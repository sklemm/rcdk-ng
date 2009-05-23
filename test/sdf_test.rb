$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'

class SDFTest < Test::Unit::TestCase
  include RCDK::Util

  @@filename = 'test/Compound_00000001_00025000.sdf'

  def test_read_sdfile
    mols = Lang.read_sdfile(@@filename)

    assert_equal(23405, mols.length)

  end

end