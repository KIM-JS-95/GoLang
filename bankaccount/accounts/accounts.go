package accounts

import "errors"

type Account struct {
	owner   string
	balance int
}

func NewAccount(owner string) *Account {
	account := Account{owner: owner, balance: 0}

	return &account
}

// Diposit * amount on your account
func (a *Account) Deposit(amount int) {
	a.balance += amount
}

var errNoMoney = errors.New("Can't Withdraw")

func (a Account) Balance() int {
	return a.balance
}

func (a *Account) Withdraw(amount int) error {
	if a.balance < amount {
		return errNoMoney
	}
	a.balance -= amount
	return nil
}
