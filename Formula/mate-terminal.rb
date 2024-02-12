class MateTerminal < Formula
  desc "Terminal emulator for the MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-terminal"

  stable do
    url "https://github.com/mate-desktop/mate-terminal/releases/download/v1.27.1/mate-terminal-1.27.1.tar.xz"
    sha256 "8d6b16ff2cac930afce4625b1b8f30c055e314e5b3dae806ac5b80c809f08dbe"
    patch :p1, Formula["z80oolong/vte/mate-terminal@1.27.1"].diff_data
  end

  head do
    url "https://github.com/mate-desktop/mate-terminal.git"
    patch :p1, :HEAD
  end

  depends_on "pkg-config" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "yelp-tools" => :build
  depends_on "itstool" => :build
  depends_on "z80oolong/dep/autoconf-archive@2023" => :build
  depends_on "z80oolong/dep/mate-common@1.24.0" => :build
  depends_on "intltool"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gdk-pixbuf"
  depends_on "z80oolong/vte/libvte@2.91"
  depends_on "z80oolong/dep/dconf@0"
  depends_on "z80oolong/dep/mate-desktop"

  def install
    aclocal_flags =  ""
    aclocal_flags << "-I #{Formula["z80oolong/dep/autoconf-archive@2023"].opt_share}/aclocal "
    aclocal_flags << "-I #{Formula["z80oolong/dep/mate-common@1.24.0"].opt_share}/aclocal"
    ENV["ACLOCAL_FLAGS"] = aclocal_flags

    system "sh", "./autogen.sh", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "rm", "#{share}/glib-2.0/schemas/gschemas.compiled"
  end

  def post_install
    Dir.chdir("#{HOMEBREW_PREFIX}/share/glib-2.0/schemas") do
      system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "--targetdir=.", "."
    end
  end

  def caveats; <<~EOS
    When starting mate-terminal installed with this Formula, the environment variables should be set as follows.
    
      export GSETTINGS_SCHEMA_DIR="#{HOMEBREW_PREFIX}/share/glib-2.0/schemas:${GSETTINGS_SCHEMA_DIR}"
      export XDG_DATA_DIRS="#{HOMEBREW_PREFIX}/share:${XDG_DATA_DIRS}"
    EOS
  end

  test do
    system "false"
  end
end

__END__
diff --git a/src/terminal-window.c b/src/terminal-window.c
index 51468df..6cefda5 100644
--- a/src/terminal-window.c
+++ b/src/terminal-window.c
@@ -910,6 +910,24 @@ terminal_set_encoding_callback (GtkToggleAction *action,
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
@@ -919,6 +937,7 @@ terminal_set_encoding_callback (GtkToggleAction *action,
     if (priv->active_screen == NULL)
         return;
 
+#endif
     encoding = g_object_get_data (G_OBJECT (action), ENCODING_DATA_KEY);
     g_assert (encoding);
