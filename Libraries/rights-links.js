// linkify any plain text URLs in the mods/accessCondition section
// dd.rights is the wrapper HTML tag
var $el = $('.rights')
var html = $el.html().replace(/(https?:\/\/[-\w\./]+)\./g, "<a href='$1'>$1</a>.")
$el.html(html)
