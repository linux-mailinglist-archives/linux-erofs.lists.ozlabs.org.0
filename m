Return-Path: <linux-erofs+bounces-3091-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCp+NmcIymk64gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3091-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC54335575F
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfk84mfDz2xlK;
	Mon, 30 Mar 2026 16:21:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848096;
	cv=none; b=Pt9WX9n1NX1fOejQVl/c/lcFgg0NL4Fx2ruDu2nuceOCAHQ2TQ2WCUc0L/zAMbB5C6yO2fndxrzZfI8iyZjHpQ66M1MHd2bRBg7y3iNGXJcMv8VJ8rMM5w0cuZc9V4YcDFMnKivusbw1+TOXP9nDQSz+xdjx7P4xUV/Jzu6EU1ESw/MOuBGiX+7VzEH2wXWedhxvbbYZepNPHqno7vabNmAfSzGG3j4+Hwi8bTtCtNW+Rg98Pv1+wGZqfmdSBWWdB6ketq0bSMz3EinpCvHkNco/8RwJGmpKiFQnHExyX5Uz67G02ow2Y3IlNwFOKt4hkj4KAR2KM23lBtUk8m/FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848096; c=relaxed/relaxed;
	bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4bwD6sTZBlGyC2acDlxQFckSeNdbYPL1mKvwWg4NT2YJMJ1gAzH5R13lVy7QB4mBbG9ge3Gws53n0uxToG0SO1uC4efOD8QnPE5lQjCOhYV9lA+yl74ibK/MNZynMsWqG3EoiknodJn+ro1xdsa5yJc+9lOUNBD9x/YAUhL17uRu7myyVOD0w8Xz66FITBlUBnR/B0n9W6fE2HsfvoUPMJI8CIhEWJ/urUEAaAczdqW5nEbcHSURoESt6osRFL8EXJb5cBTotN7AuBu8thJP475PUodVwhX2yqL+tTyrgxX8VvYMitgN8D4TTTuZxB0BGD2QhwCFTA6Rr7aJbZeLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PscfbuJo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PscfbuJo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfk714Jxz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:21:34 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1701379a12.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848093; x=1775452893; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=PscfbuJoRiKn+LaYLXB77MGc+NS6U5c0xaHwhyFS0/zMVvxQ0tU/WhuQMmM3JREih4
         Ut9R+yphtNFzDBRkPquhNMxVxCcdksr9D7NChTScIb3sK6HwfDj1koNwpmtdMKhYYIiI
         H1r/HGUwGUK4gBVAakRbqrSZkBlR/L24Mn3OhVRoYt3m7mFoP/MNUCYzyWTp2C/YA6ar
         zMC+oc+UUeEgCM+vBxMDyB15YKlfPrfCdH4a8IEqi4yPbVDPBp1jr/MKbDSGO40OO2ah
         mbryzudV7GKtbS1ziGtSJu7iAT2VrX+ZPXqREESD8ohUj1JIhlhg7t5Ggd2kKHyL5mAX
         OhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848093; x=1775452893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=XsC1lHOrsKWJmXwcv+BRNSChniuSg0uGiP/csqJ/WOzvIkwTw2dAYDYqzOToJpPo82
         RrG7tPLL9St3KI1NfVEZoDJv/RDheeQz/m0G2HivKdBXnsqBnFTc9nXWLj1DgFihAUjK
         8tAWY06KZdLhMn2mK4fqZ8MITtM7tO3URXHbARpV9sKFwhgnj4kgW5S3lvZZqEw2/Igx
         BzcPblTZnrakXuRyYztXQ7zFcLxgWOdgP57vsNPneEUQBlFm7IgfIyFkx7PjtVXOf+5c
         EBijTX4xmKhX64VYVtfSMn42i99wgUutZ/PFUeqJXnXt0lQQNNxJXF1KlYl+kfpg9jjz
         yGog==
X-Gm-Message-State: AOJu0YxZ9N3fpnFhjZHeLKS/Zd5dJuIlrNCnisMraboImq+EnfI+cAk5
	Iv5QmF7qyE2RvY/hE0wIT2GZ4+5pqUSv+QntNMf+HXYxJqJlfW9iezkIampQKUFy
X-Gm-Gg: ATEYQzwjd+NJ1WeogzhkJd3Gaw5uQBF6KAnGP8tsK6IviP+EQCJPpw0ofB2bAeXF/IQ
	Qqhi0UxTJm4rNwlbRG8nG2CaixHK33KR+aLpyKjDyA7oobxf4B2NmD5ZVD3GVqnrJtXuYcyTSXg
	qWT7e7/l5QSrrrsVFjuKHW2GPZl92DpIJJEQsReb1OD2RFAUEczjwRafyg+V52Ib0w60Q9F9qvF
	9RbDefTf2u9Qc7bwkNggQr1nIRliX6ldItgzFjt2wNlyzWxLiS0+4Ah/hVWt8RJJgr8GoD35x9j
	J1S518X8Q+fzuW8kyaiwiIGmgY4PNZGBKzKNzdfPzBLc5pPzIxDqh7SRSUTk28udcD/fFa10Bz/
	g7D4o+jSJBpV2cOaVcBdX/BsuXQVmuJ9yACfOXFYWNij1Ph49fGqlLsXUdgNv1TgYCiEqSDE1uB
	1H3cbV+0EsYVISvkDucc07lkZIWguqr02JEA==
X-Received: by 2002:a05:6a21:339a:b0:398:9c27:2479 with SMTP id adf61e73a8af0-39c877b15c0mr11539221637.5.1774848092702;
        Sun, 29 Mar 2026 22:21:32 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769160b165sm5042722a12.0.2026.03.29.22.21.31
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:21:32 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: fix typos and enhance installation guide
Date: Mon, 30 Mar 2026 10:51:26 +0530
Message-ID: <20260330052127.9173-2-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330052127.9173-1-aghi.saksham5@gmail.com>
References: <20260330052127.9173-1-aghi.saksham5@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3091-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: DC54335575F
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


