class LxterminalAT9999Dev < Formula
  desc "Desktop-independent VTE-based terminal emulator"
  homepage "https://wiki.lxde.org/en/LXTerminal"

  CURRENT_COMMIT = "ac5e36f496b2bf95eae790181e65c9eb54bb9c13".freeze
  url "https://github.com/lxde/lxterminal.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  revision 2

  keg_only "this is an alternate version of another formula"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "intltool" => :build
  depends_on "libxml2" => :build
  depends_on "libxslt" => :build
  depends_on "perl" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "vte3"

  patch :p1 do
    file "Patches/lxterminal/lxterminal-HEAD-#{CURRENT_COMMIT[0..7]}-fix.diff"
    type :unofficial
  end

  def install
    ENV.prepend_path "PERL5LIB", "#{Formula["perl-xml-parser"].opt_libexec}/lib/perl5"
    ENV["LC_ALL"] = "C"

    inreplace "man/Makefile.am" do |s|
      s.gsub! %r{http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl},
        "#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl-ns/manpages/docbook.xsl"
    end

    args  = std_configure_args
    args << "--enable-gtk3"
    args << "--enable-man"

    system "sh", "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `lxterminal` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  test do
    ENV["LC_ALL"] = "ja_JP.UTF-8"
    output = shell_output("#{bin}/lxterminal --version").strip
    assert_equal "lxterminal 0.4.1", output
  end
end
