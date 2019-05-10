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
<dd class="alert alert-warning">
    <h2 id="title">${title}</h2>
    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != ""><dd class="abstract"><pre>${abstract}</pre></dd></#if>
</dd>

<#assign answer = xml.get('mods/noteWrapper/note')>
<#if answer != ''>
    <dd>
        <h2>Answer</h2>
        <dd>
            <strong><pre>${answer}</pre></strong>
        </dd>
    </dd>
</#if>

<div id="images">
    <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
            <#if full?ends_with(".pdf") || full?ends_with(".PDF")>
                <img src="/file/ad812d22-e473-493f-9f15-9538a8830da6/1/pdf.png">
            <#else>
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
            </#if>
        </a>
    </#list>
</div>

<#list xml.getAllSubtrees('local/internalSupportWrapper') as internalSupport>
    <#assign submissionType = internalSupport.get('submissionType')>
    <#assign browsers = internalSupport.list('browser')>
    <#assign categories = internalSupport.list('category')>
    <#assign priority = internalSupport.get('priority')>
        <#if submissionType != "">
            <dt>Further Details</dt>
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

<#-- Administrator only information-->
<#if userIsMemberOf('System Administrators')>
    <hr>
    <h4 class="alert">Contributor information displays ONLY to system admins.</h4>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#assign email = xml.get('item/owner/user/email')>
        <dd>Contributor: <strong>${namePart}</strong></dd>
        <dd>Email: <strong>${email}</strong></dd>
        <#assign firstname = xml.get('item/owner/user/givenname')>
        <!-- specially crafted email link for this issue -->
        <#assign url = 'mailto:' + email + '?subject=Re:%20' + title?url + '&body=' + 'Hi%20' + firstname + ',\n'>
        <dd>
            <a href="${url}" class="btn btn-default" target="_blank"><i class="icon-envelope"></i>&nbsp;Email this user</a>
        </dd>
    </#list>
</#if>

</dl>
