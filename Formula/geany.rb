    url "https://download.geany.org/geany-2.0.tar.gz"
    sha256 "50d28a45ac9b9695e9529c73fe7ed149edb512093c119db109cea6424114847f"
    patch :p1, Formula["z80oolong/vte/geany@2.0"].diff_data

    resource("geany-plugins") do
      url "https://github.com/geany/geany-plugins/releases/download/2.0.0/geany-plugins-2.0.tar.bz2"
      sha256 "9fc2ec5c99a74678fb9e8cdfbd245d3e2061a448d70fd110a6aefb62dd514705"
    end
    resource("geany-plugins") do
      url "https://github.com/geany/geany-plugins.git"
    end

  depends_on "perl-xml-parser" => :build
  depends_on "gnupg"
  depends_on "gpgme"
  depends_on "libsoup@2"
  depends_on "libgit2"
  depends_on "webkitgtk"
  depends_on "lua@5.1"
  depends_on "z80oolong/dep/scintilla@5.3.4"
  depends_on "z80oolong/dep/ctpl@0.3.4"
    ENV.append "CFLAGS", %[-DNO_USE_HOMEBREW_GEANY_PLUGINS]
    ENV.prepend_path "PERL5LIB", "#{Formula["perl-xml-parser"].opt_libexec}/lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", "#{prefix}/lib/pkgconfig"


    resource("geany-plugins").stage do
      system "cp", "-v", "#{buildpath}/geany-plugins.diff", "./geany-plugins.diff"
      system "patch -p1 < ./geany-plugins.diff"

      system "sh", "./autogen.sh" if head?
      inreplace "./configure", "webkit2gtk-4.0", "webkit2gtk-4.1"

      args = %W[
        --disable-dependency-tracking
        --prefix=#{prefix}
        --enable-all-plugins
        --with-geany-libdir=#{lib}
      ]

      system "./configure", *args
      system "make", "install"
    end
diff --git a/geany-plugins.diff b/geany-plugins.diff
new file mode 100644
index 000000000..71e70eb26
--- /dev/null
+++ b/geany-plugins.diff
@@ -0,0 +1,74 @@
+diff --git a/debugger/src/debug.c b/debugger/src/debug.c
+index 23bde5c8..f5bd6ca6 100644
+--- a/debugger/src/debug.c
++++ b/debugger/src/debug.c
+@@ -1004,6 +1004,9 @@ void debug_init(void)
+ 	gchar *configfile;
+ 	gchar *font;
+ 	GtkTextBuffer *buffer;
++#ifndef NO_UTF8_CJK
++	gchar *vte_cjk_width = NULL;
++#endif
+ 
+ #if GTK_CHECK_VERSION(3, 0, 0)
+ 	VtePty *pty;
+@@ -1057,6 +1060,15 @@ void debug_init(void)
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
+index b9f6a388..9ef76ec7 100644
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
index 8545b18fa..8afe5aa93 100644
--- a/src/plugins.c
+++ b/src/plugins.c
@@ -1143,11 +1143,20 @@ static gint cmp_plugin_by_proxy(gconstpointer a, gconstpointer b)
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
 
@@ -1164,6 +1173,15 @@ static void load_all_plugins(void)
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