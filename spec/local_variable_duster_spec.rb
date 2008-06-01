require File.dirname(__FILE__) + '/spec_helper'

class LocalVariableBadness
  def unused_lasgn
    bar = 4
    1 + 2
  end
  
  def used_lvar
    bar = 4
    bar + 4
  end
  
  def unused_lvar
    bar = 4
    bar
    1 + 2
  end
end

describe Dust::LocalVariableDuster do
  it "should increment uses for an lasgn node" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :unused_lasgn)
    duster.dust!
    duster.uses(:bar).should == 1
  end
  
  it "should increment uses for an lvar node" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :used_lvar)
    duster.dust!
    duster.uses(:bar).should == 2 # lvar + lasgn
  end
  
  it "should create warnings for an an assigned but unused local variable" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :unused_lasgn)
    duster.dust!
    duster.warnings.should == [Dust::UnusedVariableWarning.new(:bar)]
  end
  
  it "should not create warnings for used local variables" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :used_lvar)
    duster.dust!
    duster.warnings.should == []
  end
end