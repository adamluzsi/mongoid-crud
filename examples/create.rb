require "mongoid-crud"

require_relative "helper/connection"
require_relative "helper/models"

test_a= TestA.__create__( hello: "world" )
test_b= TestB.__create__( hello: "world", world: "no", parent_id: test_a['_id'] )
test_c= TestC.__create__( hello: "embeds one", parent_id: test_a['_id'] )
test_d= TestD.__create__( hello: "embeds many in embeded one", parent_id: test_c['_id'] )

#> puts into json
puts TestA._read( _id: test_a['_id'] )

# [{"_id":"536b298b241548e55a000001","created_at":"2014-05-08T08:51:55+02:00","hello":"world","test_b":[{"_id":"536b298b241548e55a000002","created_at":"2014-05-08T08:51:55+02:00","hello":"world","updated_at":"2014-05-08T08:51:55+02:00","world":"no"}],"test_c":{"_id":"536b298b241548e55a000003","created_at":"2014-05-08T08:51:55+02:00","hello":"embeds one","updated_at":"2014-05-08T08:51:55+02:00"},"updated_at":"2014-05-08T08:51:55+02:00"}]

