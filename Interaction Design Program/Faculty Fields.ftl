<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#if userIsMemberOf('Faculty') || userIsMemberOf('College Administrators') || userIsMemberOf('System Administrators') || userIsMemberOf('Interaction Design Administrators')>
  <h4 class="alert">Fields Visible to Faculty &amp; Administrators</h4>
  <dd>
    <b>Work Quality Assessment</b>:
    <#assign rating = xml.get('local/rating')>
    <#if rating != "">
      ${rating}
    <#else>
      <i>not assessed</i>
    </#if>
  </dd>
</#if>
