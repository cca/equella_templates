<#function encode str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType == "Senior packet")>
    <dl>
        <#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#-- this is the Fine Arts Division power search ID -->
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#-- insert URL for appropriate department here -->
            <#assign departmentUrl = "https://vault.cca.edu/access/searching.do?in=C93cd1700-48ae-4e2d-8821-3130f0e4260b&q=&type=standard&dr=AFTER">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
            <dd><b>Creator:</b> <a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${encode(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <dd><b>Course Info:</b>&nbsp;
            <#if semester != "">
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if course != "">
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if faculty != "">
                — <a href ="${facultyUrl}">${faculty}</a>
            </#if>
            <#if section!= "">
                — <a href="${sectionUrl}">${section}</a>
            </#if>
        </dd>
        </#list>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>: ${abstract}</dd>
        </#if>

        <#list exhibitWrapper as exhibitWrapper>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign title = exhibitWrapper.get('title')>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign datex = exhibitWrapper.get('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || datex != "">
                <h4><u>Senior Show Information</u></h4>
                <dd>
                <#if title != ""><em>${title}</em></#if>
                <#if gallery != ""> — <a href="${galleryUrl}">${gallery}</a></#if>
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
                    <p class='artistDocs'>${full}</p>
                    </div>
                </#if>
            </#list>
        </#list>

        <#list xml.getAllSubtrees('local/exhibitWrapper/installationShotFile') as installationShotFile>
            <#list itemAttachments as itemAttachment>
                <#if installationShotFile.get('/') = itemAttachment.get('uuid')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Installation shot</i></u></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>${full}</p>
                    </div>
                </#if>
            </#list>
        </#list>
        <div class="clearfix"></div>

        <#-- only show if we actually have something -->
        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#if artistStatementFile != "">
            <h4><u>Artist Documents</u></h4>
            <#list itemAttachments as itemAttachment>
                <#if artistStatementFile == itemAttachment.get('uuid')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Artist statement</u></i></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>
                    <#if full != "">
                        ${full}
                    </#if>
                    </p>
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
                    <p class='artistDocs'>${full}</p>
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
                    <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>
        <div class="clearfix"></div>

        <div class="clearfix">
        <h4><u>Image List</u></h4>
        <#list itemAttachments as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#-- form is radio button, so only 1 value not a list
                formatOther isn't used in PNTDR -->
                <#assign form = seniorPacket.get('formatBroad')>
                <#-- edit box so this is just 1 value, not a list  -->
                <#assign materials = seniorPacket.get('formatSpecific')>
                <#-- duration used for both 2/3D dimensions & 4D duration -->
                <#assign duration = seniorPacket.get('duration')>

                <#-- low res file is optional, so use it only if we have it -->
                <#if seniorPacket.get('lowResFile') != "">
                    <#assign file = seniorPacket.get('lowResFile')>
                <#else>
                    <#assign file = seniorPacket.get('hiResFile')>
                </#if>

                <#assign mediums = seniorPacket.list('technique')>
                <#assign mediumOther = seniorPacket.get('techniqueOther')>

                <#assign themes = seniorPacket.list('tags')>
                <#-- "phase" is the "other..." option for themes -->
                <#assign themeOther = seniorPacket.get('phase')>

                <#-- open-ended description -->
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-with-metadata'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                    <#if title != ""><span class="title">${title}</span></#if>
                    <#if date != "">${date}<br></#if>
                    <#if form != "">${form}<br></#if>

                    <#if mediums?size != 0>
                        <b>Techniques:</b>&nbsp;
                        <#list mediums as medium>
                            <#if medium != 'other...'>
                                ${medium}<#if medium_has_next>, </#if>
                            <#else>
                                ${mediumOther}<#if medium_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if materials != "">${materials}<br></#if>
                    <#if duration != "">${duration}<br></#if>

                    <#if themes?size != 0>
                        <b>Concepts:</b>&nbsp;
                        <#list themes as theme>
                            <#if theme != 'other...'>
                                ${theme}<#if theme_has_next>, </#if>
                            <#else>
                                ${themeOther}<#if theme_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if notes != "">${notes}</#if>
                    </p>
                </div>

                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
