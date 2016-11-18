require('pg')
require_relative('../db/sql_runner.rb')
require('pry-byebug')

class Film

attr_accessor :title, :price
attr_reader :id

def initialize(options)
  @title = options['title']
  @price = options['price'].to_i
  @id = options['id'].to_i
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
  id_finder = SqlRunner.run(sql)
  @id = id_finder[0]['id'].to_i
end

def update()
  sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id};"
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