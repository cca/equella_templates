<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#if userIsMemberOf('Staff') || userIsMemberOf('Faculty') || userIsMemberOf('staff') || userIsMemberOf('faculty') || userIsMemberOf('System Administrators')>
    <#assign nominatedFor = xml.get('local/nominatedFor')>
    <#assign award = xml.get('local/award')>
    <#if nominatedFor != "" || award != "">
        <dt>Awards & Nominations</dt>
        <dd class="text-error">These fields display only for Faculty and Staff.</dd>
        <#if nominatedFor != ""><dd><strong>${nominatedFor}</strong></dd></#if>
        <#if award != ""><dd><strong>${award}</strong></dd></#if>
    </#if>
</#if>
