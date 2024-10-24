class LibvteAT291 < Formula
  desc "VTE provides a virtual terminal widget for GTK applications."
  homepage "https://gitlab.gnome.org/GNOME/vte"
  license "CC-BY-4.0 GPL-3.0 LGPL-3.0"

  stable do
    url "https://github.com/GNOME/vte/archive/refs/tags/0.76.2.tar.gz"
    sha256 "70a38449fda947e5cb7b4cecbe8a7a77586c799168bfb22162708c94084f21ae"
  end

  head do
    url "https://github.com/GNOME/vte.git"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "vala"  => :build
  depends_on "glibc"
  depends_on "cairo"
  depends_on "gtk+3"
  depends_on "gtk+4"
  depends_on "gnutls"
  depends_on "systemd"
  depends_on "icu4c"
  depends_on "libsixel"
  depends_on "gobject-introspection"

  keg_only :versioned_formula

  def install
#    inreplace "src/vtedefines.hh" do |s|
#      s.gsub!(%r|^#define VTE_SIXEL_ENABLED_DEFAULT false|, "#define VTE_SIXEL_ENABLED_DEFAULT true")
#    end

    ENV.append "LDFLAGS", "-ldl -lm"
#    system "meson", "setup", "build", "-Dsixel=true", "-Ddebug=true", *std_meson_args
    system "meson", "setup", "build", "-Ddebug=true", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "false"
  end
end
