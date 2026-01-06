require "./drop"

module Liquid
  class ForLoop < Drop
    @collection : Array(Any) | Hash(String, Any) | Range(Int32, Int32)
    getter parentloop : ForLoop?
    property reversed : Bool = false

    def initialize(@collection, @parentloop, @reversed = false)
      @i = 0
    end

    @[Ignore]
    def each(&)
      collection = @collection
      if collection.is_a?(Array)
        iterable = @reversed ? collection.reverse : collection
        iterable.each do |val|
          yield(val)
          @i += 1
        end
      elsif collection.is_a?(Range)
        if @reversed
          # Reverse the range by iterating backwards
          collection.to_a.reverse.each do |val|
            yield(val)
            @i += 1
          end
        else
          collection.each do |val|
            yield(val)
            @i += 1
          end
        end
      else
        collection.each do |key, val|
          yield(Any{key, val})
          @i += 1
        end
      end
    end

    @[Ignore]
    def parentloop=(@parentloop)
    end

    def length
      @collection.size
    end

    def parentloop
    end

    def index
      @i + 1
    end

    def index0
      @i
    end

    def rindex
      length - @i
    end

    def rindex0
      length - @i - 1
    end

    def first
      @i.zero?
    end

    def last
      @i == length - 1
    end
  end
end
