class Sakura < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"
  revision 1

  stable do
    url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_9.tar.gz"
    sha256 "46b792098a82ba4affc87a174ae96f32e730396e4f5ba9b699e8071253b085a2"

    patch :p1, Formula["z80oolong/vte/sakura@3.8.9"].diff_data
  end

  head do
    url "https://github.com/dabisu/sakura.git"

    patch :p1, Formula["z80oolong/vte/sakura@9999-dev"].diff_data
  end

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "systemd"
  depends_on "gtk+3"
  depends_on "vte3"

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"sakura", "--version"
  end
end
