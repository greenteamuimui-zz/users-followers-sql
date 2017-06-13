CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

  CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) ,
    body TEXT,
    author_id VARCHAR(255),

    FOREIGN KEY (author_id) REFERENCES users(id)
  );

  CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    question_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
  );

  CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_in_question INTEGER NOT NULL,
    parent_reply INTEGER,
    author_id INTEGER NOT NULL
    body TEXT NOT NULL


    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (subject_in_question) REFERENCES questions(id),
    FOREIGN KEY (parent_reply) REFERENCES replies(id)
  );

  CREATE TABLE questions_like(
    id INTEGER PRIMARY KEY,
    question_liked INTEGER,
    liked_by_user INTEGER,

    FOREIGN KEY (question_liked) REFERENCES questions(id),
    FOREIGN KEY (liked_by_user) REFERENCES users(id)
  );

  INSERT INTO
    users (fname, lname)
  VALUES
    ('Cherry', 'Lam')
    ('Janet', 'Lee')
    ('Jane', 'Doe')
    ('John', 'Doe')

  INSERT INTO
    questions(title, body, author_id)
  VALUES
    ('App Academy', 'How to succeed?', (SELECT id FROM users WHERE fname = 'Cherry' AND lname = 'Lam')
    ('Hack Reactor', 'What is your name?', (SELECT id FROM users WHERE fname = 'Janet' AND lname = 'Lee')

  INSERT INTO
    question_follows(user_id, question_id)
  VALUES
    ((SELECT id FROM users WHERE fname = 'Jane'), (SELECT id FROM questions WHERE title = 'App Academy'))
    ((SELECT id FROM users WHERE fname = 'John'), (SELECT id FROM questions WHERE title = 'Hack Reactor'))

  INSERT INTO
    -- #replies, questions_like
    replies(subject_in_question, parent_reply, author_id, body)
  VALUES
    ((SELECT id FROM questions WHERE id = 1), NULL, (SELECT id FROM users WHERE fname = 'Jane'),'Sleep alot!')
    ((SELECT id FROM questions WHERE id = 2), NULL, (SELECT id FROM users WHERE fname = 'John'),'DJ jazzy')
    ((SELECT id FROM questions WHERE id = 1), (SELECT id FROM replies WHERE body = 'DJ jazzy'), (SELECT id FROM users WHERE fname = 'Jane'),'Study')

  INSERT INTO
    questions_liked(questions_liked, liked_by_user)
  VALUES
    ((SELECT id FROM questions WHERE body = 'How to succeed?'), (SELECT id FROM users WHERE fname = 'Janet' AND lname = 'Lee'))
    ((SELECT id FROM questions WHERE body = 'What is your name?'), (SELECT id FROM users WHERE fname = 'Cherry' AND lname = 'Lam'))
