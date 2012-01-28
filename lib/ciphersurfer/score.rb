module Ciphersurfer
    PROTOCOL_SUPPORT_RATIO  = 0.3
    KEY_EXCHANGE_RATIO      = 0.3
    CIPHER_STRENGTH         = 0.4

    class Score
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

    end
end
