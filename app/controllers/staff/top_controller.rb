class Staff::TopController < Staff::Base
   # authorizeが継承元Staff::Baseでbefore_actionに登録されているが、それをスキップする
  skip_before_action :authorize

  def index
    # 省略可能。なければ暗黙裏に以下の対応するテンプレートを用いてHTML文章が生成される
    render action: "index"
  end
end
