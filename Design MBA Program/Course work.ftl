<#assign type = xml.get('local/courseWorkWrapper/courseWorkType')>

<#if type == 'Course work'>

<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign local = xml.getAllSubtrees('local')>

<style scoped>
.text-danger {
    color: #b94a48;
}
</style>

<dl>

<#list local as local>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
    <#assign division = local.get('division')>
    <#assign department = local.get('department')>
    <#-- NOTE: division URL hard-coded in, kind of has to be (=H&S here)
    but students can't see division search! so useless link for them -->
    <#-- @todo fill in these links if appropriate
    <#assign divisionUrl = "/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER"/>
    <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
    <br />
    -->

    <#assign semester = local.get('courseInfo/semester')>
    <#assign course = local.get('courseInfo/course')>
    <#assign faculty = local.get('courseInfo/faculty')>
    <#assign section = local.get('courseInfo/section')>
    <#assign courseUrl = "" />
    <#assign semesterUrl = "" />
    <#assign facultyUrl = "" />
    <#assign sectionUrl = "" />
    <dt>Course</dt>
    <dd>
        <#if (semester=="")><i>no course selected</i><#else>
            <a href="${semesterUrl}">${semester}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
        </#if>
    </dd>
    <dd>
        <#assign courseWorkTypeSpecific = local.get('courseWorkWrapper/courseWorkTypeSpecific')>
        <#if courseWorkTypeSpecific != "">
            <#-- @todo link -->
            ${courseWorkTypeSpecific}
        </#if>
    </dd>

    <#assign namePart = xml.get('mods/name/namePart')>
    <#assign groupMembers = local.get('courseWorkWrapper/groupMembers')>
    <dt>Student(s)</dt>
    <#-- prefer groupMembers if we have them
    avoids situation where namePart is recorded accidentally -->
    <#if groupMembers != "">
        <dd>${groupMembers}</dd>
    <#elseif namePart != "">
        <dd>${namePart}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#assign note = xml.get('mods/noteWrapper/note')>
    <#if abstract != "" || note != "">
        <dt>Description</dt>
        <dd>${note}</dd><br>
        <dd>${abstract}</dd><br>
    </#if>

    <#-- see the contrib wizard for details on these controls
    the language is from DMBA's project form -->
    <#if local.get('lectureSeriesWrapper/haveRelease') == "yes">
    <dd><strong class="text-danger">Project involves a Mutual Confidentiality and Nondisclosure Agreement with a client.</strong></dd><br>
    </#if>

    <#if local.get('viewLevelWrapper/viewLevel-A') == "yes">
    <dd><strong class="text-danger">Images and description should not be published publicly. For internal CCA use only.</strong></dd><br>
    </#if>

</#list>
</#if>
