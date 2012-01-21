require 'socket'
require 'net/https'
require 'openssl'

module Net
  class HTTP
    def set_context=(value)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
    end
    
    def ciphers
      return nil unless @ssl_context
      @ssl_context.ciphers
    end

    def ciphers=(val)
      @ssl_context ||= OpenSSL::SSL::SSLContext.new
      @ssl_context.ciphers = val
    end
  end
end
