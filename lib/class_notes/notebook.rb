module ClassNotes
  module Notebook
    ::WrappedSuffix = "Notebook"

    ## @brief wrap a class in notes
    ## @param klass the class
    ## @return a copy of Klass with each of its methods wrapped
    def self.wrap_class(klass)
      notebook = Class.new(klass) {
        include Notebook

        attr_reader :notes, :add_note

        def initialize
          @notes    = ClassNotes::Note.new(title: self.class.to_s, data: {})
          @add_note = ClassNotes.note_taker(notes)
          wrap_methods(*self.class.superclass.instance_methods(false))
        end
      }


      notebook_name = "#{klass.to_s}#{::WrappedSuffix}"
      Object.const_set notebook_name, notebook

      notebook
    end

    ## @brief wrap methods with notes
    ## @param meths the methods to wrap
    ## @return nil
    def wrap_methods(*meths)
      meths.each { |meth|
        m = method(meth)
        define_singleton_method(meth) { |*args, &block|

          parent    = add_note
          child     = add_note.({title: meth.to_s, data: {}})
          @add_note = ClassNotes.note_taker(child)

          result    = super(*args, &block)
          @add_note = parent

          pretty_args =
            case args.first
            when Hash
              args.first.map { |t, v| [t, v.to_s]}.to_h
            else
              args
            end

          child.data = {args: pretty_args, result: result}

          result
        }
      }
    end
  end
end
