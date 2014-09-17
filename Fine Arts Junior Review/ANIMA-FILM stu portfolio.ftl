<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign nameInfo = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list local as local>
    <#assign objective = local.get('objective')>
    <#if (objective=="film/animation work")>

    <dl>
        <h2 id="title">Junior Review Portfolio
        </h2>

    <#list nameInfo as nameInfo>
        <#assign name = nameInfo.get('namePart')>
        <dt class="indentNoLine">${name}
        <#list subNameWrapper as subNameWrapper>
            <#assign major = subNameWrapper.get('major')>
            <#-- <dt>${major} -->
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            <#if (major=="")><#else>
              - ${major}
            </#if>
        </#list>
        </dt>
    </#list>

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <dt class="subHeading">${semester}
        </dt>
    </#list>

    <div style="clear:both;"></div>

    <#list juniorReviewFiles as juniorReviewFiles>
        <#assign title = juniorReviewFiles.get('title')>
        <#assign format = juniorReviewFiles.get('projectFormat')>
        <#assign extent = juniorReviewFiles.get('extent')>
        <#if title==""><#else><dd><strong>Title:</strong><i> ${title}</i></dd></#if>
        <dd><strong>Format:</strong> ${format}</dd>
        <#assign workType = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat')>
        <#list juniorReviewFiles.getAllSubtrees('projectFormatWrapper') as projectFormatWrapper>
            <#assign workTypeX = projectFormatWrapper.get('projectFormat')>
            <#if workTypeX==""><i>Don't forget to identify your work type(s)!</i><#else>
                <dd><strong>Work type: </strong><#list workType as workType>
                    ${workType}<#if workType_has_next>; </#if>
                </#list></dd>
            </#if>
        </#list>
        <#if extent==""><#else><dd><strong>Duration/Measurements: </strong>${extent}</dd></#if>

        <#assign keyword = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper/keywordWrapper/keyword')>
        <#list juniorReviewFiles.getAllSubtrees('keywordWrapper') as keywordWrapper>
            <#assign keywordx = keywordWrapper.get('keyword')>
            <#if keywordx==""><#else>
                <dd><strong>Keyword(s): </strong><#list keyword as keyword>
                    ${keyword}<#if keyword_has_next>; </#if>
                </#list></dd>
            </#if>
        </#list>
    </#list>

    <div style="clear:both;"></div>
    <#list courseWork as courseWork>
        <#assign process = courseWork.get('process')>
        <#if (process=="")><i>Don't forget to write your self-evaluation!</i><#else>
            <dd><strong>Self-evaluation: </strong>${process}</dd>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as artistStatementFile>
        <#list itemAttachments as itemAttachment>
            <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                <#assign thumb = itemAttachment.get('thumbnail')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#if thumb != ''>
                    <#assign thumbUrl = 'https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}'>
                <#else>
                    <#-- this is more foolproof — appears to assign a generic
                    icon based on MIME type if no generated one is present -->
                    <#assign thumbUrl = 'https://vault.cca.edu/thumbs/${itemUuid}/${itemversion}/${uuid}'>
                </#if>
                <dd><strong>Artist Statement:</strong> <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">${full}</a></dd>
                <div class="image-juniorReviewDocs" style="margin-left: 20px;">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <#-- these are required to be PDFs so we can
                    rely on the PDF icon -->
                    <img src="${thumbUrl}" alt="Artist's Statement"/></a>
                </div>
            </#if>
        </#list>
    </#list>
    <div style="clear:both;"></div>

    <#else></#if>
</#list>
