
class TestA

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CRUD       #> but you should use extend for right use!

  store_in :collection => self.mongoid_name

  embeds_many :TestB.mongoid_name
  embeds_one  :TestC.mongoid_name

end

class TestB

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CRUD

  embedded_in :TestA.mongoid_name
  embeds_many :TestC.mongoid_name

end

class TestC

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CRUD

  embedded_in :TestA.mongoid_name

end