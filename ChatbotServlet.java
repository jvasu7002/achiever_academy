package achiever_web;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@SuppressWarnings("serial")
@WebServlet("/chat")
public class ChatbotServlet extends HttpServlet {

    private static final String API_KEY = "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";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userMessage = request.getParameter("message");

        String reply = getAIResponse(userMessage);

        response.setContentType("text/plain");
        response.getWriter().write(reply);
    }

    private String getAIResponse(String message) {

        try {
            URL url = new URL("https://openrouter.ai/api/v1/chat/completions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // 🔥 SYSTEM PROMPT (VERY IMPORTANT)
            String systemPrompt = "You are Achievers Academy assistant. "
                    + "Answer professionally. Only talk about courses, fees, admissions, timings. "
                    + "If unrelated question, politely refuse.";

            String jsonInput = "{"
                    + "\"model\":\"openai/gpt-3.5-turbo\","
                    + "\"messages\":["
                    + "{\"role\":\"system\",\"content\":\"" + systemPrompt + "\"},"
                    + "{\"role\":\"user\",\"content\":\"" + message + "\"}"
                    + "]"
                    + "}";

            OutputStream os = conn.getOutputStream();
            os.write(jsonInput.getBytes());
            os.flush();

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));

            String line;
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            String response = result.toString();

            // 🔧 Extract AI reply
            int start = response.indexOf("\"content\":\"") + 11;
            int end = response.indexOf("\"", start);

            return response.substring(start, end);

        } catch (Exception e) {
            e.printStackTrace();
            return "Server busy, please try again later.";
        }
    }
}