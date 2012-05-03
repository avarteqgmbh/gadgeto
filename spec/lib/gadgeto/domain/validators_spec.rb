
require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../../lib/gadgeto/domain/validators')


describe Gadgeto::Domain::Validators do

  subject { Class.new.send(:include, Gadgeto::Domain::Validators).new }


  context "third_level_domain" do
    it "shouldn't validate other level domains" do
      subject.third_level_domain?('de').should be_false
      subject.third_level_domain?('test.de').should be_false
      subject.third_level_domain?('test.test.test.de').should be_false
    end # shouldn't validate other level domains

    it "should be valid on third level domain" do
      subject.third_level_domain?('test.test.de').should be_true
      subject.third_level_domain?('t-t.test.de').should be_true
      subject.third_level_domain?('m.test.de').should be_true
      subject.third_level_domain?('m8.test.de').should be_true
      subject.third_level_domain?('m8.test42.de').should be_true
    end # should be valid on third level domain
    
    it "should't be valid on special hyphen cases" do
      subject.third_level_domain?('-t.test.de').should be_false
      subject.third_level_domain?('-.test.de').should be_false
    end # should be valid on third level domain
  end # third_level_domain

end
