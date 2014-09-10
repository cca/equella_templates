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

<#-- Administrator only information-->
<#if currentUserIsMemberOf("System Administrators")||currentUserIsMemberOf("College Administrators")||currentUserIsMemberOf("Fine Arts Division Administrators")||currentUserIsMemberOf("Fine Arts workstudy")>
<#assign local = xml.getAllSubtrees('local')>
<#assign juniorReview = xml.getAllSubtrees('local/juniorReviewWrapper')>
<#assign award = xml.getAllSubtrees('local/award')>
<#assign rating = xml.getAllSubtrees('local/rating')>
<#assign nominatedFor = xml.getAllSubtrees('local/nominatedFor')>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<br />
<h5 style="color: #936;">Information below displays ONLY to Undergrad Fine Arts Staff and College Administrators.</h5>

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


    <dt>Junior Review Assessment</dt>

    <dd><i>Averaged juror scores are displayed for each category.</i></dd>
    <dd style="color: #936;"><u>COLLEGE WIDE LEARNING OUTCOMES</u></dd>

    <dd class="subject">Visual Communication: <strong>${visComm}</strong></dd>
    <dd class="subject">Historical Context: <strong>${historContext}</strong></dd>
    <dd class="subject">Contemporary Context: <strong>${contempContext}</strong></dd>
    <dd class="subject">Written Communication: <strong>${writtenComm}</strong></dd>
    <dd class="subject">Verbal Communication: <strong>${verbalComm}</strong></dd>
    <div style="clear:both;"></div>
    <dd style="color: #936;"><u>FINE ARTS LEARNING OUTCOMES</u></dd>
    <dd class="subject">Technical & Materials Skill: <strong>${techMaterialSkill}</strong></dd>
    <dd class="subject">Personal Voice: <strong>${personalVoice}</strong></dd>
    <div style="clear:both;"></div>
    <dd class="subject">TOTAL POINTS: <strong>${totalPoints}</strong></dd>
    <dd class="subject">AVERAGE POINTS: <strong>${averagePoints}</strong></dd>
    <hr style="color: #936;">
    <dd>Did student take CORE/FYP? <strong>${CORE}</strong></dd>
    <dd>Number of panelists: <strong>${numberPanelists}</strong></dd>
        <#list local as local>
            <#assign rating = local.get('rating')>
            <#assign awardText = local.get('award_freetext')>
            <#if (rating=="")><#else><dd>Received <strong>${rating}</strong></#if>
            <#if (awardText=="")></dd><#else>because <strong>${awardText}</strong></dd></#if>


    <#assign awardx = local.get('award')>
    <#assign nominatedForx = local.get('nominatedFor')>
    <#assign nominatedText = local.get('nominated_freetext')>

        <#if (nominatedForx=="")><#else>
        <dd>Nominated for:
            <#list nominatedFor as nominatedFor>
            <strong>${nominatedFor}</strong><#if nominatedFor_has_next>; </#if>
            </#list>
        </dd></#if>
        <#if (awardx=="")><#else>
        <dd>Awarded:
            <#list award as award>
            <strong>${award}</strong><#if award_has_next>; </#if>
            </#list>
        </dd>
        </#if>
        <dd>Scholarship notes: ${nominatedText}</dd>
    </#list>
    <div style="clear:both;"></div>

    <dt>Scanned juror forms</dt>
    <#list xml.getAllSubtrees('local/juniorReviewWrapper/file') as jurorform>
        <#list itemAttachments as itemAttachment>
            <#if jurorform.get('/') = itemAttachment.get('uuid')>
                <#assign thumb = itemAttachment.get('thumbnail')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#if full?ends_with(".zip")><#else>

                    <div class="image-juniorReviewDocs">
                        <a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                        <p class='artistDocs'>${full}</p>
                    </div>
                </#if>
            </#if>
        </#list>
    </#list>
    <div style="clear:both;"></div>
</#list>
</#if>

</dl>
