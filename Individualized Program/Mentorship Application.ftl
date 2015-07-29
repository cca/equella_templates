<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<style>
/* excerpted from zebratable.css
at p/r/6.3.r2083/com.tle.web.sections.equella/css/component/zebratable.css
with the version string in there making the URL un-reusable */
table.zebra {
	width: 100%;
	margin: 10px 0;
}
table.zebra tr th {
	color: #666; /* to match color of headers */
	text-align: left;
	vertical-align: middle;
	white-space: nowrap;
}
table.zebra.large th {
	padding: 13px 11px 12px;
}
table.zebra tr td {
	text-align: left;
	vertical-align: top;
}
table.zebra.large tr td {
	font-size: 12px;
	padding: 11px 11px 9px;
	line-height: 1.5;
}

/* override our own customizations */
table.zebra.large tbody tr.odd td:hover,
table.zebra.large tbody tr.even td:hover {
    padding-left: 11px;
}
</style>

<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#if (courseWorkType == "Mentorship Application")>
<dl>
    <#assign itemUuid = xml.get('item/@id')>
    <#assign itemversion = xml.get('item/@version')>
    <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#assign division = xml.get('local/division')>
    <#assign department = xml.get('local/department')>
    <#assign departmentUrl = '/access/searching.do?in=Ce6b0e79c-82c8-4521-9c80-861abb629a6e&q=&type=standard'>
    <#if division != "">
        <dt class="hide">Collection</dt>
        <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
    </#if>

    <dt>Creator</dt>
    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
        <dd><a href="${namePartUrl}">${namePart}</a>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign gradDate = subName.get('gradDate')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
            <#if gradDate != "">
                 — Graduating: <a href="${gradDateUrl}">${gradDate}</a>
            </#if>
        </#list>
        </dd>
    </#list>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign department = xml.get('local/department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dt>Course Info</dt>
        <span id="coursestuff">
        <#if (semester != "undefined") && (semester != "")>
            <a href="${semesterUrl}">${semester}</a>
        </#if>
        <#if (department != "undefined") && (department != "")>
            — <a href ="${departmentUrl}">${department}</a>
        </#if>
        <#if (course != "undefined") && (course != "")>
            — <a href ="${courseUrl}">${course}</a>
        </#if>
        <#if (faculty != "undefined") && (faculty != "")>
            — <a href ="${facultyUrl}">${faculty}</a>
        </#if>
        <#if (section != "")>
            — <a href ="${sectionUrl}">${section}</a>
        </#if>
        </span>
     </#list>

    <#-- only show if we actually have something -->
    <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
    <#-- in Mentorship App the resumeCV is their rationale document -->
    <#assign resumeCVFile = xml.get('local/artistDocWrapper/resumeCVFile')>
    <#-- in Mentorship App the part/number is their curriculum plan -->
    <#assign plan = xml.get('mods/part/number')>
    <#-- INDV uses Artist's Website too -->
    <#assign website = xml.get('mods/relatedItem/location')>
    <#if artistStatementFile != "" || resumeCVFile != "" || plan != "" || website != "">
        <h4>Artist Documents</h4>
    </#if>
    <#list itemAttachments as itemAttachment>
        <#if artistStatementFile == itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <#-- artist statement is called "Statement of Intent"
            in the Mentorship App -->
            <p class='artistDocs'><i><u>Statement of Intent</u></i></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <p class='artistDocs'>
            <#if full != "">
                ${full}
            </#if>
            </p>
            </div>
        </#if>
        <#if resumeCVFile == itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Rationale</u></i></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        <#if plan == itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Curriculum Plan</u></i></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
    </#list>

    <#if website != "">
        <#-- fix website URLs without schemes, causes broken link -->
        <#if ! website?starts_with('http')>
            <#assign website = 'http://' + website>
        </#if>
        <div class="image-artistDocs">
            <p class="artistDocs"><i><u>Website</u></i></p>
            <p><a href="${website}">${website}</a></p>
        </div>
    </#if>

    <div class="clearfix"></div>

    <div class="clearfix">
    <h4>Image List</h4>
    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
            <#assign title = seniorPacket.get('title')>
            <#assign semester = seniorPacket.get('semester')>
            <#assign formatSpecific = seniorPacket.get('formatSpecific')>
            <#-- duration is dimensions for INDIV -->
            <#assign dimensions = seniorPacket.get('duration')>
            <#-- note: where file is stored & which files we want to
            display will vary by collection
            INDIV only uses hiResFile & they're not TIFFs -->
            <#assign file = seniorPacket.get('hiResFile')>
            <#--
            <#assign heightINCH = seniorPacket.get('heightINCH')>
            <#assign widthINCH = seniorPacket.get('widthINCH')>
            -->
            <#assign notes = seniorPacket.get('notes')>
            <#if file == uuid>
            <div class='image-photoSeniorPacket'>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='photoImagelist'>
                <#-- p.photoImagelist i sets display: block
                in our theme -->
                <#if title != ""><i>${title}</i></#if>
                <#if semester != "">${semester}<br></#if>
                <#if formatSpecific != "">${formatSpecific}<br></#if>
                <#if dimensions != "">${dimensions}<br></#if>
                <#if notes != "">${notes}</#if>
                </p>
            </div>

            </#if>
        </#list>
    </#list>
    </div>

    <div class="clearfix">
        <h4>Curriculum Plan Courses</h4>
        <table class="zebra large">
            <thead>
                <tr>
                    <th>Semester</th>
                    <th>Course Title</th>
                    <th>Credits</th>
                </tr>
            </thead>
            <tbody>
                <#assign odd = true>
                <#list xml.getAllSubtrees('/local/individualizedWrapper/curriculumPlanWrapper') as wrapper>
                <#-- alternate classes for the zebra striping style -->
                    <#if odd>
                        <#assign class = 'odd'>
                    <#else>
                        <#assign class = 'even'>
                    </#if>
                    <#assign odd = !odd>
                    <tr class="${class}">
                        <td>${wrapper.get('semester')}</td>
                        <td>${wrapper.get('course')}</td>
                        <td>${wrapper.get('credits')}</td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </div>
</dl>
</#if>
