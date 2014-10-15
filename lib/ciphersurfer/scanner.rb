require 'net/https'
require 'openssl'
require 'httpclient'


# if ruby == 1.8 we must extend Net::HTTP this way
maj=RUBY_VERSION.split('.')[0].to_i
min=RUBY_VERSION.split('.')[1].to_i

if (maj==1 and min==8)
  module Net
    class HTTP
      def set_context=(value)
        @ssl_context = OpenSSL::SSL::SSLContext.new
        @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
      end
      ssl_context_accessor :ciphers
    end
  end
end

module Ciphersurfer
  class Scanner
    
    attr_reader :ok_ciphers, :ok_bits
    attr_reader :peer_cert



    def initialize(options={})
      @host=options[:host]
      @port=options[:port] ||= 443
      @proto=options[:proto]
      @ok_ciphers=[]
      @ok_bits=[]
      @alive=false
    end

    def self.cert(host, port)
      if (! @alive)
        self.alive?(host.port)
      end

      @peer_cert

      # client=HTTPClient.new
      # response=client.get("https://#{host}:#{port}")
      # peer_cert = response.peer_cert
    end

    def self.alive?(host, port)
      client=HTTPClient.new
      begin
        @alive=true
        response=client.get("https://#{host}:#{port}")
        @peer_cert = response.peer_cert
        return true
      rescue Errno::ECONNREFUSED => e
        puts "alive?(): connection refused".color(:red)
        return false
      rescue OpenSSL::SSL::SSLError => e
        puts "alive?(): [WARNING] - #{e.message}".color(:yellow)
        return true
      rescue => e
        puts "alive?(): #{e.message}".color(:red)
        return false
      end
      
    end

    # def self.alive?(host, port)
    #   request = Net::HTTP.new(host, port)
    #   request.use_ssl = true
    #   request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #   begin
    #     response = request.get("/")
    #     return true
    #   rescue Errno::ECONNREFUSED => e
    #     return false
    #   rescue OpenSSL::SSL::SSLError => e
    #     return false
    #   rescue 
    #     return false
    #   end
    # end

    def self.poodle?(host, port)
      # context=OpenSSL::SSL::SSLContext.new(:SSLv3)
      request = Net::HTTP.new(host, port)
      request.use_ssl = true
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request.ssl_version = :SSLv3
      begin
        response = request.get("/")
        return true
      rescue OpenSSL::SSL::SSLError => e
        return false
      rescue
        return false
      end


    end

    def go
      context=OpenSSL::SSL::SSLContext.new(@proto)
      cipher_set = context.ciphers
      cipher_set.each do |cipher_name, cipher_version, bits, algorithm_bits|

        request = Net::HTTP.new(@host, @port)
        request.use_ssl = true
        request.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request.ciphers= cipher_name
        begin
          response = request.get("/")
          @ok_bits << bits
          @ok_ciphers << cipher_name
        rescue OpenSSL::SSL::SSLError => e
          # Quietly discard SSLErrors, really I don't care if the cipher has
          # not been accepted
        rescue 
          # Quietly discard all other errors... you must perform all error
          # chekcs in the calling program
        end
      end
    end
  end
end
