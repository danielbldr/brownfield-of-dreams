class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    @tutorial_videos = @facade.videos.paginate(page: params[:page], per_page: 5)
    @tutorial = Tutorial.last
  end
end
