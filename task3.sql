/*
 Navicat Premium Data Transfer

 Source Server         : 本地MYSQL8.0
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3307
 Source Schema         : task3

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 05/10/2025 12:03:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (1, 0);
INSERT INTO `accounts` VALUES (2, 300);

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `author` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `price` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES ('1', '人世间', 'zsw', 123);
INSERT INTO `books` VALUES ('2', '平凡的世界', 'zsw', 20);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `post_id` bigint UNSIGNED NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_comments_deleted_at`(`deleted_at` ASC) USING BTREE,
  INDEX `fk_posts_comments`(`post_id` ASC) USING BTREE,
  CONSTRAINT `fk_posts_comments` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, NULL, NULL, NULL, 1, '评论1');
INSERT INTO `comments` VALUES (2, NULL, NULL, NULL, 1, '评论2');
INSERT INTO `comments` VALUES (3, NULL, NULL, NULL, 1, '评论3');
INSERT INTO `comments` VALUES (4, NULL, NULL, '2025-10-05 11:59:29.414', 4, '评论4');

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `department` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `salary` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES ('1', 'zhangjie', '技术部', 1000);
INSERT INTO `employees` VALUES ('2', 'zhangjie1', '技术部', 2000);
INSERT INTO `employees` VALUES ('3', 'zhangjie3', '人事部', 3000);

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `comment_count` bigint NULL DEFAULT NULL,
  `comment_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_posts_deleted_at`(`deleted_at` ASC) USING BTREE,
  INDEX `fk_users_posts`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_users_posts` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (1, NULL, NULL, NULL, '标题1', '标题1标题1标题1标题1标题1标题1标题1', 1, NULL, NULL);
INSERT INTO `posts` VALUES (2, NULL, NULL, NULL, '标题2', '标题2标题2标题2标题2标题2', 1, NULL, NULL);
INSERT INTO `posts` VALUES (3, NULL, NULL, NULL, '标题3', '标题3标题3标题3标题3标题3', 1, NULL, NULL);
INSERT INTO `posts` VALUES (4, NULL, NULL, NULL, '标题4', '标题4标题4标题4标题4标题4', 2, NULL, '无评论');
INSERT INTO `posts` VALUES (5, '2025-10-05 11:46:57.709', '2025-10-05 11:46:57.709', NULL, '这个是标题', '这个是内容', 1, 0, '');
INSERT INTO `posts` VALUES (6, '2025-10-05 11:48:01.613', '2025-10-05 11:48:01.613', NULL, '这个是标题', '这个是内容', 1, 0, '');
INSERT INTO `posts` VALUES (7, '2025-10-05 11:48:44.853', '2025-10-05 11:48:44.853', NULL, '这个是标题', '这个是内容', 1, 0, '');
INSERT INTO `posts` VALUES (8, '2025-10-05 11:49:33.054', '2025-10-05 11:49:33.054', NULL, '这个是标题', '这个是内容', 1, 0, '');
INSERT INTO `posts` VALUES (9, '2025-10-05 11:50:40.639', '2025-10-05 11:50:40.639', NULL, '这个是标题', '这个是内容', 1, 0, '');
INSERT INTO `posts` VALUES (10, '2025-10-05 11:50:50.987', '2025-10-05 11:50:50.987', NULL, '这个是标题', '这个是内容', 1, 0, '');

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `grade` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `age` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO `students` VALUES (1, '张三', '四年级', 20);
INSERT INTO `students` VALUES (2, 'zhangjie', '三年级', 20);
INSERT INTO `students` VALUES (3, 'xiena', '三年级', 20);
INSERT INTO `students` VALUES (4, 'zsw', '二年级', 15);

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_account_id` bigint NULL DEFAULT NULL,
  `to_account_id` bigint NULL DEFAULT NULL,
  `amount` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO `transactions` VALUES (1, 1, 2, 100);
INSERT INTO `transactions` VALUES (2, 1, 2, 100);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `user_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `gender` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `age` bigint NULL DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `post_count` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_users_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '2025-10-05 11:08:05.000', NULL, NULL, '张杰', '12345678@qq.com', '男', 23, '的点点滴滴', 2);
INSERT INTO `users` VALUES (2, '2025-10-05 11:08:05.000', NULL, NULL, '谢娜', '12345678@qq.com', '女', 18, '火火恍恍惚惚', NULL);

SET FOREIGN_KEY_CHECKS = 1;
