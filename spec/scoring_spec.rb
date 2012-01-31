require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Ciphersurfer' do
  describe 'Score' do
    it "should assign A to overall scores higher than 80" do
      Ciphersurfer::Score.evaluate(90).should == "A"
      Ciphersurfer::Score.evaluate(80).should == "A"
      Ciphersurfer::Score.evaluate(79).should_not == "A"
    end

    it "should assign B to scores up between 65 and 79" do
      Ciphersurfer::Score.evaluate(64).should_not == "B"
      Ciphersurfer::Score.evaluate(65).should == "B"
      Ciphersurfer::Score.evaluate(79).should == "B"
      Ciphersurfer::Score.evaluate(80).should_not == "B"
    end
    it "should assign C to scores up between 50 and 64" do
      Ciphersurfer::Score.evaluate(49).should_not == "C"
      Ciphersurfer::Score.evaluate(50).should == "C"
      Ciphersurfer::Score.evaluate(64).should == "C"
      Ciphersurfer::Score.evaluate(65).should_not == "C"
    end
    it "should assign D to scores up between 35 and 49" do
      Ciphersurfer::Score.evaluate(34).should_not == "D"
      Ciphersurfer::Score.evaluate(35).should == "D"
      Ciphersurfer::Score.evaluate(49).should == "D"
      Ciphersurfer::Score.evaluate(50).should_not == "D"
    end
    it "should assign E to scores up between 20 and 34" do
      Ciphersurfer::Score.evaluate(19).should_not == "E"
      Ciphersurfer::Score.evaluate(20).should == "E"
      Ciphersurfer::Score.evaluate(34).should == "E"
      Ciphersurfer::Score.evaluate(35).should_not == "E"
    end
    it "should assign F to overall scores lower than 20" do
      Ciphersurfer::Score.evaluate(19).should == "F"
      Ciphersurfer::Score.evaluate(0).should == "F"
      Ciphersurfer::Score.evaluate(-123).should == "F"
      Ciphersurfer::Score.evaluate(20).should_not == "F"
    end

    it "should give a 0.5 if both SSLv2 and SSLv3 are supported but no TLS" do
      Ciphersurfer::Score.evaluate_protocols([:SSLv2, :SSLv3]).should == 50
    end
    it "should give a 0.2 if only SSLv2 protocol is supported" do
      Ciphersurfer::Score.evaluate_protocols([:SSLv2]).should == 20
    end

    it "should give a 0.55 if SSLv2 and TLSv1 are supported but no SSLv3" do
      Ciphersurfer::Score.evaluate_protocols([:SSLv2, :TLSv1]).should == 55
    end

    it "should give a 0.55 if SSLv2, SSLv3 and TLSv1 are supported" do
      Ciphersurfer::Score.evaluate_protocols([:SSLv2, :SSLv3, :TLSv1]).should == 55
    end

    it "should give a 1 if only TLSv1.2 is supported" do
      Ciphersurfer::Score.evaluate_protocols([:TLSv12]).should == 100
    end

    it "should give a 0 if cipher has 0 length" do
      Ciphersurfer::Score.evaluate_ciphers([0]).should == 0
    end 

    it "should give a 0.2 if ciphers supported have length < 128" do 
      Ciphersurfer::Score.evaluate_ciphers([40, 56, 64]).should == 20
    end 

    it "should give a 0.8 if ciphers supported have length < 256" do 
      Ciphersurfer::Score.evaluate_ciphers([128, 168, 255]).should == 80
    end 

    it "should give a 1.0 if ciphers supported have length >= 256" do 
      Ciphersurfer::Score.evaluate_ciphers([256, 512, 2048]).should == 100
    end 

    it "should give 0.1 if no encryption or ciphers lenght < 128" do
      Ciphersurfer::Score.evaluate_ciphers([0, 40, 56, 64]).should == 10
    end

    it "should give a 0.5 if ciphers supported have length < 256 and < 128" do 
      Ciphersurfer::Score.evaluate_ciphers([40, 56, 128, 168, 255]).should == 50
    end 

    it "should give a 0.6 if ciphers supported have length >= 256 and < 128" do 
      Ciphersurfer::Score.evaluate_ciphers([40, 56, 1024, 2048]).should == 60
    end 

    it "should give a 0 if no key provided" do
      Ciphersurfer::Score.evaluate_key(0).should == 0
    end

    it "should give a 0.2 if key < 512" do
      Ciphersurfer::Score.evaluate_key(128).should == 20
      Ciphersurfer::Score.evaluate_key(256).should == 20
      Ciphersurfer::Score.evaluate_key(511).should == 20
      Ciphersurfer::Score.evaluate_key(512).should_not == 20
    end

    it "should give a 0.4 if 512 <= key < 1024" do
      Ciphersurfer::Score.evaluate_key(512).should == 40
      Ciphersurfer::Score.evaluate_key(1000).should == 40
      Ciphersurfer::Score.evaluate_key(1024).should_not == 40
    end

    it "should give a 0.8 if 1024 <= key < 2048" do
      Ciphersurfer::Score.evaluate_key(1024).should == 80
      Ciphersurfer::Score.evaluate_key(2043).should == 80
      Ciphersurfer::Score.evaluate_key(2048).should_not == 80
    end

    it "should give a 0.9 if 2048 <= key < 4096" do
      Ciphersurfer::Score.evaluate_key(2048).should == 90
      Ciphersurfer::Score.evaluate_key(4095).should == 90
      Ciphersurfer::Score.evaluate_key(4096).should_not == 90
    end

    it "should give a 1.0 if key >= 4096" do
      Ciphersurfer::Score.evaluate_key(4096).should == 100
    end


    it "should evalute the overall score" do
      Ciphersurfer::Score.score(100, 100, 100).should == 100
      Ciphersurfer::Score.score(0, 100, 100).should == 70
      Ciphersurfer::Score.score(100, 0, 100).should == 70
      Ciphersurfer::Score.score(100, 100, 0).should == 60
      Ciphersurfer::Score.score(0, 0, 100).should == 40
    end
  end
end
