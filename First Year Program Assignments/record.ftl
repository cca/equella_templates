<#function currentUserIsMemberOf targetGroup>
    <#assign allowedGroupID = "" >
    <#list user.searchGroups("") as group>
        <#if group.getName() == targetGroup>
            <#assign allowedGroupID = group.getUniqueID()>
            <#break>
        </#if>
    </#list>
    <#if allowedGroupID != "" && user.isMemberOfGroup(allowedGroupID)>
        <#return true>
    </#if>
    <#return false>
</#function>

<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign assignmentWrapper = xml.getAllSubtrees('local/assignmentWrapper')>
<dl>
<#list title as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}
    </h2>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign department = courseInfo.get('department')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign firstYearDimension = courseInfo.get('firstYearDimension')>
    <#-- <dd>${course} -->
    <#-- <dd>${department} -->
    <#-- <dd>${semester} -->
    <#-- <dd>${faculty} -->
    <#-- <dd>${section} -->
    <#-- <dd>${firstYearDimension} -->
    <#assign courseUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign firstYearDimensionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CfirstYearDimension%3E${firstYearDimension}%3C%2FfirstYearDimension%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=name&dr=AFTER" />
    <#assign departmentUrl = "" />
    <#if (semester=="")><#else>
    <dt>Course Information</dt>
    <span id="namestuff"><a href="${semesterUrl}">${semester}</a>
        <#if (department=="CORE Studio/First Year")>
            <#else> — <a href="${departmentUrl}">${department}</a>
        </#if>
        <#if (firstYearDimension=="undefined")>
            <#else> — <a href="${firstYearDimensionUrl}">${firstYearDimension}</a>
        </#if>
        <#if (course=="undefined")>
            <#else> — <a href="${courseUrl}">${course}</a>
        </#if>
        <#-- Administrator only information-->
        <#if currentUserIsMemberOf("First Year External Reviewers")><#else>
            <#if faculty=="undefined">
                <#else> — <a href="${facultyUrl}">${faculty}</a>
            </#if>
            <#if section=="undefined">
                <#else> — <a href="${sectionUrl}">${section}</a>
            </#if>
        </#if>
    </span>
    </dd>
    </#if>
</#list>

<#list assignmentWrapper as assignmentWrapper>
    <#assign title = assignmentWrapper.get('title')>
    <#assign description = assignmentWrapper.get('description')>
    <#assign assignmentDue = assignmentWrapper.get('assignmentDue')>
    <#assign assignmentDueText = assignmentWrapper.get('assignmentDue_freetext')>
    <#assign assignmentLength = assignmentWrapper.get('assignmentLength')>
    <#assign assignmentLengthText = assignmentWrapper.get('assignmentLength_freetext')>
    <#assign references = assignmentWrapper.get('references')>

    <dt>Assignment Information</dt>
    <#if (description=="")><#else>
        <dd><strong>Description:</strong> ${description}</dd>
    </#if>
    <#if (assignmentDue=="") || (assignmentDue=="other")><#else>
        <dd><strong>Assignment occurred during:</strong> ${assignmentDue}</dd>
    </#if>
    <#if (assignmentDueText=="")><#else>
        <dd><strong>Assignment occurred during:</strong> ${assignmentDueText}</dd>
    </#if>
    <#if (assignmentLength=="") || (assignmentLength=="other")><#else>
        <dd><strong>Assignment length:</strong> ${assignmentLength}</dd>
    </#if>
    <#if (assignmentLengthText=="")><#else>
        <dd><strong>Assignment length:</strong> ${assignmentLengthText}</dd>
    </#if>
    <#if (references=="")><#else>
        <dd><strong>Assignment references:</strong> ${references}</dd>
    </#if>

    <#assign skills = xml.getAllSubtrees('local/skills')>
    <#assign skills_freetext = xml.getAllSubtrees('local/skills_freetext')>
    <#assign ccaValues = xml.getAllSubtrees('local/ccaValues')>
    <#list local as local>
        <#assign skillsx = local.get('skills')>
        <#assign skillsText = local.get('skills_freetext')>
        <#assign thinkingProcesses = local.get('thinkingProcesses')>
        <#assign critiqueStrategy = local.get('critiqueStrategy')>
        <#assign ccaValuesx = local.get('ccaValues')>
        <#assign ccaValuesText = local.get('ccaValues_freetext')>
        <#if (skillsx=="")><#else>
            <dd><strong>Skills used in work:</strong>
            <#list skills as skills>
                ${skills}<#if skills_has_next>; </#if>
            </#list>
            </dd>
        </#if>
        <#if (skillsText=="")><#else>
            <dd><strong>Other skills:</strong> ${skillsText}</dd>
        </#if>
        <#if (thinkingProcesses=="")><#else>
            <dd><strong>Thinking Processes:</strong> ${thinkingProcesses}</dd>
        </#if>
        <#if (critiqueStrategy=="")><#else>
            <dd><strong>Critique Strategy:</strong> ${critiqueStrategy}</dd>
        </#if>


    <#if ('/local/assignmentWrapper/programLOWrapper/programLO')!=''>
        <dd><strong>Program Learning Outcomes:</strong></dd>
        <#list assignmentWrapper.getAllSubtrees('programLOWrapper') as programLOWrapper>
            <#assign programLO = programLOWrapper.get('programLO')>
            <dd>${programLO}</dd>
        </#list>
    <#else></#if>

    <#if ('/local/assignmentWrapper/ccaLOWrapper/ccaLO')!=''>
        <dd><strong>CCA Learning Outcomes:</strong></dd>
        <#list assignmentWrapper.getAllSubtrees('ccaLOWrapper') as ccaLOWrapper>
            <#assign ccaLO = ccaLOWrapper.get('ccaLO')>
            <dd>${ccaLO}</dd>
        </#list>
    <#else></#if>

    <#if ('/local/assignmentWrapper/teachStrategyWrapper/teachStrategy')!=''>
        <dd><strong>Teaching Strategies:</strong></dd>
        <#list assignmentWrapper.getAllSubtrees('teachStrategyWrapper') as teachStrategyWrapper>
            <#assign teachStrategy = teachStrategyWrapper.get('teachStrategy')>
            <#assign teachStrategy_freetext = teachStrategyWrapper.get('teachStrategy_freetext')>
            <dd>${teachStrategy_freetext}</dd>
            <dd>${teachStrategy}</dd>
        </#list>
    <#else></#if>

        <#if (ccaValuesx=="")><#else>
            <dd><strong>CCA Values:</strong>
            <#list ccaValues as ccaValues>
                ${ccaValues}<#if ccaValues_has_next>; </#if>
            </#list>
            </dd>
        </#if>
        <#if (ccaValuesText=="")><#else>
            <dd><strong>Other CCA Values:</strong> ${ccaValuesText}</dd>
        </#if>
    </#list>

</#list>
</dl>
