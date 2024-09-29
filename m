Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617929892CB
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 04:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727578742;
	bh=nL1fM1AJ+aK+h2v0o3WB9gqbS/N1IBqXlRVveJ88yVA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ebuxIi4JdAxWZ4a55Eq0LIXaUFtcZ3fphCwHZ/65f0P7MrzM0sYH5Skpy1v6xZzb4
	 47AykzajQxOUOgI2lXCpdxZ7KxFLaADn+IOmWqg5kKm1cYHqBuG6OKQO6zbJ3bYmNh
	 /2P/Uft53IT0LSNZVhFyYmthzdfyWgTSe0EOTeBF96D1e5nwjxR6s4u4cl5g1kA8Zj
	 Zpx6yXI9JHxgAKZLizYrQRZ9rPP612pQVxrF01WtEceP9RZWlAHjtCdYXinJFz3M9P
	 5vVEm1Ef60eyjoUIN5mr0tZz2wyJ79ctVTbZ9PTbLLhY1o7NnxvegK2uivEMHjy4lW
	 AkoP/ZaAh8TGA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XGTS63NW7z2ykC
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 12:59:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727578739;
	cv=none; b=TfYmFYLtOhchK7DPb8fg85eRNiidjjmSLufLkmQU9dNC0y2xT/UYEVW82jOdDY+NjRiIfedoTxheWg5gFLsORlh4+2v7egfclXruWjS7Z8Rny1h7SR9WZGS7j4FvCJqZnFImQ92+wToVIPKd/kzU48HBXGdr78j/YFfTfoyHz8xt+uf9vAyuyk49dmOUJBtDTAI0Yy+y9q5LPXzP7aDHFxdzjzSQE3SynNgk1yXQBq+Ae3+4RcyX/m5b0OGhq9Nc5jhXZo0AgPEhHApRlGAMND/dI/1f8iCb7zb/ji0++SLGt7Y3n4xgN1LLAi4hgHC87n3uGq0g2JHiXCqFiBPFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727578739; c=relaxed/relaxed;
	bh=nL1fM1AJ+aK+h2v0o3WB9gqbS/N1IBqXlRVveJ88yVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyeSuJk2rMbFDyv1ptOnsgamgDp2+JAiaSZ4+jYnlov6G1FeQcWfhUTyvBYat2UNMdMV/QJjH4PvcIKXeHNX8YdPDHhzkYemAhpZam5LVPLQEvDIos7/t+AP002d1Hd8X9BvnP0KBwf/zItf/M1bMMxKBbo1zG9kZMOAqhmma/kbiSx96VNASOFCpbspH97IujH/RJ5hNF5MVKeG6qE8sea2VUhPccWufcrOXvv0JLbfZED+leE+8KC5ySSMbW5wsBl1/QVqmLQDiMYLCSUpkMTBnO5oEe7KB+CEDGBcsg//Y2OsJG02BDw/EW+6faGwYft8HYwmrcdwhwRozic2jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=EBZoYdKT; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=EBZoYdKT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XGTS23hDcz2xqc
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Sep 2024 12:58:58 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A442697C4;
	Sat, 28 Sep 2024 22:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1727578731; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=nL1fM1AJ+aK+h2v0o3WB9gqbS/N1IBqXlRVveJ88yVA=;
	b=EBZoYdKTUSS2PYxkKVc7woni3n28idYLtWygQMHoCFTIO59AYIxLGdbIxjeC1mZ4QqVxbN
	vxFE47kDCJX8aMWI1tZi46W6RYxazYAxQHJCcbEAK4K2U5pYUlQEDrVwbe0gbMokXb+Wy4
	nS1D9NMoZyUezXc3aL6dKJjAwCgqdse8GVlJsTRGwltO3NDe827CTrijYxDZtZSvMkSi2+
	3jeZvHHFLV0V2cnY3WG3KJxDPPMssoEz8JD4pc0GiNHAc3rqsYrykHz8CVfu1Hz8WkXN0/
	k0FvtjCjOgSEiGYUy1GkQB2SuRmvOuc6xdj6AlXJBch6rjlWu7enKSvo8KfOyA==
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: rust: add rust version fuse program
Date: Sun, 29 Sep 2024 10:58:30 +0800
Message-ID: <20240929025830.354941-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds new configure script for checking
cross-compiling rustc/cargo/rustup and build erofsfuse
Rust version fuse based on autotools. The Xattr feature
hasn't been completed yet.

The program is the same copy from erofs-rs repo[1]

[1]: https://github.com/ToolmanP/erofs-rs

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 Makefile.am           |   5 +
 configure.ac          |  48 ++++-
 rust/fuse/Cargo.lock  | 359 ++++++++++++++++++++++++++++++++++++++
 rust/fuse/Cargo.toml  |   9 +
 rust/fuse/Makefile.am |  14 ++
 rust/fuse/src/main.rs | 394 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 rust/fuse/Cargo.lock
 create mode 100644 rust/fuse/Cargo.toml
 create mode 100644 rust/fuse/Makefile.am
 create mode 100644 rust/fuse/src/main.rs

diff --git a/Makefile.am b/Makefile.am
index fc464e8..959b123 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,6 +3,11 @@
 ACLOCAL_AMFLAGS = -I m4
 
 SUBDIRS = man lib mkfs dump fsck
+
 if ENABLE_FUSE
+if ENABLE_RUST
+SUBDIRS += rust/fuse
+else
 SUBDIRS += fuse
 endif
+endif
diff --git a/configure.ac b/configure.ac
index 9c1657b..38e1ae6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -171,6 +171,15 @@ AC_ARG_WITH(selinux,
       ;;
     esac], [with_selinux=no])
 
+AC_ARG_WITH(rust,
+   [AS_HELP_STRING([--with-rust],
+      [enable and build with rust implementation @<:@default=no@:>@])],
+   [case "$with_rust" in
+      yes|no) ;;
+      *) AC_MSG_ERROR([invalid argument to --with-rust])
+      ;;
+    esac], [with_rust=no])
+
 # Checks for libraries.
 # Use customized LZ4 library path when specified.
 AC_ARG_WITH(lz4-incdir,
@@ -364,6 +373,37 @@ AS_IF([test "x$with_selinux" != "xno"], [
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_selinux="no"])
 
+# Configure Rust
+AS_IF([test "x$with_rust" != "xno"], [
+   RUSTC_TARGET=""
+   RUSTC_MODE=""
+   case "$build" in
+      *linux*)
+         arch="${build%%-*}"
+         RUSTC_TARGET="${arch}-unknown-linux-gnu" 
+         ;;
+      *apple*)
+         AC_MSG_ERROR(["Apple Rust Build isn't supported currently."])
+         ;;
+   esac
+   AC_PATH_PROG([RUSTUP], [rustup], [notfound])
+   AS_IF([test "x$RUSTUP" = "xnotfound"], [AC_MSG_ERROR([rustup is required for rust build.])])
+   AC_PATH_PROG([CARGO], [cargo], [notfound])
+   AS_IF([test "x$CARGO" = "xnotfound"], [AC_MSG_ERROR([cargo is required for rust build.])])
+   AC_PATH_PROG([RUSTC], [rustc], [notfound])
+   AS_IF([test "x$RUSTC" = "xnotfound"], [AC_MSG_ERROR([rustc is required for rust build.])])
+   AC_MSG_CHECKING([whether rustc has target $RUSTC_TARGET installed])
+   AS_IF([test "xCFLAGS" = *-g*], [RUSTC_MODE="debug"], [RUSTC_MODE="release"])
+   if $RUSTUP target list | grep -q $RUSTC_TARGET; then
+      AC_MSG_RESULT([yes])
+   else
+      AC_MSG_RESULT([no])
+      AC_MSG_ERROR([Rust tatget $RUSTC_TARGET is not installed. Please run 'rustup target add $RUSTC_TARGET' to install it.])
+   fi
+   AC_SUBST(RUSTC_TARGET)
+   AC_SUBST(RUSTC_MODE)
+], [have_rust="no"])
+
 # Configure fuse
 AS_IF([test "x$enable_fuse" != "xno"], [
   # Paranoia: don't trust the result reported by pkgconfig before trying out
@@ -566,6 +606,7 @@ AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_RUST], [test "x${with_rust}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -575,6 +616,10 @@ if test "x$have_selinux" = "xyes"; then
   AC_DEFINE([HAVE_LIBSELINUX], 1, [Define to 1 if libselinux is found])
 fi
 
+if test "x${with_rust}" = "xyes"; then
+  AC_DEFINE([HAVE_RUST], 1, [Define to 1 if rust is enabled.])
+fi
+
 if test "x${have_lz4}" = "xyes"; then
   AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
 
@@ -634,5 +679,6 @@ AC_CONFIG_FILES([Makefile
 		 mkfs/Makefile
 		 dump/Makefile
 		 fuse/Makefile
-		 fsck/Makefile])
+		 fsck/Makefile
+                 rust/fuse/Makefile])
 AC_OUTPUT
diff --git a/rust/fuse/Cargo.lock b/rust/fuse/Cargo.lock
new file mode 100644
index 0000000..d4f72d2
--- /dev/null
+++ b/rust/fuse/Cargo.lock
@@ -0,0 +1,359 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "anstream"
+version = "0.6.15"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "64e15c1ab1f89faffbf04a634d5e1962e9074f2741eef6d97f3c4e322426d526"
+dependencies = [
+ "anstyle",
+ "anstyle-parse",
+ "anstyle-query",
+ "anstyle-wincon",
+ "colorchoice",
+ "is_terminal_polyfill",
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle"
+version = "1.0.8"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1bec1de6f59aedf83baf9ff929c98f2ad654b97c9510f4e70cf6f661d49fd5b1"
+
+[[package]]
+name = "anstyle-parse"
+version = "0.2.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "eb47de1e80c2b463c735db5b217a0ddc39d612e7ac9e2e96a5aed1f57616c1cb"
+dependencies = [
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle-query"
+version = "1.1.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6d36fc52c7f6c869915e99412912f22093507da8d9e942ceaf66fe4b7c14422a"
+dependencies = [
+ "windows-sys",
+]
+
+[[package]]
+name = "anstyle-wincon"
+version = "3.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5bf74e1b6e971609db8ca7a9ce79fd5768ab6ae46441c572e46cf596f59e57f8"
+dependencies = [
+ "anstyle",
+ "windows-sys",
+]
+
+[[package]]
+name = "byteorder"
+version = "1.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
+
+[[package]]
+name = "clap"
+version = "4.5.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b0956a43b323ac1afaffc053ed5c4b7c1f1800bacd1683c353aabbb752515dd3"
+dependencies = [
+ "clap_builder",
+ "clap_derive",
+]
+
+[[package]]
+name = "clap_builder"
+version = "4.5.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4d72166dd41634086d5803a47eb71ae740e61d84709c36f3c34110173db3961b"
+dependencies = [
+ "anstream",
+ "anstyle",
+ "clap_lex",
+ "strsim",
+]
+
+[[package]]
+name = "clap_derive"
+version = "4.5.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4ac6a0c7b1a9e9a5186361f67dfa1b88213572f427fb9ab038efb2bd8c582dab"
+dependencies = [
+ "heck",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "clap_lex"
+version = "0.7.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1462739cb27611015575c0c11df5df7601141071f07518d56fcc1be504cbec97"
+
+[[package]]
+name = "colorchoice"
+version = "1.0.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d3fd119d74b830634cea2a0f58bbd0d54540518a14397557951e79340abc28c0"
+
+[[package]]
+name = "erofs-sys"
+version = "0.1.0"
+source = "git+https://github.com/ToolmanP/erofs-rs.git#b2b45d5e7fa5eebe48f5bc2a21c48fff820df8a1"
+
+[[package]]
+name = "erofsfuse"
+version = "0.1.0"
+dependencies = [
+ "clap",
+ "erofs-sys",
+ "fuser",
+]
+
+[[package]]
+name = "fuser"
+version = "0.11.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "104ed58f182bc2975062cd3fab229e82b5762de420e26cf5645f661402694599"
+dependencies = [
+ "libc",
+ "log",
+ "memchr",
+ "page_size",
+ "pkg-config",
+ "smallvec",
+ "users",
+ "zerocopy",
+]
+
+[[package]]
+name = "heck"
+version = "0.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+
+[[package]]
+name = "is_terminal_polyfill"
+version = "1.70.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
+
+[[package]]
+name = "libc"
+version = "0.2.159"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "561d97a539a36e26a9a5fad1ea11a3039a67714694aaa379433e580854bc3dc5"
+
+[[package]]
+name = "log"
+version = "0.4.22"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c54bba33a7f72f873a39d07b24"
+
+[[package]]
+name = "memchr"
+version = "2.7.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+
+[[package]]
+name = "page_size"
+version = "0.4.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "eebde548fbbf1ea81a99b128872779c437752fb99f217c45245e1a61dcd9edcd"
+dependencies = [
+ "libc",
+ "winapi",
+]
+
+[[package]]
+name = "pkg-config"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "953ec861398dccce10c670dfeaf3ec4911ca479e9c02154b3a215178c5f566f2"
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.86"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.37"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b5b9d34b8991d19d98081b46eacdd8eb58c6f2b201139f7c5f643cc155a633af"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "smallvec"
+version = "1.13.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
+
+[[package]]
+name = "strsim"
+version = "0.11.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+
+[[package]]
+name = "syn"
+version = "2.0.79"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "89132cd0bf050864e1d38dc3bbc07a0eb8e7530af26344d3d2bbbef83499f590"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.13"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e91b56cd4cadaeb79bbf1a5645f6b4f8dc5bde8834ad5894a8db35fda9efa1fe"
+
+[[package]]
+name = "users"
+version = "0.11.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "24cc0f6d6f267b73e5a2cadf007ba8f9bc39c6a6f9666f8cf25ea809a153b032"
+dependencies = [
+ "libc",
+ "log",
+]
+
+[[package]]
+name = "utf8parse"
+version = "0.2.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+
+[[package]]
+name = "winapi"
+version = "0.3.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+dependencies = [
+ "winapi-i686-pc-windows-gnu",
+ "winapi-x86_64-pc-windows-gnu",
+]
+
+[[package]]
+name = "winapi-i686-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+
+[[package]]
+name = "winapi-x86_64-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+
+[[package]]
+name = "windows-sys"
+version = "0.52.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+dependencies = [
+ "windows-targets",
+]
+
+[[package]]
+name = "windows-targets"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+dependencies = [
+ "windows_aarch64_gnullvm",
+ "windows_aarch64_msvc",
+ "windows_i686_gnu",
+ "windows_i686_gnullvm",
+ "windows_i686_msvc",
+ "windows_x86_64_gnu",
+ "windows_x86_64_gnullvm",
+ "windows_x86_64_msvc",
+]
+
+[[package]]
+name = "windows_aarch64_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+
+[[package]]
+name = "windows_aarch64_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+
+[[package]]
+name = "windows_i686_gnu"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+
+[[package]]
+name = "windows_i686_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+
+[[package]]
+name = "windows_i686_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+
+[[package]]
+name = "windows_x86_64_gnu"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+
+[[package]]
+name = "windows_x86_64_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+
+[[package]]
+name = "windows_x86_64_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+
+[[package]]
+name = "zerocopy"
+version = "0.6.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "854e949ac82d619ee9a14c66a1b674ac730422372ccb759ce0c39cabcf2bf8e6"
+dependencies = [
+ "byteorder",
+ "zerocopy-derive",
+]
+
+[[package]]
+name = "zerocopy-derive"
+version = "0.6.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "125139de3f6b9d625c39e2efdd73d41bdac468ccd556556440e322be0e1bbd91"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
diff --git a/rust/fuse/Cargo.toml b/rust/fuse/Cargo.toml
new file mode 100644
index 0000000..26a63d3
--- /dev/null
+++ b/rust/fuse/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "erofsfuse"
+version = "0.1.0"
+edition = "2021"
+
+[dependencies]
+fuser = "0.11"
+erofs-sys = { git = "https://github.com/ToolmanP/erofs-rs.git" }
+clap = { version = "4", features = ["derive", "cargo"] }
diff --git a/rust/fuse/Makefile.am b/rust/fuse/Makefile.am
new file mode 100644
index 0000000..6b0e9fe
--- /dev/null
+++ b/rust/fuse/Makefile.am
@@ -0,0 +1,14 @@
+AUTOMAKE_OPTIONS = foreign
+
+EXTRA_PROGRAMS  = target/$(RUSTC_TARGET)/$(RUSTC_MODE)/erofsfuse
+EXTRA_DIST = src/main.rs Cargo.toml Cargo.lock
+
+all-local:
+	$(CARGO) build -vvv --$(RUSTC_MODE) --target $(RUSTC_TARGET)
+
+install-exec-local:
+	$(MKDIR_P) $(DESTDIR)$(bindir)
+	$(INSTALL_PROGRAM) target/$(RUSTC_TARGET)/$(RUSTC_MODE)/erofsfuse-rs $(DESTDIR)$(bindir)/erofsfuse
+
+clean-local:
+	$(CARGO) clean
diff --git a/rust/fuse/src/main.rs b/rust/fuse/src/main.rs
new file mode 100644
index 0000000..c929e2f
--- /dev/null
+++ b/rust/fuse/src/main.rs
@@ -0,0 +1,394 @@
+use clap::{arg, Parser};
+use erofs_sys::data::backends::uncompressed::UncompressedBackend;
+use erofs_sys::data::*;
+use erofs_sys::dir::DirentDesc;
+use erofs_sys::errnos::Errno::*;
+use erofs_sys::file::ImageFileSystem;
+use erofs_sys::inode::*;
+use erofs_sys::operations::*;
+use erofs_sys::superblock::FileSystem as ErofsFileSystem;
+use erofs_sys::superblock::SuperBlock;
+use erofs_sys::xattrs::*;
+use erofs_sys::{Nid, Off, PosixResult};
+use fuser::Filesystem as FuseFileSystem;
+use fuser::MountOption;
+use fuser::{
+    FileAttr, FileType, ReplyAttr, ReplyData, ReplyDirectory, ReplyEntry, Request, FUSE_ROOT_ID,
+};
+use std::collections::{hash_map::Entry, HashMap};
+use std::ffi::OsStr;
+use std::ffi::*;
+use std::fs::File;
+use std::mem::size_of;
+use std::os::unix::ffi::OsStrExt;
+use std::os::unix::fs::FileExt;
+use std::path::Path;
+use std::sync::{Arc, Mutex};
+use std::time::Duration;
+use std::time::SystemTime;
+use std::time::UNIX_EPOCH;
+
+struct FuseCollection(HashMap<Nid, SimpleInode>);
+struct FuseFile(File);
+
+impl Source for FuseFile {
+    fn fill(&self, data: &mut [u8], _device_id: i32, offset: Off) -> PosixResult<u64> {
+        self.0
+            .read_at(data, offset)
+            .map_or(Err(ERANGE), |size| Ok(size as u64))
+    }
+}
+
+impl FileSource for FuseFile {}
+
+struct SimpleInode {
+    info: InodeInfo,
+    xattr_shared_entries: XAttrSharedEntries,
+    nid: Nid,
+}
+
+impl Inode for SimpleInode {
+    fn new(_sb: &SuperBlock, info: InodeInfo, nid: Nid, xattr_header: XAttrSharedEntries) -> Self {
+        Self {
+            info,
+            xattr_shared_entries: xattr_header,
+            nid,
+        }
+    }
+    fn xattrs_shared_entries(&self) -> &XAttrSharedEntries {
+        &self.xattr_shared_entries
+    }
+    fn nid(&self) -> Nid {
+        self.nid
+    }
+    fn info(&self) -> &InodeInfo {
+        &self.info
+    }
+}
+
+impl InodeCollection for FuseCollection {
+    type I = SimpleInode;
+    fn iget(&mut self, nid: Nid, f: &dyn ErofsFileSystem<Self::I>) -> PosixResult<&mut Self::I> {
+        match self.0.entry(nid) {
+            Entry::Vacant(v) => {
+                let info = f.read_inode_info(nid)?;
+                let xattrs_header = f.read_inode_xattrs_shared_entries(nid, &info)?;
+                Ok(v.insert(Self::I::new(f.superblock(), info, nid, xattrs_header)))
+            }
+            Entry::Occupied(o) => Ok(o.into_mut()),
+        }
+    }
+    fn release(&mut self, nid: Nid) {
+        self.0.remove(&nid);
+    }
+}
+
+struct ErofsFuse {
+    filesystem: Box<dyn ErofsFileSystem<SimpleInode>>,
+    collection: FuseCollection,
+}
+
+fn system_time_from_time(secs: i64, nsecs: u32) -> SystemTime {
+    if secs >= 0 {
+        UNIX_EPOCH + Duration::new(secs as u64, nsecs)
+    } else {
+        UNIX_EPOCH - Duration::new((-secs) as u64, nsecs)
+    }
+}
+
+fn file_type_from_type(ty: Type) -> FileType {
+    match ty {
+        Type::Regular => FileType::RegularFile,
+        Type::Directory => FileType::Directory,
+        Type::Link => FileType::Symlink,
+        Type::Fifo => FileType::NamedPipe,
+        Type::Character => FileType::CharDevice,
+        Type::Block => FileType::BlockDevice,
+        Type::Socket => FileType::Socket,
+        Type::Unknown => panic!("Unknown Type"),
+    }
+}
+
+fn get_file_attr_from_filesystem_inode(inode: &SimpleInode, sb: &SuperBlock) -> FileAttr {
+    match *inode.info() {
+        InodeInfo::Extended(e) => FileAttr {
+            atime: system_time_from_time(e.i_mtime as i64, e.i_mtime_nsec),
+            ino: inode.nid() + FUSE_ROOT_ID,
+            size: e.i_size,
+            blocks: sb.blk_round_up_generic(e.i_size) as u64,
+            mtime: system_time_from_time(e.i_mtime as i64, e.i_mtime_nsec),
+            ctime: system_time_from_time(e.i_mtime as i64, e.i_mtime_nsec),
+            crtime: system_time_from_time(e.i_mtime as i64, e.i_mtime_nsec),
+            perm: inode.info().inode_perm(),
+            kind: file_type_from_type(inode.info().inode_type()),
+            nlink: e.i_nlink,
+            blksize: 512,
+            uid: e.i_uid,
+            gid: e.i_gid,
+            rdev: 0,
+            flags: 0,
+        },
+        InodeInfo::Compact(c) => FileAttr {
+            atime: system_time_from_time(sb.build_time, sb.build_time_nsec as u32),
+            ino: inode.nid() + FUSE_ROOT_ID,
+            size: c.i_size as u64,
+            blocks: sb.blk_round_up_generic(c.i_size as u64) as u64,
+            mtime: system_time_from_time(sb.build_time, sb.build_time_nsec as u32),
+            ctime: system_time_from_time(sb.build_time, sb.build_time_nsec as u32),
+            crtime: system_time_from_time(sb.build_time, sb.build_time_nsec as u32),
+            perm: inode.info().inode_perm(),
+            kind: file_type_from_type(inode.info().inode_type()),
+            nlink: c.i_nlink as u32,
+            blksize: 512,
+            uid: c.i_uid as u32,
+            gid: c.i_gid as u32,
+            rdev: 0,
+            flags: 0,
+        },
+    }
+}
+
+fn filetype_from_dtype(ty: u8) -> FileType {
+    match ty {
+        1 => FileType::RegularFile,
+        2 => FileType::Directory,
+        3 => FileType::CharDevice,
+        4 => FileType::BlockDevice,
+        5 => FileType::NamedPipe,
+        6 => FileType::Socket,
+        7 => FileType::Symlink,
+        _ => panic!("unknown"),
+    }
+}
+
+fn nid_to_ino(sb: &SuperBlock, nid: Nid) -> u64 {
+    if nid == sb.root_nid as u64 {
+        FUSE_ROOT_ID
+    } else {
+        nid + FUSE_ROOT_ID
+    }
+}
+impl ErofsFuse {
+    fn ino_to_nid(&self, ino: u64) -> Nid {
+        if ino == FUSE_ROOT_ID {
+            self.filesystem.superblock().root_nid as u64
+        } else {
+            ino - FUSE_ROOT_ID
+        }
+    }
+    fn nid_to_ino(&self, nid: Nid) -> u64 {
+        if nid == self.filesystem.superblock().root_nid as u64 {
+            FUSE_ROOT_ID
+        } else {
+            nid + FUSE_ROOT_ID
+        }
+    }
+    fn try_read_link(&mut self, ino: u64) -> PosixResult<Vec<u8>> {
+        let inode = self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())?;
+        let mut symlink: Vec<u8> = Vec::new();
+        for res in self.filesystem.mapped_iter(inode, 0)? {
+            let block = res?;
+            let data = block.content();
+            symlink.extend_from_slice(data);
+        }
+        symlink.push(b'\0');
+        Ok(symlink)
+    }
+    fn try_read(&mut self, ino: u64, offset: i64, mut size: u32) -> PosixResult<Vec<u8>> {
+        let inode = self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())?;
+        let mut result: Vec<u8> = Vec::new();
+        for res in self.filesystem.mapped_iter(inode, offset as u64)? {
+            let block = res?;
+            let data = block.content();
+            let nsize = data.len().min(size as usize);
+            result.extend_from_slice(&data[..nsize]);
+            size -= nsize as u32;
+            if size == 0 {
+                break;
+            }
+        }
+        Ok(result)
+    }
+}
+const TTL: Duration = Duration::from_secs(1); // 1 second
+impl FuseFileSystem for ErofsFuse {
+    fn init(&mut self, _req: &Request<'_>, _config: &mut fuser::KernelConfig) -> Result<(), c_int> {
+        Ok(())
+    }
+    fn readdir(
+        &mut self,
+        _req: &Request<'_>,
+        ino: u64,
+        _fh: u64,
+        offset: i64,
+        mut reply: ReplyDirectory,
+    ) {
+        let sb = self.filesystem.superblock();
+        match self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())
+        {
+            Ok(inode) => {
+                let mut count = 1;
+                match self
+                    .filesystem
+                    .fill_dentries(inode, 0, offset as u64, &mut |dirent, _| {
+                        if reply.add(
+                            nid_to_ino(sb, dirent.desc().nid),
+                            count + 1,
+                            filetype_from_dtype(dirent.desc().file_type),
+                            OsStr::from_bytes(dirent.dirname()),
+                        ) {
+                            true
+                        } else {
+                            count += 1;
+                            false
+                        }
+                    }) {
+                    Ok(()) => reply.ok(),
+                    Err(e) => reply.error(e as i32),
+                }
+            }
+            Err(e) => reply.error(e as i32),
+        }
+    }
+    fn lookup(
+        &mut self,
+        _req: &Request<'_>,
+        parent: u64,
+        _name: &std::ffi::OsStr,
+        reply: ReplyEntry,
+    ) {
+        let nid = self.ino_to_nid(parent);
+        match lookup(
+            self.filesystem.as_filesystem(),
+            &mut self.collection,
+            nid,
+            _name.to_str().unwrap(),
+        ) {
+            Ok(inode) => {
+                reply.entry(
+                    &TTL,
+                    &get_file_attr_from_filesystem_inode(inode, self.filesystem.superblock()),
+                    0,
+                );
+            }
+            Err(e) => reply.error(e as i32),
+        }
+    }
+    fn getattr(&mut self, _req: &Request<'_>, ino: u64, reply: ReplyAttr) {
+        match self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())
+        {
+            Ok(inode) => reply.attr(
+                &TTL,
+                &get_file_attr_from_filesystem_inode(inode, self.filesystem.superblock()),
+            ),
+            Err(e) => reply.error(e as i32),
+        }
+    }
+
+    fn readlink(&mut self, _req: &Request<'_>, ino: u64, reply: ReplyData) {
+        match self.try_read_link(ino) {
+            Ok(symlink) => reply.data(&symlink),
+            Err(e) => reply.error(e as i32),
+        }
+    }
+
+    fn read(
+        &mut self,
+        _req: &Request,
+        ino: u64,
+        _fh: u64,
+        offset: i64,
+        size: u32,
+        _flags: i32,
+        _lock: Option<u64>,
+        reply: ReplyData,
+    ) {
+        match self.try_read(ino, offset, size) {
+            Ok(data) => reply.data(&data),
+            Err(e) => reply.error(e as i32),
+        }
+    }
+    fn open(&mut self, _req: &Request<'_>, ino: u64, _flags: i32, reply: fuser::ReplyOpen) {
+        match self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())
+        {
+            Ok(_) => reply.opened(0, 0),
+            Err(e) => reply.error(e as i32),
+        }
+    }
+    fn opendir(&mut self, _req: &Request<'_>, ino: u64, _flags: i32, reply: fuser::ReplyOpen) {
+        match self
+            .collection
+            .iget(self.ino_to_nid(ino), self.filesystem.as_filesystem())
+        {
+            Ok(_) => reply.opened(0, 0),
+            Err(e) => reply.error(e as i32),
+        }
+    }
+    fn releasedir(
+        &mut self,
+        _req: &Request<'_>,
+        ino: u64,
+        _fh: u64,
+        _flags: i32,
+        reply: fuser::ReplyEmpty,
+    ) {
+        self.collection.release(self.ino_to_nid(ino));
+        reply.ok()
+    }
+    fn release(
+        &mut self,
+        _req: &Request<'_>,
+        ino: u64,
+        _fh: u64,
+        _flags: i32,
+        _lock_owner: Option<u64>,
+        _flush: bool,
+        reply: fuser::ReplyEmpty,
+    ) {
+        self.collection.release(self.ino_to_nid(ino));
+        reply.ok()
+    }
+}
+
+#[derive(Parser, Debug)]
+#[command(version, about, long_about = None)]
+struct ErofsArgs {
+    #[arg(short, long)]
+    image: String,
+    #[arg(short, long)]
+    mountpoint: String,
+}
+fn main() {
+    let args = ErofsArgs::parse();
+    let file = File::options()
+        .read(true)
+        .write(true)
+        .open(Path::new(&args.image))
+        .unwrap();
+    let filesystem =
+        Box::new(ImageFileSystem::try_new(UncompressedBackend::new(FuseFile(file))).unwrap());
+    let collection = FuseCollection(HashMap::new());
+    let erofs_fuse = ErofsFuse {
+        filesystem,
+        collection,
+    };
+    fuser::mount2(
+        erofs_fuse,
+        args.mountpoint,
+        &[
+            MountOption::FSName("erofs_fuse_rs".to_string()),
+            MountOption::AutoUnmount,
+        ],
+    )
+    .unwrap()
+}
-- 
2.46.1

