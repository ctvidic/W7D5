# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#
class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: true 
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password 
    
    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        user && user.is_password?(password) ? user : nil  
    end 

    def is_password?(password)
        obj = BCrypt::Password.new(self.password_digest)
        obj.is_password?(password)
    end 

    def self.generate_session_token
        SecureRandom.urlsafe_base64
    end 

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end 

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end 

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end
    
    has_many :subs_moderated,
        class_name: 'Sub',
        foreign_key: :moderator_id,
        primary_key: :id

    has_many :posts,
        class_name: 'Post',
        foreign_key: :author_id,
        primary_key: :id
end 
