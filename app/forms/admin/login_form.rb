class Admin::LoginForm
# form_withのmodelオプションに指定できる
include ActiveModel::Model

# フォームのフィールド名  
attr_accessor :email, :password
end
