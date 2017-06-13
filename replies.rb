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


  def initialize(options)
    @id = options['id']
    @subject_in_question = options['subject_in_question']
    @parent_reply = options['parent_reply']
    @author_id = options['author_id']
    @body = options['body']
  end

end
