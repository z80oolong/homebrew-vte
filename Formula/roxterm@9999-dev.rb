class RoxtermAT9999Dev < Formula
  desc "Highly configurable terminal emulator based on VTE"
  homepage "https://roxterm.sourceforge.io/"

  CURRENT_COMMIT = "00fcf32619ea0b4c1d5afeb5b590a3565d82c4f7".freeze
  url "https://github.com/realh/roxterm.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  license "LGPL-3.0-or-later"
  revision 3

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
    file "Patches/roxterm/roxterm-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
    type :unofficial
  end

  def install
    ENV.append "CFLAGS", "-D_GNU_SOURCE"
    ENV.append "CFLAGS", "-DENABLE_NLS=1"

    inreplace "./man/CMakeLists.txt" do |s|
      s.gsub! %r{http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl},
        "#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl-ns/manpages/docbook.xsl"
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

      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/ja/LC_MESSAGES/roxterm.mo", "./ja.po"
      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/en_US/LC_MESSAGES/roxterm.mo", "./en_US.po"
    end
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `roxterm` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  test do
    system "test", "-x", bin/"roxterm"
  end
end
