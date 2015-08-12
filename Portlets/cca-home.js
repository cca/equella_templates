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
    var id = $wrapper.attr('id')
    var height = (id == 'campusPlanning' ? 67.5 : 90)
    var captions = (id == 'campusPlanning' ?  false : true)

    // clear existing timers
    $.each(timers, function(index, timer) {
        clearTimeout(timer)
    })
    // hide all images
    $wrapper.find('img').hide();
    // justified gallery
    // dox: miromannino.github.io/Justified-Gallery/options-and-events/
    $wrapper.justifiedGallery({
        'captions': captions,
        'lastRow': 'hide',
        'randomize': true,
        'rowHeight': height
    })
    // when layout's complete, fade in each image
    // each one has a 200s longer interval than the last
    .on('jg.complete', function() {
        // cannot cache lookup any earlier since .justifiedGallery call above
        // changed the order of the DOM elements
        $wrapper.find('img').each(function(index, img) {
            timers.push(
                setTimeout(function() {
                    $(img).fadeIn();
                }, 150 * index)
            );
        })
    })
}

// run on document load
$(function(){
    $('.tab:not(".link")').click(handleTabClick)
    $('.tab.active').click()
})
