class StaffMember < ApplicationRecord
include StringNormalizer

  has_many :events, class_name: "StaffEvent", dependent: :destroy

  #バリデーションの直前に実行されるコールバック（正規化によってひらがな入力をカタカナに変換する処理している）
  before_validation do
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
  end

  # 1個以上のカタカナ文字列にマッチする正規表現。\p{katakana}は任意のカタカナ1文字にマッチ。\u{30fc}は長音符1文字にマッチ
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    # suspendedがfalse かつ 入社日が今日以前 かつ （退社日が空 または 退社日が今日以降）
    !suspended? && start_date <= Date.today &&
    (end_date.nil? || end_date > Date.today)
  end
end
