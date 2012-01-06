require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/dslable')

class DslableDummy
  include Gadgeto::Dslable

  dslable_method :item, :key, "*args"
end

describe Gadgeto::Dslable do

  it "should define a class method dslable_method if extended" do
    o = Object.new
    o.extend(Gadgeto::Dslable)
    o_metaclass = class << o; self; end

    o_metaclass.respond_to?(:dslable_method).should be_true
  end

  it "should define a class method dslable_method if included" do
    DslableDummy.respond_to?(:dslable_method).should be_true
  end

  it "should define an instance method draw" do
    o = DslableDummy.new
    o.respond_to?(:draw).should be_true
  end

  context "" do

    let (:o) {DslableDummy.new}

    before(:each) do
      o.draw do
        item "item1" do

          item "item1.1" do
            item "item1.1.1", 3, "hello world"
            item "item1.1.2"
          end

        end

        item "item2"
      end
    end

    it { o.items.size.should == 2 }
    it { o.items[0].class.should == DslableDummy }


    it { o.items[0].items[0].items[0].attributes[:args].size.should == 2 }
    it { o.items[0].items[0].items[0].attributes[:args][1].should == "hello world" }

    it { o.items[0].items[0].items[1].attributes[:key].should == "item1.1.2" }
 end

end
