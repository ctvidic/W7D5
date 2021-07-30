# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#
class Sub < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :description, :moderator_id, presence: true
    
    belongs_to :moderator,
        class_name: 'User',
        foreign_key: :moderator_id,
        primary_key: :id

    has_many :posts,
        class_name: 'Post',
        foreign_key: :sub_id,
        primary_key: :id

end
