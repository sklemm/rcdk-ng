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

jrequire 'org.openscience.cdk.tools.manipulator.AtomContainerManipulator'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.WeightDescriptor'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.XLogPDescriptor'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.HBondDonorCountDescriptor'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.HBondAcceptorCountDescriptor'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.RotatableBondsCountDescriptor'
jrequire 'org.openscience.cdk.qsar.descriptors.molecular.TPSADescriptor'
jrequire 'org.openscience.cdk.ringsearch.AllRingsFinder'
  
# The Ruby Chemistry Development Kit.
module RCDK

  # Classes and methods for calculating descriptors
  module QSAR

    # Wrapper for the IDescriptor Implementations
    # Currently available
    # - MW
    # - XLogP3
    # - clogP
    # - HBD
    # - HBA
    # - nRotB
    # - tPSA
    # - Formal Charge
    # - Nb(rings)
    #
    # Usage:
    # <pre>descriptor = RCDK::QSAR::Descriptor.new
    # descriptor.read_molecule(mol)
    # mw = descriptor.mw
    # tpsa = descriptor.tpsa
    # </pre>
    class Descriptor
      include Org::Openscience::Cdk
      include Org::Openscience::Cdk::Qsar::Descriptors::Molecular

      # reads the molecule and saves it as member variable
      def read_molecule(mol)
        @mol = mol
        Tools::Manipulator::AtomContainerManipulator.convertImplicitToExplicitHydrogens(@mol)
        @mol
      end

      # returns the molecular weight of the molecule as
      def mw
        desc = WeightDescriptor.new
        desc.calculate(@mol).getValue().doubleValue
      end

      def xlogp
        desc = XLogPDescriptor.new

        desc.calculate(@mol).getValue().doubleValue
      end
            
      def hbd
        desc = HBondDonorCountDescriptor.new
        desc.calculate(@mol).getValue().intValue
      end
      
      def hba
        desc = HBondAcceptorCountDescriptor.new
        desc.calculate(@mol).getValue().intValue
      end
      
      def nrb
        desc = RotatableBondsCountDescriptor.new
        desc.calculate(@mol).getValue().intValue
      end
      
      def tpsa
        desc = TPSADescriptor.new
        desc.calculate(@mol).getValue().doubleValue
      end
      
      def formal_charge
        Tools::Manipulator::AtomContainerManipulator.getTotalFormalCharge(@mol)
      end
      
      def n_rings
        finder = Ringsearch::AllRingsFinder.new
        finder.findAllRings(@mol).getAtomContainerCount
      end

    end

  end

end
