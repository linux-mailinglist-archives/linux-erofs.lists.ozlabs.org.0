Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEBCC467
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Oct 2019 22:47:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lMPJ4nhqzDqfS
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 06:47:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570222020;
	bh=KbKXkT3Sn3t41+iJ452T9CMQmE6vHTAwPwcOprIuPvU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=h+Od4xi/i/rMWft/+WZ1RhbyTZZU+nPmtTOoUKl26ErLgxoRJMV81xdXlf0AXN3E5
	 vtjalxIQHNnOlxKtcv+24a5sc+vbJaYQRUfGKWSOGg5krFLCmlMINvkZKDe0mcO5G0
	 Q0nFccTcJPvSS426XPB1wYENI7bp5WM+Hr/yJNurf3klHcQ/MlTujwybe5BGPBr7pf
	 NOYqZjT7ttXqz6c3evgsBzXv7qdSJqjiBzXndmF8Bdizg/9+Hzl+qLrPm0dfYdO4pf
	 VU9v97cuYohdbiYAIcswBYOn3c1q1Af7kyg0E6nMl0frENmioPPN/jdEIXCe4KM/tr
	 S84q6bhGT4rmg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.83; helo=sonic313-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="e9TEciYW"; 
 dkim-atps=neutral
Received: from sonic313-20.consmr.mail.gq1.yahoo.com
 (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lMP572cJzDqdx
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Oct 2019 06:46:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570222001; bh=Fl//5MTCVMqda1rsPDGCZSdlbFhOdztxqx0HQrMOH+w=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=e9TEciYWPQiUekgegoW6B7nNChGdlla48r6RwoqopzAOUrj+ADNnfwEeiDeocdEd19PrNtaR87bQf/hyR+hFF4L/cZLnoUor2wmEpWOaNWdlwuwHR5GvczqS1e3z1mSZ0YEgyZg4/yrk4Z0DcBtmP/otYS0+u18JAu5/AeUYlCgmRrOAR2mKnraYC46kMHXciS9olos7iTQZbqbEK7GVQ9BcBQ5dbaSnurYnC8bVo0n1awcdOF/oGjIESyjprYLyeQzEtnMVLvz00yLxibyW+zY0997rASOg+CPlk7JTovWniUQsHuZXWwQPybcBbHLfouiZNFGUbji8FwK8Pyw33Q==
X-YMail-OSG: ESbQ1YMVM1m_WZIeX1YLKMnnUW3jXnu0NdPaFhulssBoK43qXr3iNFGMd6DM4DI
 efXKSQu0TZ9n3bOUfN9zuPxx1hVK2nz1ShBrGzX26b4ZfMmnd6AfEQl4l2j3mKijgB5w3L6Sn2Va
 8mK9P8.qFkJVNHWSfxQo6r1kcD8rdv4kBGZ2DXXsuI8YyaBt9ciucZN17BbDVIcaJQJDFg5hu.vX
 2QfSf.gf1uUD9uggL3vUgeNF8ih2OAOeple73J.qTAQHVgscKTC_lv34Lmjtj9hCqHhWyTEimZxh
 FDrjWFVtw4Yctqh2a3SS5LCrHiqDHGFJVBvlSchw5HFpmrkLjCOsTZpx43EtGzra1PI6qczUaLpq
 YAa46sO7OEhlDDqKzDaYIKUNxn8T7_SMG7ESOEVsOK8xYFVG46uQsKOW6n0.AeP8k0tST17t.WCL
 xIu9li0.2Ld7m3Stc9Ur9DO09aYtWQ6lkUQos7rK0GWvT_rUlHvDEr1l.FhSpAjwu6_dIF08KtRA
 48uTFbv71cD6lMlknFa8ZoFxxP1YkStwK9SzDaKKL1Z.u9foZgapdCxI49d.rGWuVXobbvF7OPJT
 p6Gx5fmLcVy1l.iWJVay3YV5tkWSifso.ZB4YJG4g9TEVhNZpc75U5razrH5x0jdjFBGNv0F01ny
 s2kI9_sGzR6I2LMAk1zpkOu6_p6dGilvRLjJBW1k8_5rQD_utxoWq4BN0NPtWJfP6lAwi6mtyw_T
 ypwzdCEWxiazhNoOgZGpYgxSdu9zoEfVQv4e_MxFANR7WWOWOuL1IGf0WNrTXcJqC6w169L3TgOc
 A.I5HNP0TPJTBegR6dFa8CPVC7eyv4xpxB.n56cBTxiXuFnwmqTnNTuD1SND3kSzI1KMW5_aOhO3
 Dd8.hFbh3qqhhVQa2OvWtgEwoR_ZaJ28TO0iKPqZoV07YM_cyilp9fHOOJrXT3mUrxJACfJNVDLH
 St4XRRcg3fDQsxP8LfnQ6JTyXGHwMt2G2C_llx0x0i.H5ax.vHG.Tgq7eqAWWjm.bqALvVgtWhc7
 s4nuep2jr0XnqK17mKmqMVTv08vW6UQnYnq4NxTvmShC7N0vV9JbzCt6ZDPkkfaV4QSSMN0o2ls4
 .tC9JUVGkYm5pXkN0mVfOB0eXFVMapGqM49l.zCll5RuaSlsv3QxlXFrTTUIF2kdd6Nd1JaVS0Sa
 aqCMoCDG3GBXdUhrlcmVIoAD6ko5AnP5GM3s1uwqppaXFkEcIwPr7823NB65YlxVplXmSXD4lkeq
 fzgWLdBEcb1PNouZdeBApLY8B4Ce59CBPTvdI1iLjujlwCdWlbuWlsMDNLCmFq3ec2xEQre3EDGJ
 YCzhn
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 4 Oct 2019 20:46:41 +0000
Received: by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID deb090a1363bdefbed1275484c094855; 
 Fri, 04 Oct 2019 20:46:40 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: support 64-bit internal buffer cache
Date: Sat,  5 Oct 2019 04:46:29 +0800
Message-Id: <20191004204630.22696-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Previously, the type of off in struct erofs_buffer_head
is unsigned int, it's not enough for large files.

Fix to a 64-bit field in order to support large files.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi Guifu,
Please take some time to review these patches
since I'd like to release erofs-utils 1.0 recently.

Thanks,
Gao Xiang

 include/erofs/cache.h |  8 ++++----
 include/erofs/defs.h  |  4 ++++
 lib/cache.c           | 15 ++++++++-------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 71df811..10a6aac 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -31,7 +31,7 @@ struct erofs_buffer_head {
 	struct list_head list;
 	struct erofs_buffer_block *block;
 
-	unsigned int off;
+	erofs_off_t off;
 	struct erofs_bhops *op;
 
 	void *fsprivate;
@@ -87,13 +87,13 @@ static inline bool erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 }
 
 struct erofs_buffer_head *erofs_buffer_init(void);
-int erofs_bh_balloon(struct erofs_buffer_head *bh, unsigned int incr);
+int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
-struct erofs_buffer_head *erofs_balloc(int type, unsigned int size,
+struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext);
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
-					int type, int size);
+					int type, unsigned int size);
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
 bool erofs_bflush(struct erofs_buffer_block *bb);
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 0d9910c..15db4e3 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -136,6 +136,10 @@ typedef int64_t         s64;
 	type __max2 = (y);			\
 	__max1 > __max2 ? __max1: __max2; })
 
+#define sgn(x) ({		\
+	typeof(x) _x = (x);	\
+(_x > 0) - (_x < 0); })
+
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
 #define BIT(nr)             (1UL << (nr))
diff --git a/lib/cache.c b/lib/cache.c
index 4f03cb9..41d2d5d 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -74,14 +74,15 @@ struct erofs_buffer_head *erofs_buffer_init(void)
 /* return occupied bytes in specific buffer block if succeed */
 static int __erofs_battach(struct erofs_buffer_block *bb,
 			   struct erofs_buffer_head *bh,
-			   unsigned int incr,
+			   erofs_off_t incr,
 			   unsigned int alignsize,
 			   unsigned int extrasize,
 			   bool dryrun)
 {
-	const unsigned int alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = alignedoffset + incr + extrasize -
-			roundup(bb->buffers.off + 1, EROFS_BLKSIZ);
+	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
+	const int oob = sgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
+				    alignsize) + incr + extrasize -
+			    EROFS_BLKSIZ);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
@@ -113,7 +114,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 	return (alignedoffset + incr) % EROFS_BLKSIZ;
 }
 
-int erofs_bh_balloon(struct erofs_buffer_head *bh, unsigned int incr)
+int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 {
 	struct erofs_buffer_block *const bb = bh->block;
 
@@ -124,7 +125,7 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, unsigned int incr)
 	return __erofs_battach(bb, NULL, incr, 1, 0, false);
 }
 
-struct erofs_buffer_head *erofs_balloc(int type, unsigned int size,
+struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext)
 {
@@ -214,7 +215,7 @@ found:
 }
 
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
-					int type, int size)
+					int type, unsigned int size)
 {
 	struct erofs_buffer_block *const bb = bh->block;
 	struct erofs_buffer_head *nbh;
-- 
2.17.1

