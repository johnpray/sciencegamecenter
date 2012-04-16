module ReviewsHelper

	def progress_color(rating = 0)
		if rating.nil?
			""
		elsif rating >= 4
			"progress-success"
		elsif rating >= 3
			"progress-info"
		elsif rating >= 2
			"progress-warning"
		elsif rating < 2
			"progress-danger"
		end
	end
			
end