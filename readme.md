# class_notes
[![Gem Version](https://d25lcipzij17d.cloudfront.net/badge.svg?id=rb&type=6&v=2.0.0&x2=0)](https://rubygems.org/gems/class_notes)

make your classes take notes

## install:
    gem install class_notes

## usage:

```ruby
require 'class_notes'

class SimpleMath
  def add(a:, b:)
    a + b
  end

  def add_4(a:,b:,c:,d:)
    add(a: add(a: a, b: b), b: add(a: c, b: d) )
  end
end

notebook = ClassNotes.jot(SimpleMath).new
notebook.add_4(a: 1, b: 2, c: 3, d: 4) # => 10
puts notebook.notes
```
```YAML
SimpleMathNotebook:
  children:
    add_4:
      args:
        a: 1
        b: 2
        c: 3
        d: 4
      children:
        add:
          args:
            a: 1
            b: 2
          results:
            0: 3
        add:
          args:
            a: 3
            b: 4
          results:
            0: 7
        add:
          args:
            a: 3
            b: 7
          results:
            0: 10
      results:
        0: 10
```
## docs:
http://www.rubydoc.info/gems/class_notes
