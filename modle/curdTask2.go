package modle

import "fmt"

type Accounts struct {
	Id      int
	Balance int
}

type Transactions struct {
	Id            int
	FromAccountId int `db:"from_account_id"`
	ToAccountId   int `db:"to_account_id"`
	Amount        int
}

func Test() {
	//DB.AutoMigrate(&Accounts{})
	//DB.AutoMigrate(&Transactions{})
	//DB.AutoMigrate(&Employees{})
	//DB.AutoMigrate(&Books{})
}

func TransferMoney() {
	tx := DB.Begin()
	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
		}
	}()
	if err := tx.Error; err != nil {
		fmt.Println(err)
	}

	// 查询A账户
	ua := &Accounts{Id: 1}
	tx.First(&ua)
	ua.Balance = ua.Balance - 100
	if ua.Balance < 0 {
		tx.Rollback()
	}
	if err := tx.Save(&ua).Error; err != nil {
		tx.Rollback()
	}

	// 查询B账户
	ub := &Accounts{Id: 2}
	tx.First(&ub)
	ub.Balance = ub.Balance + 100

	// panic("失败")
	if err := tx.Save(&ub).Error; err != nil {
		tx.Rollback()
	}

	// 保存记录
	t := &Transactions{FromAccountId: 1, ToAccountId: 2, Amount: 100}
	tx.Save(t)

	tx.Commit()
}
