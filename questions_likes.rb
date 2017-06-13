require_relative 'QuestionsDatabase'

class QuestionsLikes
  attr_accessor :id, :question_liked, :liked_by_user

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM questions_likes")
  data.map { |datum| QuestionsLikes.new(datum) }
  end

  def self.find_by_id(id)
  question_like = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions_likes
    WHERE
      id = ?
  SQL
  return nil if question_like.empty?
  QuestionsLikes.new(question_like.first)
  end


  def initialize(options)
    @id = options['id']
    @question_liked = options['question_liked']
    @liked_by_user = options['liked_by_user']
  end

end
