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

  end
end
