This project is mostly for experimenting with an MCP integration with Claude, the final goal being a RAG like application modelling DnD campaigns that allows Claude to read and write campaign information into a flat file and/or SQL format.


## PoC

Verify that you can write a tool that lets the LLM set state in memory.


The Saga data model is designed to be lightweight, to let you begin to plan content for your campaign alongside an LLM without overdefining things. Often you won't understand the full picture of what you want.


## Model

Campaign





Error activating extension: Failed to add extension configuration, error: Initialization(Stdio { name: "mcpmemorystore", cmd: "/usr/lib/Goose/resources/bin/npx", args: ["-y", "@modelcontextprotocol/server-memory"], envs: Envs { map: {} }, env_keys: ["MEMORY_FILE_PATH"], timeout: Some(300), description: None, bundled: None }, McpServerError { method: "initialize", server: "", source: ServerBoxError(StdioProcessError("fatal:hermit: open /home/nicholasf/.config/goose/mcp-hermit/bin/hermit: text file busy\n")) })



---


Campaigns will be composed of parts, parts will be composed of sessions. 

<!-- A DM will use this tool to create a SessionPlan. This is the plan of what will happen in a session. It will have a list of events, encounters, etc..

After a session has run the DM will create a SessionSummary, which will be a list of points of things that happened in the session.

This tool is not concerned to work with combat mechanics or statistics. It is concerned to create campaign content. -->



Implement a db connection using node pg in the src/pg.ts file. A function should be exposed which takes port, user, password and server address data, it will connect to a database and return a connection.