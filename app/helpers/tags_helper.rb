module TagsHelper
  def tag_status_options
    Tag::STATUSES.collect {|k,v| [v, k]}
  end
end
