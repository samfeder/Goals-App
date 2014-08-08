class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  after_initialize :ensure_classification

  belongs_to :user

  scope :public_goal, -> { where(public: true) }

  private

  def ensure_classification
    self.public == true if self.public.nil?
  end
end
