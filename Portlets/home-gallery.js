// @TODO break this out into tour.js file
//Create tour button in top right corner
// @TODO move style out of string
$('body #body-inner').append('<div style="color:#b35;" id="startTourBtn">New? Take a tour</div>');
//Check if tour has been started already, if so, change start button text and stop attention bouncing
function checkTourStatus(){
   if (localStorage.tour_current_step == 7){
       $('#startTourBtn').html('Restart Tour');
       localStorage.tour_current_step = 0;
        clearInterval(jumpy);
   }
   else if (localStorage.tour_end == 'yes'){
        $('#startTourBtn').html('Continue tour');
        clearInterval(jumpy);
    }
}

/*-------------------------------------
  Create tour object - BOOTSTRAP TOUR
-------------------------------------*/

/* Want to add a new step to the tour?

{
    element: (#id or selector of focus item)
    title: (a text title for the item)
    backdrop: (leave this as true to include the tour shadow overlay)
    content: text/html content to go in the body of the box
}

*/

// Which 'how to' guide to include in 'contribute' step?
var roleGuideSuggestion = "";
if ( window._ccaRole == 'student' ){
    // @TODO move style out of string
    roleGuideSuggestion = "<br><br><strong><a style='color:#d46!important;' target='_blank' href='/file/5b76c993-efcb-40d1-bb9a-69614ebf01eb/2/general%20student%20course%20work%20submission.pdf'>How to Upload an Assignment</a></strong>";
}
else if ( window._ccaRole == 'faculty' || window._ccaRole == 'staff' ){
    // @TODO move style out of string
    roleGuideSuggestion = "<br><br><strong><a style='color:#d46!important;' target='_blank' href='/file/c261de7d-bdf5-4c2b-b3e2-960cc38205af/1/fac%20assignment%20template%20submissionREVISED.pdf'>How to Create an Assignment Template</a></strong>";
}

var tour = new Tour({
  steps: [
  {
    element: "#menu>ul>li>a[href*='access/home.do']",
    title: "Dashboard",
    backdrop: true,
    content: "The Vault homepage - check out work from other students and from CCA's private art collections in the Dashboard Gallery."
  },
  {
    element: "#menu>ul>li>a[href*='access/myresources.do']",
    title: "My Resources",
    backdrop: true,
    // @TODO move style out of string
    content: "Once you've submitted an assignment or saved a draft you can view or make changes to it here.<br><br><strong><a style='color:#d46!important;' href='access/myresources.do?type=published'>Published</a></strong> : Finished & Submitted Assignments<br><br><strong><a style='color:#d46!important;' href='access/myresources.do?type=draft'>Drafts</a></strong> : Unsubmitted Assignments"
  },
  {
    element: "#menu>ul>li>a[href*='access/searching.do']",
    title: "Search",
    backdrop: true,
    content: "Search Vault for a specific work, collection, or assignment."
  },
  {
    element: "#menu>ul>li>a[href*='access/contribute.do']",
    title: "Contribute",
    backdrop: true,
      content: "Submit assignments or artwork for your classes and portfolio reviews." + roleGuideSuggestion
  },
  {
    element: "#menu>ul>li>a[href*='access/hierarchy.do?topic=44db2f8a-bb57-4f1d-801a-43443ae55176']",
    title: "Info, Guides & FAQs",
    backdrop: true,
    content: "New to Vault or having trouble figuring something out? Check here for our 'how to' guides."
  },
  {
    element: "#menu>ul>li>a[href*='access/runwizard.do?method=newitem&itemdefUuid=64efdfe9-9fcb-40ed-9688-206f1985eea0']",
    title: "Support Services",
    backdrop: true,
    content: "After checking the guides, if you're still having trouble then feel free to contact us for assistance."
  },
  {
    element: "#menu>ul>li>a[href*='access/notifications.do']",
    title: "Notifications",
    backdrop: true,
    content: "You'll get notifications here any time there are new developments with your assignment submissions."
  },
  {
      orphan: true,
      title: "Fin",
      backdrop: true,
      content: "<img width='250px' src='file/b3371770-df58-4f29-8f1c-2f3c97f68298/1/thatsallfolks.gif'>"
  }
],
onEnd: function (tour) {
    //hack to make the shadow backdrop fade out instead of disappearing instantly
    $('body').append('<div class="tour-backdrop"></div>');
    $('.tour-backdrop').animate({
        opacity:0
    }, 1000, function(){
        $('.tour-backdrop').remove();
    });
    $('html,body').animate({ scrollTop: 0 }, 1000);

    checkTourStatus();
}
});

// bounce the start button to call attention every 3 sec.
var jumpy = setInterval(jumpTourBtn, 3000);

// bounce function
function jumpTourBtn(){
    $('#startTourBtn').animate({
        top:34
    }, 150, function(){
        $('#startTourBtn').animate({
            top:44
        }, 190, function(){
            $('#startTourBtn').animate({
        top:34
    }, 150, function(){
        $('#startTourBtn').animate({
            top:44
        }, 190, function(){

        });

    });
        });

    });
}

//if user mouses over the button then stop bouncing
$('#startTourBtn').mouseover(function(){
    clearInterval(jumpy);
});

    //if user clicks on the button then start the tour
$('#startTourBtn').click(function(){

    //force start tour
    tour.start(true);

    //hack fade in the shadow overlay
        $('body .tour-backdrop').css('opacity', '0');
    $('.tour-backdrop').animate({
        opacity: 0.5
    });
});

checkTourStatus();

// @TODO break this out into separate file
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
