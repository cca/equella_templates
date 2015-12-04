<#assign collectionID = 'C7ca03329-3b33-4ace-8883-4b728bdb78e2'>

<dt class="hide">Collection</dt>
<#assign collection = xml.get('collection')>
<#assign searchUrl = '/access/searching.do?in=${collectionID}&q='>
<dd class="collection">
    <a href="${searchUrl}">${collection}</a>
</dd>

<#assign title = xml.get('mods/titleInfo/title')>
<#if title != ''><h2 id="title">${title}</h2></#if>

<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign department = courseInfo.get('department')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#if semester != "">
        <dt>Course Info</dt>
        <span id="namestuff">
            ${semester}
            — ${department}
            — ${course}
            — ${faculty}
            — ${section}
        </span>
    </#if>
</#list>

<dt>Document Details</dt>

<#assign type = xml.get('/mods/typeOfResourceWrapper/typeOfResource')>
<dd><b>Type of Documents:</b> ${type}</dd>

<#assign completeness = xml.get('/mods/noteWrapper/note')>
<#if completeness == "incomplete">
    <div class="alert text-error">
        This is an <em>incomplete</em> set of files; the instructor will upload further documents at a later date.<br><br>
        If you are the instructor, you can add additional files by the selecting the <b class="js-nv-test"><u>Create a new version</u></b> link under the right-side <b>Actions</b> menu.
    </div>
</#if>

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != "">
    <dd>
        <b>Notes:</b><br>
        <pre>${abstract}</pre>
    </dd>
</#if>

<script>
$(function(){

// new version link tricks, yo
var nv = $('#nv_link')
if (nv.length) $('.js-nv-test').html(nv.clone())

})
</script>
