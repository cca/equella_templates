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

.sm-left-margin {
    margin-left: 1px;
}
</style>
    <dl>

        <#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
        <#assign artistDoc = xml.getAllSubtrees('local/artistDocWrapper')>
        <#assign department = xml.get('local/department')>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#assign name = xml.getAllSubtrees('mods/name')>
        <#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
        <#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
        <#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
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

        <#list name as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER'>
            <dd class="sm-left-margin"><b>Creator: </b><a href="${namePartUrl}">${namePart}</a>
            <#list subNameWrapper as subName>
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

        <#assign faculties = xml.list('local/courseInfo/faculty')>
        <#if faculties?size != 0>
            <dd class="sm-left-margin"><b>Faculty Advisor(s)</b>:
            <#list faculties as faculty>
                <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
                <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next>, </#if>
            </#list></dd>
        </#if>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd class="sm-left-margin"><b>Description</b>: ${abstract}</dd>
        </#if>

        <#list exhibitWrapper as exhibitWrapper>
            <#assign gallery = exhibitWrapper.get('gallery')>
            <#assign note = exhibitWrapper.get('note')>
            <#assign dates = exhibitWrapper.list('date')>
            <#assign title = exhibitWrapper.get('title')>
            <#assign galleryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%2F%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ESenior+packet%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3CexhibitWrapper%3E%3Cgallery%3E${gallery}%3C%2Fgallery%3E%3C%2FexhibitWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#-- only show if we actually have something -->
            <#if gallery != "" || note != "" || title != "">
                <h4><u>Senior Show Information</u></h4>
                <dd>
                <#if title != ""><em>${title}</em></#if>
                <#if gallery != ""><a href="${galleryUrl}">${gallery}</a></#if>
                <#-- note is just a non-CCA gallery in SR Packet template -->
                <#if note != "">${note}</#if>
                <#if dates?size != 0> —
                    <#list dates as date>
                        ${date}<#if date_has_next> through </#if>
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

        <#assign videoFile = xml.get('mods/part/number')>
        <#list itemAttachments as itemAttachment>
            <#if videoFile == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                <p class='artistDocs'><i><u>Video File</u></i></p>
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
                <#assign forms = seniorPacket.list('formatBroad')>
                <#assign materials = seniorPacket.list('formatSpecific')>
                <#-- heightINCH is full dimensions string -->
                <#assign dimensions = seniorPacket.get('heightINCH')>
                <#-- note: where file is stored & which files we want to
                display will vary by collection -->
                <#assign jpgFile = seniorPacket.get('lowResFile')>
                <#assign file = seniorPacket.get('hiResFile')>
                <#assign techniques = seniorPacket.list('technique')>
                <#assign techniqueOthers = seniorPacket.list('techniqueOther')>
                <#assign tags = seniorPacket.list('tags')>
                <#if file == uuid>
                <div class='image-studentWork'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='photoImagelist'>
                    <#-- p.photoImagelist i sets display: block
                    in our theme -->
                    <#if title != ""><i>${title}</i></#if>
                    <#if date != "">${date}<br></#if>

                    <#if forms?size != 0>
                        <b>Form(s):</b>&nbsp;
                        <#list forms as form>
                            ${form}<#if form_has_next>, </#if>
                        </#list><br>
                    </#if>

                    <#if materials?size != 0>
                        <b>Materials:</b>&nbsp;
                        <#list materials as material>
                            ${material}<#if material_has_next>, </#if>
                        </#list><br>
                    </#if>

                    <#-- building techniques -->
                    <#if techniques?size != 0>
                        <b>Techniques:</b>&nbsp;
                        <#list techniques as technique>
                            ${technique}<#if technique_has_next>, </#if>
                        </#list><br>
                    </#if>
                    <#-- finishing techniques -->
                    <#if techniqueOthers?size != 0>
                        <#list techniqueOthers as techniqueOther>
                            ${techniqueOther}<#if techniqueOther_has_next>, </#if>
                        </#list><br>
                    </#if>

                    <#if tags?size != 0>
                        <b>Themes:</b>&nbsp;
                        <#list tags as tag>
                            ${tag}<#if tag_has_next>, </#if>
                        </#list>
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
