-- mysql -u foo_user -p -h localhost
SET FOREIGN_KEY_CHECKS = 0;
use foo_db;
TRUNCATE TABLE foo;
INSERT INTO `foo` (`foo_id`, `value1`, `value2`)
VALUES
  (1, 'bar', NULL);
