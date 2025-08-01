
## 项目信息
- 项目名称，要根据产品需求文档PRD.MD中的含义来命名，两个单词构成，比如为：SmartAgent（这里是示例名称）

## 项目分为前后端分离架构
- 前端使用 Vue 3 + Element Plus + Vite 构建
- 后端使用 Node.js + Express + Sqlite 构建
## 后面的步骤每一步执行完都跟我进行确认。
- 分析产品需求文档PRD.MD，然后输出ARCHITECTURE.MD，用于指导项目的整体设计和技术选型，包含：目录结构详解、组件设计模式、状态管理方案、API设计规范等
- 先以openapi规范的方式，按照产品需求文档PRD.MD的功能中的描述，生成api.json文件
- 然后将产品需求文档PRD.MD中的功能描述，对需要用到的实体类字段进行描述，生成entity.json文件
- 根据entity.json文件，生成后端实体类、生成init_scheme.sql、init_data_fake.sql、init_admin.sql，其中init_scheme.sql用于初始化数据库表结构，init_data_fake.sql用于插入测试数据, init_admin.sql用于插入管理员数据。
- 最后根据api.json文件，生成前端的API接口代码和后端的Controller层代码
- 前端代码生成后，生成README.md文件，包含项目概述、目录结构、技术栈等
- 后端代码生成后，生成README.md文件，包含项目技术架构、目录结构、重要实体类说明、API接口文档等
- 补齐前后端的vue和node.js的框架项目结构
- 项目根目录生成README.md文件，包含项目概述、目录结构、技术栈、贡献指南等

## 其他要求
- 每个类文件负责单一功能，遵循单一职责原则
- 项目要为相似的类文件，创建对应的目录结构
- 项目命名：
  - 前端：agent-frontend
  - 后端：agent-backend
- 项目结构：
```
agent-frontend/                       # 前端项目目录
├── src/                              # 前端源代码目录
│   ├── App.vue                       # Vue 根组件
│   ├── main.js                       # 前端入口文件
│   ├── assets/                       # 静态资源目录（图片、样式等）
│   ├── components/                   # 通用组件目录
│   ├── services/                     # API 服务封装目录
│   ├── stores/                       # 状态管理目录（如Pinia/Vuex）
│   ├── utils/                        # 工具函数目录
│   ├── views/                        # 页面视图目录
│   └── config/                       # 配置文件目录
├── package.json                      # 前端依赖及脚本配置
├── vite.config.js                    # Vite 配置文件
├── .env                              # 环境变量配置
├── .env.example                      # 环境变量示例文件
├── index.html                        # 前端入口 HTML 文件
└── README.md                         # 前端说明文档

agent-backend/                        # 后端项目目录
├── src/                              # 后端源代码目录
│   ├── controllers/                  # 控制器目录，处理路由请求
│   ├── middlewares/                  # 中间件目录
│   ├── models/                       # 数据模型目录
│   ├── routes/                       # 路由定义目录
│   ├── services/                     # 业务逻辑服务目录
│   └── utils/                        # 工具函数目录
├── package.json                      # 后端依赖及脚本配置
├── .env                              # 环境变量配置
├── .env.example                      # 环境变量示例文件
└── server.js                         # 后端入口文件

workspace/                            # 工作区目录
└── logs/                             # 日志文件目录
└── tests/                            # 测试用例目录
└── temp/                             # 临时文件目录

scripts/                              # 自动化脚本目录（部署、构建、迁移等）
└── start.sh                          # Linux/macOS 启动脚本
└── start.bat                         # Windows 启动脚本
└── deploy.docker.bat                 # Docker 部署脚本（Windows）
└── deploy.dev.bat                    # 开发环境部署脚本（Windows）
└── deploy.docker.bat                 # Docker 部署脚本（Windows，重复）
└── deploy.dev.bat                    # 开发环境部署脚本（Windows，重复）

docs/                                 # 项目文档目录（接口、设计等）
README.md                             # 项目根目录说明文档
```