<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign assignmentWrapper = xml.getAllSubtrees('local/assignmentWrapper')>

<dl>
<dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign departmentUrl = "/access/searching.do?in=Ccff0cb78-e353-4e85-a1c8-4a3b359d80bf&q=&sort=datemodified&dr=AFTER"/>
            <#assign divisionUrl = "/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>
        <br/>

<#list title as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}</h2>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign category = courseInfo.get('courseCategory')>
    <#assign specialPrograms = courseInfo.get('specialPrograms')>
    <#assign courseName = courseInfo.get('courseName')>
    <#assign courseinfo = courseInfo.get('courseinfo')>
    <#-- @todo check dynamic URLs
    copypasta: %3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E
    -->
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical%20Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#if semester == ""><i>no course selected</i><#else>
        <dd><a href="${semesterUrl}">${semester}</a>
                 — <a href="${courseUrl}">${course}</a>
                 (<a href="${courseNameUrl}">${courseName}</a>)
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
        </dd>
    </#if>

    <#-- @todo no student work currently but when it's available check that this works
    <#assign studentWorkUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical+Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Ccourseinfo%3E${courseinfo}%3C%2Fcourseinfo%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
   <dd>See <a href="${studentWorkUrl}">student work from this assignment</a>.</dd> -->
</#list>

<dt>Assignment Information</dt>

<#assign reviews = xml.list('local/assignmentWrapper/review')>
<#list assignmentWrapper as assignmentWrapper>
    <#assign title = assignmentWrapper.get('title')>
    <#assign description = assignmentWrapper.get('description')>
    <#assign assignmentDue = assignmentWrapper.get('assignmentDue')>
    <#assign assignmentLength = assignmentWrapper.get('assignmentLength')>
    <#assign process = assignmentWrapper.get('process')>
    <#assign references = assignmentWrapper.get('references')>
    <#assign type = assignmentWrapper.get('type')>
    <#assign typeSpecific = assignmentWrapper.get('typeSpecific')>
    <#assign typeOther = assignmentWrapper.get('typeOther')>
    <#assign typeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical+Studies%3C%2Fdepartment%3E%3CassignmentWrapper%3E%3Ctype%3E${type}%3C%2Ftype%3E%3C%2FassignmentWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />

    <dd><strong>Category:</strong> <a href="${typeUrl}">${type}</a>
    </dd>

    <#if description != "">
        <dd><strong>Description:</strong> ${description}</dd>
    </#if>
    <#if references != "">
        <dd><strong>Assignment text / resources:</strong> ${references}</dd>
    </#if>
    <#if (assignmentDue == "") || (assignmentDue == "other")><#else>
        <dd><strong>Assignment duration:</strong> ${assignmentLength} through ${assignmentDue}</dd>
    </#if><div style="clear:both;"></div>
    <#if (process == "draft required" && reviews?size > 0)>
        <dd><strong>Drafting process:</strong> ${process} —
        <#list reviews as review>
            ${review}<#if review_has_next>, </#if>
        </#list>
        </dd>
    <#elseif process == "no draft required">
        <dd><strong>Drafting process:</strong> ${process}</dd>
    </#if>

    <#assign programLOs = xml.list('local/programLearningOutcomes')>
    <#assign skills = xml.list('local/skills')>
    <#assign ccaLOs = xml.list('local/ccaLearningOutcome')>
    <#list local as local>
        <#assign critiqueStrategy = local.get('critiqueStrategy')>
        <#if critiqueStrategy != "">
            <dd><strong>Feedback Strategy:</strong> ${critiqueStrategy}</dd>
        </#if>

        <#if (skills?size > 0 )>
            <dd><strong>Skills Learning Outcomes:</strong></dd>
            <dd><ul>
            <#list skills as skill>
                <li>${skill}</li>
            </#list>
            </ul></dd>
        </#if>

        <#if (programLOs?size > 0 )>
            <dd><strong>Knowledge Learning Outcomes:</strong></dd>
            <dd><ul>
            <#list programLOs as programLO>
                <li>${programLO}</li>
            </#list>
            </ul></dd>
        </#if>

        <#if (ccaLOs?size > 0 )>
            <dd><strong>CCA Learning Outcomes:</strong></dd>
            <dd><ul>
            <#list ccaLOs as ccaLO>
                <li><a href="/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3ECritical+Studies%3C%2Fdepartment%3E%3CccaLearningOutcome%3E${ccaLO}%3C%2FccaLearningOutcome%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER">${ccaLO}</a></li>
            </#list>
            </ul></dd>
        </#if>
    </#list>
</#list>
</dl>
