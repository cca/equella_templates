<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd><strong>Student:</strong> ${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign username = subName.get('username')>
            <#assign status = subName.get('constituent')>
            <#assign ccaid = subName.get('ccaAffiliated')>
            <#assign majorUrl = "" />
            <#if major != "">
                 — ${major}
            </#if>
            <#if status != "">
                 — ${status}
            </#if>
            <#if username != "">
                 — ${username}
            </#if>
            <#if ccaid != "">
                 — ${ccaid}
            </#if>
        </#list>
    </#list>

<#assign firstYearDimension = xml.getAllSubtrees('local/courseInfo/firstYearDimension')>
    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign department = courseInfo.get('department')>
        <#assign firstYearDimensionX = courseInfo.get('firstYearDimension')>
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "" />

        <dd><strong>Semester review requested:</strong> ${semester}</dd>
        <dd><strong>CORE Studio waiver requested for:</strong></dd>
        <dd>
            <#list firstYearDimension as firstYearDimension>
                ${firstYearDimension}<#if firstYearDimension_has_next>; </#if>
            </#list>
        </dd>
        <#-- helper fn for checking below -->
        <#function haveWaiver waiver>
            <#if waiver != "" && waiver != "undetermined at this time">
                <#return true>
            <#else>
                <#return false>
            </#if>
        </#function>
        <#-- the waiver status' all got mapped into rather arbitrary areas -->
        <#assign C100Waiver = xml.get('local/projectWrapper/flaggedFor')>
        <#assign C104Waiver = xml.get('local/courseWorkWrapper/assignmentReferences')>
        <#assign C108Waiver = xml.get('local/assignmentWrapper/review')>
        <#assign C112Waiver = xml.get('local/seniorPacketWrapper/phase')>
        <#-- if we have any of the waiver statuses, show 'em -->
        <#if haveWaiver(C100Waiver) || haveWaiver(C104Waiver) || haveWaiver(C108Waiver) || haveWaiver(C112Waiver)>
            <dd>
                <strong>Waiver Status:</strong><br />
                <#if haveWaiver(C100Waiver)>${C100Waiver}<br /></#if>
                <#if haveWaiver(C104Waiver)>${C104Waiver}<br /></#if>
                <#if haveWaiver(C108Waiver)>${C108Waiver}<br /></#if>
                <#if haveWaiver(C112Waiver)>${C112Waiver}<br /></#if>
            </dd>
        </#if>
        <hr>
    </#list>

<#if xml.exists('local/projectWrapper/fileA')>
    <dd><strong><u>D1 PORTFOLIO</u></strong></dd>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/projectWrapper') as D1Wrapper>
            <#assign file = D1Wrapper.get('fileA')>
            <#assign title = D1Wrapper.get('title')>
            <#assign format = D1Wrapper.get('format')>
            <#assign dimensions = D1Wrapper.get('dimensions')>
            <#assign semester = D1Wrapper.get('semester')>
            <#assign description = D1Wrapper.get('description')>
            <#assign waiverStatus = D1Wrapper.get('flaggedFor')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='metadata'>
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if format != "">${format}<br></#if>
                        <#if dimensions != "">${dimensions}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if description != "">${description}<br></#if>
                        <#if waiverStatus != "">${waiverStatus}<br></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
    <hr />
</#if>

<#if xml.exists('local/courseWorkWrapper/file')>
    <dd><strong><u>2D PORTFOLIO</u></strong></dd>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/courseWorkWrapper') as D2Wrapper>
            <#assign file = D2Wrapper.get('file')>
            <#assign title = D2Wrapper.get('projectTitle')>
            <#assign format = D2Wrapper.get('material')>
            <#assign dimensions = D2Wrapper.get('materials_freetext')>
            <#assign semester = D2Wrapper.get('assignmentDue')>
            <#assign description = D2Wrapper.get('assignmentDescription')>
            <#assign waiverStatus = D2Wrapper.get('flaggedFor')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if format != "">${format}<br></#if>
                        <#if dimensions != "">${dimensions}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if description != "">${description}<br></#if>
                        <#if waiverStatus != "">${waiverStatus}<br></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
    <hr />
</#if>

<#if (xml.get('local/assignmentWrapper/file'))!="">
    <dd><strong><u>3D PORTFOLIO</u></strong></dd>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/assignmentWrapper') as D3Wrapper>
            <#assign file = D3Wrapper.get('file')>
            <#assign title = D3Wrapper.get('title')>
            <#assign format = D3Wrapper.get('type')>
            <#assign dimensions = D3Wrapper.get('process')>
            <#assign semester = D3Wrapper.get('assignmentDue')>
            <#assign description = D3Wrapper.get('description')>
            <#assign waiverStatus = D3Wrapper.get('flaggedFor')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if format != "">${format}<br></#if>
                        <#if dimensions != "">${dimensions}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if description != "">${description}<br></#if>
                        <#if waiverStatus != "">${waiverStatus}<br></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
    <hr />
</#if>

<#if xml.exists('local/seniorPacketWrapper/file')>
    <dd><strong><u>4D PORTFOLIO</u></strong></dd>

    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/seniorPacketWrapper') as D4Wrapper>
            <#assign file = D4Wrapper.get('file')>
            <#assign title = D4Wrapper.get('title')>
            <#assign format = D4Wrapper.get('formatBroad')>
            <#assign duration = D4Wrapper.get('heightINCH')>
            <#assign semester = D4Wrapper.get('semester')>
            <#assign description = D4Wrapper.get('notes')>
            <#assign waiverStatus = D4Wrapper.get('flaggedFor')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if format != "">${format}<br></#if>
                        <#if duration != "">${duration}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if description != "">${description}<br></#if>
                        <#if waiverStatus != "">${waiverStatus}<br></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
    <hr />
</#if>
