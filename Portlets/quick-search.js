// run on document load so we're sure portlet is present in DOM
$(function (){

// ensure Quick Search is first portal by copying to top & removing old one
$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07').clone().prependTo('#topwide').addClass('oldQS')
$('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07:not(.oldQS)').remove()
$('.quick-search').prepend('<h3>Quick Search</h3><br><br>')

// placeholder in search box rather than just title attribute
if (!$('#ppsp_q').attr('placeholder')) {
    $('#ppsp_q').attr('placeholder', 'Search for an item...')
}

})
