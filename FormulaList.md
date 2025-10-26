# z80oolong/vte に含まれる Formula 一覧

## 概要

本文書では、[Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/vte``` に含まれる Formula 一覧を示します。また、[libvte][LVTE] は、[GTK][DGTK] の端末エミュレータウィジェットを提供するライブラリです。さらに、このリポジトリは、東アジア圏の文字表示に関する問題（[East Asian Ambiguous Character][EAWA] 問題）を修正した端末エミュレータを提供します。各 Formula の詳細については、```brew info <formula>``` コマンドをご覧ください。

## Formula 一覧

### z80oolong/vte/libvte@2.91

[libvte][LVTE] の安定版および HEAD 版をインストールする Formula です。このライブラリは、以下に述べる [libvte][LVTE] ベースの端末エミュレータに依存します。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。**

### z80oolong/vte/sakura

[GTK][DGTK] と [libvte][LVTE] ベースの端末エミュレータ [sakura][SAKU] の最新安定版および HEAD 版をインストールする Formula です。

この Formula でインストールされた [sakura][SAKU] では、**Unicode の [East Asian Ambiguous Character][EAWA]（例: "◎" や "★" 等の記号文字や罫線文字）が日本語環境で適切な文字幅で表示されない問題（[EAWA] 問題）が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [EAWA] を半角文字幅で表示します。

  [EAWA] を全角文字幅で表示する場合、以下のように ```sakura``` を起動します。

  ```bash
  $ export VTE_CJK_WIDTH=1  # 環境変数を設定
  $ sakura
  # または
  $ env VTE_CJK_WIDTH=1 sakura
  ```

### z80oolong/vte/sakura@{version}

(注: ```{version}``` には [sakura][SAKU] の各バージョン番号が入ります。)

これは、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの端末エミュレータ [sakura][SAKU] の安定版をインストールする Formula です。使用法は ```z80oolong/vte/sakura``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [sakura][SAKU] を使用するには ```brew link --force z80oolong/vte/sakura@{version}``` を実行してください。**

### z80oolong/vte/sakura@9999-dev

これは、```z80oolong/vte/sakura@9999-dev``` に組み込まれた差分ファイルの適用により、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの端末エミュレータ [sakura][SAKU] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/vte/sakura@9999-dev``` に組み込まれている差分ファイルが [sakura][SAKU] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [sakura][SAKU] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/vte/sakura@9999-dev``` で確認できます。使用法は ```z80oolong/vte/sakura``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [sakura][SAKU] を使用するには ```brew link --force z80oolong/vte/sakura@9999-dev``` を実行してください。**
    - **この Formula は、```z80oolong/vte/sakura``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/vte/sakura``` をご使用ください。

### z80oolong/vte/roxterm

[GTK][DGTK] と [libvte][LVTE] ベースのタブ式端末エミュレータ [roxterm][ROXT] の最新安定版および HEAD 版をインストールする Formula です。

この Formula でインストールされた [roxterm][ROXT] では、**[EAWA] 問題が修正され、メニューや設定画面の一部を除き、機械翻訳による簡易な日本語化が行われています。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [EAWA] を半角文字幅で表示します。

### z80oolong/vte/roxterm@{version}

(注: ```{version}``` には [roxterm][ROXT] の各バージョン番号が入ります。)

これは、[EAWA] 問題の修正及び機械翻訳による簡易な日本語化を行った [GTK][DGTK] と [libvte][LVTE] ベースのタブ式端末エミュレータ [roxterm][ROXT] の安定版をインストールする Formula です。使用法は ```z80oolong/vte/roxterm``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [roxterm][ROXT] を使用するには ```brew link --force z80oolong/vte/roxterm@{version}``` を実行してください。**

### z80oolong/vte/roxterm@9999-dev

これは、```z80oolong/vte/roxterm@9999-dev``` に組み込まれた差分ファイルの適用により、[EAWA] 問題の修正及び機械翻訳による簡易な日本語化を行った [GTK][DGTK] と [libvte][LVTE] ベースのタブ式端末エミュレータ [roxterm][ROXT] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/vte/roxterm@9999-dev``` に組み込まれている差分ファイルが [roxterm][ROXT] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [roxterm][ROXT] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/vte/roxterm@9999-dev``` で確認できます。使用法は ```z80oolong/vte/roxterm``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [roxterm][ROXT] を使用するには ```brew link --force z80oolong/vte/roxterm@9999-dev``` を実行してください。**
    - **この Formula は、```z80oolong/vte/roxterm``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/vte/roxterm``` をご使用ください。

### z80oolong/vte/tilda

[GTK][DGTK] と [libvte][LVTE] ベースのドロップダウン端末エミュレータ [tilda][TILD] の最新安定版および HEAD 版をインストールする Formula です。

この Formula でインストールされた [tilda][TILD] では、**[EAWA] 問題が修正され、メニューや設定画面の一部を除き、機械翻訳による簡易な日本語化が行われています。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [EAWA] を半角文字幅で表示します。

### z80oolong/vte/tilda@{version}

(注: ```{version}``` には [tilda][TILD] の各バージョン番号が入ります。)

これは、[EAWA] 問題の修正及び機械翻訳による簡易な日本語化を行った [GTK][DGTK] と [libvte][LVTE] ベースのドロップダウン端末エミュレータ [tilda][TILD] の安定版をインストールする Formula です。使用法は ```z80oolong/vte/tilda``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [tilda][TILD] を使用するには ```brew link --force z80oolong/vte/tilda@{version}``` を実行してください。**

### z80oolong/vte/tilda@9999-dev

これは、```z80oolong/vte/tilda@9999-dev``` に組み込まれた差分ファイルの適用により、[EAWA] 問題の修正及び機械翻訳による簡易な日本語化を行った [GTK][DGTK] と [libvte][LVTE] ベースのドロップダウン端末エミュレータ [tilda][TILD] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/vte/tilda@9999-dev``` に組み込まれている差分ファイルが [tilda][TILD] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [tilda][TILD] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/vte/tilda@9999-dev``` で確認できます。使用法は ```z80oolong/vte/tilda``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [tilda][TILD] を使用するには ```brew link --force z80oolong/vte/tilda@9999-dev``` を実行してください。**
    - **この Formula は、```z80oolong/vte/tilda``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/vte/tilda``` をご使用ください。

### z80oolong/vte/lxterminal

[GTK][DGTK] と [libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータ [lxterminal][LXTM] の最新安定版および HEAD 版をインストールする Formula です。

この Formula でインストールされた [lxterminal][LXTM] では、**[EAWA] 問題が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [EAWA] を半角文字幅で表示します。

### z80oolong/vte/lxterminal@{version}

(注: ```{version}``` には [lxterminal][LXTM] の各バージョン番号が入ります。)

これは、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータ [lxterminal][LXTM] の安定版をインストールする Formula です。使用法は ```z80oolong/vte/lxterminal``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [lxterminal][LXTM] を使用するには ```brew link --force z80oolong/vte/lxterminal@{version}``` を実行してください。**

### z80oolong/vte/lxterminal@9999-dev

これは、```z80oolong/vte/lxterminal@9999-dev``` に組み込まれた差分ファイルの適用により、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータ [lxterminal][LXTM] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/vte/lxterminal@9999-dev``` に組み込まれている差分ファイルが [lxterminal][LXTM] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [lxterminal][LXTM] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/vte/lxterminal@9999-dev``` で確認できます。使用法は ```z80oolong/vte/lxterminal``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [lxterminal][LXTM] を使用するには ```brew link --force z80oolong/vte/lxterminal@9999-dev``` を実行してください。**
    - **この Formula は、```z80oolong/vte/lxterminal``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/vte/lxterminal``` をご使用ください。

### z80oolong/vte/geany

[GTK][DGTK] と [libvte][LVTE] ベースの軽量 IDE [geany][GEAN] の最新安定版および HEAD 版をインストールする Formula です。

この Formula でインストールされた [geany][GEAN] では、**[EAWA] 問題が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [geany][GEAN] の端末機能で [EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [EAWA] を半角文字幅で表示します。

### z80oolong/vte/geany@{version}

(注: ```{version}``` には [geany][GEAN] の各バージョン番号が入ります。)

これは、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの軽量 IDE [geany][GEAN] の安定版をインストールする Formula です。使用法は ```z80oolong/vte/geany``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [geany][GEAN] を使用するには ```brew link --force z80oolong/vte/geany@{version}``` を実行してください。**

### z80oolong/vte/geany@9999-dev

これは、```z80oolong/vte/geany@9999-dev``` に組み込まれた差分ファイルの適用により、[EAWA] 問題を修正した [GTK][DGTK] と [libvte][LVTE] ベースの軽量 IDE [geany][GEAN] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/vte/geany@9999-dev``` に組み込まれている差分ファイルが [geany][GEAN] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [geany][GEAN] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/vte/geany@9999-dev``` で確認できます。使用法は ```z80oolong/vte/geany``` の記述をご覧ください。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。この Formula によってインストールされた [geany][GEAN] を使用するには ```brew link --force z80oolong/vte/geany@9999-dev``` を実行してください。**
    - **この Formula は、```z80oolong/vte/geany``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/vte/geany``` をご使用ください。

### z80oolong/vte/lua@5.1

```z80oolong/vte/geany```、```z80oolong/vte/geany@{version}```、```z80oolong/vte/geany@9999-dev``` のプラグインに依存する Lua 5.1 処理系をインストールする Formula です。

- **注意**:
    - **この Formula は versioned formula のため、keg-only でインストールされます。**

## 詳細情報

- Homebrew の使用方法: ```brew help``` または ```man brew``` を実行してください。
- Homebrew for Linux: [Homebrew for Linux][BREW]

<!-- 外部リンク一覧 -->

[BREW]: https://linuxbrew.sh/  
[EAWA]: http://www.unicode.org/reports/tr11/#Ambiguous  
[LXDE]: http://www.lxde.org/  
[LXTM]: https://github.com/lxde/lxterminal  
[DGTK]: https://gtk.org/  
[LVTE]: https://github.com/GNOME/vte  
[SAKU]: https://github.com/dabisu/sakura  
[ROXT]: https://github.com/realh/roxterm  
[TILD]: https://github.com/lanoxx/tilda/  
[GEAN]: https://www.geany.org/
