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

<#-- no need for red <h5> saying "info only displays to admins"
since that's done in the template before ("Assessment Info") -->

    <#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Junior Review portfolio'>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

        <#list xml.getAllSubtrees('local/juniorReviewWrapper') as juniorReview>
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

            <#assign rating = xml.get('local/rating')>
            <#assign awardText = xml.get('local/award_freetext')>
            <#if (rating != "")>
                <dd>Received <strong>${rating}</strong>
            </#if>
            <#if (awardText != "")>
                because <strong>${awardText}</strong>
            </#if>
            <#if rating != ""></dd></#if>

            <#assign awards = xml.list('local/award')>
            <#assign nominatedFors = xml.list('local/nominatedFor')>
            <#assign nominatedText = xml.get('local/nominated_freetext')>

            <#if (nominatedFors?size != 0)>
                <dd class="subject">Nominations:
                <#list nominatedFors as nominatedFor>
                    <strong>received ${nominatedFor}</strong><#if nominatedFor_has_next>; </#if>
                </#list>
                </dd>
            </#if>
            <#if (awards?size != 0)>
                <dd class="subject">Awarded:
                <#list awards as award>
                    <strong>${award}</strong><#if award_has_next>; </#if>
                </#list>
                </dd>
            </#if>
            <dd class="subject">Piece recommended for ACH: <strong>${nominatedText}</strong></dd>
        </#list>
    </#if>
</#if>
