require('pg')
require_relative('film')
require_relative('customer')

class Ticket

  attr_accessor :customer_id, :film_id, :id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
      VALUES 
      ('#{ @customer_id }', '#{ @film_id }') 
      RETURNING *"
    ticket = SqlRunner.run(sql)
    @id = ticket[0]['id'].to_i
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id};"
    customer = SqlRunner.run(sql).first
    return Customer.new(customer)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = #{@film_id};"
    film = SqlRunner.run(sql).first
    return Film.new(film)
  end

  def self.sell_ticket(customer, film)
    ticket = Ticket.new({'customer_id' => customer.id,
      'film_id' => film.id
      })
    ticket.save()
    film.available_tickets -= 1
    film.update()
    customer.funds -= film.price
    customer.update()
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end



end