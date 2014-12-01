<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#assign local = xml.getAllSubtrees('local')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#-- Administrator only information-->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("Library Administrator") || userIsMemberOf("College Administrators") || userIsMemberOf("Fashion Design Administrator") || userIsMemberOf("Fashion Design Faculty")>

<#list local as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign rating = local.get('rating')>
    <#assign accreditationUrl = "" />
    <#assign ratingUrl = "" />
    <#if (accreditation != "")>
        <br />
        <h5 style="color: #936;">Information below displays ONLY to Fashion Design Faculty &amp; Staff and College Administrators.</h5>
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

<#list relateditem as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign note = relateditem.get('note')>
    <#assign type = relateditem.get('@type')>
    <#if (title == "" && note== "")><#else>
        <dt>Related publication(s)</dt>
        <#if type=="">
            <dd>
            <#else>
            <dd>${type}:
        </#if>
        <#if title==""><#else>
            <em>${title}</em></dd>
        </#if>
        <#if note==""><#else>
            <dd>Note: ${note}</dd>
        </#if>
    </#if>
</#list>

</#if>
</dl>
