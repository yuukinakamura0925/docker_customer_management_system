class Staff::Base < ApplicationController
  before_action :authorize
   private 
   
   def current_staff_member
    
    if session[:staff_member_id]
      # ||= 自己代入。右辺がnilまたはfalseであれば代入
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
    end
  end
  # application_helper.rbに記述しているのと同じ効果になる（erbで使える）
  helper_method :current_staff_member

  def authorize
    unless current_staff_member
      flash.alert = "職員としてログインしてください"
      redirect_to :staff_login
    end
  end
end
