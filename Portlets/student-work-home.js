// put under "Client-side on-ready script" in the portal admin

var alignImages = function ($el) {
    // make studentWork a bit shorter
    var height = $el.attr('id') == 'studentWork' ? 90 : 130
    $el.justifiedGallery({
        rowHeight: height
    });
}

var handleTabClick = function (event) {
    var $el = $(this)
    // cache jQuery lookups
    , $target = $($el.data('target'))
    , $activeTab = $('.tab.active')
    , $active = $($activeTab.data('target'))

    // is selected gallery already visible? do nothing
    if ($target.is(':visible')) {
        return
    } else {
        // hide active gallery, remove active class from past tab
        $active.hide()
        $activeTab.removeClass('active')
        // add active class to clicked tab, show new gallery
        $el.addClass('active')
        $target.show()
        alignImages($target)
    }
}

alignImages($('#studentWork'))
$('.tab').click(handleTabClick)
