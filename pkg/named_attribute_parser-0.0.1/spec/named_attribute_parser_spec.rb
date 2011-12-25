require File.dirname(__FILE__) + '/spec_helper.rb'

describe NamedAttributeParser do
  
  before :all do
    @obj = Object.new
    @obj.extend NamedAttributeParser

    @obj.instance_eval do
      def def_name; "TARO" end
      def def_age; 0 end
      def def_address; "TOKYO" end

      def get_parsed(*args)
        name, age, address = 
          named_attributes(args, :name, age: def_age, address: def_address)
        
        [name, age, address]
      end

      def get_parsed_all_default(*args)
        name, age, address = 
          named_attributes(args, name: def_name, age: def_age, address: def_address)
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
    address.should == @obj.def_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed(name: "shin")
    name.should == "shin"
    age.should == @obj.def_age
    address.should == @obj.def_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed_all_default
    name.should == @obj.def_name
    age.should == @obj.def_age
    address.should == @obj.def_address
  end

  it "should raise if named attribute not given than is not given default" do
    lambda{ @obj.get_parsed }.should raise_error ArgumentError
  end
  
end

describe "NamedAttributeParser with block" do
  
  before :all do
    @obj = Object.new
    @obj.extend NamedAttributeParser
    
    @obj.instance_eval do
      def def_name; "TARO" end
      def def_age; 0 end
      def def_address; "TOKYO" end

      def get_parsed(*args)
        named_attributes(args, :name, age: def_age, address: def_address) do
          | name, age, address |
          [name, age, address]
        end
      end

      def get_parsed_all_default(*args)
        named_attributes(args, name: def_name, age: def_age, address: def_address) do
          | name, age, address |
          [name, age, address]
        end
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
    address.should == @obj.def_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed(name: "shin")
    name.should == "shin"
    age.should == @obj.def_age
    address.should == @obj.def_address
  end

  it "parse named attibutes using 2 default value" do
    name, age, address = @obj.get_parsed_all_default
    name.should == @obj.def_name
    age.should == @obj.def_age
    address.should == @obj.def_address
  end

  it "should raise if named attribute not given than is not given default" do
    lambda{ @obj.get_parsed }.should raise_error ArgumentError
  end
  
end
