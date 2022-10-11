# 日本語特有の各種変換機能を提供
require "nkf"

module StringNormalizer
  extend ActiveSupport::Concern

  # 文字列に含まれる全角の英数字と記号を半角に変更し、全角スペースを半角スペースに変換いし、先頭と末尾の空白を空白を除去している
  def normalize_as_email(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  def normalize_as_name(text)
    # 第一引数にフラグ文字、第二引数に変換対象の文字列をとり、変換後の文字列を返すのが、NKFモジュール
    NKF.nkf("-W -w -Z1", text).strip if text
    # ーW 入力の文字コードがUTF-8であることを指定
    # -w UTF-8で出力する
    # -Z1 全角の英数字、記号、全角スペースを半角に変換する
    # --katakana ひらがなをカタカナに変換する
    # stripは文字列の先頭と末尾の空白文字を除去する
  end

  def normalize_as_furigana(text)
    NKF.nkf("-W -w -Z1 --katakana", text).strip if text
  end

  # def normalize_as_postal_code(text)
  #   NKF.nkf("-W -w -Z1", text).strip.gsub(/-/, "") if text
  # end

  # def normalize_as_phone_number(text)
  #   NKF.nkf("-W -w -Z1", text).strip if text
  # end
end
