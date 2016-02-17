<#function encode str>
    <#-- 2 encodings:
    1) return a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way
    2) encode "+" e.g. in course titles like "Form + Space"    -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "Junior Review">
    <dl>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#-- this is the Design Division power search ID -->
        <#assign powerSearch = 'P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#-- insert URL for appropriate department here -->
            <#assign departmentUrl = "">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
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
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != "">
                     — Graduated: <a href="${gradDateUrl}">${gradDate}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#assign abstract = xml.get('mods/abstract')>
        <#if abstract != "">
            <dd><b>Description</b>:<br><pre>${abstract}</pre></dd>
        </#if>

        <div class="clearfix">
        <h4><u>Image List</u></h4>
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#-- note: where file is stored & which files we want to
                display will vary by collection, lowResFile is default for
                web-ready images like JPGs -->
                <#assign file = seniorPacket.get('hiResFile')>
                <#assign date = seniorPacket.get('date')>
                <#-- formatOther is dimensions -->
                <#assign dimensions = seniorPacket.get('formatOther')>
                <#-- these are very much up to departments & phase is often not used  -->
                <#assign materials = seniorPacket.list('formatSpecific')>
                <#-- open-ended description -->
                <#assign description = seniorPacket.get('notes')>
                <#assign tags = seniorPacket.list('tags')>
                <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                    <#if title != ""><span class="title">${title}</span></#if>
                    <#if date != "">${date}<br></#if>

                    <#if materials?size != 0>
                        <b>Materials:</b>&nbsp;
                        <#list materials as material>
                            <#if material != 'other...'>
                                ${material}<#if material_has_next>, </#if>
                            <#else>
                                ${phase}<#if material_has_next>, </#if>
                            </#if>
                        </#list><br>
                    </#if>

                    <#if description != "">${description}<br></#if>
                    <#if dimensions != "">${dimensions}<br></#if>

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
                    </p>
                </div>

                </#if>
            </#list>
        </#list>
        </div>
    </dl>
</#if>
</#list>
