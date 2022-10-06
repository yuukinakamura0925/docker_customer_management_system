# current_staff_memberメソッドを利用するためStaff::Base継承
class Staff::SessionsController < Staff::Base
   # authorizeが継承元Staff::Baseでbefore_actionに登録されているが、それをスキップする
  skip_before_action :authorize

  # アカウント作成フォーム
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

  # ログイン処理
  def create 
    @form = Staff::LoginForm.new(login_form_params)
    if @form.email.present?
      # 大小文字を区別せずにアドレスを照合する書き方、？はプレースホルダーといい、第二引数の値がセットされる、
      staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        staff_member.events.create!(type: "rejected")
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else 
        session[:staff_member_id] = staff_member.id
        # ログイン時の現在時刻をセッションオブジェクトに記録
        session[:last_access_time] = Time.current
        staff_member.events.create!(type: "logged_in")
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
    if current_staff_member
      current_staff_member.events.create!(type: "logged_out")
    end
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました"
    redirect_to :staff_root
  end

  private 

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end


end
