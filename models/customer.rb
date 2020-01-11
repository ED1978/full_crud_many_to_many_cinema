require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

# CREATE
  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

# READ
  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer_hash = SqlRunner.run(sql, values).first
    customer = Customer.new(customer_hash)
  end

# UPDATE


# DELETE
  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
