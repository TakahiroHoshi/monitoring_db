module ApplicationHelper
  def admin_user
    redirect_to startsearch_path unless current_user.admin?
  end

	def as_observer
		redirect_to startsearch_path if current_user.observer?
	end
end
