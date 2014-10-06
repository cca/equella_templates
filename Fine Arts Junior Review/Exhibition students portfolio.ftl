<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign nameInfo = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list local as local>
    <#assign objective = local.get('objective')>
    <#if (objective=="exhibition photographs")>

    <dl>
        <h2 id="title">Junior Review Portfolio</h2>

    <#list nameInfo as nameInfo>
        <#assign name = nameInfo.get('namePart')>
        <dt class="indentNoLine">${name}
        <#list subNameWrapper as subNameWrapper>
            <#assign major = subNameWrapper.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            <#if major != "">
              - ${major}
            </#if>
        </#list>
        </dt>
    </#list>

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <dt class="subHeading">${semester}</dt>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>

    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list juniorReviewFiles as juniorReviewFiles>
            <#assign file = juniorReviewFiles.get('file')>
            <#assign title = juniorReviewFiles.get('title')>
            <#assign extent = juniorReviewFiles.get('extent')>
            <#if file==uuid>
                <#if full?ends_with(".zip")>
                <#elseif full?ends_with(".jpg")>
                    <div class='image-juniorReviewWork'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='photoImagelist'>
                    <#if title != ""><i>${title}</i><br /></#if>
                    <#if ('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat')!=''>
                        <#list juniorReviewFiles.getAllSubtrees('projectFormatWrapper') as projectFormatWrapper>
                            <#assign projectFormat = projectFormatWrapper.get('projectFormat')>
                            ${projectFormat}<br/>
                        </#list>
                    </#if>
                    <#if extent != "">${extent}<br /></#if>
                    <#if ('local/juniorReviewWrapper/fileWrapper/keywordWrapper/keyword')!=''>
                        <#list juniorReviewFiles.getAllSubtrees('keywordWrapper') as keywordWrapper>
                            <#assign keyword = keywordWrapper.get('keyword')>
                            ${keyword}<br/>
                        </#list>
                    </#if>
                    </p>
                    </div>

                <#elseif full?ends_with(".mov")>
                    <div class='image-juniorReviewMovImgWork'>
                        <a href="/items/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/p/r/6.1.r2275/com.tle.web.mimetypes.service/icons/quicktime.png"/></a>
                        <br/>
                    <p>
                        <#if title != ""><i>${title}</i><br /></#if>
                        <#if ('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat')!=''>
                            <#list juniorReviewFiles.getAllSubtrees('projectFormatWrapper') as projectFormatWrapper>
                                <#assign projectFormat = projectFormatWrapper.get('projectFormat')>
                                ${projectFormat}<br/>
                            </#list>
                        </#if>
                        <#if extent != "">${extent}<br /></#if>
                        <#if ('local/juniorReviewWrapper/fileWrapper/keywordWrapper/keyword')!=''>
                            <#list juniorReviewFiles.getAllSubtrees('keywordWrapper') as keywordWrapper>
                                <#assign keyword = keywordWrapper.get('keyword')>
                                ${keyword}<br/>
                            </#list>
                        </#if>
                    </p>
                    </div>

                <div style="clear:both;"></div>

                <#else>
                    <div class='image-juniorReviewWork'>
                        <a href="/file/${itemUuid}/${itemversion}/${full}">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='photoImagelist'>
                        <#if title != ""><i>${title}</i><br /></#if>
                        <#if ('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat')!=''>
                            <#list juniorReviewFiles.getAllSubtrees('projectFormatWrapper') as projectFormatWrapper>
                                <#assign projectFormat = projectFormatWrapper.get('projectFormat')>
                                ${projectFormat}<br/>
                            </#list>
                        </#if>

                        <#if ('local/juniorReviewWrapper/fileWrapper/keywordWrapper/keyword')!=''>
                            <#list juniorReviewFiles.getAllSubtrees('keywordWrapper') as keywordWrapper>
                                <#assign keyword = keywordWrapper.get('keyword')>
                                ${keyword}<br/>
                            </#list>
                        </#if>

                        <#if extent != "">${extent}<br /></#if>
                        </p>
                    </div>
                </#if>
            </#if>
        </#list>
    </#list>

    <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as artistStatementFile>
        <#list itemAttachments as itemAttachment>
            <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                <#assign thumb = itemAttachment.get('thumb')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#if thumb != ''>
                    <#assign thumbUrl = '/file/${itemUuid}/${itemversion}/${thumb}'>
                <#else>
                    <#-- this is more foolproof — appears to assign a generic
                    icon based on MIME type if no generated one is present -->
                    <#assign thumbUrl = '/thumbs/${itemUuid}/${itemversion}/${uuid}'>
                </#if>
                <dt>Artist Statement</dt>
                <div>
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="${thumbUrl}" alt="Artist's Statement"/></a>
                    <p class='artistDocs'><a href="/file/${itemUuid}/${itemversion}/${full}">${full}</a></p>
                </div>
            </#if>
        </#list>
    </#list>

<h4><i>Click on thumbnails below for image slideshow and accompanying video(s).</i></h4>
    </#if>
</#list>
