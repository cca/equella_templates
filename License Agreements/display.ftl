<#assign date = xml.get('/mods/origininfo/dateCreatedWrapper/dateCreated')>
<#assign publisher = xml.get('/mods/originInfo/publisher')>
<#assign extent = xml.get('/mods/physicalDescription/extent')>
<#assign urls = xml.list('/mods/relatedItem/location')>
<#assign title = xml.get('/mods/titleInfo/title')>
<#assign publisherAddress = xml.get('/mods/originInfo/place')>
<#assign name = xml.get('/mods/name/namePart')>
<#assign position = xml.get('/mods/name/subNameWrapper/description')>
<#assign personAddress = xml.get('/mods/location/physicalLocation')>
<#assign telephone = xml.get('/mods/name/subNameWrapper/phone')>
<#assign email = xml.get('/mods/name/subNameWrapper/email')>

<dl>
    <#if date != "">
        <dt>Effective Date</dt>
        <dd class="date">${date}</dd><br>
    </#if>

    <dt>Work Information</dt>
    <#if extent != "">
        <dd><b>Material Used</b>: ${extent}</dd>
    </#if>
    <#if urls?size != 0>
        <dd><b>Material URL(s)</b>:<ul>
        <#list urls as url>
            <#list xml.getAllSubtrees('item/attachments/attachment') as attachment>
            <#if url == attachment.get('uuid')>
                <#assign link = attachment.get('file')>
                <a href="${link}">${link}</a><br>
            </#if>
            </#list>
        </#list>
        </ul></dd>
    </#if>
    <#if title != "">
        <dd><b>Title</b>: ${title}</dd>
    </#if>

    <dt>Publisher Information</dt>
    <#if publisher != "">
        <dd><b>Publisher</b>: ${publisher}</dd>
    </#if>
    <#if publisherAddress != "">
        <dd><b>Address</b><br>${publisherAddress}</dd>
    </#if>

    <dt>Creator Information</dt>
    <#if name != "">
        <dd><b>Name</b>: ${name}</dd>
    </#if>
    <#if position != "">
        <dd><b>Position</b>: ${position}</dd>
    </#if>
    <#if personAddress != "">
        <dd><b>Address</b>: ${personAddress}</dd>
    </#if>
    <#if email != "">
        <dd><b>Email</b>: ${email}</dd>
    </#if>
    <#if telephone != "">
        <dd><b>Telephone</b>: ${telephone}</dd>
    </#if>
</dl>
