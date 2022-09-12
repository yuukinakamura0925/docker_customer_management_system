class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
    #  パスワードの有無
     @staff_member.hashed_password &&
    #  開始日が今日以前
     @staff_member.start_date <= Date.today &&
    #  終了日が設定されていないか今日より後か
     (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
    #  パスワードが正しいかハッシュ関数で計算しハッシュ値が一緒かどうか
     BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end
