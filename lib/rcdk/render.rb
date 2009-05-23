# =============================================
# RCDK - The Chemistry Development Kit for Ruby
# =============================================
#
# Project Info: http://rubyforge.org/projects/rcdk
# Blog: http://depth-first.com
#
# Copyright (C) 2006 Richard L. Apodaca
#           (C) 2009 Sebastian Klemm
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
jrequire 'java.awt.image.BufferedImage'
jrequire 'java.awt.Graphics2D'
jrequire 'java.awt.Color'
jrequire 'java.awt.Font'
jrequire 'java.io.File'
jrequire 'javax.imageio.ImageIO'
jrequire 'java.util.List'
jrequire 'java.util.ArrayList'

jrequire 'org.openscience.cdk.layout.StructureDiagramGenerator'
jrequire 'org.openscience.cdk.renderer.Renderer'
jrequire 'org.openscience.cdk.renderer.RendererModel'
jrequire 'org.openscience.cdk.renderer.generators.RingGenerator'
jrequire 'org.openscience.cdk.renderer.generators.AtomContainerBoundsGenerator'
jrequire 'org.openscience.cdk.renderer.generators.BasicBondGenerator'
jrequire 'org.openscience.cdk.renderer.generators.BasicAtomGenerator'
jrequire 'org.openscience.cdk.renderer.font.AWTFontManager'
jrequire 'org.openscience.cdk.renderer.visitor.AWTDrawVisitor'
jrequire 'org.openscience.cdk.renderer.color.CPKAtomColors'


# The Ruby Chemistry Development Kit.
module RCDK

  # CDK Rendering core functions
  module Render

    class Painter
      include Org::Openscience::Cdk
      include Org::Openscience::Cdk::Renderer

      def self.write_png( molecule, filename, width, height )
        img = render_img molecule, width, height
        file = Java::Io::File.new(filename)
        Javax::Imageio::ImageIO.write(img, "PNG", file)
      end

      def self.write_jpg( molecule, filename, width, height )
        img = render_img molecule, width, height
        file = Java::Io::File.new(filename)
        Javax::Imageio::ImageIO.write(img, "JPG", file)
      end

      private

      def self.render_img( molecule, width, height )
        # prepare image
        area = Java::Awt::Rectangle.new width, height
        img = Java::Awt::Image::BufferedImage.new width, height,
          Java::Awt::Image::BufferedImage.TYPE_INT_RGB
        g2d = img.createGraphics
        g2d.setColor Java::Awt::Color.WHITE
        g2d.fillRect 0, 0, width, height
        visitor = Visitor::AWTDrawVisitor.new(g2d)

        render( molecule, visitor, area )
        # return the image
        img
      end

      def self.render_svg( molecule, width, height )

      end

      def self.render(molecule, visitor, area)
        # prepare molecule
        sdg = Layout::StructureDiagramGenerator.new
        sdg.setMolecule molecule
        sdg.generateCoordinates
        mol = sdg.getMolecule
        # prepare renderer
        generators = Java::Util::ArrayList.new
        generators.add(Generators::BasicBondGenerator.new)
        generators.add(Generators::BasicAtomGenerator.new)
        font = Font::AWTFontManager.new
        renderer = Renderer.new(generators, font)

        renderer.paintMolecule( mol, visitor, area, true )

      end

    end
      
  end
end
