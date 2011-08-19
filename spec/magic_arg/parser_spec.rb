require 'spec_helper'



describe MagicArg::Parser do
  describe 'pulls out arguements' do
    describe 'from complex arguements' do
      it 'ordered arg with un classed hash and a splat' do
        foo_init = [1,2,3,4,5]
        bar_init = {:bar => "bahz"}
        bahz_init = "string"
        args = MagicArg::Args.new(*[1,2,3,4,5, bar_init, bahz_init])
        bar, foo, bahz = MagicArg::Parser.new(args, "bar = {}, *foo, bahz[String]").extract_args
        bar.should eq(bar_init)
        foo.should eq(foo_init)
        bahz.should eq(bahz_init)
      end


      it 'ordered arg with un classed splat and a hash' do
        foo_init = [1,2,3,4,5]
        bar_init = {:bar => "bahz"}
        args = MagicArg::Args.new(*[1,2,3,4,5, bar_init])
        foo, bar = MagicArg::Parser.new(args, "*foo, bar = {}").extract_args
        bar.should eq(bar_init)
        foo.should eq(foo_init)
      end


      it 'ordered arg with [classed] splat and a hash' do
        foo_init = [1,2,3,4,5]
        bar_init = {:bar => "bahz"}
        args = MagicArg::Args.new(*[1,2,3,4,5, bar_init])
        foo, bar = MagicArg::Parser.new(args, "*foo[Numeric], bar = {}").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end

      it 'ordered arg with splat and a splat' do
        foo_init = [1,2,3,4,5]
        bar_init = [:a, :b, :c]
        args = MagicArg::Args.new(*[1,2,3,4,5, :a, :b, :c])
        foo, bar = MagicArg::Parser.new(args, "*foo, *bar[Symbol]").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end
    end


    describe 'with class sepcified'  do
      it 'simple args' do
        foo_init = "foo"
        bar_init = :bar
        args = MagicArg::Args.new(*[foo_init, bar_init])
        bar, foo = MagicArg::Parser.new(args, "bar[Symbol], foo[String]").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end

      it 'ordered arg ending in hash' do
        foo_init = "foo"
        bar_init = {:bar => "bahz"}
        args = MagicArg::Args.new(*[foo_init, bar_init])
        bar, foo = MagicArg::Parser.new(args, "bar = {}, foo[String]").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end

      it 'ordered arg with splat' do
        foo_init = "foo"
        bar_init = {:bar => "bahz"}
        args = MagicArg::Args.new(*[foo_init, bar_init])
        bar, foo = MagicArg::Parser.new(args, "*bar, foo[String]").extract_args
        foo.should eq(foo_init)
        bar.should eq([bar_init])
      end
    end

    describe 'with no class specified' do
      it 'simple ordered args' do
        foo_init = "foo"
        bar_init = :bar
        args = MagicArg::Args.new(*[foo_init, bar_init])
        foo, bar = MagicArg::Parser.new(args, "foo, bar").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end

      it 'ordered arg ending in hash' do
        foo_init = "foo"
        bar_init = {:bar => "bahz"}
        args = MagicArg::Args.new(*[foo_init, bar_init])
        foo, bar = MagicArg::Parser.new(args, "foo, bar = {}").extract_args
        foo.should eq(foo_init)
        bar.should eq(bar_init)
      end

      it 'ordered arg ending in splat' do
        foo_init = "foo"
        bar_init = "bar"
        baz_init = "baz"
        args = MagicArg::Args.new(*[foo_init, bar_init, baz_init])
        foo, bar = MagicArg::Parser.new(args, "foo, *bar").extract_args
        foo.should eq(foo_init)
        bar.should eq([bar_init, baz_init])
      end

      it 'ordered arg ending in splat' do
        foo_init = "foo"
        bar_init = "bar"
        args = MagicArg::Args.new(*[foo_init, bar_init])
        foo, bar = MagicArg::Parser.new(args, "foo, *bar").extract_args
        foo.should eq(foo_init)
        bar.should eq([bar_init])
      end


    end
    
    
  end

end

