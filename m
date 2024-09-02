Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C6967EA2
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725252685;
	bh=bbnLgImrW6BCWQ/vuxDpGCqSKr3V9+T3p5CPH+0QUwI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dxSazRhAfPd9A+ZDGYyAb0k4LY4hBRDvmyBVL5Ogbn8FjvAu4rYE8OsvrEQS0iMby
	 hLTCNpEZxykpqKOBLNZq3YOF8LrILYLsfsJ8W4+Q9yrBV3FiQuUDZIIb4eGNXxa1Zb
	 y9dwmEYwTVELMaqsbyu7jzj1OjwQZ2OsKg/kAMexlxorK3bRkwdlgISZtIC3UALzNw
	 bNIwpyfY1DPE2LdOrFQh820NXY1jug3FcK3gM9rFBDDX9nQNbSUP5pLVEHeTXUlfSa
	 CoERdCbr0sZOIb/enV4343k3wxRtq+qZ9wsg3bjRXi7z4EmXM0/54PWwzYRBjbTLfE
	 c8RHNfRBUBKAg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxxDF5KtNz3c5q
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 14:51:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725252684;
	cv=none; b=ZDfLjMeEdqUrBWuc0u/ZXfm3LjMXUPkjm4xzYWdkj5yorhVhFOHdk4kqurgMXgO5p4QMIYjdAY82vDwDPqbPO76W5xT+RDqogLW2Vri6HXRm4j/JcIZxN6idHGRYQjK/YrJHlXcioWge1tMyvpNrIsnMzsw3fNovA7KUUfFKKeCotkBVL+mJSpHvUYi5+QkquqAbEdwQXV3WeEagvceVVTBT12T0yfygQzsmNDTZQbxcPCEfG6eOFTyDalKda+rk4A2P6VjT8/JgI5IGo4Usw2HxA0/enjqZYFD7PpSlxbNvuAB5KoceLxltXP2UcAwDf36WralfaKmB/kv67oAdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725252684; c=relaxed/relaxed;
	bh=bbnLgImrW6BCWQ/vuxDpGCqSKr3V9+T3p5CPH+0QUwI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=JT3SRJ65ctJpn/yrF+Eobxp6gdquUVUf/C0fWtq2+cImtPA+vOCf+n4+V4ySDmx18A+SdLH+ShHLNV/pcsm9ATpgTbi9we71TRQ+PtseMztnO+u201doJfguLZJxqW+dSBd8AXHBONk7U8ZHxL/EFUdg2Ec3w+0Zhd8bF4mxmUlR6yZqEaQoo+fDiBn4TdVcfZrxcmH9y3n/zidFTV/ZQsljcCRYINvpMAAZPGiLF17RnlAHpVfU3ihFmx/DriVltzzkQ1bF0L7XqOZW7y4iWGr0PhoXA50ECKahyAYwTxclcGQxzmmVKv0i3mxvWocvuswS6j2cl/6dQYZEnX4+eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ouvlelf3; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ouvlelf3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxxDD0hZNz2xjh
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 14:51:24 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20D4369842;
	Mon,  2 Sep 2024 00:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725252682; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bbnLgImrW6BCWQ/vuxDpGCqSKr3V9+T3p5CPH+0QUwI=;
	b=ouvlelf3ZVXcuJ9f1uvUgyc6m7QNZ78Lv7uk0IMCVxqVqrBjbVD/M+Yrev39rGSU65tNyz
	7ZEoqieF3nzaxje1yntivdmPe2HAs3tmXVCMygf+FZiuFyihplwp2XbO5sefnDfFN+G/VG
	RmJwEobnHmxqEdP2A/7PXRq19vhZH8QKxdlhMEuQEBhVlDLrcuVGh98TELmoQcdtDUP/3q
	nDtBlzNfII9s5NaPJlaj/al+BmLEfkGRWuxsMBzOA2M2sHp92pQ1tgkXCeoBNPFvM1LY4D
	aboNlJUuP9zZcfflGf4aX0LLt+9q2gnA28g5dCosq+A0kUXCC7DBeguaUpT4ig==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH 2/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 12:51:00 +0800
Message-ID: <20240902045100.285477-3-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902045100.285477-1-toolmanp@tlmp.cc>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 90f1235dc404..f435752143cb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -21,23 +21,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
+
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
 		erofs_err(inode->i_sb,
 			  "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
 
+	lnk = kmemdup_nul(kaddr+m_pofs, inode->i_size, GFP_KERNEL);
+	if (!lnk)
+		return -ENOMEM;
 	inode->i_link = lnk;
 	return 0;
 }
-- 
2.46.0

