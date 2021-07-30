# == Schema Information
#
# Table name: posts
#
#  id        :integer          not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  sub_id    :integer          not null
#  author_id :integer          not null
#
class Post < ApplicationRecord
    validates :title, :sub_id, :author_id, presence: true

    belongs_to :sub,
        class_name: 'Sub',
        foreign_key: :sub_id,
        primary_key: :id

     belongs_to :author,
        class_name: 'User',
        foreign_key: :author_id,
        primary_key: :id


end
