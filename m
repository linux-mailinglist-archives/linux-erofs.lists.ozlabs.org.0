Return-Path: <linux-erofs+bounces-3094-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIcEBm4Iymk64gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3094-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D0355774
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfkL0yBYz2ygl;
	Mon, 30 Mar 2026 16:21:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848106;
	cv=none; b=QQeYYyGTguW9KE8HJMM99lX9eH09VAEP6L6vUUEsA5zx4ngjlBqQ4YxbGXOUVSYcuj2qCEpqQnRlzgxUrk9rVipFSr5Ij/y4qja25CYH7N6rfFnaPm8d8fYRnlQrhi460QCoep9kGV/6DNgFEzTkBKYBbmuL25R190qHuGyCm+BHYZxd1Mmfbz+18jvm6R9x/tBu6oROe5at3J2jOoZOCKSUP89XsV82G6WOe6WTsY1PdwyvdzDGuTHKkPz4kZn+tSZb1qrwccaY0gMH7r1enY/C/+5kb5eP1UmAnaxBwRJJ0Pn/yIUUCb+fH9oDT1Dn918an9o6ivBHVbMsTKWHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848106; c=relaxed/relaxed;
	bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnGdg981w0EQ9dvI+Ga4WM/iNyxwm9tgTZdQZGSZgj2/SAEaBBl2wzIHei4hkMQyf6yKgG5wPUl2i0T34bMcY1LjmJ4nfvD3HFG4z0R1sSS5q5KTlt6cPuAv2YTGPHj5+TvZUNnoVHOSpTCzk10IVl2zdFrMxaN+8+X/F8S/odwmHUBj9DjcgYStBgBwI4EZnwDjup72tkPt2URV1eL9wmVn99myA7I4qaDllFFSUR+KHibRCp77IoB5K/dRG6x6zvcK6LIzoiWuuNC11evNA5KiYoyp9T5RXc4kVxxgGILgrSmN5PlFCQKCEF4s+jnram6/mru1qxTDkkqq0rQTMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLn/94kg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLn/94kg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfkK39Rjz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:21:45 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a9296b3926so25892595ad.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848103; x=1775452903; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=hLn/94kg4if4jMJpPEZx+zSsH8S2gaHkEEagqT0P4Rgi/TZX+OSnU5qkqQoYd9LF9a
         NcKH0ilsSab3o3xPdTQhOfiy2CBZO6FtbI2aqsVOcWzlsy8N1/vGTbSr/MkimL4M+PxD
         5qhwjRCyS6ro16w6aHi9tVXTSxw1F+owSNPMo6t4ZI83kcCMUpSnd+Rb5Po0odMlJdsO
         6H0cmywNFGrISbKROmFyR4GFqoUG8Qcxac2EoZKamyw+B5VVlUVEKZcXwHbBFbo3mOTL
         X9PLTJy4w3+1WpfoBE2SoYaiP38PJ8AtNHoxOvaRqzxr6ArYkFlWC3CSiXVsKG+W2w0e
         JCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848103; x=1775452903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=Dt436C3Kf59w56Wk9pzT2gT+LiLVEaA94gbrX3HH+377Eu/sy6zQYiZT8ul0+QhJOl
         LaSt6/4ha2ayiSe/Afuvc3Fu3lSHzbNgRlSgFqBiEC0Qi7Dh7HhHHh80yxf2ihP+sE6a
         66crvCTXq7UrGykUpT7clai7OjIwJkIFjiH4xGQEP6zHkncGfkkQGvgazYnw+v+fZ9dx
         ZBC83LkMlxGLbhQwMkFNgSIUeQsuMNsRZeZ5+epMKimjlcqultCrEq2f9cOyCDYHYJRv
         B4lLP6sDaispd2xNdmPwD8Mgk+w9NNHYRKusmD5HIYFNsQTf8BhShWb5yO1+Fsjis/jX
         eneg==
X-Gm-Message-State: AOJu0YyP4xY0Fo8puHCNW7qHThpvVnyWId91hGk89BnmxlGeN5VP25th
	FcLYbIKTWCxDPKZIeUFXS2lQqpPM/LuJBKMROBGniVnLB2+P/oPkTDK5esbRhrSs
X-Gm-Gg: ATEYQzzLR8wjM+xhqZgxQWn7L6tj2NOfbqPnRe2TV370LlBKRTtxEkHyS/xQpsieziP
	vRoB8bxF4Q842m12nIn43aKPdrhgHPZEy3hrEXn4Qgz8SLFS2QrwpUMvI0UIXsiU2bnlJN4pxyi
	8kNDvnLB/uajwyN0jHWO2fcO8PkP+rhxCEsM5o0XbRtsW2Ub3BWUpRfH2Syl704ZlH61PCi4W0T
	1Jy+FCmDxki8r87359OgkCLbC2RaUyD4Ea/U0LOMQe1giSRdT4Nzo7k6qTymOZSda9evZ2LbW0N
	7OL6es53dinCuGHMbQmSgSDqYmNH35HuQNf/5rQ+ZWy5Ml2vowxv978CMdoA2cdPKZLEjW44lAd
	2Mulk8QwKF0rzh72ff8NsfD0ad1pLENZ96SKiUiWfDEZo9byu1zo23g0zSVyw2ZJFgTUZBs6jMT
	RINc5pO+skV1w2tBXaJY51+NTgUaljS2iuBw==
X-Received: by 2002:a17:903:2287:b0:2b2:42b1:ad9a with SMTP id d9443c01a7336-2b242b1b124mr73254095ad.19.1774848102916;
        Sun, 29 Mar 2026 22:21:42 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b15a2sm78624325ad.73.2026.03.29.22.21.41
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:21:42 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: fix typos and enhance installation guide
Date: Mon, 30 Mar 2026 10:51:36 +0530
Message-ID: <20260330052137.9273-2-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330052137.9273-1-aghi.saksham5@gmail.com>
References: <20260330052137.9273-1-aghi.saksham5@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3094-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 713D0355774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch addresses several issues in the README and docs/INSTALL.md
to improve the overall documentation quality and provide a better
experience for new users and developers.

First, multiple instances of "plusters" were found in the README file.
These were typos for "pclusters" (physical clusters), which is a key
concept in EROFS for block-level compression and data management.
Correcting these ensures technical accuracy and avoids confusion
for users trying to understand the filesystem's behavior, especially
regarding the "big pcluster" feature introduced in Linux 5.13.

Specifically:
- Fixed "big plusters" to "big pclusters" in the section describing
  high-compression image generation.
- Fixed "4k plusters" to "4k pclusters" in the compression hints
  example section.

Second, the installation documentation in docs/INSTALL.md was updated
to provide a more streamlined onboarding process. A "Quick Start"
section was added at the top, listing all common prerequisites for
Debian-based systems (Ubuntu, etc.). This allows users to quickly
get all necessary libraries (lz4, xz, uuid, fuse, etc.) and build
the project with a single set of commands.

Third, a new section was added to docs/INSTALL.md regarding
multithreading support. While multithreading is enabled by default
in mkfs.erofs if the compiler and environment support it, it was
not explicitly documented in the INSTALL guide. The new section
explains how to explicitly enable it with --enable-multithreading
or disable it with --disable-multithreading, providing users with
more control over their build configuration.

These changes ensure that the documentation remains up-to-date
with the latest features of erofs-utils and provides clear
instructions for both new and experienced users.
---
 README          |  4 ++--
 docs/INSTALL.md | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 1ca376f..6f9e761 100644
--- a/README
+++ b/README
@@ -122,7 +122,7 @@ images.  Users may prefer smaller images for archiving purposes, even if
 random performance is compromised with those configurations, and even
 worse when using 4KiB blocks.
 
-In order to fulfill users' needs, big plusters has been introduced
+In order to fulfill users' needs, big pclusters has been introduced
 since Linux 5.13, in which each physical clusters will be more than one
 blocks.
 
@@ -159,7 +159,7 @@ write a compress-hints file like below:
 and specify with `--compress-hints=` so that ".so" files will use
 "lz4hc,12" compression with 4k pclusters, ".txt" files will use
 "lzma,9" compression with 32k pclusters, files  under "/sbin" will use
-the default "lzma" compression with 4k plusters and other files will
+the default "lzma" compression with 4k pclusters and other files will
 use "lzma" compression with 16k pclusters.
 
 Note that the largest pcluster size should be specified with the "-C"
diff --git a/docs/INSTALL.md b/docs/INSTALL.md
index 2e818da..d96b15c 100644
--- a/docs/INSTALL.md
+++ b/docs/INSTALL.md
@@ -4,6 +4,26 @@ source.
 See the [README](../README) file in the top level directory about
 the brief overview of erofs-utils.
 
+## Quick Start
+
+For those who want a quick build, ensure that the following prerequisites are
+installed (on Debian/Ubuntu):
+
+``` sh
+$ sudo apt-get install autoconf automake libtool pkg-config uuid-dev \
+                       liblz4-dev liblzma-dev libfuse-dev zlib1g-dev \
+                       libselinux1-dev libzstd-dev
+```
+
+Then, run the following commands to build and install:
+
+``` sh
+$ ./autogen.sh
+$ ./configure
+$ make
+# make install
+```
+
 ## Dependencies & build
 
 LZ4 1.9.3+ for LZ4(HC) enabled [^1].
@@ -45,6 +65,18 @@ $ make
 Additionally, you could specify liblzma target paths with
 `--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
 
+## How to build with multithreading
+
+To enable multithreading support for mkfs.erofs, use the following:
+
+``` sh
+$ ./configure --enable-multithreading
+$ make
+```
+
+Note that multithreading is enabled by default if the compiler supports it.
+To disable it explicitly, use `--disable-multithreading`.
+
 ## How to build erofsfuse
 
 It's disabled by default as an experimental feature for now due
-- 
2.53.0


