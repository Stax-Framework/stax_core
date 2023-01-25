CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `role` VARCHAR(32) NOT NULL,
  `description` VARCHAR(32) NOT NULL,
  INDEX (`role`),
  FOREIGN KEY (`role`) REFERENCES roles(`key`) ON DELETE CASCADE ON UPDATE CASCADE
);