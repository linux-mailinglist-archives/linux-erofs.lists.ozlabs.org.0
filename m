Return-Path: <linux-erofs+bounces-2337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w0wTFXZilmmCegIAu9opvQ
	(envelope-from <linux-erofs+bounces-2337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Feb 2026 02:08:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C915B507
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Feb 2026 02:08:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGZxZ4szNz2xlj;
	Thu, 19 Feb 2026 12:08:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771463282;
	cv=none; b=IT5/LhOMtmXidP5xz8qrqfGgdjum1dTUGoXTtC22D34aO7Kzozn+DvZXZG9dcANfP9p67PawzfEzWk9lwCcrA3ohue4t0YQUMuwYLngir9zRdeejaYTQzxiZtRHEGZrzywm9xuJG/4HmMYK48I1BtzKRcdsx6ESVi/MIZ9g72jFPWCl3kcYV348XccKezyTWUD5AtxjeffFBv3Dujk/6UcUNCICO6s7kFw6N0cDrK1igU4jKRRP3xuMz9fGH9jiCQwAF1C1Gl5jqHg+5eZEgTuvyR9tiJNNcoIgB5tbcKNgnZ0TxFx6ntk/fy5dX/zMqIZFAi3Mb4vYUB4hAtXLWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771463282; c=relaxed/relaxed;
	bh=FYJ7o/WNHzFo0Bl+FIMGg/Sc5lJaRtplZvXaox237Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6t+xfYUMMG7Om30rmPkCAipm6nDPHfRRH/rVQ+VcVyMvO9UlMB55BejuTpM4AGIrnJkcKlMSMZm8xxxMuxwkowg+1OZ4APjzDxSlCddjSWZbdsTPK57adekluo4vpZmJW9nAyYW3CAnpR1S0HJiks5jkNNBzp16w6xiN1fvuqU78Ln7hGOBq1jp1lC/JOmk8C1NtTHP4/gbNAu2yuSEIHx883lCkDq59f9/o358m9YFQxYEL7gg62YoVl6SaZY1553CNVDRBLAFSQJ40SQBjyh3hmYefPrW9c4KtAZa0Js7g4FkKVrK8i6+MkGckNUcxQ/qAfQ1a+8jQqo3myIMMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LXcFm/12; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LXcFm/12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGZxY4FYWz2xN8
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Feb 2026 12:08:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771463277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FYJ7o/WNHzFo0Bl+FIMGg/Sc5lJaRtplZvXaox237Lw=;
	b=LXcFm/12unUsgyLn9NcaHO+zj/R2lLXV+YOiMxECE/vhwtxBXHIZb7JO97KbbuXjcReueC1xxWRLbRkqzAgzLOTb1sGHCj3DEnQrVVxTsIY7OpMUxE2QLUlhiEpcyXxdASt0osgfF/11ihiqETs3udmnwqUFjSOTmeylSi25z5Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzTpbY6_1771463276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Feb 2026 09:07:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib,fuse: fix xattr parsing in the metabox inode
Date: Thu, 19 Feb 2026 09:07:55 +0800
Message-ID: <20260219010755.1269214-1-hsiangkao@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-2337-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 5D0C915B507
X-Rspamd-Action: no action

Source kernel commit: 414091322c6363c9283aeb177101e4d7a3819ccd

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 1 +
 lib/xattr.c              | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e741f1ce62f1..671880f2db3c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -192,6 +192,7 @@ EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
+EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
 EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
 
diff --git a/lib/xattr.c b/lib/xattr.c
index d8c7bff2fc87..86f2e45b09b2 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1172,7 +1172,7 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, sbi, false);
+	erofs_init_metabuf(&it.buf, sbi, erofs_inode_in_metabox(vi));
 	it.pos = erofs_iloc(vi) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
@@ -1355,6 +1355,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 		return -ENODATA;
 	}
 
+	erofs_init_metabuf(&it->buf, it->sbi, erofs_inode_in_metabox(vi));
 	remaining = vi->xattr_isize - xattr_header_sz;
 	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
 	while (remaining) {
@@ -1390,6 +1391,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	unsigned int i;
 	int ret = -ENODATA;
 
+	erofs_init_metabuf(&it->buf, sbi,
+			   erofs_sb_has_shared_ea_in_metabox(sbi));
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
@@ -1431,7 +1434,6 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 
 	it.sbi = vi->sbi;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sbi, false);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
@@ -1456,7 +1458,6 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 
 	it.sbi = vi->sbi;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sbi, false);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
-- 
2.43.5


