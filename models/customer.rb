require('pg')
require_relative('../db/sql_runner.rb')
require_relative('film.rb')
require('pry-byebug')

class Customer

  attr_accessor :name, :funds, :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i
  end 

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *;"
    customer = SqlRunner.run(sql)
    @id = customer[0]['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT f.* FROM films f
      INNER JOIN tickets t
      on t.film_id = f.id
      INNER JOIN customers c
      ON c.id = t.customer_id;"
      Film.get_many(sql)
  end


  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end
 
  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

end