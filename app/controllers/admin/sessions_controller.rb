# current_administratorメソッドを利用するためAdmin::Base継承
class Admin::SessionsController < Admin::Base
  def new
    # 管理者のログイン状況を調べる
    if current_administrator
      redirect_to :admin_root
    else 
      # フォームオブジェクトの作成
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create 
    @form = Admin::LoginForm.new(login_form_params)
    if @form.email.present?
      # 大小文字を区別せずにアドレスを照合する書き方、？はプレースホルダーといい、第二引数の値がセットされる、
      administrator = Administrator.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else 
        session[:administrator_id] = administrator.id
        flash.notice = "ログインしました"
        redirect_to :admin_root
      end
    else  
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
  end

  def destroy
    #  セッションオブジェクトから:administrator_idというキーを削除する
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました"
    redirect_to :admin_root
  end

  private

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end
end

