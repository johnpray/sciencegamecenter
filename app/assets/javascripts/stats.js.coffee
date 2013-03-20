jQuery ->
	if $('#users_chart').length
		Morris.Line
			element: 'users_chart'
			data: $('#users_chart').data('users')
			xkey: 'created_at'
			ykeys: ['count', 'facebook_count']
			labels: ['Users (Total)', 'Facebook Signup Users']

	if $('#reviews_chart').length
		Morris.Line
			element: 'reviews_chart'
			data: $('#reviews_chart').data('reviews')
			xkey: 'created_at'
			ykeys: ['count']
			labels: ['Reviews (Total)'],
			lineColors: ['#51a351']

	if $('#games_chart').length
		Morris.Line
			element: 'games_chart'
			data: $('#games_chart').data('games')
			xkey: 'created_at'
			ykeys: ['enabled_count', 'disabled_count']
			labels: ['Published Games', 'Pending/Disabled Games'],
			lineColors: ['#2f96b4', '#c09853']