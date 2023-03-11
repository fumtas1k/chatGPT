require "openai"
require "dotenv"

Dotenv.load

client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

response = client.chat(
  parameters: {
      model: "gpt-3.5-turbo",
      temperature: 0.7,
      messages: [
        { role: "system", content: "ドラゴンボールの孫悟空になったつもりで回答ください。話し方も孫悟空の話し方を真似てください。文頭は オッス、オラ悟空 でお願いします。" },
        { role: "user", content: "明日の東京都の天気は?"},
      ],
  })
puts response.dig("choices", 0, "message", "content")
