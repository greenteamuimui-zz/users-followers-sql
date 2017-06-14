require_relative 'QuestionsDatabase'

class Replies
  attr_accessor :id, :subject_in_question, :parent_reply, :author_id, :body

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_id(id)
  reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
  SQL
  return nil if reply.empty?
  Replies.new(reply.first)
  end

  def self.find_by_user_id(user_id) #returns replies to user_id regardless of questions
    reply = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    return nil if reply.empty?
    Replies.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_in_question = ?
    SQL
    return nil if reply.empty?
    reply.map {|hash| Replies.new(hash)}
  end


  def initialize(options)
    @id = options['id']
    @subject_in_question = options['subject_in_question']
    @parent_reply = options['parent_reply']
    @author_id = options['author_id']
    @body = options['body']
  end

  def author #return array of authors
    author = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil if author.empty?
    author.map {|hash| Users.new(hash)}
  end

  def question
    question = QuestionsDBConnection.instance.execute(<<-SQL, subject_in_question)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    return nil if question.empty?
    question.map {|hash| Questions.new(hash)}
  end

  def parent_reply # fix this
    return nil if self.parent_reply.nil?
    parent = QuestionsDBConnection.instance.execute(<<-SQL, parent_reply)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    return nil if parent.empty?
    parent.map {|hash| Replies.new(hash)}
  end

  def child_replies
    child = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply = ?
    SQL
    return nil if child.empty?
    child.map {|hash| Replies.new(hash)}
  end


end
