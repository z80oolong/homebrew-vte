def ENV.replace_rpath(**replace_list)
  replace_list = replace_list.each_with_object({}) do |(old, new), result|
    old_f = Formula[old]
    new_f = Formula[new]
    result[old_f.opt_lib.to_s] = new_f.opt_lib.to_s
    result[old_f.lib.to_s] = new_f.lib.to_s
  end

  if (rpaths = fetch("HOMEBREW_RPATH_PATHS", false))
    self["HOMEBREW_RPATH_PATHS"] = (rpaths.split(":").map do |rpath|
      replace_list.fetch(rpath, rpath)
    end).join(":")
  end
end

class Geany < Formula
  desc "Fast and lightweight IDE"
  homepage "https://www.geany.org/"

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

    patch :p1, Formula["z80oolong/vte/geany@2.99-dev"].diff_data
  end

  resource("ctpl") do
    url "https://github.com/b4n/ctpl/archive/refs/tags/v0.3.5.tar.gz"
    sha256 "ae60c79316c6dc3a2935d906b8a911ce4188e8638b6e9b65fc6c04a5ca6bcdda"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docutils" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "perl" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "gtk-doc" => :build
  depends_on "pkgconf" => :build
  depends_on "ctags"
  depends_on "enchant"
  depends_on "gettext"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gnupg"
  depends_on "gpgme"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "hicolor-icon-theme"
  depends_on "libsoup@2"
  depends_on "libvterm"
  depends_on "pcre"
  depends_on "source-highlight"
  depends_on "webkitgtk"
  depends_on "libgit2"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"
    ENV.append "CFLAGS", "-DNO_USE_HOMEBREW_GEANY_PLUGINS"
    ENV.prepend_path "PERL5LIB", Formula["perl-xml-parser"].opt_libexec/"lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"ctpl/lib/pkgconfig"
    ENV["LC_ALL"] = "C"

    resource("ctpl").stage do
      args  = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/ctpl" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/ctpl/lib" : arg }
      args << "--disable-silent-rules"

      system "sh", "./autogen.sh"
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    if build.head?
      system "sh", "./autogen.sh"
    else
      inreplace "./scintilla/include/ScintillaTypes.h",
        /^#define SCINTILLATYPES_H/, "#define SCINTILLATYPES_H\n\n#include <cstdint>\n"
      inreplace "./scintilla/src/Geometry.h",
        /^#define GEOMETRY_H/, "#define GEOMETRY_H\n\n#include <cstdint>\n"
    end

    args  = std_configure_args
    args << "--enable-vte"
    args << "--with-vte-module-path=#{Formula["z80oolong/vte/libvte@2.91"].opt_prefix}"

    system "./configure", *args
    system "make"
    system "make", "install"

    resource("geany-plugins").stage do
      system "patch -p1 < #{buildpath}/geany-plugins.diff"
      if build.head?
        system "sh", "./autogen.sh"
      else
        inreplace "./git-changebar/src/gcb-plugin.c", /\*bool/, "*boolean"
      end
      inreplace "./configure", "webkit2gtk-4.0", "webkit2gtk-4.1"

      args  = std_configure_args
      args << "--enable-markdown"
      args << "--disable-devhelp"
      args << "--disable-geanylua"
      args << "--with-geany-libdir=#{lib}"

      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/geany", "--version"
  end
end
