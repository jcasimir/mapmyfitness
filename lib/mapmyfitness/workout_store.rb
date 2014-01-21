module MapMyFitness
  class WorkoutStore
    attr_reader :token, :connection

    def initialize(token)
      @token = token
      @connection = build_connection
    end

    def build_connection
      conn = Faraday.new
      conn.headers['Api-Key'] = Config.api_key
      conn.headers['Authorization'] = "Bearer #{token}"
      conn
    end

    def raw_workouts_by_user(id)
      response = connection.get("https://oauth2-api.mapmyapi.com/v7.0/workout/?user=#{id}&access_token=#{token}")
      JSON.parse(response.body)["_embedded"]["workouts"]
    end

    def workouts_by(user_id)
      workouts = raw_workouts_by_user(user_id).collect do |data|
        workout = Workout.new
        workout.id = data['_links']['self'].first['id']
        workout.name = data['name']
        workout.started_at = data['start_datetime']
        workout.duration = data['aggregates']['active_time_total']
        workout.distance = data['aggregates']['distance_total']
        workout
      end

      remove_duplicates_from(workouts)
    end

    def raw_workouts_by_user_in_last_days(id, number_of_days)
      response = connection.get("https://oauth2-api.mapmyapi.com/v7.0/workout/?started_after=#{how_long_ago(number_of_days)}&user=#{id}&access_token=#{token}")
      JSON.parse(response.body)["_embedded"]["workouts"]
    end

    def workouts_by_user_in_last_days(user_id, number_of_days)
      workouts = raw_workouts_by_user_in_last_days(user_id, number_of_days).collect do |data|
        workout = Workout.new
        workout.id = data['_links']['self'].first['id']
        workout.name = data['name']
        workout.started_at = data['start_datetime']
        workout.duration = data['aggregates']['active_time_total']
        workout.distance = data['aggregates']['distance_total']
        workout
      end

      remove_duplicates_from(workouts)
    end

    # workouts_by_user_in_last_days(current_user.uid, 14)

    def remove_duplicates_from(sessions)
      sessions.uniq{|session| session.id}
    end

    def how_long_ago(number_of_days)
      date_time_x_days_ago = DateTime.now - number_of_days
      result = date_time_x_days_ago.to_time.iso8601.gsub(":", "%3A")
      result[-8] = "%2B"
      result
    end

  end
end
