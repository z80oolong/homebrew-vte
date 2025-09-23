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

class Lxterminal < Formula
  desc "Desktop-independent VTE-based terminal emulator"
  homepage "https://wiki.lxde.org/en/LXTerminal"

  stable do
    url "https://github.com/lxde/lxterminal/archive/refs/tags/0.4.1.tar.gz"
    sha256 "d5da0646e20ad2be44ef69a9d620be5f1ec43b156dc585ebe203dd7b05c31d88"

    patch :p1, Formula["z80oolong/vte/lxterminal@0.4.1"].diff_data
  end

  head do
    url "https://github.com/lxde/lxterminal.git"

    patch :p1, Formula["z80oolong/vte/lxterminal@0.5.99-dev"].diff_data
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "intltool" => :build
  depends_on "libxml2" => :build
  depends_on "libxslt" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"
    ENV.prepend_path "PERL5LIB", "#{Formula["perl-xml-parser"].opt_libexec}/lib/perl5"
    ENV["LC_ALL"] = "C"

    inreplace "man/Makefile.am" do |s|
      s.gsub! %r{http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl},
        "#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl-ns/manpages/docbook.xsl"
    end

    system "sh", "./autogen.sh"

    args  = std_configure_args
    args << "--enable-gtk3"
    args << "--enable-man"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"lxterminal", "--version"
  end
end
