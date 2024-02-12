class SakuraAT387 < Formula
  desc "GTK/VTE based terminal emulator."
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"
  url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_7.tar.gz"
  sha256 "c50e1a383a1f0e803817642d017b77545c8e496daeea39ab5152b9bb6d4d171e"

  keg_only :versioned_formula

  patch :p1, :DATA

  depends_on "gtk+3"
  depends_on "z80oolong/vte/libvte@2.91"
  depends_on "systemd"
  depends_on "gettext"
  depends_on "pod2man" => :build
  depends_on "cmake" => :build

  def install
    std_cmake_args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
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
    system "#{bin}/sakura", "--version"
  end
end

__END__
diff --git a/src/sakura.c b/src/sakura.c
index 2b5b2a3..e3be05f 100644
--- a/src/sakura.c
+++ b/src/sakura.c
@@ -2949,6 +2949,9 @@ sakura_add_tab()
 	GtkWidget *event_box;
 	int index; int npages;
 	gchar *cwd = NULL; gchar *default_label_text = NULL;
+#ifndef NO_UTF8_CJK
+	gchar *vte_cjk_width = NULL;
+#endif
 
 	sk_tab = g_new0(struct sakura_tab, 1);
 
@@ -3175,6 +3178,14 @@ sakura_add_tab()
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
 
