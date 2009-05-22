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
jrequire 'java.io.File'
jrequire 'javax.imageio.ImageIO'

jrequire 'org.openscience.cdk.layout.StructureDiagramGenerator'
jrequire 'org.openscience.cdk.renderer.Renderer2DModel'
jrequire 'org.openscience.cdk.renderer.Java2DRenderer'

# The Ruby Chemistry Development Kit.
module RCDK

  # CDK Rendering core functions
  module Render

    class Painter
      include Java::Awt
      include Org::Openscience::Cdk

      def self.draw( molecule, filename, width, height )
        area = Rectangle.new( width, height )
        img = Image::BufferedImage.new( width, height,
          Image::BufferedImage.TYPE_INT_RGB )
        g2d = img.createGraphics()
        g2d.setBackground(Color.WHITE)

        sdg = Layout::StructureDiagramGenerator.new
        sdg.setMolecule(molecule)
        sdg.generateCoordinates()
        mol = sdg.getMolecule

        model = Renderer::Renderer2DModel.new
        renderer = Renderer::Java2DRenderer.new(model)

        renderer.paintMolecule(mol, g2d)
        file = Java::Io::File.new(filename)
        Javax::Imageio::ImageIO.write(img, "PNG", file)
      end

    end
      
  end
end
