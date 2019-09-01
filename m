Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F60A47A6
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:52:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj6Y69bxzDqsp
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:52:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317157;
	bh=rZPn6iBu8pwWBOIWijStpoP2gA7hWvt8+bz+UvSnTyA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UK+Q1DI83DQO73aRBDd05I/X7OghVU2jmxq/G5/dP/aLxCTj2JHx70y8hTulQ0aU3
	 WsZAKBXPsdURoHSV/5ZTVRQDuS6mo/UZUSXLWqKsiQcezv7mvM0nW81Yj34Nn3vlkU
	 2HCG98vwtj4+ZXhfihkyXa7T+a1aquZbcHOccIjRWyTLyTrUAyj6QqYestcxraIrcw
	 7Zd14vSauk2UHv5So967F6s+s7a0MiApQn0L/M+HsMiUVfs2JMAaqdsJBdwgi4RKIp
	 aLzXBgpvb4Zz7tM2T1ppLTIM/VBCW83fGcdecW2zOCaxGbrl+Z3Ix9V+QjgItNSBI0
	 +mBjWMIRw+LHg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.146; helo=sonic302-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="QOPExNav"; 
 dkim-atps=neutral
Received: from sonic302-20.consmr.mail.gq1.yahoo.com
 (sonic302-20.consmr.mail.gq1.yahoo.com [98.137.68.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6D1jtgzDqtn
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317136; bh=3O6cJFKVmB7hCW3cVQChsdJJWaBz5U9+tHWa8vcLe+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=QOPExNavkt/GHUqZYU9X5WaEfpze8nv1M5zC0X+n5XYof3R3zMwCTkjQFvqejaRW2w90g8QVBrT1Gtm17XQ+Dy9v7wkk607jHrJElNm00o+UDSg80e6SJnYp1K7+raqdGdKo9xde4cBEJG6VumE9iAYolF5VMe1sCdHWMCil0u+htRsXzv3maPqOCsiJHu63B++SuJz+31p2uLzbEKd/ybA5cFQ8P7YdZrCTKMBSSyGZg/b9Zne/Qe5gD4VB8XlNgQdw3Pj3rYMLrcsA4X2BUri1mYs1KWsRw9JVijV7IMy/WCWUOJtsFX7AFs8ChB1NTKEThgGQ5i/vW7X3SvcSPA==
X-YMail-OSG: UXeh09AVM1mo9zHexmvdphOLm7OQTRfeAh35.5FA.3MbkzFD8u_UjsmX2ubTytI
 8vcdihwqaAFZEspWFkUQzqyeBBYdbG.U_HuhVbLp3fh8JXmyAJApbLNyqx7otKvupGQzvcurU0hq
 a1.LsFFvex8ahbmu2RwbkL6tptxtze_Kl_NML.KYZlrBlZH.7SBPTGxYRwJDDfVuY_RrNmkxs6km
 iZbZsMEoowePDF29MNAnfhx6jpbF9R06Cvi.yaQ.bdACmaiZBszlmAmKrFsTKr05SfeJ_3C8P.XA
 X.Ol5zr7fZHFohrMtQDBb_pkbnHZGZV44XmWjZ385pWhV82m_AcJMWz5HWsFqNrVKZKg6MRrRCZO
 .PzDYSBqO75ip6r5taXsVxFTknIsmIrsmRajA5h_T9iKSFpY5mXJZjZTo5mdriVpoqxuLziC2IVY
 .rdx4o2VtNYq3oNhsYhi7jccwCUgD.1qwA0M3rFPZ64xN2mVa.bHIA2vB3BdHi.KP1OtjQUIuPV0
 69cApWDTjZd0H6A4Ww595VFy.5jXOaLVaiIysZQSS21hExk3d0hULzmVKkFVBIAmscqhNO.BQxSb
 VoNdoYjV6YMN.XxQ8FYioV_s7Hdzx7ozlIWfGX1rgbLq_qOP3Kq7ezlBY0W8zJUHugavn.7G9jBr
 uMJiMVh4CRkONXyHs_JTbH63_p5HijlmYBwfAlGPqS.e4Sy..NZO9fJRCqkxLUaGZ1neECDpo2tp
 bPtdlbBDEKwZQZ7_RZnh6qxJAhwZ9nc2djbu9zupGW0EKqIYlOu3kJgsILYFZOpntK8uW8QQFlbY
 aHyFHKrfLjEfaWLNKt_p_iE4KV_wonMa2l7g.doVsUQAEkriSdCK8tdJMrsuVX1KYw_Kr6AtpRu8
 oDfxo_jpK_yVHCmtA3TZQBgHTI7wXtebKRpZ1LLIN6MJp88Obw91i0xagMtfeAPgq_Imo0ZIRXZi
 YEc5ENu4G.Z1xT9nJtlF05X3HE6EyfJd7d3g.hOBkJLBtrUHSwfZYdfE7pX35vUFHCqjcr0i7_fl
 Gg7cpGb3A14mXowjFkz5MAU6hXyaDujbJcqte4e7TEXGIYpPogzNsDBW7qlbRtm7a0IosVCCExNg
 UEfV2o8PTR3yhUhgMQYwfra_9NKcx6C.FEvXYF4u3J.1GJodIs5bC4OLaHu5fFzGeDY_ghZpR0RR
 V3UhAX3L7.6gIaItVlfxny9RbhWhaJ5L3v2t8BEWHpa_z8o2GUuotN6K5qkIs3Oc555m0OfUcKmz
 DAHa7cirZ0IOC7_pTFoUZk.lJUod0Z5FJj6jLk6yb
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:16 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:13 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/21] erofs: update erofs_inode_is_data_compressed helper
Date: Sun,  1 Sep 2019 13:51:14 +0800
Message-Id: <20190901055130.30572-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph said, "This looks like a really obsfucated
way to write:
	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY; "

Although I had my own consideration, it's the right way for now.

[1] https://lore.kernel.org/linux-fsdevel/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 59dcc2e8cb02..87d7ae82339a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -62,9 +62,8 @@ enum {
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return true;
-	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
+		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 }
 
 /* bit definitions of inode i_advise */
-- 
2.17.1

