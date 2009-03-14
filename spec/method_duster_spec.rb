require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/method_badness'

include Fixtures

describe Dust::MethodDuster do
  it "should create a warning for an empty method" do
    duster = Dust::MethodDuster.new(MethodBadness, :empty_method)
    duster.dust!
    duster.warnings.include?(Dust::Warnings::EmptyMethod.new(:empty_method)).should be_true
  end
  
  it "should not create a empty method warning for a non empty method" do
    duster = Dust::MethodDuster.new(MethodBadness, :non_empty_method)
    duster.dust!
    duster.warnings.any? {|w| w.is_a? Dust::Warnings::EmptyMethod }.should be_false
  end
end
