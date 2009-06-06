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
      # filedata.read should return the filecontent as string
      def read_data(filedata)
        begin
          @reader = Io::Iterator::IteratingMDLReader.new(
            Java::Io::StringReader.new(filedata.read),
            DefaultChemObjectBuilder.getInstance
          )
          true
        rescue => e
          puts "SDF parsing failed: #{e} #{e.class} #{$!.inspect}"
          return false
        end
      end

      # Returns true if another IMolecule can be read.
      def has_next?
        begin
          @reader.has_next
        rescue => e
          puts "SDF parsing failed: #{e} #{e.class} #{$!.inspect}"
          false
        end
      end

      # Returns the next IMolecule.
      def next
        begin
          @reader.next
        rescue => e
          puts "SDF parsing failed: #{e} #{e.class} #{$!.inspect}"
          nil
        end
      end

      # Closes the Reader's resources.
      def close
        begin
          @reader.close
        rescue => e
          puts "SDF parsing failed: #{e} #{e.class} #{$!.inspect}"
        end
      end

    end

  end

end
