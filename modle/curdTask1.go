package modle

type Students struct {
	Id          int
	Name, Grade string
	Age         int
}

func init() {
	//DB.AutoMigrate(&Students{})
}

// 编写SQL语句向 students 表中插入一条新记录，学生姓名为 "张三"，年龄为 20，年级为 "三年级"。
func (s Students) Insert() {
	student := Students{Name: "张三", Age: 20, Grade: "三年级"}
	DB.Create(&student)
}

// 编写SQL语句查询 students 表中所有年龄大于 18 岁的学生信息。
func (s Students) Query() []Students {
	var studentList []Students
	DB.Where("age > ?", 18).Find(&studentList)
	return studentList
}

// 编写SQL语句将 students 表中姓名为 "张三" 的学生年级更新为 "四年级"。
func (s Students) Update() {
	DB.Model(&Students{}).Where("name = ?", "张三").Update("Grade", "四年级")
}

// 编写SQL语句删除 students 表中年龄小于 15 岁的学生记录。
func (s Students) Delete() {
	DB.Delete(&Students{}, "age < ?", 15)
}
