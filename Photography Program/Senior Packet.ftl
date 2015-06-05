<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
<#assign artistDoc = xml.getAllSubtrees('local/artistDocWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>

<dl>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType =="Senior packet")>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign department = local.get('department')>
            <#assign departmentUrl = '/access/searching.do?in=Cdd83789b-f726-47e1-8a5f-626450d226a0&q=&type=standard'>
            <#assign division = local.get('division')>
            <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#list>

        <dt>Creator</dt>
        <#list name as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#list subNameWrapper as subName>
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

        <#assign faculty = xml.getAllSubtrees('local/courseInfo/faculty')>
        <#list courseInfo as courseInfo>
            <#assign department = xml.get('local/department')>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign facultyx = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <dt>Course Info</dt>
            <span id="coursestuff">
            <#if (semester != "undefined") && (semester != "")>
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if (department != "undefined") && (department != "")>
                — <a href ="${departmentUrl}">${department}</a>
            </#if>
            <#if (course != "undefined") && (course != "")>
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if (facultyx != "undefined") && (facultyx != "")>
                —
                <#-- faculty is XML tree, loop over it -->
                <#list faculty as faculty>
                    <#-- need to do assignment inside this loop -->
                    <#assign facultyName = faculty.get('/')>
                    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${facultyName}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                    <a href ="${facultyUrl}">${facultyName}</a><#if faculty_has_next> / </#if>
                </#list>
            </#if>
            <#if (section != "undefined") && (section != "")>
                — <a href ="${sectionUrl}">${section}</a>
            </#if>
            </span>
        </#list>

        <dt>Senior Packet</dt>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd>Description: ${abstract}</dd>
        </#if>

        <#assign date = xml.getAllSubtrees('local/exhibitWrapper/date')>
        <#list exhibitWrapper as exhibitWrapper>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign datex = exhibitWrapper.get('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || datex != "">
                <h4 style="color: #666;"><u>Senior Show Information</u></h4>
                <dd>
                <#if gallery != ""><a href="${galleryUrl}">${gallery}</a></#if>
                <#if note != ""> — ${note}</#if>
                <#if datex != ""> —
                    <#list date as date>${date}<#if date_has_next> through </#if>
                    </#list>
                </#if>
                </dd>
            </#if>
        </#list>

        <#list xml.getAllSubtrees('local/exhibitWrapper/showcardFile') as showcardFile>
        <#list itemAttachments as itemAttachment>
        <#if showcardFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Show card</i></u></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>
        </#list>

        <#list xml.getAllSubtrees('local/exhibitWrapper/installationShotFile') as installationShotFile>
        <#list itemAttachments as itemAttachment>
        <#if installationShotFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Installation shot</i></u></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>
        </#list>
        <div class="clearfix"></div>

        <#-- only show if we actually have something -->
        <#if xml.get('local/artistDocWrapper/artistStatementFile') != "">
            <h4 style="color: #666;"><u>Artist Documents</u></h4>
            <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as artistStatementFile>
                <#list itemAttachments as itemAttachment>
                    <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                        <#assign thumb = itemAttachment.get('thumbnail')>
                        <#assign full = itemAttachment.get('file')>
                        <#assign uuid = itemAttachment.get('uuid')>
                        <div class="image-artistDocs">
                        <p class='artistDocs'><i><u>Artist statement</u></i></p>
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                        <p class='artistDocs'>
                        <#if full != "">
                            ${full}
                        </#if>
                        </p>
                        </div>
                    </#if>
                </#list>
            </#list>
        </#if>

        <#list xml.getAllSubtrees('local/artistDocWrapper/resumeCVFile') as resumeCVFile>
        <#list itemAttachments as itemAttachment>
        <#if resumeCVFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Resume/CV</u></i></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>
        </#list>

        <#list xml.getAllSubtrees('local/artistDocWrapper/imageListFile') as imageListFile>
        <#list itemAttachments as itemAttachment>
        <#if imageListFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs'><i><u>Image list</u></i></p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>
        </#list>

        <div class="clearfix"></div>

        <h4 style="color: #666;"><u>Image List</u></h4>
        <#list itemAttachments as itemAttachment>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign semester = seniorPacket.get('semester')>
                <#assign formatBroad = seniorPacket.get('formatBroad')>
                <#assign formatSpecific = seniorPacket.get('formatSpecific')>
                <#assign formatOther = seniorPacket.get('formatOther')>
                <#assign videoFile = seniorPacket.get('file')>
                <#assign jpgFile = seniorPacket.get('lowResFile')>
                <#assign tiffFile = seniorPacket.get('hiResFile')>
                <#assign captureTechnique = seniorPacket.get('technique')>
                <#assign duration = seniorPacket.get('duration')>
                <#assign heightINCH = seniorPacket.get('heightINCH')>
                <#assign widthINCH = seniorPacket.get('widthINCH')>
                <#assign notes = seniorPacket.get('notes')>
                <#if jpgFile==uuid>
                <div class='image-photoSeniorPacket'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                    <p class='photoImagelist'>
                    <#if title != ""><i>${title}<br></i></#if>
                    <#if semester != "">${semester}<br></#if>
                    <#if formatBroad != "">${formatBroad}<br></#if>
                    <#if formatSpecific == "">
                        <#elseif formatSpecific == "other">${formatOther}<br>
                        <#else>${formatSpecific}<br></#if>
                    <#if captureTechnique != "">${captureTechnique}<br></#if>
                    <#if duration != "">${duration}<br></#if>
                    <#if heightINCH != "">${heightINCH}</#if>
                    <#if widthINCH != ""> x ${widthINCH}<br></#if>
                    <#if notes != "">${notes}</#if>
                    </p>
                </div>

                </#if>
            </#list>
        </#list>

</dl>
</#if>
</#list>
