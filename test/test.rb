# =============================================
# RCDK - The Chemistry Development Kit for Ruby
# =============================================
#
# Project Info: http://rubyforge.org/projects/rcdk
# Blog: http://depth-first.com
#
# Copyright (C) 2006 Richard L. Apodaca
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

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'rcdk'
require 'rcdk/util'

jrequire 'org.openscience.cdk.templates.MoleculeFactory'

# A very simple test suite. Woefully incomplete. Just exercises the API.
class BasicTest < Test::Unit::TestCase
  include RCDK::Util
  include Org::Openscience::Cdk::Templates
  
  def setup
    @benzene =
"c1ccccc1
JME 2004.10 Thu Jun 01 18:20:16 EDT 2006

  6  6  0  0  0  0  0  0  0  0999 V2000
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  1  2  2  0  0  0  0
  1  3  1  0  0  0  0
  2  4  1  0  0  0  0
  3  5  2  0  0  0  0
  4  6  2  0  0  0  0
  5  6  1  0  0  0  0
M  END"
  end
  
  def test_read_molfile
    mol = Lang.read_molfile(@benzene)
    
    assert_equal(6, mol.getAtomCount)
  end
  
  def test_write_molfile
    molecule = MoleculeFactory.makeIndole
    molfile = Lang.get_molfile(molecule)
    
    assert_not_equal(0, molfile.length)
  end
  
  def test_read_smiles
    molecule = Lang.read_smiles('c1ccccc1')
    
    assert_equal(6, molecule.getAtomCount)
  end
  
  def test_read_iupac
    molecule = Lang.read_iupac('benzene')
    
    assert_equal(6, molecule.getAtomCount)
  end
  
  def test_write_smiles
    smiles = Lang.get_smiles(MoleculeFactory.makeBenzene)
    
    assert_equal('c1ccccc1', smiles)
  end
  
  def test_molfile_to_smiles
    smiles = Lang.molfile_to_smiles(@benzene)
    
    assert_equal('c1ccccc1', smiles)
  end
  
  def test_smiles_to_molfile
    molfile = Lang.smiles_to_molfile('c1ccccc1')
    
    assert_not_equal(0, molfile.length)
  end
  
  def test_coordinate_molecule
    indole = MoleculeFactory.makeIndole
    XY.coordinate_molecule(indole)
  end
  
  def test_coordinate_molfile
    molfile = XY.coordinate_molfile(XY.coordinate_molfile(@benzene))
  end
 
  def test_molfile_to_png
    Image.molfile_to_png(XY.coordinate_molfile(@benzene), 'output/benzene.png', 200, 200)
  end
  
  def test_molfile_to_svg
    Image.molfile_to_svg(XY.coordinate_molfile(@benzene), 'output/benzene.svg', 200, 200)
  end
  
  def test_molfile_to_jpg
    Image.molfile_to_jpg(XY.coordinate_molfile(@benzene), 'output/benzene.jpg', 200, 200)
  end
  
  def test_smiles_to_png
    Image.smiles_to_png('Clc1ccccc1', 'output/chlorobenzene.png', 200, 200)
  end
  
  def test_smiles_to_svg
    Image.smiles_to_svg('Clc1ccccc1', 'output/chlorobenzene.svg', 200, 200)
  end
  
  def test_smiles_to_jpg
    Image.smiles_to_jpg('Clc1ccccc1', 'output/chlorobenzene.jpg', 200, 200)
  end
  
  def test_iupac_to_png
    Image.iupac_to_png('quinoline', 'output/quinoline.png', 200, 200)
  end
  
  def test_iupac_to_svg
    Image.iupac_to_svg('quinoline', 'output/quinoline.svg', 200, 200)
  end
  
  def test_iupac_to_jpg
    Image.iupac_to_jpg('quinoline', 'output/quinoline.jpg', 200, 200)
  end
end

