package main

import (
	"fmt"
	"time"
)

func main() {
	c := make(chan string) //채널 생성

	people := [2]string{"a", "b"}
	for _, person := range people {
		go isSexy(person, c)
	}

	fmt.Println("Waiting for message ")

	for i := 0; i < len(people); i++ {
		fmt.Println("Received this message ", <-c)
	}

}

func isSexy(person string, c chan string) {
	time.Sleep(time.Second * 10)
	c <- person + " is sexy"
}
