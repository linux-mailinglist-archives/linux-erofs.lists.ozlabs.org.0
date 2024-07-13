Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D721993041C
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 08:40:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fldGyzja;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WLf44586rz3cXw
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 16:40:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fldGyzja;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WLf3y5xBwz30WX
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jul 2024 16:40:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720852839; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BQKQMyECbmdsnwbmVVugMFrl5NSpdJP/BR0eJigJxuo=;
	b=fldGyzja7zap1j5W9XSs8VsLE3WhDfGTXerJhOMkfvi25aLE1CkmJPT93BDlV4v4m2pjWKxuBngprcgvMIoGf8LIzU67tJhDsml84q4gmMvNbasqnCLh1EHYZATO1QW/uLFqOdgmizkcyUSBfqrJPRBv1jCdRaX4LGHmwGrB+QI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WAQBWiV_1720852829;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAQBWiV_1720852829)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 14:40:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: tar: support ddtaridx format informally
Date: Sat, 13 Jul 2024 14:40:28 +0800
Message-ID: <20240713064028.4134602-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240712074002.2838944-1-hsiangkao@linux.alibaba.com>
References: <20240712074002.2838944-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Yuan <tuji.yyf@alibaba-inc.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

`ddtaridx` is a customized tar meta-only format implemented in
Alibaba's OverlayBD project [1].

Please don't use it externally if you have no idea of this except for
the OverlayBD project.  It will be removed if some better way exists.

[1] https://github.com/containerd/overlaybd

Cc: Yifan Yuan <tuji.yyf@alibaba-inc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - `headerball` or `ddtaridx` might not have two trailing zero blocks.

 include/erofs/tar.h |  1 +
 lib/tar.c           | 39 ++++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 403f3a8..6fa72eb 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -61,6 +61,7 @@ struct erofs_tarfile {
 	int fd;
 	u64 offset;
 	bool index_mode, headeronly_mode, rvsp_mode, aufs;
+	bool ddtaridx_mode;
 };
 
 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/tar.c b/lib/tar.c
index 5e2c5b8..e35f473 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -611,19 +611,6 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 	return 0;
 }
 
-static int tarerofs_write_file_index(struct erofs_inode *inode,
-		struct erofs_tarfile *tar, erofs_off_t data_offset)
-{
-	int ret;
-
-	ret = tarerofs_write_chunkes(inode, data_offset);
-	if (ret)
-		return ret;
-	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
-		return -EIO;
-	return 0;
-}
-
 int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 {
 	char path[PATH_MAX];
@@ -631,7 +618,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	struct erofs_sb_info *sbi = root->sbi;
 	bool whout, opq, e = false;
 	struct stat st;
-	erofs_off_t tar_offset, data_offset;
+	erofs_off_t tar_offset, dataoff;
 
 	struct tar_header *th;
 	struct erofs_dentry *d;
@@ -658,6 +645,10 @@ restart:
 	tar_offset = tar->offset;
 	ret = erofs_iostream_read(&tar->ios, (void **)&th, sizeof(*th));
 	if (ret != sizeof(*th)) {
+		if (tar->headeronly_mode || tar->ddtaridx_mode) {
+			ret = 1;
+			goto out;
+		}
 		erofs_err("failed to read header block @ %llu", tar_offset);
 		ret = -EIO;
 		goto out;
@@ -691,7 +682,7 @@ restart:
 		cksum += (unsigned int)((u8*)th)[j];
 		ckksum += (int)((char*)th)[j];
 	}
-	if (csum != cksum && csum != ckksum) {
+	if (!tar->ddtaridx_mode && csum != cksum && csum != ckksum) {
 		erofs_err("chksum mismatch @ %llu", tar_offset);
 		ret = -EBADMSG;
 		goto out;
@@ -770,8 +761,9 @@ restart:
 			path[--j] = '\0';
 	}
 
-	data_offset = tar->offset;
-	tar->offset += st.st_size;
+	dataoff = tar->offset;
+	if (!(tar->headeronly_mode || tar->ddtaridx_mode))
+		tar->offset += st.st_size;
 	switch(th->typeflag) {
 	case '0':
 	case '7':
@@ -860,7 +852,7 @@ restart:
 
 	/* EROFS metadata index referring to the original tar data */
 	if (tar->index_mode && sbi->extra_devices &&
-	    erofs_blkoff(sbi, data_offset)) {
+	    erofs_blkoff(sbi, dataoff)) {
 		erofs_err("invalid tar data alignment @ %llu", tar_offset);
 		ret = -EIO;
 		goto out;
@@ -985,16 +977,21 @@ new_inode:
 		} else if (inode->i_size) {
 			if (tar->headeronly_mode) {
 				ret = erofs_write_zero_inode(inode);
+			} else if (tar->ddtaridx_mode) {
+				dataoff = le64_to_cpu(*(__le64 *)(th->devmajor));
+				ret = tarerofs_write_chunkes(inode, dataoff);
 			} else if (tar->rvsp_mode) {
 				inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
-				inode->i_ino[1] = data_offset;
+				inode->i_ino[1] = dataoff;
 				if (erofs_iostream_lskip(&tar->ios, inode->i_size))
 					ret = -EIO;
 				else
 					ret = 0;
 			} else if (tar->index_mode) {
-				ret = tarerofs_write_file_index(inode, tar,
-								data_offset);
+				ret = tarerofs_write_chunkes(inode, dataoff);
+				if (!ret && erofs_iostream_lskip(&tar->ios,
+								 inode->i_size))
+					ret = -EIO;
 			} else {
 				ret = tarerofs_write_file_data(inode, tar);
 			}
-- 
2.43.5

