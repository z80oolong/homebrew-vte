class MateTerminalAT1270 < Formula
  desc "Terminal emulator for the MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-terminal"
  url "https://github.com/mate-desktop/mate-terminal/releases/download/v1.27.0/mate-terminal-1.27.0.tar.xz"
  sha256 "42889c98045f011b7e633c2c1706dfc379d52c9c26aef386c8d6890c09d3681b"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "itstool" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build
  depends_on "yelp-tools" => :build
  depends_on "z80oolong/dep/autoconf-archive@2023" => :build
  depends_on "z80oolong/dep/mate-common@1.28.0" => :build
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "intltool"
  depends_on "z80oolong/dep/dconf@0"
  depends_on "z80oolong/dep/mate-desktop@1.27.1"
  depends_on "z80oolong/vte/libvte@2.91"

  patch :p1, :DATA

  def install
    aclocal_flags =  ""
    aclocal_flags << " -I #{Formula["z80oolong/dep/autoconf-archive@2023"].opt_share}/aclocal"
    aclocal_flags << " -I #{Formula["z80oolong/dep/mate-common@1.28.0"].opt_share}/aclocal"
    ENV["ACLOCAL_FLAGS"] = aclocal_flags
    ENV["LC_ALL"] = "C"

    args  = std_configure_args
    args << "--disable-schemas-compile"
    args << "--prefix=#{prefix}"
    args << "--bindir=#{libexec}/bin"

    system "sh", "./autogen.sh", *args
    system "make"
    system "make", "install"

    script  = "#!/bin/sh\n"
    script << 'export GSETTINGS_SCHEMA_DIR="'
    script << "#{Formula["z80oolong/dep/mate-desktop@1.27.1"].opt_share}/glib-2.0/schemas:"
    script << "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas:"
    script << '${GSETTINGS_SCHEMA_DIR}"'
    script << "\n"
    script << 'export XDG_DATA_DIRS="'
    script << "#{Formula["z80oolong/dep/mate-desktop@1.27.1"].opt_share}:"
    script << "#{HOMEBREW_PREFIX}/share:"
    script << '${XDG_DATA_DIRS}"'
    script << "\n"
    script << "exec #{libexec}/bin/mate-terminal $@\n"

    ohai "Create #{bin}/mate-terminal script."
    (bin/"mate-terminal").write(script)
    (bin/"mate-terminal").chmod(0755)
  end

  def post_install
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
  end

  def diff_data
    lines = path.each_line.with_object([]) do |line, result|
      result.push(line) if /^__END__/.match?(line) || result.first
    end
    lines.shift
    lines.join
  end

  test do
    system bin/"mate-terminal", "--version"
  end
end

__END__
diff --git a/src/terminal-window.c b/src/terminal-window.c
index aa5288f..42eeb25 100644
--- a/src/terminal-window.c
+++ b/src/terminal-window.c
@@ -917,6 +917,24 @@ terminal_set_encoding_callback (GtkToggleAction *action,
 {
     TerminalWindowPrivate *priv = window->priv;
     TerminalEncoding *encoding;
+#ifndef NO_UTF8_CJK
+    gchar *vte_cjk_width = NULL;
+
+    if (priv->active_screen == NULL)
+        return;
+
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(priv->active_screen)) != 2) {
+            vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(priv->active_screen), 2);
+        }
+    }
+
+    G_GNUC_BEGIN_IGNORE_DEPRECATIONS;
+    if (!gtk_toggle_action_get_active (action))
+        return;
+    G_GNUC_END_IGNORE_DEPRECATIONS;
+#else
 
     G_GNUC_BEGIN_IGNORE_DEPRECATIONS;
     if (!gtk_toggle_action_get_active (action))
@@ -926,6 +944,7 @@ terminal_set_encoding_callback (GtkToggleAction *action,
     if (priv->active_screen == NULL)
         return;
 
+#endif
     encoding = g_object_get_data (G_OBJECT (action), ENCODING_DATA_KEY);
     g_assert (encoding);
