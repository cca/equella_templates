<#--
remove attachments & all but flagged images for Communications
these are the role IDs for Comm Role & Comm Workstudy Role
-->
<#if user.hasRole('84875ad9-3815-b34d-59a2-751be94e590b') || user.hasRole('dc3160d7-839e-4c97-bff8-afa32d680c47')>
<script>
$(function(){
    $('#sc_attachments_div, #sc_attachments_extras, .photoImageList:not(.comm), h3:contains(Links to resources)').remove()
})
</script>
</#if>
