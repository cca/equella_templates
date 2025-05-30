<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- Administrator only information -->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("Library Administrator") || userIsMemberOf("College Administrators") || userIsMemberOf("Writing and Literature Administrator") || userIsMemberOf("Writing and Literature External Reviewers") || userIsMemberOf("Writing and Literature Faculty")>
    <br>
    <h4 class="alert">Information below displays ONLY to Writing and Literature Faculty &amp; Staff and College Administrators.</h4>

<#list xml.getAllSubtrees('local') as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign useInReview = local.get('assessmentWrapper/useInReview')>
    <#if accreditation != "" || useInReview == 'yes'>
        <#if accreditation != "">
            <dt>Assessment information</dt>
            <dd><strong>Flagged for:</strong> ${accreditation}</dd>
            <dd><strong>Assessment of work:</strong>
            <#assign rating = local.get('rating')>
            <#if rating == ""> <em>(No rating assigned)</em>
                <#-- TODO translating values in the display seems like
                a bad idea, should change how they're stored maybe?
                —ep 2014-12-01 -->
                <#elseif rating == "High"> Strong
                <#elseif rating == "Medium"> Satisfactory
                <#elseif rating == "Low"> Developing
                <#elseif rating == "Inadequate"> Inadequate
            </#if>
            </dd>
        </#if>

        <#if useInReview == 'yes'>
            <#list local.getAllSubtrees('assessmentWrapper') as wrapper>
                <dd><b>Used in:</b> ${wrapper.get('date')} ${wrapper.get('type')}</dd>
                <#assign id = xml.get('mods/identifier')>
                <#if id != "">
                    <dd><b>Anonymous ID:</b> ${id}</dd>
                </#if>
            </#list>
        </#if>
    </#if>

    <#assign skills = local.list('skills')>
    <#assign skillsText = local.get('skills_freetext')>
    <#if skills?size != 0>
        <dd><strong>Skills Learning Outcomes:</strong></dd>
        <#list skills as skill>
            <dd>${skill}</dd>
        </#list>
    </#if>
    <#if skillsText != "">
        <dd><strong>Other skills:</strong> ${skillsText}</dd>
    </#if>

    <#assign programLearningOutcomes = local.list('programLearningOutcomes')>
    <#assign ccaLearningOutcomes = local.list('ccaLearningOutcome')>
    <#if programLearningOutcomes?size != 0>
        <dd><strong>Knowledge Learning Outcomes:</strong>
            <#list programLearningOutcomes as programLearningOutcome>
                ${programLearningOutcome}<br>
            </#list>
        </dd>
    </#if>
    <#if ccaLearningOutcomes?size != 0>
        <dd><strong>CCA Learning Outcomes:</strong>
            <#list ccaLearningOutcomes as ccaLearningOutcome>
                ${ccaLearningOutcome}<br>
            </#list>
        </dd>
    </#if>

</#list>
</#if>
