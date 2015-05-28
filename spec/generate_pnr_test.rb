require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require_relative '../lib/pnr.rb'

describe 'generate_pnr' do

  it 'takes a pnr, birth_county, and sex named arguments' do
    proc { generate_pnr }.must_raise ArgumentError
    proc { generate_pnr('not', 'named', 'arguments') }.must_raise ArgumentError
  end

  it 'raises ArgumentError with correct message if the supplied birth_year is negative or larger than 99' do
    proc { generate_pnr(birth_year: -12) }.must_raise ArgumentError, 'birth_year must not be negative'
    proc { generate_pnr(birth_year: 100) }.must_raise ArgumentError, 'birth_year must not be larger than 99'
  end

  it 'raises ArgumentError with correct message if the supplied birth_county is empty' do
    proc { generate_pnr(birth_year: 78, birth_county: '', sex: 'male') }.must_raise ArgumentError, 'birth_county must not be empty'
  end

  it 'raises ArgumentError with correct message if the supplied birth_county is not valid' do
    proc { generate_pnr(birth_year: 78, birth_county: 'Grillkorv') }.must_raise ArgumentError, 'birth_county Grillkorv does not exist'
    proc { generate_pnr(birth_year: 78, birth_county: 'Stollholm') }.must_raise ArgumentError, 'birth_county Stollholm does not exist'
  end

  it 'raises ArgumentError with correct message if the supplied sex is not "male" or "female"' do
    proc { generate_pnr(birth_year: 78, birth_county: 'Halland', sex: 'cat') }.must_raise ArgumentError, 'sex must be "male" or "female"'
    proc { generate_pnr(birth_year: 78, birth_county: 'Halland', sex: '' ) }.must_raise ArgumentError, 'sex must be "male" or "female"'
  end

  it 'returns a string formatted as a pnr ("YYMMDD-XXXX")' do
    generate_pnr(birth_year: 32, birth_county: 'Stockholm',   sex: 'female').must_be_instance_of String
    generate_pnr(birth_year: 78, birth_county: 'Halland',     sex: 'male').must_match    /\A\d{6}-\d{4}\z/
    generate_pnr(birth_year: 12, birth_county: 'Värmland',    sex: 'female').must_match  /\A\d{6}-\d{4}\z/
    generate_pnr(birth_year: 68, birth_county: 'Norrbotten',  sex: 'male').must_match    /\A\d{6}-\d{4}\z/
    generate_pnr(birth_year: 86, birth_county: 'Gotland',     sex: 'male').must_match    /\A\d{6}-\d{4}\z/
  end

  it 'generates correct "birth_year-digits" ' do
    generate_pnr(birth_year: 78, birth_county: 'Halland',     sex: 'male')[0..1].must_match /78/
    generate_pnr(birth_year: 68, birth_county: 'Norrbotten',  sex: 'male')[0..1].must_match /28/
    generate_pnr(birth_year: 86, birth_county: 'Gotland',     sex: 'male')[0..1].must_match /86/
  end

  it 'generates correct "sex-digits" for males' do
    generate_pnr(birth_year: 78, birth_county: 'Halland',     sex: 'male')[9].must_match /(1|3|5|7|9)/
    generate_pnr(birth_year: 68, birth_county: 'Norrbotten',  sex: 'male')[9].must_match /(1|3|5|7|9)/
    generate_pnr(birth_year: 86, birth_county: 'Gotland',     sex: 'male')[9].must_match /(1|3|5|7|9)/
  end

  it 'generates correct "sex-digits" for females' do
    generate_pnr(birth_year: 32, birth_county: 'Stockholm', sex: 'female')[9].must_match /(0|2|4|6|8)/
    generate_pnr(birth_year: 12, birth_county: 'Värmland',  sex: 'female')[9].must_match /(0|2|4|6|8)/
    generate_pnr(birth_year: 86, birth_county: 'Gotland',   sex: 'female')[9].must_match /(0|2|4|6|8)/
  end

  it 'generates correct "county digits"' do
    generate_pnr(birth_year: 32, birth_county: 'Västra Götaland', sex: 'female')[7..8].must_match /(48|49|50|51|52|53|54)/
    generate_pnr(birth_year: 12, birth_county: 'Värmland',        sex: 'female')[7..8].must_match /(62|63|64)/
    generate_pnr(birth_year: 86, birth_county: 'Gotland',         sex: 'female')[7..8].to_i.must_equal 32
  end

  it 'generates correct valid pnrs' do
    valid_pnr?(pnr: generate_pnr(birth_year: 78, birth_county: 'Halland',     sex: 'male')).must_equal    true
    valid_pnr?(pnr: generate_pnr(birth_year: 12, birth_county: 'Värmland',    sex: 'female')).must_equal  true
    valid_pnr?(pnr: generate_pnr(birth_year: 68, birth_county: 'Norrbotten',  sex: 'male')).must_equal    true
    valid_pnr?(pnr: generate_pnr(birth_year: 86, birth_county: 'Gotland',     sex: 'male')).must_equal    true
  end

end