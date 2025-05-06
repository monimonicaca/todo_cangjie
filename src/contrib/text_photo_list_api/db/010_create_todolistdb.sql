CREATE DATABASE todoListDb;

USE todoListDb;

CREATE TABLE  todoItem (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    todoItemId BIGINT NULL DEFAULT NULL,
    title TEXT  NULL,     
    content TEXT NOT NULL,                  
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    userIdentityGuid VARCHAR(255) NOT NULL,
    isCompleted TINYINT(1) NOT NULL DEFAULT 0,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    image_url VARCHAR(1024),
    INDEX idx_itemId (todoItemId),
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;