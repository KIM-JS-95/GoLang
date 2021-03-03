package main

import (
	"bankaccount/accounts"
	"fmt"
)

func main() {
	account := accounts.NewAccount("kim")
	account.Deposit(10)
	fmt.Println(account.Balance())
	err := account.Withdraw(20)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(account.Balance())
}
