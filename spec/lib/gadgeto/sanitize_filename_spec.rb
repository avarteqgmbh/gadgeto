require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/sanitize_filename')


describe Gadgeto::SanitizeFilename do

  class DummyClass
    include Gadgeto::SanitizeFilename
  end

  describe 'filename' do

    subject { DummyClass.new }

    it { expect(subject.sanitize_filename('/home/foo/bar')).to eq('bar') }
    it { expect(subject.sanitize_filename('\\bar')).to eq('bar') }

    context "stripping" do
      it { expect(subject.sanitize_filename('foo bar')).to eq('foo_bar') }
      it { expect(subject.sanitize_filename('  foobar  ')).to eq('foobar') }
    end

    context "remove special characters" do
      it { expect(subject.sanitize_filename(',bar')).to eq('_bar') }
    end

  end

end
