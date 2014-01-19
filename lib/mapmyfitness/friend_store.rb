module MapMyFitness
  class FriendStore
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

    def raw_friends_for_user(id)
      response = connection.get("https://oauth2-api.mapmyapi.com/v7.0/user/?friends_with=#{id}&access_token=#{token}")
      JSON.parse(response.body)["_embedded"]["user"]
    end

    def friends_for(user_id)
      friends = raw_friends_for_user(user_id).collect do |data|
        friend = Friend.new
        friend.id = data['id']
        friend.first_name = data['first_name']
        friend.last_name = data['last_name']
        friend
      end

      remove_duplicates_from(friends)
    end

    def remove_duplicates_from(sessions)
      sessions.uniq{|session| session.id}
    end
  end
end
