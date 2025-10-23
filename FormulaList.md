# z80oolong/vte に含まれる Formula 一覧

## 概要

本文書では、[Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/vte``` に含まれる Formula 一覧を示します。各 Formula の詳細については、```brew info <formula>``` コマンドも参照してください。

## Formula 一覧

### z80oolong/vte/libvte@2.91

[GTK][DGTK] の端末エミュレータウィジェットを提供するライブラリである [libvte][LVTE] の安定版および HEAD 版をインストールするための Formula です。これ以降に述べる [libvte][LVTE] ベースの端末エミュレータを持つアプリケーションがこのライブラリに依存します。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [libvte][LVTE] は、keg-only でインストールされます。** この Formula によりインストールされる [libvte][LVTE] を使用するには、```brew link --force z80oolong/vte/libvte@2.91``` コマンドを実行する必要があります。

### z80oolong/vte/sakura

[GTK][DGTK] と [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] のうち、最新の安定版および HEAD 版をインストールするための Formula です。

この Formula によりインストールされた [sakura][SAKU] では、**Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字および罫線文字等、[East Asian Width 特性が A (Ambiguous)][EAWA] の文字（以下、[East Asian Ambiguous Character][EAWA]）が、日本語環境で適切な文字幅として扱われず表示が乱れる問題（以下、[East Asian Ambiguous Character][EAWA] 問題）が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [East Asian Ambiguous Character][EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [East Asian Ambiguous Character][EAWA] を半角文字幅で表示します。

  [sakura][SAKU] において、[East Asian Ambiguous Character][EAWA] を全角文字幅で表示する場合、以下のようにして ```sakura``` を起動します。

  ```
    $ export VTE_CJK_WIDTH=1 # 環境変数を設定
    $ sakura
    # または
    $ env VTE_CJK_WIDTH=1 sakura
  ```

### z80oolong/vte/sakura@{version}

(注：上記 ```{version}``` には、[sakura][SAKU] の各バージョン番号が入ります。)

この Formula は、```z80oolong/vte/sakura``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] の安定版 [sakura {version}][SAKU] をインストールします。

この Formula でインストールした [sakura][SAKU] の使用法については、前述の ```z80oolong/vte/sakura``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [sakura][SAKU] は、keg-only でインストールされます。** この Formula によりインストールされる [sakura][SAKU] を使用するには、```brew link --force z80oolong/vte/sakura@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/sakura@9999-dev

この Formula によりインストールされる [sakura][SAKU] では、差分ファイルの適用により、```z80oolong/vte/sakura``` において述べた [East Asian Ambiguous Character][EAWA] 問題が修正されます。

さらに、この Formula は、Formula ```z80oolong/vte/sakura``` のコードに組み込まれている、直近に作成された HEAD 版向けの差分ファイルを、その差分ファイルに対応する [sakura][SAKU] の HEAD 版のコミットに適用したものをインストールします。

また、この Formula によりインストールされる [sakura][SAKU] の具体的なコミットについては、```brew info z80oolong/vte/sakura@9999-dev``` コマンドで出力されるメッセージを参照してください。

なお、この Formula によりインストールされた [sakura][SAKU] の使用法については、前述の ```z80oolong/vte/sakura``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [sakura][SAKU] は、keg-only でインストールされます。** この Formula によりインストールされる [sakura][SAKU] を使用するには、```brew link --force z80oolong/vte/sakura@9999-dev``` コマンドを実行してください。
    - **この Formula は、```z80oolong/vte/sakura``` による [sakura][SAKU] の最新の HEAD 版のインストール時に差分ファイルの適用で不具合が発生する場合に、暫定的に使用するものです。** 通常の場合は、```z80oolong/vte/sakura``` を使用してください。

### z80oolong/vte/roxterm

[libvte][LVTE] ベースであり、場所をとらないタブ式端末エミュレータである [roxterm][ROXT] のうち、最新の安定版および HEAD 版をインストールするための Formula です。

この Formula によりインストールされた [roxterm][ROXT] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によりインストールされた [roxterm][ROXT] では、**一部のメニューおよび設定画面の表示を除き、メニューおよび設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化が行われています。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [East Asian Ambiguous Character][EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [East Asian Ambiguous Character][EAWA] を半角文字幅で表示します。

### z80oolong/vte/roxterm@{version}

(注：上記 ```{version}``` には、[roxterm][ROXT] の各バージョン番号が入ります。)

この Formula は、```z80oolong/vte/roxterm``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [roxterm][ROXT] の安定版 [roxterm {version}][ROXT] をインストールします。

この Formula でインストールした [roxterm][ROXT] の使用法については、前述の ```z80oolong/vte/roxterm``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [roxterm][ROXT] は、keg-only でインストールされます。** この Formula によりインストールされる [roxterm][ROXT] を使用するには、```brew link --force z80oolong/vte/roxterm@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/roxterm@9999-dev

この Formula によりインストールされる [roxterm][ROXT] では、差分ファイルの適用により、```z80oolong/vte/roxterm``` において述べた [East Asian Ambiguous Character][EAWA] 問題が修正されます。また、この Formula によりインストールされた [roxterm][ROXT] では、一部のメニューおよび設定画面の表示を除き、メニューおよび設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化が行われています。

さらに、この Formula は、Formula ```z80oolong/vte/roxterm``` のコードに組み込まれている、直近に作成された HEAD 版向けの差分ファイルを、その差分ファイルに対応する [roxterm][ROXT] の HEAD 版のコミットに適用したものをインストールします。

また、この Formula によりインストールされる [roxterm][ROXT] の具体的なコミットについては、```brew info z80oolong/vte/roxterm@9999-dev``` コマンドで出力されるメッセージを参照してください。

なお、この Formula によりインストールされた [roxterm][ROXT] の使用法については、前述の ```z80oolong/vte/roxterm``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [roxterm][ROXT] は、keg-only でインストールされます。** この Formula によりインストールされる [roxterm][ROXT] を使用するには、```brew link --force z80oolong/vte/roxterm@9999-dev``` コマンドを実行してください。
    - **この Formula は、```z80oolong/vte/roxterm``` による [roxterm][ROXT] の最新の HEAD 版のインストール時に差分ファイルの適用で不具合が発生する場合に、暫定的に使用するものです。** 通常の場合は、```z80oolong/vte/roxterm``` を使用してください。

### z80oolong/vte/tilda

[libvte][LVTE] ベースであり、設定可能なドロップダウン端末エミュレータである [tilda][TILD] のうち、最新の安定版および HEAD 版をインストールするための Formula です。

この Formula によりインストールされた [tilda][TILD] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によりインストールされた [tilda][TILD] では、**一部のメニューおよび設定画面の表示を除き、メニューおよび設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化が行われています。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [East Asian Ambiguous Character][EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [East Asian Ambiguous Character][EAWA] を半角文字幅で表示します。

### z80oolong/vte/tilda@{version}

(注：上記 ```{version}``` には、[tilda][TILD] の各バージョン番号が入ります。)

この Formula は、```z80oolong/vte/tilda``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [tilda][TILD] の安定版 [tilda {version}][TILD] をインストールします。

この Formula でインストールした [tilda][TILD] の使用法については、前述の ```z80oolong/vte/tilda``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [tilda][TILD] は、keg-only でインストールされます。** この Formula によりインストールされる [tilda][TILD] を使用するには、```brew link --force z80oolong/vte/tilda@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/tilda@9999-dev

この Formula によりインストールされる [tilda][TILD] では、差分ファイルの適用により、```z80oolong/vte/tilda``` において述べた [East Asian Ambiguous Character][EAWA] 問題が修正されます。また、この Formula によりインストールされた [tilda][TILD] では、一部のメニューおよび設定画面の表示を除き、メニューおよび設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化が行われています。

さらに、この Formula は、Formula ```z80oolong/vte/tilda``` のコードに組み込まれている、直近に作成された HEAD 版向けの差分ファイルを、その差分ファイルに対応する [tilda][TILD] の HEAD 版のコミットに適用したものをインストールします。

また、この Formula によりインストールされる [tilda][TILD] の具体的なコミットについては、```brew info z80oolong/vte/tilda@9999-dev``` コマンドで出力されるメッセージを参照してください。

なお、この Formula によりインストールされた [tilda][TILD] の使用法については、前述の ```z80oolong/vte/tilda``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [tilda][TILD] は、keg-only でインストールされます。** この Formula によりインストールされる [tilda][TILD] を使用するには、```brew link --force z80oolong/vte/tilda@9999-dev``` コマンドを実行してください。
    - **この Formula は、```z80oolong/vte/tilda``` による [tilda][TILD] の最新の HEAD 版のインストール時に差分ファイルの適用で不具合が発生する場合に、暫定的に使用するものです。** 通常の場合は、```z80oolong/vte/tilda``` を使用してください。

### z80oolong/vte/lxterminal

[libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータである [lxterminal][LXTM] のうち、最新の安定版および HEAD 版をインストールするための Formula です。

この Formula によりインストールされた [lxterminal][LXTM] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [East Asian Ambiguous Character][EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [East Asian Ambiguous Character][EAWA] を半角文字幅で表示します。

### z80oolong/vte/lxterminal@{version}

(注：上記 ```{version}``` には、[lxterminal][LXTM] の各バージョン番号が入ります。)

この Formula は、```z80oolong/vte/lxterminal``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 [lxterminal {version}][LXTM] をインストールします。

この Formula でインストールした [lxterminal][LXTM] の使用法については、前述の ```z80oolong/vte/lxterminal``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [lxterminal][LXTM] は、keg-only でインストールされます。** この Formula によりインストールされる [lxterminal][LXTM] を使用するには、```brew link --force z80oolong/vte/lxterminal@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/lxterminal@9999-dev

この Formula によりインストールされる [lxterminal][LXTM] では、差分ファイルの適用により、```z80oolong/vte/lxterminal``` において述べた [East Asian Ambiguous Character][EAWA] 問題が修正されます。

さらに、この Formula は、Formula ```z80oolong/vte/lxterminal``` のコードに組み込まれている、直近に作成された HEAD 版向けの差分ファイルを、その差分ファイルに対応する [lxterminal][LXTM] の HEAD 版のコミットに適用したものをインストールします。

また、この Formula によりインストールされる [lxterminal][LXTM] の具体的なコミットについては、```brew info z80oolong/vte/lxterminal@9999-dev``` コマンドで出力されるメッセージを参照してください。

なお、この Formula によりインストールされた [lxterminal][LXTM] の使用法については、前述の ```z80oolong/vte/lxterminal``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [lxterminal][LXTM] は、keg-only でインストールされます。** この Formula によりインストールされる [lxterminal][LXTM] を使用するには、```brew link --force z80oolong/vte/lxterminal@9999-dev``` コマンドを実行してください。
    - **この Formula は、```z80oolong/vte/lxterminal``` による [lxterminal][LXTM] の最新の HEAD 版のインストール時に差分ファイルの適用で不具合が発生する場合に、暫定的に使用するものです。** 通常の場合は、```z80oolong/vte/lxterminal``` を使用してください。

### z80oolong/vte/geany

[libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] のうち、最新の安定版および HEAD 版をインストールするための Formula です。

この Formula によりインストールされた [geany][GEAN] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

- **環境変数**: ```VTE_CJK_WIDTH```
    - **```VTE_CJK_WIDTH=1``` の場合**: [geany][GEAN] の端末機能において、[East Asian Ambiguous Character][EAWA] を全角文字幅で表示します。
    - **それ以外の値（または未設定）の場合**: [East Asian Ambiguous Character][EAWA] を半角文字幅で表示します。

### z80oolong/vte/geany@{version}

(注：上記 ```{version}``` には、[geany][GEAN] の各バージョン番号が入ります。)

この Formula は、```z80oolong/vte/geany``` において述べた問題を修正した [libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] の安定版 [geany {version}][GEAN] をインストールします。

この Formula でインストールした [geany][GEAN] の使用法については、前述の ```z80oolong/vte/geany``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [geany][GEAN] は、keg-only でインストールされます。** この Formula によりインストールされる [geany][GEAN] を使用するには、```brew link --force z80oolong/vte/geany@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/geany@9999-dev

この Formula によりインストールされる [geany][GEAN] では、差分ファイルの適用により、```z80oolong/vte/geany``` において述べた [East Asian Ambiguous Character][EAWA] 問題が修正されます。

さらに、この Formula は、Formula ```z80oolong/vte/geany``` のコードに組み込まれている、直近に作成された HEAD 版向けの差分ファイルを、その差分ファイルに対応する [geany][GEAN] の HEAD 版のコミットに適用したものをインストールします。

また、この Formula によりインストールされる [geany][GEAN] の具体的なコミットについては、```brew info z80oolong/vte/geany@9999-dev``` コマンドで出力されるメッセージを参照してください。

なお、この Formula によりインストールされた [geany][GEAN] の使用法については、前述の ```z80oolong/vte/geany``` の Formula についての記述を参照してください。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる [geany][GEAN] は、keg-only でインストールされます。** この Formula によりインストールされる [geany][GEAN] を使用するには、```brew link --force z80oolong/vte/geany@9999-dev``` コマンドを実行してください。
    - **この Formula は、```z80oolong/vte/geany``` による [geany][GEAN] の最新の HEAD 版のインストール時に差分ファイルの適用で不具合が発生する場合に、暫定的に使用するものです。** 通常の場合は、```z80oolong/vte/geany``` を使用してください。

### z80oolong/vte/lua@5.1

```z80oolong/vte/geany```、```z80oolong/vte/geany@{version}```、```z80oolong/vte/geany@9999-dev``` のプラグインに依存する Lua 5.1 処理系をインストールするための Formula です。

- **注意**: 
    - **この Formula は、versioned formula であるため、この Formula によりインストールされる Lua 5.1 は、keg-only でインストールされます。** この Formula によりインストールされる Lua 5.1 を使用するには、```brew link --force z80oolong/vte/lua@5.1``` コマンドを実行する必要があります。

<!-- 外部リンク一覧 -->

[BREW]: https://linuxbrew.sh/  
[TMUX]: https://tmux.github.io/  
[EAWA]: http://www.unicode.org/reports/tr11/#Ambiguous  
[LXDE]: http://www.lxde.org/  
[LXTM]: https://github.com/lxde/lxterminal  
[DGTK]: https://gtk.org/  
[LVTE]: https://github.com/GNOME/vte  
[SAKU]: https://github.com/dabisu/sakura  
[ROXT]: https://github.com/realh/roxterm  
[TILD]: https://github.com/lanoxx/tilda/  
[GEAN]: https://www.geany.org/
