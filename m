Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BB411A47B7
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:24 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7P6cLWzDqtN
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317201;
	bh=qY+fxtbE1U7MaPBZSagbqSLHeWXCztoREkUKStw6kF0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bw1c9Xx8f+9Xe/rfsM3OySb8ZHsnWD/U8TSrNVZHP61CFNDC3HKavE6FnR8ZJv8n3
	 9Cx/xLfsm4ZGONA7v04FfbN+dXw4nLiL8ogLiYql0ezpwAPQhEcJlNjqZsRiU4DgoG
	 v7NnM+y2bxdOd2XtY1oEbIG8dKRCcb8oU9nuwLmVE+DmukoiF+VgyZFvFAEVxKSHnw
	 VZcz+N1vXCnTBdOtJoXAIiapwiKSWMMO70E6qUmZdRBPO8b4eQK0NdgHuTQtV8MsIG
	 igfMprzW2tUMF4bMy4XgPAPb3cpmBe54EMk7VxA0136S30xa7NdsukDA48mAzl1CoK
	 t4b3VwY+tw8Ag==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="LIElIWJx"; 
 dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6t04pxzDqst
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317171; bh=P1IBdzBibJ6kbGYO/ArT6goRto3vKxmf4+VK0IHH0/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=LIElIWJxTc3Rk78bXSS/hMsJgh0GdxK8wVH/DoGkTH28S6Ld+nQCnBU978FhJ5RGGrJZ4GWVU22Uw1wm1mCNfIqgY07reAvDSfqB4HCv6bJK8lF1yodWjLQYqMwz2pa7wEiseIZ/RoLJF60+27LGGyjqWt9/zrvWJ7E3TQOqQsdMSC02rO1rnDNSHzoUJpZQHbopLJ40m/5UuCToo+ZetkQTmtbqzS7dKx35KsmY27upQd85XouE73fNb1fgvmJOxWrXA0go7JydJawnjOJUM5Y7mFJ6tVyw3fM7qWlJ9uonjSSsBZMWsg9znPOOCafsThXtGXUFfA4qneBKeVY/Og==
X-YMail-OSG: AgjpXwwVM1lrfTQTQil5Ei0etrOUCw25GDOkJtigshqH07o53fvcpO4ems_tBlh
 9xFm1WvG9Czss9U_UD7vKaFoXK4mWbp6VFdk.SMhQ67dDkZ1vrjz0B6tOy0eXuJeLLM7McTm8Kt6
 wgH.W3VzM1s5BQcMoqVnGmeRZFrMICpZTeep8O.KUaaacvPW2RcTiKMtKSi3RUmr1KsS3JGFKiKg
 iG.SA6xE3rXPKDqfQzRmuxVDnDaWIM9nqmrlHBKBPmuJUlb_k08xh67iDIn5p3ZhQJVoqO4w0SeB
 L38dNxcJZxrQRHj3tyOl_S9rcPceEmszQEBYzs6LrcSCNUtTDcWTDMdC6ftr1jLS4bldlYgDNMUU
 dxE9jflm31xHhOkkH5t65cTuOT1lf8feABbdw11q1WXfUs.QZhc15tYw.E70xWkMctDBdhwyiigO
 s.SeT7FG0_4oZu_kTPVSrU7HSZIwpdSp0V9KON5erQDwMvAtW_hswBNjm56sttvZqGXEOHQtuhPl
 6MT6Q6s27AxgFtUwqoz6pSZJ5NC.5Jy46xv1xUmzAfoimwj49_BPIgUYWAZlcU.x5iaTs9Vx98x4
 EANEYmQn7ff1BolOAic92KSWDASCukgj9HS3ssOA1ZCcvefQF4AdLyw5MxeUVLbF2DFOS82KOQGZ
 HtTbffJnfWBdaMiEfShg.v6lRwUEEgdZXdl2QYIde1XoUXr7KbmGxKapXFxeqQBtJG.V7a_f6k4.
 e6AW1MtLKkR82mGzCqBY_IQ6LeAL3I6QsXGDJUmjf2JefzLNNDobKpguwoo91IIS1lVj8k4Z9YIR
 C8XWo2RF238XKLI4HroG_nDylYZ3yDOHsb_qJ.XefKH5kJhhj2TXOOTbiyIHUw_GUKonx1GVdKFP
 dCtT7QmOZzy.SoZNpagAgb.WfoEWLvdEgBVLd6BuVnYVCP03pOV6Am3QWH9dJFaQYDdcAXYJjSg6
 xSX5JgaAYyMscCtjGBrejWu.hsm3agLbsUpqkcG8KsUK.yJ3I1HW3.PLRVTOkuTLhfI01V8IMfkA
 enUyO473eAsXFAA.XwpdgdaiyKV5ipR3Z3hdgPuSCoY1Z1FddVas5Ux8PZciQwP.olUs0KWzmk0F
 uxfWkkbGrpW_YoSSRg_FG1ApsW6BwTmYvBZ.AlHBNB9cL3mAHxO.idtdcgFxHVVW6oHzrX0RhV2o
 CBx1_0lbcanSjO4h6MRbXCv49aLAZ5ihgZ5A6aMWXFrOHU34hl4DxKXFPt0mLMpsznOdSCSDfBoq
 3Kv38QrMnb3PtpvXJgwBFqLy0F1RTaXwvJ_YCjUGs5aj09VMNbQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:51 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:47 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/21] erofs: kill verbose debug info in erofs_fill_super
Date: Sun,  1 Sep 2019 13:51:21 +0800
Message-Id: <20190901055130.30572-13-hsiangkao@aol.com>
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

As Christoph said [1], "That is some very verbose
debug info.  We usually don't add that and let
people trace the function instead. "

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c1a42ea7b72f..b4bf72755300 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -383,9 +383,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	struct erofs_sb_info *sbi;
 	int err;
 
-	infoln("fill_super, device -> %s", sb->s_id);
-	infoln("options -> %s", (char *)data);
-
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
 	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
@@ -418,9 +415,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		return err;
 
-	if (!silent)
-		infoln("root inode @ nid %llu", ROOT_NID(sbi));
-
 	if (test_opt(sbi, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
@@ -453,7 +447,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return err;
 
 	if (!silent)
-		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
+		infoln("mounted on %s with opts: %s, root inode @ nid %llu.",
+		       sb->s_id, (char *)data, ROOT_NID(sbi));
 	return 0;
 }
 
-- 
2.17.1

