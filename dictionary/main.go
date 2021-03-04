package main

import (
	"dictionary/mydict"
	"fmt"
)

func main() {
	dictionary := mydict.Dictionary{}
	baseword := "hello"
	dictionary.Add(baseword, "First")
	word, _ := dictionary.Search(baseword)
	del := dictionary.Delete(baseword)

	fmt.Println(del)

	word, err := dictionary.Search(baseword)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(word)
}
