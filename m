Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8151DFC6
	for <lists+linux-erofs@lfdr.de>; Fri,  6 May 2022 21:46:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kw1Kh6Hcvz3cBn
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 05:46:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kw1KW5thtz3byZ
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 05:46:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VCTGrlU_1651866391; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCTGrlU_1651866391) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 May 2022 03:46:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] erofs: remove obsoluted comments
Date: Sat,  7 May 2022 03:46:11 +0800
Message-Id: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Some comments haven't been useful anymore since the code updated.
Let's drop them instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    |  5 -----
 fs/erofs/internal.h | 25 -------------------------
 2 files changed, 30 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8d3f56c6469b..8b18d57ec18f 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,11 +8,6 @@
 
 #include <trace/events/erofs.h>
 
-/*
- * if inode is successfully read, return its inode page (or sometimes
- * the inode payload page if it's an extended inode) in order to fill
- * inline data if possible.
- */
 static void *erofs_read_inode(struct erofs_buf *buf,
 			      struct inode *inode, unsigned int *ofs)
 {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ce2a04836cd2..cfee49d33b95 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -397,31 +397,6 @@ extern const struct super_operations erofs_sops;
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
-/*
- * Logical to physical block mapping
- *
- * Different with other file systems, it is used for 2 access modes:
- *
- * 1) RAW access mode:
- *
- * Users pass a valid (m_lblk, m_lofs -- usually 0) pair,
- * and get the valid m_pblk, m_pofs and the longest m_len(in bytes).
- *
- * Note that m_lblk in the RAW access mode refers to the number of
- * the compressed ondisk block rather than the uncompressed
- * in-memory block for the compressed file.
- *
- * m_pofs equals to m_lofs except for the inline data page.
- *
- * 2) Normal access mode:
- *
- * If the inode is not compressed, it has no difference with
- * the RAW access mode. However, if the inode is compressed,
- * users should pass a valid (m_lblk, m_lofs) pair, and get
- * the needed m_pblk, m_pofs, m_len to get the compressed data
- * and the updated m_lblk, m_lofs which indicates the start
- * of the corresponding uncompressed data in the file.
- */
 enum {
 	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
-- 
2.24.4

