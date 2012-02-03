require 'openssl'

module Ciphersurfer
  class CsrValidator

    def self.cn(csr_file)
      csr = self.read_csr(csr_file)
      if csr.nil?
        return ""
      end
      csr.subject.to_a.each do |ii|
        if ii[0]=='CN'
          return ii[1]
        end
      end
      return ""
    end

    def self.valid?(csr_file)
      csr = self.read_csr(csr_file)
      csr.verify csr.public_key
    end

    def self.dump(csr_file)
      csr = self.read_csr(csr_file)
      if csr.nil?
        return ""
      end

      csr.subject.to_a.each do |ii|
        printf "%5s : %s\n", ii[0], ii[1]
      end

    end

    private

    def self.read_csr(csr_file)
      return nil unless File.exists?(csr_file)
      csr = OpenSSL::X509::Request.new File.read csr_file
      return csr
    end

  end
end
