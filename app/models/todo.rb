class Todo < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "created_by"
  has_many :items, dependent: :destroy
  validates_presence_of :title, :created_by
end
