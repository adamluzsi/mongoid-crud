mongoid-crud
============

CRUD methods for mongoid models

## Four method to rule them all!

Four super simple to use method on any mongoid model.


```ruby
    __create__ || _create
    __read__   || _read
    __update__ || _update
    __delete__ || _delete
```
### Behavior

create:
* if the model is an embeds it require a parent_id passed by "parent_id" or :parent_id key
    * same goes for the referenced
* if the model is a main one it's the same as normaly, pass the hash obj

read:
* if the model embeds or referenced you MAY tell the parent_id but you dont have to
    * in that case every doc that match the query hash will be returned in an array
* if you give _id than it will the object (even if it's embedded deeply in mordor)
* if you pass parent_id but no _id it will return a mongoid criteria with the collection of finds under the specified parent

update:
* you must give the _id for the target obj and any other hash tag will be the values to be set

delete:
* you must give the _id for delete the target obj
    * if you want drop a collection from a parent i suggest to use read + _id to find that object and give direct order to drop the embeds/reference collection


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

#### Complex example

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