class GeanyAT9999Dev < Formula
  desc "Fast and lightweight IDE"
  homepage "https://www.geany.org/"

  CURRENT_COMMIT = "426e427030fe0118648efbec5e76b2b1ddca9e5c".freeze
  url "https://github.com/geany/geany.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  revision 1

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "docutils" => :build
  depends_on "gtk-doc" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "perl" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkgconf" => :build
  depends_on "ctags"
  depends_on "enchant"
  depends_on "gettext"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gnupg"
  depends_on "gpgme"
  depends_on "gtk+3"
  depends_on "hicolor-icon-theme"
  depends_on "libgit2"
  depends_on "libsoup@2"
  depends_on "libvterm"
  depends_on "pcre"
  depends_on "source-highlight"
  depends_on "vte3"
  depends_on "webkitgtk"
  depends_on "z80oolong/vte/lua@5.1"

  resource("ctpl") do
    url "https://github.com/b4n/ctpl/archive/refs/tags/v0.3.5.tar.gz"
    sha256 "ae60c79316c6dc3a2935d906b8a911ce4188e8638b6e9b65fc6c04a5ca6bcdda"
  end

  resource("geany-plugins") do
    url "https://github.com/geany/geany-plugins.git",
      branch:   "master",
      revision: "760aaf348385e32fc171cda0d16c56df3ab9319e"
  end

  patch :p1, :DATA

  def install
    ENV.append "CFLAGS", "-DNO_USE_HOMEBREW_GEANY_PLUGINS"
    ENV.prepend_path "PERL5LIB", Formula["perl-xml-parser"].opt_libexec/"lib/perl5"
    ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"ctpl/lib/pkgconfig"
    ENV["LC_ALL"] = "C"

    resource("ctpl").stage do
      args = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/ctpl" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/ctpl/lib" : arg }
      args << "--disable-silent-rules"

      system "sh", "./autogen.sh"
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    args  = std_configure_args.dup
    args << "--enable-vte"
    args << "--with-vte-module-path=#{Formula["vte3"].opt_prefix}"

    system "sh", "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"

    resource("geany-plugins").stage do
      system "sh", "./autogen.sh"
      system "patch -p1 < #{buildpath}/geany-plugins.diff"
      inreplace "./configure", "webkit2gtk-4.0", "webkit2gtk-4.1"

      args  = std_configure_args
      args << "--enable-markdown"
      args << "--disable-devhelp"
      args << "--with-lua-pkg=lua5.1"
      args << "--with-geany-libdir=#{lib}"

      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `geany` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  def diff_data
    path.readlines(nil).first.gsub(/^.*\n__END__\n/m, "")
  end

  test do
    output = shell_output("#{bin}/geany --version").strip
    assert_match Regexp.new("^geany 2.2.0 \\(git >= [0-9a-f]{9}\\)"), output
  end
end

__END__
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
index 6625ce45c..a3918d0fe 100644
--- a/src/plugins.c
+++ b/src/plugins.c
@@ -1142,11 +1142,20 @@ static gint cmp_plugin_by_proxy(gconstpointer a, gconstpointer b)
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
 
@@ -1163,6 +1172,15 @@ static void load_all_plugins(void)
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
index 1fde0d749..c5c9e0a70 100644
--- a/src/vte.c
+++ b/src/vte.c
@@ -135,6 +135,10 @@ struct VteFunctions
 	void (*vte_terminal_set_color_foreground_rgba) (VteTerminal *terminal, const GdkRGBA *foreground);
 	void (*vte_terminal_set_color_bold_rgba) (VteTerminal *terminal, const GdkRGBA *foreground);
 	void (*vte_terminal_set_color_background_rgba) (VteTerminal *terminal, const GdkRGBA *background);
+#ifndef NO_UTF8_CJK
+	void (*vte_terminal_set_cjk_ambiguous_width) (VteTerminal *terminal, int width);
+	int  (*vte_terminal_get_cjk_ambiguous_width) (VteTerminal *terminal);
+#endif
 };
 
 
@@ -335,6 +339,9 @@ static gboolean vte_start_idle(G_GNUC_UNUSED gpointer user_data)
 static void create_vte(void)
 {
 	GtkWidget *vte, *scrollbar, *hbox;
+#ifndef NO_UTF8_CJK
+	char *vte_cjk_width = NULL;
+#endif
 
 	vte_config.vte = vte = vf->vte_terminal_new();
 	scrollbar = gtk_scrollbar_new(GTK_ORIENTATION_VERTICAL, vf->vte_terminal_get_adjustment(VTE_TERMINAL(vte)));
@@ -378,6 +385,14 @@ static void create_vte(void)
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
 
 
@@ -624,6 +639,10 @@ static gboolean vte_register_symbols(GModule *mod)
 	if (! BIND_SYMBOL(vte_terminal_get_adjustment))
 		/* vte_terminal_get_adjustment() is available since 0.9 and removed in 0.38 */
 		vf->vte_terminal_get_adjustment = default_vte_terminal_get_adjustment;
+#ifndef NO_UTF8_CJK
+	BIND_REQUIRED_SYMBOL(vte_terminal_set_cjk_ambiguous_width);
+	BIND_REQUIRED_SYMBOL(vte_terminal_get_cjk_ambiguous_width);
+#endif
 
 	#undef BIND_REQUIRED_SYMBOL_RGBA_WRAPPED
 	#undef BIND_REQUIRED_SYMBOL
