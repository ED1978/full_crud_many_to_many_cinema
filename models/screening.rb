require_relative('../db/sql_runner.rb')

class Screening

attr_accessor :film_id, :screening_time
attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i if options['film_id']
  @screening_time = options['screening_time']
end

# CREATE
def save()
  sql = "INSERT INTO screenings
  (
    film_id,
    screening_time
  )
  VALUES
  (
    $1, $2
  )
  RETURNING id"
  values = [@film_id, @screening_time]
  screening = SqlRunner.run(sql, values).first
  @id = screening['id'].to_i
end

def self.create_screening(film_id, screening_time)
  screening = Screening.new (
    {
      'film_id' => film_id,
      'screening_time' => screening_time
    }
  )
  screening.save()
end

# READ
def self.all()
  sql = "SELECT * FROM screenings"
  screenings = SqlRunner.run(sql)
  return screenings.map {|screening| Screening.new(screening)}
end

# UPDATE


# DELETE

end
