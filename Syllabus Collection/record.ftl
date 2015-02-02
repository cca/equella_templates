<dl>
    <#-- title basically repeats info below, no need to print it twice -->
    <h2 id="title">Syllabus</h2>

    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />

<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    <#assign department = courseInfo.get('department')>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseCategory = courseInfo.get('courseCategory')>
    <#assign courseName = courseInfo.get('courseName')>
    <#assign XList = courseInfo.get('XList')>
    <#assign specialPrograms = courseInfo.get('specialPrograms')>
    <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${specialPrograms}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <#assign XListUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
    <dt class="subHeading">
    <a href="${semesterUrl}">${semester}</a>
    <#if division != "undefined">
        | <a href="${divisionUrl}">${division}</a>
    </#if>
    <#if department != "undefined">
        | <a href="${departmentUrl}">${department}</a>
    </#if></dt><br/>
    <dt class="subHeading">
    <#if courseName != "undefined">
        <a href="${courseNameUrl}">${courseName}</a>
    </#if>
    <#if course != "undefined">
        | <a href="${courseUrl}">${course}</a>
    </#if>
    <#if section != "undefined">
        | <a href="${sectionUrl}">${section}</a>
    </#if>
    </dt>
    <br/>
    <dt class="subHeading">
    <#if faculty != "undefined">
        <a href="${facultyUrl}">${faculty}</a>
    </#if>
    </dt>
    <br/>
    <#if XList != "undefined" && XList != "">
        <dt class="subHeading">
         Course is cross-listed with <a href="${XListUrl}">${XList}</a>.
         </dt>
         <br/>
    </#if>
    <#-- there's gotta be a way to do this with fewer if stmts
    but whatever this works -->
    <#if courseCategory != "" || specialPrograms != "">
        <dt class="subHeading">Course category:
    </#if>
    <#if courseCategory != "">
        <a href="${courseCategoryUrl}">${courseCategory}</a>
    </#if>
    <#if courseCategory != "" && specialPrograms != "">&amp;</#if>
    <#if specialPrograms != "">
         <a href="${specialProgramsUrl}">${specialPrograms}</a>
    </#if>
    <#if courseCategory != "" || specialPrograms != "">
        </dt>
    </#if>
</#list>
</dl>
