package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	r := gin.Default()
	r.GET("/", func(context *gin.Context) {
		context.String(http.StatusOK, "welcome to use gin")
		return
	})
	err := r.Run("0.0.0.0:8080")
	if err != nil {
		panic(err.Error())
	}
}
