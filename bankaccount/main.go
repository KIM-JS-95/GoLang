package main

import (
	"bankaccount/accounts"
	"fmt"
)

func main() {
	account := accounts.NewAccount("kim")
	fmt.Println(account)
}
