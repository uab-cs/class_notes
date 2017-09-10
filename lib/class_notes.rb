require_relative 'class_notes/note'
require_relative 'class_notes/notebook'

module ClassNotes
  ::Version = [1, 0, 0]

  ## @brief create a new note taker Proc on parent
  ## @param parent the parent note
  ## @return a new Proc that can add notes to the parent
  def self.note_taker(parent)
    ->(note){ parent << note }
  end

  ## @brief wrap a class in notes
  ## @param klass the class
  ## @return a wrapped class
  def self.jot(klass)
    ClassNotes::Notebook.wrap_class(klass)
  end

end
