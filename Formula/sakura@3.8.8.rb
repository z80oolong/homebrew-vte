class SakuraAT388 < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_8.tar.gz"
  sha256 "b2b05e9e389dafe7bf41fd2fd4ca38a23afdd2e207bf0734d7f3aa3bb6346d50"
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
    file "Patches/sakura/sakura-3.8.8-fix.diff"
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
