package cmd

import (
	"log"
	"os"
	"time"

	"gopkg.in/telebot.v3"
	"github.com/spf13/cobra"
)

var serveCmd = &cobra.Command{
	Use:   "serve",
	Short: "Запуск Telegram-бота",
	Run: func(cmd *cobra.Command, args []string) {
		token := os.Getenv("TELE_TOKEN")
		if token == "" {
			log.Fatal("TELE_TOKEN не встановлено у середовищі!")
		}

		pref := telebot.Settings{
			Token:  token,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		}

		bot, err := telebot.NewBot(pref)
		if err != nil {
			log.Fatal(err)
		}

		bot.Handle(telebot.OnText, func(c telebot.Context) error {
			return c.Send("Вітаю! 👋 Ви написали: " + c.Text())
		})

		log.Println("Бот запущений...")
		bot.Start()
	},
}

func init() {
	rootCmd.AddCommand(serveCmd)
}
