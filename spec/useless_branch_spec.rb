require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::Warnings::UselessBranch do
  it "should match against branches returning only true and false" do
    warning = Dust::Warnings::UselessBranch.new(s(:cond), s(:true), s(:false))
    warning.matches?.should be_true
  end
end