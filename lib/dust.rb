$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require 'dust/warnings/simple_warning'
require 'dust/warnings/unprotected_block'
require 'dust/warnings'
require 'dust/warnings/useless_branch'

require 'dust/duster'
require 'dust/local_variable_duster'
require 'dust/block_duster'
require 'dust/branch_duster'

require 'dust/sexp_extension'
class Sexp
  include Dust::SexpExtension
end
