<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>

<dl>
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<div id="images">
    <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
    </#list>
</div>

<#list xml.getAllSubtrees('local/internalSupportWrapper') as internalSupport>
    <#assign submissionType = internalSupport.get('submissionType')>
    <#assign browsers = internalSupport.list('browser')>
    <#assign categories = internalSupport.list('category')>
    <#assign priority = internalSupport.get('priority')>
        <#if submissionType != "">
            <dt>Nature of post</dt>
        </#if>
        <dd>
        <#if submissionType != "">
            This is a ${submissionType}.
        </#if>
        </dd>
        <dd>
        <#if priority != "">
            Priority is: ${priority}.
        </#if>
        </dd>
        <#if (categories?size != 0)>
            <dd>Category of post:
            <#list categories as category>
                ${category}<#if category_has_next>; </#if>
            </#list>
            </dd>
        </#if>

        <dd>
        <#if browsers?size != 0>
            Browser(s) in which issue was encountered:
            <#list browsers as browser>
                ${browser}<#if browser_has_next>; </#if>
            </#list>
        </#if>
        </dd>
</#list>

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != ""><dd class="abstract">${abstract}</dd></#if>

<#-- Administrator only information-->
<#if userIsMemberOf('System Administrators')>
    <hr>
    <h4 class="alert">Contributor information displays ONLY to system admins.</h4>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd>Contributor: <strong>${namePart}</strong></dd>
    </#list>
</#if>

</dl>
