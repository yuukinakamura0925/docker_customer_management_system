class StaffMember < ApplicationRecord
  has_many :events, class_name: "StaffEvent", depended: :destroy
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    # suspendedがfalse かつ 入社日が今日以前 かつ （退社日が空 または 退社日が今日以降）
    !suspended? && start_date <= Date.today &&
    (end_date.nil? || end_date > Date.today)
  end
end
