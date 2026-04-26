<%@ page import="java.util.*, com.jk.klap.dao.QuestionDAO, com.jk.klap.bean.QuestionBean, com.jk.klap.utility.DBConnection" %>
<%
    Integer parentId = (Integer) session.getAttribute("parent_id");
    String childName = (String) session.getAttribute("child_name");

    if (parentId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String catIdStr = request.getParameter("categoryId");
    if (catIdStr == null || catIdStr.isEmpty()) {
        out.println("<h3 style='color:red;'>Category Id Missing!</h3>");
        return;
    }

    int categoryId = Integer.parseInt(catIdStr);
    QuestionDAO qdao = new QuestionDAO(DBConnection.getConnection());
    List<QuestionBean> questions = qdao.getQuestionsByCategory(categoryId);

    Collections.shuffle(questions);

    int totalQuestions = questions.size();
    if (totalQuestions > 10) {
        questions = questions.subList(0, 10);
        totalQuestions = 10;
    }

    if (totalQuestions == 0) {
        out.println("<h3 style='color:red;'>No questions found!</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Kids Test</title>
    <meta charset="UTF-8">

    <style>
        body {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            font-family: 'Quicksand', sans-serif;
            margin: 0;
            padding: 30px 0;
        }

        h2 {
            text-align: center;
            color: #ff4d6d;
        }

        .child-name {
            text-align: center;
            font-size: 1.3rem;
            color: #6a5acd;
            margin-bottom: 10px;
        }

        #timerBox {
            text-align: center;
            font-size: 1.4rem;
            color: #ff0000;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: #fff0f5;
            border-radius: 20px;
            padding: 25px;
        }

        .question-block {
            background: #e6f7ff;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .options label {
            display: block;
            background: #fff;
            padding: 12px;
            border-radius: 25px;
            margin: 8px 0;
            cursor: pointer;
        }

        input[type="radio"] {
            display: none;
        }

        input[type="radio"]:checked + label {
            background: #b0e0e6;
        }

        .submit-btn {
            display: block;
            margin: 30px auto;
            padding: 15px 40px;
            font-size: 1.2rem;
            border-radius: 30px;
            background: #fca311;
            color: white;
            border: none;
            cursor: pointer;
        }

        .fullscreen-message {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.9);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            z-index: 9999;
        }
    </style>
</head>

<body>

<div id="fullscreenMessage" class="fullscreen-message">
    <h2>This test must be taken in full screen</h2>
    <button onclick="enterFullscreen()">Enter Full Screen</button>
</div>

<div class="container" id="testContainer" style="display:none;">
    <h2>Fun Test</h2>
    <div class="child-name">Hello, <%= childName != null ? childName : "Kid" %></div>

    <!-- ? TIMER -->
    <div id="timerBox">
        Time Left: <span id="timer">10:00</span>
    </div>

    <form id="testForm" action="SubmitTestServlet" method="post">
        <input type="hidden" name="categoryId" value="<%= categoryId %>">
        <input type="hidden" name="totalQuestions" value="<%= totalQuestions %>">

        <% int qNo = 1;
        for (QuestionBean q : questions) { %>

        <div class="question-block">
            <h4>Q<%= qNo++ %>. <%= q.getQuestionText() %></h4>

            <div class="options">
                <input type="radio" id="a<%=q.getQuestionId()%>" name="q<%=q.getQuestionId()%>" value="A" required>
                <label for="a<%=q.getQuestionId()%>"><%= q.getOptionA() %></label>

                <input type="radio" id="b<%=q.getQuestionId()%>" name="q<%=q.getQuestionId()%>" value="B">
                <label for="b<%=q.getQuestionId()%>"><%= q.getOptionB() %></label>

                <input type="radio" id="c<%=q.getQuestionId()%>" name="q<%=q.getQuestionId()%>" value="C">
                <label for="c<%=q.getQuestionId()%>"><%= q.getOptionC() %></label>

                <input type="radio" id="d<%=q.getQuestionId()%>" name="q<%=q.getQuestionId()%>" value="D">
                <label for="d<%=q.getQuestionId()%>"><%= q.getOptionD() %></label>
            </div>
        </div>
        <% } %>

        <button type="submit" class="submit-btn">Submit Test</button>
    </form>
</div>

<script>
    let testStarted = false;
    let isSubmitting = false;

    // ? TIMER (10 minutes)
    let totalTime = 10 * 60;
    let timerInterval;

    function startTimer() {
        timerInterval = setInterval(() => {
            if (totalTime <= 0) {
                clearInterval(timerInterval);
                alert("Time is up! Test will be submitted.");
                submitForm();
            }

            let minutes = Math.floor(totalTime / 60);
            let seconds = totalTime % 60;
            document.getElementById("timer").innerText =
                String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');
            totalTime--;
        }, 1000);
    }

    function enterFullscreen() {
        document.documentElement.requestFullscreen();
        document.getElementById("fullscreenMessage").style.display = "none";
        document.getElementById("testContainer").style.display = "block";
        testStarted = true;
        startTimer();
    }

    function submitForm() {
        if (!isSubmitting) {
            isSubmitting = true;
            clearInterval(timerInterval);
            document.getElementById("testForm").submit();
        }
    }

    // ? Block reload / exit
    window.addEventListener("beforeunload", function (e) {
        if (testStarted && !isSubmitting) {
            submitForm();
            e.preventDefault();
            e.returnValue = '';
        }
    });
</script>

</body>
</html>
