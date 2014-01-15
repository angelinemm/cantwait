class Event < ActiveRecord::Base
	belongs_to :user

	validates :description, presence: true, length: {maximum: 255}
	validates :date, presence: true

	def self.futur
    	where('date >= ?', Time.now).order('date')
	end

	def self.past
    	where('date < ?', Time.now).order('date desc')
	end
end
