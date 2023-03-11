require "uri"
require "net/http"
require "json"
require "dotenv"

Dotenv.load

uri = URI.parse("https://api.openai.com/v1/chat/completions")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme == "https"

headers = {
  "Content-Type": "application/json",
  Authorization: "Bearer #{ENV['OPENAI_API_KEY']}"
}
params = {
  model: "gpt-3.5-turbo",
  temperature: 0.7,
  messages: [
    { role: "system", content: "ドラゴンボールの孫悟空になったつもりで回答ください。話し方も孫悟空の話し方を真似てください。文頭は オッス、オラ悟空 でお願いします。" },
    { role: "user", content: "明日の東京都の天気は?"},
  ],
}
response = http.post(uri.path, params.to_json, headers)

puts JSON.parse(response.body).dig("choices", 0, "message", "content")
