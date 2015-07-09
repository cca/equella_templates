<#-- load the following CSS files to go with this portlet:
- /file/3c22fa1f-f837-45af-a675-115894f6b1ae/1/justifiedGallery.min.css
- /file/0be6649f-15fa-45da-80ac-1a9c539a9418/2/dashboard-non-cca.min.css
- /file/4d7bd7f2-3093-41be-a53a-e13afa8c2dbf/1/bootstrap-tour-standalone.min.css

@TODO compile these three into one file to save on HTTP requests
see Web Assets collection to find these -->
<#if ! user.hasRole('ROLE_SYSTEM_ADMINISTRATOR')>

<#-- @TODO handle these the same as CSS files; move out of markup -->
<script src="/file/91b0c427-7c26-45bc-a550-27ed93165a9d/1/jquery.justifiedGallery.min.js"></script>
<script src="/file/4d7bd7f2-3093-41be-a53a-e13afa8c2dbf/1/bootstrap-tour-standalone.min.js"></script>
<#-- first role tested is role ID on live server, 2nd is dev -->
<#-- check user role -->
<#if user.hasRole('490b1b93-10cd-b8fa-3291-93c357efe57b')>
    <#assign role = 'faculty'>
<#elseif user.hasRole('c8038af0-fa3f-9a70-e5e1-3f768972203a')>
    <#assign role = 'staff'>
<#elseif user.hasRole('89ea364f-066e-1a3f-f70e-4b29f08e8448')>
    <#assign role = 'student'>
<#else>
    <#assign role = 'public'>
</#if>

<script>
//user role JS variable
window._ccaRole = '${role}';

//Create tour button in top right corner
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
    roleGuideSuggestion = "<br><br><strong><a style='color:#d46!important;' target='_blank' href='/file/5b76c993-efcb-40d1-bb9a-69614ebf01eb/2/general%20student%20course%20work%20submission.pdf'>How to Upload an Assignment</a></strong>";
}
else if ( window._ccaRole == 'faculty' || window._ccaRole == 'staff' ){
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
        opacity:.5
    });
});

checkTourStatus();

$(function() {

    $('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07').clone().prependTo('#topwide').addClass('oldQS');
    $('#pportlet_a0be8e7d-8171-4ffb-8d0e-48cc48170e07:not(.oldQS)').remove();
    //Quick Search
    $('.quick-search').prepend('<h3 style="padding-left:30px;">Quick Search</h3><br><br>');

    $('.campPlanTitle').hide();
    $('.campPlanTitle').stop(true, true).clearQueue();
    $('#campusPlanning').stop(true, true).clearQueue();
    $('#campusPlanning a').stop(true, true).clearQueue();
        //timers for sequential fade in
        var timers = new Array();
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
                        // setTimeout(function(){
                            console.log(myArray[i]);
                            $(this).animate({
                                top: myArray[i] + 30*(i+1)
                            }, 500);
                            $
                            //}, 600);
                            //$(this).css('top', myArray[i] + 30*(i+1));
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


     $('.onClicker').click(function(){
        location.href=$(this).attr('href');
    });

});
</script>

<div id="mainPageBox">
    <div id="mainTabs">
        <div data-target="#communications" class="mainTab active">Communications</div>
        <div data-target="#libraryCollections" class="mainTab">Library Collections</div>
        <div data-target="#campusPlanning" class="mainTab" id="campBtn">Campus Planning: Spatial Benchmarking</div>
    </div>

    <div id="cp-contrib" style="display: none;"><a href="/access/runwizard.do?method=newitem&itemdefUuid=f75326ab-977c-4873-8987-eaa419ecb773">Contribute to collection</a></div>

    <div id="libraryCollections" class="imgContainer">
        <a href="/items/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/">
            <img src="/file/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/13051706PS.jpg">
        </a>
        <a href="/items/aea1a5b3-439c-40b7-9108-201177493e57/1/">
            <img src="/file/aea1a5b3-439c-40b7-9108-201177493e57/1/13051701PS.jpg">
        </a>
        <a href="/items/5f86f540-3804-ada6-d23d-deba76285264/1/">
            <img src="/file/5f86f540-3804-ada6-d23d-deba76285264/1/06050806PR.jpg">
        </a>
        <a href="/items/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/">
            <img src="/file/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/13051705PS.jpg">
        </a>
        <a href="/items/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/">
            <img src="/file/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/06050811PS.jpg">
        </a>
        <a href="/items/e8c45774-fe75-1d59-5fed-e61e96690231/1/">
            <img src="/file/e8c45774-fe75-1d59-5fed-e61e96690231/1/05122214CP.jpg">
        </a>
        <a href="/items/89207d4c-c06f-871e-21c5-b09505ef2f04/1/">
            <img src="/file/89207d4c-c06f-871e-21c5-b09505ef2f04/1/06050801PR.jpg">
        </a>
          <a href="/items/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/">
            <img src="/file/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/06050812PR.jpg">
        </a>
        <a href="/items/ff95c836-1236-ed70-1608-12f426442fe6/1/">
            <img src="/file/ff95c836-1236-ed70-1608-12f426442fe6/1/06050802PR.jpg">
        </a>
        <a href="/items/576f4150-48d2-3fac-7e65-b81eb9287f36/1/">
            <img src="/file/576f4150-48d2-3fac-7e65-b81eb9287f36/1/06101202PR.jpg">
        </a>
        <a href="/items/3b20fff3-0974-7958-ef34-47feba6418e8/1/">
            <img src="/file/3b20fff3-0974-7958-ef34-47feba6418e8/1/07011307WA.jpg">
        </a>

        <a href="/items/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/">
            <img src="/file/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/06052201PS.jpg">
        </a>
        <a href="/items/1a227ece-b336-95df-9fae-b5d318949f8c/1/">
            <img src="/file/1a227ece-b336-95df-9fae-b5d318949f8c/1/06110103BE.jpg">
        </a>
        <a href="/items/e6490676-0020-3a29-85b6-7a41352a383b/1/">
            <img src="/file/e6490676-0020-3a29-85b6-7a41352a383b/1/05122201BE.jpg">
        </a>
    </div>

    <div id="communications" class="imgContainer">
        <a href="//vault.cca.edu/items/63b16c33-1187-4a72-bfc1-02886463e9d2/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/SFcampus03.jpg">
        </a>
        <a href="//vault.cca.edu/items/f90ffbc1-d648-41cc-9c3f-0c2a79d89990/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/13_CCA-Martinez-Oakland.jpg">
        </a>

        <a href="//vault.cca.edu/items/092e8fa5-7a9a-419d-b16e-a5978c4da7e0/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/10_CCA_ArchStudio.jpg">
        </a>
        <a href="//vault.cca.edu/items/d9a46034-9456-44fb-bf29-0b78a7c4510e/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/12_CCA-Student-Center.jpg">
        </a>
        <a href="//vault.cca.edu/items/017d392b-3678-4480-b1e3-e398995b5db9/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/11_CCA-Wattis-exterior.jpg">
        </a>
        <a href="//vault.cca.edu/items/96c2d9ea-5811-4672-8aaa-707af5a339e8/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/09_CCA-Nave-interior.jpg">
        </a>
        <a href="//vault.cca.edu/items/c05ed9b7-6ae1-44db-bd42-32b3649468a5/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/08_CCA-Nave-interior.jpg">
        </a>

        <a href="//vault.cca.edu/items/135c3377-8b72-4a46-8781-8a588d8d0d26/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/07_CCA-GradCenter.jpg">
        </a>
        <a href="//vault.cca.edu/items/b3ab986a-9fe2-420b-8d27-c13c09b0771a/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/05_CCA-Wattis.jpg">
        </a>
        <a href="//vault.cca.edu/items/95fe2008-dbac-4bfb-b7ed-9bc31d5d83d4/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/06_CCA-GradCenter.jpg">
        </a>

        <a href="//vault.cca.edu/items/01d7929b-ae0e-4bcb-8e86-bd3d5437fbe9/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/04_CCA-Nave-interior.jpg">
        </a>
        <a href="//vault.cca.edu/items/dc4ba0f2-96c9-4e3e-8115-1086784d3694/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/02_OaklandCampus_Mackey.jpg">
        </a>
        <a href="//vault.cca.edu/items/c4ae9ec6-2b02-4516-8b1e-716462e74130/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/01_SFCampusSkyline.jpg">
        </a>
    </div>
</div>

<#-- CAMPUS PLANNING IMAGES -->
<div id="campusPlanning" class="imgContainer">
    <div class="campPlanTitle" style="position:absolute; width:100%!important; height:30px!important; line-height:30px!important; box-sizing:border-box; padding-left:30px;">
        Activities
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3EActivities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EAssembling%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Assembling </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3EActivities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3ECirculation%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Circulation </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3EActivities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3ERetreating%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Retreating </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3EActivities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EBreaking%20Bread%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Breaking Bread </span>
    </div>
    <a href="//vault.cca.edu/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
        <img src="//vault.cca.edu/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2%205.jpg">
    </a>
    <a href="//vault.cca.edu/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
        <img src="//vault.cca.edu/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2%207.jpg">
    </a>

    <a href="//vault.cca.edu/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
        <img src="//vault.cca.edu/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2,%20SF%202.jpg">
    </a>
    <a href="//vault.cca.edu/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
        <img src="//vault.cca.edu/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/Zendesk%205.jpg">
    </a>

    <div class="campPlanTitle" style="position:absolute; width:100%!important; height:30px!important; line-height:30px!important; box-sizing:border-box; padding-left:30px;">
    Spatial (Typologies)
    <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3ESpatial%20(Typologies)%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EMaking%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q=">Making</span>
    <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3ESpatial%20(Typologies)%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3ETeaching%20%26amp%3B%20Learning%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q=">Teaching & Learning</span>
    <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3ESpatial%20(Typologies)%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EResearch%20%26amp%3B%20Resources%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q=">Research & Resources</span>
    <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3ESpatial%20(Typologies)%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3ELiving%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Living </span>
    </div>

    <a href="//vault.cca.edu/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
        <img src="//vault.cca.edu/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/ACCD%20CMTEL%20lab.jpg">
    </a>
    <a href="//vault.cca.edu/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
        <img src="//vault.cca.edu/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/ACCD%20CMTEL%20lab%202.jpg">
    </a>
    <a href="//vault.cca.edu/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
        <img src="//vault.cca.edu/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/Parsons%20NY%202.jpg">
    </a>
    <a href="//vault.cca.edu/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
        <img src="//vault.cca.edu/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/Parsons%20NY.jpg">
    </a>

    <div class="campPlanTitle" style="position:absolute; width:100%!important; height:30px!important; line-height:30px!important; box-sizing:border-box; padding-left:30px;">
    (Spatial) Qualities
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3E(Spatial)%20Qualities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EEnclosure%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Enclosure </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3E(Spatial)%20Qualities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EAdjacency%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Adjacency </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3E(Spatial)%20Qualities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EDisplay%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Display </span>
        <span class="onClicker" href="/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CgenreWrapper%3E%3Cgenre%3E(Spatial)%20Qualities%3C%2Fgenre%3E%3C%2FgenreWrapper%3E%3Cpart%3E%3CwrapperOther%3E%3Ctags%3EMaterials%3C%2Ftags%3E%3C%2FwrapperOther%3E%3C%2Fpart%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd&q="> Materials </span>
    </div>

    <a href="//vault.cca.edu/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
        <img src="//vault.cca.edu/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/European%20Ceramics%20Work%20Centre%20Netherlands%209.jpg">
    </a>
    <a href="//vault.cca.edu/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
        <img src="//vault.cca.edu/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%205.jpg">
    </a>
    <a href="//vault.cca.edu/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
        <img src="//vault.cca.edu/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%203.jpg">
    </a>

    <a href="//vault.cca.edu/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
        <img src="//vault.cca.edu/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%202.jpg">
    </a>
</div>

</#if>
