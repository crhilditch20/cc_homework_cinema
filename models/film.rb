require('pg')
require_relative('../db/sql_runner.rb')
require('pry-byebug')

class Film

attr_accessor :title, :price, :available_tickets, :id

def initialize(options)
  @title = options['title']
  @price = options['price'].to_i
  @id = options['id'].to_i
  @available_tickets = options['available_tickets'].to_i
end

def save()
  sql = "INSERT INTO films (title, price, available_tickets) VALUES ('#{@title}', #{@price}, #{@available_tickets}) RETURNING *;"
  film = SqlRunner.run(sql)
  @id = film[0]['id'].to_i
end

def update()
  sql = "UPDATE films SET (title, price, available_tickets) = ('#{@title}', #{@price}, #{@available_tickets}) WHERE id = #{@id};"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM films;"
  films = SqlRunner.run(sql)
  result = films.map { |film| Film.new(film) }
  return result
end

def self.delete_all() 
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)
end

def self.get_many(sql)
  films = SqlRunner.run(sql)
  result = films.map { |film| Film.new(film) }
  return result
end

end