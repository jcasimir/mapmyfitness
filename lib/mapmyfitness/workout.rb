module MapMyFitness
  class Workout
    def connection
      @connection ||= build_connection
    end

    def build_connection
      connection = Faraday.new
      connection.headers['Api-Key'] = "qjy542tq9waw28njuqv7hz4ttddc2bch"
      connection
    end

    def records_for(user_id, token)
      connection.headers['Authorization'] = "Bearer #{token}"
      response = connection.get("https://oauth2-api.mapmyapi.com/v7.0/workout/?user=#{user_id}&access_token=#{token}")
      JSON.parse(response.body)
    end
  end
end
