-- Main table for photos
CREATE TABLE photos (
    id BIGINT PRIMARY KEY,
    url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to generate id before inserting a new photo
CREATE TRIGGER photos_before_insert
BEFORE INSERT ON photos
FOR EACH ROW
SET NEW.id = IFNULL(NEW.id, insta_distributed_id());

-- Separate table for sequence numbers
CREATE TABLE IF NOT EXISTS id_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY
) AUTO_INCREMENT = 1;

-- Function to generate distributed id
CREATE FUNCTION insta_distributed_id()
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE epoch_ms BIGINT;
    DECLARE seq INT;
    DECLARE shard_id INT DEFAULT 1;   -- change per node
    DECLARE custom_epoch BIGINT DEFAULT 1704067200000; -- 2024-01-01

    -- current time in ms
    SET epoch_ms = UNIX_TIMESTAMP(NOW(3)) * 1000;

    -- sequence (10 bits)
    INSERT INTO id_sequence VALUES (NULL);
    SET seq = LAST_INSERT_ID() & 1023;

    -- build 64-bit id
    RETURN ((epoch_ms - custom_epoch) << 23)   -- 41 bits
           | (shard_id << 10)                  -- 13 bits
           | seq;                              -- 10 bits
END;



-- Insert a new photo
INSERT INTO photos (url) VALUES ('img1.jpg');

-- Select all photos
SELECT * FROM photos;