<#function encode str>
    <#-- 2 encodings:
    1) return a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way
    2) encode "+" e.g. in course titles like "Form + Space"    -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "Thesis">
    <dl>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#-- this is the Design Division power search ID -->
        <#assign powerSearch = 'P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#-- insert URL for appropriate department here -->
            <#assign departmentUrl = "">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
            <dd class="collection">
                <a href="departmentUrl">${encode(department)}</a> | <a href="${divisionUrl}">${encode(division)}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
            <dd><b>Creator:</b> <a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <dd>
            <#assign careers = xml.list('local/courseWorkWrapper/courseWorkTypeSpecific')>
            <b>Career Type(s)</b>: <#list careers as career>${career}<#if career_has_next>, </#if></#list>
        </dd>

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
        <#if abstract != "">
            <dd><b>Description</b>:<br><pre>${abstract}</pre></dd>
        </#if>

        <#-- only show if we actually have something -->
        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#if artistStatementFile != "">
            <h4><u>Senior Thesis</u></h4>
            <#list attachments as attachment>
                <#if artistStatementFile == attachment.get('uuid')>
                    <#assign full = attachment.get('file')>
                    <#assign uuid = attachment.get('uuid')>
                    <div class="image-artistDocs">
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
        </#if>
        <div class="clearfix"></div>
    </dl>
</#if>
</#list>
