class RoxtermAT3182 < Formula
  desc "Highly configurable terminal emulator based on VTE"
  homepage "https://roxterm.sourceforge.io/"
  url "https://github.com/realh/roxterm/archive/refs/tags/3.18.2.tar.gz"
  sha256 "d20a19abe03798bfc6c9404eb7ce4fbecabf2e1ab527b587aab76d06635a92e7"
  license "LGPL-3.0-or-later"
  revision 2

  keg_only "this is an alternate version of another formula"

  depends_on "cmake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "gettext" => :build
  depends_on "libxslt" => :build
  depends_on "pkgconf" => :build
  depends_on "dbus-glib"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "vte3"

  resource("roxterm-ja-po") do
    url "https://gist.github.com/731fd4e4d0adb4178ce69885bf061523.git",
        branch:   "main",
        revision: "72cd4d52211814ac3a8cecd2fc197447c3914c47"
  end

  patch :p1 do
    file "Patches/roxterm/roxterm-3.18.2-fix.diff"
    type :unofficial
  end

  def install
    ENV.append "CFLAGS", "-D_GNU_SOURCE"
    ENV.append "CFLAGS", "-DENABLE_NLS=1"

    inreplace "./man/CMakeLists.txt" do |s|
      s.gsub! %r{http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl},
        "#{formula_opt_prefix("docbook-xsl")}/docbook-xsl-ns/manpages/docbook.xsl"
    end

    inreplace "./src/config.h.in" do |s|
      s.gsub!(/^#cmakedefine ENABLE_NLS/, "#define ENABLE_NLS 1")
    end

    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    resource("roxterm-ja-po").stage do
      (share/"locale/ja/LC_MESSAGES").mkpath
      (share/"locale/en_US/LC_MESSAGES").mkpath

      system formula_opt_bin("gettext")/"msgfmt", "-o", share/"locale/ja/LC_MESSAGES/roxterm.mo", "./ja.po"
      system formula_opt_bin("gettext")/"msgfmt", "-o", share/"locale/en_US/LC_MESSAGES/roxterm.mo", "./en_US.po"
    end
  end

  test do
    system "test", "-x", bin/"roxterm"
  end
end
