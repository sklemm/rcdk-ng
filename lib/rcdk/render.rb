# =============================================
# RCDK - The Chemistry Development Kit for Ruby
# =============================================
#
# Project Info: http://rubyforge.org/projects/rcdk
# Blog: http://depth-first.com
#
# Copyright (C) 2006 Richard L. Apodaca
# Author    (C) 2009 Sebastian Klemm
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

jrequire 'java.awt.Rectangle'
jrequire 'java.awt.Dimension'
jrequire 'java.awt.image.BufferedImage'
jrequire 'java.awt.Graphics2D'
jrequire 'java.awt.Color'
jrequire 'java.awt.Font'
jrequire 'java.io.File'
jrequire 'java.io.FileWriter'
jrequire 'javax.imageio.ImageIO'
jrequire 'java.util.ArrayList'

jrequire 'org.apache.batik.dom.GenericDOMImplementation'
jrequire 'org.apache.batik.svggen.SVGGraphics2D'

jrequire 'org.openscience.cdk.layout.StructureDiagramGenerator'
jrequire 'org.openscience.cdk.renderer.AtomContainerRenderer'
jrequire 'org.openscience.cdk.renderer.RendererModel'
jrequire 'org.openscience.cdk.renderer.generators.BasicBondGenerator'
jrequire 'org.openscience.cdk.renderer.generators.BasicAtomGenerator'
jrequire 'org.openscience.cdk.renderer.font.AWTFontManager'
jrequire 'org.openscience.cdk.renderer.visitor.AWTDrawVisitor'
jrequire 'org.openscience.cdk.renderer.visitor.SVGGenerator'
jrequire 'org.openscience.cdk.renderer.color.CPKAtomColors'


# The Ruby Chemistry Development Kit.
module RCDK

  # CDK Rendering core functions
  module Render

    # Helper class for <tt>Util::Image</tt>.
    # Replaces structure-cdk ImageKit
    class Painter
      include Org::Apache::Batik
      include Org::Openscience::Cdk
      include Org::Openscience::Cdk::Renderer

      # Writes a <tt>width</tt> by <tt>height</tt> PNG image to
      # <tt>path_to_png</tt> using a <tt>molecule</tt>.
      def self.write_png( molecule, filename, width, height )
        img = render_img molecule, width, height
        file = Java::Io::File.new(filename)
        Javax::Imageio::ImageIO.write(img, "PNG", file)
      end

      # Writes a <tt>width</tt> by <tt>height</tt> JPG image to
      # <tt>path_to_png</tt> using a <tt>molecule</tt>.
      def self.write_jpg( molecule, filename, width, height )
        img = render_img molecule, width, height
        file = Java::Io::File.new(filename)
        Javax::Imageio::ImageIO.write(img, "JPG", file)
      end

      # Writes a <tt>width</tt> by <tt>height</tt> SVG document to
      # <tt>path_to_png</tt> using a <tt>molecule</tt>.
      def self.write_svg( molecule, filename, width, height )
        svg2d = render_svg molecule, width, height
        filewriter = Java::Io::FileWriter.new(filename)
        svg2d.stream(filewriter, true)
      end

      private

      def self.render_img( molecule, width, height )
        # prepare image
        img = Java::Awt::Image::BufferedImage.new width, height,
          Java::Awt::Image::BufferedImage.TYPE_INT_RGB
        g2d = img.createGraphics
        g2d.setColor Java::Awt::Color.WHITE
        g2d.fillRect 0, 0, width, height
        visitor = Visitor::AWTDrawVisitor.new(g2d)

        render( molecule, visitor, width, height )
        img
      end

      def self.render_svg( molecule, width, height )
        # prepare svg generator
        area = Java::Awt::Dimension.new width, height
        dom = Dom::GenericDOMImplementation.getDOMImplementation
        svgns = "http://www.w3.org/2000/svg"
        doc = dom.createDocument(svgns, "svg", nil)
        svg2d = Svggen::SVGGraphics2D.new(doc)
        svg2d.setSVGCanvasSize(area)
        visitor = Visitor::AWTDrawVisitor.new(svg2d)

        render( molecule, visitor, width, height )
        svg2d
      end

      def self.render(molecule, visitor, width, height)
        # prepare molecule
        sdg = Layout::StructureDiagramGenerator.new
        sdg.setMolecule molecule
        sdg.generateCoordinates
        mol = sdg.getMolecule
        # prepare renderer
        area = Java::Awt::Rectangle.new width, height
        generators = Java::Util::ArrayList.new
        generators.add(Generators::BasicBondGenerator.new)
        generators.add(Generators::BasicAtomGenerator.new)
        font = Font::AWTFontManager.new
        renderer = AtomContainerRenderer.new(generators, font)
        renderer.setup(mol,area)
        model = renderer.getRenderer2DModel
        model.setAtomColorer Color::CPKAtomColors.new
        model.setBondWidth 2

        # if model is bigger than draw area, zoom to fit screen.
        # this prevents too that small molecules are drawn to big
        diagram_bounds = renderer.calculateDiagramBounds(mol)
        if diagram_bounds.getWidth > area.getWidth || diagram_bounds.getHeight > area.getHeight
          renderer.setZoomToFit(area.getWidth, area.getHeight,
            diagram_bounds.getWidth, diagram_bounds.getHeight)
          model.setBondWidth 1
        end

        renderer.paint( mol, visitor )
      end

    end
      
  end
end
