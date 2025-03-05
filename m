Return-Path: <linux-erofs+bounces-9-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E2A5068D
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Mar 2025 18:39:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7KYs31TFz3brd;
	Thu,  6 Mar 2025 04:39:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741196385;
	cv=none; b=nWC/qrYRjmKcEg3FvJmieyDM48+mkOrKECwBnJBSa6XPx4XX1wIl5Ft/eosTsfkd/OjFB3mGy+5SlIFkNFK1bMt0HF5oeiBDhHFefIfJbIIZqx8dvA3b8RK+97HkM7RcvrSMtudcFqZL0XMhZYUoUaZ5sM+phWVUn76M71I3l0mSHibkCYCiT3jqjxbDqfDiep0WFTiNaYFNWWoJ8geV+lsr2ndzzB537hSSMF/NKPkridBsE7Vmh5SRdchFMGv8/VOBmZYhXvwhGHy1SmEFwZcoZF/0Ny6QYts1DdV2RGxx2ygXVsUn40D+p5dwpYurgjJUeNCH/WwV9ZkIO04EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741196385; c=relaxed/relaxed;
	bh=SBP1Q6tiJ7OFYObHbfgtxgjOx8JJ0+2kv9/cqxRtF0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqgiUMynRd+Itrf/zNKhm7ILaeFVlUwEoCR8mko35zulB1LUPhHLTMaU5x//bWMp9bfQKqgE53FKlVSFRMKEQgDXO5iLPn5YzGwV+cQEMR6t2ETo6l3N7c4ivBSMlgndm94EDxZB34RgWBW4aRqMOhDa+eyiM4rU367ppEHGHE9kO7FHyDR7sthNEf4qKf6NtmG62fMGwqehEoLtrO7EsvZJn7OBSnC8wdbRv0e10rtuSBMv2uTvgmP+YBN4gXPwZdm5QQuKYK8IJ+FRgQZKjzbHrxmqPO5FthhQ8xWco7FmSjq0vfW0H/OgZpdwsZU1e87kuKsyZ/pJgo+iBN5bIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kzUfIU0g; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kzUfIU0g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7KYq38T1z3bqP
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 04:39:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741196377; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SBP1Q6tiJ7OFYObHbfgtxgjOx8JJ0+2kv9/cqxRtF0A=;
	b=kzUfIU0gCnuF6f24G0y7mel8P4VvcsnfDb/pGeRMZ3mISuiag75A4Gn2FOpLie/KpoJvcmQwUhK33oS9Ww2cORyxHAFNj5j8RbBYxiN+2gvAq1kmrZ0wjqrMioJXWP7MCAIaApls52A5QOQfMau1XURhP70jFTZngwy1cQ4IhTU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQm8YtV_1741196371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 01:39:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: simplify erofs_read_inode_from_disk()
Date: Thu,  6 Mar 2025 01:39:28 +0800
Message-ID: <20250305173930.2223550-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Source kernel commit: 914fa861e3d7803c9bbafc229652c2a69edb8b60

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/namei.c | 77 ++++++++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/lib/namei.c b/lib/namei.c
index eec1f5c..b40f092 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -26,14 +26,13 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
+	erofs_off_t inode_loc = erofs_iloc(vi);
 	struct erofs_sb_info *sbi = vi->sbi;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	erofs_off_t inode_loc;
+	union erofs_inode_i_u iu;
 
 	DBG_BUGON(!sbi);
-	inode_loc = erofs_iloc(vi);
-
 	ret = erofs_dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
@@ -61,26 +60,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(die->i_mode);
 		vi->i_ino[0] = le32_to_cpu(die->i_ino);
-
-		switch (vi->i_mode & S_IFMT) {
-		case S_IFREG:
-		case S_IFDIR:
-		case S_IFLNK:
-			vi->u.i_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-			vi->u.i_rdev =
-				erofs_new_decode_dev(le32_to_cpu(die->i_u.rdev));
-			break;
-		case S_IFIFO:
-		case S_IFSOCK:
-			vi->u.i_rdev = 0;
-			break;
-		default:
-			goto bogusimode;
-		}
-
+		iu = die->i_u;
 		vi->i_uid = le32_to_cpu(die->i_uid);
 		vi->i_gid = le32_to_cpu(die->i_gid);
 		vi->i_nlink = le32_to_cpu(die->i_nlink);
@@ -88,35 +68,13 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_mtime = le64_to_cpu(die->i_mtime);
 		vi->i_mtime_nsec = le64_to_cpu(die->i_mtime_nsec);
 		vi->i_size = le64_to_cpu(die->i_size);
-		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
-			/* fill chunked inode summary info */
-			vi->u.chunkformat = le16_to_cpu(die->i_u.c.format);
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(dic->i_mode);
 		vi->i_ino[0] = le32_to_cpu(dic->i_ino);
-
-		switch (vi->i_mode & S_IFMT) {
-		case S_IFREG:
-		case S_IFDIR:
-		case S_IFLNK:
-			vi->u.i_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-			vi->u.i_rdev =
-				erofs_new_decode_dev(le32_to_cpu(dic->i_u.rdev));
-			break;
-		case S_IFIFO:
-		case S_IFSOCK:
-			vi->u.i_rdev = 0;
-			break;
-		default:
-			goto bogusimode;
-		}
-
+		iu = dic->i_u;
 		vi->i_uid = le16_to_cpu(dic->i_uid);
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nlink);
@@ -125,8 +83,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_mtime_nsec = sbi->build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
-		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
-			vi->u.chunkformat = le16_to_cpu(dic->i_u.c.format);
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version %u of nid %llu",
@@ -134,8 +90,30 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		return -EOPNOTSUPP;
 	}
 
+	switch (vi->i_mode & S_IFMT) {
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFLNK:
+		vi->u.i_blkaddr = le32_to_cpu(iu.raw_blkaddr);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+		vi->u.i_rdev = erofs_new_decode_dev(le32_to_cpu(iu.rdev));
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		vi->u.i_rdev = 0;
+		break;
+	default:
+		erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode,
+			  vi->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+
 	vi->flags = 0;
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+		/* fill chunked inode summary info */
+		vi->u.chunkformat = le16_to_cpu(iu.c.format);
 		if (vi->u.chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err("unsupported chunk format %x of nid %llu",
 				  vi->u.chunkformat, vi->nid | 0ULL);
@@ -145,9 +123,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
 	return 0;
-bogusimode:
-	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
-	return -EFSCORRUPTED;
 }
 
 struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
-- 
2.43.5


