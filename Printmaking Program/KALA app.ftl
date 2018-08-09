<#function encode str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "KALA Application">
    <dl>
        <#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#-- insert URL for appropriate department here -->
            <#assign departmentUrl = "/access/searching.do?in=C5da0fa82-2a72-4014-8b5e-66f604f98d22&q=&type=standard&dr=AFTER">
            <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&dr=AFTER">
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&dr=AFTER'>
            <dd><b>Creator:</b> <a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculties = courseInfo.list('faculty')>
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${encode(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <dd><b>Course Info:</b>&nbsp;
            <#if (semester != "undefined") && (semester != "")>
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if (course != "undefined") && (course != "")>
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if (faculties?size != 0)>
                —
                <#list faculties as faculty>
                    <#-- need to do this assignment inside of loop -->
                    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&dr=AFTER" />
                    <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next> / </#if>
                </#list>
            </#if>
        </dd>
        </#list>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>: ${abstract}</dd>
        </#if>

        <#-- only show if we actually have something -->
        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#if artistStatementFile != "">
            <h4><u>Artist Documents</u></h4>
            <#list attachments as attachment>
                <#if artistStatementFile == attachment.get('uuid')>
                    <#assign full = attachment.get('file')>
                    <#assign uuid = attachment.get('uuid')>
                    <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Artist statement</u></i></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>
                    <#if full != "">
                        ${full}
                    </#if>
                    </p>
                    </div>
                </#if>
            </#list>
        </#if>

        <#-- KALA App has letter of intent -->
        <#assign letterOfIntent = xml.get('mods/part/numberB')>
        <#list attachments as attachment>
            <#if letterOfIntent = attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs'><i><u>Letter of Intent</i></u></p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#assign resumeCVFile = xml.get('local/artistDocWrapper/resumeCVFile')>
        <#list attachments as attachment>
            <#if resumeCVFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Resume/CV</u></i></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>
        <div class="clearfix"></div>

        <div class="clearfix">
        <h4><u>Image List</u></h4>
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#-- use loFi for display -->
                <#assign file = seniorPacket.get('lowResFile')>
                <#assign videoFile = seniorPacket.get('fileTypeA')>
                <#-- formatOther is either single or multiple processes
                while technique is list of processes -->
                <#assign numTechniques = seniorPacket.get('formatOther')>
                <#assign techniques = seniorPacket.list('technique')>
                <#assign techniqueOther = seniorPacket.get('techniqueOther')>
                <#-- height/widthINCH are paper/image dimensions in inches -->
                <#assign paperSize = seniorPacket.get('heightINCH')>
                <#assign imageSize = seniorPacket.get('widthINCH')>
                <#-- depthInch is "dimensions" for technique = "book" -->
                <#assign dimensions = seniorPacket.get('depthINCH')>
                <#-- only shows for technique = "video" -->
                <#assign duration = seniorPacket.get('duration')>
                <#-- tags/keywords -->
                <#assign tags = seniorPacket.list('tags')>
                <#-- Description -->
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid || videoFile == uuid>
                    <#-- handle case in which video attachment is a URL -->
                    <#if attachment.get('@type') == 'remote'>
                        <#assign url = full>
                    <#else>
                        <#assign url = "/file/${itemUuid}/${itemversion}/${full?url}">
                    </#if>
                    <div class='image-with-metadata'>
                        <a href="${url}" target="_blank" rel="group"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class='metadata'>
                        <#-- p.photoImagelist i sets display: block
                        in our theme -->
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if date != "">${date}<br></#if>

                        <#if techniques?size != 0>
                            <b>${numTechniques}:</b>&nbsp;
                            <#list techniques as technique>
                                <#if technique != 'other...'>
                                    ${technique}<#if technique_has_next>, </#if>
                                <#else>
                                    ${techniqueOther}<#if technique_has_next>, </#if>
                                </#if>
                            </#list><br>
                        </#if>

                        <#if paperSize != ""><b>Paper size:</b> ${paperSize}<br></#if>
                        <#if imageSize != ""><b>Image size:</b> ${imageSize}<br></#if>
                        <#if dimensions != ""><b>Dimensions:</b> ${dimensions}<br></#if>
                        <#if duration != ""><b>Duration:</b> ${duration}<br></#if>

                        <#if notes != "">${notes}<br></#if>
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
        </div>

</dl>
<script>
$('.image-with-metadata a').fancybox()
</script>
</#if>
</#list>
