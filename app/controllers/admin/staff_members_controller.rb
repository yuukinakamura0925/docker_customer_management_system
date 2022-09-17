class Admin::StaffMembersController < Admin::Base
  def index
    # ふりがなを:family_name_kana（姓）, :given_name_kana（名）の順でソートして全て取得
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [:edit, :admin, staff_member]
  end

  def new 
    @staff_member = StaffMember.new
  end

  def edit 
    @staff_member = StaffMember.find(params[:id])
  end
end
