<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
<#assign artistDoc = xml.getAllSubtrees('local/artistDocWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign part = xml.getAllSubtrees('mods/part')>
<#assign jpgfileWrapper = xml.getAllSubtrees('local/jpgfileWrapper')>

<dl>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "Course work">

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <h2 id="title">${title}
        </h2>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign department = local.get('department')>
        <#assign departmentUrl = '/access/searching.do?in=Cdd83789b-f726-47e1-8a5f-626450d226a0&q=&type=standard'>
        <#assign division = local.get('division')>
        <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
    </#list>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list jpgfileWrapper as jpgfileWrapper>
            <#-- check if
            a) user doesn't have special "Comm Student Work Viewer Role"
            b) user is in Communications
            (the Group IDs here are Communications & Communications Workstudy)
            & c) item isn't specifically marked for sharing
            no field right now but that looks like "&& jpgfileWrapper.get('shared') != 'yes'")
            hide attachments & image itself if those are both true -->
            <#if ( user.doesntHaveRole('b8b91d93-ede5-4c34-84df-09d5b6bf27e5') && user.isMemberOfGroup('8264db8a-5036-0be2-fecb-fd2e2ba80a8e') || user.isMemberOfGroup('7d9339b9-aa7c-49db-80bf-cd6cc713c3ab') ) >
                <#-- hide attachments box -->
                <style>
                #sc_attachments_div {
                    display: none;
                }
                </style>
                <#-- hide header (can't target with CSS, too generic) -->
                <script>
                (function($){
                    $(function(){
                        $('h3:contains("Links to resources")').remove();
                    });
                }(jQuery));
                </script>
                <#-- don't display this item -->
                <#assign hidden = true>
            <#else>
                <#assign hidden = false>
            </#if>

            <#assign jpgfile = jpgfileWrapper.get('jpgFile')>
            <#list part as part>
                <#assign partnumber = part.get('number')>
                <#if jpgfile == uuid && hidden == false>
                    <div class="image-studentWork">
                        <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class="photoImagelist">
                        ${full}
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
    </#list>

    <div style="clear:both;"></div>

    <dt>Creator</dt>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
        <dd><a href="${namePartUrl}">${namePart}</a>
            <#list subNameWrapper as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != ""> — Graduated: <a href="${gradDate}">${gradDate}</a></#if>
            </#list>
        </dd>
    </#list>

    <#assign faculty = xml.getAllSubtrees('local/courseInfo/faculty')>
    <#list courseInfo as courseInfo>
    <#list local as local>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign facultyx = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign department = local.get('department')>
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dt>Course Info</dt>
            <span id="coursestuff">
                <#if (semester != "undefined") && (semester != "")>
                    <a href="${semesterUrl}">${semester}</a>
                </#if>
                <#if (course != "undefined") && (course != "")>
                    — <a href="${courseUrl}">${course}</a>
                </#if>
                <#if (facultyx != "undefined") && (facultyx != "")>
                    —
                    <#list faculty as faculty>
                        <#-- since faculty can hold multiple items
                        need to do assignment inside of this loop -->
                        <#assign facultyName = faculty.get('/')>
                        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${facultyName}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                        <a href ="${facultyUrl}">${facultyName}</a><#if faculty_has_next> / </#if>
                    </#list>
                </#if>
                <#if (section != "undefined") && (section != "")>
                    — <a href="${sectionUrl}">${section}</a>
                </#if>
            </span>
    </#list>
    </#list>

    <dt>Work Description</dt>
    <#list physdesc as physdesc>
    <#list local as local>
        <#assign formBroad = physdesc.get('formBroad')>
        <#assign formSpecific = physdesc.get('formSpecific')>
        <#assign extent = physdesc.get('extent')>
        <#assign digitalOrigin = physdesc.get('digitalOrigin')>
        <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign department = local.get('department')>
        <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dd>
            <#if formBroad != "">
                <a href="${formBroadUrl}">${formBroad}</a>
            </#if>
            <#if formBroad != "" && formSpecific != ""> — </#if>
            <#if formSpecific != ""><a href="${formSpecificUrl}">${formSpecific}</a></#if>
            <#if (formBroad != "" || formSpecific != "") && (digitalOrigin != "")>
                 - ${digitalOrigin}
            </#if>
        </dd>
        <#if extent != ""><dd>Measurements/Duration: ${extent}</dd></#if>
    </#list>
    </#list>

    <#list date as date>
        <#assign dateCreated = date.get('dateCreated')>
        <#if dateCreated != "">
            <#-- this is reformatted to a friendly looking date with JS -->
            <dd class="date">Date created: ${dateCreated}</dd>
        </#if>
        <div style="clear:both;"></div>
    </#list>

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if abstract != "">
            <dd>Description:<br><pre>${abstract}</pre></dd>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatement') as artistStatementFile>
        <#list itemAttachments as itemAttachment>
            <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#-- needs more spacing here -->
                <br><br>
                <div class="image-artistDocs">
                <p class="artistDocs"><i><u>Artist statement</u></i></p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class="artistDocs">
                    <#if full != "">
                        ${full}
                    </#if>
                </p>
                </div>
            </#if>
        </#list>
    </#list>

<div style="clear:both;"></div>
</#if>
</#list>
