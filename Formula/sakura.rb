class Sakura < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0-or-later"
  revision 2

  CURRENT_VERSION = "3.8.9".freeze
  CURRENT_COMMIT  = "2db313dc2155f03155d84e09e4dda43e049eb9e9".freeze

  stable do
    url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_9.tar.gz"
    sha256 "46b792098a82ba4affc87a174ae96f32e730396e4f5ba9b699e8071253b085a2"

    patch :p1 do
      file "Patches/sakura/sakura-#{CURRENT_VERSION}-fix.diff"
      type :unofficial
    end
  end

  head do
    url "https://github.com/dabisu/sakura.git"

    patch :p1 do
      file "Patches/sakura/sakura-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
      type :unofficial
    end
  end

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "systemd"
  depends_on "vte3"

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    ENV["LC_ALL"] = "C"
    output = shell_output("#{bin}/sakura --version 2>&1 || true").strip
    assert_equal "sakura version is 3.8.9", output
  end
end
