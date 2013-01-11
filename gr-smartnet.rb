require 'formula'

class GrSmartnet < Formula
  homepage 'https://github.com/lokkju/gr-smartnet'
  head 'git@github.com:lokkju/gr-smartnet.git'
  url 'https://github.com/lokkju/gr-smartnet/archive/v20120111-2.tar.gz'
  version 'v20120111-2'
  sha1 '1ab2424a0f6acefeda2444a5d477c76e0573a608'

  depends_on 'cmake' => :build
  depends_on 'gnuradio'
  depends_on 'rtlsdr'

  def options
    [
      ['--with-docs', 'Build docs.']
    ]
  end

  def install
    mkdir 'build' do
      args = ["-DCMAKE_PREFIX_PATH=#{prefix}"] + std_cmake_args
      args << '-DENABLE_DOXYGEN=OFF' unless ARGV.include?('--with-docs')
      args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system 'cmake', '..', *args
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
