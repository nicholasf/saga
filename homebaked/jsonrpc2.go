// see https://pkg.go.dev/github.com/sourcegraph/jsonrpc2

package main

import (
	"encoding/json"

	"github.com/sourcegraph/jsonrpc2"
)

type MCPServer interface {
	Call(r jsonrpc2.Request) (jsonrpc2.Response, error)
}

type server struct{}

func NewMCPServer() MCPServer {
	return server{}
}

func (s server) Call(r jsonrpc2.Request) (jsonrpc2.Response, error) {
	switch r.Method {
	default:
		m := json.RawMessage(`{"hello"}`)
		response := jsonrpc2.Response{
			ID:     jsonrpc2.ID{Num: 1},
			Result: &m,
			Error:  nil,
		}
		return response, nil
	}
}

/*
errorResponse := jsonrpc2.Response{
    Version: "2.0",
    ID:      jsonrpc2.ID{Num: 1},
    Result:  nil,
    Error: &jsonrpc2.Error{
        Code:    -32602,
        Message: "Invalid params",
        Data:    "The provided parameters are not valid",
    },
}
*/
