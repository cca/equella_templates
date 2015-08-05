<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- Administrator only information -->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("College Administrators") || userIsMemberOf("Photography Administrator") || userIsMemberOf("Photography Faculty") || userIsMemberOf("Fine Arts Division Administrators") || userIsMemberOf("Fine Arts Administrator")>
<#list xml.getAllSubtrees('local') as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign useInReview = local.get('assessmentWrapper/useInReview')>
    <#if accreditation != "" || useInReview == 'yes'>
        <br>
        <h4 class="alert">Information below displays ONLY to Photography Faculty, Photography Staff, &amp; College Administrators.</h4>
        <#if accreditation != "">
            <dt>Assessment information</dt>
            <dd><strong>Flagged for:</strong> ${accreditation}</dd>
            <dd><strong>Assessment of work:</strong>
            <#assign rating = local.get('rating')>
            <#if rating == ""> <em>(No rating assigned)</em>
                <#-- @TODO translating values in the display seems like
                a bad idea, should change how they're stored maybe?
                —ep 2014-12-01 -->
                <#elseif rating == "High"> Strong
                <#elseif rating == "Medium"> Satisfactory
                <#elseif rating == "Low"> Developing
                <#elseif rating == "Inadequate"> Inadequate
            </#if>
            </dd>
        </#if>

        <#list local.getAllSubtrees('assessmentWrapper') as wrapper>
            <dd><b>Used in:</b> ${wrapper.get('date')} ${wrapper.get('type')}</dd>
        </#list>
    </#if>

</#list>
</#if>
