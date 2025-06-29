<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Helvetica', 'Monaco', Arial, sans-serif; background-color: #fffaf6; }
        .card { border-radius: 1rem; box-shadow: 0 2px 6px rgba(0,0,0,0.05); background-color: white; }
        .sidebar {
            height: 100vh; background-color: #ecc3a5; color: black; padding-top: 20px;
        }
        .sidebar a {
            color: black; display: flex; align-items: center; padding: 10px 20px; text-decoration: none;
        }
        .sidebar a:hover { background-color: #e4bfa3; text-decoration: none; }
        .sidebar i { margin-right: 10px; }
        .dashboard-title { font-weight: 600; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <h4 class="text-center">Admin Panel</h4>
            <a href="AdminDashboard.jsp"><i class="fas fa-home"></i>Dashboard</a>
            <a href="ManagePost.jsp"><i class="fas fa-clipboard"></i>Manage Posts</a>
            <a href="Admin.jsp"><i class="fas fa-box"></i>Manage Products</a>
            <a href="register_user.jsp"><i class="fas fa-users"></i>Manage Users</a>
            <a href="#"><i class="fas fa-comment-dots"></i>Feedback</a>
        </div>

        <div class="col-md-10 p-4">
            <h2 class="dashboard-title mb-4">Welcome, Admin!</h2>
            <div class="row">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    int productCount = 0, postCount = 0, userCount = 0, feedbackCount = 0;

                    try {
                        conn = utils.DBConnection.initializeDatabase();
                        stmt = conn.createStatement();

                        rs = stmt.executeQuery("SELECT COUNT(*) FROM skinpairs");
                        if (rs.next()) productCount = rs.getInt(1);
                        rs.close();

                        rs = stmt.executeQuery("SELECT COUNT(*) FROM discussion_posts");
                        if (rs.next()) postCount = rs.getInt(1);
                        rs.close();

                        rs = stmt.executeQuery("SELECT COUNT(*) FROM skinpairs_user");
                        if (rs.next()) userCount = rs.getInt(1);
                        rs.close();

                        rs = stmt.executeQuery("SELECT COUNT(*) FROM post_comments");
                        if (rs.next()) feedbackCount = rs.getInt(1);
                        rs.close();

                    } catch(Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>

                <!-- Dashboard boxes -->
                <div class="col-md-3 mb-4"><div class="card p-3 text-center"><h5>Products</h5><h2><%= productCount %></h2></div></div>
                <div class="col-md-3 mb-4"><div class="card p-3 text-center"><h5>Posts</h5><h2><%= postCount %></h2></div></div>
                <div class="col-md-3 mb-4"><div class="card p-3 text-center"><h5>Users</h5><h2><%= userCount %></h2></div></div>
                <div class="col-md-3 mb-4"><div class="card p-3 text-center"><h5>Feedbacks</h5><h2><%= feedbackCount %></h2></div></div>
            </div>

            <div class="card p-4 mb-4">
                <h5>Overview Chart</h5>
                <div style="height: 300px;"><canvas id="overviewChart"></canvas></div>
            </div>

            <!-- Recent Activities -->
            <div class="card p-4">
                <h5>Recent Activities</h5>
                <ul>
                <%
                    Connection logConn = null;
                    Statement logStmt = null;
                    ResultSet logRs = null;
                    try {
                        logConn = utils.DBConnection.initializeDatabase();
                        logStmt = logConn.createStatement();
                        logRs = logStmt.executeQuery("SELECT * FROM activity_log ORDER BY created_at DESC LIMIT 5");

                        while (logRs.next()) {
                            String type = logRs.getString("activity_type");
                            String desc = logRs.getString("description");
                            String time = logRs.getString("created_at");

                            out.println("<li><strong>" + type.toUpperCase() + "</strong>: " + desc + " <em style='color: gray;'>[" + time + "]</em></li>");
                        }

                    } catch(Exception e) {
                        out.println("<li>Error fetching activities: " + e.getMessage() + "</li>");
                    } finally {
                        if (logRs != null) logRs.close();
                        if (logStmt != null) logStmt.close();
                        if (logConn != null) logConn.close();
                    }
                %>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    const ctx = document.getElementById('overviewChart').getContext('2d');
    const chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [
                {
                    label: 'Product Uploads',
                    data: [5, 10, 7, 12, 8, 15],
                    borderColor: 'rgba(236, 195, 165, 1)',
                    backgroundColor: 'rgba(236, 195, 165, 0.4)',
                    fill: true
                },
                {
                    label: 'Posts Created',
                    data: [3, 6, 4, 8, 5, 10],
                    borderColor: 'rgba(255, 128, 128, 1)',
                    backgroundColor: 'rgba(255, 128, 128, 0.3)',
                    fill: true
                }
            ]
        },
        options: { responsive: true, maintainAspectRatio: false }
    });
</script>
</body>
</html>
