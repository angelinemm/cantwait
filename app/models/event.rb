class Event < ActiveRecord::Base
	belongs_to :user

	validates :description, presence: true, length: {maximum: 255}
	validates :date, presence: true

	before_save :clean

	def clean
		self.description = self.description.strip
		self.url = self.url.strip if self.url
		self.details = self.details.strip if self.details
	end

	def self.futur
    	where('date >= ?', Time.now).order('date')
	end

	def self.past
    	where('date < ?', Time.now).order('date desc')
	end
end
