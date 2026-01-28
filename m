Return-Path: <linux-erofs+bounces-2226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC45KKKXeWnSxgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 05:59:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA49D1EC
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 05:59:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f196Q3Ysrz30Lv;
	Wed, 28 Jan 2026 15:59:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769576350;
	cv=none; b=RmOxm04NdkbCQL3s7XeM/cY7MFWGKUusdS5Rd523TEDq9kl/tI1q/Bp8CZBRV4wrVWM3ahOjXHX2g9aUSMIrNaaG9Ym7QjEAzxQPsqcByhvMNMyvHYF9Swaz9pmhAMi8fPeLJIUJA4c2CLr8iZWlooXqJopdfwOOZC+U8WBNsviw9uYdtxR97FhmYwTeG4vYCFv6IU3cocboKsPxPI9/N3yugX+ReBBDyzas4WQFcl40C5cHujUNLWiwCX3ger1Io1DSigaoZGAdp/Hts7GFgLTeT1qAYeYfAieHEY8i0oUQs/uKlt9f0OE1j3bzcLkm7VGJe9nQNhDkRzYD7Uxqow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769576350; c=relaxed/relaxed;
	bh=tKhmk0cBya/+peKFA+lhG9Qk30qlWXsRLkZ+A1hgQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYH9jLpFglA2ftNdpELWpzxTTfp//S6Twsd8ZKtRgpW0k7vh7hUJRb4H63k8n56nteBD4f6HD6TmYF6Lv4ZWEZu8v552c+NJ/GQ5viZ8aSCm3JW/rHqVx36KRDaP1+YWoBpnRDn2Eee8bxBWa4zirSDJioTsexglRFrcduOn+CfbSxNlr4OGKaj1aTmv2Dg9OHsW4NomH7VTenXEGzPL9W3S2RuMfu91zdFVh0ZzHQOvSW6e2djMWA0vM+cUSTA4xou2cCEhTFj5VPWMuCMFLzJ2ryXlJsjuI6+haZCidT75A7FCYClGwGNnLtvINllCNzMIjVIM3rU7qAH3xzgKrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ck2lotoD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ck2lotoD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f196N26xmz30GV
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 15:59:06 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769576340; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tKhmk0cBya/+peKFA+lhG9Qk30qlWXsRLkZ+A1hgQ60=;
	b=ck2lotoD8pVK6z1Am4aMWku9sBRjO1mg6+9ZBSQQEwWMTCRW9MlDvfAFmfDDBKi4mIPX8V2mxAghH/b/JzKgkzByDVUP0kKgL+Cd5FHpkM24/lw+CwJ5Ks41BTWlF17pyCCws6p/QRQ2GW7ewuDk/ovEqCHcIcMTL4RpToV+z7A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy29ZgF_1769576335 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 12:58:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: use inode_set_cached_link()
Date: Wed, 28 Jan 2026 12:58:54 +0800
Message-ID: <20260128045854.2266287-1-hsiangkao@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2226-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 9BBA49D1EC
X-Rspamd-Action: no action

Symlink lengths are now cached in in-memory inodes directly so that
readlink can be sped up.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2e02d4b466ce..6afe487eb9be 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,21 +8,23 @@
 #include <linux/compat.h>
 #include <trace/events/erofs.h>
 
-static int erofs_fill_symlink(struct inode *inode, void *kaddr,
-			      unsigned int m_pofs)
+static int erofs_fill_symlink(struct inode *inode, void *bptr, unsigned int ofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	loff_t off;
-
-	m_pofs += vi->xattr_isize;
-	/* check if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    check_add_overflow(m_pofs, inode->i_size, &off) ||
-	    off > i_blocksize(inode))
-		return 0;
-
-	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
-	return inode->i_link ? 0 : -ENOMEM;
+	char *link;
+	loff_t end;
+
+	ofs += vi->xattr_isize;
+	/* check whether the symlink data is small enough to be inlined */
+	if (vi->datalayout == EROFS_INODE_FLAT_INLINE &&
+	    !check_add_overflow(ofs, inode->i_size, &end) &&
+	    end <= i_blocksize(inode)) {
+		link = kmemdup_nul(bptr + ofs, inode->i_size, GFP_KERNEL);
+		if (!link)
+			return -ENOMEM;
+		inode_set_cached_link(inode, link, inode->i_size);
+	}
+	return 0;
 }
 
 static int erofs_read_inode(struct inode *inode)
-- 
2.43.5


