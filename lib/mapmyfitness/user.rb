module MapMyFitness
  class User
    def self.data_attributes
      ["username", "first_name", "last_name", "display_name", "last_initial", 
       "weight", "communication", "display_measurement_system", "time_zone", 
       "birthdate", "height", "email", "sharing", "last_login", "location", 
       "gender", "_links", "id", "date_joined"]
    end

    attr_reader *data_attributes
    attr_reader :data, :token_expires, :token_expires_at, :token_refresh, :token, :provider
    
    alias_method :uid, :id

    def initialize(auth_info)
      @data = auth_info
      parse_attributes
    end

    def parse_info_attributes(info_data)
      User.data_attributes.each do |attribute|
        instance_variable_set("@#{attribute}", data["info"][attribute])
      end
    end

    def parse_token_attributes(token_data)
      @token_expires = data["credentials"]["expires"]
      @token_expires_at = data["credentials"]["expires_at"]
      @token_refresh = data["credentials"]["refresh_token"]
      @token = data["credentials"]["token"]
    end

    def parse_attributes
      parse_info_attributes(data["info"]) if data["info"]
      parse_token_attributes(data["credentials"]) if data["credentials"]
      @provider = data["provider"]
    end
  end
end
