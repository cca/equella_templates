// server-side JS
// not used—how do I pass values from this to client-side portlet?

// parameters are:
// query — free text query
// where — xpath/SQL clause
// onlyLive — boolean for whether to only return live items
// orderType — 0: Ranking, 1: Date Modified, 2: Name
// reverse — boolean for reverse order
// offset — first result index
// maxResults — integer number of results to get

// min exclusive, max inclusive
var rand = function (min, max) {
    return Math.round(Math.random() * max + min)
}
var order = rand(0, 2)
var reverse = !!(rand(0, 1))
var offset = rand(0, 10)
var results = utils.searchAdvanced('', "/xml/local/rating like 'High'", true, order, reverse, offset, 40)
