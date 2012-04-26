module GamesHelper

	def platform_links_list(game = @game)
		if game && game.platforms
			game.platforms.order('name ASC').collect {|t| link_to(t.name, games_path(platform: t.name), title: "See all games available for #{t.name}") }.join(" // ").html_safe
		end
	end

	def subject_links_list(game = @game)
		if game && game.subjects
			game.subjects.order('name ASC').collect {|t| link_to(t.name, games_path(subject: t.name), title: "See all games that deal with #{t.name}") }.join(" // ").html_safe
		end
	end

	def random_screenshot_image(game = @game)
  	if (c = game.screenshots.count) != 0
      game.screenshots.find(:first, :offset =>rand(c)).image
    else
    	game.boxart
    end
	end
end