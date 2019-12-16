<#assign help_url = 'https://portal.cca.edu/teaching/academic-affairs/faculty-resources/portal-section-pages-teaching-faculty/#uploading-your-syllabus'>
<div class="control alert alert-warning">
    <p>
        Syllabus uploads are now done via the Portal. <strong><a href="${help_url}">
        Here is the documentation on how to upload syllabi.</a></strong> The
        basic steps are:</p>
    <ol>
        <li><a href="https://portal.cca.edu/login/?next=/" target="_blank">Login</a> to Portal</li>
        <li>Select one of your classes from the <b>My Classes</b> list on the
            home page</li>
        <li>Select <b>Edit</b> and then <b>Upload Syllabi</b></li>
        <li>Select <b>Choose File</b>, locate your syllabus on your hard drive,
            upload it</li>
        <li>Select <b>Upload Syllabus</b> one last time</li>
        <li><strong>Remember to repeat these steps for each section you're
            teaching!</strong></li>
    </ol>
    <p>Still need help? <a href="http://helpdesk.cca.edu/">Contact the Help Desk</a>
    or email <a href="mailto:helpdesk@cca.edu">helpdesk@cca.edu</a>.</p>
</div>
<style>
/* hide save button */
.save.action-button {
    display: none !important;
}
</style>
<script>
// disable annoying dialog that stops you before navigating away
$(document).ready(()=>{
    $('#wizard-controls a').click(()=>{
        window.onbeforeunload = null
        return true
    })
})
</script>
