Return-Path: <linux-erofs+bounces-2249-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lr3FoBhgWn6FwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2249-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 03:46:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB4D3D88
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 03:46:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4ntK3YgMz2xpk;
	Tue, 03 Feb 2026 13:46:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770086777;
	cv=none; b=OGpm3nTyU5lLBHVS0VDOyTQIrSKXZP9iB0slb5eLQYdzsizgDwqW220ToLmyg/8kbL6c5aEyu6px3FvwWx43vh0JuBTmjb4f0B3xxRDOB/wXRtSwxkLZCkUR8d9R4lfpnFtRtnb7PuwQp9RlPpVuYZgICtnns0RIxDt4mhfeUop9+8iAoFtQzXYVSabSclb+1ZuoZMcTbIwH90qcat0lDrNutf14q2LVRqkOgLnnjc/Wo2G+6F8ZU6NKG3fQuyrYrqZXqbB/VCJKxtuTJXYeezOFnqnb9d3pI72k4DEVqOt8m/GMLmnSxvAat+bksKJXjKMjsp8QF2uWDdu5n25l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770086777; c=relaxed/relaxed;
	bh=tbQPoE2XVu/mvdozBIom1TdUmcw2L7XVOJPqi8xiYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd67x/6vlxsyUx5ws5x3sgI5PqCJgiebjlsZ7Te2+DITAKBX+PUpxgcWURXqQlHsFQ1DRnlFyPWHjqqnMopBo0ncl82M5PFBzhlnPpSgXO8otxQw5+qKGVu10f+uHuVbokk26GyeJQ9JAwlPppoYO4Yo2W0ziMxrUccavrjM5q+wXAY6cPrfhvbaeKpCaPlKYHBopqopvoaH2X8JAev0xnn9g4kMM5HKBL9Ts8gbpOkqQ6R2J5hes7zDBkenvLpf8Fznxn5P5HoYnkisQW3fXuRu+1JjDEMGNVpX0irp4VmE0pJiOUjreiwrTit782SyTCVydObhI5PBev+eJh0TLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ine29P24; dkim-atps=neutral; spf=pass (client-ip=47.90.199.6; helo=out199-6.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ine29P24;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.6; helo=out199-6.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4ntG4PnXz2xdL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Feb 2026 13:46:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770086452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tbQPoE2XVu/mvdozBIom1TdUmcw2L7XVOJPqi8xiYqk=;
	b=ine29P24WTXtwnSI+46FotHix2rm/M68Q9wKT2RGDDvFHbFgm1m3ipPMld+qOl6tJaHGngdfgda/JZfZ/Wi0/93OQDV9LRmdFkBRrilHv1idbWZTIyN/9mplY6i/89B48JJx8XnTTm+5vU7aknwUtN/f+ReU7bnYqlnUUibW0s4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyRLuYU_1770085861 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Feb 2026 10:31:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: use inode_set_cached_link()
Date: Tue,  3 Feb 2026 10:31:00 +0800
Message-ID: <20260203023100.459027-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260128045854.2266287-1-hsiangkao@linux.alibaba.com>
References: <20260128045854.2266287-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2249-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 22CB4D3D88
X-Rspamd-Action: no action

Symlink lengths are now cached in in-memory inodes directly so that
readlink can be sped up.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix syzbot reports:
    https://syzkaller.appspot.com/bug?extid=c2dd47dc153320cc4692

 fs/erofs/inode.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2ecc28abd6cd..294f66376825 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,21 +8,29 @@
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
+		if (unlikely(!inode->i_size || strlen(link) != inode->i_size)) {
+			erofs_err(inode->i_sb, "invalid fast symlink size %llu @ nid %llu",
+				  inode->i_size | 0ULL, vi->nid);
+			kfree(link);
+			return -EFSCORRUPTED;
+		}
+		inode_set_cached_link(inode, link, inode->i_size);
+	}
+	return 0;
 }
 
 static int erofs_read_inode(struct inode *inode)
-- 
2.43.5


