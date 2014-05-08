begin

  require 'mongoid-crud/ext'
  Mongoid::Config.inject_singleton_method :register_model, add: :before do |klass|
    klass.__send__ :extend, Mongoid::CRUD::Extend
  end

rescue Exception
  STDOUT.puts("mongoid-dsl")
end
