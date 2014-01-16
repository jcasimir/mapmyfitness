module MapMyFitness
  class Config
    def self.api_key
      ENV['MMF_API_KEY']
    end
  end
end