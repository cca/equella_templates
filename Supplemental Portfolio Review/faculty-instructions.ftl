<!-- if user isn't a Student Contributor -->
<#if user.doesntHaveRole('89ea364f-066e-1a3f-f70e-4b29f08e8448')>
    <style>
    /* so button text doesn't underline on hover */
    #content-body a:hover { text-decoration: none; }
    </style>

    <dt>Instructions for Faculty</dt>
    <dd>Enter a comment specifiying which courses, if any, the student is able to pass out of given the skills demonstrated in this portfolio. Then press the <button class="btn btn-equella btn-mini" type="button"><i class="icon-plus icon-white"></i> Add comment</button> button below. <a href="#" onclick="$('#faculty-comment').toggle('fast');return false">Click here</a> to see an example comment.</dd>
    <img id="faculty-comment" src="/file/65522e83-d889-466e-ab38-ede1315b4164/1/example-comment.png" alt="example comment" style="display:none;width:97%">
    <br>

    <dd><b>Does the student need to amend their portfolio?</b> Use the button below to contact Advising.</dd>
    <!-- @TODO advising will send me different email to use -->
    <#assign advising = 'advisingrecord@cca.edu'>
    <#assign title = xml.get('mods/titleInfo/title')>
    <#assign root = 'https://vault.cca.edu/login.do?page='>
    <#assign url = root + xml.get('/itemdir')>
    <#assign name = xml.get('mods/name/namePart')>
    <!-- construct email link with relevant info filled in -->
    <#assign email = 'mailto:' + advising + '@cca.edu?subject=Re:%20' + title?url + '&body=' + 'Link to item in VAULT: '?url + url + '\nStudent: '?url + name>
    <a class="btn btn-info btn-large" href="${email}">
        <i class="icon-envelope"></i>&nbsp;Email Advising
    </a>
    <br>
</#if>
