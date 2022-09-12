class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    @administrator &&
    #  パスワードの有無
     @administrator.hashed_password &&
    #  パスワードが正しいかハッシュ関数で計算しハッシュ値が一緒かどうか
     BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end
