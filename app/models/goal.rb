# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  status     :string           not null
#  sharing    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :body, :user_id, :status, :sharing, presence: true
  STATUS = ["not completed", "completed"]
  SHARING = ["Public", "Private"]
  validates :status, inclusion: STATUS
  validates :sharing, inclusion: SHARING
  belongs_to :user






end
