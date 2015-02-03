<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "Senior packet">
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
dd { margin-left: 0; }
</style>
    <dl>
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
            <dd><b>Creator:</b> <a href="${namePartUrl}">${namePart}</a>
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
            <dd><b>Course Info:</b>&nbsp;
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

        <#list xml.getAllSubtrees('local/exhibitWrapper') as exhibitWrapper>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign title = exhibitWrapper.get('title')>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign datex = exhibitWrapper.get('date')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
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
        <#list itemAttachments as itemAttachment>
        <#if showcardFile == itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
            <p class='artistDocs label'>Show card</p>
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>

        <#assign installationShotFile = xml.get('local/exhibitWrapper/installationShotFile')>
        <#list itemAttachments as itemAttachment>
        <#if installationShotFile == itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
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
        <#assign exitPresentation = xml.get('mods/part/number')>
        <#assign imageListFile = xml.get('local/artistDocWrapper/imageListFile')>
        <#assign thesisFile = xml.get('local/artistDocWrapper/thesisStatement')>
        <#-- only show if we actually have something -->
        <#if artistStatementFile != "" || resumeCVFile != "" || exitPresentation != "" || imageListFile != "" || thesisFile != "">
            <h4>Artist Documents</h4>
        </#if>

        <#list itemAttachments as itemAttachment>
            <#if artistStatementFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
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

        <#list itemAttachments as itemAttachment>
            <#if resumeCVFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Resume/CV</p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#list itemAttachments as itemAttachment>
            <#if exitPresentation == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs label'>Exit Presentation</p>
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>

        <#list itemAttachments as itemAttachment>
            <#if thesisFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
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
        <#list itemAttachments as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign date = seniorPacket.get('date')>
                <#assign formatBroad = seniorPacket.get('formatBroad')>
                <#-- formatOther is dimensions -->
                <#assign dimensions = seniorPacket.get('formatOther')>
                <#-- materials is formatSpecific -->
                <#assign materials = seniorPacket.list('formatSpecific')>
                <#-- prefer lowResFile is we have it
                otherwise take hiRes -->
                <#if seniorPacket.get('lowResFile') != "">
                    <#assign file = seniorPacket.get('lowResFile')>
                <#else>
                    <#assign file = seniorPacket.get('hiResFile')>
                </#if>
                <#assign techniques = seniorPacket.list('technique')>
                <#assign techniqueOther = seniorPacket.get('techniqueOther')>
                <#-- concept is tags and conceptOther is phase -->
                <#assign tags = seniorPacket.list('tags')>
                <#assign tagOther = seniorPacket.get('phase')>
                <#assign notes = seniorPacket.get('notes')>
                <#if file == uuid>
                <div class='image-studentWork'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='photoImagelist'>
                    <#-- p.photoImagelist i sets display: block
                    in our theme -->
                    <#if title != ""><i>${title}</i></#if>
                    <#if date != "">${date}<br></#if>
                    <#if formatBroad != "">
                        <b>Form:</b>&nbsp;${formatBroad}<br>
                    </#if>

                    <#if techniques?size != 0>
                        <b>Techniques:</b>&nbsp;
                        <#list techniques as technique>
                            <#-- see comment above "tags" for details on this approach -->
                            <#if technique != 'other...'>
                                ${technique}<#if technique_has_next>, </#if>
                            <#else>
                                ${techniqueOther}<#if technique_has_next>, </#if>
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

                    <#if materials?size != 0>
                        <b>Materials:</b>&nbsp;
                        <#list materials as material>
                            ${material}<#if material_has_next>, </#if>
                        </#list><br>
                    </#if>

                    <#if dimensions != "">${dimensions}<br></#if>
                    </p>
                </div>

                </#if>
            </#list>
        </#list>
        </div>
</dl>
</#if>
</#list>
