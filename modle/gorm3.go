package modle

import (
	"fmt"

	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	UserName  string
	Email     string
	Gender    string
	Age       int
	Address   string
	Posts     []Post `gorm:"foreignKey:UserId"`
	PostCount int
}

type Post struct {
	gorm.Model
	Title         string
	Content       string
	UserId        int
	Comments      []Comment `gorm:"foreignKey:PostId"`
	CommentCount  int
	CommentStatus string
}

type Comment struct {
	gorm.Model
	PostId  int
	Content string
}

func InitTable() {
	DB.AutoMigrate(&User{})
	DB.AutoMigrate(&Post{})
	DB.AutoMigrate(&Comment{})
}

func QueryP1() {
	// 编写Go代码，使用Gorm查询某个用户发布的所有文章及其对应的评论信息。
	var user User
	DB.Preload("Posts.Comments").Find(&user, 1)
	fmt.Println(user)

	// 编写Go代码，使用Gorm查询评论数量最多的文章信息。
	post := &Post{}
	DB.Raw("SELECT t1.*,count( 1 ) count FROM posts t1 JOIN comments t2 ON t1.id = t2.post_id GROUP BY t1.id LIMIT 1").Scan(&post)
	fmt.Println("评论最多:", post)
}

func TestP2() {
	// 添加文章,统计数量
	post := &Post{Title: "这个是标题", Content: "这个是内容", UserId: 1}
	DB.Create(&post)
}

func TestP3() {
	var com Comment
	DB.Where("post_id=?", 4).Find(&com)
	DB.Where("post_id=?", 4).Delete(&com)
}

// 为 Post 模型添加一个钩子函数，在文章创建时自动更新用户的文章数量统计字段。
func (p *Post) BeforeCreate(tx *gorm.DB) (err error) {
	var user User
	if err = tx.Model(&User{}).Where("id = ?", p.UserId).First(&user).Error; err != nil {
		return
	}
	user.PostCount++
	tx.Model(&user).UpdateColumn("post_count", user.PostCount)
	return
}

// 为 Comment 模型添加一个钩子函数，在评论删除时检查文章的评论数量，如果评论数量为 0，则更新文章的评论状态为 "无评论"。
func (c *Comment) AfterDelete(tx *gorm.DB) (err error) {
	var post Post
	if err := tx.Model(&Post{}).Where("id = ?", c.PostId).First(&post).Error; err != nil {
		return err
	}
	var commentCount int64
	if err := tx.Model(&Comment{}).Where("post_id = ?", c.PostId).Count(&commentCount).Error; err != nil {
		return err
	}
	fmt.Println("commentCount=", commentCount)
	if commentCount == 0 {
		post.CommentStatus = "无评论"
		tx.Model(&post).UpdateColumn("comment_status", post.CommentStatus)
	}
	return
}
