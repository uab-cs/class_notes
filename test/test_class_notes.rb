require 'test/unit'
require_relative '../lib/class_notes'
require_relative 'simple_math'

class TestClassNotes < Test::Unit::TestCase

  def setup
    @notebook = ClassNotes.jot(SimpleMath).new
  end

  def teardown
    Object.send(:remove_const, @notebook.class.to_s)
  end

  def test_notebook
    [:add, :add_2, :add_4].each { |meth|
      assert @notebook.respond_to? meth
    }
  end

  def test_unobtrusiveness
    assert_equal @notebook.add_4(a: 1, b: 2, c: 3, d: 4), 10
  end

  def test_penmanship
    @notebook.add_4(a: 1, b: 2, c: 3, d: 4)
    notes = @notebook.notes
    assert_equal notes.title, "SimpleMathNotebook"
    assert_equal notes.to_h[:children].first[:children][2][:children].first[:data][:args][1], 7
  end

end
