# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/render'

class RenderTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::Render

  def test_write_png()
    molecule = Lang.read_smiles('C=1C=CC=CC=1')
    Painter.draw(molecule, 'benzene_new.png', 200, 200)
  end
end
