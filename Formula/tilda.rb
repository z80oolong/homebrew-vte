class Tilda < Formula
  desc "Gtk-based drop down terminal for Linux and Unix"
  homepage "https://github.com/lanoxx/tilda"
  license "GPL-2.0-or-later"
  revision 2

  CURRENT_VERSION = "2.0.0".freeze
  CURRENT_COMMIT  = "b6a2ca205a958f09632599655b97e3d81a58ee2b".freeze

  stable do
    url "https://github.com/lanoxx/tilda/archive/refs/tags/tilda-#{CURRENT_VERSION}.tar.gz"
    sha256 "ff9364244c58507cd4073ac22e580a4cded048d416c682496c1b1788ee8a30df"

    patch :p1 do
      file "Patches/tilda/tilda-#{CURRENT_VERSION}-fix.diff"
      type :unofficial
    end
  end

  head do
    url "https://github.com/lanoxx/tilda.git"

    patch :p1 do
      file "Patches/tilda/tilda-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
      type :unofficial
    end
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "perl" => :build
  depends_on "pkgconf" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "vte3"

  resource("libconfuse") do
    url "https://github.com/libconfuse/libconfuse/releases/download/v3.3/confuse-3.3.tar.xz"
    sha256 "1dd50a0320e135a55025b23fcdbb3f0a81913b6d0b0a9df8cc2fdf3b3dc67010"
  end

  def install
    ENV["LC_ALL"] = "C"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"libconfuse/lib/pkgconfig"
    ENV.prepend_path "HOMEBREW_RPATH_PATHS", libexec/"libconfuse/lib"

    resource("libconfuse").stage do
      args = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/libconfuse" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/libconfuse/lib" : arg }
      args << "--disable-silent-rules"

      system "./configure", *args
      system "make"
      system "make", "install"
    end

    system "sh", "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args.dup
    system "make"
    system "make", "install"
  end

  test do
    ENV["LC_ALL"] = "C"
    ver = build.head? ? "1.6-alpha" : version
    output = shell_output("#{bin}/tilda --version")
    assert_match Regexp.new("Tilda #{ver}", Regexp::MULTILINE), output
  end
end
