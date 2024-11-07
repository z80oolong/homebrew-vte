class TildaAT200 < Formula
  desc "A Gtk based drop down terminal for Linux and Unix"
  homepage "https://github.com/lanoxx/tilda"
  url "https://github.com/lanoxx/tilda/archive/refs/tags/tilda-2.0.0.tar.gz"
  sha256 "ff9364244c58507cd4073ac22e580a4cded048d416c682496c1b1788ee8a30df"
  license "GPL-2.0"

  keg_only :versioned_formula

  patch :p1, :DATA

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "perl" => :build
  depends_on "z80oolong/dep/libconfuse@3.3" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    ENV["LC_ALL"] = "C"
    system "./autogen.sh"

    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
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
    system "#{bin}/tilda", "--version"
  end
end

__END__
diff --git a/po/LINGUAS b/po/LINGUAS
index 38adefd..09ad7f5 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -9,6 +9,7 @@ fr
 hr
 hu
 it
+ja
 lt
 nb
 pl
diff --git a/po/ja.po b/po/ja.po
new file mode 100644
index 0000000..c2ed824
--- /dev/null
+++ b/po/ja.po
@@ -0,0 +1,681 @@
+# Japanese translations for tilda-tilda package.
+# Copyright (C) 2024 THE tilda-tilda'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the tilda-tilda package.
+#  <zool@zool.jpn.org>, 2024.
+#
+
+msgid ""
+msgstr ""
+"Project-Id-Version: tilda-tilda 2.0.0\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2024-11-07 05:34+0900\n"
+"PO-Revision-Date: 2024-11-07 05:35+0900\n"
+"Last-Translator:  <zool@zool.jpn.org>\n"
+"Language-Team: Japanese <translation-team-ja@lists.sourceforge.net>\n"
+"Language: ja\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=1; plural=0;\n"
+
+#: src/tilda.ui:69
+msgid "Close Tilda"
+msgstr "Tildaを閉じる"
+
+#: src/tilda.ui:72
+msgid "Open a new terminal"
+msgstr "新しいターミナルを開く"
+
+#: src/tilda.ui:75
+msgid "Open a new terminal and hide"
+msgstr "新しいターミナルを開いて隠す"
+
+#: src/tilda.ui:86 src/tilda.ui:194
+msgid "Top"
+msgstr "上"
+
+#: src/tilda.ui:89 src/tilda.ui:197
+msgid "Bottom"
+msgstr "下"
+
+#: src/tilda.ui:92 src/tilda.ui:200
+msgid "Left"
+msgstr "左"
+
+#: src/tilda.ui:95 src/tilda.ui:203
+msgid "Right"
+msgstr "右"
+
+#: src/tilda.ui:98
+msgid "Hidden"
+msgstr "非表示"
+
+#: src/tilda.ui:109
+msgid "Focus Terminal"
+msgstr "ターミナルにフォーカス"
+
+#: src/tilda.ui:112
+msgid "Hide Terminal"
+msgstr "ターミナルを隠す"
+
+#: src/tilda.ui:123
+msgid "Block Cursor"
+msgstr "ブロックカーソル"
+
+#: src/tilda.ui:126
+msgid "IBeam Cursor"
+msgstr "アイビームカーソル"
+
+#: src/tilda.ui:129
+msgid "Underline Cursor"
+msgstr "アンダーラインカーソル"
+#--------------
+#: src/tilda.ui:140
+msgid "Show whole tab title"
+msgstr "タブタイトルを全て表示"
+
+#: src/tilda.ui:143
+msgid "Show first n chars of title"
+msgstr "タイトルの最初の n 文字を表示"
+
+#: src/tilda.ui:146
+msgid "Show last n chars of title"
+msgstr "タイトルの最後の n 文字を表示"
+
+#: src/tilda.ui:157
+msgid "Isn't displayed"
+msgstr "表示しない"
+
+#: src/tilda.ui:160
+msgid "Goes after initial title"
+msgstr "初期タイトルの後に表示"
+
+#: src/tilda.ui:163
+msgid "Goes before initial title"
+msgstr "初期タイトルの前に表示"
+
+#: src/tilda.ui:166
+msgid "Replace initial title"
+msgstr "初期タイトルを置き換える"
+
+#: src/tilda.ui:177
+msgid "Drop to the default shell"
+msgstr "デフォルトのシェルに戻る"
+
+#: src/tilda.ui:180
+msgid "Restart the command"
+msgstr "コマンドを再起動"
+
+#: src/tilda.ui:183
+msgid "Exit the terminal"
+msgstr "ターミナルを終了"
+
+#: src/tilda.ui:214 src/tilda.ui:246
+msgid "Custom"
+msgstr "カスタム"
+
+#: src/tilda.ui:217
+msgid "Green on Black"
+msgstr "黒地に緑"
+
+#: src/tilda.ui:220
+msgid "Black on White"
+msgstr "白地に黒"
+
+#: src/tilda.ui:223
+msgid "White on Black"
+msgstr "黒地に白"
+
+#: src/tilda.ui:226
+msgid "Zenburn"
+msgstr "Zenburn"
+
+#: src/tilda.ui:229
+msgid "Solarized Light"
+msgstr "Solarized Light"
+
+#: src/tilda.ui:232
+msgid "Solarized Dark"
+msgstr "Solarized Dark"
+
+#: src/tilda.ui:235
+msgid "Snazzy"
+msgstr "Snazzy"
+
+#: src/tilda.ui:257
+msgid "On the Left"
+msgstr "左側"
+
+#: src/tilda.ui:260
+msgid "On the Right"
+msgstr "右側"
+
+#: src/tilda.ui:263
+msgid "Disabled"
+msgstr "無効"
+
+#: src/tilda.ui:274 src/tilda.ui:291
+msgid "ASCII DEL"
+msgstr "ASCII DEL"
+
+#: src/tilda.ui:277 src/tilda.ui:294
+msgid "Escape sequence"
+msgstr "エスケープシーケンス"
+
+#: src/tilda.ui:280 src/tilda.ui:297
+msgid "Control-H"
+msgstr "Control-H"
+
+#: src/tilda.ui:314
+msgid "Tilda Config"
+msgstr "Tilda 設定"
+
+#: src/tilda.ui:395
+msgid "Start Tilda hidden"
+msgstr "Tilda を非表示で開始"
+
+#: src/tilda.ui:409
+msgid "Always on top"
+msgstr "常に最前面"
+
+#: src/tilda.ui:423
+msgid "Display on all workspaces"
+msgstr "全ワークスペースに表示"
+
+#: src/tilda.ui:437
+msgid "Do not show in taskbar"
+msgstr "タスクバーに表示しない"
+
+#: src/tilda.ui:451
+msgid "Show Notebook Border"
+msgstr "ノートブックの境界線を表示"
+
+#: src/tilda.ui:465
+msgid "Set as Desktop window"
+msgstr "デスクトップウィンドウとして設定"
+
+#: src/tilda.ui:480
+msgid "Start in fullscreen"
+msgstr "全画面で開始"
+
+#: src/tilda.ui:509
+msgid "Non-focus Pull Up Behaviour:"
+msgstr "非フォーカス時のプルアップ動作:"
+
+#: src/tilda.ui:560
+msgid "<b>Window Display</b>"
+msgstr "<b>ウィンドウ表示</b>"
+
+#: src/tilda.ui:598
+msgid "Cursor Blinks"
+msgstr "カーソルが点滅"
+
+#: src/tilda.ui:612
+msgid "Audible Terminal Bell"
+msgstr "ターミナルベルを鳴らす"
+
+#: src/tilda.ui:628
+msgid "Cursor Shape: "
+msgstr "カーソル形状: "
+
+#: src/tilda.ui:663
+msgid "<b>Terminal Display</b>"
+msgstr "<b>ターミナル表示</b>"
+
+#: src/tilda.ui:703
+msgid "Font:"
+msgstr "フォント:"
+
+#: src/tilda.ui:733
+msgid "<b>Font</b>"
+msgstr "<b>フォント</b>"
+
+#: src/tilda.ui:782
+msgid "Hide Tilda when mouse leaves it"
+msgstr "マウスが外れたときに Tilda を隠す"
+
+#: src/tilda.ui:799
+msgid "Auto Hide Delay:"
+msgstr "自動非表示の遅延:"
+
+#: src/tilda.ui:809
+msgid "Hide when Tilda loses focus"
+msgstr "Tilda がフォーカスを失ったときに隠す"
+
+#: src/tilda.ui:829
+msgid "<b>Auto Hide</b>"
+msgstr "<b>自動非表示</b>"
+
+#: src/tilda.ui:868
+msgid "When last terminal is closed:"
+msgstr "最後のターミナルが閉じられたとき:"
+
+#: src/tilda.ui:895
+msgid "Always prompt on exit"
+msgstr "終了時に常に確認"
+
+#: src/tilda.ui:918
+msgid "<b>Program Exit</b>"
+msgstr "<b>プログラム終了</b>"
+
+#: src/tilda.ui:936
+msgid ""
+"<small><i><b>Note:</b> Some options require that tilda is restarted.</i></"
+"small>"
+msgstr ""
+"<small><i><b>注意:</b> 一部のオプションは tilda の再起動が必要です。</i></small>"
+
+#: src/tilda.ui:953
+msgid "General"
+msgstr "一般設定"
+
+#: src/tilda.ui:998
+msgid "Word Characters:"
+msgstr "単語の文字:"
+
+#: src/tilda.ui:1026
+msgid "<b>Select by Word</b>"
+msgstr "<b>単語で選択</b>"
+
+#: src/tilda.ui:1062
+msgid "Match Numbers"
+msgstr "数字を一致させる"
+
+#: src/tilda.ui:1077
+msgid "Match Email Addresses"
+msgstr "メールアドレスを一致させる"
+
+#: src/tilda.ui:1091
+msgid "Match File URIs"
+msgstr "ファイル URI を一致させる"
+
+#: src/tilda.ui:1120
+msgid "Web Browser *:"
+msgstr "ウェブブラウザ *:"
+
+#: src/tilda.ui:1130
+msgid "Press and hold CTRL to activate match"
+msgstr "一致を有効にするには CTRL を押し続けます"
+
+#: src/tilda.ui:1144
+msgid "Use custom web browser command"
+msgstr "カスタムウェブブラウザコマンドを使用"
+
+#: src/tilda.ui:1159
+msgid "Match Web URIs"
+msgstr "ウェブ URI を一致させる"
+
+#: src/tilda.ui:1199
+msgid "<b>Match Handling</b>"
+msgstr "<b>一致の処理</b>"
+
+#: src/tilda.ui:1234
+msgid "Initial Title:"
+msgstr "初期タイトル:"
+
+#: src/tilda.ui:1256
+msgid "Title Max Length:"
+msgstr "タイトルの最大長:"
+
+#: src/tilda.ui:1297
+msgid "Dynamically-set Title:"
+msgstr "動的に設定されたタイトル:"
+
+#: src/tilda.ui:1309
+msgid "Title Behaviour:"
+msgstr "タイトルの動作:"
+
+#: src/tilda.ui:1342
+msgid "<b>Title</b>"
+msgstr "<b>タイトル</b>"
+
+#: src/tilda.ui:1403
+msgid "Run a custom command instead of the shell"
+msgstr "シェルの代わりにカスタムコマンドを実行"
+
+#: src/tilda.ui:1419
+msgid "Custom Command:"
+msgstr "カスタムコマンド:"
+
+#: src/tilda.ui:1431
+msgid "When Command Exits:"
+msgstr "コマンド終了時:"
+
+#: src/tilda.ui:1441
+msgid "Use a login shell"
+msgstr "ログインシェルを使用"
+
+#: src/tilda.ui:1467
+msgid "<b>Command</b>"
+msgstr "<b>コマンド</b>"
+
+#: src/tilda.ui:1494
+msgid ""
+"* A valid command that can open a browser must be entered here. It is "
+"possible to use the name of a specific browser such as 'firefox' and 'google-"
+"chrome' or to use the generic commands 'x-www-browser' and 'xdg-open'. The "
+"best command may be different depending on the system."
+msgstr ""
+"* ブラウザを開ける有効なコマンドをここに入力してください。"
+"'firefox'や'google-chrome'などの特定のブラウザ名や、'x-www-browser'や'xdg-open'といった"
+"汎用コマンドが使用できます。最適なコマンドはシステムによって異なる可能性があります。"
+#----------
+#: src/tilda.ui:1531
+msgid "Show confirmation dialog when closing tab"
+msgstr "タブを閉じる際に確認ダイアログを表示"
+
+#: src/tilda.ui:1551
+msgid "Close Action"
+msgstr "終了アクション"
+
+#: src/tilda.ui:1572
+msgid "Title and Command"
+msgstr "タイトルとコマンド"
+
+#: src/tilda.ui:1616 src/tilda.ui:1794
+msgid "Percentage"
+msgstr "パーセンテージ"
+
+#: src/tilda.ui:1640 src/tilda.ui:1806
+msgid "In Pixels"
+msgstr "ピクセル単位"
+
+#: src/tilda.ui:1667
+msgid "<b>Height</b>"
+msgstr "<b>高さ</b>"
+
+#: src/tilda.ui:1703
+msgid "Monitor:"
+msgstr "モニター:"
+
+#: src/tilda.ui:1758
+msgid "<b>Select monitor</b>"
+msgstr "<b>モニターの選択</b>"
+
+#: src/tilda.ui:1845
+msgid "<b>Width</b>"
+msgstr "<b>幅</b>"
+
+#: src/tilda.ui:1881
+msgid "Centered Horizontally"
+msgstr "水平方向に中央配置"
+
+#: src/tilda.ui:1899
+msgid "Y Position"
+msgstr "Y 位置"
+
+#: src/tilda.ui:1933
+msgid "X Position"
+msgstr "X 位置"
+
+#: src/tilda.ui:1943
+msgid "Centered Vertically"
+msgstr "垂直方向に中央配置"
+
+#: src/tilda.ui:1971
+msgid "<b>Position</b>"
+msgstr "<b>位置</b>"
+
+#: src/tilda.ui:2009
+msgid "Position of Tabs:"
+msgstr "タブの位置:"
+
+#: src/tilda.ui:2036
+msgid "Expand Tabs"
+msgstr "タブを展開"
+
+#: src/tilda.ui:2050
+msgid "Show single Tab"
+msgstr "単一のタブを表示"
+
+#: src/tilda.ui:2064
+msgid "Display Title in Tooltip"
+msgstr "ツールチップにタイトルを表示"
+
+#: src/tilda.ui:2078
+msgid "Insert New Tabs after Current Tab"
+msgstr "現在のタブの後に新しいタブを挿入"
+
+#: src/tilda.ui:2098
+msgid "<b>Tabs</b>"
+msgstr "<b>タブ</b>"
+
+#: src/tilda.ui:2147
+msgid "Animation Delay (usec)"
+msgstr "アニメーションの遅延（μ秒）"
+
+#: src/tilda.ui:2159
+msgid "Animation Orientation"
+msgstr "アニメーションの向き"
+
+#: src/tilda.ui:2197
+msgid "Animated Pulldown"
+msgstr "アニメーションプルダウン"
+
+#: src/tilda.ui:2213
+msgid "Level of Transparency"
+msgstr "透明度のレベル"
+
+#: src/tilda.ui:2223
+msgid "Enable Transparency"
+msgstr "透明化を有効にする"
+
+#: src/tilda.ui:2246
+msgid "<b>Extras</b>"
+msgstr "<b>エクストラ</b>"
+
+#: src/tilda.ui:2265
+msgid "Appearance"
+msgstr "外観"
+
+#: src/tilda.ui:2334
+msgid "Cursor Color"
+msgstr "カーソルの色"
+
+#: src/tilda.ui:2382
+msgid "Text Color"
+msgstr "文字色"
+
+#: src/tilda.ui:2394
+msgid "Background Color"
+msgstr "背景色"
+
+#: src/tilda.ui:2406
+msgid "Built-in Schemes"
+msgstr "組み込みの配色"
+
+#: src/tilda.ui:2420
+msgid "<b>Foreground and Background Colors</b>"
+msgstr "<b>前景と背景の色</b>"
+
+#: src/tilda.ui:2452
+msgid ""
+"<small><i><b>Note:</b> Terminal applications have these colors available to "
+"them.</i></small>"
+msgstr ""
+"<small><i><b>注:</b> ターミナルアプリケーションはこれらの色を使用できます。</i></small>"
+
+#: src/tilda.ui:2495
+msgid "Choose Color 14"
+msgstr "色 14 を選択"
+
+#: src/tilda.ui:2508
+msgid "Choose Color 13"
+msgstr "色 13 を選択"
+
+#: src/tilda.ui:2521
+msgid "Choose Color 15"
+msgstr "色 15 を選択"
+
+#: src/tilda.ui:2534
+msgid "Choose Color 12"
+msgstr "色 12 を選択"
+
+#: src/tilda.ui:2547
+msgid "Choose Color 10"
+msgstr "色 10 を選択"
+
+#: src/tilda.ui:2560
+msgid "Choose Color 11"
+msgstr "色 11 を選択"
+
+#: src/tilda.ui:2573
+msgid "Choose Color 9"
+msgstr "色 9 を選択"
+
+#: src/tilda.ui:2586
+msgid "Choose Color 7"
+msgstr "色 7 を選択"
+
+#: src/tilda.ui:2599
+msgid "Choose Color 6"
+msgstr "色 6 を選択"
+
+#: src/tilda.ui:2612
+msgid "Choose Color 5"
+msgstr "色 5 を選択"
+
+#: src/tilda.ui:2625
+msgid "Choose Color 4"
+msgstr "色 4 を選択"
+
+#: src/tilda.ui:2638
+msgid "Choose Color 3"
+msgstr "色 3 を選択"
+
+#: src/tilda.ui:2651
+msgid "Choose Color 2"
+msgstr "色 2 を選択"
+
+#: src/tilda.ui:2664
+msgid "Choose Color 1"
+msgstr "色 1 を選択"
+
+#: src/tilda.ui:2677
+msgid "Choose Color 0"
+msgstr "色 0 を選択"
+
+#: src/tilda.ui:2691
+msgid "Choose Color 8"
+msgstr "色 8 を選択"
+
+#: src/tilda.ui:2708
+msgid "Built-in schemes:"
+msgstr "組み込み配色:"
+
+#: src/tilda.ui:2723
+msgid "Color palette:"
+msgstr "カラーパレット:"
+
+#: src/tilda.ui:2748
+msgid "Show bold text in bright colors"
+msgstr "太字を明るい色で表示"
+
+#: src/tilda.ui:2766
+msgid "<b>Palette</b>"
+msgstr "<b>パレット</b>"
+
+#: src/tilda.ui:2785
+msgid "Colors"
+msgstr "色"
+
+#: src/tilda.ui:2842
+msgid "Scrollbar is:"
+msgstr "スクロールバー:"
+
+#: src/tilda.ui:2851
+msgid "Limit scrollback to:"
+msgstr "スクロールバックを制限:"
+
+#: src/tilda.ui:2855
+msgid "Unselect for unlimited scrollback."
+msgstr "選択を解除すると無制限のスクロールバックになります。"
+
+#: src/tilda.ui:2867
+msgid "Scroll on Output"
+msgstr "出力時にスクロール"
+
+#: src/tilda.ui:2881
+msgid "Scroll on Keystroke"
+msgstr "キー入力時にスクロール"
+
+#: src/tilda.ui:2903
+msgid "0"
+msgstr "0"
+
+#: src/tilda.ui:2915
+msgid "lines"
+msgstr "行"
+
+#: src/tilda.ui:2941
+msgid "<b>Scrolling</b>"
+msgstr "<b>スクロール</b>"
+
+#: src/tilda.ui:2962
+msgid "Scrolling"
+msgstr "スクロール"
+
+#: src/tilda.ui:3001
+msgid ""
+"<small><i><b>Note:</b> These options may cause some applications to behave "
+"incorrectly.  They are only here to allow you to work around certain "
+"applications and operating systems that expect different terminal behavior.</"
+"i></small>"
+msgstr ""
+"<small><i><b>注:</b> これらのオプションにより一部のアプリケーションが誤動作する"
+"可能性があります。これは、異なるターミナル動作を想定している一部のアプリケーションや"
+"オペレーティングシステムに対応するためのものです。</i></small>"
+
+#: src/tilda.ui:3017
+msgid "_Backspace key generates:"
+msgstr "_Backspace キーの生成:"
+
+#: src/tilda.ui:3031
+msgid "_Delete key generates:"
+msgstr "_Delete キーの生成:"
+
+#: src/tilda.ui:3043
+msgid "_Reset Compatibility Options to Defaults"
+msgstr "_互換性オプションをデフォルトにリセット"
+
+#: src/tilda.ui:3097
+msgid "<b>Compatibility</b>"
+msgstr "<b>互換性</b>"
+
+#: src/tilda.ui:3116
+msgid "Compatibility"
+msgstr "互換性"
+
+#: src/tilda.ui:3168
+msgid "<b>Keybindings</b>"
+msgstr "<b>キー設定</b>"
+
+#: src/tilda.ui:3180
+msgid "Clear Keybinding"
+msgstr "キー設定のクリア"
+
+#: src/tilda.ui:3199
+msgid "Keybindings"
+msgstr "キー設定"
+
+#: src/tilda-search-box.ui:15
+msgid ""
+"Search term not found, search again to continue the search at the beginning."
+msgstr ""
+"検索語が見つかりません。先頭から再検索を行います。"
+
+#: src/tilda-search-box.ui:49
+msgid "_Next"
+msgstr "次へ(_N)"
+
+#: src/tilda-search-box.ui:64
+msgid "_Prev"
+msgstr "前へ(_P)"
+
+#: src/tilda-search-box.ui:79
+msgid "_Match Case"
+msgstr "大文字小文字を区別(_M)"
+
+#: src/tilda-search-box.ui:96
+msgid "_Regex"
+msgstr "正規表現(_R)"
diff --git a/src/tilda_terminal.c b/src/tilda_terminal.c
index ed6a30c..86eaa5b 100644
--- a/src/tilda_terminal.c
+++ b/src/tilda_terminal.c
@@ -137,6 +137,9 @@ register_match (VteRegex * regex,
 
 struct tilda_term_ *tilda_term_init (struct tilda_window_ *tw, gint index)
 {
+#ifndef NO_UTF8_CJK
+    gchar *vte_cjk_width = NULL;
+#endif
     DEBUG_FUNCTION ("tilda_term_init");
     DEBUG_ASSERT (tw != NULL);
 
@@ -228,6 +231,15 @@ struct tilda_term_ *tilda_term_init (struct tilda_window_ *tw, gint index)
     gtk_widget_show (term->vte_term);
     gtk_widget_show (term->hbox);
 
+#ifndef NO_UTF8_CJK
+    /* Set VTE Terminal to CJK ambiguous width. */
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(term->vte_term)) != 2) {
+            vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(term->vte_term), 2);
+        }
+    }
+#endif
     /* Get current term's working directory */
     current_tt_index = gtk_notebook_get_current_page (GTK_NOTEBOOK(tw->notebook));
     current_tt = g_list_nth_data (tw->terms, current_tt_index);
