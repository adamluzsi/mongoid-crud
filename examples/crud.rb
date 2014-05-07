require_relative "../lib/mongoid-dsl"
require_relative "helper/connection"
require_relative "helper/models"

test_a= TestA.__create__ hello: "world"
test_b= TestB.__create__( hello: "world", world: "no", parent_id: test_a['_id'] )


TestB.__read__( hello: "world", world: "no", parent_id: test_a['_id'] ).each{|e|puts(e.inspect)}
#> search by parent_id + query

puts TestB.__read__(  _id: test_b['_id'] ).inspect
#> search for target _id in embeds

puts TestB.__read__( hello: "world", world: "no" ).inspect
#> search all embeds by query

puts TestB.__update__ _id: test_b['_id'], hello: "sup!"

puts TestB.__read__(  _id: test_b['_id'] ).inspect
puts TestB.__delete__(  _id: test_b['_id'] ).inspect
puts TestB.__read__(  _id: test_b['_id'] ).inspect


Mongoid.purge!