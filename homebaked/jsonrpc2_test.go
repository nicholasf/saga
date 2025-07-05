package main

import (
	"encoding/json"
	"testing"

	"github.com/sourcegraph/jsonrpc2"
)

func TestCall(t *testing.T) {
	s := NewMCPServer()
	m := json.RawMessage(`{ "hello": "there"}`)
	r := jsonrpc2.Request{
		ID:     jsonrpc2.ID{Num: 1},
		Method: "test.method",
		Params: &m,
		Notif:  false,
	}

	t.Run("Testing call", func(t *testing.T) {
		res, err := s.Call(r)

	})
}
