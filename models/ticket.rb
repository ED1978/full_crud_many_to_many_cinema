require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :customer_id, :film_id, :screening_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i if options['customer_id']
    @film_id = options['film_id'].to_i if options['film_id']
    @screening_id = options['screening_id'].to_i if options['screening_id']
  end

# CREATE
  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id,
      screening_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.create_ticket(customer_id, film_id, screening_id)
    ticket = Ticket.new(
      {
        'customer_id' => customer_id,
        'film_id' => film_id,
        'screening_id' => screening_id
      }
    )
    ticket.save()
  end

# READ
  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    ticket_hash = SqlRunner.run(sql, values).first
    ticket = Ticket.new(ticket_hash)
  end

# UPDATE
  def update()
    sql = "UPDATE tickets SET
    (
      customer_id,
      film_id,
      screening_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# JOIN CUSTOMER
  def customer()
    sql ="SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

# JOIN FILM
  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql , values).first
    return Film.new(film)
  end

end
