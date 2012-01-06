require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/email')

describe Gadgeto::Email do

  it { Gadgeto::Email.valid?("user@example.com").should be_true }
  it { Gadgeto::Email.valid?("user+name@example.com").should be_true }

  it { Gadgeto::Email.valid?("userexample.com").should be_false }

end
