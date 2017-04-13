// linkify any plain text URLs in the mods/accessCondition section
// dd.rights is the wrapper HTML tag
var $el = $('.rights')
var re = /(https:\/\/creativecommons\.org\/licenses\/by-nc\/4\.0\/) \./i
var html = $el.html().replace(re, '<a rel="license" href="$1">$1</a>.')
$el.html(html)
