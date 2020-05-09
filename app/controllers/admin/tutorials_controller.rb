class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(tutorial_params)
    if tutorial.save
      if params['tutorial']['playlist_id'] != ""
        conn = Faraday.new(url: 'https://www.googleapis.com/') do |faraday|
          faraday.params[:part] = 'snippet'
          faraday.params[:key] = ENV['YOUTUBE_API_KEY']
        end

        part = 'snippet'
        key = ENV['YOUTUBE_API_KEY']
        playlist_id = params['tutorial']['playlist_id']

        response = conn.get("/youtube/v3/playlistItems?part=#{part}&playlistId=#{playlist_id}&key=#{key}")

        json = JSON.parse(response.body, symbolize_names: true)

        videos = json[:items]

        videos.each do |video|
          tutorial.videos.create(title: video[:snippet][:title],
                                 description: video[:snippet][:description],
                                 video_id: video[:id],
                                 thumbnail: video[:snippet][:thumbnails][:standard][:url],
                                 position: video[:snippet][:position])
        end
      end

      flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here', tutorial_path(tutorial.id))}.".html_safe
      redirect_to admin_dashboard_path
    else
      flash[:error] = tutorial.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list,
                                     :title,
                                     :description,
                                     :thumbnail,)
  end
end
