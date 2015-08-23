module ApplicationHelper
  include Rack::Recaptcha::Helpers

  protected
  
    def default_options(options)
      options[:max] ||= 5
      options[:class] ||= "col-md-15 col-sm-6"
      options
    end
end
