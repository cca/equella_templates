<#-- these are submitted by Work Study Students and feature only a PDF
presentation & not a list of individual works. Workflow requested by Fine Arts
office in Fall 2020 to deal with remote learning. -->
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list local as local>
<#assign objective = local.get('objective')>
<#if (objective == "brief portfolio")>

    <dl>
        <h2 id="title">Junior Review Portfolio</h2>

    <#assign name = xml.get('mods/name/namePart')>
    <#-- TODO indentNoLine adds deceptive blue coloring
    makes this look like a link when it's not -->
    <#if name != "">
        <dt class="indentNoLine">${name}
            -<#list xml.list('mods/name/subNameWrapper/major') as major>
            ${major}<#if major_has_next>, </#if>
            </#list>
        </dt>
    </#if>

    <#assign semester = xml.get('local/courseInfo/semester')>
    <dt class="subHeading">${semester}</dt>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>

    <br>
    <h4><i>Click on thumbnails below for image slideshow and accompanying video(s).</i></h4>
</#if>
</#list>
