Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D7305F9
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQs00fxrzDqWF
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:52:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263940;
	bh=uUS7TwRpUzUffxP+NuqNpvuEvNH2atlNPdqmJzjM16Y=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SvOuHGA1Wdjc09nwuR9hbUApXHqHiaqjxqbfI22tBu50/Med6Si3S5tHInTtaSWil
	 EKxIBzF/HlXA1U7RIV82kHhTrWsIGAxAbskbk184wYWGckCVelI+pK/aSSkeM4yltf
	 B4bPstcUb9yazWm3w3hMtNCpddEkjte57cZq3oPIOcaGO7q9XLNSveIyF4ZU7Xx06k
	 7x/mgo7bD/++HnlkuSQYw5peh+EDHgtDFcs7Q1/TeSx6dGvC+DS3FkART5lGsPQJH4
	 O9MU1GQCtmIb3Ej+PdyQ6Rz2s77YhM/OrMOxTA4IpugZZsfyuICvKZ6Z4ciNy8y/aG
	 XcDdPE1ko4arg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="ZAXlTjCY"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrh2k7szDqW8
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:52:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263922; bh=qPACMkgQpewgmHQ7/F/l7hgdmaLRE2PUVakTzGI6pjs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=ZAXlTjCYMldOpcMc5UaMJA/DDBMLhhy2TbIHfHACQZHuBSp/vxQU4M5VVU3ZUudSejrtRdVtEI9JdmzNAMoInPnakWnfiGhxXWDvzqw4Npa/zcbRolYNgNGld0jEfyG0IzwxqkZRGeIgd1pGvdJKQLKYxjoJbh5+p7UJ0Z9jCQ2wlNxgX/5KILzPrgBsbnG1pl1n0485KJmWad0hJj9Own+ZPWMw9vUD6jB41+0pmq0I5lz8bqR3yMIL9RrnX9MzD4wK6+7oV9ZX7f6eYH8xMshtiCyEBenNygbBYYhAFI37pk2pPGQ0gc8h0C3FmrBGZpjKJzpTsbzbha9A7mNOUg==
X-YMail-OSG: wqhLiAwVM1lTvZ80.su4531WXjR8oCXiNV23OgtAwAkz4EeulGLCIoWur6HMqjh
 Nm8dfa4C4QSgFDNrSo6_Qdy8aN8LJVNxcyFZTy2YXYUMUm38gNrUOEy1m3387_VN48_H0I957yJw
 Z6lr1p6OdfwkSW4dChY.lrVV5SSYjzk36W8gAlvmHVJQV1Hmb9IESAwaJ1NDxL8Pw2llX5Yyc5zx
 QqMLwygAe7OD1npjZ.kOImmSZax3qoyNDKpx1ClcPQVjGW_rJiYOzRecRqrAuj7rk1Cz9gscB3dr
 yhVxQX0TmgKeHF0RcNRf0RzP5i.80rHvlKG7cYEdc1K.K6tvMNQAGSjuP.sk3B3D0LMzICANk_ZZ
 4_E2fCB25GCJjJyadQRR7kHruFYN9FCKQFkTSprF8G8PW62VbQpygNr7SpOn5Di5bPerQzLRiZb8
 iMwCwFxoGA3VtlnFhM8CP1BGP2HAS3uYqY1PBlvDpNo.kA_ttJUtz.DZzprLIq68.bpp2uIp7rvZ
 lpI.x9l2nB0XvQur.CWkUPolR7DSh71M1OfAAYHxTeCXq2.SOcrTrVvZa3CfgMzyIrZchPT7Ex28
 .QjIx2DOvu_trqUUqQeWWqNNeCfUBVud8URZknCVb58avw9akwQks76d0ncdfU1SVubCoTC_YwZr
 UTRYtgdY11bfpJViFFfzByHiv0JWUYFZq8d7q_dmtJ.z8mW91WFR7gSvyZz_.U7KlbUl_prckY6V
 9EFrCEFuoty6TsM3lpymo64TDwlPtao4gsxPb5iyyF5RWKBu.MSHGcQaqMMzlPPrcvWTdJV4M9ss
 xjsRk6E9akGQqtOXp8sl02hQAxRcYOaHoZiYsgLlTYvvCxxv6nTvwWOtWo7NkGCHxzZUwYNS3vt7
 lDyJkEXMhXeiV2e8bDaQpD9yoncVQjmxU2MX7CZ9FNnUNmWir1QSDLIdsd74ilz4aWdwxvd2F4y9
 FenORoa_cm6LadIn80.Z3Vt94PsB3avG4JS86hv8u0LTAAQ9W.8of9GRD0mjFaRT.nf0W7D.xYC8
 LKk5wtEqW5FyZ9I23zqaBgb2DDKnJfSRTxx1bdCAQRiJ7.5iq1vQ0PAAaX19MioyQ7ANr8da9MoI
 DnYzj9FoAOLUL95hn_9ryI38rytUiRv3sJlXLrNqCPJOLwWsrCAPpLHhQIk8NPLaKbwNGEM5VT4O
 ACIlJD5vsWo4iUOC2FaNRrUq3iTbRAaOGp4sKuxSm4jrIYpiC61I2F.Mlkg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:52:02 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:58 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 13/13] erofs-utils: fix potential erofs_bh_balloon failure
Date: Fri, 31 May 2019 08:50:47 +0800
Message-Id: <20190531005047.22093-14-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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

erofs_write_tail_end is called at the last end
of erofs_mkfs_build_tree, which is of course
after traversing all sub-tree inodes.

Therefore, erofs_bh_balloon could fail if
corresponding block is allocated, fix it.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Will be wrapped in the original patch.

 lib/inode.c | 61 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index b7fcf0e..9f7a4e4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -399,6 +399,35 @@ static struct erofs_bhops erofs_write_inode_bhops = {
 	.flush = erofs_bh_flush_write_inode,
 };
 
+int erofs_prepare_tail_block(struct erofs_inode *inode)
+{
+	struct erofs_buffer_head *bh;
+	int ret;
+
+	if (!inode->idata_size)
+		return 0;
+
+	bh = inode->bh_data;
+	if (!bh) {
+		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
+		if (IS_ERR(bh))
+			return PTR_ERR(bh);
+		bh->op = &erofs_skip_write_bhops;
+
+		/* get blkaddr of bh */
+		ret = erofs_mapbh(bh->block, true);
+		DBG_BUGON(ret < 0);
+		inode->u.i_blkaddr = bh->block->blkaddr;
+
+		inode->bh_data = bh;
+		return 0;
+	}
+	/* expend a block as the tail block (should be successful) */
+	ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
+	DBG_BUGON(ret);
+	return 0;
+}
+
 int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	unsigned int inodesize;
@@ -421,11 +450,18 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
+		int ret;
+
 		inode->data_mapping_mode = EROFS_INODE_LAYOUT_PLAIN;
 noinline:
+		/* expend an extra block for tail-end data */
+		ret = erofs_prepare_tail_block(inode);
+		if (ret)
+			return ret;
 		bh = erofs_balloc(INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
+		DBG_BUGON(inode->bh_inline);
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
@@ -485,28 +521,11 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->op = &erofs_write_inline_bhops;
 	} else {
 		int ret;
-		erofs_off_t off;
-
-		if (bh) {
-			/* expend a block (should be successful) */
-			ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
-			DBG_BUGON(ret);
-
-			erofs_mapbh(bh->block, true);
-			off = erofs_btell(bh, true) - EROFS_BLKSIZ;
-		} else {
-			bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
-			if (IS_ERR(bh))
-				return PTR_ERR(bh);
-
-			bh->op = &erofs_skip_write_bhops;
-			erofs_mapbh(bh->block, true);
-			off = erofs_btell(bh, false);
-			inode->u.i_blkaddr = erofs_blknr(off);
-			inode->bh_data = bh;
-		}
 
-		ret = dev_write(inode->idata, off, inode->idata_size);
+		erofs_mapbh(bh->block, true);
+		ret = dev_write(inode->idata,
+				erofs_btell(bh, true) - EROFS_BLKSIZ,
+				inode->idata_size);
 		if (ret)
 			return ret;
 
-- 
2.17.1

