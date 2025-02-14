# frozen_string_literal: true

if defined? RedisClient
  raise "RedisClient version changed" unless RedisClient::VERSION == "0.21.1"

  class RedisClient
    class Config
      prepend(
        Module.new do
          def initialize(url: nil, **kwargs)
            return super unless url

            uri = URI.parse(url)
            if uri.scheme == "unix"
              super(**kwargs, url: nil)
              @path = uri.path
            else
              super
            end
          end
        end
      )
    end
  end
end
