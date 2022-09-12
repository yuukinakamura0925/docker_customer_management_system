class Staff::TopController < Staff::Base
  def index
    # 省略可能。なければ暗黙裏に以下の対応するテンプレートを用いてHTML文章が生成される
    render action: "index"
  end
end
