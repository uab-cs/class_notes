module ClassNotes
  module Notebook
    self::WrappedSuffix = "Notebook"

    ## @brief wrap a class in notes
    ## @param klass the class
    ## @return a copy of Klass with each of its methods wrapped
    def self.wrap_class(klass)
      notebook = Class.new(klass) {
        include Notebook

        attr_reader :notes, :add_note

        def initialize(*args, &block)
          @notes    = ClassNotes::Note.new(title: self.class.to_s)
          @add_note = ClassNotes.note_taker(notes)
          wrap_methods(*self.class.superclass.instance_methods(false))
          super(*args, &block)
        end
      }

      notebook_name = "#{klass.name.split("::").last}#{Notebook::WrappedSuffix}"
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
          child     = add_note.({title: meth.to_s, args: args})
          @add_note = ClassNotes.note_taker(child)

          results   = super(*args, &block)
          @add_note = parent

          child.results = results

          results
        }
      }
    end
  end
end
