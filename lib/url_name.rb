module UrlName
  ALLOWED_NAME_CHARACTERS = 'A-Za-z0-9\-'
  SEPARATOR = '_'
  
  module ClassMethods
    def normalize_name(name)
      replacement_for_spaces = '-'
      normal = name.gsub(Regexp.new("[^#{ALLOWED_NAME_CHARACTERS} &]"),'') 
      normal = normal.strip.downcase                       
      normal = normal.gsub(/[\s]/, replacement_for_spaces)
      normal = normal.gsub(/&/, 'and')
      normal = normal.gsub(Regexp.new("#{replacement_for_spaces}{2,}"), replacement_for_spaces) 
      normal
    end
    
    def get_identifier(url_name)
      url_name.split(SEPARATOR).first
    end
  end
  
  def self.included(receiver)
    receiver.extend ClassMethods
  end
end