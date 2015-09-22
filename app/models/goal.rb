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
  include Commentable

  STATUS = ["not completed", "completed"]
  SHARING = ["Public", "Private"]

  validates :body, :user_id, :status, :sharing, presence: true
  validates :status, inclusion: STATUS
  validates :sharing, inclusion: SHARING
  before_validation :ensure_status_is_set

  belongs_to :user



  private
  def ensure_status_is_set
    self.status ||= "not completed"
  end
end
