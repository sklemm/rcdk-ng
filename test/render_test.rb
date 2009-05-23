$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/render'

class RenderTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::Render

  def test_render_imgs()
    molecule = Lang.read_smiles('Clc1ccccc1')
    Painter.write_png(molecule, 'output/new_chlorobenzene.png', 200, 200)
    Painter.write_jpg(molecule, 'output/new_chlorobenzene.jpg', 200, 200)
    molecule = Lang.read_smiles('CC(=O)OC1=CC=CC=C1C(=O)O')
    Painter.write_png(molecule, 'output/new_aspirin.png', 200, 200)
    Painter.write_jpg(molecule, 'output/new_aspirin.jpg', 200, 200)
  end
end
