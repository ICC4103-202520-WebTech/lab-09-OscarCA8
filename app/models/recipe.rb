class Recipe < ApplicationRecord
    belongs_to :user
    has_rich_text :instructions
    validates :title, presence: true
    validates :cook_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :difficulty, presence: true, inclusion: { in: %w[Easy Medium Hard] }
    validates :instructions, presence: true
end
