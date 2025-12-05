package main

import (
    "time"

    "github.com/Yevgen-sky/kbot/cmd"
)

func main() {
    cmd.Execute()

    for {
        time.Sleep(10 * time.Minute)
    }
}
