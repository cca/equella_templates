
<#function currentUserIsMemberOf targetGroup>
  <#assign allowedGroupID = "" >
  <#list user.searchGroups("") as group>
    <#if group.getName() == targetGroup>
      <#assign allowedGroupID = group.getUniqueID()>
      <#break>
    </#if>
  </#list>
  <#if allowedGroupID != "" && user.isMemberOfGroup(allowedGroupID)>
    <#return true>
  </#if>
  <#return false>
</#function>

<#assign local = xml.getAllSubtrees('local')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<!#-- Administrator only information-->
<#if currentUserIsMemberOf("System Administrators")||currentUserIsMemberOf("Library Administrator")||currentUserIsMemberOf("College Administrators")||currentUserIsMemberOf("Graphic Design Administrator")||currentUserIsMemberOf("Graphic Design Faculty")>

<#list local as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign rating = local.get('rating')>
    <#assign accreditationUrl = "" />
    <#assign ratingUrl = "" />
        <br />
        <h5 style="color: #936;"><center>Assessment information &amp; comments display ONLY to<br/>Graphic Design Faculty &amp; Staff and College Administrators.</center></h5>
        <#if (accreditation=="")&&(rating != "")>
            <dt>Assessment</dt>
            <#if (accreditation != "")>
                <dd>Flagged for: <a href="${accreditationUrl}">${accreditation}</a></dd>
            </#if>
            <#if (rating != "")>
                <dd>Quality of work: <a href="${ratingUrl}">${rating}</a></dd>
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
