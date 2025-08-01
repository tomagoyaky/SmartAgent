
# One-click deployment script for frontend and backend (PowerShell)

# Function to kill process by port
function Kill-ProcessByPort {
    param([int]$Port)
    
    Write-Host "Checking for processes on port $Port..."
    $processes = netstat -ano | findstr ":$Port"
    
    if ($processes) {
        Write-Host "Found processes on port $Port, terminating..."
        $processes | ForEach-Object {
            $line = $_.Trim()
            if ($line -match '\s+(\d+)$') {
                $processId = $matches[1]
                try {
                    taskkill /PID $processId /F 2>$null
                    Write-Host "Terminated process PID: $processId"
                } catch {
                    Write-Host "Failed to terminate PID: $processId"
                }
            }
        }
        Start-Sleep -Seconds 2
    } else {
        Write-Host "No processes found on port $Port"
    }
}

# Function to kill PowerShell windows by title pattern
function Kill-PowerShellByTitle {
    param([string]$TitlePattern)
    
    Write-Host "Closing PowerShell windows with title pattern: $TitlePattern"
    $currentProcessId = $PID
    try {
        Get-Process powershell -ErrorAction SilentlyContinue | ForEach-Object {
            # 不要关闭当前正在运行的PowerShell窗口
            if ($_.Id -ne $currentProcessId -and $_.MainWindowTitle -like "*$TitlePattern*") {
                Write-Host "Closing PowerShell window: $($_.MainWindowTitle) (PID: $($_.Id))"
                Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
            }
        }
    } catch {
        Write-Host "Error closing PowerShell windows: $($_.Exception.Message)"
    }
}

# Function to kill Node.js processes by command line
function Kill-NodeProcesses {
    Write-Host "Closing Node.js processes related to agent..."
    try {
        Get-WmiObject Win32_Process -Filter "name='node.exe'" | ForEach-Object {
            $commandLine = $_.CommandLine
            if ($commandLine -like "*agent-backend*" -or $commandLine -like "*agent-frontend*") {
                Write-Host "Terminating Node.js process: $($_.ProcessId) - $commandLine"
                Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
            }
        }
    } catch {
        Write-Host "Error closing Node.js processes: $($_.Exception.Message)"
    }
}

# Close previous deployment windows
Write-Host "=== Cleanup Previous Deployments ==="
Write-Host "Current PowerShell PID: $PID (this window will be protected)"
Kill-PowerShellByTitle -TitlePattern "BackendService-Agent"
Kill-PowerShellByTitle -TitlePattern "FrontendService-Agent"
Kill-NodeProcesses

# 1. Clean up ports and install backend dependencies
Write-Host "=== Backend Setup ==="
Kill-ProcessByPort -Port 3000

Write-Host "Installing backend dependencies..."
cd "d:\Agent\agent-backend"
npm install

Write-Host "Starting backend service..."
Start-Process powershell -ArgumentList '-NoExit', '-Command', '$host.ui.RawUI.WindowTitle=\"BackendService-Agent\"; cd d:\Agent\agent-backend; node index.js'

# Wait a moment for backend to start
Start-Sleep -Seconds 3

# 2. Clean up ports and install frontend dependencies
Write-Host "=== Frontend Setup ==="
Kill-ProcessByPort -Port 5173
Kill-ProcessByPort -Port 5174

Write-Host "Installing frontend dependencies..."
cd "d:\Agent\agent-frontend"
npm install

Write-Host "Starting frontend service..."
Start-Process powershell -ArgumentList '-NoExit', '-Command', '$host.ui.RawUI.WindowTitle=\"FrontendService-Agent\"; cd d:\Agent\agent-frontend; npm run dev'

Write-Host "=== Deployment Complete ==="
Write-Host "Backend is running on: http://localhost:3000"
Write-Host "Frontend will be available on: http://localhost:5173 or http://localhost:5174"
Write-Host "Please wait a few seconds for services to fully start..."
