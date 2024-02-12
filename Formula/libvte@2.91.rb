class LibvteAT291 < Formula
  desc "VTE provides a virtual terminal widget for GTK applications."
  homepage "https://gitlab.gnome.org/GNOME/vte"
  license "CC-BY-4.0 GPL-3.0 LGPL-3.0"

  stable do
    url "https://github.com/GNOME/vte/archive/refs/tags/0.75.0.tar.gz"
    sha256 "3a12c6ddd2431a78ae69fc9f451a0b1b179e7577ec2cdb5ad17993b83a609a53"
  end

  head do
    url "https://github.com/GNOME/vte.git"
  end

  depends_on "gtk+3"
  depends_on "gtk+4"
  depends_on "gnutls"
  depends_on "systemd"
  depends_on "icu4c"
  depends_on "gobject-introspection"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "vala"  => :build

  keg_only :versioned_formula

  def install
    inreplace "src/vtedefines.hh" do |s|
      s.gsub!(%r|^#define VTE_SIXEL_ENABLED_DEFAULT false|, "#define VTE_SIXEL_ENABLED_DEFAULT true")
    end

    system "meson", "setup", "build", "-Ddebug=true", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "false"
  end
end
