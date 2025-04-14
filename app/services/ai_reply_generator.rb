class AiReplyGenerator
  def initialize(email, tone)
    @email = email
    @tone = tone
    @client = OpenAI::Client.new
  end

  def generate
    prompt = build_prompt
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a professional email assistant. Generate a reply to the given email in the specified tone." },
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  private

  def build_prompt
    <<~PROMPT
      Please generate a professional email reply with the following requirements:

      Email to reply to:
      #{@email}

      Tone: #{@tone}

      Please ensure the reply is:
      1. Professional and appropriate
      2. Matches the specified tone
      3. Addresses the key points in the original email
      4. Is concise and clear
    PROMPT
  end
end
