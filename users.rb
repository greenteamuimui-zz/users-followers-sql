require_relative 'QuestionsDatabase'

class Users
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| Users.new(datum) }
  end

  def self.find_by_id(id)
  user = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
  SQL
  #returns an empty array if the input ID isn't included in the database
  return nil if user.empty?
  # user is an array of one hash with user information. must unzip the array to access the hash
  Users.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    #returns an empty array if the input ID isn't included in the database
    return nil if user.empty?
    # user is an array of one hash with user information. must unzip the array to access the hash
    Users.new(user.first)
  end


  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end
