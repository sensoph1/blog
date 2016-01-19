class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
	scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

	mount_uploader :featured, FeaturedUploader



	def next
		Post.next(self.id).first
	end
	def previous
		Post.previous(self.id).first
	end


end
