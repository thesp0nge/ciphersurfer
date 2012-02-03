require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Given a CSR file ciphersurfer " do

  it "should be able to extract the CN" do
    cn_2=Ciphersurfer::CsrValidator.cn('./spec/data/nightwish.csr')
    cn_2.should_not be_nil
    cn_2.should_not be_empty
    cn_2.should == "nightwish"
  end

  it "should be able to verify a valid csr" do
    v2=Ciphersurfer::CsrValidator.valid?('./spec/data/nightwish.csr')

    v2.should be_true
  end

end
