require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::Warnings::AssignmentAsCondition do
  it "should match against an assignment" do
    # TODO(kevinclark): 
    #   This should really include :dasgn, :cvasgn, and :op_asgn2,
    #   but I can't figure out how they show up in the AST.
    
    matches = {
      "a = 1" => s(:lasgn, :a, s(:lit, 1)),
      "a ||= 2" => s(:op_asgn_or,  s(:lvar, :a), s(:lasgn, :a, s(:lit, 2))),
      "a &&= 3" => s(:op_asgn_and, s(:lvar, :a), s(:lasgn, :a, s(:lit, 2))),
      "@a = 4" => s(:iasgn, :@a, s(:lit, 4)),
      "a[0] ||= 5" => s(:op_asgn1, s(:vcall, :a), s(:array, s(:lit, 0)), :"||", s(:lit, 1)),
      "$a = 6" => s(:gasgn, :$a, s(:lit, 1)),
      "a = 7 # in a block" => s(:dasgn_curr, :a, s(:lit, 1))
    }
        
    matches.each do |_, assignment|
      warning = Dust::Warnings::AssignmentAsCondition.new(assignment)
      warning.matches?.should be_true
    end
  end
  
  it "shouldn't match against nodes that aren't an assignment" do
    non_matches = {
      "a == 1" => s(:call, s(:vcall, :a), :==, s(:array, s(:lit, 1))),
      "a.nil?" => s(:call, s(:vcall, :a), :nil?),
      "a" => s(:vcall, :a),
      "a(b,c,d)" => s(:fcall, :a, s(:array, s(:vcall, :b), s(:vcall, :c), s(:vcall, :d)))
    }
    
    non_matches.each do |_, condition|
      warning = Dust::Warnings::AssignmentAsCondition.new(condition)
      warning.matches?.should be_false
    end
  end
end