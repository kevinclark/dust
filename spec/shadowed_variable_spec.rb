require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/local_variable_badness'

include Fixtures

describe Dust::Warnings::ShadowedVariable do

  it "should match an lasgn" do
    warning = Dust::Warnings::ShadowedVariable.new(s(:lasgn, :x, nil))
    warning.matches?.should be_true
  end
  
  it "should not match when there are no assignments" do
    warning = Dust::Warnings::ShadowedVariable.new(nil)
    warning.matches?.should_not be_true
  end
  
  it "should not match a block variable assignment" do
    warning = Dust::Warnings::ShadowedVariable.new(s(:dasgn_curr, :y))
    warning.matches?.should_not be_true
  end
  
  it "should store the name of a shadowed variable" do
    warning = Dust::Warnings::ShadowedVariable.new(s(:lasgn, :x, nil))
    warning.matches?
    warning.vars.should == Set.new([:x])
  end
  
  it "should match and store names in multiple assignment" do
    exp = s(:masgn, s(:array, s(:dasgn_curr, :p), s(:dasgn_curr, :d), 
                               s(:dasgn_curr, :q), s(:lasgn, :x, nil)), nil, nil)
    
    warning = Dust::Warnings::ShadowedVariable.new(exp)
    warning.matches?.should be_true
    warning.vars.should == Set.new([:x])
  end
  
  it "should handle splat args in multiple assignment" do
    exp =  s(:masgn, s(:array, s(:dasgn_curr, :x), s(:dasgn_curr, :y)), s(:lasgn, :a), nil)
    warning = Dust::Warnings::ShadowedVariable.new(exp)
    warning.matches?.should be_true
    warning.vars.should == Set.new([:a])
  end
  
  it "should handle one splat arg" do
    exp = s(:masgn, nil, s(:lasgn, :a), nil)
    warning = Dust::Warnings::ShadowedVariable.new(exp)
    warning.matches?.should be_true
    warning.vars.should == Set.new([:a])
  end
  
  it "should store the name of all shadowed variables" do
    exp = s(:masgn, s(:array, s(:dasgn_curr, :p), s(:dasgn_curr, :d), 
                               s(:lasgn, :q, nil), s(:lasgn, :x, nil)), nil, nil)
    warning = Dust::Warnings::ShadowedVariable.new(exp)
    warning.matches?
    warning.vars.should == Set.new([:q, :x])
  end
  
end