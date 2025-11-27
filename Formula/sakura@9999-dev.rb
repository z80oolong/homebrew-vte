class SakuraAT9999Dev < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"

  @@current_commit = "46f4582a7b9b2e4eb892909b3e29e5067fcbb2f7"
  url "https://github.com/dabisu/sakura.git",
    branch:   "master",
    revision: @@current_commit
  version "git-#{@@current_commit[0..7]}"
  revision 1

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "systemd"
  depends_on "gtk+3"
  depends_on "vte3"

  patch :p1, :DATA

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `sakura` based on the HEAD version (commit #{@@current_commit[0..7]}) from its git repository.
    EOS
  end

  def diff_data
    path.readlines(nil).first.gsub(/^.*\n__END__\n/m, "")
  end

  test do
    system bin/"sakura", "--version"
  end
end

__END__
diff --git a/src/sakura.c b/src/sakura.c
index 9c49d55..c2c048b 100644
--- a/src/sakura.c
+++ b/src/sakura.c
@@ -3035,6 +3035,9 @@ sakura_add_tab()
 	GtkWidget *event_box;
 	gint index, page, npages;
 	gchar *cwd = NULL; gchar *default_label_text = NULL;
+#ifndef NO_UTF8_CJK
+	gchar *vte_cjk_width = NULL;
+#endif
 
 	sk_tab = g_new0(struct sakura_tab, 1);
 
@@ -3312,6 +3315,14 @@ sakura_add_tab()
 	vte_terminal_set_audible_bell (VTE_TERMINAL(sk_tab->vte), sakura.audible_bell ? TRUE : FALSE);
 	vte_terminal_set_cursor_blink_mode (VTE_TERMINAL(sk_tab->vte), sakura.blinking_cursor ? VTE_CURSOR_BLINK_ON : VTE_CURSOR_BLINK_OFF);
 	vte_terminal_set_cursor_shape (VTE_TERMINAL(sk_tab->vte), sakura.cursor_type);
+#ifndef NO_UTF8_CJK
+	vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+	if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+		if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(sk_tab->vte)) != 2) {
+			vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(sk_tab->vte), 2);
+		}
+	}
+#endif
 
 }
 
