class GnomeTerminal < Formula
  desc "GNOME common terminal Emulator"
  homepage "https://gitlab.gnome.org/GNOME/gnome-terminal"
  url "https://github.com/GNOME/gnome-terminal/archive/refs/tags/3.54.2.tar.gz"
  sha256 "101e69d2c4abec2789e01605588d09e43d8a65fdf327e13b74d78773c71f55b5"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "itstool" => :build
  depends_on "libxslt" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gsettings-desktop-schemas"
  depends_on "gtk+3"
  depends_on "libhandy"
  depends_on "z80oolong/dep/dconf@0"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    inreplace(buildpath/"data/org.gnome.Terminal.desktop.in") do |s|
      s.gsub!(/^SingleMainWindow=false/, "X-SingleMainWindow=false")
    end

    inreplace(buildpath/"data/org.gnome.Terminal.Preferences.desktop.in") do |s|
      s.gsub!(/^SingleMainWindow=true/, "X-SingleMainWindow=true")
    end

    args  = std_meson_args
    args << "--bindir=#{libexec}/bin"
    args << "-Dnautilus_extension=false"

    system "meson", "setup", "build", *args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    (pkgshare/"glib-2.0").mkpath
    (pkgshare/"glib-2.0").install share/"glib-2.0/schemas"

    ohai "Create #{bin}/gnome-terminal script."
    (bin/"gnome-terminal").write(wrapper_script)
    (bin/"gnome-terminal").chmod(0755)
  end

  def post_install
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
  end

  def gschema_dirs
    dirs = [share]
    dirs << (HOMEBREW_PREFIX/"share")
    dirs << "/usr/local/share"
    dirs << "/usr/share"
    dirs << "${GSETTINGS_SCHEMA_DIR}"
    dirs
  end
  private :gschema_dirs

  def xdg_data_dirs
    dirs = [share]
    dirs << (HOMEBREW_PREFIX/"share")
    dirs << "/usr/local/share"
    dirs << "/usr/share"
    dirs << "${XDG_DATA_DIRS}"
    dirs
  end
  private :xdg_data_dirs

  def wrapper_script
    <<~EOS
      #!/bin/sh
      export GSETTINGS_SCHEMA_DIR="#{gschema_dirs.join(":")}"
      export XDG_DATA_DIRS="#{xdg_data_dirs.join(":")}"
      #{libexec}/gnome-terminal-server 2>&1 &
      sleep 1
      exec #{libexec}/bin/gnome-terminal $@
    EOS
  end
  private :wrapper_script

  test do
    system bin/"gnome-terminal", "--version"
  end
end
