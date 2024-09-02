Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C6968144
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725264279;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GDdANt9w0ppx5ac2Zh1POHLT2RnIDYSuFFq646XFNn5V8J6xq1Xwzysqg31riDGcO
	 cvZApx9wI+l9Hxze3mzAwJ9Sh8nKs+dydxzNjc/SfIlcrOqwJWX5gblEXnypmYRnPv
	 Icw5+wPs+1Ns+SY+7qFH9YKqwhYVtf16Zye7CKDayxjWqzaApXEnQoN5nUwH6dMRH1
	 AVmykai03iohwX817dJn9aV78G+TgKu+VeimqzavT01BtVlBBQMkoOJ+crP7HgRxBQ
	 Js62fZpZ7q2Iltdgz5BxikqhLUVHYLRTEG273Lqosl09C3fljj/Gk8S8M3Nom4ohH1
	 wzKaDm/DB+FgA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy1WC422jz2yPM
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:04:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725264278;
	cv=none; b=YvYKHGK2rjASoSX0ThwkndLszV3oUfkygVkEItoM0/NtiUkt7C9BmUVWGi9BhBN+Wl1EYNxDxArBzwnL/u+aA5gjQBHawmnhmicu7BbFILu/wBCt2G4o135lVcfOLlCBLuiYYR0XNN2QDALOoZrZhAZS3bNur1/6jVcpFME7cXMr9MdZ7r7M0GNjuabJ0jeumu6ewKn2Pjao/WRZ3LdB+/pZFcNsrWk1hgcWbuY6ufxMstzRYBlf1B3YXmWyReR9ARhAx2YQbHrAlc4aH+6/5wc8vq2iexsGRisyu/wdj/sT1zQkDgcFyNj+01E/KBP0q5FL+yW+lVEcQnfe/azizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725264278; c=relaxed/relaxed;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=kiWr3oF8iGFXPnD2PwB3UkKpacBxgr11qaNPOLGdbhmYOzqnaW0U9seMIdkJdYqU41cALdpOr3I9rsj9aRpfU6DW9c5iRb8aiFMWQ56YqGWY+nS0puEcXsvGJGkDmlncYeE3WKYTxN4aESUXJ7fPt3vrGetxbBT8p/ekDmoL6fdRITz4j+9SG4tkgQhI2qwSMZK+9pTt1/WWXeje/XED+wlqA/QLM3RccwcKTpin+3CpF7ckat7UZy/zoOQnMXD11YKeQ9pQYnLmDXDw3JLqIiF40T8dWJKc8PtJEF6eZjJqT2SF+xeglUUriNMKemR3c61Tl8nO7Ef/mzhoNjOujQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=XW5H+dBh; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=XW5H+dBh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy1WB24RNz2xYY
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:04:38 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BF886983F;
	Mon,  2 Sep 2024 04:04:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725264274; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	b=XW5H+dBh2d8Qk64ukrUeSGFRl3Rvmah7aJVV/PMOlHtGFeEdDuAhFQgHDOY6W9H4+krQQg
	WjIzaqc9RjvVfrEDRtUkCAKE0vxM+wQAa3Hr41IaqHjP8T8ttoU3abzD0iXc2Yd45sGqXI
	uV3/yjWrGvIQEg0G1ACJb6ZFwAFmQzk560pd2FwxH/X7bHrJe8bNneLNO9IMJMcN8NfHUg
	2kbiAoAme3mWyx3lpYfDN9+JjQhox1jnr6YpEfAclKNet3nVO49QWmJ5V8F8+1ZHHaNuTj
	G0miduPNuVTLjciIBGeQsbHobUO4KYAWPsJ1UrrZNyjHwRSebmjU/E9ze0fKuA==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V3 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 16:04:16 +0800
Message-ID: <20240902080417.427993-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902080417.427993-1-toolmanp@tlmp.cc>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..40d3f4921d81 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -179,7 +179,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
@@ -188,24 +187,19 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
+		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
+	
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+	if (!inode->i_link)
+		return -ENOMEM;
 
-	inode->i_link = lnk;
 	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }
-- 
2.46.0

