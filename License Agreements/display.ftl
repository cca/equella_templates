<#assign date = xml.get('/mods/origininfo/dateCreatedWrapper/dateCreated')>
<#assign publisher = xml.get('/mods/originInfo/publisher')>
<#assign extent = xml.get('/mods/physicalDescription/extent')>
<#assign urls = xml.list('/mods/relatedItem/location')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign title = xml.get('/mods/titleInfo/title')>
<#assign publisherAddress = xml.get('/mods/originInfo/place')>
<#assign name = xml.get('/mods/name/namePart')>
<#assign position = xml.get('/mods/name/subNameWrapper/description')>
<#assign personAddress = xml.get('/mods/location/physicalLocation')>
<#assign telephone = xml.get('/mods/name/subNameWrapper/phone')>
<#assign email = xml.get('/mods/name/subNameWrapper/email')>
<#assign paymentReceived = xml.get('mods/noteWrapper/note')>
<#assign payment = xml.get('mods/relatedItem/identifier')>

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
            <#list attachments as attachment>
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
    <#if paymentReceived != ''>
        <#assign url = "/searching.do?in=C905e9e64-2d7c-4922-994c-bb467f52f9b2&q=%22${paymentReceived?url}%22">
        <dd><b>Payment:</b> <a href="${url}">${paymentReceived}.</a></dd>
        <#if payment != ''>
            <#list attachments as attachment>
                <#if attachment.get('uuid') == payment>
                    <#-- this is the lazy way to construct this link—with a search
                    on the title—but the way EQUELLA structures resource attachments
                    is so inane it would take 10x longer to figure out the best way -->
                    <#assign desc = attachment.get('description')>
                    <dd><b>Payment archived in VAULT:</b>
                        <a href="/searching.do?in=all&q=${desc?url}">${desc}</a>
                    </dd>
                </#if>
            </#list>
        </#if>
    </#if>

    <dt>Publisher Information</dt>
    <#if publisher != "">
        <dd><b>Publisher</b>: ${publisher}</dd>
    </#if>
    <#if publisherAddress != "">
        <dd>
            <b>Address</b>:<br>
            <#-- display line breaks in address with <pre> tag -->
            <pre>${publisherAddress}</pre>
        </dd>
    </#if>

    <dt>Creator Information</dt>
    <#if name != "">
        <dd><b>Name</b>: ${name}</dd>
    </#if>
    <#if position != "">
        <dd><b>Position</b>: ${position}</dd>
    </#if>
    <#if personAddress != "">
        <dd>
            <b>Address</b>:<br>
            <#-- display line breaks in address with <pre> tag -->
            <pre>${personAddress}</pre>
        </dd>
    </#if>
    <#if email != "">
        <dd><b>Email</b>: ${email}</dd>
    </#if>
    <#if telephone != "">
        <dd><b>Telephone</b>: ${telephone}</dd>
    </#if>
</dl>
