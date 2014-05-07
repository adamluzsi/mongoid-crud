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

```ruby

    test_a= TestA.__create__ hello: "world"
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