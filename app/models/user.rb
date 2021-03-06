class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_secure_password
	validates :name, presence: true, length: { maximum: 30 }
	validates :email, format: { with: /\A[^@]+@[^@]+\z/ }, uniqueness: true
	before_save { self.email = email.downcase }
  before_save { self.session_token ||= Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s) }
  #self.per_page = 10
  paginates_per 10
end
