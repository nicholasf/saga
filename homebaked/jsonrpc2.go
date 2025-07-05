// see https://pkg.go.dev/github.com/sourcegraph/jsonrpc2

package main

import (
	"context"
	"log"

	"github.com/sourcegraph/jsonrpc2"
)

type MCPServer interface {
	Handle(ctx context.Context, c *jsonrpc2.Conn, r *jsonrpc2.Request)
}

type server struct{}

func NewMCPServer() MCPServer {
	return &server{}
}

// Handle implements the jsonrpc2.Handler interface.
func (s *server) Handle(ctx context.Context, c *jsonrpc2.Conn, r *jsonrpc2.Request) {
	switch r.Method {
	case "sayHello":
		if err := c.Reply(ctx, r.ID, "hello world"); err != nil {
			log.Println(err)
			return
		}
	default:
		err := &jsonrpc2.Error{Code: jsonrpc2.CodeMethodNotFound, Message: "Method not found"}
		if err := c.ReplyWithError(ctx, r.ID, err); err != nil {
			log.Println(err)
			return
		}
	}
}
