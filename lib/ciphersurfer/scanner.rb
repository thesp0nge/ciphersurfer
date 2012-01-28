require 'net/https'
require 'openssl'

module Ciphersurfer
  class Scanner
    
    attr_reader :ok_ciphers

    def initialize(options={})
      @host=options[:host]
      @port=options[:port] ||= 443
      @proto=options[:proto]
      @ok_ciphers=[]
    end

    def self.alive?(host, port)
      request = Net::HTTP.new(host, port)
      request.use_ssl = true
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
      begin
        response = request.get("/")
        return true
      rescue Errno::ECONNREFUSED => e
        return false
      rescue OpenSSL::SSL::SSLError => e
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
          @ok_ciphers << {:bits=>bits, :name=>cipher_name}
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
