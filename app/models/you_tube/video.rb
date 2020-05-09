module YouTube
  class Video
    attr_reader :thumbnail

    def initialize(data = {})
      return if data[:items].empty?

      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
    end

    def self.by_id(id)
      new(YoutubeService.new.video_info(id))
    end
  end
end
