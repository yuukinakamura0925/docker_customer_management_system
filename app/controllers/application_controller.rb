class ApplicationController < ActionController::Base
  layout :set_layout
  # 権限不足
  class Forbidden < ActionController::ActionControllerError; end
  # IPアドレスの制限
  class IpAddressRejected < ActionController::ActionControllerError; end

  # module ErrorHandlersを読み込み(本番環境のみで使用するエラー画面の設定モジュール)
  include ErrorHandlers 

  private def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      "customer"
    end
  end
end
