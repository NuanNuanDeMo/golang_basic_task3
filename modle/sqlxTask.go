package modle

import (
	"fmt"
	"log"

	"github.com/jmoiron/sqlx"
)

type Employees struct {
	Id         string `db:"id"`
	Name       string `db:"name"`
	Department string `db:"department"`
	Salary     int    `db:"salary"`
}

type Books struct {
	Id     string `db:"id"`
	Title  string `db:"title"`
	Author string `db:"author"`
	Price  int    `db:"price"`
}

var dbSqlx *sqlx.DB

// 初始化连接
func init() {
	dsn := "root:123456@tcp(127.0.0.1:3307)/task3?charset=utf8mb4&parseTime=True"
	var err error
	// 建立连接
	dbSqlx, err = sqlx.Connect("mysql", dsn)
	if err != nil {
		log.Fatalf("连接失败: %v", err)
	}

	dbSqlx.SetMaxOpenConns(10)
	dbSqlx.SetMaxIdleConns(5)
	fmt.Println("数据库连接成功")
}

func Query1() {
	defer dbSqlx.Close()
	// 1. 编写Go代码，使用Sqlx查询 employees 表中所有部门为 "技术部" 的员工信息，并将结果映射到一个自定义的 Employee 结构体切片中。
	var employees []Employees
	err := dbSqlx.Select(&employees, "select id,name,department,salary from employees where department=?", "技术部")
	if err != nil {
		return
	}
	fmt.Println("查询数据employees:", employees)

	// 2.编写Go代码，使用Sqlx查询 employees 表中工资最高的员工信息，并将结果映射到一个 Employee 结构体中。
	var employee Employees
	err = dbSqlx.Get(&employee, "select id,name,department,salary from employees where salary = (select max(salary) from employees)")
	if err != nil {
		return
	}
	fmt.Println("查询数据employee:", employee)
}

// 编写Go代码，使用Sqlx执行一个复杂的查询，例如查询价格大于 50 元的书籍，并将结果映射到 Book 结构体切片中，确保类型安全。
func Query2() {
	defer dbSqlx.Close()
	var books []Books
	err := dbSqlx.Select(&books, "select id,title,author,price from books where price> ? ORDER BY price DESC", 50)
	if err != nil {
		return
	}
	for _, book := range books {
		if book.Price < 0 {
			_ = fmt.Errorf("价格维护不正确: %v", book.Price)
		}
	}
	fmt.Println("查询的数据:", books)
}
