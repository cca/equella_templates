<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType == "Course work")>
    <dl>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER'>
            <dd><b>Creator: </b><a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <dt>Course Information</dt>
        <#list courseInfo as courseInfo>
            <#assign department = courseInfo.get('department')>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign courseCategory = courseInfo.get('courseCategory')>
            <#assign specialPrograms = courseInfo.get('specialPrograms')>
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <dd>
                <#if semester != "">
                    <a href="${semesterUrl}">${semester}</a>
                </#if>
                <#if semester != "" && course != ""> - </#if>
                <#if course != "">
                    <a href="${courseUrl}">${course}</a> —
                </#if>
                <#if faculty!= "">
                    <a href="${facultyUrl}">${faculty}</a> —
                </#if>
                <#if section!= "">
                    <a href="${sectionUrl}">${section}</a>
                </#if>
            </dd>

            <#if courseCategory != "">
                <dd>Course category: <a href="${courseCategoryUrl}">${courseCategory}</a></dd>
            </#if>
        </#list>

        <dt>Description</dt>
        <#assign assignment = xml.get('local/courseWorkWrapper/assignmentTitle')>
        <#if (assignment != "")>
            <dd><b>Assignment Title</b>: ${assignment}</dd>
        </#if>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>:<br>
                <pre>${abstract}</pre>
            </dd>
        </#if>

        <div class="clearfix">
            <dd>
                <#assign dimensions = xml.get('mods/physicalDescription/extent')>
                <#assign forms = xml.list('mods/physicalDescription/formatBroad')>
                <#assign temperature = courseWork.get('workType')>
                <#assign materials = courseWork.list('courseWorkTypeSpecific')>
                <#-- building techniques -->
                <#assign techniques = courseWork.list('technique')>
                <#assign techniqueOther = courseWork.get('techniqueOther')>
                <#-- finishing techniques -->
                <#assign processes = courseWork.list('process')>
                <#assign processOther = courseWork.get('process_freetext')>
                <#assign tags = xml.list('local/tags')>

                <#if forms?size != 0>
                    <dd><b>Form(s):</b>&nbsp;
                    <#list forms as form>
                        ${form}<#if form_has_next>, </#if>
                    </#list></dd>
                </#if>

                <#-- building techniques -->
                <#if techniques?size != 0>
                    <dd><b>Building Techniques:</b>&nbsp;
                    <#list techniques as technique>
                        <#if technique != 'other...'>
                            ${technique}<#if technique_has_next>, </#if>
                        <#else>
                            ${techniqueOther}<#if technique_has_next>, </#if>
                        </#if>
                    </#list></dd>
                </#if>

                <#-- finishing techniques -->
                <#if processes?size != 0>
                    <dd><b>Finishing Techniques:</b>&nbsp;
                    <#list processes as process>
                        <#if process != 'other...'>
                            ${process}<#if process_has_next>, </#if>
                        <#else>
                            ${processOther}<#if process_has_next>, </#if>
                        </#if>
                    </#list></dd>
                </#if>

                <#if materials?size != 0>
                    <dd><b>Materials:</b>&nbsp;
                    <#list materials as material>
                        ${material}<#if material_has_next>, </#if>
                    </#list></dd>
                </#if>

                <#if dimensions != "">
                    <dd><b>Dimensions:</b>&nbsp;${dimensions}</dd>
                </#if>
                <#if temperature != "">
                    <dd><b>Firing temp.:</b>&nbsp;${temperature}</dd>
                </#if>

                <#if tags?size != 0>
                    <dd><b>Themes:</b>&nbsp;
                    <#list tags as tag>
                        ${tag}<#if tag_has_next>, </#if>
                    </#list></dd>
                </#if>
            </dd>
        </div>

        <#assign videoFile = xml.get('mods/part/numberC')>
        <#list attachments as attachment>
            <#if videoFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <h4><u>Video File</u></h4>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
                <div class="clearfix"></div>
            </#if>
        </#list>

        <div class="clearfix">
        <h4><u>Images</u></h4>
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list xml.list('mods/part/number') as image>
                <#if image == uuid>
                <div class="image-studentWork">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </div>
                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
