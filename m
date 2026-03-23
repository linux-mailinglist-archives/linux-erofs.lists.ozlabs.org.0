Return-Path: <linux-erofs+bounces-2950-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGESJ54MwWngQAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2950-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 10:49:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A18462EF543
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 10:49:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffT0908HDz2ySc;
	Mon, 23 Mar 2026 20:49:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774259352;
	cv=none; b=evQ4auNiNNCzredX8oEqUGTfEgY7Pvznso7IEe4q+s8ncPsowdQQfq9shvQwSCL4KF3b0oq3xy//s5lfy0MeuGbRVmmNeUfTtppX5lDOkLfxT9ET3503tJE2sDSmoliSOXzW5ztu8VHnJ55kLgpEvwv4gVMILoNLl93ytZxiFxkNsIC+vDAq47Lv8d37UV7XJbeXSWxDsYTnLE2h0iN432TzH/XWuNVIX3+4jllziedFICyGsZkpYGvp8lM6n0rh6FE0r/4OyuZgzJr5RF4/7lwpPsTESYK142CvukEWSiHW8NDFn30M0q+riSwTHQpQCWq/wCzcFKB89ukXmQSgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774259352; c=relaxed/relaxed;
	bh=0KzACxuDuinzNW8y4KmDnlliv0Pog010pgubfK+alRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVQr6OXBI5A4okokzeCHNoDB0RGw9R/KkKcUs3BuZaqKe9epBHEILe295i39b9FJr49OISvi142MkQIRNXnYLHuWXNrkB/YP2ueRr4FiahNcUhRhTp0zXHRhxytxCmqfvDIWfSDdR5+Xz6JKvlUxqQU7utjF3dnvU7lJzbLdaqn8kUxdrB9z9ocSiR04f2wQGxD37ZKjffmDR2Mq89gHtEJDzt4+FXMBD2IDalx48m7XRzbZAcR8Ire1Dxd4RbIoNAZD0aAiCsoC82LXLDM7V0kOa9sp7t52mV/czxqASGPZl4Jn4ACXgQJWbDprdzmJUrcnZ5JGIjBD6ASCWfVt7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xSR3Arj9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xSR3Arj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffT060DHmz2ySb
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 20:49:07 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774259343; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0KzACxuDuinzNW8y4KmDnlliv0Pog010pgubfK+alRU=;
	b=xSR3Arj9kVsIWB2bRN9eizXImhBdZuViOHX70ZGngBYsoiT2+UfYauCK0a2p1np6e7srVpXFAC+QqD0BvnB/+5h9pIj5CI25xRAXxY8Ojdr5Ors8vjSye8tuYzwDvK9lWPpngFtmZ6/kiRtnSgORK2hD3MJ5hxjqKTVpcQhpr1E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.W8c8F_1774259338;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.W8c8F_1774259338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 17:49:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: update the Kconfig description
Date: Mon, 23 Mar 2026 17:48:57 +0800
Message-ID: <20260323094857.2187994-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2950-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: A18462EF543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refine the description to better highlight its features and use cases.

In addition, add instructions for building it as a module and clarify
the compression option.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index a9f645f57bb2..9489ed8ad95b 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -16,22 +16,36 @@ config EROFS_FS
 	select ZLIB_INFLATE if EROFS_FS_ZIP_DEFLATE
 	select ZSTD_DECOMPRESS if EROFS_FS_ZIP_ZSTD
 	help
-	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
-	  file system with modern designs (e.g. no buffer heads, inline
-	  xattrs/data, chunk-based deduplication, multiple devices, etc.) for
-	  scenarios which need high-performance read-only solutions, e.g.
-	  smartphones with Android OS, LiveCDs and high-density hosts with
-	  numerous containers;
-
-	  It also provides transparent compression and deduplication support to
-	  improve storage density and maintain relatively high compression
-	  ratios, and it implements in-place decompression to temporarily reuse
-	  page cache for compressed data using proper strategies, which is
-	  quite useful for ensuring guaranteed end-to-end runtime decompression
+	  EROFS (Enhanced Read-Only File System) is a modern, lightweight,
+	  secure read-only filesystem for various use cases, such as immutable
+	  system images, container images, application sandboxes, and datasets.
+
+	  EROFS uses a flexible, hierarchical on-disk design so that features
+	  can be enabled on demand: the core on-disk format is block-aligned in
+	  order to perform optimally on all kinds of devices, including block
+	  and memory-backed devices; the format is easy to parse and has zero
+	  metadata redundancy, unlike generic filesystems, making it ideal for
+	  for filesytem auditing and remote access; inline data, random-access
+	  friendly directory data, inline/shared extended attributes and
+	  chunk-based deduplication ensure space efficiency while maintaining
+	  high performance.
+
+	  Optionally, it supports multiple devices to reference external data,
+	  enabling data sharing for container images.
+
+	  It also has advanced encoded on-disk layouts, particularly for data
+	  compression and fine-grained deduplication. It utilizes fixed-size
+	  output compression to improve storage density while keeping relatively
+	  high compression ratios. Furthermore, it implements in-place
+	  decompression to reuse file pages to keep compressed data temporarily
+	  with proper strategies, which ensures guaranteed end-to-end runtime
 	  performance under extreme memory pressure without extra cost.
 
-	  See the documentation at <file:Documentation/filesystems/erofs.rst>
-	  and the web pages at <https://erofs.docs.kernel.org> for more details.
+	  For more details, see the web pages at <https://erofs.docs.kernel.org>
+	  and the documentation at <file:Documentation/filesystems/erofs.rst>.
+
+	  To compile EROFS filesystem support as a module, choose M here. The
+	  module will be called erofs.
 
 	  If unsure, say N.
 
@@ -105,7 +119,8 @@ config EROFS_FS_ZIP
 	depends on EROFS_FS
 	default y
 	help
-	  Enable transparent compression support for EROFS file systems.
+	  Enable EROFS compression layouts so that filesystems containing
+	  compressed files can be parsed by the kernel.
 
 	  If you don't want to enable compression feature, say N.
 
-- 
2.43.5


