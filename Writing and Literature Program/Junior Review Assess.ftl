<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- Administrator only information-->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("College Administrators") || userIsMemberOf("Writing and Literature Administrator") || userIsMemberOf("Writing and Literature External Reviewers")>

<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReview = xml.getAllSubtrees('local/juniorReviewWrapper')>
<#assign award = xml.getAllSubtrees('local/award')>
<#assign rating = xml.getAllSubtrees('local/rating')>
<#assign nominatedFor = xml.getAllSubtrees('local/nominatedFor')>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<br />
<h5 style="color: #936;">Information below displays ONLY to Writing and Literature Faculty, Staff and College Administrators.</h5>

<dl>
<#list courseWork as courseWork>
    <#assign type = courseWork.get('courseWorkType')>
    <#if type=='Junior Review portfolio'>

        <#list juniorReview as juniorReview>
            <#assign historContext = juniorReview.get('historContext')>
            <#assign contempContext = juniorReview.get('contempContext')>
            <#assign visComm = juniorReview.get('visComm')>
            <#assign verbalComm = juniorReview.get('verbalComm')>
            <#assign writtenComm = juniorReview.get('writtenComm')>
            <#assign techMaterialSkill = juniorReview.get('techMaterialSkill')>
            <#assign personalVoice = juniorReview.get('personalVoice')>
            <#assign totalPoints = juniorReview.get('totalPoints')>
            <#assign averagePoints = juniorReview.get('averagePoints')>
            <#assign numberPanelists = juniorReview.get('numberPanelists')>
            <#assign CORE = juniorReview.get('CORE')>
            <#assign overall = juniorReview.get('overallQuality')>

            <dt>Junior Review Assessment</dt>
    <div style="clear:both;"></div>
            <dd><i>Averaged juror scores are displayed for each category.</i></dd>

            <dd class="subject">Technical execution & knowledge of craft: <strong>${techMaterialSkill}</strong></dd>
            <dd class="subject">Appropriate literary historical knowledge: <strong>${historContext}</strong></dd>
            <dd class="subject">Understanding of current literary practices: <strong>${contempContext}</strong></dd>
            <dd class="subject">Verbal/written ability to articulate ideas about work: <strong>${writtenComm}</strong></dd>
            <dd class="subject">Demonstrates a flair for language and literary form: <strong>${personalVoice}</strong></dd>
            <dd class="subject">Preparation and presentation: <strong>${visComm}</strong></dd>
            <dd class="subject">Progress toward a coherent body of work: <strong>${verbalComm}</strong></dd>
            <dd class="subject">Overall Quality of Work: <strong>${overall}</strong></dd>
            <div style="clear:both;"></div>

            <#list local as local>
                <#assign rating = local.get('rating')>
                <#assign awardText = local.get('award_freetext')>
                <#if (rating != "")><dd>Received <strong>${rating}</strong></#if>
                <#if (awardText=="")></dd><#else>because <strong>${awardText}</strong></dd></#if>

                <#assign awardx = local.get('award')>
                <#assign nominatedForx = local.get('nominatedFor')>
                <#assign nominatedText = local.get('nominated_freetext')>

                <#if (nominatedForx != "")>
                    <dd class="subject">Nominations:
                    <#list nominatedFor as nominatedFor>
                        <strong>received ${nominatedFor}</strong><#if nominatedFor_has_next>; </#if>
                    </#list></dd>
                </#if>
                <#if (awardx != "")>
                    <dd class="subject">Awarded:
                    <#list award as award>
                        <strong>${award}</strong><#if award_has_next>; </#if>
                    </#list>
                    </dd>
                </#if>
                <dd class="subject">Piece recommended for ACH: <strong>${nominatedText}</strong></dd>
            </#list>

            <div style="clear:both;"></div>

        </#list>

    </#if>
</#list>

</#if>
</dl>
