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

RCDK_VERSION = '0.4.2'
CDK_VERSION = '20090505'
STRUCTURE_CDK_VERSION = '0.2.2'
BATIK_VERSION = '1.7'

require 'rcdk/java'

require_jar File.join(File.dirname(__FILE__), '..', 'java', 'lib', 'cdk-' + CDK_VERSION + '.jar')
require_jar File.join(File.dirname(__FILE__), '..', 'java', 'lib', 'structure-cdk-' + STRUCTURE_CDK_VERSION + '.jar')
require_jar File.join(File.dirname(__FILE__), '..', 'java', 'lib', 'batik-' + BATIK_VERSION + '.jar')
