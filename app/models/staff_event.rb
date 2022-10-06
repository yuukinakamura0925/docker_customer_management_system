class StaffEvent < ApplicationRecord
  self.inheritance_column = nil #特別な意味が失われる、普通のカラムとして使える

  belongs_to :member, class_name: "StaffMember", foreign_key: "staff_member_id"
  alias_attributes :occurred_at, :created_at
end
