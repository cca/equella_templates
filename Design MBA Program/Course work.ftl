<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>
<#assign type = xml.get('local/courseWorkWrapper/courseWorkType')>

<#-- if public user, hide all the things
hide VAULT's wrapper basically: left, right columns, footer, non-logo stuff up top -->
<#if !userIsMemberOf('staff') && !userIsMemberOf('Staff') && !userIsMemberOf('Faculty') && !userIsMemberOf('Student') && !userIsMemberOf('Students') && !userIsMemberOf('students') && !userIsMemberOf('System Administrators')>
<style>
#breadcrumbs,
#menu,
#col2,
#helpAndOptions,
#footer {
    display: none;
}
</style>
</#if>

<#if type == 'Course work' || type == 'Senior thesis'>

<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign powerSearch = 'P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3'>

<dl>
<#list local as local>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
    <#assign division = local.get('division')>
    <#assign department = local.get('department')>
    <#-- NOTE: division URL hard-coded in, kind of has to be (=H&S here)
    but students can't see division search! so useless link for them -->
    <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EDesign+Strategy+MBA%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
    <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
    <br />

    <#assign semester = local.get('courseInfo/semester')>
    <#assign course = local.get('courseInfo/course')>
    <#assign faculty = local.get('courseInfo/faculty')>
    <#assign section = local.get('courseInfo/section')>
    <#function search str>
        <#return '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=%22' + str + '%22'>
    </#function>
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
    <dt>Course</dt>
    <dd>
        <#if semester == ""><i>no course selected</i><#else>
            <a href="${semesterUrl}">${semester}</a>
                 — <a href="${search(course)}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${search(section)}">${section}</a>
        </#if>
    </dd>
    <dd>
        <#assign courseWorkTypeSpecific = local.get('courseWorkWrapper/courseWorkTypeSpecific')>
        <#if courseWorkTypeSpecific != "">
            <a href="${search(courseWorkTypeSpecific)}">${courseWorkTypeSpecific}</a>
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
        <dd><pre>${abstract}</pre></dd><br>
    </#if>

    <#-- see the contrib wizard for details on these controls
    the language is from DMBA's project form -->
    <#if local.get('lectureSeriesWrapper/haveRelease') == "yes">
    <dd><strong class="text-error">Project involves a Mutual Confidentiality and Nondisclosure Agreement with a client.</strong></dd><br>
    </#if>

    <#if local.get('viewLevelWrapper/viewLevel-A') == "yes">
    <dd><strong class="text-error">Images and description should not be published publicly. For internal CCA use only.</strong></dd><br>
    </#if>

</#list>
</dl>
</#if>
