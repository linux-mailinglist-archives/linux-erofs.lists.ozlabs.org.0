Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7919A02FD
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 09:49:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XT3545nr6z2yQJ
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 18:49:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729064951;
	cv=none; b=njCN9uaxhAwhTrhjCsPRthHf7pBUhLldDMEXh8xIDIlmNjpUauzf57OS2oNFvILBxumRSlNPr/+bJTcqLFvO0zKYocY79/zzQkyStEuMtK89sViBHWxZL8nC+LF9U4P2CtAToNgahx/zh7TlNzCM+tO2u0/HQqbBCuBFPnRwwczl4g1IDIaQEiJdAMd4IphanNdbWmu5VULgI1Z+Aym4FlwU5zYYH2UZGp8n4t70LlfL5stZYf0tD5I2yUpUBHGGcZaMU3njd/L636AUZVap3kZfGWx8H4II2huBWSQqETf8PKvrumemlowK65EXJevYQh4wxF7VtkyNYEWKn9vinw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729064951; c=relaxed/relaxed;
	bh=9ibaNb09EgrjwollziJ1TM1n67BixQySMDktzo7al30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oASNPSBioB55K2livMXPfcZ15fnOhGTV/0yVgyo2Gg6NZ6XwGgYrQJImR++lMeSwJtFef9Mld/nX2eSf+nRgBEEgJns+daABJPVoJ60PXbkJKKKg9EzbsWNiB30U8NnB3KJikrhQYF2YVxdE3Hct2J4vKMu5/Hm+jHxdqkXD48FsB88N/1z72XTG+hktgIDyWaMWC7fqyhU8o+RIvUzqUNDfDA9jt7SxGaEAnGxG8TJ8a0t6wdLB6Fz+k1iJrEULIIy4pxIuypKk3998TlKq21pvV6zNu1WwvXAz1Y8fAznhnWlHqvSIz+ESPAJJLACPT2LTI0tliq5mbN2KWVVL7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WjRaCzY4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WjRaCzY4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XT34x4rWwz2xjd
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2024 18:49:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729064937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9ibaNb09EgrjwollziJ1TM1n67BixQySMDktzo7al30=;
	b=WjRaCzY4h59zqpq6bb4ng/0SDQ4nDj1/LBIQuDtpc143Em2UTTR8bYwS8x5yXQj3EcsjAvKTwZ06lbEqlm+UQ8OrN4G0v0Motqa9iaLZPH6DVxoh/0QUyEvFhPDVOgXXoodT8nJLW4shC6PuUFVJqU8l/EC7ykGUNdYAnF8gVus=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHGX2VC_1729064930 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 15:48:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix unexpected errors for chunk-based images
Date: Wed, 16 Oct 2024 15:48:49 +0800
Message-ID: <20241016074849.2862282-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

mkfs.erofs may fail because copy_file_range() returns the number of
bytes which could be less than the length originally requested.

Fixes: 03cbf7b8f7f7 ("erofs-utils: mkfs: support chunk-based uncompressed files")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 6c2ea0e..9e85721 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -480,9 +480,8 @@ int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 {
 	struct erofs_buffer_head *bh;
-	ssize_t length;
+	ssize_t length, ret;
 	u64 pos_in, pos_out;
-	ssize_t ret;
 
 	if (blobfile) {
 		fflush(blobfile);
@@ -532,9 +531,21 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 	pos_out += sbi->bdev.offset;
 	if (blobfile) {
 		pos_in = 0;
-		ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
-				sbi->bdev.fd, &pos_out, datablob_size);
-		ret = ret < datablob_size ? -EIO : 0;
+		do {
+			length = min_t(erofs_off_t, datablob_size,  SSIZE_MAX);
+			ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
+					sbi->bdev.fd, &pos_out, length);
+		} while (ret > 0 && (datablob_size -= ret));
+
+		if (ret >= 0) {
+			if (datablob_size) {
+				erofs_err("failed to append the remaining %llu-byte chunk data",
+					  datablob_size);
+				ret = -EIO;
+			} else {
+				ret = 0;
+			}
+		}
 	} else {
 		ret = erofs_io_ftruncate(&sbi->bdev, pos_out + datablob_size);
 	}
-- 
2.43.5

