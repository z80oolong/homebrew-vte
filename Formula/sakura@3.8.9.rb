class SakuraAT389 < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_9.tar.gz"
  sha256 "46b792098a82ba4affc87a174ae96f32e730396e4f5ba9b699e8071253b085a2"
  license "GPL-2.0-or-later"
  revision 2

  keg_only "this is an alternate version of another formula"

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "systemd"
  depends_on "vte3"

  patch :p1 do
    file "Patches/sakura/sakura-3.8.9-fix.diff"
    type :unofficial
  end

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
    assert_equal "sakura version is #{version}", output
  end
end
