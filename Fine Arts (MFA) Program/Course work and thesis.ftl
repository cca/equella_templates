<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#-- this template works for both course work and thesis type submissions -->
<#if courseWorkType == "Course work" || courseWorkType == 'Thesis'>
    <dl>
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
            <#assign departmentUrl = "/access/searching.do?in=C5a7d71f7-9ffc-41f0-a2ee-2761e78feb11&q=&type=standard&dr=AFTER">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <dt>Creator</dt>
        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#assign majors = name.list('subNameWrapper/major')>
            <#if majors?size != 0> —
                <#list majors as major>
                    <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                    <a href="${majorUrl}">${major}</a><#if major_has_next>, </#if>
                </#list>
            </#if>
            <#assign year = xml.get("/mods/origininfo/dateCreatedWrapper/dateCreated")>
            <#if year != "">
                (${year})
            </#if>
            </dd>
        </#list>

        <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    		<#assign semester = courseInfo.get('semester')>
    		<#assign course = courseInfo.get('course')>
    		<#assign faculty = courseInfo.get('faculty')>
    		<#assign section = courseInfo.get('section')>
    		<#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    		<#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3EFall+2013%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    		<#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    		<#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    		<dt>Course Information</dt>
    		<span id="coursestuff">
    			<#if semester != "">
    				<a href="${semesterUrl}">${semester}</a>
    			</#if>
    			<#if course != "">
    				— <a href="${courseUrl}">${course}</a>
    			</#if>
    			<#if faculty != "">
    				— <a href="${facultyUrl}">${faculty}</a>
    			</#if>
    			<#if section != "">
    				— <a href="${sectionUrl}">${section}</a>
    			</#if>
    		</span>
    	</#list>

        <dt>Details</dt>

        <#assign medium = xml.get('mods/physicalDescription/formBroad')>
        <#if (medium != "")>
            <dd><b>Medium</b>: ${medium}</dd>
        </#if>

        <#assign dimensions = xml.get('mods/physicalDescription/extent')>
        <#if (dimensions != "")>
            <dd><b>Dimensions</b>: ${dimensions}</dd>
        </#if>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>:<br><pre>${abstract}</pre></dd>
        </#if>
    </dl>
</#if>
</#list>
