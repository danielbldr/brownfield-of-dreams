class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def get_playlist_videos(playlist_id)
    params = { part: 'snippet', playlistId: playlist_id }
    json = get_json('youtube/v3/playlistItems', params)
    json_items = json[:items]
    if json[:nextPageToken]
      params = { part: 'snippet',
                 playlistId: playlist_id,
                 pageToken: json[:nextPageToken] }
      json_items << get_json('youtube/v3/playlistItems', params)[:items]
    end
    json_items.flatten
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
      f.params[:maxResults] = 50
    end
  end
end
