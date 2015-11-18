<script>
(function($) {
// JS to convert MODS dates
// hash for converting number to name
// put null first so array is essentially indexed from 1
var months = [null
	, "January"
	, "February"
	, "March"
	, "April"
	, "May"
	, "June"
	, "July"
	, "August"
	, "September"
	, "October"
	, "November"
	, "December"
]
// run on each date
$('.js-date').each(function(i, el) {
	// text is like "2015-02-22"
	// wish we could use Intl.DateTimeFormat but sometimes we're missing the day
	// which means we can't make a complete JavaScript Date object
	var dates = $(el).text().split('-')
	var year = dates[0]
	var month_num = parseInt(dates[1], 10)
	// below guarding against any piece being missing
	var month = months[month_num]
	var day = dates[2]
	var formattedDate = ''

	// we assume we have at least a year
	if (day && month) {
		formattedDate = month + ' ' + day + ', ' + year
	} else if (month) {
		formattedDate = month + ', ' + year
	} else {
		formattedDate = year
	}

	$(el).text(formattedDate)
})

})(jQuery)
</script>
