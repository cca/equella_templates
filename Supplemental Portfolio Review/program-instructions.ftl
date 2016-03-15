<#-- this is an ASC in the collection's contribution wizard -->
<#assign major = xml.get('/mods/name/subNameWrapper/major')>
<#switch major>

    <#case "Animation (BFA)">
        <!-- <#assign url = ''> -->
    	<#break>

    <#case "Architecture (BArch)">

    	<#break>

    <#case "Ceramics (BFA)">

    	<#break>

    <#case "Community Arts (BFA)">

    	<#break>

    <#case "Curatorial Practice (MA)">

        <#break>

    <#case "Design (MFA)">

    	<#break>

    <#case "Fashion Design (BFA)">

    	<#break>

    <#case "Film (BFA)">

    	<#break>

    <#case "Fine Arts (MFA)">

    	<#break>

    <#case "Furniture (BFA)">

    	<#break>

    <#case "Glass (BFA)">

    	<#break>

    <#case "Graphic Design (BFA)">

    	<#break>

    <#case "Illustration (BFA)">

    	<#break>

    <#case "Individualized Major (BFA)">
        <#assign url = 'https://www.cca.edu/'>
    	<#break>

    <#case "Industrial Design (BFA)">

    	<#break>

    <#case "Interaction Design (BFA)">

    	<#break>

    <#case "Interaction Design (MDes)">

    	<#break>

    <#case "Interior Design (BFA)">

    	<#break>

    <#case "Jewelry / Metal Arts (BFA)">

    	<#break>

    <#case "Master of Architecture (MArch)">

    	<#break>

    <#case "Master of Advanced Architectural Design (MAAD)">

    	<#break>

    <#case "MBA in Civic Innovation">

    	<#break>

    <#case "MBA in Design Strategy">

    	<#break>

    <#case "MBA in Strategic Foresight">

    	<#break>

    <#case "MFA in Comics">

    	<#break>

    <#case "MFA in Film">

    	<#break>

    <#case "Painting/Drawing (BFA)">

    	<#break>

    <#case "Photography (BFA)">

    	<#break>

    <#case "Printmaking (BFA)">

    	<#break>

    <#case "Sculpture (BFA)">

    	<#break>

    <#case "Social Practice and Public Forms (MA)">

    	<#break>

    <#case "Textiles (BFA)">

    	<#break>

    <#case "Undecided">
<p class="alert alert-error">
Undeclared students do not receive a supplemental portfolio review until they have declared a major. Students should submit their studio interests through the Early Registration Intake Form. Undeclared students will meet with their Academic Advisor during orientation to discuss their interests and finalize their schedules.
</p>
    	<#break>

    <#case "Visual and Critical Studies (MA)">

    	<#break>

    <#case "Visual Studies (BA)">

    	<#break>

    <#case "Writing and Literature (BA)">

    	<#break>

    <#case "Writing (MFA)">

    	<#break>

    <#default>
        <#assign url = 'https://www.cca.edu/'>

</#switch>

<#if url != ''>
    <div class="control">
    <#if major != "Undecided">
        <h3><a href="${url}" target="_blank">${major} Program Instructions</a></h3>
    </#if>
    <#-- fluid iframe embed of google doc -->
    <div style="width:100%;position:relative;padding:0;padding-top:75%">
      <iframe
        style="position:absolute;top:0;left:0;width:100%;height:100%;"
        src="${url}" frameborder="0">
      </iframe>
    </div>

    </div>
</#if>

<p>If there's no link above or the link doesn't work for you, please <a href="mailto:advisingrecord@cca.edu?subject=Supplemental+Portfolio+Review+Instructions">email Academic Advising</a>.</p>

<p>Please Note: Remember to refer to the <a href="https://www.cca.edu/admissions/admitted/registration">Early Registration</a> page on the CCA website for supplemental program submission requirements.</p>
