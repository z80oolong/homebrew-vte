class TildaAT150 < Formula
  desc "Gtk-based drop down terminal for Linux and Unix"
  homepage "https://github.com/lanoxx/tilda"
  url "https://github.com/lanoxx/tilda/archive/refs/tags/tilda-1.5.0.tar.gz"
  sha256 "f664c17daca2a2900f49de9eb65746ced03c867b02144149ef21260cbcd61039"
  license "GPL-2.0-or-later"
  revision 1

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "perl" => :build
  depends_on "pkgconf" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "vte3"

  resource("libconfuse") do
    url "https://github.com/libconfuse/libconfuse/releases/download/v3.3/confuse-3.3.tar.xz"
    sha256 "1dd50a0320e135a55025b23fcdbb3f0a81913b6d0b0a9df8cc2fdf3b3dc67010"
  end

  patch :p1, :DATA

  def install
    ENV["LC_ALL"] = "C"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"libconfuse/lib/pkgconfig"
    ENV.prepend_path "HOMEBREW_RPATH_PATHS", libexec/"libconfuse/lib"

    resource("libconfuse").stage do
      args = std_configure_args.dup
      args.map! { |arg| arg.match?(/^--prefix/) ? "--prefix=#{libexec}/libconfuse" : arg }
      args.map! { |arg| arg.match?(/^--libdir/) ? "--libdir=#{libexec}/libconfuse/lib" : arg }
      args << "--disable-silent-rules"

      system "./configure", *args
      system "make"
      system "make", "install"
    end

    system "sh", "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  def diff_data
    path.readlines(nil).first.gsub(/^.*\n__END__\n/m, "")
  end

  test do
    ENV["LC_ALL"] = "C"
    output = shell_output("#{bin}/tilda --version")
    assert_match Regexp.new("Tilda #{version}", Regexp::MULTILINE), output
  end
end

__END__
diff --git a/po/LINGUAS b/po/LINGUAS
index 4032f69..8da074a 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -8,6 +8,7 @@ es
 fr
 hu
 it
+ja
 lt
 nb
 pl
diff --git a/po/ja.po b/po/ja.po
new file mode 100644
index 0000000..40608e5
--- /dev/null
+++ b/po/ja.po
@@ -0,0 +1,1077 @@
+# Japanese translation for tilda
+# Copyright (c) 2008 Rosetta Contributors and Canonical Ltd 2008
+# This file is distributed under the same license as the tilda package.
+# NAKATSUKA, Yukitaka <zool@zool.jpn.org>, 2025.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: tilda\n"
+"Report-Msgid-Bugs-To: sloutri@iit.edu\n"
+"POT-Creation-Date: 2020-02-08 23:45+0100\n"
+"PO-Revision-Date: 2025-09-23 10:05+0900\n"
+"Last-Translator: NAKATSUKA, Yukitaka <zool@zool.jpn.org>\n"
+"Language-Team: Japanese <ja@li.org>\n"
+"Language: ja\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Launchpad-Export-Date: 2008-04-28 05:36+0000\n"
+"X-Generator: Launchpad (build Unknown)\n"
+
+#: src/menu.ui:6
+msgid "_New Tab"
+msgstr "新しいタブ(_N)"
+
+#: src/menu.ui:10
+#, fuzzy
+msgid "_Close Tab"
+msgstr "タブを閉じる(_C)"
+
+#: src/menu.ui:16
+msgid "_Copy"
+msgstr "コピー(_C)"
+
+#: src/menu.ui:20
+msgid "_Paste"
+msgstr "貼り付け(_P)"
+
+#: src/menu.ui:26
+msgid "_Toggle Fullscreen"
+msgstr "フルスクリーンの切り替え(_T)"
+
+#: src/menu.ui:30
+msgid "_Toggle Searchbar"
+msgstr "検索バーの切り替え(_T)"
+
+#: src/menu.ui:36
+msgid "_Preferences"
+msgstr "設定(_P)"
+
+#: src/menu.ui:42
+msgid "_Quit"
+msgstr "終了(_Q)"
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
+#, fuzzy
+msgid "Hide Terminal"
+msgstr "ターミナルを隠す"
+
+#: src/tilda.ui:123
+msgid "Block Cursor"
+msgstr "ブロックカーソル"
+
+#: src/tilda.ui:126
+msgid "IBeam Cursor"
+msgstr "Iビームカーソル"
+
+#: src/tilda.ui:129
+msgid "Underline Cursor"
+msgstr "下線カーソル"
+
+#: src/tilda.ui:140
+msgid "Show whole tab title"
+msgstr "タブタイトル全体を表示"
+
+#: src/tilda.ui:143
+msgid "Show first n chars of title"
+msgstr "タイトルの最初のn文字を表示"
+
+#: src/tilda.ui:146
+msgid "Show last n chars of title"
+msgstr "タイトルの最後のn文字を表示"
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
+#, fuzzy
+msgid "Replace initial title"
+msgstr "初期タイトルを置き換える"
+
+#: src/tilda.ui:177
+msgid "Drop to the default shell"
+msgstr "デフォルトシェルに切り替え"
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
+#, fuzzy
+msgid "Escape sequence"
+msgstr "エスケープシーケンス"
+
+#: src/tilda.ui:280 src/tilda.ui:297
+msgid "Control-H"
+msgstr "Control-H"
+
+#: src/tilda.ui:314
+msgid "Tilda Config"
+msgstr "Tilda設定"
+
+#: src/tilda.ui:395
+msgid "Start Tilda hidden"
+msgstr "Tildaを非表示で起動"
+
+#: src/tilda.ui:409
+msgid "Always on top"
+msgstr "常に最前面"
+
+#: src/tilda.ui:423
+msgid "Display on all workspaces"
+msgstr "すべてのワークスペースに表示"
+
+#: src/tilda.ui:437
+msgid "Do not show in taskbar"
+msgstr "タスクバーに表示しない"
+
+#: src/tilda.ui:451
+msgid "Show Notebook Border"
+msgstr "ノートブックの枠を表示"
+
+#: src/tilda.ui:465
+msgid "Set as Desktop window"
+msgstr "デスクトップウィンドウとして設定"
+
+#: src/tilda.ui:480
+msgid "Start in fullscreen"
+msgstr "フルスクリーンで起動"
+
+#: src/tilda.ui:509
+msgid "Non-focus Pull Up Behaviour:"
+msgstr "非フォーカス時のプルアップ動作："
+
+#: src/tilda.ui:560
+msgid "<b>Window Display</b>"
+msgstr "<b>ウィンドウ表示</b>"
+
+#: src/tilda.ui:598
+msgid "Cursor Blinks"
+msgstr "カーソルの点滅"
+
+#: src/tilda.ui:612
+msgid "Audible Terminal Bell"
+msgstr "ターミナルの可聴ベル"
+
+#: src/tilda.ui:628
+msgid "Cursor Shape: "
+msgstr "カーソルの形状："
+
+#: src/tilda.ui:663
+msgid "<b>Terminal Display</b>"
+msgstr "<b>ターミナル表示</b>"
+
+#: src/tilda.ui:703
+msgid "Font:"
+msgstr "フォント："
+
+#: src/tilda.ui:733
+msgid "<b>Font</b>"
+msgstr "<b>フォント</b>"
+
+#: src/tilda.ui:782
+msgid "Hide Tilda when mouse leaves it"
+msgstr "マウスが離れたときにTildaを隠す"
+
+#: src/tilda.ui:799
+msgid "Auto Hide Delay:"
+msgstr "自動非表示の遅延："
+
+#: src/tilda.ui:809
+msgid "Hide when Tilda loses focus"
+msgstr "Tildaがフォーカスを失ったときに隠す"
+
+#: src/tilda.ui:829
+#, fuzzy
+msgid "<b>Auto Hide</b>"
+msgstr "<b>自動非表示</b>"
+
+#: src/tilda.ui:936
+msgid ""
+"<small><i><b>Note:</b> Some options require that tilda is restarted.</i></"
+"small>"
+msgstr ""
+"<small><i><b>注意：</b> 一部のオプションはTildaの再起動が必要です。</i></"
+"small>"
+
+#: src/tilda.ui:953
+msgid "General"
+msgstr "一般"
+
+#: src/tilda.ui:998
+msgid "Word Characters:"
+msgstr "単語文字："
+
+#: src/tilda.ui:1026
+msgid "<b>Select by Word</b>"
+msgstr "<b>単語単位で選択</b>"
+
+#: src/tilda.ui:1076
+#, fuzzy
+msgid "Web Browser *:"
+msgstr "ウェブブラウザ："
+
+#: src/tilda.ui:1093
+msgid "<b>URL Handling</b>"
+msgstr "<b>URL処理</b>"
+
+#: src/tilda.ui:1128
+msgid "Initial Title:"
+msgstr "初期タイトル："
+
+#: src/tilda.ui:1150
+msgid "Title Max Length:"
+msgstr "タイトルの最大長："
+
+#: src/tilda.ui:1191
+msgid "Dynamically-set Title:"
+msgstr "動的に設定されたタイトル："
+
+#: src/tilda.ui:1203
+msgid "Title Behaviour:"
+msgstr "タイトルの動作："
+
+#: src/tilda.ui:1236
+msgid "<b>Title</b>"
+msgstr "<b>タイトル</b>"
+
+#: src/tilda.ui:1297
+msgid "Run a custom command instead of the shell"
+msgstr "シェルの代わりにカスタムコマンドを実行"
+
+#: src/tilda.ui:1313
+msgid "Custom Command:"
+msgstr "カスタムコマンド："
+
+#: src/tilda.ui:1325
+msgid "When Command Exits:"
+msgstr "コマンド終了時："
+
+#: src/tilda.ui:1335
+msgid "Use a login shell"
+msgstr "ログインシェルを使用"
+
+#: src/tilda.ui:1361
+msgid "<b>Command</b>"
+msgstr "<b>コマンド</b>"
+
+#: src/tilda.ui:1388
+msgid ""
+"* A valid command that can open a browser must be entered here. It is "
+"possible to use the name of a specific browser such as 'firefox' and 'google-"
+"chrome' or to use the generic commands 'x-www-browser' and 'xdg-open'. The "
+"best command may be different depending on the system."
+msgstr ""
+"* ここにはブラウザを開くことができる有効なコマンドを入力する必要があります。"
+"特定のブラウザ名（例：'firefox'や'google-chrome'）を使用するか、"
+"汎用コマンド'x-www-browser'や'xdg-open'を使用できます。"
+"最適なコマンドはシステムによって異なる場合があります。"
+
+#: src/tilda.ui:1425
+msgid "Show confirmation dialog when closing tab"
+msgstr "タブを閉じるときに確認ダイアログを表示"
+
+#: src/tilda.ui:1445
+msgid "Close Action"
+msgstr "閉じる動作"
+
+#: src/tilda.ui:1466
+msgid "Title and Command"
+msgstr "タイトルとコマンド"
+
+#: src/tilda.ui:1510 src/tilda.ui:1688
+msgid "Percentage"
+msgstr "パーセント"
+
+#: src/tilda.ui:1534 src/tilda.ui:1700
+msgid "In Pixels"
+msgstr "ピクセル単位"
+
+#: src/tilda.ui:1561
+msgid "<b>Height</b>"
+msgstr "<b>高さ</b>"
+
+#: src/tilda.ui:1597
+msgid "Monitor:"
+msgstr "モニター："
+
+#: src/tilda.ui:1652
+#, fuzzy
+msgid "<b>Select monitor</b>"
+msgstr "<b>モニターの選択</b>"
+
+#: src/tilda.ui:1739
+msgid "<b>Width</b>"
+msgstr "<b>幅</b>"
+
+#: src/tilda.ui:1775
+msgid "Centered Horizontally"
+msgstr "水平方向に中央揃え"
+
+#: src/tilda.ui:1793
+msgid "Y Position"
+msgstr "Y位置"
+
+#: src/tilda.ui:1827
+msgid "X Position"
+msgstr "X位置"
+
+#: src/tilda.ui:1837
+msgid "Centered Vertically"
+msgstr "垂直方向に中央揃え"
+
+#: src/tilda.ui:1865
+msgid "<b>Position</b>"
+msgstr "<b>位置</b>"
+
+#: src/tilda.ui:1903
+msgid "Position of Tabs:"
+msgstr "タブの位置："
+
+#: src/tilda.ui:1930
+msgid "Expand Tabs"
+msgstr "タブを拡張"
+
+#: src/tilda.ui:1944
+msgid "Show single Tab"
+msgstr "単一タブを表示"
+
+#: src/tilda.ui:1958
+msgid "Display Title in Tooltip"
+msgstr "ツールチップにタイトルを表示"
+
+#: src/tilda.ui:1981
+#, fuzzy
+msgid "<b>Tabs</b>"
+msgstr "<b>タブ</b>"
+
+#: src/tilda.ui:2030
+msgid "Animation Delay (usec)"
+msgstr "アニメーション遅延（マイクロ秒）"
+
+#: src/tilda.ui:2042
+msgid "Animation Orientation"
+msgstr "アニメーションの方向"
+
+#: src/tilda.ui:2080
+msgid "Animated Pulldown"
+msgstr "アニメーション付きプルダウン"
+
+#: src/tilda.ui:2096
+msgid "Level of Transparency"
+msgstr "透明度"
+
+#: src/tilda.ui:2106
+msgid "Enable Transparency"
+msgstr "透明を有効にする"
+
+#: src/tilda.ui:2129
+msgid "<b>Extras</b>"
+msgstr "<b>その他</b>"
+
+#: src/tilda.ui:2148
+msgid "Appearance"
+msgstr "外観"
+
+#: src/tilda.ui:2217
+#, fuzzy
+msgid "Cursor Color"
+msgstr "カーソルの色"
+
+#: src/tilda.ui:2265
+msgid "Text Color"
+msgstr "テキストの色"
+
+#: src/tilda.ui:2277
+msgid "Background Color"
+msgstr "背景色"
+
+#: src/tilda.ui:2289
+msgid "Built-in Schemes"
+msgstr "組み込みスキーム"
+
+#: src/tilda.ui:2303
+msgid "<b>Foreground and Background Colors</b>"
+msgstr "<b>前景色と背景色</b>"
+
+#: src/tilda.ui:2335
+msgid ""
+"<small><i><b>Note:</b> Terminal applications have these colors available to "
+"them.</i></small>"
+msgstr ""
+"<small><i><b>注意：</b> ターミナルアプリケーションはこれらの色を使用できます。</i></"
+"small>"
+
+#: src/tilda.ui:2378
+msgid "Choose Color 14"
+msgstr "色14を選択"
+
+#: src/tilda.ui:2391
+msgid "Choose Color 13"
+msgstr "色13を選択"
+
+#: src/tilda.ui:2404
+msgid "Choose Color 15"
+msgstr "色15を選択"
+
+#: src/tilda.ui:2417
+msgid "Choose Color 12"
+msgstr "色12を選択"
+
+#: src/tilda.ui:2430
+msgid "Choose Color 10"
+msgstr "色10を選択"
+
+#: src/tilda.ui:2443
+msgid "Choose Color 11"
+msgstr "色11を選択"
+
+#: src/tilda.ui:2456
+msgid "Choose Color 9"
+msgstr "色9を選択"
+
+#: src/tilda.ui:2469
+msgid "Choose Color 7"
+msgstr "色7を選択"
+
+#: src/tilda.ui:2482
+msgid "Choose Color 6"
+msgstr "色6を選択"
+
+#: src/tilda.ui:2495
+msgid "Choose Color 5"
+msgstr "色5を選択"
+
+#: src/tilda.ui:2508
+msgid "Choose Color 4"
+msgstr "色4を選択"
+
+#: src/tilda.ui:2521
+msgid "Choose Color 3"
+msgstr "色3を選択"
+
+#: src/tilda.ui:2534
+msgid "Choose Color 2"
+msgstr "色2を選択"
+
+#: src/tilda.ui:2547
+msgid "Choose Color 1"
+msgstr "色1を選択"
+
+#: src/tilda.ui:2560
+msgid "Choose Color 0"
+msgstr "色0を選択"
+
+#: src/tilda.ui:2574
+msgid "Choose Color 8"
+msgstr "色8を選択"
+
+#: src/tilda.ui:2591
+#, fuzzy
+msgid "Built-in schemes:"
+msgstr "組み込みスキーム："
+
+#: src/tilda.ui:2606
+msgid "Color palette:"
+msgstr "カラーパレット："
+
+#: src/tilda.ui:2622
+#, fuzzy
+msgid "<b>Palette</b>"
+msgstr "<b>パレット</b>"
+
+#: src/tilda.ui:2641
+msgid "Colors"
+msgstr "色"
+
+#: src/tilda.ui:2698
+msgid "Scrollbar is:"
+msgstr "スクロールバーは："
+
+#: src/tilda.ui:2707
+#, fuzzy
+msgid "Limit scrollback to:"
+msgstr "スクロールバックを制限："
+
+#: src/tilda.ui:2711
+msgid "Unselect for unlimited scrollback."
+msgstr "無制限のスクロールバックにするには選択を解除してください。"
+
+#: src/tilda.ui:2723
+msgid "Scroll on Output"
+msgstr "出力時にスクロール"
+
+#: src/tilda.ui:2737
+msgid "Scroll on Keystroke"
+msgstr "キー入力時にスクロール"
+
+#: src/tilda.ui:2759
+msgid "0"
+msgstr "0"
+
+#: src/tilda.ui:2771
+msgid "lines"
+msgstr "行"
+
+#: src/tilda.ui:2797
+msgid "<b>Scrolling</b>"
+msgstr "<b>スクロール</b>"
+
+#: src/tilda.ui:2818
+msgid "Scrolling"
+msgstr "スクロール"
+
+#: src/tilda.ui:2857
+msgid ""
+"<small><i><b>Note:</b> These options may cause some applications to behave "
+"incorrectly.  They are only here to allow you to work around certain "
+"applications and operating systems that expect different terminal behavior.</"
+"i></small>"
+msgstr ""
+"<small><i><b>注意：</b> これらのオプションは、一部のアプリケーションが正しく動作しない原因となる場合があります。"
+"これらは、特定のアプリケーションやオペレーティングシステムが期待する異なるターミナルの動作に対応するためのものです。</i></small>"
+
+#: src/tilda.ui:2873
+msgid "_Backspace key generates:"
+msgstr "バックスペースキーの動作(_B)："
+
+#: src/tilda.ui:2887
+msgid "_Delete key generates:"
+msgstr "削除キーの動作(_D)："
+
+#: src/tilda.ui:2899
+msgid "_Reset Compatibility Options to Defaults"
+msgstr "互換性オプションをデフォルトにリセット(_R)"
+
+#: src/tilda.ui:2953
+msgid "<b>Compatibility</b>"
+msgstr "<b>互換性</b>"
+
+#: src/tilda.ui:2972
+msgid "Compatibility"
+msgstr "互換性"
+
+#: src/tilda.ui:3024
+#, fuzzy
+msgid "<b>Keybindings</b>"
+msgstr "<b>キーバインド</b>"
+
+#: src/tilda.ui:3043
+msgid "Keybindings"
+msgstr "キーバインド"
+
+#: src/configsys.c:384
+msgid "Unable to sync the config file to disk\n"
+msgstr "設定ファイルをディスクに同期できません\n"
+
+#: src/configsys.c:394
+msgid "Unable to close the config file\n"
+msgstr "設定ファイルを閉じることができません\n"
+
+#: src/configsys.c:407
+#, c-format
+msgid "Unable to write the config file to %s\n"
+msgstr "設定ファイルを%sに書き込めません\n"
+
+#: src/tilda.c:239
+#, c-format
+msgid "Unable to run command: `%s'\n"
+msgstr "コマンドを実行できません：`%s'\n"
+
+#: src/tilda.c:284 src/tilda.c:459
+#, c-format
+msgid "Unable to open lock directory: %s\n"
+msgstr "ロックディレクトリを開けません：%s\n"
+
+#: src/tilda.c:396
+#, c-format
+msgid "Creating directory:'%s'\n"
+msgstr "ディレクトリを作成中：'%s'\n"
+
+#: src/tilda.c:555
+msgid ""
+"Found style.css in the user config directory, applying user css style.\n"
+msgstr ""
+"ユーザ設定ディレクトリにstyle.cssが見つかりました。ユーザCSSスタイルを適用します。\n"
+
+#: src/tilda.c:610
+msgid "Migrating old config path to XDG folders\n"
+msgstr "古い設定パスをXDGフォルダに移行中\n"
+
+#: src/tilda.c:673
+#, c-format
+msgid "Specified config file '%s' does not exist. Reverting to default path.\n"
+msgstr "指定された設定ファイル'%s'が存在しません。デフォルトパスに戻します。\n"
+
+#: src/tilda.c:766 src/tilda-keybinding.c:409
+#, fuzzy
+msgid ""
+"The keybinding you chose for \"Pull Down Terminal\" is invalid. Please "
+"choose another."
+msgstr "「ターミナルをプルダウン」のキーバインドが無効です。別のものを選択してください。"
+
+#: src/tilda-keybinding.c:115
+msgid "Action"
+msgstr "アクション"
+
+#: src/tilda-keybinding.c:121
+msgid "Shortcut"
+msgstr "ショートカット"
+
+#: src/tilda-keybinding.c:306
+msgid "Enter keyboard shortcut"
+msgstr "キーボードショートカットを入力"
+
+#: src/tilda-keybinding.c:417
+#, fuzzy, c-format
+msgid "The keybinding you chose for \"%s\" is invalid. Please choose another."
+msgstr "選択した「%s」のキーバインドが無効です。別のものを選択してください。"
+
+#: src/tilda_terminal.c:398
+#, c-format
+msgid "Problem reading link %s: %s\n"
+msgstr "リンク%sの読み込みに問題：%s\n"
+
+#: src/tilda_terminal.c:421
+#, c-format
+msgid "Unable to launch default shell: %s\n"
+msgstr "デフォルトシェルを起動できません：%s\n"
+
+#: src/tilda_terminal.c:423
+#, c-format
+msgid "Unable to launch custom command: %s\n"
+msgstr "カスタムコマンドを起動できません：%s\n"
+
+#: src/tilda_terminal.c:424
+#, fuzzy, c-format
+msgid "Launching custom command failed with error: %s\n"
+msgstr "カスタムコマンドの起動に失敗しました。エラー：%s\n"
+
+#: src/tilda_terminal.c:425 src/tilda_terminal.c:459
+msgid "Launching default shell instead\n"
+msgstr "代わりにデフォルトシェルを起動します\n"
+
+#: src/tilda_terminal.c:458
+#, c-format
+msgid "Problem parsing custom command: %s\n"
+msgstr "カスタムコマンドの解析に問題：%s\n"
+
+#: src/tilda_terminal.c:976
+#, c-format
+msgid "Failed to launch the web browser. The command was `%s'\n"
+msgstr "ウェブブラウザの起動に失敗しました。コマンド：`%s'\n"
+
+#: src/tilda_terminal.c:1026
+msgid "Untitled"
+msgstr "タイトルなし"
+
+#: src/tilda_terminal.c:1044
+msgid "Bad value for \"d_set_title\" in config file\n"
+msgstr "設定ファイル内の「d_set_title」に無効な値\n"
+
+#: src/tilda_window.c:109
+msgid "Are you sure you want to close this tab?"
+msgstr "このタブを閉じてもよろしいですか？"
+
+#: src/tilda_window.c:156
+msgid "You have a bad tab_pos in your configuration file\n"
+msgstr "設定ファイルに無効なtab_posがあります\n"
+
+#: src/tilda_window.c:811
+#, c-format
+msgid "Unable to set tilda's icon: %s\n"
+msgstr "Tildaのアイコンを設定できません：%s\n"
+
+#: src/tilda_window.c:1105
+msgid "Out of memory, cannot create tab\n"
+msgstr "メモリ不足、タブを作成できません\n"
+
+#: src/tilda_window.c:1225
+msgid "Are you sure you want to Quit?"
+msgstr "終了してもよろしいですか？"
+
+#: src/wizard.c:138
+#, fuzzy, c-format
+msgid "Tilda %d Config"
+msgstr "Tilda %d 設定"
+
+#: src/wizard.c:561
+msgid "Invalid Cursor Type, resetting to default\n"
+msgstr "無効なカーソルタイプ、デフォルトにリセット\n"
+
+#: src/wizard.c:579
+msgid "Invalid non-focus pull up behaviour, ignoring\n"
+msgstr "無効な非フォーカス時のプルアップ動作、無視します\n"
+
+#: src/wizard.c:1046
+msgid "Invalid tab position setting, ignoring\n"
+msgstr "無効なタブ位置設定、無視します\n"
+
+#~ msgid "Allow Bold Text"
+#~ msgstr "太字テキストを許可"
+
+#~ msgid "Set the background color"
+#~ msgstr "背景色を設定"
+
+#~ msgid "Run a command at startup"
+#~ msgstr "起動時にコマンドを実行"
+
+#~ msgid "Set the font to the following string"
+#~ msgstr "フォントを以下の文字列に設定"
+
+#, fuzzy
+#~ msgid "Configuration file"
+#~ msgstr "設定ファイル"
+
+#~ msgid "Scrollback Lines"
+#~ msgstr "スクロールバック行数"
+
+#~ msgid "Use Scrollbar"
+#~ msgstr "スクロールバーを使用"
+
+#~ msgid "Print the version, then exit"
+#~ msgstr "バージョンを表示して終了"
+
+#~ msgid "Set Initial Working Directory"
+#~ msgstr "初期作業ディレクトリを設定"
+
+#~ msgid "Opaqueness: 0-100%"
+#~ msgstr "不透明度：0-100%"
+
+#~ msgid "Show Configuration Wizard"
+#~ msgstr "設定ウィザードを表示"
+
+#~ msgid ""
+#~ "Error parsing command-line options. Try \"tilda --help\"\n"
+#~ "to see all possible options.\n"
+#~ "\n"
+#~ "Error message: %s\n"
+#~ msgstr ""
+#~ "コマンドラインオプションの解析エラー。「tilda --help」を試して\n"
+#~ "すべての可能なオプションを確認してください。\n"
+#~ "\n"
+#~ "エラーメッセージ：%s\n"
+
+#, fuzzy
+#~ msgid ""
+#~ "Error parsing Glib and GTK specific command-line options. Try \"tilda --"
+#~ "help-all\"\n"
+#~ "to see all possible options.\n"
+#~ "\n"
+#~ "Error message: %s\n"
+#~ msgstr ""
+#~ "GlibおよびGTK固有のコマンドラインオプションの解析エラー。「tilda --help-all」を試して\n"
+#~ "すべての可能なオプションを確認してください。\n"
+#~ "\n"
+#~ "エラーメッセージ：%s\n"
+
+#~ msgid "Enable Antialiasing"
+#~ msgstr "アンチエイリアシングを有効にする"
+
+#~ msgid "Use Image for Background"
+#~ msgstr "背景に画像を使用"
+
+#~ msgid "Scroll Background"
+#~ msgstr "背景をスクロール"
+
+#~ msgid "Use Antialiased Fonts"
+#~ msgstr "アンチエイリアスフォントを使用"
+
+#~ msgid "Set Background Image"
+#~ msgstr "背景画像を設定"
+
+#~ msgid "Enable Double Buffering"
+#~ msgstr "ダブルバッファリングを有効にする"
+
+#~ msgid "    "
+#~ msgstr "    "
+
+#, fuzzy
+#~ msgid "<b>Paste</b>"
+#~ msgstr "<b>貼り付け</b>"
+
+#, fuzzy
+#~ msgid "<b>Quit</b>"
+#~ msgstr "<b>終了</b>"
+
+#, fuzzy
+#~ msgid "<b>Copy</b>"
+#~ msgstr "<b>コピー</b>"
+
+#, fuzzy
+#~ msgid "<b>Pull Down Terminal</b>"
+#~ msgstr "<b>ターミナルをプルダウン</b>"
+
+#, fuzzy
+#~ msgid "<b>Move Tab Left</b>"
+#~ msgstr "<b>タブを左に移動</b>"
+
+#, fuzzy
+#~ msgid "<b>Move Tab Right</b>"
+#~ msgstr "<b>タブを右に移動</b>"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Add Tab\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブを追加」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Close Tab\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブを閉じる」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Next Tab\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「次のタブ」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Previous Tab\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「前のタブ」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Move Tab to Left\" is invalid. Please "
+#~ "choose another."
+#~ msgstr "「タブを左に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Move Tab to Right\" is invalid. Please "
+#~ "choose another."
+#~ msgstr "「タブを右に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Copy\" is invalid. Please choose another."
+#~ msgstr "「コピー」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Quit\" is invalid. Please choose another."
+#~ msgstr "「終了」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 1\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ1に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 2\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ2に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 3\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ3に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 4\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ4に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 5\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ5に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 6\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ6に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 7\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ7に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 8\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ8に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 9\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ9に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Go To Tab 10\" is invalid. Please choose "
+#~ "another."
+#~ msgstr "「タブ10に移動」のキーバインドが無効です。別のものを選択してください。"
+
+#, fuzzy
+#~ msgid ""
+#~ "The keybinding you chose for \"Toggle Fullscreen\" is invalid. Please "
+#~ "choose another."
+#~ msgstr "「フルスクリーンの切り替え」のキーバインドが無効です。別のものを選択してください。"
+
+#~ msgid ""
+#~ "Top\n"
+#~ "Bottom\n"
+#~ "Left\n"
+#~ "Right"
+#~ msgstr ""
+#~ "上\n"
+#~ "下\n"
+#~ "左\n"
+#~ "右"
+
+#~ msgid ""
+#~ "Isn't displayed\n"
+#~ "Goes after initial title\n"
+#~ "Goes before initial title\n"
+#~ "Replace initial title"
+#~ msgstr ""
+#~ "表示しない\n"
+#~ "初期タイトルの後に表示\n"
+#~ "初期タイトルの前に表示\n"
+#~ "初期タイトルを置き換える"
+
+#~ msgid ""
+#~ "Hold the terminal open\n"
+#~ "Restart the command\n"
+#~ "Exit the terminal"
+#~ msgstr ""
+#~ "ターミナルを開いたままにする\n"
+#~ "コマンドを再起動\n"
+#~ "ターミナルを終了"
+
+#~ msgid ""
+#~ "Custom\n"
+#~ "Green on Black\n"
+#~ "Black on White\n"
+#~ "White on Black"
+#~ msgstr ""
+#~ "カスタム\n"
+#~ "黒地に緑\n"
+#~ "白地に黒\n"
+#~ "黒地に白"
+
+#~ msgid ""
+#~ "On the Left\n"
+#~ "On the Right\n"
+#~ "Disabled"
+#~ msgstr ""
+#~ "左側\n"
+#~ "右側\n"
+#~ "無効"
+
+#~ msgid "Key Binding"
+#~ msgstr "キーバインド"
+
+#~ msgid "Grab Keybinding"
+#~ msgstr "キーバインドを取得"
diff --git a/src/tilda_terminal.c b/src/tilda_terminal.c
index d9b2fc1..0ed49a1 100644
--- a/src/tilda_terminal.c
+++ b/src/tilda_terminal.c
@@ -102,6 +102,9 @@ static void tilda_terminal_switch_page_cb (GtkNotebook *notebook,
 
 struct tilda_term_ *tilda_term_init (struct tilda_window_ *tw)
 {
+#ifndef NO_UTF8_CJK
+    gchar *vte_cjk_width = NULL;
+#endif
     DEBUG_FUNCTION ("tilda_term_init");
     DEBUG_ASSERT (tw != NULL);
 
@@ -197,6 +200,15 @@ struct tilda_term_ *tilda_term_init (struct tilda_window_ *tw)
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
