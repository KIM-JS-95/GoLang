package main

import (
"fmt"
)

func repeatMe(words ...string)  {
fmt.Println(words)
}

func main(){
	repeatMe("a","d","c","d")
}