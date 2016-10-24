<#-- dashboard portlet -->
<#-- server message -->
<div class="clearfix alert" style="font: bold 1.3em/140% Arial">
    <#-- close button -->
    <button type="button" class="close" data-dismiss="alert" style="background-image:none;"><i class="icon-remove"></i></button>

    <h2 class="text-center">It's Open Access Week!</h2>
    <br>

    <p>
        In celebration of <a href="http://libguides.cca.edu/open-access">Open Access</a> Week, the libraries are encouraging faculty to deposit their academic publications into <a href="/access/runwizard.do?method=newitem&itemdefUuid=e96ccf65-0098-44bb-bec0-6e1cd5466046">the Faculty Research collection!</a> Upload by clicking the link, or email an article or book chapter to <a href="mailto:vault@cca.edu?subject=Faculty+Research+Contribution">vault@cca.edu</a> and we'll do it for you. Everyone who uploads a publication will be entered in raffle to win a gift certificate for coffee.
    </p>
    <br>

    <p><em><a href="#" onclick="$('.why-oa').toggle('slow');return false;">But why would I do that?</a></em></p>
    <p class="why-oa ui-helper-hidden">
        Making publications open access benefits...
        <ul class="why-oa ui-helper-hidden" style="list-style:disc;margin:0 1em">
            <li><em>You</em>, by increasing the visibility of your academic publications</li>
            <li><em>Libraries</em>, by decreasing our reliance on expensive journal subscriptions</li>
            <li><em>Society</em>, by ensuring that your scholarship is accessible to all</li>
        </ul>
    </p>
</div>
<script>
// this portlet
var portlet = $('#pportlet_d927005c-5b25-4e0f-9250-a49b444f829b').remove()
// dashboard gallery
$('#pportlet_8227ae70-7ba4-42ee-8dfa-9175957a060f').prepend(portlet)
</script>
