class SakuraAT9999Dev < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"

  CURRENT_COMMIT = "2db313dc2155f03155d84e09e4dda43e049eb9e9".freeze
  url "https://github.com/dabisu/sakura.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  license "GPL-2.0-or-later"
  revision 1

  keg_only "this is an alternate version of another formula"

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "systemd"
  depends_on "vte3"

  patch :p1 do
    file "Patches/sakura/sakura-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
    type :unofficial
  end

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `sakura` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  test do
    ENV["LC_ALL"] = "C"
    output = shell_output("#{bin}/sakura --version 2>&1 || true").strip
    assert_equal "sakura version is 3.8.9", output
  end
end
