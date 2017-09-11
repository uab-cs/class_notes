module ClassNotes
  ##
  ## @brief      Class for a single step.
  ##
  class Note
    attr_accessor :title, :children
    attr_reader :args, :results

    ##
    ## @brief      makes a new note
    ##
    ## @param      title The title of the note
    ## @param      data  The note's data
    ##
    ## @return     a new note object
    ##
    def initialize(title:, args:nil, results:nil)
      @title    = title
      self.args=(args) if args
      self.results=(results) if results

      @children = []
    end

    def args=(args)
      @args =
        if args.length == 1 and args.first.class == Hash
          normalize(args.first)
        else
          normalize(args)
        end
    end

    def results=(data)
      @results=normalize(data)
    end

    def normalize(data)
      case data
      when Hash
        data.map { |t, v| [t, v.to_s]}.to_h
      when Array
        i = -1
        data.map { |e|
          [ i+=1 , e.to_s]
        }.to_h
      else
        {0 => "#{data}"}
      end
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

    def h_to_s(hash, pre)
      hash.map { |i, a| pre + "#{i}: #{a}" }.join("\n")
    end

    def tab(i)
      "  " * i
    end

    ## @brief render the note as a string
    ## @param indent the indent level of the base string
    ## @return String
    def to_s(i=0)
      [
        tab(i) + "#{title}:",
        if args and not args.empty?
          tab(i+1) + "args:\n" + h_to_s(args, tab(i+2))
        end,
        unless children.empty?
          tab(i+1) + "children:\n" +
          children.map { |child| child.to_s(i+2) }.join("\n")
        end,
        if results
          tab(i+1) + "results:\n" + h_to_s(results, tab(i+2))
        end
      ].compact.join("\n")
    end

    ## @brief render the note as a hash
    ## @return Hash
    def to_h
      {
        title: title,
        args: args,
        children: children.empty? ? nil : children.map { |child| child.to_h },
        results: results
      }.compact
    end
  end
end
