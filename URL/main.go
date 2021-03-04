package main

import (
	"errors"
	"fmt"
	"net/http"
)

var errRequstFailed = errors.New("err")

func main() {
	var results = make(map[string]string)
	urls := []string{
		"https://www.naver.com",
		"https://www.jajaja.com",
	}

	for _, url := range urls {
		result := "OK"
		err := hitURL(url)
		if err != nil {
			result = "FAILED"
		}
		results[url] = result
	}

	for url, result := range results {
		fmt.Println(url, result)
	}

}

func hitURL(url string) error {
	fmt.Println("Checking", url)
	resp, err := http.Get(url)

	if err != nil || resp.StatusCode >= 400 {
		fmt.Println(err, resp.StatusCode)
		return errRequstFailed
	}
	return nil
}
