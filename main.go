package main

import (
	"fmt"
	"github.com/gofiber/fiber/v2"
	"log"
	"os"
	"github.com/TwiN/go-color"

	"HelloHarness/releases"
	"HelloHarness/routes"
	"github.com/joho/godotenv"
)

func main() {

	// Load the settings from the appropriate .env file (either .env.prod or .env.dev)
	env := os.Getenv("HELLO_HARNESS_ENV")
	if env == "" {
		env = "dev"
	}

	if err := godotenv.Load(".env." + env); err != nil {
		log.Fatal(err)
	}

	str := fmt.Sprintf("Hello Harness version %s (Build:%s)...", releases.VersionNumber, releases.BuildTime)
	println(color.Ize(color.Yellow, str))
	str = fmt.Sprintf("Starting up on port [%s]...", os.Getenv("PORT"))
	println(color.Ize(color.Yellow, str))

	app := fiber.New()

	routes.Setup(app)

	hostAndPort := ":" + os.Getenv("PORT")

	app.Listen(hostAndPort)
}
