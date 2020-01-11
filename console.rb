require_relative('./models/customer.rb')

require('pry-byebug')

kerry = Customer.new (
  {
    'name' => 'Kerry Morrison',
    'funds' => 100
  }
)
kerry.save()

binding.pry
nil
