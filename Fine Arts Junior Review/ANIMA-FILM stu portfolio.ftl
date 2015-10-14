<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list local as local>
    <#assign objective = local.get('objective')>
    <#if (objective == "film/animation work")>

<dl>
    <h2 id="title">Junior Review Portfolio</h2>

    <#assign name = xml.get('mods/name/namePart')>
    <#-- @TODO indentNoLine adds deceptive blue coloring
    makes this look like a link when it's not -->
    <#if name != "">
        <dt class="indentNoLine">${name}
        <#list subNameWrapper as subNameWrapper>
            <#assign major = subNameWrapper.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            <#if (major != "")>
              - ${major}
            </#if>
        </dt>
        </#list>
    </#if>

    <#assign semester = xml.get('local/courseInfo/semester')>
    <dt class="subHeading">${semester}</dt>

    <div style="clear:both;"></div>

    <#list juniorReviewFiles as juniorReviewFile>
        <#assign title = juniorReviewFile.get('title')>
        <#assign format = juniorReviewFile.get('projectFormat')>
        <#assign extent = juniorReviewFile.get('extent')>
        <#if title != "">
            <dd><strong>Title:</strong> <i>${title}</i></dd>
        </#if>
        <dd><strong>Format:</strong> ${format}</dd>
        <#assign workType = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat')>
        <#list juniorReviewFile.getAllSubtrees('projectFormatWrapper') as projectFormatWrapper>
            <#assign workTypeX = projectFormatWrapper.get('projectFormat')>
            <#if workTypeX == "">
                <i>Don't forget to identify your work type(s)!</i>
            <#else>
                <dd><strong>Work type: </strong>
                <#list workType as workType>
                    ${workType}<#if workType_has_next>; </#if>
                </#list>
                </dd>
            </#if>
        </#list>

        <#if extent != "">
            <dd><strong>Duration/Measurements: </strong>${extent}</dd>
        </#if>

        <#assign keywords = xml.list('local/juniorReviewWrapper/fileWrapper/keywordWrapper/keyword')>
        <#if (keywords?size > 0)>
            <dd><strong>Keyword(s): </strong>
            <#list keywords as keyword>
                ${keyword}<#if keyword_has_next>; </#if>
            </#list>
            </dd>
        </#if>
    </#list>

    <div style="clear:both;"></div>
    <#list courseWork as courseWork>
        <#assign process = courseWork.get('process')>
        <#if (process == "")>
            <i>Don't forget to write your self-evaluation!</i>
        <#else>
            <dd><strong>Self-evaluation: </strong>${process}</dd>
        </#if>
    </#list>

    <#assign artistStatementFile = xml.get('local/artistDocWrapper/artistStatementFile')>
    <#list itemAttachments as itemAttachment>
        <#if artistStatementFile = itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#assign thumb = '/thumbs/${itemUuid}/${itemversion}/${uuid}'>
            <dd>
                <strong>Artist Statement:</strong> <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">${full}</a>
            </dd>
            <div class="image-juniorReviewDocs" style="margin-left: 20px;">
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="${thumb}" alt="Artist's Statement"/></a>
            </div>
        </#if>
    </#list>
    <div style="clear:both;"></div>

    </#if>
</#list>
