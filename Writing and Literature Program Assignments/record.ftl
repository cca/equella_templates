<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
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
            <#assign divisionUrl = "/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER"/>
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>
        <br/>

<#list title as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}
    </h2>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign category = courseInfo.get('courseCategory')>
    <#assign specialPrograms = courseInfo.get('specialPrograms')>
    <#assign courseName = courseInfo.get('courseName')>
    <#assign XList = courseInfo.get('XList')>
    <#assign WRLITxLITPA = courseInfo.get('secondXList')>
    <#assign courseinfo = courseInfo.get('courseinfo')>
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign categoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign XListUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign WRLITxLITPAUrl = "">
    <#if (semester == "")><i>no course selected</i><#else>
    <dd><span id="WrLitcoursestuff"><a href="${semesterUrl}">${semester}</a>
             — <a href="${courseUrl}">${course}</a>
             (<a href="${courseNameUrl}">${courseName}</a>)
             — <a href="${facultyUrl}">${faculty}</a>
             — <a href="${sectionUrl}">${section}</a>
    </span></dd>
    </#if>
    <#if (category != "")&&(specialPrograms == "")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${categoryUrl}">${category}</a>
        </span></dd>
    <#elseif (category != "")&&(specialPrograms != "")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${categoryUrl}">${category}</a> —
            <a href="${specialProgramsUrl}">${specialPrograms}</a>
        </span></dd>
    <#elseif (category == "")&&(specialPrograms != "")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${specialProgramsUrl}">${specialPrograms}</a>
        </span></dd>

    </#if>
    <#if (XList != "")>
        <dd><span id="WrLitcoursestuff">
             Course is cross-listed with <a href="${XListUrl}">${XList}</a>
             <#if (WRLITxLITPA != "")>
                (${WRLITxLITPA}).
             <#elseif (WRLITxLITPA == "")>.
             </#if>
        </dd>
    </#if>
    <#assign studentWorkUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Ccourseinfo%3E${courseinfo}%3C%2Fcourseinfo%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <dd>Click <a href="${studentWorkUrl}" target="_blank">HERE to see student work</a> from this assignment.</dd>

</#list>

<dt>Assignment Information</dt>

<#assign review = xml.getAllSubtrees('local/assignmentWrapper/review')>
<#list assignmentWrapper as assignmentWrapper>
    <#assign title = assignmentWrapper.get('title')>
    <#assign description = assignmentWrapper.get('description')>
    <#assign assignmentDue = assignmentWrapper.get('assignmentDue')>
    <#assign assignmentLength = assignmentWrapper.get('assignmentLength')>
    <#assign process = assignmentWrapper.get('process')>
    <#assign reviewX = assignmentWrapper.get('review')>
    <#assign references = assignmentWrapper.get('references')>
    <#assign type = assignmentWrapper.get('type')>
    <#assign typeSpecific = assignmentWrapper.get('typeSpecific')>
    <#assign typeOther = assignmentWrapper.get('typeOther')>
    <#assign typeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3E${type}%3C%2Ftype%3E%3C%2FassignmentWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign typeSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3EAnalytical%3C%2Ftype%3E%3CtypeSpecific%3E${typeSpecific}%3C%2FtypeSpecific%3E%3C%2FassignmentWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">
    <#assign typeOtherUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3EAnalytical%3C%2Ftype%3E%3CtypeSpecific%3Eother+category+of+analysis%3C%2FtypeSpecific%3E%3CtypeOther%3E${typeOther}%3C%2FtypeOther%3E%3C%2FassignmentWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&dr=AFTER">

    <dd><strong>Category:</strong> <a href="${typeUrl}">${type}</a>
        <#if typeSpecific == "other category of analysis"> — <a href="${typeOtherUrl}">${typeOther}</a>
        <#elseif typeSpecific != ""> — <a href="${typeSpecificUrl}">${typeSpecific}</a>
        </#if>
    </dd>

    <#if (description != "")>
        <dd><strong>Description:</strong><br><pre>${description}</pre></dd>
    </#if>
    <#if (references != "")>
        <dd><strong>Assignment text resources:</strong> ${references}</dd>
    </#if>
    <#if (assignmentDue == "" || assignmentDue == "other")><#else>
        <dd><strong>Assignment duration:</strong> ${assignmentLength} through ${assignmentDue}</dd>
    </#if><div style="clear:both;"></div>
    <#if (process == "draft required" && reviewX != "")>
        <dd><strong>Drafting process:</strong> ${process} —
        <#list review as review>${review}<#if review_has_next>, </#if>
        </#list>
        </dd>
    <#elseif (process == "no draft required")>
        <dd><strong>Drafting process:</strong> ${process}</dd>
    </#if>

    <#list local as local>
        <#assign critiqueStrategy = local.get('critiqueStrategy')>
        <#if critiqueStrategy != "">
            <dd><strong>Feedback Strategy:</strong> ${critiqueStrategy}</dd>
        </#if>

        <#assign programLOs = xml.list('local/assignmentWrapper/programLOWrapper/programLO')>
        <#if programLOs?size != 0>
            <dd><strong>Program Learning Outcomes:</strong></dd>
            <ul class="standard">
                <#list programLOs as programLO><li>${programLO}</li></#list>
            </ul>
        </#if>

        <#assign genEdLOs = local.list('programLearningOutcomes')>
        <#if genEdLOs?size != 0>
            <dd><strong>GenEd Learning Outcomes:</strong></dd>
            <ul class="standard">
                <#list genEdLOs as genEdLO><li>${genEdLO}</li></#list>
            </ul>
        </#if>

        <#assign ccaLOs = local.list('ccaLearningOutcome')>
        <#if ccaLOs?size != 0>
            <dd><strong>CCA Learning Outcomes:</strong></dd>
            <ul class="standard">
                <#list ccaLOs as ccaLO><li>${ccaLO}</li></#list>
            </ul>
        </#if>
    </#list>
</#list>
</dl>
