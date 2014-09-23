require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/time_of_day')

describe Gadgeto::TimeOfDay do

  describe "new" do

    it "should require an argument" do
      expect { Gadgeto::TimeOfDay.new }.to raise_exception
    end

    it { expect{ Gadgeto::TimeOfDay.new("0730") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("a:30") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("-1:30") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("+1:30") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("a1:30") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("01:x") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("01:3") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("30:00") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("01:70") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("01:61") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("25:00") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }
    it { expect{ Gadgeto::TimeOfDay.new("24:01") }.to raise_error(Gadgeto::TimeOfDay::InvalidTimeOfDayFormat) }

    it { expect{ Gadgeto::TimeOfDay.new("24:00") }.not_to raise_error }
    it { expect{ Gadgeto::TimeOfDay.new("08:13") }.not_to raise_error }
  end


  describe "to_s" do
    it "should return string representation by default" do
      Gadgeto::TimeOfDay.new("08:30").to_s.should == "08:30"
    end
  end

  describe "to_i" do
    context "should return time of day converted in minutes" do
      it { Gadgeto::TimeOfDay.new("00:00").to_i.should == 0 }
      it { Gadgeto::TimeOfDay.new("08:00").to_i.should == (8 * 60) }
      it { Gadgeto::TimeOfDay.new("08:13").to_i.should == (8 * 60 + 13) }
    end
  end

  describe "hour" do
    it { Gadgeto::TimeOfDay.new("08:30").hour.should == 8 }
    it { Gadgeto::TimeOfDay.new("8:30").hour.should == 8 }
  end

  describe "minute" do
    it { Gadgeto::TimeOfDay.new("08:37").minute.should == 37 }
    it { Gadgeto::TimeOfDay.new("08:07").minute.should == 7 }
  end

  describe "add_minutes" do
    it { Gadgeto::TimeOfDay.new("08:30").add_minutes(7).to_s.should == "08:37" }
    it { Gadgeto::TimeOfDay.new("08:59").add_minutes(1).to_s.should == "09:00" }
    it { Gadgeto::TimeOfDay.new("08:00").add_minutes(135).to_s.should == "10:15" }

    it { Gadgeto::TimeOfDay.new("23:59").add_minutes(1).to_s.should == "00:00" }
    it { Gadgeto::TimeOfDay.new("23:59").add_minutes(2).to_s.should == "00:01" }
    it { Gadgeto::TimeOfDay.new("23:59").add_minutes(120).to_s.should == "01:59" }

  end

  describe "self.valid?" do
    it { expect { Gadgeto::TimeOfDay.valid? }.to raise_error }
    it { Gadgeto::TimeOfDay.valid?("08:07").should be_truthy }
    it { Gadgeto::TimeOfDay.valid?("08:70").should be_falsey }
    it { Gadgeto::TimeOfDay.valid?("x8:30").should be_falsey }
  end

  describe "operator <" do
    it { (Gadgeto::TimeOfDay.new("08:00") < Gadgeto::TimeOfDay.new("08:01")).should be_truthy }
    it { (Gadgeto::TimeOfDay.new("08:01") < Gadgeto::TimeOfDay.new("08:00")).should be_falsey }
    it { (Gadgeto::TimeOfDay.new("08:00") < Gadgeto::TimeOfDay.new("08:00")).should be_falsey }
  end

  describe "operator >" do
    it { (Gadgeto::TimeOfDay.new("08:01") > Gadgeto::TimeOfDay.new("08:00")).should be_truthy }
    it { (Gadgeto::TimeOfDay.new("08:00") > Gadgeto::TimeOfDay.new("08:01")).should be_falsey }
    it { (Gadgeto::TimeOfDay.new("08:11") > Gadgeto::TimeOfDay.new("08:11")).should be_falsey }
  end

  describe "operator ==" do
    it { (Gadgeto::TimeOfDay.new("08:13") == Gadgeto::TimeOfDay.new("08:13")).should be_truthy }
  end

  describe "till" do

    it { Gadgeto::TimeOfDay.new("00:00").minutes_till(Gadgeto::TimeOfDay.new("00:00")).should == 0 }
    it { Gadgeto::TimeOfDay.new("00:00").minutes_till(Gadgeto::TimeOfDay.new("00:13")).should == 13 }
    it { Gadgeto::TimeOfDay.new("08:15").minutes_till(Gadgeto::TimeOfDay.new("10:00")).should == 105 }

    context "allow overflow" do
      it { Gadgeto::TimeOfDay.new("23:00").minutes_till(Gadgeto::TimeOfDay.new("01:00")).should == 120 }
    end

    context "do not allow overflow" do
      it { expect { Gadgeto::TimeOfDay.new("23:00").minutes_till(Gadgeto::TimeOfDay.new("01:00"), :overflow => false)}.to raise_error }
      it { Gadgeto::TimeOfDay.new("23:00").minutes_till(Gadgeto::TimeOfDay.new("23:15"), :overflow => false).should == 15 }
    end

  end

end
