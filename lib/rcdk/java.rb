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

require 'rubygems'
require_gem 'rjb'
require 'rjb'

# Adds the fully-qualified path <tt>path_to_jarfile</tt> to the <tt>
# CLASSPATH</tt> environment variable. Any jarfiles added after the
# first invocation of a Java constructor will be globally ignored, i.e., <tt>
# require</tt> all jarfiles first in your program before constructing
# objects from them.
def require_jar(path_to_jarfile)
  if classpath_set?
    ENV['CLASSPATH'] = ENV['CLASSPATH'] + File::PATH_SEPARATOR + path_to_jarfile
  else
    ENV['CLASSPATH'] = path_to_jarfile
  end
end

private  

# Returns false if the <tt>CLASSPATH</tt> variable is either null or
# empty, or otherwise true.
def classpath_set?
  if !ENV['CLASSPATH']
    return false
  elsif ''.eql?(ENV['CLASSPATH'])
    return false
  end
  
  true
end

module Kernel

  # Maps the packages and class name specified by <tt>qualified_class_name</tt>
  # to a nested set of Ruby modules. The first letter of each module name is
  # capitalized. For example, <tt>java.util.HashMap</tt> would become <tt>
  # Java::Util::HashMap</tt>.
  # 
  # The first use of <tt>jrequire</tt> will render all subsequent calls
  # to <tt>require_jar</tt> ineffective.
  def jrequire(qualified_class_name)
    java_class = Rjb::import(qualified_class_name)
    package_names = qualified_class_name.to_s.split('.')
    java_class_name = package_names.delete(package_names.last)
    new_module = self.class

    package_names.each do |package_name|
      module_name = package_name.capitalize

      if !new_module.const_defined?(module_name)
        new_module = new_module.const_set(module_name, Module.new)
      else
        new_module = new_module.const_get(module_name)
      end
    end

    return false if new_module.const_defined?(java_class_name)

    new_module.const_set(java_class_name, java_class)

    return true
  end
end