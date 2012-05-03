
require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/domain')


describe Gadgeto::Domain::Validators do

  subject { Gadgeto::Domain }

  context "domain" do
    it "should validate domains" do
      subject.new('de').should be_valid
      subject.new('test.de').should be_valid
      subject.new('test.test.de').should be_valid
      subject.new('test.test.test.de').should be_valid
    end # shouldn't validate other level domains
  end

  context "third_level_domain" do
    it "shouldn't validate other level domains" do
      subject.new('de').should_not be_third_level_domain
      subject.new('test.de').should_not be_third_level_domain
      subject.new('test.test.test.de').should_not be_third_level_domain
    end # shouldn't validate other level domains

    it "should be valid on third level domain" do
      subject.new('test.test.de').should be_third_level_domain
      subject.new('t-t.test.de').should be_third_level_domain
      subject.new('m.test.de').should be_third_level_domain
      subject.new('m8.test.de').should be_third_level_domain
      subject.new('m8.test42.de').should be_third_level_domain
    end # should be valid on third level domain
    
    it "should't be valid on special hyphen cases" do
      subject.new('-t.test.de').should_not be_third_level_domain
      subject.new('-.test.de').should_not be_third_level_domain
    end # should be valid on third level domain
  end # third_level_domain

end
