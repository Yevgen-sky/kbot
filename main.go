package main

import (
    "time"

    "github.com/Yevgen-sky/kbot/cmd"
)

func main() {
    cmd.Execute()

    // держим процесс живым, но без дедлока
    for {
        time.Sleep(10 * time.Minute)
    }
}
