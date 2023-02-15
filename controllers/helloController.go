package controllers

import (
	"HelloHarness/releases"
	"fmt"
	"github.com/ipfs/go-bitfield"
	"github.com/TwiN/go-color"
	"github.com/gofiber/fiber/v2"
)

var keyword = "hello-1234-7"

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

func PrintBitfield(c *fiber.Ctx) error {
	bf := bitfield.NewBitfield(10)

	// Set bits 1, 3, 5, and 7
	bf.SetBit(1)
	bf.SetBit(3)
	bf.SetBit(5)
	bf.SetBit(7)

	// Print the bitfield as a string
	// fmt.Println(bf)

	// Check if bit 5 is set
	if bf.Bit(5) {
		fmt.Println("Bit 5 is set")
	} else {
		fmt.Println("Bit 5 is not set")
	}
	return nil
}
