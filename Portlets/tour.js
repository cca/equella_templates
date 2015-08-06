// Check if tour has been started already
// if so, change start button text and stop attention bouncing
function checkTourStatus(interval){
   if (localStorage.tour_current_step == 7){
       $('#startTourBtn').html('Restart Tour');
       localStorage.tour_current_step = 0;
       clearInterval(interval);
   }
   else if (localStorage.tour_end == 'yes'){
        $('#startTourBtn').html('Continue tour');
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

// run on document load
$(function(){

// Create tour button in top right corner
$('body #body-inner').append('<div id="startTourBtn">New? Take a tour</div>');

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
if ( _ccaRole == 'student' ){
    roleGuideSuggestion = "<br><br><strong><a class='suggestion' target='_blank' href='/file/5b76c993-efcb-40d1-bb9a-69614ebf01eb/2/general%20student%20course%20work%20submission.pdf'>How to Upload an Assignment</a></strong>";
}
else if ( _ccaRole == 'faculty' || _ccaRole == 'staff' ){
    roleGuideSuggestion = "<br><br><strong><a class='suggestion' target='_blank' href='/file/c261de7d-bdf5-4c2b-b3e2-960cc38205af/1/fac%20assignment%20template%20submissionREVISED.pdf'>How to Create an Assignment Template</a></strong>";
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
    content: "Once you've submitted an assignment or saved a draft you can view or make changes to it here.<br><br><strong><a class='suggestion' href='access/myresources.do?type=published'>Published</a></strong> : Finished & Submitted Assignments<br><br><strong><a style='color:#d46!important;' href='access/myresources.do?type=draft'>Drafts</a></strong> : Unsubmitted Assignments"
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
        // hack to make the shadow backdrop fade out instead of disappearing instantly
        $('body').append('<div class="tour-backdrop"></div>');
        $('.tour-backdrop').animate({ opacity:0 }, 1000, function() {
            $('.tour-backdrop').remove();
        });
        $('html, body').animate({ scrollTop: 0 }, 1000);
        checkTourStatus(jumpy);
    }
});

// bounce the start button to call attention every 3 sec.
var jumpy = setInterval(jumpTourBtn, 3000);

// if user mouses over the button then stop bouncing
$('#startTourBtn').mouseover(function(){
    clearInterval(jumpy);
});

// if user clicks on the button then start the tour
$('#startTourBtn').click(function(){

    // force start tour
    tour.start(true);

    // hack fade in the shadow overlay
    $('body .tour-backdrop').css('opacity', '0');
    $('.tour-backdrop').animate({
        opacity: 0.5
    });
});

checkTourStatus(jumpy);

})
