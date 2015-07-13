// run on document load so we're sure portlet is present in DOM
$(function (){

// @TODO next 3 lines are separate quick-search.js file, unrelated to below
$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07').clone().prependTo('#topwide').addClass('oldQS');
$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07:not(.oldQS)').remove();
//Quick Search
// @TODO move style out of string
$('.quick-search').prepend('<h3 style="padding-left:30px;">Quick Search</h3><br><br>');

})
