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
<#-- Administrator only information -->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("Library Administrator") || userIsMemberOf("College Administrators") || userIsMemberOf("Writing and Literature Administrator") || userIsMemberOf("Writing and Literature External Reviewers") || userIsMemberOf("Writing and Literature Faculty")>

<#list local as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign rating = local.get('rating')>
    <#-- these URLs aren't used anywhere? -EP -->
    <#assign accreditationUrl = "">
    <#assign ratingUrl = "">
    <#if accreditation != "">
        <br />
        <h5 style="color: #936;">Information below displays ONLY to Writing and Literature Faculty &amp; Staff and College Administrators.</h5>
        <#if accreditation != "">
            <dt>Assessment information</dt>
            <dd><strong>Flagged for:</strong> ${accreditation}</dd>
            <dd><strong>Assessment of work:</strong>
            <#if (rating == "")> <em>(No rating assigned)</em>
                <#-- @todo translating values in the display seems like
                a bad idea, should change how they're stored maybe?
                —ep 2014-12-01 -->
                <#elseif (rating == "High")> Strong
                <#elseif (rating == "Medium")> Satisfactory
                <#elseif (rating == "Low")> Developing
                <#elseif (rating == "Inadequate")> Inadequate
                </dd>
            </#if>
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
