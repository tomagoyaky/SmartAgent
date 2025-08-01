# SmartAgent自动提交脚本
# 自动提交子模块并更新主仓库

param(
    [Parameter()]
    [string]$Message = "Auto commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Write-Host "=== SmartAgent自动提交脚本 ===" -ForegroundColor Green
Write-Host "提交信息: $Message" -ForegroundColor Yellow
Write-Host ""

# 检查是否在正确的目录
if (!(Test-Path ".gitmodules")) {
    Write-Host "错误: 当前目录不是SmartAgent主仓库根目录" -ForegroundColor Red
    exit 1
}

# 函数：检查Git状态并提交
function Submit-Repository {
    param(
        [string]$Path,
        [string]$Name,
        [string]$CommitMessage
    )
    
    Write-Host "=== 处理 $Name ===" -ForegroundColor Cyan
    
    if (Test-Path $Path) {
        Push-Location $Path
        
        # 检查是否有变更
        $status = git status --porcelain
        if ($status) {
            Write-Host "发现变更，正在提交..." -ForegroundColor Yellow
            
            # 添加所有变更
            git add .
            
            # 提交变更
            git commit -m $CommitMessage
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✓ 本地提交成功" -ForegroundColor Green
                
                # 推送到远程
                git push
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "✓ 远程推送成功" -ForegroundColor Green
                } else {
                    Write-Host "✗ 远程推送失败" -ForegroundColor Red
                    Pop-Location
                    return $false
                }
            } else {
                Write-Host "✗ 本地提交失败" -ForegroundColor Red
                Pop-Location
                return $false
            }
        } else {
            Write-Host "没有变更需要提交" -ForegroundColor Gray
        }
        
        Pop-Location
        return $true
    } else {
        Write-Host "警告: 路径 $Path 不存在" -ForegroundColor Yellow
        return $true
    }
}

try {
    # 1. 提交agent-backend子模块
    $backendSuccess = Submit-Repository -Path "agent-backend" -Name "Agent Backend" -CommitMessage "feat: $Message"
    
    # 2. 提交agent-frontend子模块
    $frontendSuccess = Submit-Repository -Path "agent-frontend" -Name "Agent Frontend" -CommitMessage "feat: $Message"
    
    # 3. 更新子模块引用并提交主仓库
    if ($backendSuccess -and $frontendSuccess) {
        Write-Host "=== 处理主仓库 SmartAgent ===" -ForegroundColor Cyan
        
        # 更新子模块引用到最新提交
        Write-Host "更新子模块引用..." -ForegroundColor Yellow
        git submodule update --remote
        
        # 检查主仓库是否有变更
        $mainStatus = git status --porcelain
        if ($mainStatus) {
            Write-Host "发现主仓库变更，正在提交..." -ForegroundColor Yellow
            
            # 添加所有变更（包括子模块引用更新）
            git add .
            
            # 提交主仓库
            git commit -m "chore: $Message - 更新子模块引用"
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✓ 主仓库本地提交成功" -ForegroundColor Green
                
                # 推送主仓库
                git push
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "✓ 主仓库远程推送成功" -ForegroundColor Green
                } else {
                    Write-Host "✗ 主仓库远程推送失败" -ForegroundColor Red
                    exit 1
                }
            } else {
                Write-Host "✗ 主仓库本地提交失败" -ForegroundColor Red
                exit 1
            }
        } else {
            Write-Host "主仓库没有变更需要提交" -ForegroundColor Gray
        }
        
        Write-Host ""
        Write-Host "=== 所有提交完成！ ===" -ForegroundColor Green
        Write-Host "✓ Agent Backend 已提交" -ForegroundColor Green
        Write-Host "✓ Agent Frontend 已提交" -ForegroundColor Green
        Write-Host "✓ SmartAgent 主仓库已更新" -ForegroundColor Green
        
    } else {
        Write-Host ""
        Write-Host "=== 子模块提交失败，终止操作 ===" -ForegroundColor Red
        exit 1
    }
    
} catch {
    Write-Host "执行过程中发生错误: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "使用说明:" -ForegroundColor Cyan
Write-Host "  ./submit.ps1                    # 使用默认提交消息"
Write-Host "  ./submit.ps1 '修复登录bug'       # 使用自定义提交消息"
Write-Host ""
