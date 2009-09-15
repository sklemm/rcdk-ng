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

require 'rcdk'
require 'rcdk/render'

jrequire 'java.io.StringReader'
jrequire 'java.io.StringWriter'
jrequire 'org.openscience.cdk.io.MDLWriter'
jrequire 'org.openscience.cdk.io.MDLReader'
jrequire 'org.openscience.cdk.smiles.SmilesParser'
jrequire 'org.openscience.cdk.smiles.SmilesGenerator'
jrequire 'org.openscience.cdk.DefaultChemObjectBuilder'
jrequire 'org.openscience.cdk.Molecule'
jrequire 'org.openscience.cdk.layout.StructureDiagramGenerator'
jrequire 'org.openscience.cdk.CDKConstants'
jrequire 'org.openscience.cdk.tools.manipulator.AtomContainerManipulator'

# The Ruby Chemistry Development Kit.
module RCDK
  
  # Convenience methods for working with the CDK.
  module Util

    class Property
      include Org::Openscience::Cdk

      def self.get_title(mol)
        title = mol.getProperty(CDKConstants.TITLE)
        if title
          return title.toString
        else
          return "<title not found>"
        end
      end

      def self.set_title(mol, title)
        mol.setProperty(CDKConstants.TITLE, title)
        return mol
      end

    end

    class Tools
      include Org::Openscience::Cdk::Tools::Manipulator

      def self.remove_hydrogens(mol)
        AtomContainerManipulator.removeHydrogensPreserveMultiplyBonded(mol)
      end
      
    end

    # Molecular language translation. Currently molfile, SMILES,
    # and SD files (read-only) are implemented.
    class Lang
      include Org::Openscience::Cdk
      include Org::Openscience::Cdk::Io
      include Java::Io

      @@mdl_reader = Io::MDLReader.new
      @@mdl_writer = Io::MDLWriter.new
      @@smiles_parser = Smiles::SmilesParser.new(DefaultChemObjectBuilder.getInstance)
      @@smiles_generator = Smiles::SmilesGenerator.new

      # Returns a CDK <tt>Molecule</tt> given the String-based molfile
      # <tt>molfile</tt>.
      def self.read_molfile(molfile)
        reader = StringReader.new(molfile)
        
        @@mdl_reader.setReader(reader)
        @@mdl_reader.read(Molecule.new)
      end
      
      # Returns a String-based molfile by parsing the CDK <tt>molecule</tt>.
      def self.get_molfile(molecule)
        writer = StringWriter.new
        
        @@mdl_writer.setWriter(writer)
        @@mdl_writer.writeMolecule(molecule)
        @@mdl_writer.close
        
        writer.toString
      end
      
      # Returns a CDK <tt>Molecule</tt> by parsing <tt>smiles</tt>.
      def self.read_smiles(smiles)
        @@smiles_parser.parseSmiles(smiles)
      end
      
      # Returns a SMILES string based on the structure of the indicated
      # CDK <tt>molecule</tt>.
      def self.get_smiles(molecule)
        @@smiles_generator.createSMILES(molecule)
      end
      
      # Returns a SMILES string by parsing the <tt>molfile</tt> string.
      def self.molfile_to_smiles(molfile)
        get_smiles(read_molfile(molfile))
      end
      
      # Returns a molfiles STRING by parsing <tt>smiles</tt>.
      def self.smiles_to_molfile(smiles)
        get_molfile(read_smiles(smiles))
      end
    end
    
    # 2-D coordinate generation.
    class XY
      include Org::Openscience::Cdk     
      
      @@sdg = Layout::StructureDiagramGenerator.new    
      
      # Assigns 2-D coordinates to the indicated <tt>molfile</tt> string.
      def self.coordinate_molfile(molfile)
        mol = coordinate_molecule(Lang.read_molfile(molfile))
        
        Lang.get_molfile(mol)
      end
      
      # Assigns 2-D coordinates to the indicated CDK <tt>molecule</tt>.
      def self.coordinate_molecule(molecule)
        @@sdg.setMolecule(molecule)
        @@sdg.generateCoordinates
        @@sdg.getMolecule
      end
    end
    
    # Raster and SVG 2-D molecular images.
    class Image
      
      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using <tt>molfile</tt>.
      def self.molfile_to_png(molfile, path_to_png, width, height)
        Render::Painter.write_png(Lang.read_molfile(molfile), path_to_png, width, height)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_svg</tt> using <tt>molfile</tt>.
      def self.molfile_to_svg(molfile, path_to_svg, width, height)
        Render::Painter.write_svg(Lang.read_molfile(molfile), path_to_svg, width, height)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_jpg</tt> using <tt>molfile</tt>.
      def self.molfile_to_jpg(molfile, path_to_jpg, width, height)
        Render::Painter.write_jpg(Lang.read_molfile(molfile), path_to_jpg, width, height)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_png(smiles, path_to_png, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        Render::Painter.write_png(mol, path_to_png, width, height)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_svg</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_svg(smiles, path_to_svg, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        Render::Painter.write_svg(mol, path_to_svg, width, height)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_jpg</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_jpg(smiles, path_to_jpg, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        Render::Painter.write_jpg(mol, path_to_jpg, width, height)
      end
      
    end
  end
end

