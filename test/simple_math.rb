class SimpleMath
  def add(a:, b:)
    add_2(a, b)
  end

  def add_2(a, b)
    a + b
  end

  def recurse(i=0)
    recurse i+1 unless i > 10
  end

  def add_4(a:,b:,c:,d:)
    add(a: add(a: a, b: b), b: add(a: c, b: d) )
  end
end
