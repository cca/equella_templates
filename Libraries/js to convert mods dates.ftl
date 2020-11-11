<script>
(function($) {
// JS to convert MODS dates
// hash for converting month number to name
var months = ["January"
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
function dateFormat (text) {
	// text is YYYY-MM-DD date like "2015-02-22"
	// we cannot use Intl.DateTimeFormat because date is sometimes incomplete
	// be careful that day and/or month could be null/missing
	var dates = text.split('-')
	var year = dates[0]
	var month_num = parseInt(dates[1], 10)
	var month = month_num && months[month_num - 1]
	var day = parseInt(dates[2], 10)

	// we assume we have at least a year
	if (day && month) {
		return month + ' ' + day + ', ' + year
	} else if (month) {
		return month + ', ' + year
	} else {
		return year
	}
}
// run on each date
$('.js-date').each((i, el) => $(el).text(dateFormat($(el).text())))

// testing (uncomment & run):
// dateFormat('2020-05-09') === 'May 9, 2020'; dateFormat('2020-05') === 'May, 2020'; dateFormat('2020') === '2020';
})(jQuery)
</script>
