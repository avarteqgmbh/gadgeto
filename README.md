Gadgeto
=======

[![Build Status](https://secure.travis-ci.org/avarteqgmbh/gadgeto.png)](http://travis-ci.org/avarteqgmbh/gadgeto)
[![Dependency Status](https://gemnasium.com/avarteqgmbh/gadgeto.png)](https://gemnasium.com/avarteqgmbh/gadgeto)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/avarteqgmbh/gadgeto)

Collection of ruby code snippets.

## Usage

All functionality is loaded issuing:

``` ruby
require 'gadgeto/all'
```

If you plan to use only a handful of snippets, it is recommended to require
explicitly each snippet:

``` ruby
require 'gadgeto/<snippet>'
```

For example:

``` ruby
require 'gadgeto/dslable' # loads Gadgeto::Dslable
```

## Overview

**Gadgeto::Domain**

``` ruby
require 'gadgeto/domain'

Gadgeto::Domain.valid?("de")         #=> true
Gadgeto::Domain.valid?("test.de")    #=> true
Gadgeto::Domain.valid?("-.test.de")  #=> false

domain = Gadgeto::Domain.new("m.test.de")
domain.third_level_domain?           #=> true
```

**Gadgeto::Dslable**

``` ruby
require 'gadgeto/dslable'

class Foo
  include Gadgeto::Dslable
  include Gadgeto::Dslable::Display

  dslable_method :item, :key, '*arguments'

  def inspect
    attributes[:key]
  end
end

f = Foo.new

f.draw do
  item 'home', :baem => :bum do
    item 'terms'
    item 'imprint'
  end

  item 'products' do
    item 'kitchen' do
      item 'forks'
    end
  end
end

f.display :items
f.items[0].attributes[:key] #=> "home"
```

**Gadgeto::Email**

``` ruby
require 'gadgeto/email'

Gadgeto::Email.valid?("user@example.com")      #=> true
Gadgeto::Email.valid?("user+name@example.com") #=> true
```

**Gadgeto::SanitizeFilename (Module)**

``` ruby
require 'gadgeto/sanitize_filename'

obj = Object.new
obj.extend(Gadgeto::SanitizeFilename)
obj.sanitize_filename("foo bar.zip") #=> "foo_bar.zip"
```

**Gadgeto::TimeOfDay**

``` ruby
require 'gadgeto/time_of_day'

Gadgeto::TimeOfDay.valid?("09:15")   #=> true

t = Gadgeto::TimeOfDay.new("08:30")  #=> 08:30
t.hour                               #=> 8
t.minute                             #=> 30
t.to_i                               #=> 480
t.add_minutes(30)                    #=> 09:00

t1 = Gadgeto::TimeOfDay.new("08:30") #=> 08:30
t2 = Gadgeto::TimeOfDay.new("09:30") #=> 09:30
t1 < t2                              #=> true
t1 > t2                              #=> false
t1.minutes_till(t2)                  #=> 60
t1 == t2                             #=> false
```

**Gadgeto::VideoUrl**

``` ruby
require 'gadgeto/video_url'

Gadgeto::VideoUrl.valid?("http://vimeo.com/11384488") #=> true
Gadgeto::VideoUrl.supported_services                  #=> [:youtube, :vimeo]

video_url = Gadgeto::VideoUrl.new('http://www.youtube.com/watch?v=0zM3nApSvMg')
video_url.valid?  #=> true
video_url.service #=> :youtube
video_url.id      #=> "0zM3nApSvMg"
```

## Contributors

See https://github.com/avarteqgmbh/gadgeto/contributors
