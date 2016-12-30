module GamesHelper

	def platform_links_list(game = @game)
		if game && game.platforms
			game.platforms.sort_by { |name| GAME_PLATFORMS.index(name) rescue -1 }.collect {|t| link_to(t.name, games_path(platform: t.name), title: "See all games available for #{t.name}") }.join(" // ").html_safe
		end
	end

	def subject_links_list(game = @game)
		if game && game.subjects
			game.subjects.sort_by { |name| GAME_SUBJECTS.index(name) rescue -1 }.collect {|t| link_to(t.name, games_path(subject: t.name), title: "See all games that deal with #{t.name}") }.join(" // ").html_safe
		end
	end

	def intended_for_links_list(game = @game)
		if game && game.intended_fors
			game.intended_fors.sort_by { |name| GAME_INTENDED_FORS.index(name) rescue -1 }.collect {|t| link_to(t.name, games_path(intended_for: t.name), title: "See all games intended for #{t.name}") }.join(" // ").html_safe
		end
	end

	def developer_type_links_list(game = @game)
		if game && game.developer_types
			game.developer_types.sort_by { |name| GAME_DEVELOPER_TYPES.index(name) rescue -1 }.collect {|t| link_to(t.name, games_path(developer_type: t.name), title: "See all games by a #{t.name}") }.join(" // ").html_safe
		end
	end

	def cost_links_list(game = @game)
		if game && game.costs
			game.costs.sort_by { |name| GAME_COSTS.index(name) rescue -1 }.collect {|t| link_to(t.name, games_path(cost: t.name), title: "See all #{t.name} games") }.join(" // ").html_safe
		end
	end

	def random_screenshot_image(game = @game)
		if (c = game.screenshots.count) != 0
      game.screenshots.find(:first, :offset =>rand(c)).image
    else
    	game.boxart
		end
	end

	def youtube_embed_iframe(url)
		if url.present?
			url_params = Rack::Utils.parse_nested_query(url.split('?').last)
	    youtube_id = url_params["v"]
	    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameBorder: 0)
		end
	end
end
