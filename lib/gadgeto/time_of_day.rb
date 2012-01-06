module Gadgeto
  # A +TimeOfDay+ represents the time of day.
  #
  # Limitation: 24 hours only.
  class TimeOfDay

    class InvalidTimeOfDayFormat < ::Exception # :nodoc:
    end

    class TimeOfDayOutOfRange < ::Exception # :nodoc:
    end

    ONE_HOUR_IN_MINUTES = 60 # :nodoc:
    HOURS_ONE_DAY = 24 # :nodoc:

    attr_reader :hour, :minute

    # Creates a new TimeOfDay object.
    #
    #    TimeOfDay.new("08:00") #=> 08:00
    #    TimeOfDay.new("x8:00") #=> raises InvalidTimeOfDayFormat
    #
    def initialize(time_of_day)
      match = /^([0-2]?\d):([0-5]\d)$/.match(time_of_day)
      raise InvalidTimeOfDayFormat if match.nil?
      @hour = match[1].to_i
      @minute = match[2].to_i
      raise InvalidTimeOfDayFormat if (@hour > HOURS_ONE_DAY) || (@hour == HOURS_ONE_DAY && @minute > 0)
    end

    # Returns the hour component.
    #
    #   t = TimeOfDay.new("08:00") #=> 08:00
    #   t.hour                     #=> 8
    def hour
      @hour
    end

    # Returns the hour component.
    #
    #   t = TimeOfDay.new("08:03") #=> 08:00
    #   t.minute                   #=> 3
    def minute
      @minute
    end

    # Adds the given +minutes+ to +self+.
    #
    #    t = TimeOfDay.new("08:00") #=> 08:00
    #    t.add_minutes(60)          #=> 09:00
    #
    #    t = TimeOfDay.new("23:50") #=> 08:00
    #    t.add_minutes(20)          #=> 00:10
    def add_minutes(minutes)
      new_minutes = @minute + minutes
      hours_to_add = (@minute + minutes) / 60
      new_hour = @hour + hours_to_add

      @hour = new_hour % HOURS_ONE_DAY
      @minute = new_minutes % ONE_HOUR_IN_MINUTES

      self
    end

    # Returns string representing time of day.
    #
    #    TimeOfDay.new("08:00").to_s #=> "08:00"
    def to_s
      "#{hour.to_s.rjust(2, '0')}:#{minute.to_s.rjust(2, '0')}"
    end

    # Returns time of day in minutes.
    #
    #    TimeOfDay.new("02:07") #=> 127
    def to_i
      hour * 60 + minute
    end

    # Returns +true+ if +self+ precedes +other+.
    #
    #    TimeOfDay.new("08:00") < TimeOfDay.new("09:00:) #=> true
    def <(other)
      return true if self.hour < other.hour
      return false if self.hour > other.hour

      self.minute < other.minute
    end

    # Returns +true+ if +self+ follows +other+.
    #
    #    TimeOfDay.new("09:00") < TimeOfDay.new("08:00:) #=> true
    def >(other)
      return true if self.hour > other.hour
      return false if self.hour < other.hour

      self.minute > other.minute
    end

    # Returns true if +self+ is equal to +other+.
    #
    #   TimeOfDay.new("08:00") == TimeOfDay.new("08:00") #=> true
    def ==(other)
      self.hour == other.hour && self.minute == other.minute
    end

    # Returns difference in minutes between +self+ and +other+.
    #
    #    TimeOfDay.new("08:00").minutes_till(TimeOfDay.new("09:00"))                     #=> 60
    #    TimeOfDay.new("23:00").minutes_till(TimeOfDay.new("01:00"))                     #=> 120
    #
    #    TimeOfDay.new("23:00").minutes_till(TimeOfDay.new("01:00"), :overflow => false) #=> raises TimeOfDayOutOfRange
    def minutes_till(other, options = {})
      options[:overflow] = true if options[:overflow].nil?

      if options[:overflow]
        if self > other
          (self.minutes_till(TimeOfDay.new("24:00"))) + other.to_i
        else
          other.to_i - self.to_i
        end
      else
        raise TimeOfDayOutOfRange if self > other
        other.to_i - self.to_i
      end
    end

    # Returns +true+ if +time_of_day+ represents time of day.
    #
    #    TimeOfDay.valid?("08:00") #=> true
    def self.valid?(time_of_day)
      begin
        val = TimeOfDay.new(time_of_day)
        true
      rescue InvalidTimeOfDayFormat, TimeOfDayOutOfRange
        false
      end
    end

    alias :inspect :to_s

  end
end
