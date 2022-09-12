class Admin::Base < ApplicationController
  private def current_administrator
    if session[:administrator_id]
      # ||= 自己代入。右辺がnilまたはfalseであれば代入
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
    end
  end
  # application_helper.rbに記述しているのと同じ効果になる（erbで使える）
  helper_method :current_administrator
end
