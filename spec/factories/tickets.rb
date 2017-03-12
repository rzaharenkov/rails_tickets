# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  status      :integer          default("new")
#  reporter_id :integer
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :ticket do
    title "MyString"
    description "MyString"
    status "MyString"
  end
end
