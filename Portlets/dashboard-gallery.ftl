<#-- load the following CSS files to go with this portlet:
- /file/3c22fa1f-f837-45af-a675-115894f6b1ae/1/justifiedGallery.min.css
- /file/0be6649f-15fa-45da-80ac-1a9c539a9418/2/dashboard-non-cca.min.css

load the following JS files:
- /file/3c22fa1f-f837-45af-a675-115894f6b1ae/2/jquery.justifiedGallery.min.js

see Web Assets collection to find these -->
<script src="/file/9e9a26b8-5d55-4d11-82f6-0f6e901c65a8/3/non-cca-home.min.js"></script>

<div id="mainPageBox">
    <div id="mainTabs">
        <a data-target="#communications" class="mainTab active" onclick="_gaq.push(['_trackEvent', 'gallery', 'tab', 'communications']);">Communications</a>
        <a data-target="#libraryCollections" class="mainTab" onclick="_gaq.push(['_trackEvent', 'gallery', 'tab', 'library collections']);">Libraries' Collections</a>
        <#if user.hasRole('TLE_LOGGED_IN_USER_ROLE')>
            <a href="/access/searching.do?in=all&type=gallery" class="tab link"
            onclick="_gaq.push(['_trackEvent', 'gallery', 'tab', 'browse all']);">
            Browse All Collections</a>
        </#if>
    </div>

    <div id="communications" class="imgContainer">
        <a href="//vault.cca.edu/items/63b16c33-1187-4a72-bfc1-02886463e9d2/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/SFcampus03.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/f90ffbc1-d648-41cc-9c3f-0c2a79d89990/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/13_CCA-Martinez-Oakland.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/092e8fa5-7a9a-419d-b16e-a5978c4da7e0/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/10_CCA_ArchStudio.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/d9a46034-9456-44fb-bf29-0b78a7c4510e/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/12_CCA-Student-Center.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/017d392b-3678-4480-b1e3-e398995b5db9/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/11_CCA-Wattis-exterior.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/96c2d9ea-5811-4672-8aaa-707af5a339e8/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/09_CCA-Nave-interior.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/c05ed9b7-6ae1-44db-bd42-32b3649468a5/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/08_CCA-Nave-interior.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/135c3377-8b72-4a46-8781-8a588d8d0d26/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/07_CCA-GradCenter.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/b3ab986a-9fe2-420b-8d27-c13c09b0771a/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/05_CCA-Wattis.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/95fe2008-dbac-4bfb-b7ed-9bc31d5d83d4/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/06_CCA-GradCenter.jpg/thumbnail.jpg">
        </a>
        <a href="//vault.cca.edu/items/01d7929b-ae0e-4bcb-8e86-bd3d5437fbe9/1/">
            <img src="//vault.cca.edu/file/1b004418-0315-4fd9-9245-d2092ac8e6c6/1/_TILES/04_CCA-Nave-interior.jpg/thumbnail.jpg">
        </a>
    </div>

    <div id="libraryCollections" class="imgContainer">
        <a href="/items/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/">
            <img src="/file/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/13051706PS.jpg">
        </a>
        <a href="/items/aea1a5b3-439c-40b7-9108-201177493e57/1/">
            <img src="/file/aea1a5b3-439c-40b7-9108-201177493e57/1/_THUMBS/13051701PS.jpg_PREVIEW_.jpeg">
        </a>
        <a href="/items/5f86f540-3804-ada6-d23d-deba76285264/1/">
            <img src="/file/5f86f540-3804-ada6-d23d-deba76285264/1/_TILES/06050806PR.jpg/thumbnail.jpg">
        </a>
        <a href="/items/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/">
            <img src="/file/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/_THUMBS/13051705PS.jpg_PREVIEW_.jpeg">
        </a>
        <a href="/items/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/">
            <img src="/file/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/_TILES/06050811PS.jpg/thumbnail.jpg">
        </a>
        <a href="/items/e8c45774-fe75-1d59-5fed-e61e96690231/1/">
            <img src="/file/e8c45774-fe75-1d59-5fed-e61e96690231/1/_TILES/05122214CP.jpg/thumbnail.jpg">
        </a>
        <a href="/items/89207d4c-c06f-871e-21c5-b09505ef2f04/1/">
            <img src="/file/89207d4c-c06f-871e-21c5-b09505ef2f04/1/_TILES/06050801PR.jpg/thumbnail.jpg">
        </a>
          <a href="/items/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/">
            <img src="/file/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/_TILES/06050812PR.jpg/thumbnail.jpg">
        </a>
        <a href="/items/ff95c836-1236-ed70-1608-12f426442fe6/1/">
            <img src="/file/ff95c836-1236-ed70-1608-12f426442fe6/1/_TILES/06050802PR.jpg/thumbnail.jpg">
        </a>
        <a href="/items/576f4150-48d2-3fac-7e65-b81eb9287f36/1/">
            <img src="/file/576f4150-48d2-3fac-7e65-b81eb9287f36/1/_TILES/06101202PR.jpg/thumbnail.jpg">
        </a>
        <a href="/items/3b20fff3-0974-7958-ef34-47feba6418e8/1/">
            <img src="/file/3b20fff3-0974-7958-ef34-47feba6418e8/1/_THUMBS/07011307WA.jpg_PREVIEW_.jpeg">
        </a>
        <a href="/items/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/">
            <img src="/file/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/_TILES/06052201PS.jpg/thumbnail.jpg">
        </a>
        <a href="/items/1a227ece-b336-95df-9fae-b5d318949f8c/1/">
            <img src="/file/1a227ece-b336-95df-9fae-b5d318949f8c/1/_TILES/06110103BE.jpg/thumbnail.jpg">
        </a>
        <a href="/items/e6490676-0020-3a29-85b6-7a41352a383b/1/">
            <img src="/file/e6490676-0020-3a29-85b6-7a41352a383b/1/_TILES/05122201BE.jpg/thumbnail.jpg">
        </a>
    </div>
</div>
