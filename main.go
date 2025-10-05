package main

import (
	"fmt"
	"golang_basic_task3/modle"
)

func main() {

	// curd
	students := modle.Students{}
	students.Insert()
	studentlist := students.Query()
	for key, value := range studentlist {
		fmt.Println(key, value)
	}
	students.Update()
	students.Delete()
	modle.TransferMoney()

	// sqlx
	modle.Query1()
	modle.Query2()

	// 进阶gorm
	modle.QueryP1()
	modle.TestP2()
	modle.TestP3()

}
