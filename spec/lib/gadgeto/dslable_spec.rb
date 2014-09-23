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

    expect(o_metaclass.respond_to?(:dslable_method)).to be_truthy
  end

  it "should define a class method dslable_method if included" do
    expect(DslableDummy.respond_to?(:dslable_method)).to be_truthy
  end

  it "should define an instance method draw" do
    o = DslableDummy.new
    expect(o.respond_to?(:draw)).to be_truthy
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

    it { expect(o.items.size).to eq(2) }
    it { expect(o.items[0].class).to eq(DslableDummy) }


    it { expect(o.items[0].items[0].items[0].attributes[:args].size).to eq(2) }
    it { expect(o.items[0].items[0].items[0].attributes[:args][1]).to eq("hello world") }

    it { expect(o.items[0].items[0].items[1].attributes[:key]).to eq("item1.1.2") }
 end

end
