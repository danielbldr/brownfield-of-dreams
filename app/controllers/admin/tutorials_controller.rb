class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(tutorial_params)
    if tutorial.save && playlist_id != ''
      videos = YoutubeService.new.get_playlist_videos(playlist_id)
      tutorial.create_videos(videos)
      tutorial_created_with_playlist(tutorial)
    elsif tutorial.save
      tutorial_created(tutorial)
    else
      tutorial_not_created(tutorial)
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
                                     :thumbnail)
  end

  def playlist_id
    params['tutorial']['playlist_id']
  end

  def tutorial_created_with_playlist(tutorial)
    flash[:success] = "Successfully created tutorial.
                      #{view_context.link_to('View it here',
                                             tutorial_path(tutorial.id))}."
    redirect_to admin_dashboard_path
  end

  def tutorial_created(tutorial)
    flash[:success] = 'Successfully created tutorial.'
    redirect_to tutorial_path(tutorial.id)
  end

  def tutorial_not_created(tutorial)
    flash[:error] = tutorial.errors.full_messages.to_sentence
    redirect_back(fallback_location: root_path)
  end
end
