$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/io'

jrequire 'org.openscience.cdk.CDKConstants'

class SDFTest < Test::Unit::TestCase
  include RCDK::IO

  @@filename = 'test/Compound_00000001_00025000.sdf'

  def test_read_sdfile
    
    file = File.new(@@filename, "r")
    fh = IO.new(file.fileno,"r")
    reader = SdfReader.new
    reader.read_data(fh)
    fh.close
    count = 0
    while reader.has_next?
      mol = reader.next
      puts mol.getProperty(Org::Openscience::Cdk::CDKConstants.TITLE).toString
      count+=1
    end

    assert_equal(23405, count)

  end

end