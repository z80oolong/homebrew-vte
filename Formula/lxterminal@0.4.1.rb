class LxterminalAT041 < Formula
  desc "Desktop-independent VTE-based terminal emulator"
  homepage "https://wiki.lxde.org/en/LXTerminal"
  url "https://github.com/lxde/lxterminal/archive/refs/tags/0.4.1.tar.gz"
  sha256 "d5da0646e20ad2be44ef69a9d620be5f1ec43b156dc585ebe203dd7b05c31d88"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "intltool" => :build
  depends_on "libxml2" => :build
  depends_on "libxslt" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "z80oolong/vte/libvte@2.91"

  patch :p1, :DATA

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

  def diff_data
    lines = path.each_line.with_object([]) do |line, result|
      result.push(line) if /^__END__/.match?(line) || result.first
    end
    lines.shift
    lines.join
  end

  test do
    system bin/"lxterminal", "--version"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 638f8fb..171522d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -95,11 +95,11 @@ if test x"$enable_man" = x"yes"; then
 		AC_MSG_ERROR([xsltproc is required to regenerate the pre-built man page; consider --disable-man])
 	fi
 
-	dnl check for DocBook DTD and stylesheets in the local catalog.
-	JH_CHECK_XML_CATALOG([-//OASIS//DTD DocBook XML V4.1.2//EN],
-		[DocBook XML DTD V4.1.2], [], AC_MSG_ERROR([DocBook XML DTD is required to regenerate the pre-built man page; consider --disable-man]))
-	JH_CHECK_XML_CATALOG([http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl],
-		[DocBook XSL Stylesheets >= 1.70.1], [], AC_MSG_ERROR([DocBook XSL Stylesheets are required to regenerate the pre-built man page; consider --disable-man]))
+	#dnl check for DocBook DTD and stylesheets in the local catalog.
+	#JH_CHECK_XML_CATALOG([-//OASIS//DTD DocBook XML V4.1.2//EN],
+	#	[DocBook XML DTD V4.1.2], [], AC_MSG_ERROR([DocBook XML DTD is required to regenerate the pre-built man page; consider --disable-man]))
+	#JH_CHECK_XML_CATALOG([http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl],
+	#	[DocBook XSL Stylesheets >= 1.70.1], [], AC_MSG_ERROR([DocBook XSL Stylesheets are required to regenerate the pre-built man page; consider --disable-man]))
 
 	rm -f $srcdir/man/lxterminal.1
 fi
diff --git a/src/lxterminal.c b/src/lxterminal.c
index 5148b75..6b0611a 100644
--- a/src/lxterminal.c
+++ b/src/lxterminal.c
@@ -1185,6 +1185,10 @@ static Term * terminal_new(LXTerminal * terminal, const gchar * label, const gch
     /* Create and initialize Term structure for new terminal. */
     Term * term = g_slice_new0(Term);
     term->parent = terminal;
+#ifndef NO_UTF8_CJK
+    /* Value of environment variable 'VTE_CJK_WIDTH'. */
+    gchar *vte_cjk_width = NULL;
+#endif
 
     /* Create a VTE and a vertical scrollbar, and place them inside a horizontal box. */
     term->vte = vte_terminal_new();
@@ -1225,6 +1229,14 @@ static Term * terminal_new(LXTerminal * terminal, const gchar * label, const gch
 #endif
     vte_terminal_set_backspace_binding(VTE_TERMINAL(term->vte), VTE_ERASE_ASCII_DELETE);
     vte_terminal_set_delete_binding(VTE_TERMINAL(term->vte), VTE_ERASE_DELETE_SEQUENCE);
+#ifndef NO_UTF8_CJK
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(term->vte)) != 2) {
+            vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(term->vte), 2);
+        }
+    }
+#endif
 
     /* steal from tilda-0.09.6/src/tilda_terminal.c:145 */
     /* Match URL's, etc. */
@@ -1235,8 +1247,10 @@ static Term * terminal_new(LXTerminal * terminal, const gchar * label, const gch
     vte_terminal_match_set_cursor_name(VTE_TERMINAL(term->vte), ret, "pointer");
     ret = vte_terminal_match_add_regex(VTE_TERMINAL(term->vte), dingus2, 0);
     vte_terminal_match_set_cursor_name(VTE_TERMINAL(term->vte), ret, "pointer");
+#ifndef NO_FIX_G_REGEX
     vte_regex_unref(dingus1);
     vte_regex_unref(dingus2);
+#endif
 #else
     GRegex * dingus1 = g_regex_new(DINGUS1, G_REGEX_OPTIMIZE, 0, NULL);
     GRegex * dingus2 = g_regex_new(DINGUS2, G_REGEX_OPTIMIZE, 0, NULL);
@@ -1244,8 +1258,10 @@ static Term * terminal_new(LXTerminal * terminal, const gchar * label, const gch
     vte_terminal_match_set_cursor_name(VTE_TERMINAL(term->vte), ret, "pointer");
     ret = vte_terminal_match_add_gregex(VTE_TERMINAL(term->vte), dingus2, 0);
     vte_terminal_match_set_cursor_name(VTE_TERMINAL(term->vte), ret, "pointer");
+#ifndef NO_FIX_G_REGEX
     g_regex_unref(dingus1);
     g_regex_unref(dingus2);
+#endif
 #endif
 
     /* Create a horizontal box inside an event box as the toplevel for the tab label. */
