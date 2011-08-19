require 'spec_helper'


describe MagicArg do

  describe 'self.new().parse()' do
    it 'works' do
      foo_init = "foo"
      bar_init = :bar
      foo, bar = MagicArg.new([foo_init, bar_init]).parse("foo, bar")
      foo.should eq(foo_init)
      bar.should eq(bar_init)
    end
  end
  
  describe 'self.parse' do
    it 'works' do
      foo_init = "foo"
      bar_init = :bar
      foo, bar = MagicArg.parse([foo_init, bar_init], "foo, bar")
      foo.should eq(foo_init)
      bar.should eq(bar_init)
    end
  end
end