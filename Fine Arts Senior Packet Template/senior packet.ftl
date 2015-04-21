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
        <#-- this is the Fine Arts Division power search ID -->
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#-- insert URL for appropriate department here -->
            <#assign departmentUrl = "" />
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER" />
            <dd class="collection">
                <a href="departmentUrl">${encode(department)}</a> | <a href="${divisionUrl}">${encode(division)}</a>
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
        <#if abstract != "">
            <dd><b>Description</b>: ${abstract}</dd>
        </#if>

        <#list xml.getAllSubtrees('local/exhibitWrapper') as exhibitWrapper>
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
            <#list attachmentss as attachment>
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

        <#assign exitPresentation = xml.get('mods/part/number')>
        <#list attachments as attachment>
            <#if exitPresentation == attachment.get('uuid')>
                <#assign full = attachment.get('file')>
                <#assign uuid = attachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u>Exit Review Presentation</u></i></p>
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
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#assign formatBroads = seniorPacket.list('formatBroad')>
                <#-- formatOther is often the "other..." write-in for formatBroad -->
                <#assign formatOther = seniorPacket.get('formatOther')>
                <#-- these are very much up to departments & phase is often not used  -->
                <#assign formatSpecifics = seniorPacket.list('formatSpecific')>
                <#assign phase = seniorPacket.get('phase')>
                <#-- most departments only use a subset of these for dimensions -->
                <#assign heightINCH = seniorPacket.get('heightINCH')>
                <#assign widthINCH = seniorPacket.get('widthINCH')>
                <#assign depthINCH = seniorPacket.get('depthINCH')>
                <#assign duration = seniorPacket.get('duration')>
                <#-- note: where file is stored & which files we want to
                display will vary by collection, lowResFile is default for
                web-ready images like JPGs -->
                <#assign file = seniorPacket.get('lowResFile')>
                <#assign techniques = seniorPacket.list('technique')>
                <#assign techniqueOther = seniorPacket.get('techniqueOther')>
                <#assign tags = seniorPacket.list('tags')>
                <#-- open-ended description -->
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-with-metadata'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                    <#if title != ""><span class="title">${title}</span></#if>
                    <#if date != "">${date}<br></#if>
                    <#if heightINCH != "">${heightINCH}<br></#if>
                    <#if widthINCH != "">${widthINCH}<br></#if>
                    <#if depthINCH != "">${depthINCH}<br></#if>
                    <#if duration != "">${duration}<br></#if>

                    <#if formatBroads?size != 0>
                        <b>Form(s):</b>&nbsp;
                        <#list formatBroads as formatBroad>
                            <#-- dont print other but its actual value,
                            which is stored elsewhere ("phase" for formatSpecific)
                            the 2nd "formatBroad_has_next" ensure the comma-sep.
                            list doesnt get screwed up while we do this -->
                            <#if formatBroad != 'other...'>
                                ${formatBroad}<#if formatBroad_has_next>, </#if>
                            <#else>
                                ${formatOther}<#if formatBroad_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if techniques?size != 0>
                        <b>Techniques:</b>&nbsp;
                        <#list techniques as technique>
                            <#if technique != 'other...'>
                                ${technique}<#if technique_has_next>, </#if>
                            <#else>
                                ${techniqueOther}<#if technique_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if tags?size != 0>
                        <b>Concepts:</b>&nbsp;
                        <#list tags as tag>
                            <#-- this handles multi-layer tags as we may see when
                            using taxonomies, so Parent\Child => Parent: Child -->
                            <#if tag != 'other...'>
                                ${tag?replace('\\', ': ')}<#if tag_has_next>, </#if>
                            <#else>
                                ${notes}<#if tag_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if formatSpecifics?size != 0>
                        <b>Interdisciplinarity:</b>&nbsp;
                        <#list formatSpecifics as formatSpecific>
                            <#if formatSpecific != 'other...'>
                                ${formatSpecific}<#if formatSpecific_has_next>, </#if>
                            <#else>
                                ${phase}<#if formatSpecific_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>
                    </p>
                </div>

                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
