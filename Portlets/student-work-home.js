// put under "Client-side on-ready script" in the portal admin

var handleTabClick = function (event) {
    var $targetTab = $(this)
    // cache jQuery lookups
    , $target = $($targetTab.data('target'))
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
        $targetTab.addClass('active')
        $target.show() // is this necessary? does JG do .show() automatically?
        showImages($target)
    }
}

var timers = []

var showImages = function ($wrapper) {
    var height = $wrapper.attr('id') == 'studentWork' ? 90 : 130
    var $images = $wrapper.find('img')

    // clear existing timers
    $.each(timers, function(index, timer) {
        clearTimeout(timer)
    })
    // hide all images
    $images.hide();
    // justified gallery
    $wrapper.justifiedGallery({
        rowHeight: height
    })
    // when layout's complete, fade in each image
    // each one has a 200s longer interval than the last
    .on('jg.complete', function() {
        $images.each(function(index, img) {
            timers.push(
                setTimeout(function() {
                    $(img).fadeIn();
                }, 200 * index)
            );
        })
    })
}

showImages($('#studentWork'))
$('.tab').click(handleTabClick)
