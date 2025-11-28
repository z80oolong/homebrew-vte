class Geany < Formula
  desc "Fast and lightweight IDE"
  homepage "https://www.geany.org/"
  revision 1

  stable do
    url "https://download.geany.org/geany-2.1.tar.gz"
    sha256 "8da944e82f78f3c4c6e6b054b7c562ab64ea37d4a3e7dc8576bed8a8160d3c2a"

    resource("geany-plugins") do
      url "https://github.com/geany/geany-plugins/archive/refs/tags/2.1.0.tar.gz"
      sha256 "9ca8412763c2f8a7141f6a1569166f4fabf95fc8aad5149a754265673ffce5bb"
    end

    patch :p1, Formula["z80oolong/vte/geany@2.1"].diff_data
  end

  head do
    url "https://github.com/geany/geany.git"

    resource("geany-plugins") do
      url "https://github.com/geany/geany-plugins.git"
    end

    patch :p1, Formula["z80oolong/vte/geany@9999-dev"].diff_data
  end

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

  resource("ctpl") do
    url "https://github.com/b4n/ctpl/archive/refs/tags/v0.3.5.tar.gz"
    sha256 "ae60c79316c6dc3a2935d906b8a911ce4188e8638b6e9b65fc6c04a5ca6bcdda"
  end

  def install
    ENV.append "CFLAGS", "-DNO_USE_HOMEBREW_GEANY_PLUGINS"
    ENV.prepend_path "PERL5LIB", Formula["perl-xml-parser"].opt_libexec/"lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"ctpl/lib/pkgconfig"
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

    args  = std_configure_args
    args << "--enable-vte"
    args << "--with-vte-module-path=#{Formula["vte3"].opt_prefix}"

    if build.head?
      system "sh", "./autogen.sh"
    else
      inreplace "./scintilla/include/ScintillaTypes.h",
        /^#define SCINTILLATYPES_H/, "#define SCINTILLATYPES_H\n\n#include <cstdint>\n"
      inreplace "./scintilla/src/Geometry.h",
        /^#define GEOMETRY_H/, "#define GEOMETRY_H\n\n#include <cstdint>\n"
    end

    system "./configure", *args
    system "make"
    system "make", "install"

    resource("geany-plugins").stage do
      system "sh", "./autogen.sh"
      system "patch -p1 < #{buildpath}/geany-plugins.diff"
      inreplace "./git-changebar/src/gcb-plugin.c", /\*bool/, "*boolean" unless build.head?
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
    ver = build.head? ? "2.2.0 \\(git >= [0-9a-f]{9}\\)" : version
    assert_match Regexp.new("^geany #{ver}"), output
  end
end
