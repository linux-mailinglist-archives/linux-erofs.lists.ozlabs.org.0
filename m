Return-Path: <linux-erofs+bounces-3071-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y5T9BA43yGlziQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3071-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 21:16:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1034FEB0
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 21:16:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjpgD3PcJz2ySc;
	Sun, 29 Mar 2026 07:16:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774728968;
	cv=none; b=IE+Jilwjm9cMRtmFGody/0nIu7ijB/9BjWK9lOjNvsC3BWDXbv/JWFul8/WBz9fLTTb98YBbwlzkIECMROS8QXX6rJNgabujzh1g8mPiSHMExf2D4LkZCaBU3uULxJ/V63enlfMUnuqbCmHqjbrL9kO4a4w3pAb2CHzN0d2PbiG03fL/kpRkeGphR6IvxxD+VrGAB460vqRm0vYp77tc0Ww/JKPIBpwonHDTTWqELPqEOtIYvtOPb5XBpb/wfTy2SLgxZ7qialmIHsO+BZ8Gg5+T+t9Y5tEV8VWZ2VsVq2nK4aOa0ZwN/oH0sgpz7T8E0XVPYb0ZLmkihj5kzdmQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774728968; c=relaxed/relaxed;
	bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiIDZstMSInNMuETJ5FeglHXWz0zlHiXoWRlQ3z8a33mpJDGuT1660oZBlvMlNo7T5U3QYE7y03s7Dnmbad+2+EfB2aPbziIQqZVBKpNex4abst3l7q1WGztINQ78mJBzQri1GcuyhEYIkwgOeJ76X3x+QXckBhFlr/df7b9tSJDReZfdJA5o+lmz1l9eHfI+L6vip+Kk+4kknce0DB6TIeazETFSKrgtDP1/z7op16NohWbw5NBw5iv0HIf6xAvNzdKkWg03ycmW5pSk6Wn7ucooBBFp6eJ/5nwma0F4rvl/hUBeZYBuy9edWG8Rt2WMQY576xVxpTFDWxbkrxqug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pDmXqQFm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pDmXqQFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjpg96wpgz2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 07:16:04 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c766cf593daso2335758a12.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728961; x=1775333761; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=pDmXqQFmIbOTsOuKlidjS79XZAVgwTPhf6bFdmqjk1rfDJBQfPM8IRya4eq6nwD09R
         PBoLaiS+GRXH+S1g70M7yU2kQoGq38odfx8EQodN3AAomqZIY2SwWE9bJXoilsJk16rq
         g67CKt6YHeD12DCNoljRdA3rCcDnSMlBDVResdpivlU8AAjSyldIYcQJZHYMMz3CHIxx
         h06EpxQKXkhQausnRl0Nc2OH/Fmnymryrtg1iy8J6Kqbh5Sgov/szJ9+JQo1p4+Kg9ed
         T8QBFpH+/7WPlx23sG/VyX1G8oHetDiNbhf5WN2+yx9IE8spCx3ZTq52LKpJiVqQFkl7
         ODUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728961; x=1775333761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=NyMfRoLfCLAyn3Yn2rb2w4aPgnuynWQGvmwBo2dejmpxULVm49jzaQkTwYa6EsXJ8F
         G9bkvuq4IS24IHOFHqKclU5CeWoGGj4gjUozS+YO6cqJUgppl/GVB2CKaN0Q7p+dOr5n
         6ZFz9yT132J4iUbGTP1due0O7HsvlSZbtLnIFOt19+a77BjVWZUXlcgkwIzXNC6kFG5u
         NXjsmaZ8X+2yG0vv8bAZjottrd2GrlsQ3M7mbewVZv2zZ0/6kTDyhVVUAgiFkcn0KnDy
         MVeD3xyrUlHmKPRt/b9KoZddpBrhUOynSM59YCy/VzFrmJGAAveCQNNIG651rS6If1XP
         94xw==
X-Gm-Message-State: AOJu0Ywn2Vm9BLCrrAf8K5Kicnlm/xoIlUuM52sk2vcbMGvOCy5gda0I
	U6rlDSagQK8KdVWCtF2OZoyp85Rd9ICjwml+yWJsKh5fesXCAa5lYhD+gSD5hFZ4
X-Gm-Gg: ATEYQzyIflfzu0a7qt+ZCNIJqqvA+9H/vu7i3bSOHTPoiIORK9xK7ty+ueU+fA1tEH+
	0LYk/1FDUwcCcUTjvY6w2tPYEw7X381ATbh5W6IRUrvd+zKw3CA7FOhn//3vQrOzTeqRXlkOK+2
	2SFwwIhqvMnkH+c2C4LQWpzbt8ros9ARTzPrp6UBnmAib1iHOJ1Uc8600znaVrLylAvs5BfS0I5
	p7itOLvgl3ti9HhhxBnVZ1ijinypSOiM9NJJYxwC35EQCSyoU7qwhUqTwJg2rcK8NBmAxLxC4lH
	HRg2wmKSPzLHgAJlEv4EHs828czQd0xhez51E9KRQZbaDbHLpUf1rk52I5o2ZziuwZLUTsxphJq
	hnUhSoIyY6VRe3g12v0cIU1yn2RhZIsLmM2+LBw+5goLMhGO5M5BOjY2dbv2DErUkNFb4GVDmKD
	tfTYcRqujtwgPVDIGgdxZtmdf8KJMwFrg=
X-Received: by 2002:a05:6a20:6a0d:b0:398:c0ef:e155 with SMTP id adf61e73a8af0-39c8790c8e1mr7582034637.15.1774728961146;
        Sat, 28 Mar 2026 13:16:01 -0700 (PDT)
Received: from kali ([110.227.40.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb809sm2430852a12.28.2026.03.28.13.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:16:00 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Saksham <aghi.saksham5@gmail.com>
Subject: [PATCH] erofs-utils: fix typos and enhance installation guide
Date: Sun, 29 Mar 2026 01:45:55 +0530
Message-ID: <20260328201555.5192-1-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3071-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 74A1034FEB0
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


