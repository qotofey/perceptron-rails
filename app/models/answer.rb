class Answer < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  # validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  after_create :create_vectors

  def create_vectors
    size = self.all.size - 1

    for i in 0...size do
      self.all[i].vector << 0
      self.all[i].save
    end

    a = self.all[size]
    for i in 0...size do
      a.vector << 0
    end
    a.vector << 1
    a.save
  end

end

=begin
git add .
git commit -am "fix prod"
git push
cap production deploy

=end