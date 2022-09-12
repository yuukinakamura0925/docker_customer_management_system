class ApplicationRecord < ActiveRecord::Base
  # 抽象クラスという宣言
  self.abstract_class = true
end
