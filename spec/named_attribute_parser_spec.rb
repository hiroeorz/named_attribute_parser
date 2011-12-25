require File.dirname(__FILE__) + '/spec_helper.rb'

describe NamedAttributeParser do
  
  before :all do
    @obj = Object.new
    @obj.extend NamedAttributeParser

    @obj.instance_eval do
      def default_name; "TARO" end
      def default_age; 0 end
      def default_address; "TOKYO" end

      def get_parsed(*args)
        name, age, address = 
          named_attributes(args, :name , 
                           age: default_age, address: default_address)
        
        [name, age, address]
      end

      def get_parsed_all_default(*args)
        name, age, address = 
          named_attributes(args, 
                           name: default_name , 
                           age: default_age, 
                           address: default_address)
        
        [name, age, address]
      end
    end
  end

  it "parse hash attibutes" do
    name, age, address = 
      @obj.get_parsed(:name => "shin", :age => 36, :address => "SHIMANE")

    name.should == "shin"
    age.should == 36
    address.should == "SHIMANE"
  end

  it "parse named attibutes" do
    name, age, address = 
      @obj.get_parsed(name: "shin", age: 36, address: "SHIMANE")

    name.should == "shin"
    age.should == 36
    address.should == "SHIMANE"
  end

  it "parse named attibutes using 1 default value" do
    name, age, address = @obj.get_parsed(name: "shin", age: 36)
    name.should == "shin"
    age.should == 36
    address.should == @obj.default_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed(name: "shin")
    name.should == "shin"
    age.should == @obj.default_age
    address.should == @obj.default_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed_all_default
    name.should == @obj.default_name
    age.should == @obj.default_age
    address.should == @obj.default_address
  end

  it "should raise if named attribute not given than is not given default" do
    lambda{ @obj.get_parsed }.should raise_error ArgumentError
  end
  
end
