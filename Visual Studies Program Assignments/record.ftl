<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign assignmentWrapper = xml.getAllSubtrees('local/assignmentWrapper')>
<dl>

<dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#-- <dd>${division} -->
            <#assign department = local.get('department')>
            <#-- <dd>${department} -->
            <#assign divisionUrl = "https://vault.cca.edu/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER"/>
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
    <#assign courseinfo = courseInfo.get('courseinfo')>
    <#-- <dd>${course} -->
    <#-- <dd>${semester} -->
    <#-- <dd>${faculty} -->
    <#-- <dd>${section} -->
    <#-- <dd>${category} -->
    <#-- <dd>${courseName} -->
    <#-- <dd>${specialPrograms} -->
    <#-- <dd>${XList} -->
    <#-- <dd>${courseinfo} -->
    <#assign courseUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign categoryUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign courseNameUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign specialProgramsUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${category}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign XListUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign WRLITxLITPAUrl = "" />
    <#if (semester=="")><i>no course selected</i><#else>
    <dd><span id="WrLitcoursestuff"><a href="${semesterUrl}">${semester}</a>
             — <a href="${courseUrl}">${course}</a>
             (<a href="${courseNameUrl}">${courseName}</a>)
             — <a href="${facultyUrl}">${faculty}</a>
             — <a href="${sectionUrl}">${section}</a>
    </span></dd>
    </#if>
    <#if (category!="")&&(specialPrograms=="")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${categoryUrl}">${category}</a>
        </span></dd>
    <#elseif (category!="")&&(specialPrograms!="")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${categoryUrl}">${category}</a> —
            <a href="${specialProgramsUrl}">${specialPrograms}</a>
        </span></dd>
    <#elseif (category=="")&&(specialPrograms!="")>
        <dd><span id="WrLitcoursestuff">
            Course category:
            <a href="${specialProgramsUrl}">${specialPrograms}</a>
        </span></dd>

    </#if>
    <#assign studentWorkUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourseinfo%3E${courseinfo}%3C%2Fcourseinfo%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
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
    <#-- <dd>${type} -->
    <#-- <dd>${typeSpecific} -->
    <#-- <dd>${typeOther} -->
    <#assign typeUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3E${type}%3C%2Ftype%3E%3C%2FassignmentWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign typeSpecificUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3EAnalytical%3C%2Ftype%3E%3CtypeSpecific%3E${typeSpecific}%3C%2FtypeSpecific%3E%3C%2FassignmentWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign typeOtherUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CassignmentWrapper%3E%3Ctype%3EAnalytical%3C%2Ftype%3E%3CtypeSpecific%3Eother+category+of+analysis%3C%2FtypeSpecific%3E%3CtypeOther%3E${typeOther}%3C%2FtypeOther%3E%3C%2FassignmentWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />

    <dd><strong>Category:</strong> <a href="${typeUrl}">${type}</a>
        <#if typeSpecific=="other category of analysis"> — <a href="${typeOtherUrl}">${typeOther}</a>
        <#elseif typeSpecific!=""> — <a href="${typeSpecificUrl}">${typeSpecific}</a>
        </#if>
    </dd>

    <#if (description=="")><#else>
        <dd><strong>Description:</strong> ${description}</dd>
    </#if>
    <#if (references=="")><#else>
        <dd><strong>Assignment text / resources:</strong> ${references}</dd>
    </#if>
    <#if (assignmentDue=="") || (assignmentDue=="other")><#else>
        <dd><strong>Assignment duration:</strong> ${assignmentLength} through ${assignmentDue}</dd>
    </#if><div style="clear:both;"></div>
    <#if (process=="draft required") && (reviewX!="")>
        <dd><strong>Drafting process:</strong> ${process} —
        <#list review as review>${review}<#if review_has_next>, </#if>
        </#list>
        </dd>
    <#elseif (process=="no draft required")>
        <dd><strong>Drafting process:</strong> ${process}</dd>
    </#if>

    <#assign programLO = xml.getAllSubtrees('local/programLearningOutcomes')>
    <#assign skills = xml.getAllSubtrees('local/skills')>
    <#assign ccaLO = xml.getAllSubtrees('local/ccaLearningOutcome')>
    <#list local as local>
        <#assign critiqueStrategy = local.get('critiqueStrategy')>
        <#assign ccaLOx = local.get('ccaLearningOutcome')>
        <#assign programLOx = local.get('programLearningOutcomes')>
        <#assign skillsx = local.get('skills')>
        <#if (critiqueStrategy=="")><#else>
            <dd><strong>Feedback Strategy:</strong> ${critiqueStrategy}</dd>
        </#if>

        <dd><strong>Skills Learning Outcomes:</strong></dd>
            <#if skillsx==""><#else>
                <dd>
                <#list skills as skills>&bull; ${skills}<#if skills_has_next><br/></#if>
                </#list>
                </dd>
            </#if>

        <dd><strong>Knowledge Learning Outcomes:</strong></dd>
            <#if programLOx==""><#else>
                <dd>
                <#list programLO as programLO>&bull; ${programLO}<#if programLO_has_next><br/></#if>
                </#list>
                </dd>
            </#if>

        <dd><strong>CCA Learning Outcomes:</strong></dd>
            <#if ccaLOx==""><#else>
                <dd>
                <#list ccaLO as ccaLO>&bull; ${ccaLO}<#if ccaLO_has_next><br/></#if>
                </#list>
                </dd>
            </#if>
    </#list>
</#list>
</dl>
