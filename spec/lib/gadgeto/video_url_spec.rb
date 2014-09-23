require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../../lib/gadgeto/video_url')

YOUTUBE_LINKS = [ 'http://www.youtube.com/v/0zM3nApSvMg?fs=1&amp;hl=en_US&amp;rel=0',
                  'http://www.youtube.com/embed/0zM3nApSvMg?rel=0',
                  'http://www.youtube.com/watch?v=0zM3nApSvMg&feature=feedrec_grec_index',
                  'http://www.youtube.com/watch?v=0zM3nApSvMg',
                  'http://youtu.be/0zM3nApSvMg',
                  'http://www.youtube.com/watch?v=0zM3nApSvMg#t=0m10s' ]

VIMEO_LINKS = [ 'http://vimeo.com/channels/hd#11384488',
                'http://vimeo.com/groups/brooklynbands/videos/11384488',
                'http://vimeo.com/staffpicks#11384488',
                'http://vimeo.com/11384488' ]

describe Gadgeto::VideoUrl do

  describe 'instance methods' do
    let(:youtube_video_url){ Gadgeto::VideoUrl.new('http://www.youtube.com/embed/0zM3nApSvMg?rel=0') }
    let(:vimeo_video_url){ Gadgeto::VideoUrl.new('http://vimeo.com/11384488') }

    describe '#id' do
      it 'should return the youtube video-id for a youtube video url' do
        youtube_video_url.id.should eq('0zM3nApSvMg')
      end

      it 'should return the vimeo video-id for a vimeo video url' do
        vimeo_video_url.id.should eq('11384488')
      end
    end

    describe '#service' do
      it 'should return "youtube" for a youtube video url' do
        youtube_video_url.service.should eq(:youtube)
      end

      it 'should return "vimeo" for a vimeo video url' do
        vimeo_video_url.service.should eq(:vimeo)
      end
    end

    describe '#embedded' do
      it 'should return the url for embedded video for youtube with autplay true default' do
        youtube_video_url.embedded.should eq('http://www.youtube.com/embed/0zM3nApSvMg?wmode=transparent&autoplay=1')
      end

      it 'should return the url for embedded video for youtube with autoplay false if set' do
        youtube_video_url.embedded(:autoplay => false).should eq('http://www.youtube.com/embed/0zM3nApSvMg?wmode=transparent&autoplay=0')
      end

      it 'should return the url for embedded video for vimeo with autoplay true default' do
        vimeo_video_url.embedded.should eq('http://player.vimeo.com/video/11384488?title=0&amp;byline=0&amp;portrait=0&autoplay=1')
      end

      it 'should return the url for embedded video for vimeo with autoplay false if set' do
        vimeo_video_url.embedded(:autoplay => false).should eq('http://player.vimeo.com/video/11384488?title=0&amp;byline=0&amp;portrait=0&autoplay=0')
      end
    end

    describe '#valid?' do
      it 'should return true for a valid youtube url' do
        YOUTUBE_LINKS.each do |youtube_url|
          Gadgeto::VideoUrl.new(youtube_url).should be_valid
        end
      end

      it 'should return true for a valid vimeo url' do
        VIMEO_LINKS.each do |vimeo_url|
          Gadgeto::VideoUrl.new(vimeo_url).should be_valid
        end
      end

      it 'should return false for a unsupported url' do
        Gadgeto::VideoUrl.new('http://www.imnotthaaatvalid.de/7777as882128as').should_not be_valid
      end
    end
  end

  describe 'class methods' do

    describe '#valid?' do
      it 'should return true for a valid youtube url' do
        YOUTUBE_LINKS.each do |youtube_url|
          expect(Gadgeto::VideoUrl.valid?(youtube_url)).to be_truthy
        end
      end

      it 'should return true for a valid vimeo url' do
        VIMEO_LINKS.each do |vimeo_url|
          expect(Gadgeto::VideoUrl.valid?(vimeo_url)).to be_truthy
        end
      end

      it 'should return false for a unsupported url' do
        expect(Gadgeto::VideoUrl.valid?('http://www.imnotthaaatvalid.de/7777as882128as')).to be_falsey
      end
    end

    describe '#supported_services' do
      it 'should return the supported service types' do
        Gadgeto::VideoUrl.supported_services.should eq([:youtube, :vimeo])
      end
    end
  end
end
