package routes

import (
	"HelloHarness/controllers"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/monitor"
	"github.com/gofiber/fiber/v2"
)

func Setup(app *fiber.App) {
	app.Get("/dashboard", monitor.New())
	api := app.Group("/api", logger.New())

	api.Get("/hello", controllers.SayHello)
	api.Get("/version", controllers.PrintReleaseInfo)
}
