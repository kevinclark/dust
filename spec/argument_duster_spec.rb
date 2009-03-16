require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/local_variable_badness'
require 'fixtures/block_badness'

include Fixtures

describe Dust::ArgumentDuster do
  it "should create warnings for an unreferenced argument" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :unused_arg)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnusedArgument.new(:arg)]
  end
  
  it "should not create warnings for a referenced argument" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :used_arg)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should not create warnings for splat args" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :used_splat_arg)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should not create warnings when calling super with no explicit arguments" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :super_with_implicit_args)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should create warnings when calling super with explicit arguments but without referencing the passed arguments" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :super_with_explicit_args)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnusedArgument.new(:arg)]
  end
  
  it "should not create warnings for args used with splats" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :args_used_with_splats)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should ignore [:block] arguments in args" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :default_args)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should handle &block in args when called" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :block_arg_called)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should handle &block in args when curried" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :block_arg_curried)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should warn when &block in args is unused" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :block_arg_unused)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnusedArgument.new(:block)]
  end
  
  it "shouldn't warn on non-argument variables" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :rescue_to_variable)
    duster.dust!
    duster.warnings.should == []
  end
end
