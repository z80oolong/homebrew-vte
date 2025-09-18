class Gtkx3AT32443 < Formula
  desc "Toolkit for creating graphical user interfaces"
  homepage "https://gtk.org/"
  url "https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.43.tar.xz"
  sha256 "7e04f0648515034b806b74ae5d774d87cffb1a2a96c468cb5be476d51bf2f3c7"
  license "LGPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/gtk\+[._-](3\.([0-8]\d*?)?[02468](?:\.\d+)*?)\.t/i)
  end

  keg_only :versioned_formula


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "perl" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]

  depends_on "at-spi2-core"
  depends_on "cairo"
  depends_on "fribidi"
  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gsettings-desktop-schemas"
  depends_on "harfbuzz"
  depends_on "hicolor-icon-theme"
  depends_on "libepoxy"
  depends_on "pango"

  uses_from_macos "libxslt" => :build # for xsltproc

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "cmake" => :build

    depends_on "fontconfig"
    depends_on "iso-codes"
    depends_on "libx11"
    depends_on "libxau"
    depends_on "libxcb"
    depends_on "libxdamage"
    depends_on "libxext"
    depends_on "libxfixes"
    depends_on "libxi"
    depends_on "libxinerama"
    depends_on "libxkbcommon"
    depends_on "libxrandr"
    depends_on "wayland"
    depends_on "wayland-protocols"
    depends_on "xorgproto"
  end

  resource("fcitx5-gclient") do
    url "https://github.com/fcitx/fcitx5-gtk/archive/refs/tags/5.1.4.tar.gz"
    sha256 "73f63d10078c62e5b6d82e6b16fcb03d2038cc204fc00052a34ab7962b0b7815"
  end

  resource("scim-frontend-gtk3") do
    url "https://github.com/scim-im/scim/archive/refs/tags/1.4.18.tar.gz"
    sha256 "072d79dc3c7277b8e8fcb1caf1a83225c3bf113d590f314b85ae38024427a228"

    patch :p1 do
      url "https://mirrors.sjtug.sjtu.edu.cn/gentoo/app-i18n/scim/files/scim-1.4.18-fix-for-gcc15.patch"
      sha256 "1db8d4acc686895b5d3123e172fdf6a7542ae8f160d94399982fca770e6d6bf1"
    end
  end

  def install
    ENV.append "LDFLAGS", "-ldl"
    ENV.append "CXXFLAGS", "-fpermissive"

    args = %w[
      -Dgtk_doc=false
      -Dman=true
      -Dintrospection=true
    ]

    if OS.mac?
      args << "-Dquartz_backend=true"
      args << "-Dx11_backend=false"
    end

    # ensure that we don't run the meson post install script
    ENV["DESTDIR"] = "/"

    # Find our docbook catalog
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    resource("fcitx5-gclient").stage do
      ENV["LC_ALL"] = "C"
      ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"

      args  = std_cmake_args.dup
      args.map! { |arg| arg.match?(/^-DCMAKE_INSTALL_PREFIX/) ? "-DCMAKE_INSTALL_PREFIX=#{libexec}/fcitx5" : arg }
      args.map! { |arg| arg.match?(/^-DCMAKE_INSTALL_LIBDIR/) ? "-DCMAKE_INSTALL_LIBDIR=#{libexec}/fcitx5/lib" : arg }
      args << "-DENABLE_GIR=OFF"
      args << "-DENABLE_GTK2_IM_MODULE=OFF"
      args << "-DENABLE_GTK3_IM_MODULE=ON"
      args << "-DENABLE_GTK4_IM_MODULE=OFF"
      args << "-DENABLE_SNOOPER=OFF"
      args << "-DGTK3_IM_MODULEDIR=#{lib}/gtk-3.0/3.0.0/immodules"

      # Using std::free may cause a compile error.
      inreplace "./gtk3/utils.h", /std::free/, "free"

      system "cmake", "-S", ".", "-B", "build", *args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
    end

    resource("scim-frontend-gtk3").stage do
      ENV["LC_ALL"] = "C"
      ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"

      system "./bootstrap"

      args  = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/scim" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/scim/lib" : arg }
      args << "--enable-silent-rules"
      args << "--enable-shared"
      args << "--disable-static"
      args << "--disable-tests"
      args << "--disable-documents"
      args << "--disable-config-simple"
      args << "--disable-config-socket"
      args << "--disable-frontend-x11"
      args << "--disable-frontend-socket"
      args << "--disable-im-rawcode"
      args << "--disable-im-socket"
      args << "--disable-orig-gtk2-immodule"
      args << "--disable-orig-gtk3-immodule"
      args << "--disable-gtk2-immodule"
      args << "--enable-gtk3-immodule"
      args << "--with-gtk3-im-module-dir=#{lib}/gtk-3.0/3.0.0/immodules"
      args << "--disable-qt3-immodule"
      args << "--disable-qt4-immodule"
      args << "--disable-clutter-immodule"
      args << "--disable-panel-gtk"
      args << "--disable-setup-ui"
      args << "--with-x"
      args << "--without-doxygen"
      args << "--with-gtk-version=3"

      system "./configure", *args
      system "make"
      system "make", "install"
    end

    bin.install_symlink bin/"gtk-update-icon-cache" => "gtk3-update-icon-cache"
    man1.install_symlink man1/"gtk-update-icon-cache.1" => "gtk3-update-icon-cache.1"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", share/"glib-2.0/schemas"
    system bin/"gtk3-update-icon-cache", "-f", "-t", share/"icons/hicolor"
    system bin/"gtk-query-immodules-3.0 > #{lib}/gtk-3.0/3.0.0/immodules.cache"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gtk/gtk.h>

      int main(int argc, char *argv[]) {
        gtk_disable_setlocale();
        return 0;
      }
    EOS

    flags = shell_output("pkg-config --cflags --libs gtk+-3.0").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
    # include a version check for the pkg-config files
    assert_match version.to_s, shell_output("cat #{lib}/pkgconfig/gtk+-3.0.pc").strip
  end
end
