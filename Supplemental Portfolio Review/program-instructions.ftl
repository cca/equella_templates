<#--
this is an ASC in the collection's contribution wizard
each major has its own instructions for the portfolio
so we use major as a switch to change the documentation URL
-->

<#assign major = xml.get('/mods/name/subNameWrapper/major')>
<#switch major>

    <#case "Animation (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/12iCTO9rD6xNVWJm7D5k05u6Z32E7s023hbYu2JvchBo/preview?usp=sharing'>
    	<#break>

    <#case "Architecture (BArch)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1VR_B6B-H-3kSIfBOoxRM-TfqPZlpWHr91f0dyh28KRQ/preview?usp=sharing'>
    	<#break>

    <#case "Ceramics (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1LVGg9dDFbEn9k7cyKFjzEWDdbyPEb7qdX2v4N5WjbKs/preview?usp=sharing'>
    	<#break>

    <#case "Community Arts (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1esZpCFb3l5jO3QOeg_zcSjyf91gg-cNC1JTL1bzOiZ0/preview?usp=sharing'>
    	<#break>

    <#case "Fashion Design (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1rf1U6346K8WYTSCibZyU69fnGuBZdbhIiJCWfTaOOjA/preview?usp=sharing'>
    	<#break>

    <#case "Film (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/150VdUP9Ts7XKG_p6RJSXpZHvGu4KIRRV8WdpGmn0GV4/preview?usp=sharing'>
    	<#break>

    <#case "Furniture (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1y49nLKoxz12VcCSF4BbSl8Usafo8_7ZS5sLglpVgpm4/preview?usp=sharing'>
    	<#break>

    <#case "Glass (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1e-6oeuENe-eDYchB_Dwh9kw2J_D_axreLV0u1Y9zFZM/preview?usp=sharing'>
    	<#break>

    <#case "Graphic Design (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1F7IUEHsZOQDlmlIf_derIO_Ewa2kFxoXRE8eYfswdVE/preview?usp=sharing'>
    	<#break>

    <#case "Illustration (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/16IPT_ZnaF3Udm3L9Pj6KG7SpsM2y6WuaH5zi5QvSVHA/preview?usp=sharing'>
    	<#break>

    <#case "Individualized Major (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/11nW4yp2msdZ9ozE6VD1t4XVKoQjqNAZDX3qxx6ZztqQ/preview?usp=sharing'>
    	<#break>

    <#case "Industrial Design (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1EQoQlwj-1GLG95um9P2rVbVOBKfRfITm0zOpWa5GS-M/preview?usp=sharing'>
    	<#break>

    <#case "Interaction Design (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1eY92N0XPbaCsZx4zMDEc77f7JtVw8he9H6F8kbgjcy0/preview?usp=sharing'>
    	<#break>

    <#case "Interior Design (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/16_OX4DUwcMBv4ksmrOMUicfeccBunKMF0Jo2E_3yPoM/preview?usp=sharing'>
    	<#break>

    <#case "Jewelry / Metal Arts (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1BPs2EHd7QmBd3TzftDq97xhS4u42fDjzdtAkotXjXLE/preview?usp=sharing'>
    	<#break>

    <#case "Painting/Drawing (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/18Udpdx1KpStfW8OR3VNr1q3-V0BmFNwIovHiJh_OKaQ/preview?usp=sharing'>
    	<#break>

    <#case "Photography (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1JAt8g7TyLFpfS2RllBa8ebiyMHxvQFTVJUvD2rHQFKI/preview?usp=sharing'>
    	<#break>

    <#case "Printmaking (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1erqTNVIqAyCUH7EuN4zkENjH0HsMKOqyFkXprU4p_1U/preview?usp=sharing'>
    	<#break>

    <#case "Sculpture (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/18Bv10YhVKTHgcrlI_eRAieatx8ETBfNbqZ8n9KmOACo/preview?usp=sharing'>
    	<#break>

    <#case "Textiles (BFA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1N7PZp81GrwIBRhBwpXu3tzDXwgQcPQI4LOo8OpK-iQ8/preview?usp=sharing'>
    	<#break>

    <#case "Undecided">
<p class="alert alert-error">
Undeclared students do not receive a supplemental portfolio review until they have declared a major. Students should submit their studio interests through the Early Registration Intake Form. Undeclared students will meet with their Academic Advisor during orientation to discuss their interests and finalize their schedules.
</p>
    	<#break>

    <#case "Visual Studies (BA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1QM7YVEM0GUQN4ME_SScx3aZrI7SzNwf_-NPuaWHydIc/preview?usp=sharing'>
    	<#break>

    <#case "Writing and Literature (BA)">
        <#assign url = 'https://docs.google.com/a/cca.edu/document/d/1ALv8nPvha0hcsH3eyRaGfmjYS8JO20rV8sWpu7CSddw/preview?usp=sharing'>
    	<#break>

    <#default>
        <#-- no default URL for now -->
        <#-- <#assign url = ''> -->

</#switch>

<#-- guard against URL being undefined (e.g. in <#default> case) -->
<#if url?exists && url != ''>
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

<p>Please Note: Refer to the <a href="https://www.cca.edu/admissions/admitted/registration">Early Registration</a> page on the CCA website for supplemental program submission requirements.</p>
