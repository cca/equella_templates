<#-- dashboard portlet -->
<#-- server message -->
<div class="clearfix alert" style="font: bold 1.3em/140% Arial">
    <#-- close button -->
    <button type="button" class="close" data-dismiss="alert" style="background-image:none;"><i class="icon-remove"></i></button>

    <h2 class="text-center">Faculty - submit your syllabi!</h2>
    <br>
	<p>
        Upload your syllabi for the Fall semester <a href="https://vault.cca.edu/access/runwizard.do?method=newitem&itemdefUuid=9ec74523-e018-4e01-ab4e-be4dd06cdd68">here</a>. Need assistance? See the <a href="https://vault.cca.edu/items/4eb14fb4-1b10-4527-914c-85610df0fb61/1/">demo upload video</a> or contact the Systems Librarian, <a href="https://portal.cca.edu/people/ephetteplace">Eric Phetteplace</a>.
    </p>
</div>
<script>
// this portlet
var portlet = $('#pportlet_d927005c-5b25-4e0f-9250-a49b444f829b').remove()
// dashboard gallery
$('#pportlet_8227ae70-7ba4-42ee-8dfa-9175957a060f').prepend(portlet)
</script>
