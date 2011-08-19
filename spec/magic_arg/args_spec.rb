require 'spec_helper'

describe MagicArg::Args do
  describe '' do
    it '' do
      string = "foo"
      symbol = :bar
      args = MagicArg::Args.new(string, symbol)
      args.should eq([string, symbol])
      args.find(String).first.should eq(string)
      args.find(Symbol).first.should eq(symbol)
    end
  end

  describe 'handles different input types' do
    it '' do
      string = "foo"
      symbol = :bar
      args = MagicArg::Args.new(*[string, symbol])
      args.should eq([string, symbol])
      args.find(String).first.should eq(string)
      args.find(Symbol).first.should eq(symbol)
    end
  end

  describe 'pop!' do
    it 'pulls out the first value matching parameter, and removes it from args' do
      string = "foo"
      symbol = :bar
      args = MagicArg::Args.new(*[string, symbol])
      args.pop!(Symbol).should == symbol
      args.should_not include(symbol)
    end
  end

  describe 'split' do
    it 'splits if class is in the middle' do
      input = [1, nil, 2 ]
      args = MagicArg::Args.new(*input)
      args.split(NilClass).should eq([[1], [2]])
    end

    it 'splits if class is at the beginning' do
      input = [nil, 1, 2]
      args = MagicArg::Args.new(*input)
      args.split(NilClass).should eq([[1, 2]])
    end

    it 'splits if class is at the beginning' do
      input = [nil, ["bar"]]
      args = MagicArg::Args.new(*input)
      args.split(NilClass).first.should eq([["bar"]])
    end

  end

end