<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType == "Workshops / Events")>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <#assign subTitle = xml.get('mods/titleInfo/subTitle')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

    <div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign uuid = itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <#if full?contains("http://") || full?ends_with(".zip")><#else>
            <a href="/file/${itemUuid}/${itemversion}/${full}">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
        </#if>
    </#list>
    </div>

    <dt>Workshop Event Information</dt>
    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
		<#assign semester = courseInfo.get('semester')>
		<#assign course = courseInfo.get('course')>
		<#assign faculty = courseInfo.get('faculty')>
		<#assign section = courseInfo.get('section')>
		<#assign courseCategory = courseInfo.get('courseCategory')>
		<#assign specialPrograms = courseInfo.get('specialPrograms')>
		<#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
		<#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3EFall+2013%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
		<#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
		<#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
		<#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
		<dd>
            <b>Related Course</b>:<br>
    		<span id="coursestuff">
    			<#if semester != "">
    				<a href="${semesterUrl}">${semester}</a>
    			</#if>
    			<#if (course != "undefined" && course != "Events")>
    				— <a href="${courseUrl}">${course}</a>
    			</#if>
    			<#if (faculty != "undefined" && faculty != "")>
    				— <a href="${facultyUrl}">${faculty}</a>
    			</#if>
    			<#if (section != "undefined" && section != "")>
    				— <a href="${sectionUrl}">${section}</a>
    			</#if>
    		</span>
    		<#if courseCategory != "">
    			<dd><b>Course category</b>: <a href="${courseCategoryUrl}">${courseCategory}</a></dd>
    		</#if>
        </dd>
	</#list>

    <#list local as local>
        <#assign objective = local.get('objective')>
        <#-- @todo fix this URL -->
        <#assign objectiveUrl = "">
        <dd><a href="${objectiveUrl}">${objective}</a>
    </#list>

    <#list xml.getAllSubtrees('mods/origininfo') as origininfo>
        <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
        <#assign semesterCreated = origininfo.get('semesterCreated')>
        <#-- @todo fix this URL -->
        <#assign semesterCreatedUrl = "">
         — <#if semesterCreated != "">
            Date:
            <a href="${semesterCreatedUrl}">${semesterCreated}</a> |
        </#if>
        <#if dateCreated != "">${dateCreated}</#if>
        </dd>
    </#list>

    <#list local as local>
        <#-- list() returns a list of text inside nodes -->
        <#assign tags = xml.list('local/tags')>
        <#if tags?size != 0>
            <dd><b>Tags</b>:<br>
             <#list tags as tag>
                <#-- assign URL inside of loop -->
                <#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%2F%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%2F%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&dr=AFTER">
                <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
            </#list></dd>
        </#if>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd><b>Description</b>:<br><pre>${abstract}</pre></dd>
    </#if>

    <#assign names = xml.getAll('mods/subject/name')>
    <#if names?size != 0>
        <dd><b>People in photos</b>:
            <#list names as name>
                ${name}<#if name_has_next>, </#if>
            </#list>
        </dd>
    </#if>

</dl>
</#if>
</#list>
