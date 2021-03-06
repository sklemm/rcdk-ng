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

CDK_VERSION = '1.2.3-with-jcpprim'
BATIK_VERSION = '1.7'

require 'jrequire'

libpath = File.dirname(__FILE__) + "/../java/lib"

classpath = ENV['CLASSPATH'] ||= ''
classpath += File::PATH_SEPARATOR + File.join(libpath, 'cdk-' + CDK_VERSION + '.jar')
classpath += File::PATH_SEPARATOR + File.join(libpath, 'batik-' + BATIK_VERSION + '.jar')

load_jvm(classpath, ['-Xms128m', '-Xmx1024m'])
