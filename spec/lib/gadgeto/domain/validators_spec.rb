
require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../../lib/gadgeto/domain/validators')


describe Gadgeto::Domain::Validators do

  subject { Class.new.send(:include, Gadgeto::Domain::Validators).new }


  context "third_level_domain" do
    it "shouldn't validate other level domains" do
      expect(subject.third_level_domain?('de')).to be_falsey
      expect(subject.third_level_domain?('test.de')).to be_falsey
      expect(subject.third_level_domain?('test.test.test.de')).to be_falsey
    end

    it "should be valid on third level domain" do
      expect(subject.third_level_domain?('test.test.de')).to be_truthy
      expect(subject.third_level_domain?('t-t.test.de')).to be_truthy
      expect(subject.third_level_domain?('m.test.de')).to be_truthy
      expect(subject.third_level_domain?('m8.test.de')).to be_truthy
      expect(subject.third_level_domain?('m8.test42.de')).to be_truthy
    end

    it "should't be valid on special hyphen cases" do
      expect(subject.third_level_domain?('-t.test.de')).to be_falsey
      expect(subject.third_level_domain?('-.test.de')).to be_falsey
    end
  end

end
