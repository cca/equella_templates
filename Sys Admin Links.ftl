<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign base = '/items/${id}/${version}/'>
<#assign collection = xml.get('item/@itemdefid')>

<#if userIsMemberOf('System Administrators')>
    <div class="alert alert-info text-center">
        <h1>System Administrator Information</h1>
        <br>
        <a class="btn-primary btn" href="${base}<XML>">&lt;XML&gt;</a>
        <a class="btn-primary btn" href="/oai?verb=GetRecord&metadataPrefix=oai_dc&identifier=tle:${id}:${collection}:${version}">OAI-PMH</a>
        <a class="btn-primary btn" href="${base}~">~Tilde~</a>
        <a class="btn-primary btn" href="/api/item/${id}">API</a>
    </div>
</#if>
