<%@ page import="com.jk.klap.dao.ContentDAO, com.jk.klap.bean.ContentBean, java.util.*" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fun Learning Hub</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f4f7fb;
        }

        /* ===== MAIN CONTENT ===== */
        .content-section {
            margin-left: 200px;
            padding: 90px 30px 30px 30px;
        }

        .row {
            row-gap: 25px;
        }

        /* ===== CARD ===== */
        .content-box {
            background: white;
            border-radius: 18px;
            padding: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: 0.3s;
            cursor: pointer;

            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .content-box:hover {
            transform: translateY(-8px) scale(1.03);
        }

        /* ===== IMAGE FIXED ===== */
        .content-image {
            width: 100%;
            height: 180px;
            object-fit: contain;   /* ? FIX */
            background: #fff;
            border-radius: 12px;
            padding: 5px;
        }

        /* ===== TITLE ===== */
        .content-title {
            margin-top: 12px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        /* ===== MODAL ===== */
        .modal-dialog {
            max-width: 100%;
            margin: 0;
        }

        .modal-content {
            height: 100vh;
            border-radius: 0;
            background: linear-gradient(135deg, #ff9ccf, #ff4a72);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-image {
            max-width: 80%;
            max-height: 60%;
            border-radius: 20px;
        }

        #modalText {
            font-size: 3rem;
            margin-top: 20px;
        }

        .modal-buttons button {
            margin: 10px;
            padding: 10px 25px;
            border-radius: 10px;
            border: none;
            font-weight: bold;
        }

        .btn-info {
            background: #6f42c1;
            color: white;
        }

        .btn-success {
            background: #ff4081;
            color: white;
        }

        /* ===== MOBILE ===== */
        @media(max-width:768px){
            .content-section {
                margin-left: 0;
                padding: 80px 15px;
            }
        }

    </style>
</head>

<body>

<%
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    List<ContentBean> contentList = ContentDAO.getContentByCategoryId(categoryId);
%>

<!-- CONTENT -->
<div class="content-section">
    <div class="row g-4">

        <% for(int i = 0; i < contentList.size(); i++) {
            ContentBean bean = contentList.get(i);
        %>

        <!-- ? FIX: 3 cards per row -->
        <div class="col-12 col-sm-6 col-md-6 col-lg-4">
            <div class="content-box" onclick="openModal(<%= i %>)">

                <img src="<%= request.getContextPath() + "/" + bean.getImagePath() %>" 
                     class="content-image"/>

                <div class="content-title">
                    <%= bean.getTextContent() %>
                </div>

            </div>
        </div>

        <% } %>

    </div>
</div>

<!-- MODAL -->
<div class="modal fade" id="imageModal">
    <div class="modal-dialog">
        <div class="modal-content text-center">

            <img id="modalImage" class="modal-image"/>
            <h4 id="modalText"></h4>

            <div class="modal-buttons">
                <button id="backBtn" class="btn btn-info" onclick="prevImage()">? Back</button>
                <button class="btn btn-success" onclick="speakText(currentText)">? Speak</button>
                <button id="nextBtn" class="btn btn-info" onclick="nextImage()">Next ?</button>
            </div>

        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const contentList = [
        <% for (int i = 0; i < contentList.size(); i++) {
            ContentBean bean = contentList.get(i);
        %>
        {
            imagePath: "<%= request.getContextPath() + "/" + bean.getImagePath() %>",
            textContent: "<%= bean.getTextContent().replace("\"", "\\\"") %>"
        }<%= (i < contentList.size() - 1) ? "," : "" %>
        <% } %>
    ];

    let currentIndex = 0;
    let currentText = '';

    function speakText(text) {
        currentText = text;
        let utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = 'en-IN';
        window.speechSynthesis.cancel();
        window.speechSynthesis.speak(utterance);
    }

    function openModal(index) {
        currentIndex = index;
        updateModal();
        new bootstrap.Modal(document.getElementById('imageModal')).show();
    }

    function updateModal() {
        const content = contentList[currentIndex];
        document.getElementById("modalImage").src = content.imagePath;
        document.getElementById("modalText").textContent = content.textContent;
        currentText = content.textContent;

        document.getElementById("backBtn").style.display = currentIndex === 0 ? "none" : "inline-block";
        document.getElementById("nextBtn").style.display = currentIndex === contentList.length - 1 ? "none" : "inline-block";
    }

    function nextImage() {
        if (currentIndex < contentList.length - 1) {
            currentIndex++;
            updateModal();
        }
    }

    function prevImage() {
        if (currentIndex > 0) {
            currentIndex--;
            updateModal();
        }
    }
</script>

</body>
</html>