<#-- variables used to fill in values below -->
<#assign date = xml.get('/mods/origininfo/dateCreatedWrapper/dateCreated')>
<#assign publisher = xml.get('/mods/originInfo/publisher')>
<#assign extent = xml.get('/mods/physicalDescription/extent')>
<#assign title = xml.get('/mods/titleInfo/title')>
<#assign publisherAddress = xml.get('/mods/originInfo/place')>
<#assign name = xml.get('/mods/name/namePart')>
<#assign position = xml.get('/mods/name/subNameWrapper/description')>
<#assign personAddress = xml.get('/mods/location/physicalLocation')>
<#assign telephone = xml.get('/mods/name/subNameWrapper/phone')>
<#assign email = xml.get('/mods/name/subNameWrapper/email')>
<#assign collection = xml.get('mods/relatedItem/title')>

<div class="control alert no-print clearfix">
    <ul class="standard">
        <li><b>Review</b> the license agreement</li>
        <li><b>Print</b> a copy</li>
        <li><b>Sign</b> the copy</li>
        <li>Then either
            <ul>
                <li>
                    <b>Upload</b> a signed copy <a href="#p2c3" onclick="location+='#p2c3'; return false;">at the bottom of this form & press the green <b>Save</b> button</a>
                </li>
                <li>
                    <b>Email</b> the signed copy to your CCA Archives contact
                </li>
            </ul>
        </li>
    </ul>
    <button style="float:right;" class="btn btn-primary" onclick="window.print();return false">&nbsp;Print&nbsp;<i class="icon-print"></i></button>
</div>

<p><span class="highlight">This License Agreement (this "Agreement") is made effective as of ${date} (the "Effective Date") between California College of the Arts, 5212 Broadway, Oakland, California, 94618 ("Owner") and ${publisher} ("Publisher").</span></p>
<p>In consideration of the mutual promises contained herein and other good and valuable consideration, the receipt and sufficiency of which is hereby acknowledged, the parties agree as follows:</p>

<h2><u>I. Licensed Material Content; Grant of License</u></h2>
<p><span class="highlight">The materials that are the subject of this Agreement shall consist of: ${extent}</span> (hereinafter referred to as the "Content").</p>
<p>Publisher acknowledges that the copyright and title to the Content and any trademarks or service marks relating thereto remain with Owner and/or its suppliers. Publisher shall not have right, title or interest in the Content except as expressly set forth in this Agreement. Owner hereby grants to Publisher non-exclusive use of the Content in accordance with this Agreement.</p>

<h2><u>II. Delivery of Content to Publisher</u></h2>
<p>Owner will provide the Content to the Publisher in the following manner:</p>
<ul class="standard">
    <li>File Transfer. Copies of the Content may be provided through electronic transfer such as email; or</li>
    <li>Physical Media. Copies of the Content may be provided on physical media (e.g., CD or DVD).</li>
</ul>

<h2><u>III. Authorized Use of Content</u></h2>
<p>Content is to be used for the purpose of producing, distributing and exploiting print editions of the book currently entitled ${title} ("Book") by Publisher.</p>
<p>In connection with advertising, publicizing, exhibiting and exploiting the Book, Content may be used in whole or in part in any and all media, devices, processes and technology now known or hereafter devised except as restricted in Section IV.</p>

<h2><u>IV. Specific Restrictions on Use of Content</u></h2>
<p>Use of Content in Non-Print Media. Publisher shall not use the Content for media-based, electronic, online, or other such non-print versions of the Book without the prior written permission of Owner.</p>
<p>Use of the Content in electronic form for the purpose of advertising, publicizing, exhibiting and exploiting the Book must be in the form of derivatives created by the Publisher such that the resolution of the Content is no greater than 72 ppi with maximum image dimensions of 1000 pixels x 800 pixels.</p>
<p>Use of the Content in electronic form for the purpose of electronic editions or versions of the Book must be in the form of derivatives created by the Publisher such that the resolution of the longer side of the Content is no greater than 2000 pixels.</p>

<h2><u>V. Uses Not Covered</u></h2>
<p>This Agreement does not license Content for use in media productions, with the exception of electronic editions or versions of the Book as defined above.</p>
<p>This Agreement does not license Content for use in derivative print products without prior written consent of Owner.</p>

<h2><u>VI. Term</u></h2>
<p>This Agreement shall continue in effect for the duration of time in which the Book is in-print as designated by Publisher; commencing on the Effective Date.</p>

<h2><u>VII. Owner Obligations</u></h2>
<p>Owner acknowledges that Publisher is proceeding with the production, distribution, and exploitation of the Book in reliance upon and induced by the Agreement and therefore will not revoke it or attempt to enjoin or otherwise interfere with the same.</p>

<h2><u>VIII. Publisher Obligations</u></h2>
<p>Publisher shall have the right but not the obligation to utilize the Content in the Book, and in advertising, publicizing, exhibiting, or exploiting same, in whole or in part.</p>
<p>When the agreement is terminated, Publisher must destroy the Content as originally delivered by Owner, along with any derivatives created in the process of realizing the Book and associated advertising, publicity, etc.</p>

<h2><u>IX. Fees</u></h2>
<p>For use of Content as established in this Agreement, Publisher shall make payment to Owner as specified below. Payment shall be by check, payable to California College of the Arts, sent to Business Services Office, attn: Ken Tanzer, California College of the Arts, 1111 8th Street, San Francisco CA 94107.</p>
<p><span class="highlight">Specified fees: negotiated by project</span></p>
<p style="margin-left:3em;"><span class="highlight">For publications created for educational purposes, by not-for-profit institutions, compensation will be delivery of one copy of the "Content" as a finished product, in hardcover if so published, to the "Owner" within two months of release date.</span></p>
<p><span class="highlight">In cases where the above criteria are not met, or when the Content requested requires an exceptional amount of work on the part of the Owner, additional fees may be charged.</span></p>

<h2><u>X. Acknowledgement; Source Citation</u></h2>

<#-- special case for Mudflats where RS must be credited, too -->
<#if collection == 'Robert Sommer Mudflats Collection'>
    <p>Acknowledgement for use of Content shall reference: California College of the Arts Libraries. <span class="highlight">Preferred attribution and source for Content is: Photograph(s) by Robert Sommer. From the ${collection} at California College of the Arts Libraries, San Francisco, California.</span> Abbreviations may be substituted to conform with editorial style.</p>
<#else>
    <p>Acknowledgement for use of Content shall reference: California College of the Arts Libraries. <span class="highlight">Preferred attribution and source for Content is: from the ${collection} at California College of the Arts Libraries, San Francisco, California.</span> Abbreviations may be substituted to conform with editorial style.</p>
</#if>

<h2><u>XI. Assignment and Transfer</u></h2>
<p>Except as specifically stated in this agreement, parties may not assign, directly or indirectly, all or part of its rights or obligations under this Agreement without the prior written consent of the other party, which consent shall not be unreasonably withheld or delayed. The right to renegotiate terms is reserved if the nature of the assignee is substantially different.</p>

<h2><u>XII. Warranties</u></h2>
<p>Subject to the Limitations set forth elsewhere in this Agreement:</p>
<p>Owner warrants that it has the right to license the rights granted under this Agreement to use Content, that permission for publication and use is given as owner of the Content in its physical form and by virtue of being the creator of the Content in its digital form, and that use of the Content by Publisher in accordance with the terms of this Agreement does not infringe copyright of any known third party. The Owner shall indemnify and hold the Publisher harmless for any losses, claims, damages, awards, penalties, or injuries incurred, including reasonable attorney's fees, which arise from any claim by any third party of an alleged infringement of copyright or any other property right arising out of the use of the Content by the Publisher in accordance with the terms of this Agreement.</p>

<h2><u>XIII. Limitations on Warranties</u></h2>
<p>Notwithstanding anything else in this Agreement:</p>
<p>Neither party shall be liable for any indirect, special, incidental, punitive or consequential damages, including but not limited to loss of data, business interruption, or loss of profits, arising out of the use of or the inability to use the Content.</p>
<p>Owner makes no representation or warranty, and expressly disclaims any liability with respect to the integrity of the Content, including but not limited to errors or omissions in attribution and description, libel, infringement of rights of publicity, privacy, trademark rights, moral rights, or the disclosure of confidential information.</p>

<h2><u>XIV. Indemnities</u></h2>
<p>Each party shall indemnify and hold the other harmless for any losses, claims, damages, awards, penalties, or injuries incurred by any third party, including reasonable attorney's fees, which arise from any alleged breach of such indemnifying party's representations and warranties made under this Agreement, provided that the indemnifying party is promptly notified of any such claims. The indemnifying party shall have the sole right to defend such claims at its own expense. The other party shall provide, at the indemnifying party's expense, such assistance in investigating and defending such claims as the indemnifying party may reasonably request. This indemnity shall survive the termination of this Agreement.</p>

<h2><u>XV. Early Termination</u></h2>
<p>In the event that either party believes that the other materially has breached any obligations under this Agreement, or if Owner believes that Publisher has exceeded the scope of the License, such party shall so notify the breaching party in writing. The breaching party shall have 90 days from the receipt of notice to cure the alleged breach and to notify the non-breaching party in writing that cure has been effected. If the breach is not cured within 90 days, the non-breaching party shall have the right to terminate the Agreement without further notice.</p>

<h2><u>XVI. Governing Law</u></h2>
<p>This Agreement shall be interpreted and construed according to, and governed by, the laws of the State of California, excluding any such laws that might direct the application of the laws of another jurisdiction. The courts located in San Francisco, California, shall have jurisdiction to hear any dispute under this Agreement.</p>

<h2><u>XVII. Dispute Resolution</u></h2>
<p>In the event any dispute or controversy arising out of or relating to this Agreement, the parties agree to exercise their best efforts to resolve the dispute as soon as possible. The parties shall, without delay, continue to perform their respective obligations under this Agreement which are not affected by the dispute.</p>
<p><u>Mediation</u>. In the event that the parties cannot by exercise of their best efforts resolve the party shall give to the other party written notice of its decision to do so, including a description of the issues subject to the dispute and a proposed resolution thereof. Designated representatives of both parties shall attempt to resolve the dispute within 90 days after such notice. If those designated representatives cannot resolve the dispute, the parties shall meet in or near San Francisco, California, and describe the dispute and their respective proposals for resolution to responsible executives of the disputing parties, who shall act in good faith to resolve the dispute. If the dispute is not resolved within 90 days after such meeting, the dispute shall be submitted to binding arbitration in accordance with the Arbitration provision of this Agreement.</p>
<p><u>Arbitration</u>. Any controversies or disputes arising out of or relating to this Agreement shall be resolved by binding arbitration in accordance with the then current Commercial Arbitration Rules of the American Arbitration Association. The parties shall endeavor to select a mutually acceptable arbitrator knowledgeable about issues relating to the subject matter of this Agreement. In the event the parties are unable to agree to such a selection, each party will select an arbitrator and the arbitrators in turn shall select a third arbitrator. The arbitration shall take place at a location that is in or near San Francisco, California. All documents, materials, and information in the possession of each party that are in any way relevant to the claim(s) or dispute(s) shall be made available to the other party for review and copying no later than 45 days after the notice of arbitration is served.</p>
<p>The arbitrator(s) shall not have the authority, power, or right to alter, change, amend, modify, add, or subtract from any provision of this Agreement or to award punitive damages. The arbitrator shall have the power to issue mandatory orders and restraining orders in connection with the arbitration. The award rendered by the arbitrator shall be final and binding on the parties, and judgment may be entered thereon in any court having jurisdiction. The agreement to arbitration shall be specifically enforceable under prevailing arbitration law. During the continuance of any arbitration proceeding, the parties shall continue to perform their respective obligations under this Agreement.</p>

<h2><u>XVIII. Force Majeure</u></h2>
<p>Neither party shall be liable in damages or have the right to terminate this Agreement for any delay or default in performing hereunder if such delay or default is caused by conditions beyond its control including, but not limited to Acts of God, Government restrictions (including the denial or cancellation of any export or other necessary license), wars, insurrections and/or any other cause beyond the reasonable control of the party whose performance is affected.</p>

<h2><u>XIX. Entire Agreement</u></h2>
<p>This Agreement constitutes the entire agreement of the parties and supersedes all prior communications, understandings and agreements relating to the subject matter hereof, whether oral or written.</p>

<h2><u>XX. Amendment</u></h2>
<p>No modification or claimed waiver of any provision of this Agreement shall be valid except by written amendment signed by authorized representatives of Owner and Publisher.</p>

<h2><u>XXI. Severability</u></h2>
<p>If any provision or provisions of this Agreement shall be held to be invalid, illegal, unenforceable or in conflict with the law of any jurisdiction, the validity, legality and enforceability of the remaining provisions shall not in any way be affected or impaired thereby.</p>

<h2><u>XXII. Waiver of Contractual Right</u></h2>
<p>Waiver of any provision herein shall not be deemed a waiver of any other provision herein, nor shall waiver of any breach of this Agreement be construed as a continuing waiver of other breaches of the same or other provisions of this Agreement.</p>

<h2><u>XXIII. Notices</u></h2>
<p>All notices given pursuant to this Agreement shall be in writing and may be hand delivered, or shall be deemed received within 5 days after mailing if sent by registered or certified mail, return receipt requested. If any notice is sent by facsimile or email, confirmation copies must be sent by mail or hand delivery to the specified address. Either party may from time to time change its Notice Address by written notice to the other party.</p>

<div class="clearfix">
    <div class="left">
        <p><strong>If to Owner:</strong></p>
        <p>CCA Libraries<br>
        California College of the Arts<br>
        5212 Broadway<br>
        Oakland<br>
        California<br>
        94618</p>
    </div>

    <div class="right">
        <p><strong>If to Publisher:</strong></p>
        <p>${name}, representing<br>
        ${publisher}<br>
        <#-- display line breaks in address with <pre> tag -->
        <pre>${publisherAddress}</pre></p>
    </div>
</div>

<p><strong>IN WITNESS WHEREOF</strong>, the parties have executed this Agreement by their respective, duly authorized representatives as of the date first above written.</p>

<div class="clearfix">
    <p class="low-margin"><strong>OWNER:</strong></p>
    <p class="left">
        BY: ___________________________<br>
        Signature of Authorized Signatory of Owner
    </p>
    <p class="right">DATE: _________________________</p>
</div>

<p>Print Name: Annemarie Haar<br>
Title: Director of Libraries, California College of the Arts<br>
Address: 5212 Broadway Oakland CA 94618<br>
Telephone No.: 510-594-3657<br>
E-mail: <a href="mailto:ahaar@cca.edu" target="_blank">ahaar@cca.edu</a></p>

<div class="clearfix">
    <p class="low-margin"><strong>PUBLISHER:</strong></p>
    <p class="left">
        BY: ___________________________<br>
        Signature of Authorized Signatory of Owner
    </p>
    <p class="right">DATE: _________________________</p>
</div>
<p>Print Name: ${name}<br>
Title: ${title}<br>
Address:<br>
<#-- display line breaks in address with <pre> tag -->
<pre>${personAddress}</pre><br>
Telephone No.: ${telephone}<br>
E-mail: ${email}</p>
