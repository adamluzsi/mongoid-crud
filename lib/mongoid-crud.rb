require 'mongoid'
require 'mongoid-dsl'

module Mongoid

  module CRUD

    @@parent_sym= :parent_id
    def self.included klass
      klass.__send__ :extend, self
    end

    def __create__ *args

      query   = Hash[*args.select{|e| e.class <= ::Hash }]
      classes = args.select{|e| e.class <= ::Class }

      if self.embedded?
        raise(ArgumentError,"for embeded document, you need :#{@@parent_sym}") if query[@@parent_sym].nil?
        return self._get_class_path(*classes).pinch.last._find(query.delete(@@parent_sym)).__send__(self.mongoid_name).create!(query)
      else
        return self.create!(query)
      end

    end
    alias _create __create__

    def __read__ *args

      query   = Hash[*args.select{|e| e.class <= ::Hash }]
      classes = args.select{|e| e.class <= ::Class }

      if self.embedded?
        # raise(ArgumentError,"for embeded document, you need :#{@@parent_sym}") if [:_id,@@parent_sym].select{|e| !query[e].nil?}.empty?

        if !query[:_id].nil?
          return self._find(query[:_id])#.__send__(self.mongoid_name).create(query)
        elsif !query[@@parent_sym].nil?
          return self._get_class_path(*classes).pinch.last._find(query.delete(@@parent_sym)).__send__(self.mongoid_name).where(query)
        else
          return self._where(query)
        end

      else
        return self.where(query)
      end

    end
    alias _read __read__

    def __update__ *args

      query   = Hash[*args.select{|e| e.class <= ::Hash }]
      classes = args.select{|e| e.class <= ::Class }

      raise(ArgumentError,"to #{__method__} document, you need :_id") if query[:_id].nil?
      var= self._find(query.delete(:_id))
      query.each{|k,v| var[k]= v }
      return var.save!

    end
    alias _update __update__

    def __delete__ *args

      query   = Hash[*args.select{|e| e.class <= ::Hash }]
      classes = args.select{|e| e.class <= ::Class }

      raise(ArgumentError,"to #{__method__} document, you need :_id") if query[:_id].nil?
      return self._find(query[:_id]).delete

    end
    alias _delete __delete__

  end
end