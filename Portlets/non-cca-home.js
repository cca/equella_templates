$(function() {
    //timers for sequential fade in
    var timers = []
    // Hide the Images Initially
    $('.imgContainer.active img').hide()
    // Initialize Justified Gallery Plugin, set row height to 130px
    $('.imgContainer').justifiedGallery({
        lastRow: 'hide',
        rowHeight: 130
    })
    // Sequentially fade in the images
    $('.imgContainer.active img').each(function(i) {
        var thisImg = $(this)
        timers.push(
            setTimeout(
                function() {
                    thisImg.fadeIn()
                }, 200 * i)
            )
    })

    // When user clicks on a new tab:
    $('.mainTab').click(function() {
        // Finish all previous animations
        for (var i = 0; i < timers.length; i++) {
            clearTimeout(timers[i])
        }
        $('.imgContainer.active img').stop(true, true).hide()

        //remove active class from previous tab
         $('.mainTab.active').removeClass('active')
        //apply active class to new tab
         $(this).addClass('active')
        //update the active image container
        $('.imgContainer.active').removeClass('active')
        $($(this).data('target')).addClass('active')
        // run justified gallery plugin on new container
        $('.imgContainer.active').justifiedGallery({
            lastRow: 'hide',
            rowHeight: 130
        })
        //hide all images initially
        $('.imgContainer.active img').hide()
        $('.imgContainer img').stop(true, true).clearQueue()
        // Sequentially fade in the images
        $('.imgContainer.active img').each(function(index)  {
            var thisImg = $(this)
            timers.push(
                setTimeout(
                    function() {
                        thisImg.fadeIn()
                }, 200 * index)
            )
        })
    })

    $('.active').click()
})
