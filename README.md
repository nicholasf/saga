This project is mostly for experimenting with an MCP integration with Claude, the final goal being a RAG like application modelling DnD campaigns that allows Claude to read and write campaign information into a flat file and/or SQL format.


## PoC

Verify that you can write a tool that lets the LLM set state in memory.



## Model

Campaign





Error activating extension: Failed to add extension configuration, error: Initialization(Stdio { name: "mcpmemorystore", cmd: "/usr/lib/Goose/resources/bin/npx", args: ["-y", "@modelcontextprotocol/server-memory"], envs: Envs { map: {} }, env_keys: ["MEMORY_FILE_PATH"], timeout: Some(300), description: None, bundled: None }, McpServerError { method: "initialize", server: "", source: ServerBoxError(StdioProcessError("fatal:hermit: open /home/nicholasf/.config/goose/mcp-hermit/bin/hermit: text file busy\n")) })