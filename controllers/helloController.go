package controllers

import (
	"HelloHarness/releases"
	"fmt"
	"github.com/TwiN/go-color"
	"github.com/gofiber/fiber/v2"
)

var keyword = "hello-123"

func SayHello(c *fiber.Ctx) error {
	str := fmt.Sprintf("Hello from 'HELLO HARNESS API Service with keyword : [%s]'...", keyword)
	println(color.Ize(color.Yellow, str))
	return c.JSON(str)
}

func PrintReleaseInfo(c *fiber.Ctx) error {
	str := fmt.Sprintf("Hello Harness version %s (Build:%s)...", releases.VersionNumber, releases.BuildTime)
	println(color.Ize(color.Yellow, str))
	// jstr := fmt.Sprintf("value: '%s'", str)
	return c.JSON(str)
}
