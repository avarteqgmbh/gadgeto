module Gadgeto
  class VideoUrl

    YOUTUBE_REGEXP = /^.*((youtu.be\/)|(v\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/i
    VIMEO_REGEXP = /http:\/\/(www\.)?vimeo.com\/(.*\/)?(\w*#)?(\d+)($|\/)/i

    YOUTUBE_EMBEDDED_TEMPLATE = 'http://www.youtube.com/embed/%s?wmode=transparent&autoplay=%s'
    VIMEO_EMBEDDED_TEMPLATE = 'http://player.vimeo.com/video/%s?title=0&amp;byline=0&amp;portrait=0&autoplay=%s'

    SUPPORTED_SERVICE_TYPES = [:youtube, :vimeo]

    attr_accessor :url

    # Return a new instance with the given URL
    #
    # === Parameters
    # <tt>url</tt> - URL of the video
    def initialize(url)
      @url = url
    end

    # Set the own media type.
    def service
      case self.url
        when YOUTUBE_REGEXP then :youtube
        when VIMEO_REGEXP then :vimeo
        else nil
      end
    end

    # Returns the own video service id
    def id
      case self.service
        when :youtube then parse_video_id_for_youtube
        when :vimeo then parse_video_id_for_vimeo
      end
    end

    # Returns the URL for this video embedded
    #
    # === Parameters
    # * <tt>options</tt> - Configuration for the embedded URL.
    #
    # === Options
    # * <tt>:autoplay</tt> - Autoplay on or off (default on)
    def embedded(options={})
      autoplay = options[:autoplay].nil? ? true : options[:autoplay]
      autoplay = !!autoplay ? '1' : '0'
      embeded_template = case self.service
                         when :youtube then YOUTUBE_EMBEDDED_TEMPLATE
                         when :vimeo then VIMEO_EMBEDDED_TEMPLATE
                         end
      return embeded_template % [self.id, autoplay]
    end

    # Returns true if the URL is valid
    def valid?
      VideoUrl.valid?(self.url)
    end

    # Returns all supported service types as array of symbols
    def self.supported_video_types
      return SUPPORTED_SERVICE_TYPES
    end

    # Returns true if the URL is valid
    #
    # === Parameters
    # <tt>url</tt> - URL to validate
    def self.valid?(url)
      !!url.match(/(#{YOUTUBE_REGEXP})|(#{VIMEO_REGEXP})/)
    end

    private

    # Set video_id for a given regexp and index of match result
    def parse_video_id_for_regexp_and_index(regexp, index)
      match_result = self.url.match(regexp)
      return match_result[index] if !!match_result
    end

    # Parse the youtube video_id and set it in self
    def parse_video_id_for_youtube
      parse_video_id_for_regexp_and_index(YOUTUBE_REGEXP, 6)
    end

    # Parse the vimeo video_id and set it in self
    def parse_video_id_for_vimeo
      parse_video_id_for_regexp_and_index(VIMEO_REGEXP, 4)
    end
  end
end
