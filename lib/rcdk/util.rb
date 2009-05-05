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

jrequire 'java.io.StringReader'
jrequire 'java.io.StringWriter'
jrequire 'org.openscience.cdk.io.MDLWriter'
jrequire 'org.openscience.cdk.io.MDLReader'
jrequire 'org.openscience.cdk.smiles.SmilesParser'
jrequire 'org.openscience.cdk.smiles.SmilesGenerator'
jrequire 'org.openscience.cdk.DefaultChemObjectBuilder'
jrequire 'org.openscience.cdk.Molecule'
jrequire 'org.openscience.cdk.layout.StructureDiagramGenerator'
jrequire 'org.openscience.cdk.io.CMLReader'
jrequire 'org.openscience.cdk.ChemFile'
jrequire 'net.sf.structure.cdk.util.ImageKit'
jrequire 'uk.ac.cam.ch.wwmm.opsin.NameToStructure'

# The Ruby Chemistry Development Kit.
module RCDK
  
  # Convenience methods for working with the CDK.
  module Util
    
    # Molecular language translation. Currently molfile, SMILES,
    # and IUPAC nomenclature (read-only) are implemented.
    class Lang
      include Org::Openscience::Cdk
      include Org::Openscience::Cdk::Io
      include Java::Io
      include Uk::Ac::Cam::Ch::Wwmm::Opsin
      
      @@mdl_reader = Io::MDLReader.new
      @@mdl_writer = Io::MDLWriter.new
      @@smiles_parser = Smiles::SmilesParser.new
      @@smiles_generator = Smiles::SmilesGenerator.new(DefaultChemObjectBuilder.getInstance)
      @@cml_reader = nil
      
      # Returns a CDK <tt>Molecule</tt> given the String-based molfile
      # <tt>molfile</tt>.
      def self.read_molfile(molfile)
        reader = StringReader.new(molfile)
        
        @@mdl_reader.setReader(reader)
        @@mdl_reader.read(Molecule.new)
      end
      
      # Returns a CDK <tt>Molecule</tt> given the specified <tt>iupac_name</tt>.
      def self.read_iupac(iupac_name)
        nts = NameToStructure.getInstance
        cml = nts.parseToCML(iupac_name)
        
        raise "Couldn't parse #{iupac_name}." unless cml
        
        string_reader = StringReader.new(cml.toXML)
        
        @@cml_reader = CMLReader.new unless @@cml_reader
        @@cml_reader.setReader(string_reader)
        
        chem_file = @@cml_reader.read(ChemFile.new)
        chem_file.getChemSequence(0).getChemModel(0).getSetOfMolecules.getMolecule(0)
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
      include Net::Sf::Structure::Cdk::Util
      
      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using <tt>molfile</tt>.
      def self.molfile_to_png(molfile, path_to_png, width, height)
        ImageKit.writePNG(Lang.read_molfile(molfile), width, height, path_to_png)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_svg</tt> using <tt>molfile</tt>.
      def self.molfile_to_svg(molfile, path_to_svg, width, height)
        ImageKit.writeSVG(Lang.read_molfile(molfile), width, height, path_to_svg)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_jpg</tt> using <tt>molfile</tt>.
      def self.molfile_to_jpg(molfile, path_to_jpg, width, height)
        ImageKit.writeJPG(Lang.read_molfile(molfile), width, height, path_to_jpg)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_png(smiles, path_to_png, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        
        ImageKit.writePNG(mol, width, height, path_to_png)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_svg</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_svg(smiles, path_to_svg, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        
        ImageKit.writeSVG(mol, width, height, path_to_svg)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_jpg</tt> using <tt>smiles</tt>. Coordinates are automatically
      # assigned.
      def self.smiles_to_jpg(smiles, path_to_jpg, width, height)
        mol = XY.coordinate_molecule(Lang.read_smiles(smiles))
        
        ImageKit.writeJPG(mol, width, height, path_to_jpg)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using <tt>iupac_name</tt>. Coordinates
      # are automatically assigned.
      def self.iupac_to_png(iupac_name, path_to_png, width, height)
        mol = XY.coordinate_molecule(Lang.read_iupac(iupac_name))
        
        ImageKit.writePNG(mol, width, height, path_to_png)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_svg</tt> using <tt>iupac_name</tt>. Coordinates
      # are automatically assigned.
      def self.iupac_to_svg(iupac_name, path_to_svg, width, height)
        mol = XY.coordinate_molecule(Lang.read_iupac(iupac_name))
        
        ImageKit.writeSVG(mol, width, height, path_to_svg)
      end
      
      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_jpg</tt> using <tt>iupac_name</tt>. Coordinates
      # are automatically assigned.
      def self.iupac_to_jpg(iupac_name, path_to_jpg, width, height)
        mol = XY.coordinate_molecule(Lang.read_iupac(iupac_name))
        
        ImageKit.writeJPG(mol, width, height, path_to_jpg)
      end
    end
  end
end