// Copyright 2025 The Go MCP SDK Authors. All rights reserved.
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

package main

import (
	"context"
	"flag"
	"log/slog"
	"os"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

var httpAddr = flag.String("http", ":8080", "use SSE HTTP at this address")

var messages = make(map[string]string)

type Key struct {
	Key string
}

type KeyValue struct {
	Key   string
	Value string
}

func RecordKeyValuePair(ctx context.Context, ss *mcp.ServerSession, params *mcp.CallToolParamsFor[KeyValue]) (*mcp.CallToolResultFor[string], error) {
	var res mcp.CallToolResultFor[string]

	k := params.Arguments.Key
	v := params.Arguments.Value

	messages[k] = v
	slog.Info("Storing", k, v)

	res.StructuredContent = "ok"
	return &res, nil
}

func GetValue(ctx context.Context, ss *mcp.ServerSession, params *mcp.CallToolParamsFor[Key]) (*mcp.CallToolResultFor[string], error) {
	var res mcp.CallToolResultFor[string]
	k := params.Arguments.Key

	slog.Info("Returning", k, k, "value", messages[k])
	res.StructuredContent = messages[k]
	return &res, nil
}

func main() {
	impl := mcp.Implementation{
		"keyValueStore",
		"Key Value store",
		"1.0",
	}

	server := mcp.NewServer(&impl, nil)

	mcp.AddTool(server, &mcp.Tool{
		Name:        "set_value_with_key",
		Description: "Stores a value under the key",
	}, RecordKeyValuePair)

	mcp.AddTool(server, &mcp.Tool{
		Name:        "get_value_with_key",
		Description: "Retrieves the value",
	}, GetValue)

	t := mcp.NewLoggingTransport(mcp.NewStdioTransport(), os.Stderr)
	if err := server.Run(context.Background(), t); err != nil {
		slog.Error("Server failed: %v", err)
	}
}
