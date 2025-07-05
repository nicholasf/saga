package main

import (
	"context"
	"log/slog"
	"net"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/sourcegraph/jsonrpc2"
)

func main() {
	ctx := context.Background()
	r := gin.Default()
	connA, connB := net.Pipe()

	sender := jsonrpc2.NewConn(ctx, jsonrpc2.NewPlainObjectStream(connA), nil)
	defer sender.Close()

	s := NewMCPServer()
	receiver := jsonrpc2.NewConn(ctx, jsonrpc2.NewPlainObjectStream(connB), s)
	defer receiver.Close()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	r.POST("/mcp/*jsonRPCRequest", func(c *gin.Context) {
		data := c.Param("jsonRPCRequest")

		var result string
		if err := sender.Call(ctx, data, nil, &result); err != nil {
			slog.Info("Result: ", result, result)
			c.Error(err)
		}

		c.JSON(200, result)
	})

	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

// basic session handler, returns a session id
func initializer() string {
	return uuid.NewString()
}
