// put under "Client-side on-ready script" in the portal admin

var alignImages = function ($el) {
    // make studentWork a bit shorter
    var height = $el.attr('id') == 'studentWork' ? 90 : 130
    $el.justifiedGallery({
        rowHeight: height
    });
}

var handleTabClick = function (event) {
    $el = $(this)
    // cache jQuery lookups
    $target = $($el.data('target'))
    $current = $($('.mainTab.active').data('target'))

    // is selected gallery already visible? do nothing
    if ($target.is(':visible')) {
        return
    } else {
        // hide active gallery, remove active class from past tab
        $current.hide()
        $('.mainTab.active').removeClass('active')
        // show new gallery, add active class to clicked tab
        $target.show()
        $el.addClass('active')
        alignImages($target)
    }
}

alignImages($('#studentWork'))
$('.mainTab').click(handleTabClick)
