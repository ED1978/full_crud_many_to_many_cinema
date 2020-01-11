require_relative('./models/customer.rb')
require_relative('./models/film.rb')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()

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

kerry.funds = 200
kerry.update()

# alan.delete()

customers = Customer.all()

# FILM
hollywood = Film.new (
  {
    'title' => 'Once Upon A Time In HollyWood',
    'price' => 6
  }
)
hollywood.save()

joker = Film.new (
  {
    'title' => 'Joker',
    'price' => 6
  }
)
joker.save()

films = Film.all()

binding.pry
nil
