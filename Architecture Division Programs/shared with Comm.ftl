<#--
remove attachments & all but flagged images for Communications
these are the role IDs for Comm Role & Comm Workstudy Role
-->
<#if !user.hasRole('b8b91d93-ede5-4c34-84df-09d5b6bf27e5') && user.hasRole('84875ad9-3815-b34d-59a2-751be94e590b') || user.hasRole('dc3160d7-839e-4c97-bff8-afa32d680c47')>
<script>
$(function(){
    $('#sc_attachments_div, #sc_attachments_extras, .image-with-metadata:not(.comm), h3:contains(Links to resources)').remove()
})
</script>
</#if>
