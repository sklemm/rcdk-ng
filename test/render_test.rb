$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/render'

class RenderTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::Render

  def test_write_png()
    molecule = Lang.read_smiles('Clc1ccccc1')
    Painter.write_png(molecule, 'output/new_chlorobenzene.png', 100, 100)
    molecule = Lang.read_smiles('CC(=O)OC1=CC=CC=C1C(=O)O')
    Painter.write_png(molecule, 'output/new_aspirin.png', 100, 100)
  end
end
