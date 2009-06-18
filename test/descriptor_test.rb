$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/qsar'

class DescriptorTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::QSAR

  def setup
    @mol = Lang.read_smiles('CN1CCC23C4C1CC5=C2C(=C(C=C5)O)OC3C(C=C4)O')
    @descriptor = Descriptor.new
    @descriptor.read_molecule(@mol)
  end

  def test_all
    puts @descriptor.mw
    puts @descriptor.xlogp
    puts @descriptor.hbd
    puts @descriptor.hba
    puts @descriptor.nrb
    puts @descriptor.tpsa
    puts @descriptor.formal_charge
    puts @descriptor.n_rings
  end

end
