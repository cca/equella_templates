<div style = "border:none!important;" id="searchform" class="area">
    <div class="query-wrapper" role="search">
        <div class="input">
            <div id="q_autocomplete" class="autocomplete-container">
                <input style = "margin-left:-70px; width:340px;" id="q" class="real ui-autocomplete-input" type="text" name="q" value="" autocomplete="off">
                <span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span>
                <input style = "margin-left:-70px; width:340px;" class="prompt" type="text" disabled="disabled">
            </div>
        </div>
        <input id="searchform-in" name="in" value="all" type="hidden" />
        <button style = "padding-top:2px; padding-bottom:1px; position: absolute;
right: -20px; top:0px; width:40px;" id="searchform-search" class="btn btn-equella" name="sq_s" type="button">
            <i class="icon-search icon-white"></i>
        </button>
    </div>
    <style scoped>
    /* override a few spacing properties
    since we're embedding the div inside itself
    it needs to be shrunk down just a bit */
    #searchform .query-wrapper input[type=text],
    #searchform .query-wrapper select {
        width: 280px;
    }
    #searchform-search {
        left: 370px;
    }
    #searchform {
        margin: 0;
    }

	.browse-topics ul li{
		background:none!important;
	}


    </style>
</div>
<script>
$(document).ready(function(){

$('#col1').find("input").keydown(function( event ) {
  if ( event.which == 13 ) {
    $('html, body').animate({
      scrollTop: $('#searchresults').offset().top - 10
     }, 1200);
  }
});

//on search btn click, trigger enter press since that is working.
  $('#searchform-search').click(function () {
    var e = jQuery.Event("keydown");
    e.which = 13; // # Some key code value
    $('#col1').find("input").trigger(e);
  });
});
/*
$('#searchform-search').click(function () {
    // point form at search URL instead of hierarchy.do
    // add "&in={{ID}}" if you want a collection or power search
    $('#eqpageForm').attr('action', '/access/searching.do&in=P63e19032-7c08-44ec-b3d4-24904a2c4ccd');
    // postAjaxJSON(form, id, params, callback, errorcallback)
    // _f() => returns page-wrapping form, calls _e() an alias for doc.getElById
    postAjaxJSON(_f(), '$UP6$sq.saveQuery', [], function (results, status) {
        // showNewResults(imageUrl, oldDiv, newContents, callback)
        showNewResults('p/r/6.2.r1360/com.tle.web.sections.standard/images/ajax/doing.gif', $('#searchresults'), results, null);
    }, showNewResults('p/r/6.2.r1360/com.tle.web.sections.standard/images/ajax/doing.gif', $('#searchresults'), null, null)
    );

    return false;

});

*/
</script>

<center><a href="https://vault.cca.edu/s/contribute-spatial">CONTRIBUTE TO THE COLLECTION!</a></center>
<br/>
<script src="https://vault.cca.edu/file/91b0c427-7c26-45bc-a550-27ed93165a9d/1/jquery.justifiedGallery.min.js"></script>
<script src="https://vault.cca.edu/file/4d7bd7f2-3093-41be-a53a-e13afa8c2dbf/1/bootstrap-tour-standalone.min.js"></script>

<script>
    $(function()    {

	$('.area.browse-topics').append('<div id = "communications" class = "imgContainer"><a href = "//vault.cca.edu/items/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/"><img src = "//vault.cca.edu/file/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/MIT%20Media%20Lab%20MA(2).jpg"></a><a href = "//vault.cca.edu/items/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/"><img src = "//vault.cca.edu/file/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/Parsons%20SCE%20NY%204.jpg"></a><a href = "//vault.cca.edu/items/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/"><img src = "//vault.cca.edu/file/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/MIT%20Media%20Lab%20MA%203.jpeg"></a><a href = "//vault.cca.edu/items/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/"><img src = "https://vault.cca.edu/file/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/MIT%20Media%20Lab%20MA.jpg"></a><a href = "//vault.cca.edu/items/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/"><img src = "//vault.cca.edu/file/4f4fabee-faa6-4296-81bc-40a5a28f8b3c/1/Parsons%20SCE%20NY%203.jpg"></a></div>');

    $('.campPlanTitle').hide();
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
        //timer for title slide-out animation
        timers.push(setTimeout(function(){
            //currTop is the 'top' style of each image
            var currTop = -1;
            //array to categorize images into rows
            var myArray = [];

            //each image,
            $('#campusPlanning>a').each(function(){
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
                            $

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
        });
        // Sequentially fade in the images
    $(".imgContainer.active img").each(function(i)  {
                var thisImg = $(this);

                timers.push(setTimeout(function(){thisImg.fadeIn();}, 200*i));
    });

    // When user clicks on a new tab:
    $('.mainTab').click(function(){
    $('.campPlanTitle').hide();
    $('.campPlanTitle').stop(true, true).clearQueue();
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



    });

        $('.active').click();

        $('.onClicker').click(function(){
            location.href=$(this).attr('href');
        });

    });
</script>

<style>

    /*********************************/
    /*     Fixing Equella Styles     */
    /*********************************/
    #topwide>.box:first-child{
        display:block;
    }

    #ppfm3_portletDiv{
        background:white;
    }

    .box_head{
            display:none;
    }
    .box_content{
            padding-top:0px;
        border-top:0px!important;
    }

    /*********************************/
    /* END Fixing Equella Styles END */
    /*********************************/
    #mainPageBox    {
        width:  100%;
        margin: auto;
    }

    .imgContainer   {
        width:  100%;
        border: 1px solid #ddd;
        box-sizing: border-box;
        border-radius:5px;
        display:    block;
    }

    .imgContainer.active>a>img:hover{
        opacity:.8;
    }

        .imgContainer.active img    {
        display:    none;
    }

    .imgContainer.active    {
        display:    block!important;
    }

    #mainTabs   {
        width:  100%;
        padding:5px;
        box-sizing:border-box;
        height:40px;
    }

    .mainTab    {
        float:left;
        padding:5px 5px;
                color: #333!important;
                cursor:pointer;
        min-width:130px;
        text-align:center;

    }

        .mainTab:hover  {
            color: #000!important;
    }



    .mainTab.active {
        font-weight:    bold;
    }

    body .tour-backdrop{
        opacity:.5;
    }
</style>

<link rel="stylesheet" type="text/css" href="https://vault.cca.edu/file/3c22fa1f-f837-45af-a675-115894f6b1ae/1/justifiedGallery.min.css">

<link rel="stylesheet" type="text/css" href="https://vault.cca.edu/file/4d7bd7f2-3093-41be-a53a-e13afa8c2dbf/1/bootstrap-tour-standalone.min.css">
