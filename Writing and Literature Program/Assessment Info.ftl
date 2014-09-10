
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
<#if currentUserIsMemberOf("System Administrators")||currentUserIsMemberOf("Library Administrator")||currentUserIsMemberOf("College Administrators")||currentUserIsMemberOf("Writing and Literature Administrator")||currentUserIsMemberOf("Writing and Literature External Reviewers")||currentUserIsMemberOf("Writing and Literature Faculty")>

<#list local as local>
    <#assign accreditation = local.get('accreditation')>
    <#assign rating = local.get('rating')>
    <#-- <dd>${accreditation} -->
    <#-- <dd>${rating} -->
    <#-- these URLs aren't used anywhere? -EP -->
    <#assign accreditationUrl = "" />
    <#assign ratingUrl = "" />
    <#if accreditation != "">
        <br />
        <h5 style="color: #936;">Information below displays ONLY to Writing and Literature Faculty &amp; Staff and College Administrators.</h5>
        <#if accreditation != "">
            <dt>Assessment information</dt>
            <#if accreditation != "">
                <dd><strong>Flagged for:</strong> ${accreditation}</dd>
            </#if>
                <dd><strong>Assessment of work:</strong>
                <#if (rating=="")> <em>(No rating assigned)</em>
                <#elseif (rating=="High")> Strong
                <#elseif (rating=="Medium")> Satisfactory
                <#elseif (rating=="Low")> Developing
                <#elseif (rating=="Inadequate")> Inadequate
                </dd>
            </#if>
        </#if>
    </#if>
</#list>

<#assign skills = xml.getAllSubtrees('local/skills')>
<#assign programLearningOutcomes = xml.getAllSubtrees('local/programLearningOutcomes')>
<#assign ccaLearningOutcome = xml.getAllSubtrees('local/ccaLearningOutcome')>
<#list local as local>
    <#assign skillsx = local.get('skills')>
    <#assign skillsText = local.get('skills_freetext')>
    <#if skillsx != "">
        <dd><strong>Skills Learning Outcomes:</strong></dd>
        <#list skills as skills>
            <dd>${skills}</dd>
        </#list>
    </#if>
    <#if skillsText != "">
        <dd><strong>Other skills:</strong> ${skillsText}</dd>
    </#if>

    <#assign programLearningOutcomesx = local.get('programLearningOutcomes')>
    <#assign ccaLearningOutcomex = local.get('ccaLearningOutcome')>
    <#if programLearningOutcomesx != "">
        <dd><strong>Knowledge Learning Outcomes:</strong>
            <#list programLearningOutcomes as programLearningOutcomes>
                <dd>${programLearningOutcomes}</dd>
            </#list>
        </dd>
    </#if>
    <#if ccaLearningOutcomex != "">
        <dd><strong>CCA Learning Outcomes:</strong>
            <#list ccaLearningOutcome as ccaLearningOutcome>
                <dd>${ccaLearningOutcome}</dd>
            </#list>
        </dd>
    </#if>
</#list>

</#if>
