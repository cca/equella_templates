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

<#if userIsMemberOf('System Administrators')>
    <div class="alert alert-info text-center">
        <h1>System Administrator Information</h1>
        <br>
        <a class="btn-primary btn" href="${base}<XML>">&lt;XML&gt;</a>
        <a class="btn-primary btn" href="${base}~">~Tilde~</a>
        <a class="btn-primary btn" href="/api/item/${id}">API</a>
    </div>
</#if>
