module Gadgeto
  module SanitizeFilename

    def sanitize_filename(filename)
      return filename unless filename

      filename.strip.tap do |fn|
        # get only the filename
        fn.gsub! /^.*(\\|\/)/, ''

        fn.gsub! /[^A-Za-z0-9\.\-]/, '_'
      end
    end

  end
end
