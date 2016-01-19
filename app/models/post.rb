class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
	scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

	attr_accessor :featured

	after_save :save_featured, if: :featured

	def save_featured
			filename = featured.original_filename
			folder = "public/posts/#{id}/featured"

			FileUtils::mkdir_p folder

			f = File.open File.join(folder, filename), 'wb'
			f.write featured.read()
			f.close

			self.featured = nil
			update image_filename: filename

	end






	def next
		Post.next(self.id).first
	end
	def previous
		Post.previous(self.id).first
	end


end
