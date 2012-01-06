require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/sanitize_filename')


describe Gadgeto::SanitizeFilename do

  class DummyClass
    include Gadgeto::SanitizeFilename
  end

  describe 'filename' do

    subject { DummyClass.new }

    it { subject.sanitize_filename('/home/foo/bar').should == 'bar'}
    it { subject.sanitize_filename('\\bar').should == 'bar'}

    context "stripping" do
      it { subject.sanitize_filename('foo bar').should == 'foo_bar'}
      it { subject.sanitize_filename('  foobar  ').should == 'foobar'}
    end

    context "remove special characters" do
      it { subject.sanitize_filename(',bar').should == '_bar'}
    end

  end

end
