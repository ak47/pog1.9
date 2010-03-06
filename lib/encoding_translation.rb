##
# = encoding_translation.rb
#
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
# 

##
# == EncodingTranslation Module
#
# This module is a set of encoding translations shortcut methods using the 
# String#pack and String#unpack methods.
#
module EncodingTranslation
  ##
  # Converts a binary string +str+ to hexidecimal
  #
  def bin_to_hex( str )
    str.unpack("H#{str.length*2}").at(0)
  end
  
  ##
  # Converts a hexidecimal string +str+ to binary
  #
  def hex_to_bin( str )
    [str].pack("H#{str.length}")
  end
  
  ##
  # Converts a binary string +str+ to base 64
  #
  def bin_to_b64( str )
    [str].pack('m').gsub(/\s+/, '')
  end
  
  ##
  # Converts a base64 string +str+ to binary
  #
  def b64_to_bin( str )
    str.unpack("m").at(0)
  end
end
