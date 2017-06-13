require_relative 'QuestionsDatabase'

class QuestionsFollows
  attr_accessor :id, :user_id, :question_id

  def self.all
  data = QuestionsDBConnection.instance.execute("SELECT * FROM question_follows")
  data.map { |datum| QuestionsFollows.new(datum) }
  end

  def self.find_by_id(id)
  question_follow = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      id = ?
  SQL
  return nil if question_follow.empty?
  QuestionsFollows.new(question_follow.first)
  end


  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
