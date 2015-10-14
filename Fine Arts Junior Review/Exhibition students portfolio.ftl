<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list local as local>
    <#assign objective = local.get('objective')>
    <#if (objective == "exhibition photographs")>

    <dl>
        <h2 id="title">Junior Review Portfolio</h2>

    <#assign name = xml.get('mods/name/namePart')>
    <#-- @TODO indentNoLine adds deceptive blue coloring
    makes this look like a link when it's not -->
    <#if name != "">
        <dt class="indentNoLine">${name}
        <#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
        <#list subNameWrapper as subNameWrapper>
            <#assign major = subNameWrapper.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            <#if major != "">
              - ${major}
            </#if>
        </#list>
        </dt>
    </#if>

    <#assign semester = xml.get('local/courseInfo/semester')>
    <dt class="subHeading">${semester}</dt>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>

    <div class="clearfix js-masonry" data-masonry-options='{ "columnWidth": 130, "itemSelector": ".image-juniorReviewWork, .image-juniorReviewMovImgWork" }'>
    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list juniorReviewFiles as juniorReviewFiles>
            <#assign file = juniorReviewFiles.get('file')>
            <#assign title = juniorReviewFiles.get('title')>
            <#assign extent = juniorReviewFiles.get('extent')>
            <#if file == uuid>
                <#if full?ends_with(".zip")>
                <#-- print nothing, skip this attachment -->
                <#elseif full?ends_with(".jpg")>
                    <div class="image-juniorReviewWork">
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}" width="88" height="66"/></a>
                    <p class="photoImagelist">
                    <#if title != ""><i>${title}</i><br /></#if>
                    <#if xml.get('local/juniorReviewWrapper/fileWrapper/projectFormatWrapper/projectFormat') != ''>
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
                        <a href="/items/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/p/r/6.1.r2275/com.tle.web.mimetypes.service/icons/quicktime.png" width="88" height="66"/></a>
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

                <#else>
                    <div class="image-juniorReviewWork">
                        <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}" width="88" height="66"/></a>
                    <p class="photoImagelist">
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
    </div>

    <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as artistStatementFile>
        <#list itemAttachments as itemAttachment>
            <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#assign thumb = '/thumbs/${itemUuid}/${itemversion}/${uuid}'>
                <dt>Artist Statement</dt>
                <div>
                    <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="${thumb}" alt="Artist's Statement" width="88" height="66"/></a>
                    <p class="artistDocs"><a href="/file/${itemUuid}/${itemversion}/${full}">${full}</a></p>
                </div>
            </#if>
        </#list>
    </#list>

<h4><i>Click on thumbnails below for image slideshow and accompanying video(s).</i></h4>
    </#if>
</#list>

<script src="//cdn.jsdelivr.net/masonry/3.1.5/masonry.min.js"></script>
