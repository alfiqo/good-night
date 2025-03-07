class Rack::Attack
  ### 🚀 Throttle requests per IP ###
  throttle("req/ip", limit: 60, period: 1.minute) do |req|
    req.ip
  end
end
