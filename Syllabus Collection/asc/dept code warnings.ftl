<#function userHasRole roleName>
  <#list user.searchRoles(roleName) as role>
    <#if user.hasRole(role.getUniqueID())>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#if userHasRole('Critical Studies Faculty Role')>
    <div class="control alert alert-warning">
    <h3>Multiple Subjects are under the CRTSD department</h3>
    <p>
        Please note that while the section code for your course may begin with
        <code>PHCRT</code>, <code>SCIMA</code>, or <code>SSHIS</code> that all of
        these classes fall under the Critical Studies program and can be found
        underneath the <b>CRTSD</b> code.
    </p>
    </div>
</#if>

<#if userHasRole('Writing and Literature Faculty Role')>
    <div class="control alert alert-warning">
    <h3>LITPA courses can be found under WRLIT</h3>
    <p>
        While your section code may be <code>LITPA</code> these courses are underneath
        the Writing & Literature Program and can be found under the <b>WRLIT</b> code.
    </p>
    </div>
</#if>
