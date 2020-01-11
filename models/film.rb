require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

# CREATE
  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

# READ


# UPDATE


# DELETE
def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

end
