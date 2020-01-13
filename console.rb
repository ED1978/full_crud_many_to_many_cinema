require_relative('./models/customer.rb')
require_relative('./models/film.rb')
# require_relative('./models/ticket.rb')

require('pry-byebug')

Ticket.delete_all()
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

joker.price = 7
joker.update()

found_film = Film.find(joker.id)

# joker.delete()


films = Film.all()


# TICKET
ticket_1 = Ticket.new (
  {
    'customer_id' => alan.id,
    'film_id' => hollywood.id
  }
)
ticket_1.save()

ticket_2 = Ticket.new (
  {
    'customer_id' => kerry.id,
    'film_id' => hollywood.id
  }
)
ticket_2.save()

ticket_2.film_id = joker.id
ticket_2.update()

found_ticket = Ticket.find(ticket_2.id)

# ticket_2.delete()

tickets = Ticket.all()

alan.buy_ticket(joker)

binding.pry
nil
