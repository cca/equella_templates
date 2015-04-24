<#function encode str>
    <#-- 2 encodings:
    1) return a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way
    2) encode "+" e.g. in course titles like "Form + Space"    -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType == "Senior packet")>
    <dl>
        <#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

        <h2 id="title">${xml.get('mods/titleInfo/title')}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#assign departmentUrl = "/access/searching.do?in=C3c29d46d-73c0-4144-8f2b-7470d5f59134&q=&type=standard&dr=AFTER">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
            <dd><b>Creator:</b> <a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
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
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${encode(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <dd><b>Course Info:</b>&nbsp;
            <#if semester != "">
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if course != "">
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if faculty != "">
                — <a href ="${facultyUrl}">${faculty}</a>
            </#if>
            <#if section!= "">
                — <a href="${sectionUrl}">${section}</a>
            </#if>
        </dd>
        </#list>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>: ${abstract}</dd>
        </#if>

        <div class="clearfix">
        <#-- only show if we actually have something -->
        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#if artistStatementFile != "">
            <h4><u>Artist Documents</u></h4>
            <#list attachments as attachment>
                <#if artistStatementFile == attachment.get('uuid')>
                    <#assign full = attachment.get('file')>
                    <#assign uuid = attachment.get('uuid')>
                    <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Filmmaker statement</u></i></p>
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
        </div>

        <div class="clearfix">
        <h4><u>Image List</u></h4>
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign logLine = seniorPacket.get('notes')>
                <#assign date = seniorPacket.get('date')>
                <#assign categories = seniorPacket.list('formatBroad')>
                <#assign formatOther = seniorPacket.get('formatOther')>
                <#assign duration = seniorPacket.get('duration')>
                <#-- multiple files, this just gets the first one -->
                <#assign image = seniorPacket.get('lowResFile')>
                <#assign video = seniorPacket.get('hiResFile')>
                <#assign synopsis = seniorPacket.get('process')>
                <#if image == uuid>
                <#-- get link for related video -->
                <#list attachments as attachment>
                    <#if attachment.get('uuid') == video>
                        <#assign videoFile = attachment.get('file')>
                        <#assign url = '/file/${itemUuid}/${itemversion}/${videoFile}'>
                    </#if>
                </#list>
                <div class='image-with-metadata'>
                    <a href="${url}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                    <#if title != ""><span class="title">${title}</span></#if>
                    <#if logLine != ""><em>${logLine}</em><br></#if>
                    <#if date != "">${date}<br></#if>
                    <#if duration != ""><b>Duration</b>:&nbsp;${duration}<br></#if>
                    <#if categories?size != 0>
                        <b>Categories:</b>&nbsp;
                        <#list categories as category>
                            <#-- dont print other but its actual value,
                            which is stored elsewhere ("phase" for formatSpecific)
                            the 2nd "formatBroad_has_next" ensure the comma-sep.
                            list doesnt get screwed up while we do this -->
                            <#if category != 'other...'>
                                ${category}<#if category_has_next>, </#if>
                            <#else>
                                ${formatOther}<#if category_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>
                    <#if synopsis != "">${synopsis}<br></#if>
                    </p>
                </div>

                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
