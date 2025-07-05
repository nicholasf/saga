package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	r.POST("/mcp", func(c *gin.Context) {

	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

// basic session handler, returns a session id
func initializer() string {
	return uuid.NewString()
}
