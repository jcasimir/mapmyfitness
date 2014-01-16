module MapMyFitness
  class Workout
    def connection
      @connection ||= build_connection
    end

    def build_connection
      connection = Faraday.new
      connection.headers['Api-Key'] = Config.api_key
      connection
    end

    def raw_workouts_for_user(id, token)
      connection.headers['Authorization'] = "Bearer #{token}"
      response = connection.get("https://oauth2-api.mapmyapi.com/v7.0/workout/?user=#{id}&access_token=#{token}")
      JSON.parse(response.body)
    end

    def records_for(user_id, token)
      raw_workouts_for_user(user_id, token)
    end
  end
end
