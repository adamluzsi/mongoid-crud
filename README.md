mongoid-crud
============

CRUD methods for mongoid
Four super simple to use method on any mongoid model.

```ruby
    __create__
    __read__
    __update__
    __delete__
```

### Example


short example:

```ruby
    require "mongoid-crud"

    require_relative "helper/connection"
    require_relative "helper/models"

    test_a= TestA.__create__( hello: "world" )
    test_b= TestB.__create__( hello: "world", world: "no", parent_id: test_a['_id'] )
    test_C= TestC.__create__( hello: "embeds one", parent_id: test_a['_id'] )

    #> puts into json
    puts TestA._read( _id: test_a['_id'] ).to_json
```

produce:

```json
  [{"_id":"536b298b241548e55a000001","created_at":"2014-05-08T08:51:55+02:00","hello":"world","test_b":[{"_id":"536b298b241548e55a000002","created_at":"2014-05-08T08:51:55+02:00","hello":"world","updated_at":"2014-05-08T08:51:55+02:00","world":"no"}],"test_c":{"_id":"536b298b241548e55a000003","created_at":"2014-05-08T08:51:55+02:00","hello":"embeds one","updated_at":"2014-05-08T08:51:55+02:00"},"updated_at":"2014-05-08T08:51:55+02:00"}]
```


```ruby
    require "mongoid-crud"

    require_relative "helper/connection"
    require_relative "helper/models"

    test_a= TestA.__create__( hello: "world" )
    #> TestA obj return

    test_b= TestB.__create__( hello: "world", world: "no", parent_id: test_a['_id'] )
    #> TestB obj return

    TestB.__read__( hello: "world", world: "no", parent_id: test_a['_id'] ).each{|e|puts(e.inspect)}
    #> search by parent_id + query , mongoid criteria return

    puts TestB.__read__(  _id: test_b['_id'] ).inspect
    #> search for target _id in embeds, object return

    TestB.__read__( hello: "world", world: "no" ).inspect
    #> search all embeds by query , return in simple array

    TestB.__update__ _id: test_b['_id'], hello: "sup!"
    #> true

    TestB.__read__(  _id: test_b['_id'] )
    #> TestB Obj

    TestB.__delete__(  _id: test_b['_id'] )
    #> true

    TestB.__read__(  _id: test_b['_id'] )
    #> nil
```