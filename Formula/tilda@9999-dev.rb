class TildaAT9999Dev < Formula
  desc "Gtk-based drop down terminal for Linux and Unix"
  homepage "https://github.com/lanoxx/tilda"

  CURRENT_COMMIT = "b6a2ca205a958f09632599655b97e3d81a58ee2b".freeze
  url "https://github.com/lanoxx/tilda.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  license "LGPL-3.0-or-later"
  revision 2

  keg_only "this is an alternate version of another formula"

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

  patch :p1 do
    file "Patches/tilda/tilda-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
    type :unofficial
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
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `tilda` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  test do
    ENV["LC_ALL"] = "C"
    output = shell_output("#{bin}/tilda --version")
    assert_match Regexp.new("Tilda 1.6-alpha", Regexp::MULTILINE), output
  end
end
