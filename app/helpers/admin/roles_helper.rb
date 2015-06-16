module Admin::RolesHelper
  def role_options
    [['No Role', nil]] + Role.all.order(:id).collect {|r| [r.name, r.id]}
  end
end
