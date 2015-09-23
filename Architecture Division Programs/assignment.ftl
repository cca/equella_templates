<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign powerSearch = 'Pafcc42be-462c-483e-b2ed-98ffcd15ff3d'>

<#if xml.get('local/courseWorkWrapper/submissionType') == "Assignment">
<dl>

    <#assign department = xml.get('local/department')>
    <#assign division = xml.get('local/division')>
    <dt class="hide">Division</dt>
    <#assign divisionUrl = "/access/searching.do?in=C1ca1ba6f-e327-4557-9b7e-25e1bba1b359&q=&type=standard&dr=AFTER">
    <dd class="collection">
        <#if department != "">
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&type=standard&dr=AFTER">
            <a href="${departmentUrl}">${department}</a>&nbsp;|&nbsp;
        </#if>
        <a href="${divisionUrl}">${division}</a>
    </dd>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign department = courseInfo.get('department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseCategory = courseInfo.get('courseCategory')>
        <#assign XList = courseInfo.get('XList')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />

        <#if semester != "" && semester != "undefined">
            <span id="coursestuff"><strong>Course</strong>:
                <a href="${semesterUrl}">${semester}</a>
                 — <a href="${departmentUrl}">${department}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
                 <#if XList != "">
                     <br>(Cross-listed as ${XList}.)
                 </#if>
            </span>
        </#if>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dt>Notes</dt>
        <dd>${abstract}</dd>
    </#if>
</#if>
