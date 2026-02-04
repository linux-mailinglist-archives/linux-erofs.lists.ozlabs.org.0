Return-Path: <linux-erofs+bounces-2257-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIlbKnATg2nBhQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2257-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 10:37:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB02E3F00
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 10:37:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Zyj2TR3z2yFQ;
	Wed, 04 Feb 2026 20:37:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770197869;
	cv=none; b=hisgQiEZx2m/+4mapoO3gtvda9GyF8gq/yzCHlJIoTacCYCQNcFNsA7l1JYMrua6AklxIH6c5EiYvjWoxQL5D4I3RFADhdwdYa13C0q1btWQw9gjsJ1CeEVttoG4RxkAegODSSs3OSNBEzMaIX8z03t3FmZosLjh0S+7P8NzAGlWGRvqpxrffkif1wbaux6OwH1up+JfqMek1E997wliFtvHaKPJ/E7k8Rr31uNjNBQJ5uvqBfrVuacFI32gFwCFprKgl8aKpAby4PlkrkaOSKk2Kcw9aP7DxfxebmWXfigHSUQF0VGAfd0doTR6oAgPnvbJS3yPuEv9rVehHs2+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770197869; c=relaxed/relaxed;
	bh=Zeh7CD+1/h+lCDoGt7yz+rrLj5FU0zFwxjfIaxRKgBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm7fO+PGf4ltA5P/bOuHf63P3ccrjaxHsGRG+uTlin/ck/My50PFL+HH/CGNaJ+0gavk8hO8t5aGFOGAxG7KFasjKyvP5ZskDr1/1XDpQmhmxyxNpSG/FZWZu8s7qgTU5KIJrNaXKaNSkGgxiuhaIuYtKJqEEZiaOQT2L08oqmkB5iTcWzMWcF2wcwYxSUWF8I3P50iO4JK8/xuuRKgaxajab9l4DBjkaQ3qXi2CyOPAEqJqhjzHZHw1t5sORdc+Os7nIUQl02I+gBMDFx+BeBlaEKCvi7QbRw+79GCZsQJZZUkNGNKbGolT64wr1amiH7zAXAgHvUKWE0z4T0/hhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9cjRzOd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9cjRzOd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Zyf6Rnpz2xpk
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Feb 2026 20:37:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770197858; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Zeh7CD+1/h+lCDoGt7yz+rrLj5FU0zFwxjfIaxRKgBA=;
	b=I9cjRzOdzcORpfeFjOwaqdQBHr2o2YWqD4l2jumN3zbD1/taQJ3x5KyWm3/t4EqXB9MWbl2hbyI409jJ4Giv31Qn44f3VRkHPk8yV/Qf+Z2Qm0vC2NVCSw51ld1M/075s4WVrMNPh9EjPcemIIGHJKDcxkCyRX5i6LhR7RLPSZ8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyWVUEX_1770197852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 17:37:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: update compression algorithm status
Date: Wed,  4 Feb 2026 17:37:31 +0800
Message-ID: <20260204093731.2902332-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2257-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: DAB02E3F00
X-Rspamd-Action: no action

The following changes are proposed in the upcoming Linux 7.0:

 - Enable LZMA support by default, as it's already in use by Fedora 42/43
   and some Android vendors for minimal filesystem sizes;

 - Promote DEFLATE and Zstandard out of EXPERIMENTAL status, given that
   they have been landed and well-tested for over a year and are
   already ready for general use.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst |  6 +++---
 fs/erofs/Kconfig                    | 11 +++--------
 fs/erofs/decompressor_deflate.c     |  1 -
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index af1df574e66c..d6b3693eba60 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -63,9 +63,9 @@ Here are the main features of EROFS:
  - Support POSIX.1e ACLs by using extended attributes;
 
  - Support transparent data compression as an option:
-   LZ4, MicroLZMA and DEFLATE algorithms can be used on a per-file basis; In
-   addition, inplace decompression is also supported to avoid bounce compressed
-   buffers and unnecessary page cache thrashing.
+   LZ4, MicroLZMA, DEFLATE and Zstandard algorithms can be used on a per-file
+   basis; In addition, inplace decompression is also supported to avoid bounce
+   compressed buffers and unnecessary page cache thrashing.
 
  - Support chunk-based data deduplication and rolling-hash compressed data
    deduplication;
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index b71f2a8074fe..a9f645f57bb2 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -112,13 +112,14 @@ config EROFS_FS_ZIP
 config EROFS_FS_ZIP_LZMA
 	bool "EROFS LZMA compressed data support"
 	depends on EROFS_FS_ZIP
+	default y
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing LZMA compressed data, specifically called microLZMA. It
 	  gives better compression ratios than the default LZ4 format, at the
 	  expense of more CPU overhead.
 
-	  If unsure, say N.
+	  Say N if you want to disable LZMA compression support.
 
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
@@ -129,9 +130,6 @@ config EROFS_FS_ZIP_DEFLATE
 	  ratios than the default LZ4 format, while it costs more CPU
 	  overhead.
 
-	  DEFLATE support is an experimental feature for now and so most
-	  file systems will be readable without selecting this option.
-
 	  If unsure, say N.
 
 config EROFS_FS_ZIP_ZSTD
@@ -141,10 +139,7 @@ config EROFS_FS_ZIP_ZSTD
 	  Saying Y here includes support for reading EROFS file systems
 	  containing Zstandard compressed data.  It gives better compression
 	  ratios than the default LZ4 format, while it costs more CPU
-	  overhead.
-
-	  Zstandard support is an experimental feature for now and so most
-	  file systems will be readable without selecting this option.
+	  overhead and memory footprint.
 
 	  If unsure, say N.
 
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 3fb73000ed27..4f26ab767645 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -89,7 +89,6 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 		inited = true;
 	}
 	mutex_unlock(&deflate_resize_mutex);
-	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
 	return 0;
 failed:
 	mutex_unlock(&deflate_resize_mutex);
-- 
2.43.5


