Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369554DC508
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 12:48:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KK5530jL6z30Df
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 22:48:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KK54s3xjcz2xTq
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 22:48:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R971e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V7RcuMP_1647517690; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7RcuMP_1647517690) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Mar 2022 19:48:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: rename ctime to mtime
Date: Thu, 17 Mar 2022 19:48:08 +0800
Message-Id: <20220317114808.104788-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: David Anderson <dvander@google.com>

EROFS images should inherit modification time rather than change time,
since users and host tooling have no easy way to control change time.

To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
renamed to i_mtime and i_mtime_nsec.

Signed-off-by: David Anderson <dvander@google.com>
[ Gao Xiang: update document as well. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
If no other concerns, I will apply it for 5.18.

 Documentation/filesystems/erofs.rst | 2 +-
 fs/erofs/erofs_fs.h                 | 5 +++--
 fs/erofs/inode.c                    | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 7119aa213be7..bef6d3040ce4 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -40,7 +40,7 @@ Here is the main features of EROFS:
    Inode metadata size    32 bytes      64 bytes
    Max file size          4 GB          16 EB (also limited by max. vol size)
    Max uids/gids          65536         4294967296
-   File change time       no            yes (64 + 32-bit timestamp)
+   Per-inode timestamp    no            yes (64 + 32-bit timestamp)
    Max hardlinks          65536         4294967296
    Metadata reserved      4 bytes       14 bytes
    =====================  ============  =====================================
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3ea62c6fb00a..1238ca104f09 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -12,6 +12,7 @@
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -186,8 +187,8 @@ struct erofs_inode_extended {
 
 	__le32 i_uid;
 	__le32 i_gid;
-	__le64 i_ctime;
-	__le32 i_ctime_nsec;
+	__le64 i_mtime;
+	__le32 i_mtime_nsec;
 	__le32 i_nlink;
 	__u8   i_reserved2[16];
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ff62f84f47d3..e8b37ba5e9ad 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -113,8 +113,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_ctime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_ctime_nsec);
+		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
+		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
-- 
2.24.4

