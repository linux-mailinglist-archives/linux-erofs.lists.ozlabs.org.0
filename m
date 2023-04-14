Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D736E1E4E
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 10:30:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyV5R316gz3cjK
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 18:30:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PyV5D6Cfwz3c9r
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 18:30:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vg2zKY5_1681461034;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2zKY5_1681461034)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 16:30:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: cleanup i_format-related stuffs
Date: Fri, 14 Apr 2023 16:30:27 +0800
Message-Id: <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Switch EROFS_I_{VERSION,DATALAYOUT}_BITS into
EROFS_I_{VERSION,DATALAYOUT}_MASK.

Also avoid erofs_bitrange() since its functionality is simple enough.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  8 ++++----
 fs/erofs/internal.h | 18 ++++--------------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 4ec422c2b74f..2c7b16e340fe 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -109,14 +109,14 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 }
 
 /* bit definitions of inode i_format */
-#define EROFS_I_VERSION_BITS            1
-#define EROFS_I_DATALAYOUT_BITS         3
+#define EROFS_I_VERSION_MASK            0x01
+#define EROFS_I_DATALAYOUT_MASK         0x07
 
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATALAYOUT_BIT          1
+#define EROFS_I_ALL_BIT			4
 
-#define EROFS_I_ALL	\
-	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+#define EROFS_I_ALL	((1 << EROFS_I_ALL_BIT) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
 #define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6c8c0504032e..e7b7d3f581c4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -343,24 +343,14 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
-static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
-					  unsigned int bits)
+static inline unsigned int erofs_inode_version(unsigned int ifmt)
 {
-
-	return (value >> bit) & ((1 << bits) - 1);
-}
-
-
-static inline unsigned int erofs_inode_version(unsigned int value)
-{
-	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
-			      EROFS_I_VERSION_BITS);
+	return (ifmt >> EROFS_I_VERSION_BIT) & EROFS_I_VERSION_MASK;
 }
 
-static inline unsigned int erofs_inode_datalayout(unsigned int value)
+static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 {
-	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
-			      EROFS_I_DATALAYOUT_BITS);
+	return (ifmt >> EROFS_I_DATALAYOUT_BIT) & EROFS_I_DATALAYOUT_MASK;
 }
 
 /*
-- 
2.24.4

