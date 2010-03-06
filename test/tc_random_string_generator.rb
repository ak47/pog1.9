# Copyright (c) 2007 Operis Systems, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require 'test/unit'
require File.join( File.dirname(__FILE__), '..', 'lib', 'pog.rb' )

class TC_PasswordTests < Test::Unit::TestCase
  def test_shuffle_string
    str = "qwertyuiopQWERTYUIOP"
    str_freq = frequencies(str)
    str_2 = RandomStringGenerator.shuffle_string str
    assert_not_equal str_2, str
    assert_equal frequencies(str_2), frequencies(str)
  end
  
  def frequencies( str )
    r = {}
    for i in 0...str.length do
      c = str[i]
      if r[c]
        r[c] += 1
      else
        r[c] = 1
      end
    end
  end
  
  def test_rand_char
    rsg = RandomStringGenerator.new
    rsg.set_characters_array
    assert_not_nil rsg.rand_char
  end
  
  def test_rand_char_with_delete
    rsg = RandomStringGenerator.new(2, :special => 'abd')
    rsg.set_characters_array
    3.times do
      assert_not_nil rsg.rand_char( true )
    end
    
    rsg = RandomStringGenerator.new(2, :special => 'abd')
    rsg.set_characters_array
    3.times do
      assert_nothing_raised { rsg.rand_char( true ) }
    end
    assert_raise RuntimeError do 
      rsg.rand_char( true )
    end 
  end
  
  def test_noduplicates_safety
    rsg = RandomStringGenerator.new(3, :special => 'ab', :no_duplicates => true)
    assert_raise RuntimeError do
      rsg.generate
    end
  end
  
  def test_generation
    rsg = RandomStringGenerator.new
    assert_not_nil rsg.generate
    
    rsg.set_option :single_quotes => true, :double_quotes => true, :backtick => true
    
    assert_not_nil rsg.generate
    assert_equal rsg.generate.length, 8
    
    rsg = RandomStringGenerator.new(9, :all => true)

    assert_not_nil rsg.generate
    assert_equal rsg.generate.length, 9

    rsg = RandomStringGenerator.new(10, :all_except_quotes => true)

    assert_not_nil rsg.generate
    assert_equal rsg.generate.length, 10

    rsg.set_option :special => 5
    assert_raise(ArgumentError) { rsg.set_characters_array }
  end
  
  def test_bad_range
    rsg = RandomStringGenerator.new
    assert_raise(ArgumentError) { rsg.range('foo') }
  end
  
  def test_wep_generation
    ascii64_wep = RandomStringGenerator.generate_wep(64,:ascii)
    ascii128_wep = RandomStringGenerator.generate_wep(128,:ascii)
    hex152_wep  = RandomStringGenerator.generate_wep(152)
    hex256_wep  = RandomStringGenerator.generate_wep(256)
    
    assert_not_nil ascii64_wep
    assert_not_nil ascii128_wep
    assert_not_nil hex152_wep
    assert_not_nil hex256_wep
    
    assert_equal ascii64_wep.length, 5
    assert_equal ascii128_wep.length, 13
    assert_equal hex152_wep.length, 32
    assert_equal hex256_wep.length, 58
    
    assert_raise(RuntimeError) { RandomStringGenerator.generate_wep(152, :not_a_type) }
  end
  
  def test_attrs
    rsg = RandomStringGenerator.new
    
    assert_equal rsg.length, 8
    rsg.length = 7
    assert_equal rsg.length, 7

    assert_equal rsg.options, {:lower_alphas => true,
                               :upper_alphas => true,
                               :numerals     => true,
                               :no_duplicates=> false }
    rsg.set_option :symbols => false, :no_duplicates=> true
    assert_equal rsg.options, {:lower_alphas => true,
                               :upper_alphas => true,
                               :numerals     => true,
                               :no_duplicates=> true,
                               :symbols => false }
  end
end