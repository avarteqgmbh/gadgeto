
require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/domain')


describe Gadgeto::Domain::Validators do

  subject { Gadgeto::Domain }

  context "domain" do
    it "should validate domains" do
      expect(subject.new('de')).to be_valid
      expect(subject.new('test.de')).to be_valid
      expect(subject.new('test.test.de')).to be_valid
      expect(subject.new('test.test.test.de')).to be_valid
    end
  end

  context "third_level_domain" do
    it "shouldn't validate other level domains" do
      expect(subject.new('de')).to_not be_third_level_domain
      expect(subject.new('test.de')).to_not be_third_level_domain
      expect(subject.new('test.test.test.de')).to_not be_third_level_domain
    end

    it "should be valid on third level domain" do
      expect(subject.new('test.test.de')).to be_third_level_domain
      expect(subject.new('t-t.test.de')).to be_third_level_domain
      expect(subject.new('m.test.de')).to be_third_level_domain
      expect(subject.new('m8.test.de')).to be_third_level_domain
      expect(subject.new('m8.test42.de')).to be_third_level_domain
    end

    it "should't be valid on special hyphen cases" do
      expect(subject.new('-t.test.de')).to_not be_third_level_domain
      expect(subject.new('-.test.de')).to_not be_third_level_domain
    end
  end

end
