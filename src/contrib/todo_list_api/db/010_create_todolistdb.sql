CREATE DATABASE todoListDb;

USE todoListDb;

CREATE TABLE  todoItem (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    todoItemId BIGINT NULL DEFAULT NULL,
    title TEXT  NULL,     
    content TEXT NOT NULL,                  
    userIdentityGuid VARCHAR(255) NOT NULL,
    completedTime VARCHAR(255),
    createdTime VARCHAR(255),
    isCompleted TINYINT(1) NOT NULL DEFAULT 0,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_itemId (todoItemId),
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;