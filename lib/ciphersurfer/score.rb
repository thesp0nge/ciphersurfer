module Ciphersurfer

    class Score

      # Gives the final evaluation given the final score
      # @param the score obtained in the previous steps
      # @result an evaluation between A, the highest one and F, the lowest
      def self.evaluate(score)
        return "F" unless score > 0

        case score

        when 0...20
          ret = "F"
        when 20...35
          ret = "E"
        when 35...50
          ret = "D"
        when 50...65
          ret = "C"
        when 65...80
          ret = "B"
        else
          ret = "A"
        end

        return ret
      end


      def self.evaluate_protocols(protocols)
        best  = -1
        worst = -1

        if (protocols.include?(:SSLv2))
          best = 20
          worst = 20
        end
        if (protocols.include?(:SSLv3))
          best = 80
          (worst = 80) unless worst != -1
        end
        if (protocols.include?(:TLSv1))
          best = 90
          (worst = 90) unless worst != -1
        end
        if (protocols.include?(:TLSv11))
          best = 95
          (worst = 95) unless worst != -1
        end
        if (protocols.include?(:TLSv12))
          best = 100
          (worst = 100) unless worst != -1
        end

        (best + worst) / 2

      end

      # @param an Array of supported ciphers bit 
      def self.evaluate_ciphers(ciphers)
        best  = -1
        worst = 999999999999999999999999999999999999

        #[0, 24, 1024]
        ciphers.each do |c|
          if (c == 0)
            worst = 0
            best = 0 unless best != -1
          end
          if (c < 128) && (c!=0)
            worst = 20 unless worst < 20
            best = 20 unless best > 20
          end

          if (c < 256) && (c>=128)
            worst = 80 unless worst < 80
            best = 80 unless best > 80
          end

          if (c >= 256)
            worst = 100 unless worst < 100
            best = 100
          end

        end
        (best + worst) / 2
      end


      # FIXME: How can I test Weak key (Debian OpenSSL flaw)?
      def self.evaluate_key(key_length)
        case (key_length)
        when 0
          return 0
        when 1...512
          return 20
        when 512...1024
          return 40
        when 1024...2048
          return 80
        when 2048...4096
          return 90
        else
          return 100
        end
      end

      def self.score(proto, key, ciphers)
        return ((0.3*proto) + (0.3*key) + (0.4*ciphers))
      end
    end
end
