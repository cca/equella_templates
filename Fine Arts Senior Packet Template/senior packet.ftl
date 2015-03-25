<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType == "Senior packet")>
<style>
div.image-studentWork {
    min-height: 230px;
    max-height:230px;
    width:  174px;
    max-width:  174px;
    margin-top:20px;
    margin-bottom:  10px;
}

div.image-studentWork > a {
    width: 110px;
    display: block;
    margin: auto;
}

/* get rid of dotted underline */
div.image-studentWork > a:hover {
    border: none;
}

div.image-studentWork > a:hover img {
    border-color:black;
}

.image-studentWork.shorter {
    min-height: 150px;
}

p.photoImagelist {
    overflow: hidden;
    width: 154px;
    max-width: 154px;
    padding: 10px;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-left: 0 !important;
}

div.image-studentWork:hover {
    overflow: visible;
}

div.image-studentWork:hover p.photoImagelist {
    max-height: 1000px;
    background: #eee;
    height: auto;
    position: absolute;
    white-space: normal;
}

.photoImagelist i {
    border-bottom: 1px dotted #bbb;
    padding-bottom: 7px;
    font-weight: bold;
}
.attachments {
    position: static;
}
</style>
    <dl>

        <#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
        <#assign artistDoc = xml.getAllSubtrees('local/artistDocWrapper')>
        <#assign department = xml.get('local/department')>
        <#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#assign departmentUrl = "" />
            <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection">
                ${department} | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
            <dd style="margin-left: 1px;"><b>Creator: </b><a href="${namePartUrl}">${namePart}</a>
            <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
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
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculties = courseInfo.list('faculty')>
            <#assign courseUrl = "">
            <#assign semesterUrl = "">
            <dd style="margin-left: 1px;"><b>Course Info: </b>
            <#if (semester != "undefined") && (semester != "")>
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if (course != "undefined") && (course != "")>
                — <a href ="${courseUrl}">${course}</a>
            </#if>
            <#if (faculties?size != 0)>
                —
                <#list faculties as faculty>
                    <#-- need to do this assignment inside of loop -->
                    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                    <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next> / </#if>
                </#list>
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
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
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

        <#assign exitPresentation = xml.get('mods/part/number')>
        <#list itemAttachments as itemAttachment>
            <#if exitPresentation == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs'><i><u>Exit Review Presentation</u></i></p>
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
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#assign formatBroads = seniorPacket.list('formatBroad')>
                <#assign formatOther = seniorPacket.get('formatOther')>
                <#-- interdisciplinarity is formatSpecific and interdisciplinarity is phase -->
                <#assign formatSpecifics = seniorPacket.list('formatSpecific')>
                <#assign phase = seniorPacket.get('phase')>
                <#-- heightINCH is dimensions -->
                <#assign heightINCH = seniorPacket.get('heightINCH')>
                <#-- note: where file is stored & which files we want to
                display will vary by collection -->
                <#assign file = seniorPacket.get('file')>
                <#assign techniques = seniorPacket.list('technique')>
                <#assign techniqueOther = seniorPacket.get('techniqueOther')>
                <#-- concept is tags and conceptOther is notes -->
                <#assign tags = seniorPacket.list('tags')>
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-studentWork'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='photoImagelist'>
                    <#-- p.photoImagelist i sets display: block
                    in our theme -->
                    <#if title != ""><i>${title}</i></#if>
                    <#if date != "">${date}<br></#if>
                    <#if heightINCH != "">${heightINCH}<br></#if>

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
