Return-Path: <linux-erofs+bounces-3097-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLsREhQKymmL4gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3097-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE735585F
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:28:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkftT0r0kz2xlK;
	Mon, 30 Mar 2026 16:28:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848529;
	cv=none; b=Pj4pa4pHzxufYUxUT2GFZ6KeXaWlkV+bfmSSGXqZ4Ae+mfz9RG1uEQYXKlZYv0fMJJz629ajmolW69kz5oxX0z28QpwoVjzAkBrVJWd7Mk8jockwPQwcIYCkkp3CF5a1oZLdKtYQpAaNjDCjlYC8kh0gBLH04ojU61VF1ZubYy32kxob/lDmeqng91ONEagcn+xhw/+JjqocqQDWRSpxarDETPWGf5wCY26/7Iqjs1wJGzEUYkt4edyh/TLdMnChuThcIwBEWydQ5TNpLPXGJfGWHTXp6uEgMYOkd9WkPiPDj1lLxeeUGhwlcSHhxThK1VWrS8Vl76Wy9ztnf0lnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848529; c=relaxed/relaxed;
	bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBaOWpi+79d6HEXlxQuvgo2JKCPNvCUmwh2rumx9UkxibgXsnAyXGNjKCTWKybxiFxbTlDPTHUwbZOA48gPBvkTZHKndD4GXdXThpejg/apSEAEwSMN88nG7ruTH37UGbbb3NqPcRb1l53+S3pZSUhfwVMS18MJchNZGG+jdkuwhvItr/sLKaPpu7b/5nNHnnQPFEHaGCHIrIwZLvr53kpZucjMZ7F+JkUeSKvgqwE5WBQNbE1WXjP1eejXr7BJnJfboI8i5bgkgPss6sihN74JMSxoYRgHwtVdLktUXBqAR5v8nRBvEWV9f9eEbBop/6JfWRxPllO9huizDMoOcBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmRBXwQP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmRBXwQP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkftS3Pfdz2yfl
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:28:48 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8299f1ca894so1929604b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848526; x=1775453326; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=PmRBXwQPO1KNIee/SPqL75dn/WBsTeEpRvGp1HdOrNt1Rwif0bXI7+/SbiSsBfDyWV
         1IBUUxkOYP2qRYkknkjVsiInhpkHUXTmMvcNOx5reM7kIucoIyq2/LundR+b6W4KkbVF
         hWLprEhrysL5ffyq+8WTAj6CER2A1QM6a6A0WNeEEJK0JvbWIP1Dj5G9lvllt4JPZNci
         gYPGsQHFAV2vMkQI1lSi/UvY5j1u9lVCliHuP26E2OFjo9vOX7dRKO4ZVoX3enPvjopJ
         MsTcEDpPbV1g/gYK1X9eAAPCvqK1vXjC/LY4hHCna30NLQK2HJOOy2Qd7HGvLJ56l+57
         u8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848526; x=1775453326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nRa4Y3DTO90LLAywkvRujNPmCrM0radhzw/wt55MS0Y=;
        b=RRkqGRJxFwU4U74NR8chcPG2zB6kwyW/7QoLpQgtvZnmWO5xIUDJvXKLWf8LRjB0pl
         TNFGPPuQhOrOdF2oh2PaSM0V3e+p5aNyLeHJ8npmY7DLkkmhYG7t1C029Wmt8SA+2xKs
         nD6mHWoayTj5MbqSwJrVTkCrndM3L/Sv1bJKeXztdhmZuhJ9HqvQfRM9Spi00TxLPmYM
         gS3x4PphyrLvGWQsjbrTUTXWynSYO12syR51SQi3kw76PNYRZuO2ElSjkuClXWFOAsrI
         +QLqqPFqmjxT65KEBmgcGemAkUSlLFDA++mHo5PlCWDA9nMlNKslMeDE1Pu5FtRtIxcp
         U0Gg==
X-Gm-Message-State: AOJu0Yw+pydyrnMsDdQAP6JZEdydgeE/LFbmuA0MDvxjqtWM/blXcTAk
	ssUpixofCn1+BirpIUHPlVLOX742CsVIuzZWcbdJbjE/zu19He2MzPUEp+UTJFWV
X-Gm-Gg: ATEYQzymoeZFgdrzfjWHoR8oLcN7kJIcTccE8EHzmJ2Mwg8/6ftpVc5O0Sg1GDZ0wIj
	G3kyCGufROGAtS5vC28qWZZ3SjQInUHn1uUB257ibg2uz0VrIRMbCN3O6ACzRp5TXF3hFnfph9B
	vIiP6ymIAe03H/WlmZbiF+FbmJP9bD6MWYRecnvpwf6wWna+I1y6jixxJbA5GGnPdC/pJQN+tuz
	gfBKXBpUXUGzysUsIT0G42PWI8f5XlH2oQuWSwfUCOW0bJ8nPj80x/rFt9Ngygznc0MueccllrR
	qvdTUgkMakz9lSIP8QXQbgxAjiXxQ1DJItGwKqPHyGyhe2onamYtv1iuLmACGQyAADM6zhIzVlk
	O57wjBJIUCsm74pGZSXaCmxXxlCSAAAkK7Im5zueAf+mFh4UT93mq0yWG4Ypi7E2TwmQgmy21gP
	m63YN0Zm3886X+7U8pYjkx2EeNq1f/Lx31bAH/c72qKyOL
X-Received: by 2002:a05:6a00:2e8f:b0:81f:852b:a934 with SMTP id d2e1a72fcca58-82c95ebee0emr11076353b3a.24.1774848526051;
        Sun, 29 Mar 2026 22:28:46 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm4851891b3a.1.2026.03.29.22.28.45
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:28:45 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: fix typos and enhance installation guide
Date: Mon, 30 Mar 2026 10:58:38 +0530
Message-ID: <20260330052840.12730-2-aghi.saksham5@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3097-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 65AE735585F
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


