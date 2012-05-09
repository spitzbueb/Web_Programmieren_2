class Product < ActiveRecord::Base
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	
	validates :title, :description, :image_url,presence:true
	validates :price,numericality:{greater_than_or_equal_to:0.05}
	validates :title,uniqueness:true
	validates :image_url,allow_blank:true,format:{
		with: %r{\.(gif|png|jpg)$}i, message:'must be an URL for GIF, JPG or PNG'
		}
	private
	#Keine Line-Items referenzieren das Produkt
	def ensure_not_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
