# =============================================
# RCDK - The Chemistry Development Kit for Ruby
# =============================================
#
# Project Info: http://rubyforge.org/projects/rcdk
# Blog: http://depth-first.com
#
# Copyright (C) 2006 Richard L. Apodaca
# Author    (C) 2009 Sebastian Klemm
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License version 2.1 as published by the Free Software
# Foundation.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor
# Boston, MA 02111-1301, USA.

require 'rcdk'
require 'rcdk/util'

jrequire 'java.io.StringReader'
jrequire 'org.openscience.cdk.io.iterator.IteratingMDLReader'
jrequire 'org.openscience.cdk.DefaultChemObjectBuilder'

# The Ruby Chemistry Development Kit.
module RCDK

  # Classes and methods for reading and writing chemical file formats
  module IO

    # Minimal wrapper for the IteratingMDLReader
    #
    # Usage:
    # <pre>sdf_reader = RCDK::SdfReader.new
    # sdf_reader.read_data(filedata)
    # while sdf_reader.has_next
    #   mol = sdf_reader.next
    # end</pre>
    class SdfReader
      include Org::Openscience::Cdk

      # load the data in the reader.
      # filedata expects a subclass of Ruby IO.
      def initialize(filedata)
        super()
        @file = filedata
      end

      # load the data in the reader.
      # filedata expects a subclass of Ruby IO.
      def read_data(filedata)
        if @file
          @file.close
        end
        @file = filedata
      end

      # Returns true if another molfile can be read.
      def has_next?
        has_next = false
        pos = @file.pos
        entry = @file.gets("$$$$\n")
        if entry && entry.match(/M  END/)
          has_next = true
        end
        @file.pos = pos
        has_next
      end

      # Returns the next molfile entry.
      def next
        @file.gets("$$$$\n")
      end

      # Closes the Reader's resources.
      def close
        @file.close
      end

    end

  end

end
