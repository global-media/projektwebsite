class ImagesController < ApplicationController
  layout 'admin'
  
  def create    
    @image = Image.new({image: params[:image], content_id: content_id, content_type: content_type})
    if @image.save
      render :json => { :files => [{
                                    "name" => @image.image_file_name,
                                    "size" => @image.image_file_size,
                                    "url" => @image.image.url,
                                    "thumbnail_url" => @image.image.url(:thumb),
                                    "delete_url" => delete_url,
                                    "delete_type" => @image.image_content_type
                                  }] }
    else
      render :json => [ {:error => "custom_failure"} ], :status => 404
    end
  end
  
  def destroy
    @image = Image.find(params[:id]).destroy
    redirect_to redirect_url
  end
  
  protected
    
    def parent_controller
      if params[:episode_id]
        'episodes'
      elsif params[:product_id]
        'products'
      end
    end
    
    def content_id
      case parent_controller
      when 'products'; params[:product_id]
      when 'episodes'; params[:episode_id]
      end      
    end
    
    def content_type
      case parent_controller
      when 'products'; 'Product'
      when 'episodes'; 'Episode'
      end
    end
        
    def delete_url
      case parent_controller
      when 'products'; admin_store_product_image_url(id: @image.id)
      when 'episodes'; admin_contents_comic_episode_image_url(id: @image.id)
      end
    end
    
    def redirect_url
      case parent_controller
      when 'products'; edit_admin_store_product_url(id: content_id, anchor: "images")
      when 'episodes'; edit_admin_contents_comic_episode_url(id: content_id, anchor: "images")
      end
    end
end
