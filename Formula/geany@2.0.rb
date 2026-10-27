class GeanyAT20 < Formula
  desc "Fast and lightweight IDE"
  homepage "https://www.geany.org/"
  url "https://download.geany.org/geany-2.0.tar.gz"
  sha256 "50d28a45ac9b9695e9529c73fe7ed149edb512093c119db109cea6424114847f"
  revision 2

  keg_only "this is an alternate version of another formula"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docutils" => :build
  depends_on "gtk-doc" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "perl" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkgconf" => :build
  depends_on "ctags"
  depends_on "enchant"
  depends_on "gettext"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gnupg"
  depends_on "gpgme"
  depends_on "gtk+3"
  depends_on "hicolor-icon-theme"
  depends_on "libgit2"
  depends_on "libsoup@2"
  depends_on "libvterm"
  depends_on "pcre"
  depends_on "source-highlight"
  depends_on "vte3"
  depends_on "webkitgtk"
  depends_on "z80oolong/vte/lua@5.1"

  resource("geany-plugins") do
    url "https://github.com/geany/geany-plugins/releases/download/2.0.0/geany-plugins-2.0.tar.bz2"
    sha256 "9fc2ec5c99a74678fb9e8cdfbd245d3e2061a448d70fd110a6aefb62dd514705"

    patch :p1 do
      file "Patches/geany/geany-plugin-2.0-fix.diff"
      type :unofficial
    end
  end

  resource("ctpl") do
    url "https://github.com/b4n/ctpl/archive/refs/tags/v0.3.5.tar.gz"
    sha256 "ae60c79316c6dc3a2935d906b8a911ce4188e8638b6e9b65fc6c04a5ca6bcdda"
  end

  patch :p1 do
    file "Patches/geany/geany-2.0-fix.diff"
    type :unofficial
  end

  def install
    ENV.append "CFLAGS", "-DNO_USE_HOMEBREW_GEANY_PLUGINS"
    ENV.prepend_path "PERL5LIB", formula_opt_libexec("perl-xml-parser")/"lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"ctpl/lib/pkgconfig"
    ENV.prepend "CPPFLAGS", "-I#{formula_opt_include("glibc")}"
    ENV.prepend "CFLAGS", "-I#{formula_opt_include("glibc")}"
    ENV.prepend "CXXFLAGS", "-I#{formula_opt_include("glibc")}"
    ENV["LC_ALL"] = "C"

    resource("ctpl").stage do
      args = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/ctpl" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/ctpl/lib" : arg }
      args << "--disable-silent-rules"

      system "sh", "./autogen.sh"
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    inreplace "./scintilla/include/ScintillaTypes.h",
      /^#define SCINTILLATYPES_H/, "#define SCINTILLATYPES_H\n\n#include <cstdint>\n"
    inreplace "./scintilla/src/Geometry.h",
      /^#define GEOMETRY_H/, "#define GEOMETRY_H\n\n#include <cstdint>\n"

    args  = std_configure_args.dup
    args << "--enable-vte"
    args << "--with-vte-module-path=#{formula_opt_prefix("vte3")}"

    system "./configure", *args
    system "make"
    system "make", "install"

    resource("geany-plugins").stage do
      inreplace "./git-changebar/src/gcb-plugin.c", /\*bool/, "*boolean"
      inreplace "./configure", "webkit2gtk-4.0", "webkit2gtk-4.1"

      args  = std_configure_args
      args << "--enable-markdown"
      args << "--disable-devhelp"
      args << "--with-lua-pkg=lua5.1"
      args << "--with-geany-libdir=#{lib}"

      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    output = shell_output("#{bin}/geany --version").strip
    assert_match Regexp.new("^geany #{version}"), output
  end
end
