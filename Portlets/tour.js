// run on document load
$(function(){
    // Check if tour has been started already
    // if so, change start button text and stop attention bouncing
    function checkTourStatus(interval){
       if (localStorage.tour_current_step == 5){
           $('#startTourBtn').text('Restart Tour');
           localStorage.tour_current_step = 0;
           clearInterval(interval);
       }
       else if (localStorage.tour_end == 'yes'){
            $('#startTourBtn').text('Continue tour');
            clearInterval(interval);
        }
    }

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

    // Create tour button in top right corner
    $('#body-inner').append('<div id="startTourBtn">New? Take a tour</div>');

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
    var roleGuideSuggestion;
    // global variable _ccaRole provided by Freemarker template
    if (window._ccaRole == 'student') {
        roleGuideSuggestion = "<br><br><strong><a class='suggestion' target='_blank' href='/file/5b76c993-efcb-40d1-bb9a-69614ebf01eb/2/general%20student%20course%20work%20submission.pdf'>How to Upload an Assignment</a></strong>";
    } else if (window._ccaRole == 'faculty' || window._ccaRole == 'staff'){
        roleGuideSuggestion = "<br><br><strong><a class='suggestion' target='_blank' href='/file/c261de7d-bdf5-4c2b-b3e2-960cc38205af/1/fac%20assignment%20template%20submissionREVISED.pdf'>How to Create an Assignment Template</a></strong>";
    }

    var tour = new Tour({
        backdrop: true,
        container: "html",
        debug: "true",
        steps: [
            {
                element: "#menu a[href$='myresources.do']",
                title: "My Resources",
                content: "You can view or make changes to your VAULT contributions here.<br><br><strong><a class='suggestion' href='access/myresources.do?type=published'>Published</a></strong>: Finalized & submitted items<br><br><strong><a style='color:#d46!important;' href='access/myresources.do?type=draft'>Drafts</a></strong>: Unfinished work"
            }, {
                element: "#menu a[href$='searching.do']",
                title: "Search",
                content: "Search VAULT for students' course work, materials in the library archives, and more."
            }, {
                element: "#menu a[href$='contribute.do']",
                title: "Contribute",
              content: "Upload your own work to VAULT." + roleGuideSuggestion
            }, {
                element: "#menu a[href$='hierarchy.do?topic=44db2f8a-bb57-4f1d-801a-43443ae55176']",
                title: "Info, Guides & FAQs",
                content: "New to VAULT or having trouble? Check here for our 'how to' guides."
            }, {
                element: "#menu a[href$='runwizard.do?method=newitem&itemdefUuid=64efdfe9-9fcb-40ed-9688-206f1985eea0']",
                title: "Support Services",
                content: "If you're still having trouble after reading our guides, feel free to contact us for assistance."
            }, {
              orphan: true,
              title: "Fin",
              content: "<img width='250px' src='file/b3371770-df58-4f29-8f1c-2f3c97f68298/1/thatsallfolks.gif'>"
            }
        ],
        onEnd: function (tour) {
            // make the shadow backdrop fade out instead of disappearing instantly
            $('body').append('<div class="tour-backdrop"></div>');
            $('.tour-backdrop').animate({ opacity:0 }, 1000, function() {
                $('.tour-backdrop').remove();
            });
            $('html, body').animate({ scrollTop: 0 }, 1000);
            checkTourStatus(jumpy);
        }
    });

    // bounce the start button _once_ 3 seconds after DOM load
    var jumpy = setTimeout(jumpTourBtn, 3000);

    // if user mouses over the button then stop bouncing
    $('#startTourBtn').mouseover(function(){
        clearInterval(jumpy);
    }).click(function(){
        // force start tour
        tour.start(true);

        // hack fade in the shadow overlay
        $('.tour-backdrop').css('opacity', '0').animate({
            opacity: 0.5
        });
    });

    checkTourStatus(jumpy);

})
