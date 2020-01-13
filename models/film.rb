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
  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    film_hash = SqlRunner.run(sql, values).first
    film = Film.new(film_hash)
  end

# UPDATE
  def update()
    sql = "UPDATE films SET
    (
      title,
      price
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# INNER JOIN CUSTOMERS
  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def screenings()
    sql = "SELECT * FROM screenings WHERE film_id = $1"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.map {|screening| Screening.new(screening)}
  end

  def screening_times()
    times = []
    for screening in screenings() do
      times.push(screening.screening_time)
    end
    return times
  end

  def count_customers()
    return customers().length
  end

  def most_popular_screening_times()
    top_screening_time = nil
    most_screenings = 0
    for screening in screenings() do
      ticket_count = screening.count_tickets()
      if ticket_count > most_screenings
        top_screening_time = screening.screening_time
        most_screenings = ticket_count
      end
    end
    return top_screening_time
  end

end
