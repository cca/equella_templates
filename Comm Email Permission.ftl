<#-- only for users in the unique "Communications Student Work Viewer Role"
generate an email template asking for permission to use the item -->
<#if user.hasRole('b8b91d93-ede5-4c34-84df-09d5b6bf27e5') || user.getUsername() == 'eric1'>
    <#assign id = item.getUuid()>
    <#assign version = item.getVersion()>
    <#assign item_url = 'https://vault.cca.edu/items/${id}/${version}/'>
    <#assign department = xml.get('local/department')>
    <#if department != ''>
        <#assign address = 'Dear [program chair for ${department}],\n\n'>
    <#else>
        <#assign address = 'Dear [INSERT NAME],\n\n'>
    </#if>
    <#assign body = "Communications would like to request permission to use the following piece of student work: ${item_url} . Allowing us to use this work lets us market CCA and displays the excellent work of students in your program. If you have any questions about the work's use, you can reply to this email.\n\nSincerely,\nCCA Marketing/Communications Department">
    <#assign email_template = 'mailto:?subject=' + 'Permission to use a student work in VAULT'?url + '&body=' + address?url + body?url>
    <div class="alert alert-info text-center">
        <h1>Communications</h1>
        <br>
        <a class="btn-primary btn" href="${email_template}">Ask for usage permission</a>
    </div>
</#if>
