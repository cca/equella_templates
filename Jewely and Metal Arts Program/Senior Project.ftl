<#function encode str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Senior packet">
    <dl>
        <#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>
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
            <#assign departmentUrl = "/access/searching.do?in=C8faafb5c-7617-4c17-80f7-b9db9b0fd06f&q=&type=standard&dr=AFTER">
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
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — <b>Graduated</b>: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#assign faculties = xml.list('local/courseInfo/faculty')>
        <#if faculties?size != 0>
        <dd><b>Faculty Advisor<#if (faculties?size > 1)>s</#if></b>:
        <#list faculties as faculty>
                <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next>, </#if>
        </#list>
        </dd>
        </#if>

        <dt>Senior Project</dt>
        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b>: ${abstract}</dd>
        </#if>

        <#list xml.getAllSubtrees('local/exhibitWrapper') as exhibitWrapper>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || dates?size != 0>
                <h4><u>Senior Show Information</u></h4>
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
        <#list attachments as attachment>
        <#if showcardFile.get('/') = attachment.get('uuid')>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
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
        <#list attachments as attachment>
        <#if installationShotFile.get('/') = attachment.get('uuid')>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
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
            <#list attachments as attachment>
                <#if artistStatementFile == attachment.get('uuid')>
                    <#assign full = attachment.get('file')>
                    <#assign uuid = attachment.get('uuid')>
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
        <#list attachments as attachment>
            <#if resumeCVFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs'><i><u>Resume/CV</u></i></p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#assign imageListFile = xml.get('local/artistDocWrapper/imageListFile')>
        <#list attachments as attachment>
            <#if imageListFile == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
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
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign lowResFile = seniorPacket.get('lowResFile')>
                <#if uuid == lowResFile>
                    <#assign title = seniorPacket.get('title')>
                    <#assign semester = seniorPacket.get('date')>
                    <#assign formatSpecific = seniorPacket.get('formatSpecific')>
                    <#assign formatOther = seniorPacket.get('formatOther')>
                    <#-- duration is dimensions -->
                    <#assign dimensions = seniorPacket.get('duration')>
                    <#-- note: where file is stored & which files we want to
                    display vary by collection -->
                    <#assign technique = seniorPacket.get('technique')>
                    <#assign notes = seniorPacket.get('notes')>
                    <div class="image-with-metadata">
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class="metadata">
                            <#if title != ""><span class="title">${title}</span></#if>
                            <#if semester != "">${semester}<br></#if>
                            <#list seniorPacket.list('formatBroad') as formatBroad>
                                <#if formatBroad != "other">${formatBroad}<br></#if>
                            </#list>
                            <#-- the text for formatBroad == "other" value -->
                            <#if formatOther != "">${formatOther}<br></#if>
                            <#if formatSpecific != "">${formatSpecific}<br></#if>
                            <#if dimensions != "">${dimensions}<br></#if>
                            <#if technique != "">${technique}<br></#if>
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
