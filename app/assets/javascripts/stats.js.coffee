jQuery ->
	Morris.Line
		element: 'users_chart'
		data: $('#users_chart').data('users')
		xkey: 'created_at'
		ykeys: ['count', 'facebook_count']
		labels: ['New Users (Total)', 'New Facebook-Connected Users']

	Morris.Line
		element: 'reviews_chart'
		data: $('#reviews_chart').data('reviews')
		xkey: 'created_at'
		ykeys: ['count']
		labels: ['New Reviews (Total)']