require_relative('../db/sql_runner.rb')

class Screening

attr_accessor :film_id, :screening_time, :capacity
attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i if options['film_id']
  @screening_time = options['screening_time']
  @capacity = options['capacity']
end

# CREATE
def save()
  sql = "INSERT INTO screenings
  (
    film_id,
    screening_time,
    capacity
  )
  VALUES
  (
    $1, $2, $3
  )
  RETURNING id"
  values = [@film_id, @screening_time, @capacity]
  screening = SqlRunner.run(sql, values).first
  @id = screening['id'].to_i
end

def self.create_screening(film_id, screening_time, capacity)
  screening = Screening.new (
    {
      'film_id' => film_id,
      'screening_time' => screening_time,
      'capacity' => capacity
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

def self.find(id)
  sql = "SELECT * FROM screenings WHERE id = $1"
  values = [id]
  screening_hash = SqlRunner.run(sql, values).first
  screening = Screening.new(screening_hash)
end

# UPDATE
def update()
  sql = "UPDATE screenings SET
  (
    film_id,
    screening_time,
    capacity
  ) =
  (
    $1, $2, $3
  )
  WHERE id = $4"
  values = [@film_id, @screening_time, @capacity, @id]
  SqlRunner.run(sql, values)
end


# DELETE
def self.delete_all()
  sql = "DELETE FROM screenings"
  SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM screenings WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def film()
  sql = "SELECT * FROM films WHERE id = $1"
  values = [@film_id]
  film = SqlRunner.run(sql, values).first
  return Film.new(film)
end

def tickets()
  sql = "SELECT * FROM tickets WHERE screening_id = $1"
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  return tickets.map {|ticket| Ticket.new(ticket)}
end

def count_tickets()
  return tickets().length
end

end
