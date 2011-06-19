require 'spec/spec_helper'

describe ARSerialize do
  describe :serialize do
    it "does not change normal values" do
      ARSerialize.serialize('x').should == 'x'
      ARSerialize.serialize([1,2,[3,4]]).should == [1,2,[3,4]]
      ARSerialize.serialize({:x => {:y => 1}}).should == {:x => {:y => 1}}
    end

    it "serializes ar" do
      user = User.create!(:title => 'foo')
      serialized = "ActiveRecord:User:#{user.id}"
      ARSerialize.serialize(user).should == serialized
      ARSerialize.serialize([1,2,[3,user]]).should == [1,2,[3,serialized]]
      ARSerialize.serialize({:x => {:y => user}}).should == {:x => {:y => serialized}}
    end
  end

  describe :deserialize do
    it "does not change normal values" do
      ARSerialize.deserialize('x').should == 'x'
      ARSerialize.deserialize([1,2,[3,4]]).should == [1,2,[3,4]]
      ARSerialize.deserialize({:x => {:y => 1}}).should == {:x => {:y => 1}}
    end

    it "deserializes ar" do
      user = User.create!(:title => 'foo')
      serialized = "ActiveRecord:User:#{user.id}"
      ARSerialize.deserialize(serialized).should == user
      ARSerialize.deserialize([1,2,[3,serialized]]).should == [1,2,[3,user]]
      ARSerialize.deserialize([1,2,[serialized,3]]).should == [1,2,[user,3]]
      ARSerialize.deserialize({:x => {:y => serialized}}).should == {:x => {:y => user}}
    end

    it "deserializes with indifferent access" do
      result = ARSerialize.deserialize({:x => {:y => 1}}.with_indifferent_access)
      result['x']['y'].should == 1
      result = ARSerialize.deserialize({:x => {:y => 1}})
      result['x'].should == nil
    end
  end
end
