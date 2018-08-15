package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()

	if err != nil {
		log.Fatal("Failed to load env file...")
	}

	router := gin.Default()
	servicePort := os.Getenv("SERVICE_PORT")

	router.GET("/healthcheck", func(c *gin.Context) {
		c.String(200, "ok")
	})

	router.Run(":" + servicePort)
}
