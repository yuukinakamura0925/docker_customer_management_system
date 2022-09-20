# current_staff_memberメソッドを利用するためStaff::Base継承
class Staff::SessionsController < Staff::Base
  def new
    # ユーザーのログイン状況を調べる
    if current_staff_member
      redirect_to :staff_root
    else 
      # フォームオブジェクトの作成
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create 
    @form = Staff::LoginForm.new(login_form_params)
    if @form.email.present?
      # 大小文字を区別せずにアドレスを照合する書き方、？はプレースホルダーといい、第二引数の値がセットされる、
      staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else 
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログインしました"
        redirect_to :staff_root
      end
    else  
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
  end

  def destroy
    #  セッションオブジェクトから:staff_member_idというキーを削除する
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました"
    redirect_to :staff_root
  end

  private 

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end


end
