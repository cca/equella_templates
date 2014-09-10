<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign local = xml.getAllSubtrees('local')>

<dl>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">Syllabus
    </h2>
</#list>

<#list local as local>
    <#assign division = local.get('division')>
    <#-- <dt>${division} -->
    <#assign divisionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />

<#list courseInfo as courseInfo>
    <#assign department = courseInfo.get('department')>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseCategory = courseInfo.get('courseCategory')>
    <#assign courseName = courseInfo.get('courseName')>
    <#assign XList = courseInfo.get('XList')>
    <#assign specialPrograms = courseInfo.get('specialPrograms')>
    <#-- <dt>${course} -->
    <#-- <dt>${department} -->
    <#-- <dt>${semester} -->
    <#-- <dt>${faculty} -->
    <#-- <dt>${section} -->
    <#-- <dt>${courseCategory} -->
    <#-- <dt>${courseName} -->
    <#-- <dt>${XList} -->
    <#-- <dt>${specialPrograms} -->
    <#assign specialProgramsUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${specialPrograms}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseCategoryUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseNameUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign XListUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <dt class="subHeading">
    <a href="${semesterUrl}">${semester}</a>
        <#if (division=="undefined")>
            <#else> | <a href="${divisionUrl}">${division}</a>
        </#if>
        <#if (department=="undefined")>
            <#else> | <a href="${departmentUrl}">${department}</a>
        </#if></dt><br/>
        <dt class="subHeading">
        <#if (courseName=="undefined")>
            <#else><a href="${courseNameUrl}">${courseName}</a>
        </#if>
        <#if (course=="undefined")>
            <#else> | <a href="${courseUrl}">${course}</a>
        </#if>
        <#if section=="undefined">
            <#else> | <a href="${sectionUrl}">${section}</a>
        </#if>
        </dt><br/>
        <dt class="subHeading">
        <#if faculty=="undefined">
            <#else><a href="${facultyUrl}">${faculty}</a>
        </#if>
        </dt><br/>

        <#if (XList!="undefined")&&(XList!="")>
            <dt class="subHeading">
             Course is cross-listed with <a href="${XListUrl}">${XList}</a>.
             </dt><br/>
        <#else></#if>
    <#if (courseCategory=="")><#else>
        <dt class="subHeading">Course category:
        <a href="${courseCategoryUrl}">${courseCategory}</a>
    </#if>
    <#if (specialPrograms!="")>
        &amp <a href="${specialProgramsUrl}">${specialPrograms}</a>
    <#else></#if>
    </dt>

</#list>
</#list>
</dl>
