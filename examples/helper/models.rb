
class TestA

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CRUD       #> but you should use extend for right use!

  store_in :collection => self.mongoid_name

  embeds_many :TestB.mongoid_name

end

class TestB

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CRUD       #> but you should use extend for right use!

  embedded_in :TestA.mongoid_name
  embeds_many :TestC.mongoid_name


end

class TestC

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :TestB.mongoid_name
  embeds_many :TestD.mongoid_name

  field :test,
        :type         => String,
        :presence     => true,
        :desc         => "description for this field"

end

class TestD

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :TestC.mongoid_name

  field :test,
        :type         => String,
        :presence     => true,
        :desc         => "description for this field"

end