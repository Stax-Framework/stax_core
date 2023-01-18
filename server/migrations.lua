local queries = {
  {
    table = {
      query = [[
        CREATE TABLE IF NOT EXISTS `users` (
          `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
          `name` VARCHAR(24) NOT NULL,
          `role` INT NOT NULL DEFAULT 0,
          `whitelisted` TINYINT NOT NULL DEFAULT 0,
          `priority` TINYINT NOT NULL DEFAULT 0,
          `identifier` VARCHAR(100) NOT NULL,
          `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          `last_played_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
      ]]
    }
  },
  {
    table = {
      query = [[
        CREATE TABLE IF NOT EXISTS `user_bans` (
          `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
          `reason` TEXT DEFAULT NULL,
          `permaban` TINYINT DEFAULT 0,
          `admin_id` INT NOT NULL,
          `user_id` INT NOT NULL,
          FOREIGN KEY (`admin_id`) REFERENCES users(`id`) ON DELETE RESTRICT,
          FOREIGN KEY (`user_id`) REFERENCES users(`id`) ON DELETE CASCADE
        )
      ]]
    }
  },
  {
    table = {
      query = [[
        CREATE TABLE IF NOT EXISTS `user_kicks` (
          `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
          `reason` TEXT DEFAULT NULL,
          `admin_id` INT NOT NULL,
          `user_id` INT NOT NULL,
          FOREIGN KEY (`admin_id`) REFERENCES users(`id`) ON DELETE RESTRICT,
          FOREIGN KEY (`user_id`) REFERENCES users(`id`) ON DELETE CASCADE
        );
      ]]
    }
  },
  {
    table = {
      query = [[
        CREATE TABLE IF NOT EXISTS `user_warns` (
          `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
          `reason` TEXT DEFAULT NULL,
          `admin_id` INT NOT NULL,
          `user_id` INT NOT NULL,
          FOREIGN KEY (`admin_id`) REFERENCES users(`id`) ON DELETE RESTRICT,
          FOREIGN KEY (`user_id`) REFERENCES users(`id`) ON DELETE CASCADE
        );
      ]]
    }
  }
}

AddEventHandler("DZ::Server::Core::CreateDatabaseTables", function(resource --[[ string ]], callback --[[ function ]])
  if resource ~= GetCurrentResourceName() then return end
  callback(queries)
end)