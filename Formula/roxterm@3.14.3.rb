class RoxtermAT3143 < Formula
  desc "Highly configurable terminal emulator based on VTE"
  homepage "https://roxterm.sourceforge.io/"
  url "https://github.com/realh/roxterm/archive/refs/tags/3.14.3.tar.gz"
  sha256 "4f801371113ff33d6a53dfa77aef6c3d09d29620fcf27e844c755904f9776e5b"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "gettext" => :build
  depends_on "libxslt" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus-glib"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "z80oolong/vte/libvte@2.91"

  resource("roxterm-ja-po") do
    url "https://gist.github.com/731fd4e4d0adb4178ce69885bf061523.git",
        branch:   "main",
        revision: "72cd4d52211814ac3a8cecd2fc197447c3914c47"
  end

  patch :p1, :DATA

  def install
    ENV.append "CFLAGS", "-D_GNU_SOURCE"
    ENV.append "CFLAGS", "-DENABLE_NLS=1"

    inreplace "CMakeLists.txt" do |s|
      s.gsub! %r{http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl},
        "#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl-ns/manpages/docbook.xsl"
    end

    inreplace "./src/config.h.in" do |s|
      s.gsub!(/^#undef ENABLE_NLS/, "#define ENABLE_NLS 1")
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    resource("roxterm-ja-po").stage do
      (share/"locale/ja/LC_MESSAGES").mkpath
      (share/"locale/en_US/LC_MESSAGES").mkpath

      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/ja/LC_MESSAGES/roxterm.mo", "./ja.po"
      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/en_US/LC_MESSAGES/roxterm.mo", "./en_US.po"
    end
  end

  def diff_data
    lines = path.each_line.with_object([]) do |line, result|
      result.push(line) if /^__END__/.match?(line) || result.first
    end
    lines.shift
    lines.join
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roxterm --version")
  end
end

__END__
diff --git a/src/roxterm.c b/src/roxterm.c
index 1a8173f..5760e37 100644
--- a/src/roxterm.c
+++ b/src/roxterm.c
@@ -3233,6 +3233,9 @@ static GtkWidget *roxterm_multi_tab_filler(MultiWin * win, MultiTab * tab,
     gboolean custom_tab_name = FALSE;
     MultiWin *template_win = roxterm_get_win(roxterm_template);
     GtkWidget *viewport = NULL;
+#ifndef NO_UTF8_CJK
+    char *vte_cjk_width = NULL;
+#endif
 
     roxterm_terms = g_list_append(roxterm_terms, roxterm);
 
@@ -3259,6 +3262,14 @@ static GtkWidget *roxterm_multi_tab_filler(MultiWin * win, MultiTab * tab,
             roxterm->columns, roxterm->rows);
     gtk_widget_grab_focus(roxterm->widget);
     vte = VTE_TERMINAL(roxterm->widget);
+#ifndef NO_UTF8_CJK
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vte_terminal_get_cjk_ambiguous_width(vte) != 2) {
+            vte_terminal_set_cjk_ambiguous_width(vte, 2);
+        }
+    }
+#endif
     if (vte_widget)
         *vte_widget = roxterm->widget;
     if (adjustment)
