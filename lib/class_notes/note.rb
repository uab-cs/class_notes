module ClassNotes
  ##
  ## @brief      Class for a single step.
  ##
  class Note
    attr_accessor :title, :data, :children

    ##
    ## @brief      makes a new note
    ##
    ## @param      title The title of the note
    ## @param      data  The note's data
    ##
    ## @return     a new note object
    ##
    def initialize(title:, data:)
      @children = []
      @title    = title
      @data     = data
    end

    ##
    ## @brief      clears a notes children
    ##
    ## @return     []
    ##
    def reset!
      @children = []
    end

    ##
    ## @brief      add children
    ##
    ## @param other the child, can be either a note or a hash.  If a hash is
    ##              given, a new note will be created using the hash as its
    ##              arguments
    ##
    ## @return     []
    ##
    def <<(other)
      case other
      when Note
        @children << other
      when Hash
        @children << Note.new(other)
      end
      @children.last
    end

    ## @brief render the note as a string
    ## @param indent the indent level of the base string
    ## @return String
    def to_s(indent=0)
      [
        "#{"  " * indent}#{title}",
        unless children.empty?
          children.map { |child| child.to_s(indent+1) }.join("\n")
        end,
        "#{"  " * (indent+1)}#{data}"
      ].compact.join("\n")
    end

    ## @brief render the note as a hash
    ## @return Hash
    def to_h
      {
        title: title,
        children: children.empty? ? nil : children.map { |child| child.to_h },
        data: data
      }.compact
    end
  end
end
