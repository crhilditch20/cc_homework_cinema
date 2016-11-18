require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require('pry-byebug')

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  'name' => 'Claire',
  'funds' => 40
  })
customer2 = Customer.new({
  'name' => 'Steph',
  'funds' => 30
  })
customer3 = Customer.new({
  'name' => 'Jane',
  'funds' => 35
  })
customer4 = Customer.new({
  'name' => 'Winnie',
  'funds' => 45
  })

customer1.save()
customer2.save()
customer3.save()
customer4.save()

customer4.funds = 50
customer4.update()

film1 = Film.new({
  'title' => 'Batman Begins',
  'price' => 7
  })
film2 = Film.new({
  'title' => 'Finding Nemo',
  'price' => 5
  })

film1.save()
film2.save()

film2.title = 'Finding Dory'
film2.update()

Film.all
Customer.all

binding.pry
nil


