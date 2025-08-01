# SmartAgent - 智能代理系统

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![Vue.js](https://img.shields.io/badge/Vue.js-3.0+-blue.svg)](https://vuejs.org/)

SmartAgent是一个现代化的智能代理系统，提供可扩展的LLM（大语言模型）和搜索引擎集成能力。系统采用前后端分离架构，支持多种AI服务提供商和搜索引擎。

## 🚀 项目特性

### 🎯 核心功能
- **多LLM支持**: 集成GLM、OpenAI等多种大语言模型
- **多搜索引擎**: 支持Tavily、Bing等搜索服务
- **模块化架构**: 可插拔的服务架构，易于扩展
- **现代化界面**: Vue 3 + Element Plus构建的响应式前端
- **工作空间管理**: 完整的会话和数据管理系统

### 🏗️ 技术架构
- **后端**: Node.js + Express + SQLite
- **前端**: Vue 3 + Element Plus + Vite
- **数据库**: SQLite with WAL模式
- **部署**: Docker + PowerShell自动化脚本

## 📁 项目结构

```
SmartAgent/
├── agent-backend/          # 后端服务 (子模块)
│   ├── src/
│   │   ├── config/         # 配置管理
│   │   ├── database/       # 数据库管理
│   │   ├── models/         # 数据模型
│   │   ├── routes/         # API路由
│   │   └── services/       # 服务层
│   └── workspace/          # 运行时数据
├── agent-frontend/         # 前端应用 (子模块)
│   ├── src/
│   │   ├── components/     # Vue组件
│   │   ├── views/          # 页面视图
│   │   └── utils/          # 工具函数
│   └── dist/               # 构建输出
├── deploy.ps1              # 部署脚本
├── submit.ps1              # 自动提交脚本
└── README.md               # 项目文档
```

## 🛠️ 快速开始

### 环境要求
- Node.js 18.0+
- npm 或 yarn
- Git
- PowerShell (Windows) 或 Bash (Linux/Mac)

### 克隆项目（包含子模块）
```bash
git clone --recursive https://github.com/tomagoyaky/SmartAgent.git
cd SmartAgent
```

如果已经克隆了主仓库，需要初始化子模块：
```bash
git submodule init
git submodule update
```

### 后端设置
```bash
cd agent-backend
npm install
cp .env.example .env
# 编辑 .env 文件，配置API密钥
npm start
```

### 前端设置
```bash
cd agent-frontend
npm install
npm run dev
```

## 🔧 配置说明

### 环境变量配置
在 `agent-backend/.env` 文件中配置以下变量：

```properties
# GLM API配置
GLM_API_KEY=your_glm_api_key
GLM_API_URL=https://open.bigmodel.cn/api/paas/v4/

# OpenAI API配置（可选）
OPENAI_API_KEY=your_openai_api_key
OPENAI_API_URL=https://api.openai.com/v1/

# 搜索引擎配置
TAVILY_API_KEY=your_tavily_api_key
BING_API_KEY=your_bing_api_key

# 数据库配置
DATABASE_PATH=./workspace/instance/smartagent.db

# 服务器配置
PORT=3000
NODE_ENV=production
```

### 支持的服务提供商

#### LLM服务
- **GLM (智谱AI)**: 国产大语言模型，支持中文对话、代码生成等
- **OpenAI**: GPT系列模型，支持文本生成、对话等
- **自定义LLM**: 通过扩展LLMService基类添加新的模型

#### 搜索引擎
- **Tavily**: 专为AI优化的搜索API
- **Bing Search**: 微软必应搜索API
- **自定义搜索**: 通过扩展SearchService基类添加新的搜索引擎

## 🚀 部署

### 使用PowerShell脚本部署
```powershell
# 开发环境部署
./deploy.ps1 -Environment dev

# 生产环境部署
./deploy.ps1 -Environment prod

# 清理并重新部署
./deploy.ps1 -Environment prod -Clean
```

### Docker部署（规划中）
```bash
docker-compose up -d
```

## 📝 开发工作流

### 自动提交脚本
使用 `submit.ps1` 脚本可以自动提交子模块和主仓库：

```powershell
# 使用默认提交消息
./submit.ps1

# 使用自定义提交消息
./submit.ps1 "修复用户登录功能"
```

脚本会按顺序执行：
1. 提交并推送 agent-backend 子模块
2. 提交并推送 agent-frontend 子模块
3. 更新子模块引用并提交主仓库

### 开发规范
- 遵循语义化版本控制
- 使用约定式提交格式
- 保持代码风格一致
- 编写单元测试

## 🎮 API接口

### 聊天接口
```http
POST /api/chat
Content-Type: application/json

{
    "message": "你好，请介绍一下你自己",
    "threadId": "optional-thread-id",
    "llmProvider": "glm",
    "searchProvider": "tavily"
}
```

### 线程管理
```http
GET /api/threads          # 获取线程列表
POST /api/threads         # 创建新线程
GET /api/threads/:id      # 获取线程详情
DELETE /api/threads/:id   # 删除线程
```

### 设置管理
```http
GET /api/settings         # 获取系统设置
PUT /api/settings         # 更新系统设置
```

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

### 子模块开发
- 后端开发: 在 `agent-backend` 子模块中进行
- 前端开发: 在 `agent-frontend` 子模块中进行
- 使用 `submit.ps1` 脚本统一提交所有更改

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 🙏 致谢

- [Vue.js](https://vuejs.org/) - 渐进式JavaScript框架
- [Element Plus](https://element-plus.org/) - Vue 3 UI库
- [Express.js](https://expressjs.com/) - Node.js Web框架
- [SQLite](https://www.sqlite.org/) - 轻量级数据库

## 📞 联系方式

- 项目地址: [https://github.com/tomagoyaky/SmartAgent](https://github.com/tomagoyaky/SmartAgent)
- 问题反馈: [Issues](https://github.com/tomagoyaky/SmartAgent/issues)

---

**SmartAgent** - 让AI更智能，让开发更简单 🚀
