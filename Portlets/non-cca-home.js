/*jshint -W083 */
// ignore 'fn created in loop' warnings
var stopCampusPlanningAnimations = function () {
    $('.campPlanTitle').stop(true, true).clearQueue();
    $('.campPlanTitle').hide();
    $('#campusPlanning').stop(true, true).clearQueue();
    $('#campusPlanning a').stop(true, true).clearQueue();
}

$(function() {
    //timers for sequential fade in
    var timers = [];
    // Hide the Images Initially
    $('.imgContainer.active img').hide();
    // Initialize Justified Gallery Plugin, set row height to 130px
    $('.imgContainer').justifiedGallery({
        lastRow: 'hide',
        rowHeight: 130
    }).on('jg.complete', function(e) {
        if ($('#campusPlanning').hasClass('active')) {
        timers.push(setTimeout(function() {
            var currTop = -1;
            var myArray = [];

            $('#campusPlanning').find('a').each(function() {
                if (currTop != parseInt($(this).css('top')) ){
                    currTop = parseInt($(this).css('top'));
                    myArray.push(currTop);
                }
            });

            var campHeight = $('#campusPlanning').height();

            for ( i = 0; i < myArray.length; i++ ) {
                $('.campPlanTitle').each(function(i) {
                    $(this).css('top', myArray[i] + 30*(i));
                });
                $('#campusPlanning').find('a').each(function() {
                    if ( parseInt($(this).css('top')) == myArray[i] ){
                            $(this).animate({
                                top: myArray[i] + 30*(i+1)
                            }, 500);
                        }
                }).promise().done(function() {
                    if (!$('#campusPlanning').is(':animated')) {
                        $('#campusPlanning').animate({
                            height: (campHeight + myArray.length * 30)
                        }, 200);
                        $('.campPlanTitle').fadeIn();
                    }
                });
            }
                    /*setTimout(function(){
                $('#campusPlanning').find('a').each(
                    if ( currTop != parseInt($(this).css('top')) ){
                        currTop = parseInt($(this).css('top'));
                        myArray.push(currTop);
                    }
                });
                }, 100);*/
    },3000));
    }
        });
        // Sequentially fade in the images
    $('.imgContainer.active img').each(function(i) {
        var thisImg = $(this);
        timers.push(
            setTimeout(
                function() {
                    thisImg.fadeIn();
                }, 200*i)
            );
    });

    // When user clicks on a new tab:
    $('.mainTab').click(function() {
        // Finish all previous animations
        stopCampusPlanningAnimations();
        for (var i = 0; i < timers.length; i++) {
            clearTimeout(timers[i]);
        }
        $('.imgContainer.active img').stop(true, true).hide();

        //remove active class from previous tab
         $('.mainTab.active').removeClass('active');
        //apply active class to new tab
         $(this).addClass('active');
        //update the active image container
         $('.imgContainer.active').removeClass('active');
        $($(this).data('target')).addClass('active');
        // run justified gallery plugin on new container
        $('.imgContainer.active').justifiedGallery({
            lastRow: 'hide',
            rowHeight: 130
        });
        //hide all images initially
        $('.imgContainer.active img').hide();
        $('.imgContainer img').stop(true, true).clearQueue();
        // Sequentially fade in the images
        $('.imgContainer.active img').each(function(index)  {
            var thisImg = $(this);
            timers.push(
                setTimeout(
                    function() {
                        thisImg.fadeIn();
                }, 200 * index)
            );
        });

        // we're on campus planning tab
        if ($(this).attr('id') === 'campBtn') {
            // fade in link to Campus Planning contribution Wizard
            $('#cp-contrib').fadeIn();
        } else {
            // any other tab, fade it out
            $('#cp-contrib').fadeOut();
        }
    });

    $('.active').click();

    // @TODO why reimplement an HTML anchor tag?!? these should just be links
    $('.onClicker').click(function() {
        location.href = $(this).attr('href');
    });
});
