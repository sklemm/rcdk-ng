$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/qsar'

jrequire 'org.openscience.cdk.io.CMLWriter'
jrequire 'java.io.FileWriter'
jrequire 'java.io.StringWriter'

class DescriptorTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::QSAR

  def setup
    @mol = Lang.read_molfile(Lang.smiles_to_molfile('CC(=O)OC1=CC=CC=C1(C(=O)O)'))

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
