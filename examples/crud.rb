require "mongoid-crud"

require_relative "helper/connection"
require_relative "helper/models"

test_a= TestA.__create__( hello: "world" )
test_b= TestB.__create__( hello: "world", world: "no", parent_id: test_a['_id'] )
test_c= TestC.__create__( hello: "embeds one", parent_id: test_a['_id'] )

#> puts into json
puts TestA._read( _id: test_a['_id'] ).to_json
# [{"_id":"536b298b241548e55a000001","created_at":"2014-05-08T08:51:55+02:00","hello":"world","test_b":[{"_id":"536b298b241548e55a000002","created_at":"2014-05-08T08:51:55+02:00","hello":"world","updated_at":"2014-05-08T08:51:55+02:00","world":"no"}],"test_c":{"_id":"536b298b241548e55a000003","created_at":"2014-05-08T08:51:55+02:00","hello":"embeds one","updated_at":"2014-05-08T08:51:55+02:00"},"updated_at":"2014-05-08T08:51:55+02:00"}]

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
