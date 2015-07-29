<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType == "Senior packet")>
    <dl>
        <#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
        <#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#assign departmentUrl = '/access/searching.do?in=Ce6b0e79c-82c8-4521-9c80-861abb629a6e&q=&type=standard'>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <dt>Creator</dt>
        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
            <#assign department = xml.get('local/department')>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculties = xml.list('local/courseInfo/faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <dt>Course Info</dt>
            <span id="coursestuff">
            <#if (semester != "undefined" && semester != "")>
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if (department != "undefined" && department != "")>
                — <a href ="${departmentUrl}">${department}</a>
            </#if>
            <#if (course != "undefined" && course != "")>
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if faculties?size != 0>
                — <#-- faculty is list, loop over it -->
                <#list faculties as faculty>
                    <#-- need to do assignment inside this loop -->
                    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                    <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next> / </#if>
                </#list>
            </#if>
            <#if (section != "undefined" && section != "")>
                — <a href ="${sectionUrl}">${section}</a>
            </#if>
            </span>
        </#list>

        <dt>Senior Project</dt>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd>Description: ${abstract}</dd>
        </#if>

        <#assign date = xml.getAllSubtrees('local/exhibitWrapper/date')>
        <#list exhibitWrapper as exhibitWrapper>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || dates?size != 0>
                <h4 style="color: #666;"><u>Senior Show Information</u></h4>
                <dd>
                <#if gallery != ""><a href="${galleryUrl}">${gallery}</a></#if>
                <#-- note is just a non-CCA gallery in SR Packet template -->
                <#if note != "">${note}</#if>
                <#if dates?size != 0> —
                    <#list dates as date>${date}<#if date_has_next> through </#if>
                    </#list>
                </#if>
                </dd>
            </#if>
        </#list>

        <#list xml.getAllSubtrees('local/exhibitWrapper/showcardFile') as showcardFile>
            <#list itemAttachments as itemAttachment>
            <#if showcardFile.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Show card</i></u></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </div>
            </#if>
            </#list>
        </#list>

        <div class="clearfix">
            <#list xml.getAllSubtrees('local/exhibitWrapper/installationShotFile') as installationShotFile>
                <#list itemAttachments as itemAttachment>
                <#if installationShotFile.get('/') = itemAttachment.get('uuid')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <div class="image-artistDocs">
                        <p class='artistDocs'><i><u>Installation shot</i></u></p>
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    </div>
                </#if>
                </#list>
            </#list>
        </div>

        <#-- only show if we actually have something -->
        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#if artistStatementFile != "">
            <h4 style="color: #666;"><u>Artist Documents</u></h4>
            <#list itemAttachments as itemAttachment>
                <#if artistStatementFile == itemAttachment.get('uuid')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <div class="image-artistDocs">
                        <p class='artistDocs'><i><u>Artist statement</u></i></p>
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    </div>
                </#if>
            </#list>
        </#if>

        <#assign resumeCVFile = xml.get('local/artistDocWrapper/resumeCVFile')>
        <#list itemAttachments as itemAttachment>
            <#if resumeCVFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Resume/CV</u></i></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </div>
            </#if>
        </#list>

        <#assign imageListFile = xml.get('local/artistDocWrapper/imageListFile')>
        <#list itemAttachments as itemAttachment>
            <#if imageListFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Image list</u></i></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </div>
            </#if>
        </#list>

        <#-- INDV uses Artist's Website too -->
        <#assign website = xml.get('mods/relatedItem/location')>
        <#if website != "">
            <#-- fix website URLs without schemes, causes broken link -->
            <#if ! website?starts_with('http')>
                <#assign website = 'http://' + website>
            </#if>
            <div class="image-artistDocs">
                <p class="artistDocs"><i><u>Website</u></i></p>
                <p><a href="${website}">${website}</a></p>
            </div>
        </#if>

        <div class="clearfix"></div>

        <div class="clearfix">
        <h4 style="color: #666;"><u>Image List</u></h4>
        <#list itemAttachments as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign semester = seniorPacket.get('semester')>
                <#assign formatBroad = seniorPacket.get('formatBroad')>
                <#assign formatSpecific = seniorPacket.get('formatSpecific')>
                <#-- formatOther is dimensions for INDIV -->
                <#assign dimensions = seniorPacket.get('formatOther')>
                <#-- INDIV only uses file & they're not TIFFs -->
                <#assign file = seniorPacket.get('file')>
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-with-metadata'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if formatBroad != "">${formatBroad}<br></#if>
                        <#if formatSpecific != "">${formatSpecific}<br></#if>
                        <#if dimensions != "">${dimensions}<br></#if>
                        <#if notes != "">${notes}<br></#if>
                    </p>
                </div>
                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
