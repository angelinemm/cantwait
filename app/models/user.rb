class User < ActiveRecord::Base
	has_many :events, dependent: :destroy

	validates :username, presence: true, length: {maximum: 50}, uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: {minimum: 6, maximum: 20}

	before_save :clean
	before_create :create_remember_token

	def clean
		self.email = self.email.downcase.strip
		self.username = self.username.downcase.strip
    end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def send_password_reset
		self.update_attribute(:password_reset_token, User.encrypt(User.new_token))
		self.update_attribute(:password_reset_sent_at, Time.zone.now)
		UserMailer.password_reset(self).deliver
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_token)
		end
end
