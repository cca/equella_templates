<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- Administrator only information-->
<#if userIsMemberOf("College Administrators") || userIsMemberOf("First Year Administrator") || userIsMemberOf("Library Administrator") || userIsMemberOf("First Year Faculty") || userIsMemberOf("First Year Coordinators") || userIsMemberOf("First Year TA") || userIsMemberOf("First Year External Reviewers") || userIsMemberOf('System Administrators')>
	<h4 class="alert">Assignment, assessment information and comments display ONLY<br>
    to First Year Faculty &amp; Staff, College Administrators, and External Reviewers.<hr></h4>

	<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>

	<#list courseWork as courseWork>
		<#assign assignmentTitle = courseWork.get('assignmentTitle')>
		<#assign assignmentDescription = courseWork.get('assignmentDescription')>
		<#assign assignmentDue = courseWork.get('assignmentDue')>
		<#assign assignmentDueText = courseWork.get('assignmentDue_freetext')>
		<#assign assignmentLength = courseWork.get('assignmentLength')>
		<#assign assignmentLengthText = courseWork.get('assignmentLength_freetext')>
		<#assign assignmentReferences = courseWork.get('assignmentReferences')>

		<#if (assignmentTitle != "")>
			<dt>Assignment Information</dt>
			<#if (assignmentTitle != "")>
				<dd><strong>Title:</strong> ${assignmentTitle}</dd>
			</#if>
			<#if (assignmentDescription != "")>
				<dd><strong>Description:</strong> ${assignmentDescription}</dd>
			</#if>
			<#if (assignmentDue != "")>
				<dd><strong>Assignment occurred during:</strong> ${assignmentDue}</dd>
			</#if>
			<#if (assignmentDueText != "")>
				<dd><strong>Other time period for when assignment occurred in semester:</strong> ${assignmentDueText}</dd>
			</#if>
			<#if (assignmentLength != "")>
				<dd><strong>Assignment length:</strong> ${assignmentLength}</dd>
			</#if>
			<#if (assignmentLengthText != "")>
				<dd><strong>Other description of length of assignment:</strong> ${assignmentLengthText}</dd>
			</#if>
			<#if (assignmentReferences != "")>
				<dd><strong>Assignment references:</strong> ${assignmentReferences}</dd>
			</#if>
		</#if>
	</#list>

	<#assign local = xml.getAllSubtrees('local')>
	<#list local as local>
		<#assign accreditation = local.get('accreditation')>
		<#assign rating = local.get('rating')>
		<#assign skills = local.list('skills')>
		<#assign skillsText = local.get('skills_freetext')>
		<#assign programLearningOutcomes = local.list('programLearningOutcomes')>
		<#assign ccaLearningOutcomes = local.list('ccaLearningOutcome')>
		<#assign teachingStrategies = local.list('teachingStrategy')>
		<#assign teachingStrategyText = local.get('teachingStrategy_freetext')>
		<#assign thinkingProcesses = local.get('thinkingProcesses')>
		<#assign critiqueStrategy = local.get('critiqueStrategy')>
		<#assign ccaValues = local.list('ccaValues')>
		<#assign ccaValuesText = local.get('ccaValues_freetext')>
		<#assign awards = local.list('award')>
		<#assign nominatedFors = local.list('nominatedFor')>
		<#assign yearNomineeAward = local.get('yearNomineeAward')>
		<#if (accreditation != "")>
			<dt>Accreditation and Assessment Review Information</dt>
			<dd><strong>Flagged for:</strong> ${accreditation}</dd>
			<#if (rating != "")>
				<dd><strong>Rating:</strong> ${rating}</dd>
			</#if>
			<#if (skills?size > 0)>
				<dd><strong>Skills used in work:</strong>
				<#list skills as skill>
					${skill}<#if skill_has_next>; </#if>
				</#list>
				</dd>
			</#if>
			<#if (skillsText != "")>
				<dd><strong>Other skills:</strong> ${skillsText}</dd>
			</#if>
			<#if (programLearningOutcomes?size > 0)>
				<dd><strong>FY Program Learning Outcomes:</strong>
				<#list programLearningOutcomes as programLearningOutcome>
					${programLearningOutcome}<#if programLearningOutcome_has_next>; </#if>
				</#list>
				</dd>
			</#if>
			<#if (ccaLearningOutcomes?size > 0)>
				<dd><strong>CCA Learning Outcomes:</strong>
				<#list ccaLearningOutcomes as ccaLearningOutcome>
					${ccaLearningOutcome}<#if ccaLearningOutcome_has_next>; </#if>
				</#list>
				</dd>
			</#if>
			<#if (teachingStrategies?size > 0)>
				<dd><strong>Teaching Strategies:</strong>
				<#list teachingStrategies as teachingStrategy>
					${teachingStrategy}<#if teachingStrategy_has_next>; </#if>
				</#list>
				</dd>
			</#if>
			<#if (teachingStrategyText != "")>
				<dd><strong>Other teaching strategies:</strong> ${teachingStrategyText}</dd>
			</#if>
			<#if (thinkingProcesses != "")>
				<dd><strong>Thinking Processes:</strong> ${thinkingProcesses}</dd>
			</#if>
			<#if (critiqueStrategy != "")>
				<dd><strong>Critique Strategy:</strong> ${critiqueStrategy}</dd>
			</#if>
			<#if (ccaValues?size > 0)>
				<dd><strong>CCA Values:</strong>
				<#list ccaValues as ccaValue>
					${ccaValue}<#if ccaValue_has_next>; </#if>
				</#list>
				</dd>
			</#if>
			<#if (ccaValuesText != "")>
				<dd><strong>Other CCA Values:</strong> ${ccaValuesText}</dd>
			</#if>
		</#if>
		<#if (nominatedFors?size > 0)>
		<dd>
			<strong>Nomination(s):</strong>
			<#list nominatedFors as nominatedFor>
				${nominatedFor}<#if nominatedFor_has_next>; </#if>
			</#list>
		</dd>
		</#if>
		<#if (awards?size > 0)>
		<dd>
			<strong>Award(s):</strong>
			<#list awards as award>
				${award}<#if award_has_next>; </#if>
			</#list>
		</dd>
		</#if>
		<#if (yearNomineeAward != "")>
			<dd>
				<strong>Year of nominations and/or awards:</strong> ${yearNomineeAward}
			</dd>
		</#if>
	</#list>
</#if>
</dl>
