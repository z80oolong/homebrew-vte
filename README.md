# z80oolong/vte -- libvte 対応端末エミュレータ及びアプリケーションの各種問題を修正する Formula 群

## 概要

[Homebrew for Linux][BREW] は、Linux の各ディストリビューションにおけるソースコードの取得およびビルドに基づくパッケージ管理システムです。このシステムを使用することで、ソースコードからのソフトウェアのインストールを簡単かつ効率的に行うことができます。

また、[libvte][LVTE] は、[GNOME][GNME] において端末エミュレータを実装するためのコア機能を [GTK ウィジェット][DGTK] のライブラリとしてまとめたものです。

さらに、この [Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/vte``` は、[libvte][LVTE] を基盤とする各種端末エミュレータおよびアプリケーションにおいて、以下の問題を修正します：

- **Unicode の規格における東アジア圏の文字の問題**：
    - いわゆる "◎" や "★" 等の記号文字や罫線文字等、[East Asian Width 特性が A (Ambiguous)][EAWA] の文字（以下、[East Asian Ambiguous Character][EAWA]）が、日本語環境で適切な全角文字幅や半角文字幅として扱われず、表示が乱れる問題があります（以下、[EAWA] 問題）。
    - 一部の端末エミュレータでは、環境変数 ```VTE_CJK_WIDTH``` を設定することで、[EAWA] 問題を適切に制御できます。
- **日本語化の未対応**：
    - 一部の端末エミュレータにおいて、メニューや設定画面等の表示が日本語化されていない問題があります。
    - 一部のメニューおよび設定画面を除き、機械翻訳による簡易な日本語翻訳に基づく日本語化を行っています。

このリポジトリは、上記の問題を修正した [libvte][LVTE] 対応の端末エミュレータおよびアプリケーションをインストールするための Formula 群を提供します。

なお、対応する端末エミュレータおよびアプリケーションの詳細については、本リポジトリに同梱される ```FormulaList.md``` を参照してください。

## 使用方法

- [Homebrew for Linux][BREW] を端末にインストールします。以下のリソースを参考にしてください：
    - [thermes 氏][THER] による "[Linuxbrew のススメ][THBR]"
    - [Homebrew for Linux 公式ページ][BREW]
- 本リポジトリの Formula を以下のようにインストールします：

```
  $ brew tap z80oolong/tmux
  $ brew install <formula>
```

または、一時的な方法として、以下のように URL を直接指定してインストール可能です：

```
  $ brew install https://raw.githubusercontent.com/z80oolong/homebrew-tmux/master/Formula/<formula>.rb
```

利用可能な Formula の一覧および詳細は、本リポジトリに同梱の ```FormulaList.md``` を参照してください。

## 詳細情報

本リポジトリおよび [Homebrew for Linux][BREW] の使用方法の詳細は、以下のコマンドやリソースを参照してください：

- ```brew help``` コマンド
- ```man brew``` コマンド
- [Homebrew for Linux 公式ページ][BREW]

## 謝辞

本リポジトリの作成にあたり、[GNOME の公式ドキュメント][DVTE] 等の資料を参照しました。[GNOME プロジェクト][GNME] の開発者コミュニティおよび [libvte][LVTE] 対応端末エミュレータやアプリケーションの開発者各位に心より感謝いたします。

## 使用条件

本リポジトリは、[Homebrew for Linux][BREW] の Tap リポジトリとして、[Homebrew for Linux の開発コミュニティ][BREW] および [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有します。本リポジトリは、[BSD 2-Clause License][BSD2] に基づいて配布されます。詳細については、本リポジトリに同梱される ```LICENSE``` を参照してください。

<!-- 外部リンク一覧 -->

[BREW]: https://linuxbrew.sh/
[GNME]: https://www.gnome.org/
[DGTK]: https://gtk.org/
[LVTE]: https://github.com/GNOME/vte
[EAWA]: http://www.unicode.org/reports/tr11/#Ambiguous
[THER]: https://qiita.com/thermes
[THBR]: https://qiita.com/thermes/items/926b478ff6e3758ecfea
[DVTE]: https://developer-old.gnome.org/vte/unstable/VteTerminal.html
[BSD2]: https://opensource.org/licenses/BSD-2-Clause
[ZOOL]: http://zool.jpn.org/
