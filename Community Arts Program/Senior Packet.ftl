<#function encode str>
    <#-- 2 encodings:
    1) return a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way
    2) encode "+" e.g. in course titles like "Form + Space"    -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Senior packet">
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
            <#assign departmentUrl = "/access/searching.do?in=C248b97e8-6db4-4d07-9929-8050e729c721&q=&type=standard&dr=AFTER">
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
            <#assign faculties = courseInfo.list('faculty')>
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${encode(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <dd><b>Course Info:</b>&nbsp;
            <#if semester != "undefined" && semester != "">
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if course != "undefined" && course != "">
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if faculties?size != 0>
                —
                <#list faculties as faculty>
                    <#-- need to do this assignment inside of loop -->
                    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                    <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next> / </#if>
                </#list>
            </#if>
        </dd>
        </#list>

        <#list xml.getAllSubtrees('local/exhibitWrapper') as exhibitWrapper>
            <#assign title = exhibitWrapper.get('title')>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || datex != "">
                <h4>Senior Show Information</h4>
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

        <#assign showcardFile = xml.get('local/exhibitWrapper/showcardFile')>
        <#list attachments as attachment>
            <#if showcardFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Show card</p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#assign installationShotFile = xml.get('local/exhibitWrapper/installationShotFile')>
        <#list attachments as attachment>
            <#if installationShotFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Installation shot</p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>
        <div class="clearfix"></div>

        <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
        <#assign resumeCVFile = xml.get('local/artistDocWrapper/resumeCVFile')>
        <#assign imageListFile = xml.get('local/artistDocWrapper/imageListFile')>
        <#assign thesisFile = xml.get('local/artistDocWrapper/thesisStatement')>
        <#-- only show if we actually have something -->
        <#if artistStatementFile != "" || resumeCVFile != "" || imageListFile != "" || thesisFile != "">
            <h4>Artist Documents</h4>
        </#if>

        <#list attachments as attachment>
            <#if artistStatementFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Artist statement</p>
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

        <#list attachments as attachment>
            <#if resumeCVFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Resume/CV</p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#list attachments as attachment>
            <#if thesisFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Senior Thesis File</p>
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

        <div class="clearfix"></div>
        <div class="clearfix">
        <h4>Image List</h4>
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#assign forms = seniorPacket.list('formatBroad')>
                <#-- formatOther is dimensions -->
                <#assign dimensions = seniorPacket.get('heightINCH')>
                <#-- materials is formatSpecific -->
                <#assign medias = seniorPacket.list('formatSpecific')>
                <#assign mediaOther = seniorPacket.get('formatOther')>
                <#-- prefer lowResFile is we have it
                otherwise take hiRes -->
                <#if seniorPacket.get('lowResFile') != "">
                    <#assign file = seniorPacket.get('lowResFile')>
                <#else>
                    <#assign file = seniorPacket.get('hiResFile')>
                </#if>
                <#-- theme is tags and conceptOther is phase -->
                <#assign tags = seniorPacket.list('tags')>
                <#assign tagOther = seniorPacket.get('phase')>
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-with-metadata'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                    <#if title != ""><span class="title">${title}</span></#if>
                    <#if date != "">${date}<br></#if>

                    <#if forms?size != 0>
                        <b>Form:</b>&nbsp;
                        <#list forms as form>
                            ${form}<#if form_has_next>, </#if>
                        </#list><br>
                    </#if>

                    <#if medias?size != 0>
                        <b>Materials:</b>&nbsp;
                        <#list medias as media>
                            <#if media != 'other...'>
                                ${media}<#if media_has_next>, </#if>
                            <#else>
                                ${mediaOther}<#if media_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if tags?size != 0>
                        <b>Themes:</b>&nbsp;
                        <#list tags as tag>
                            <#-- dont print other but its actual value,
                            which is stored elsewhere ("phase" for tags)
                            the 2nd "tag_has_next" ensure the comma-sep.
                            list doesnt get screwed up while we do this -->
                            <#if tag != 'other...'>
                                ${tag?replace('\\', ': ')}<#if tag_has_next>, </#if>
                            <#else>
                                ${tagOther}<#if tag_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if dimensions != "">${dimensions}<br></#if>
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
