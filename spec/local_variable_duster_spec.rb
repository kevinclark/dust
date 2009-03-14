require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/local_variable_badness'

include Fixtures

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
    duster.warnings.should == [Dust::Warnings::UnusedVariable.new(:bar)]
  end
  
  it "should not create warnings for used local variables" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :used_lvar)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should not create warnings for local variables with calls" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :lvar_with_call)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should warn when a block variable shadows a local variable" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :lvar_shadowed)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::ShadowedVariable.new(:x)]
  end
  
  it "should warn when a block variable (among many) shadows a local variable" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :lvar_shadowed_many_block_vars)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::ShadowedVariable.new]
  end
  
  it "should not warn when a block variable does not shadow a local variable" do
    duster = Dust::LocalVariableDuster.new(LocalVariableBadness, :lvar_not_shadowed)
    duster.dust!
    duster.warnings.should == []
  end
end