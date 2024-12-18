class Sakura < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"

  stable do
    url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_8.tar.gz"
    sha256 "b2b05e9e389dafe7bf41fd2fd4ca38a23afdd2e207bf0734d7f3aa3bb6346d50"

    patch :p1, Formula["z80oolong/vte/sakura@3.8.8"].diff_data
  end

  head do
    url "https://github.com/dabisu/sakura.git"

    patch :p1, :DATA
  end

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "systemd"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def diff_data
    lines = path.each_line.with_object([]) do |line, result|
      result.push(line) if /^__END__/.match?(line) || result.first
    end
    lines.shift
    lines.join
  end

  test do
    system bin/"sakura", "--version"
  end
end

__END__
diff --git a/src/sakura.c b/src/sakura.c
index 72ec13f..8bfca37 100644
--- a/src/sakura.c
+++ b/src/sakura.c
@@ -3001,6 +3001,9 @@ sakura_add_tab()
 	GtkWidget *event_box;
 	gint index, page, npages;
 	gchar *cwd = NULL; gchar *default_label_text = NULL;
+#ifndef NO_UTF8_CJK
+	gchar *vte_cjk_width = NULL;
+#endif
 
 	sk_tab = g_new0(struct sakura_tab, 1);
 
@@ -3278,6 +3281,14 @@ sakura_add_tab()
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
 
