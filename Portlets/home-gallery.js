$(function() {

    // @TODO next 3 lines are separate quick-search.js file, unrelated to below
    $('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07').clone().prependTo('#topwide').addClass('oldQS');
    $('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07:not(.oldQS)').remove();
    //Quick Search
    // @TODO move style out of string
    $('.quick-search').prepend('<h3 style="padding-left:30px;">Quick Search</h3><br><br>');

    $('.campPlanTitle').hide();
    $('.campPlanTitle').stop(true, true).clearQueue();
    $('#campusPlanning').stop(true, true).clearQueue();
    $('#campusPlanning a').stop(true, true).clearQueue();
        //timers for sequential fade in
        var timers = [];
        // Hide the Images Initially
    $('.imgContainer.active img').hide();
        // Initialize Justified Gallery Plugin, set row height to 130px
    $(".imgContainer").justifiedGallery({
        rowHeight:130,
            sizeRangeSuffixes:{'lt100':'',
            'lt240':'',
            'lt320':'',
            'lt500':'',
            'lt640':'',
            'lt1024':''}
    }).on('jg.complete', function(e){
        if ( $('#campusPlanning').hasClass('active')) {
        timers.push(setTimeout(function(){
            var currTop = -1;
            var myArray = [];

            $('#campusPlanning').find('a').each(function(){
                if ( currTop != parseInt($(this).css('top')) ){
                    currTop = parseInt($(this).css('top'));
                    myArray.push(currTop);
                }
            });

            var campHeight = $('#campusPlanning').height();

            for ( i=0; i<myArray.length; i++ ){
                $('.campPlanTitle').each(function(i){
                    $(this).css('top', myArray[i] + 30*(i));
                });
                $('#campusPlanning').find('a').each(function(){
                    if ( parseInt($(this).css('top')) == myArray[i] ){
                            $(this).animate({
                                top: myArray[i] + 30*(i+1)
                            }, 500);
                        }
                }).promise().done( function(){
                    if (!$('#campusPlanning').is(':animated')) {
                        $('#campusPlanning').animate({
                            height: (campHeight + myArray.length*30)
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
    $(".imgContainer.active img").each(function(i)  {
                var thisImg = $(this);

                timers.push(setTimeout(function(){thisImg.fadeIn();}, 200*i));
    });

    // When user clicks on a new tab:
    $('.mainTab').click(function(){
        $('.campPlanTitle').stop(true, true).clearQueue();
        $('.campPlanTitle').hide();
        $('#campusPlanning').stop(true, true).clearQueue();
        $('#campusPlanning a').stop(true, true).clearQueue();
        // Finish all previous animations
        //clearAllTimeout('fades'); // clearAllInterval(); for intervals
        for (var i = 0; i < timers.length; i++)
        {
            clearTimeout(timers[i]);
        }
        $('.imgContainer.active img').stop(true, true).hide();

        //remove active class from previous tab
         $('.mainTab.active').removeClass('active');
        //apply active class to new tab
         $(this).addClass('active');
        //update the active image container
         $('.imgContainer.active').removeClass('active');
        $($(this).attr('data-target')).addClass('active');
        // run justified gallery plugin on new container
        $(".imgContainer.active").justifiedGallery({
        rowHeight:130,
                sizeRangeSuffixes:{'lt100':'',
            'lt240':'',
            'lt320':'',
            'lt500':'',
            'lt640':'',
            'lt1024':''}
        });
        //hide all images initially
        $('.imgContainer.active img').hide();
        $('.imgContainer img').stop(true,true).clearQueue();
        //sequentially fade in each image
         // Sequentially fade in the images
        $(".imgContainer.active img").each(function(i)  {
                    var thisImg = $(this);
                      timers.push(setTimeout(function(){thisImg.fadeIn();}, 200*i));
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
    $('.onClicker').click(function(){
        location.href = $(this).attr('href');
    });
});
