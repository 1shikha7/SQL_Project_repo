USE MusicStore
CREATE TABLE media_type (
    media_type_id INT,
    name VARCHAR(27)
);
INSERT INTO media_type VALUES (1,'MPEG audio file'),
	(2,'Protected AAC audio file'),
	(3,'Protected MPEG-4 video file'),
	(4,'Purchased AAC audio file'),
	(5,'AAC audio file');
