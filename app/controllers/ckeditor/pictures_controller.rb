class Ckeditor::PicturesController < Ckeditor::ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def index
    @pictures = Ckeditor.picture_model.find_all(ckeditor_pictures_scope)
    respond_with(@pictures) 
  end
  
  def create
    @picture = Ckeditor::Picture.new
	  respond_with_asset(@picture)
  end
  
  def destroy
    @picture.destroy
    respond_with(@picture, :location => pictures_path)
  end
  
  protected
  
    def find_asset
      @picture = Ckeditor.picture_model.get!(params[:id])
    end

    def authorize_resource
      model = (@picture || Ckeditor::Picture)
      @authorization_adapter.try(:authorize, params[:action], model)
    end
end
