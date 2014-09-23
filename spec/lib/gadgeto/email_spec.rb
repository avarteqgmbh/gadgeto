require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/email')

describe Gadgeto::Email do

  it { expect(Gadgeto::Email.valid?("user@example.com")).to be_truthy }
  it { expect(Gadgeto::Email.valid?("user+name@example.com")).to be_truthy }

  it { expect(Gadgeto::Email.valid?("userexample.com")).to be_falsey }

end
