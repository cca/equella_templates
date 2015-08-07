// run on document load so we're sure portlet is present in DOM
$(function (){

$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07').clone().prependTo('#topwide').addClass('oldQS');
$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07:not(.oldQS)').remove();
$('.quick-search').prepend('<h3>Quick Search</h3><br><br>');

})
