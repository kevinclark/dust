$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require 'dust/warnings/simple_warning'
require 'dust/warnings/unused_variable'
require 'dust/warnings/unprotected_block'
require 'dust/warnings/useless_branch'
require 'dust/warnings/identical_branch'
require 'dust/warnings/rescue_value'
require 'dust/warnings/rescue_everything'
require 'dust/warnings/unused_argument'
require 'dust/warnings/assignment_as_condition'

require 'dust/duster'
require 'dust/local_variable_counter'
require 'dust/local_variable_duster'
require 'dust/argument_duster'
require 'dust/block_duster'
require 'dust/branch_duster'
require 'dust/rescue_duster'


require 'dust/sexp_extension'
class Sexp
  include Dust::SexpExtension
end
