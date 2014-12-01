<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- Administrator only information -->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("Library Administrator") || userIsMemberOf("College Administrators") || userIsMemberOf("Industrial Design Administrator") || userIsMemberOf("Industrial Design Faculty")>

<#list xml.getAllSubtrees('local') as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign rating = local.get('rating')>
    <#assign accreditationUrl = "" />
    <#assign ratingUrl = "" />
    <#if (accreditation != "")>
        <br />
        <h5 style="color: #936;">Information below displays ONLY to Industrial Design Faculty &amp; Staff and College Administrators.</h5>
        <#if (accreditation != "")>
            <dt>Assessment Information</dt>
            <#if (accreditation != "")>
                <dd>Flagged for: <a href="${accreditationUrl}">${accreditation}</a></dd>
            </#if>
            <#if (rating != "")>
                <dd>Assessment of work: <a href="${ratingUrl}">${rating}</a></dd>
            </#if>
        </#if>
    </#if>
</#list>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign note = relateditem.get('note')>
    <#assign type = relateditem.get('@type')>
    <#if (title != "" || note != "")>
        <dt>Related publication(s)</dt>
        <dd>
        <#if type != "">
            ${type}:
        </#if>
        <#if title != "">
            <em>${title}</em></dd>
        </#if>
        <#if note != "">
            <dd>Note: ${note}</dd>
        </#if>
    </#if>
</#list>

</#if>
</dl>
