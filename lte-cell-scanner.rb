require 'formula'

class LteCellScanner < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/GrOsmoSDR'
  head 'https://github.com/Evrytania/LTE-Cell-Scanner.git'
  url 'https://github.com/Evrytania/LTE-Cell-Scanner.git', :rev => '5fa3df8a5d915c73cacea843021ce0c5b317522f'

  depends_on 'cmake' => :build
  depends_on 'gnuradio'

  def install
    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system 'make'
      system 'make install'
    end
  end

  def python_path
    python = Formula.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
