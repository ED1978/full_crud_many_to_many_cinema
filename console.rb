require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

require('pry-byebug')

Ticket.delete_all()
# Screening.delete_all()
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

eric = Customer.new (
  {
    'name' => 'Eric Downie',
    'funds' => 200
  }
)
eric.save()

steve = Customer.new (
  {
    'name' => 'Steve Smith',
    'funds' => 200
  }
)
steve.save()

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


# screening
screening_1 = Screening.new (
  {
    'film_id' => hollywood.id,
    'screening_time' => '1300',
    'capacity' => 5
  }
)
screening_1.save()

screening_2 = Screening.new (
  {
    'film_id' => joker.id,
    'screening_time' => '1500',
    'capacity' => 3
  }
)
screening_2.save()

screening_3 = Screening.new (
  {
    'film_id' => hollywood.id,
    'screening_time' => '1700',
    'capacity' => 5
  }
)
screening_3.save()

screening_4 = Screening.new (
  {
    'film_id' => joker.id,
    'screening_time' => '1900',
    'capacity' => 5
  }
)
screening_4.save()

screening_4.screening_time = '1930'
screening_4.update()


found_screening = Screening.find(screening_1.id)

# screening_1.delete()

screenings = Screening.all()

# TICKET
# ticket_1 = Ticket.new (
#   {
#     'customer_id' => alan.id,
#     'film_id' => hollywood.id,
#     'screening_id' => screening_1.id
#   }
# )
# ticket_1.save()
#
# ticket_2 = Ticket.new (
#   {
#     'customer_id' => kerry.id,
#     'film_id' => hollywood.id,
#     'screening_id' => screening_2.id
#   }
# )
# ticket_2.save()

# ticket_2.film_id = joker.id
# ticket_2.update()

# found_ticket = Ticket.find(ticket_2.id)

# ticket_2.delete()

alan.buy_ticket(screening_1)
alan.buy_ticket(screening_2)
alan.buy_ticket(screening_3)
alan.buy_ticket(screening_4)
kerry.buy_ticket(screening_2)
eric.buy_ticket(screening_2)
eric.buy_ticket(screening_3)
steve.buy_ticket(screening_2)

tickets = Ticket.all()


kerry.pay(joker.price)

binding.pry
nil
