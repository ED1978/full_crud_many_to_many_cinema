require_relative('./models/customer.rb')

require('pry-byebug')

Customer.delete_all()

# CUSTOMER
kerry = Customer.new (
  {
    'name' => 'Kerry Morrison',
    'funds' => 100
  }
)
kerry.save()

alan = Customer.new (
  {
    'name' => 'Alan Anderson',
    'funds' => 200
  }
)
alan.save()

found_customer = Customer.find(alan.id)

customers = Customer.all()

binding.pry
nil
