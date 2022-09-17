class Admin::StaffMembersController < Admin::Base
  def index
    # ふりがなを:family_name_kana（姓）, :given_name_kana（名）の順でソートして全て取得
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end
end
