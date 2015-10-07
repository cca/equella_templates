<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign powerSearch = 'Pe78fd93a-86cd-40a9-9382-e86897646a2d'>

<#list courseWork as courseWork>
    <#assign type = courseWork.get('courseWorkType')>
    <#if type == 'Course work'>
    <#-- <dl> closed in viewLevel & access display -->
    <dl>
        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <dt class="hide">Collection</dt>
        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER"/>
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
        <br />

        <#list courseInfo as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign category = courseInfo.get('courseCategory')>
            <#assign specialPrograms = courseInfo.get('specialPrograms')>
            <#assign courseName = courseInfo.get('courseName')>
            <#assign IntroToLit = courseInfo.get('firstYearDimension')>
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign categoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#if semester == ""><i>no course selected</i><#else>
                <dd><span id="WrLitcoursestuff"><strong>Course:</strong>
                <a href="${semesterUrl}">${semester}</a>
                     — <a href="${courseUrl}">${course}</a>
                     — <a href="${facultyUrl}">${faculty}</a>
                     — <a href="${sectionUrl}">${section}</a>
                </span></dd>
            </#if>
            <#if (category != "" && specialPrograms == "")>
                <dd><span id="WrLitcoursestuff"><strong>Course category: </strong>
                    <a href="${courseNameUrl}">${courseName}</a> —
                    <a href="${categoryUrl}">${category}</a>
                </span></dd>
            <#elseif (category != "" && specialPrograms != "")>
                <dd><span id="WrLitcoursestuff"><strong>Course category: </strong>
                    <a href="${courseNameUrl}">${courseName}</a> —
                    <a href="${categoryUrl}">${category}</a> —
                    <a href="${specialProgramsUrl}">${specialPrograms}</a>
                </span></dd>
            <#elseif (category == "" && specialPrograms != "")>
                <dd><span id="WrLitcoursestuff"><strong>Course category: </strong>
                    <a href="${courseNameUrl}">${courseName}</a> —
                    <a href="${specialProgramsUrl}">${specialPrograms}</a>
                </span></dd>
            <#elseif (category == "" && specialPrograms == "")>
                <dd><span id="WrLitcoursestuff"><strong>Course category: </strong>
                    <a href="${courseNameUrl}">${courseName}</a>
                </span></dd>
            <#elseif (category != "" && IntroToLit != "")>
                <dd><span id="WrLitcoursestuff"><strong>Course category: </strong>
                    <a href="${courseNameUrl}">${courseName}</a> —
                    ${IntroToLit}
                </span></dd>
            </#if>
        </#list>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#if (namePart != "")>
                <dd><strong>Student:</strong> ${namePart}
            </#if>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#if (major != "")>
                     — <a href="${majorUrl}">${major}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#assign draftOrFinal = courseWork.get('material')>
        <#assign draftProcess = courseWork.get('process')>
        <#assign draftOrFinalUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3Cmaterial%3E${draftOrFinal}%3C%2Fmaterial%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting%20and%20Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#if draftOrFinal != "">
            <dd><strong>Submission type:</strong>
                 <a href="${draftOrFinalUrl}">${draftOrFinal}</a></dd>
        </#if>
        <#if draftProcess != "">
            <dd><strong>Drafting process:</strong>${draftProcess}</dd>
        </#if>

        <#assign tags = xml.list('local/tags')>
        <#if (tags?size > 0)>
            <dd><strong>Keywords:</strong>
            <#list tags as tag>
                ${tag}<#if tag_has_next>, </#if>
            </#list>
            </dd>
        </#if>
    </#if>
</#list>
