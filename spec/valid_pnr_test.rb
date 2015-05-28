require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require_relative '../lib/pnr.rb'

describe 'valid_pnr?' do

  it 'takes a personnummer as a string as a named  argument' do
    proc { valid_pnr? }.must_raise ArgumentError
    proc { valid_pnr?('A pnr without a named argument') }.must_raise ArgumentError
  end

  it 'raises ArgumentError with correct message if the supplied pnr is empty' do
    proc { valid_pnr?(pnr: '') }.must_raise ArgumentError, 'Pnr must not be empty'
  end

  it 'correctly validates pnrs following the YYMMDD-XXXX pattern' do
    valid_pnr?(pnr: '811218-9876').must_equal true
    valid_pnr?(pnr: '781206-4611').must_equal true
    valid_pnr?(pnr: '811218-9866').must_equal false
    valid_pnr?(pnr: '781206-4613').must_equal false
  end

end