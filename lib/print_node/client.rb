module PrintNode
  class Client

    attr_accessor :username,
      :password,
      :address

    def self.connection
      @connection ||= new.connection
    end

    def initialize(options={})
      @username      = options[:username]      || ENV['PRINTUSERNAME']
      @password      = options[:password]      || ENV['PASSWORD']
      @address       = 'https://api.printnode.com/'
    end

    def connection
      Faraday.new(url: @address) do |conn|
        conn.basic_auth @username, @password
        conn.request  :json
        conn.use      FaradayMiddleware::RaiseHttpException
        conn.adapter  Faraday.default_adapter
      end
    end

  end
end