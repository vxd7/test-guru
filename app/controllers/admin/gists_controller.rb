class Admin::GistsController < Admin::BaseController
  def index
    @all_gists = Gist.all
  end

  def show; end
end
