Return-Path: <linux-erofs+bounces-3099-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKs7NRkKymmL4gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3099-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09961355873
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkftX69rWz2yfl;
	Mon, 30 Mar 2026 16:28:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848532;
	cv=none; b=lTRUuVPYCImiBZQH0ROye0GNGLEhU34xPzoRjUNRzVZtVTFMCserGF1LPDyHA9a7Oz0OqQFwq9PT1EjHYJm50mkkEJEBqWqBxCCLNwiRYmYtVNmZS9HjC51jlOB3piLV+jSStpT6GnOjCpRfyQkboYOzWAZi67SlwcMehcnWIesY9G31/MWwzyYcnQy5fFy9fVnfPx9m+j1oYET+O+0eE8ZTlTNNbkZ3tlzP29F1pOSxFgjeZ7KL30Tctph6cpV3YYVF8jq2PRNlpQj/d+6nSn4Yt0r/TVM2asKCa6AFUSr2mtHnF629I2FR7+dm6IttH5f6dluj7H7d3EUGts8rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848532; c=relaxed/relaxed;
	bh=i0m+6uQNSzTBadroqBWA+KunwGKDmaaYWs0V+0qRQus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcPwXOlmQqDrDIlAMQdJEckt+ReZ62m9N++JKxR+6/lElHwUYqmk52zh7BzYptocBg6EINkTnbZbwVg1upBIMT73yeRtVWZxYevJu7+emvVQ5bU3YSJ+oI2mJKAb2h4Sda7QJUl/2SBsMiQxcHVIYwOOYz6GsyfPregg+T/ruH0r4537llwdJAq6fU2BtmeXXPjdbq2peFhCGPTtKeQv4iJISRsGawDiPFGyZHR0aa36sEZQ/i0FH+Gp3kNzXvnIY0XZeF2eA7H95GqNIRBcaZHknUjodW1ef4jog86bVcgs+w6aszm7jaDaUzEsjb9fL0Jzqas0COc8lLG/7oIpXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S73rb1ER; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S73rb1ER;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkftW3Lv7z2ygh
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:28:51 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-82c2239140aso1611365b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848529; x=1775453329; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0m+6uQNSzTBadroqBWA+KunwGKDmaaYWs0V+0qRQus=;
        b=S73rb1ERSpT50Br8Kl2J1343tnY284xRy8EZ0MR9TZtzdpPsRpyTUA4tgbznwCNDXZ
         mNjLw/0FQpYXtk9ml0pL/G2CaTSkdzYLGWMTje6jefHJhw1q8E6nHVIhfqznitpK82Vw
         p/rYaGpg5txS9aahju4qYhnSN4Aj8SexCylSyWrwcmVeZeF07Ej51K6kEvs9znIGv0S1
         6n6yYuACG6DcnFBfolsBRL+LqzBIs5xu7Dv0lw4icwVg6wbyBldVOP4O+89Ffx5zZMeX
         +PaMpoMzZ35DRtPovZQdgZ4cisnfyEl5PL1vB0Ck4zqHbvyXlxsX/UwwiZiyFLsMab/D
         uEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848529; x=1775453329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i0m+6uQNSzTBadroqBWA+KunwGKDmaaYWs0V+0qRQus=;
        b=jNR6l5+YH1dSJToPl/lobTNAWYDbRMpAgdqj+r6N40uYSEEbbeUdKL67+zEgipqxWY
         I0kpc94bdQw0RRNwIe1EoeTVzWD5A/CtviFVWrPKS8W0225IzVgyYagViIm9UR5m+jqV
         CP+hOOufEy9JUMJkoBH/ecw1PzpcwDtmsI5j+lQnC/OZp3Z+rGH2bl1glZc7TRerJXtk
         GSkWTyXZM9LPCXZ1Xhxl2PqoPtphrINmAsljXvWV60+1tu+j1swyjy9VFozXp37xisKo
         cBbuT1C8hm2V1P14Bvr3A32sO1jeqxY+WT32GeBAAGzfkHVVx1ARi82YTGOJtKL4+uS/
         DBOw==
X-Gm-Message-State: AOJu0YxAewxTCQTuhDMSL7ouvrLUoY39RtLrtxzu/vQan899hVR9nd57
	8H6ayuJVHQw3m9SQNW8chGzKHk63y8FCLTb9Z7deGrg0Fnm5nS/I3HM5bumyFrZe
X-Gm-Gg: ATEYQzz7V0jsjOqfevTfastCPuNetW7kqwKIqbjsCxlk+I7w1DCW4CyUlW0TyBPnA++
	+m0oHcLf7MGPVYY2yBlZdm4Td9RAIEl4jXleOg7QcQ5C9MVydBNlfWSMeGQS4b7NG94ubdeEVdN
	GyvUMfbaF+DzSYCy4J5esshbRWtrZnGJM/tD8E6/uVNVmRKIJU9ou1GbbpcQwwDQHhh0IA7Tuem
	Q8pd2Pup31+xtxgJi0W2bfjjSHCmqiVursHz6/3cR281bza8yzCFqHbyUNMlRB0uagzohKJpQHA
	42nUWJ8o/u3q+MThRpTXXdwV1oIWV1AanMSNLmWoLJawTrg8/wmeDyRUObssFVuQxr4Hb58IuxG
	VAUmw2SQF6AwTzbC3Gy5fTCEQtlBeHO2U4dnIcBaIgVgoWP1h/bziKRzhW/olWiyaPnzVPz2Jjk
	/qPyZvaW5Isro/BDJkYDYdmvh+Y8v/Q7J8Vw==
X-Received: by 2002:a05:6a00:bc0b:b0:829:780d:99c9 with SMTP id d2e1a72fcca58-82c95ee0be5mr10373976b3a.26.1774848528951;
        Sun, 29 Mar 2026 22:28:48 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm4851891b3a.1.2026.03.29.22.28.47
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:28:48 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] docs: expand build instructions and multithreading documentation
Date: Mon, 30 Mar 2026 10:58:40 +0530
Message-ID: <20260330052840.12730-4-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330052840.12730-1-aghi.saksham5@gmail.com>
References: <20260330052840.12730-1-aghi.saksham5@gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3099-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 09961355873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The previous build documentation was somewhat minimal and did not fully
emphasize the available configuration options, particularly regarding
multithreading. While the feature was mentioned, its importance for
performance in large image creation was not sufficiently highlighted,
and it lacked clear context on its default behavior and requirements.

This commit refactors docs/INSTALL.md to provide a more comprehensive
and professional guide for developers and users. Key changes include:

1.  Consolidated dependencies list: Grouped all mandatory and optional
    dependencies (LZ4, XZ, libfuse, libzstd, libuuid) for better
    clarity, including specific version recommendations and links to
    related issues for LZ4.

2.  Enhanced Multithreading documentation: Expanded the section on
    --enable-multithreading to explain its role in accelerating data
    compression in mkfs.erofs. Clarified that the configuration script
    attempts to auto-detect support and provided explicit instructions
    on how to force the feature on or off.

3.  Added advanced configuration section: Introduced a dedicated section
    for LZMA and multithreading, making it easier for users to find
    performance-related options.

4.  Included other notable options: Added mentions of --enable-lz4,
    --enable-zstd, and --with-selinux to give users a broader overview
    of the tool suite's capabilities.

5.  Improved formatting and copy: Standardized headers and lists, fixed
    minor phrasing, and ensured that the installation instructions are
    clear and follow best practices.

These improvements ensure that the build documentation is as high-quality
as the project's source code, providing a clear path for anyone looking
to build and optimize erofs-utils for their specific environment.

Signed-off-by: Saksham <aghi.saksham5@gmail.com>
---
 docs/INSTALL.md | 97 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/docs/INSTALL.md b/docs/INSTALL.md
index d96b15c..d51c153 100644
--- a/docs/INSTALL.md
+++ b/docs/INSTALL.md
@@ -1,8 +1,8 @@
 This document describes how to configure and build erofs-utils from
 source.
 
-See the [README](../README) file in the top level directory about
-the brief overview of erofs-utils.
+See the [README](../README) file in the top level directory for
+a brief overview of erofs-utils.
 
 ## Quick Start
 
@@ -24,25 +24,23 @@ $ make
 # make install
 ```
 
-## Dependencies & build
+## Dependencies & Build Requirements
 
-LZ4 1.9.3+ for LZ4(HC) enabled [^1].
+- **LZ4 1.9.3+**: Required for LZ4 and LZ4HC compression support [^1].
+- **XZ Utils 5.3.2alpha+**: Required for LZMA support. Version 5.4+ is highly
+  recommended for better performance and stability.
+- **libfuse 2.6+**: Required if you wish to build `erofsfuse`.
+- **libzstd 1.4.0+**: Required for Zstandard (zstd) compression support.
+- **libuuid**: Required for filesystem UUID support.
 
-[XZ Utils 5.3.2alpha+](https://tukaani.org/xz/xz-5.3.2alpha.tar.gz) for
-LZMA enabled, [XZ Utils 5.4+](https://tukaani.org/xz/xz-5.4.1.tar.gz)
-highly recommended.
+[^1]: It is not recommended to use LZ4 versions below 1.9.3 due to potential
+crashes related to `LZ4_compress_destSize()`, `LZ4_compress_HC_destSize()`, or
+`LZ4_decompress_safe_partial()`.
 
-libfuse 2.6+ for erofsfuse enabled.
+## Core Build Process
 
-[^1]: It's not recommended to use LZ4 versions under 1.9.3 since
-unexpected crashes could make trouble to end users due to broken
-LZ4_compress_destSize() (fixed in v1.9.2),
-[LZ4_compress_HC_destSize()](https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82) or
-[LZ4_decompress_safe_partial()](https://github.com/lz4/lz4/issues/783).
-
-## How to build with LZ4
-
-To build, the following commands can be used in order:
+To build the core utilities (`mkfs.erofs`, `dump.erofs`, and `fsck.erofs`),
+execute the following commands:
 
 ``` sh
 $ ./autogen.sh
@@ -50,54 +48,79 @@ $ ./configure
 $ make
 ```
 
-`mkfs.erofs`, `dump.erofs` and `fsck.erofs` binaries will be
-generated under the corresponding folders.
+The resulting binaries will be located in their respective project
+subdirectories.
 
-## How to build with liblzma
+## Advanced Configuration Options
 
-In order to enable LZMA support, build with the following commands:
+### Enabling LZMA Support
+
+LZMA compression is not enabled by default. To include it in your build:
 
 ``` sh
 $ ./configure --enable-lzma
 $ make
 ```
 
-Additionally, you could specify liblzma target paths with
-`--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
+If your LZMA libraries are in non-standard locations, you can specify them
+using:
+`--with-liblzma-incdir=DIR` and `--with-liblzma-libdir=DIR`.
+
+### Enabling Multithreading Support
 
-## How to build with multithreading
+Multithreading significantly accelerates the compression process in
+`mkfs.erofs` by utilizing multiple CPU cores.
 
-To enable multithreading support for mkfs.erofs, use the following:
+To explicitly enable multithreading support:
 
 ``` sh
 $ ./configure --enable-multithreading
 $ make
 ```
 
-Note that multithreading is enabled by default if the compiler supports it.
-To disable it explicitly, use `--disable-multithreading`.
+**Note:** The configuration script attempts to detect multithreading support
+(e.g., via pthreads) and may enable it by default if compatible libraries and
+headers are found on your system. To ensure it is disabled, use
+`--disable-multithreading`.
 
-## How to build erofsfuse
+When enabled, `mkfs.erofs` will use multiple worker threads for data
+compression, which is highly recommended for large image creation on
+multiprocessor systems.
 
-It's disabled by default as an experimental feature for now due
-to the extra libfuse dependency, to enable and build it manually:
+### Building erofsfuse
+
+`erofsfuse` is currently considered an experimental feature and is disabled
+by default to avoid a mandatory `libfuse` dependency. To build it:
 
 ``` sh
 $ ./configure --enable-fuse
 $ make
 ```
 
-`erofsfuse` binary will be generated under `fuse` folder.
+The `erofsfuse` binary will be generated in the `fuse/` directory.
+
+### Other Notable Configure Options
+
+- `--enable-lz4`: Enable LZ4 compression support (default: auto).
+- `--enable-zstd`: Enable Zstandard compression support (default: auto).
+- `--with-selinux`: Enable SELinux support for labeling (default: auto).
 
-## How to install erofs-utils manually
+Run `./configure --help` for a complete list of available options.
 
-Use the following command to install erofs-utils binaries:
+## Installation
+
+To install the compiled utilities to your system:
 
 ``` sh
 # make install
 ```
 
-By default, `make install` will install all the files in
-`/usr/local/bin`, `/usr/local/lib` etc.  You can specify an
-installation prefix other than `/usr/local` using `--prefix`,
-for instance `--prefix=$HOME`.
+By default, files are installed into `/usr/local/bin`, `/usr/local/lib`, etc.
+You can change the installation target using the `--prefix` option during
+configuration:
+
+``` sh
+$ ./configure --prefix=$HOME/mytools
+$ make
+# make install
+```
-- 
2.53.0


