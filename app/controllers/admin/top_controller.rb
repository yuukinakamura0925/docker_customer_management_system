class Admin::TopController < Admin::Base
  # authorizeが継承元Admin::Baseでbefore_actionに登録されているが、それをスキップする
  skip_before_action :authorize

   def index
    # 省略可能。なければ暗黙裏に以下の対応するテンプレートを用いてHTML文章が生成される
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end

   end
end
