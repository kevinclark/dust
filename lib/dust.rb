$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require 'dust/warnings'
require 'dust/duster'
require 'dust/local_variable_duster'
require 'dust/null_statement_duster'
require 'dust/block_duster'