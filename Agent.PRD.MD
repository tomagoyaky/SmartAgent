AI-Agent项目
- 为了处理聊天机器人无法“凭记忆”回答的问题，请集成一个网页搜索工具Tavily 搜索引擎

# 功能
- 基于glm-4.5-flash 大模型服务，参考https://docs.bigmodel.cn/api-reference/%E6%A8%A1%E5%9E%8B-api/%E5%AF%B9%E8%AF%9D%E8%A1%A5%E5%85%A8
- 使用 LangGraph 创建一个基本的聊天机器人。该机器人可以通过接收用户输入并使用 LLM 生成响应来进行基本对话。
- 处理聊天机器人无法“凭记忆”回答的问题，请集成一个Tavily 搜索引擎
- 添加记忆(本地持久化)，让它记住之前交互的上下文,达到连贯、多轮对话的能力。
- 如果需要人工输入才能成功完成任务。同样，对于某些操作，您可能需要在运行前获得人工批准，以确保一切按预期运行。

## 插件系统
- 平台支持插件，llm可以通过agent来调用运行这些插件
- 前端可以展示这些插件信息
- 定义插件开发规范，提供开发平台支持开发者上传插件
- 插件需要支持热插拔

# llm 模型
- glm-4.5-flash


# 参考
- 创建基础机器人：https://docs.langchain.com/langgraph-platform/langgraph-basics/1-build-basic-chatbot
- 添加内存：https://docs.langchain.com/langgraph-platform/langgraph-basics/3-add-memory
- Tavily搜索引擎文档参考：https://python.langchain.com/docs/integrations/tools/tavily_search/
- 添加人机交互控制：https://docs.langchain.com/langgraph-platform/langgraph-basics/4-human-in-the-loop
- 添加状态：https://docs.langchain.com/langgraph-platform/langgraph-basics/5-customize-state
- glm 大模型服务开发指南：https://docs.bigmodel.cn/cn/guide/develop/http/introduction


# 依赖
```
pip install -U langgraph langsmith langchain-tavily
```

# 密钥
- Tavily 搜索引擎的 API 密钥：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
- glm-4.5-flash 大模型服务的密钥：9d4faa62184d46fab3acc23d58890dce.h0FNEM0BGXUtIIlq，请求地址是https://open.bigmodel.cn/api/paas/v4/

# 技术框架
- 使用node+vue
- 前端需要有loading状态
- glm-4.5-flash 请求时，需要支持stream和thinking
- 需要处理CORS跨域问题
- 聊天记录需要记录在本地，以数据库的形式存储。
- 消息发送失败后，需要有状态标记，用户点击标记可以进行重试