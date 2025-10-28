package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "kbot",
	Short: "kbot — це простий Telegram бот на Golang",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Вітаю! Це твій перший Telegram бот 🚀")
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
