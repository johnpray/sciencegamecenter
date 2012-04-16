module GamesHelper

	def platform_links_list(game = @game)
		game.platforms.collect {|t| link_to(t.name, games_path(platform: t.name)) }.join(", ").html_safe
	end

	def subject_links_list(game = @game)
		game.subjects.collect {|t| link_to(t.name, games_path(subject: t.name)) }.join(", ").html_safe
	end
end