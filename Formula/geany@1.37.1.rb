class GeanyAT1371 < Formula
  desc "Fast and lightweight IDE"
  homepage "https://www.geany.org/"
  url "https://download.geany.org/geany-1.37.1.tar.gz"
  sha256 "3978148c57570df8ed817afe050bc038f1b4dd39dc8efeb0acb19cd4f0690a58"

  resource("geany-plugins") do
    url "https://github.com/geany/geany-plugins/archive/refs/tags/1.37.0.tar.gz"
    sha256 "14df1dda3760eedd3a28daba0788f3bee5b83ae31f042c57a78c20f37a77eb28"
  end

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "docutils" => :build
  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "hicolor-icon-theme"
  depends_on "z80oolong/vte/libvte@2.91"
  depends_on "ctags"
  depends_on "pcre"
  depends_on "libsoup"
  depends_on "enchant"
  depends_on "libvterm"
  depends_on "gnupg"
  depends_on "gpgme"
  depends_on "libsoup@2"
  depends_on "z80oolong/dep/libgit2@1.3.2"
  depends_on "webkitgtk"
  depends_on "lua@5.1"
  depends_on "source-highlight"
  depends_on "z80oolong/dep/scintilla@5.3.4"
  depends_on "z80oolong/dep/ctpl@0.3.4"

  patch :p1, :DATA

  def install
    ENV.append "CFLAGS", %[-DNO_USE_HOMEBREW_GEANY_PLUGINS]
    ENV.prepend_path "PERL5LIB", "#{Formula["perl-xml-parser"].opt_libexec}/lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", "#{prefix}/lib/pkgconfig"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-silent-rules
      --enable-gtk3
      --enable-vte
      --enable-enchant
      --enable-lua
      --enable-plugins
      --with-libvterm=#{Formula["libvterm"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"

    resource("geany-plugins").stage do
      system "cp", "-v", "#{buildpath}/geany-plugins.diff", "./geany-plugins.diff"
      system "patch -p1 < ./geany-plugins.diff"

      system "sh", "./autogen.sh"
      inreplace "./configure", "webkit2gtk-4.0", "webkit2gtk-4.1"

      args = %W[
        --disable-dependency-tracking
        --prefix=#{prefix}
        --enable-markdown
        --disable-devhelp
        --with-geany-libdir=#{lib}
      ]

      system "./configure", *args
      system "make", "install"
    end
  end

  def diff_data
    lines = self.path.each_line.inject([]) do |result, line|
      result.push(line) if ((/^__END__/ === line) || result.first)
      result
    end
    lines.shift
    return lines.join("")
  end

  test do
    system "#{bin}/geany", "--version"
  end
end

__END__
diff --git a/geany-plugins.diff b/geany-plugins.diff
new file mode 100644
index 000000000..7c99f3796
--- /dev/null
+++ b/geany-plugins.diff
@@ -0,0 +1,74 @@
+diff --git a/debugger/src/debug.c b/debugger/src/debug.c
+index 6a019c5..5498edb 100644
+--- a/debugger/src/debug.c
++++ b/debugger/src/debug.c
+@@ -1000,6 +1000,9 @@ void debug_init(void)
+ 	gchar *configfile;
+ 	gchar *font;
+ 	GtkTextBuffer *buffer;
++#ifndef NO_UTF8_CJK
++	gchar *vte_cjk_width = NULL;
++#endif
+ 
+ #if GTK_CHECK_VERSION(3, 0, 0)
+ 	VtePty *pty;
+@@ -1053,6 +1056,15 @@ void debug_init(void)
+ 	vte_terminal_set_pty(VTE_TERMINAL(terminal), pty_master);
+ 	scrollbar = gtk_vscrollbar_new(GTK_ADJUSTMENT(VTE_TERMINAL(terminal)->adjustment));
+ #endif
++
++#ifndef NO_UTF8_CJK
++	vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
++	if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
++		if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(terminal)) != 2) {
++		vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(terminal), 2);
++		}
++	}
++#endif
+ 	gtk_widget_set_can_focus(GTK_WIDGET(scrollbar), FALSE);
+ 	tab_terminal = gtk_frame_new(NULL);
+ 	gtk_frame_set_shadow_type (GTK_FRAME(tab_terminal), GTK_SHADOW_NONE);
+diff --git a/scope/src/conterm.c b/scope/src/conterm.c
+index b9f6a38..9ef76ec 100644
+--- a/scope/src/conterm.c
++++ b/scope/src/conterm.c
+@@ -472,6 +472,9 @@ void conterm_init(void)
+ 	int pty_master;
+ 	char *pty_name;
+ #endif
++#ifndef NO_UTF8_CJK
++	char *vte_cjk_width = NULL;
++#endif
+ 
+ 	conterm_load_config();
+ #ifdef G_OS_UNIX
+@@ -487,6 +490,14 @@ void conterm_init(void)
+ 		NULL);
+ 	terminal_window = get_widget("terminal_window");
+ 	terminal_show = GTK_CHECK_MENU_ITEM(get_widget("terminal_show"));
++#ifndef NO_UTF8_CJK
++	vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
++	if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
++		if (vte_terminal_get_cjk_ambiguous_width(program_terminal) != 2) {
++			vte_terminal_set_cjk_ambiguous_width(program_terminal, 2);
++		}
++	}
++#endif
+ 
+ 	if (pref_terminal_padding)
+ 	{
+@@ -567,6 +578,14 @@ void conterm_init(void)
+ 		console = vte_terminal_new();
+ 		gtk_widget_show(console);
+ 		debug_console = VTE_TERMINAL(console);
++#ifndef NO_UTF8_CJK
++		vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
++		if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
++			if (vte_terminal_get_cjk_ambiguous_width(debug_console) != 2) {
++				vte_terminal_set_cjk_ambiguous_width(debug_console, 2);
++			}
++		}
++#endif
+ 		dc_output = console_output;
+ 		dc_output_nl = console_output_nl;
+ 		g_signal_connect_after(debug_console, "realize", G_CALLBACK(on_vte_realize), NULL);
diff --git a/src/plugins.c b/src/plugins.c
index 52c847f08..4e0fb319d 100644
--- a/src/plugins.c
+++ b/src/plugins.c
@@ -1193,11 +1193,20 @@ static gint cmp_plugin_by_proxy(gconstpointer a, gconstpointer b)
 	}
 }
 
+#ifndef NO_USE_HOMEBREW_GEANY_PLUGINS
+#ifndef DEFAULT_HOMEBREW_PATH
+#define DEFAULT_HOMEBREW_PATH "/home/linuxbrew/.linuxbrew"
+#endif
+#endif
 
 /* Load (but don't initialize) all plugins for the Plugin Manager dialog */
 static void load_all_plugins(void)
 {
 	gchar *plugin_path_config;
+#ifndef NO_USE_HOMEBREW_GEANY_PLUGINS
+	gchar *homebrew_prefix;
+	gchar *plugin_path_homebrew;
+#endif
 	gchar *plugin_path_system;
 	gchar *plugin_path_custom;
 
@@ -1214,6 +1223,15 @@ static void load_all_plugins(void)
 		load_plugins_from_path(plugin_path_custom);
 		g_free(plugin_path_custom);
 	}
+#ifndef NO_USE_HOMEBREW_GEANY_PLUGINS
+	homebrew_prefix = g_getenv("HOMEBREW_PREFIX");
+	if (homebrew_prefix == NULL)
+		homebrew_prefix = DEFAULT_HOMEBREW_PATH;
+	plugin_path_homebrew = g_build_filename(homebrew_prefix, "lib", "geany", NULL);
+	/* load plugins from $HOMEBREW_PREFIX/lib/geany */
+	load_plugins_from_path(plugin_path_homebrew);
+	g_free(plugin_path_homebrew);
+#endif
 
 	/* finally load plugins from $prefix/lib/geany */
 	load_plugins_from_path(plugin_path_system);
diff --git a/src/vte.c b/src/vte.c
index 612a6e0c5..3f0b90881 100644
--- a/src/vte.c
+++ b/src/vte.c
@@ -138,6 +138,10 @@ struct VteFunctions
 	void (*vte_terminal_set_color_bold_rgba) (VteTerminal *terminal, const GdkRGBA *foreground);
 	void (*vte_terminal_set_color_background_rgba) (VteTerminal *terminal, const GdkRGBA *background);
 #endif
+#ifndef NO_UTF8_CJK
+	void (*vte_terminal_set_cjk_ambiguous_width) (VteTerminal *terminal, int width);
+	int  (*vte_terminal_get_cjk_ambiguous_width) (VteTerminal *terminal);
+#endif
 };
 
 
@@ -348,6 +352,9 @@ static gboolean vte_start_idle(G_GNUC_UNUSED gpointer user_data)
 static void create_vte(void)
 {
 	GtkWidget *vte, *scrollbar, *hbox;
+#ifndef NO_UTF8_CJK
+	char *vte_cjk_width = NULL;
+#endif
 
 	vc->vte = vte = vf->vte_terminal_new();
 	scrollbar = gtk_vscrollbar_new(vf->vte_terminal_get_adjustment(VTE_TERMINAL(vte)));
@@ -391,6 +398,14 @@ static void create_vte(void)
 	gtk_notebook_insert_page(GTK_NOTEBOOK(msgwindow.notebook), hbox, terminal_label, MSG_VTE);
 
 	g_signal_connect_after(vte, "realize", G_CALLBACK(on_vte_realize), NULL);
+#ifndef NO_UTF8_CJK
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vf->vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(vte)) != 2) {
+            vf->vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(vte), 2);
+        }
+    }
+#endif
 }
 
 
@@ -642,6 +657,10 @@ static gboolean vte_register_symbols(GModule *mod)
 	if (! BIND_SYMBOL(vte_terminal_get_adjustment))
 		/* vte_terminal_get_adjustment() is available since 0.9 and removed in 0.38 */
 		vf->vte_terminal_get_adjustment = default_vte_terminal_get_adjustment;
+#ifndef NO_UTF8_CJK
+	BIND_REQUIRED_SYMBOL(vte_terminal_set_cjk_ambiguous_width);
+	BIND_REQUIRED_SYMBOL(vte_terminal_get_cjk_ambiguous_width);
+#endif
 
 	#undef BIND_REQUIRED_SYMBOL_RGBA_WRAPPED
 	#undef BIND_REQUIRED_SYMBOL
