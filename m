Return-Path: <linux-erofs+bounces-1188-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C619BE14FB
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7f4m5Sz301N;
	Thu, 16 Oct 2025 13:48:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582910;
	cv=none; b=GbWG4WfnfOFffW7xKvii+RcSYJUQvwFEG7cfzp4OJX5/OtsBprClIx5ZpH9feUF20FdSKlWAfMkxtRiGqvySKRgrP96m6Eez2tsfDzgo2nkmi6WibL0ptqOHklis7jlDKSt9ZqgJIob9tlNArVMSCxwDivKEnvFDLN4NMaJhkf0ql+oZEOFS7YiKcGIpcponYFDwLQvY+FPlfISFiO8fEwV5YZ4co4NgmkBk/Qr13CAbO0uWLR8BFhEAZOf17AKilT15Qg2zOIEBvs9qUPkNayhNzDbc+2ruVxJF2J1SD8tRSesMCqhln7wDqTfFvl8Fi8AaqJSrbhzOhiEEbSW50g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582910; c=relaxed/relaxed;
	bh=zy87n7dSAfTDhwIM1HsuwHIXsz4PF4ITAvXeRCawAZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0ieYvY4KyTwrd2w5rh6hd/aWg/vjM73LwlM8P7czKGTDX8df1qnZh40LrS6KbqMxW47YxxVbyHjnMlSiAkMc/LRnMCrT+eLJCdOW9G2ZVDQRbl0l1pdd8CHE6rqbeN2nG8dU35l8/r3OVEFrEmlBEAa76HDetDfrypwkkiFU+37pfVlEnaSlm2Pol11u1JVlpBqxvGDIP3el/KdIaSNigemwl3sSzF+Yn/a5BD+yu6BawlW5h+IZVIfDQfTQ0lGAkP2rqJCI1QzuipU/IqO5BOGlZ/sPZLdi9TElJ0IvsLX0DfnHy6n1w7OD1OzBV9PdsD5/uh6NWl9f5cZCm2n/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q4jakcEN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q4jakcEN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7c6CZ4z3bW7
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zy87n7dSAfTDhwIM1HsuwHIXsz4PF4ITAvXeRCawAZE=;
	b=Q4jakcENenFc8LhOnXyKGLmxNkGbj22Pqa3/1/IrIRgIKsVfIFDUlHAshM2Id0ECi7SiDeLQi2YXwMygYSOHr1v6J7MSxK0FZa4R2bbVWqCYuWVdnUMe0nXfj3aTrhgoufnM5eTRO5Q4q2gyrFdciVPjJKgEsgNbviA/GRekig4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVk9_1760582903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6/7] erofs-utils: lib: refine erofs_write_unencoded_data()
Date: Thu, 16 Oct 2025 10:48:14 +0800
Message-ID: <20251016024815.2750927-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

It is now used as an unencoded layout writer by leveraging
virtual files.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index e7c3edf..264c4ae 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -612,33 +612,31 @@ static bool erofs_file_is_compressible(struct erofs_importer *im,
 	return true;
 }
 
-static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd,
-					   erofs_off_t fpos)
+static int erofs_write_unencoded_data(struct erofs_inode *inode,
+				      struct erofs_vfile *vf, erofs_off_t fpos,
+				      bool noseek)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t nblocks, i;
 	unsigned int len;
 	int ret;
-	bool noseek = inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF;
 
 	if (!noseek && erofs_sb_has_48bit(sbi)) {
-		if (lseek(fd, fpos, SEEK_DATA) < 0 && errno == ENXIO) {
+		if (erofs_io_lseek(vf, fpos, SEEK_DATA) < 0 && errno == ENXIO) {
 			ret = erofs_allocate_inode_bh_data(inode, 0);
 			if (ret)
 				return ret;
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			return 0;
 		}
-		ret = lseek(fd, fpos, SEEK_SET);
+		ret = erofs_io_lseek(vf, fpos, SEEK_SET);
 		if (ret < 0)
 			return ret;
 		else if (ret != fpos)
 			return -EIO;
 	}
 
-	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size >> sbi->blkszbits;
-
 	ret = erofs_allocate_inode_bh_data(inode, nblocks);
 	if (ret)
 		return ret;
@@ -648,8 +646,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd,
 			    erofs_pos(sbi, nblocks - i));
 		ret = erofs_io_xcopy(&sbi->bdev,
 				     erofs_pos(sbi, inode->u.i_blkaddr + i),
-				     &((struct erofs_vfile){ .fd = fd }), len,
-				     noseek);
+				     vf, len, noseek);
 		if (ret)
 			return ret;
 	}
@@ -661,7 +658,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd,
 		if (!inode->idata)
 			return -ENOMEM;
 
-		ret = read(fd, inode->idata, inode->idata_size);
+		ret = erofs_io_read(vf, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
 			free(inode->idata);
 			inode->idata = NULL;
@@ -682,8 +679,11 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
+	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	/* fallback to all data uncompressed */
-	return write_uncompressed_file_from_fd(inode, fd, fpos);
+	return erofs_write_unencoded_data(inode,
+			&(struct erofs_vfile){ .fd = fd }, fpos,
+			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
 }
 
 int erofs_iflush(struct erofs_inode *inode)
@@ -2152,7 +2152,11 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		if (ret < 0)
 			return ERR_PTR(-errno);
 	}
-	ret = write_uncompressed_file_from_fd(inode, fd, 0);
+
+	inode->datalayout = EROFS_INODE_FLAT_INLINE;
+	ret = erofs_write_unencoded_data(inode,
+			&(struct erofs_vfile){ .fd = fd }, 0,
+			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
 	if (ret)
 		return ERR_PTR(ret);
 out:
-- 
2.43.5


