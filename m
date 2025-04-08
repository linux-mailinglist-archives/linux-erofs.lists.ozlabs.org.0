Return-Path: <linux-erofs+bounces-161-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F6A80222
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 13:45:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX4501GKfz305v;
	Tue,  8 Apr 2025 21:45:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744112708;
	cv=none; b=DV6KNu8bruYcou2AB8z4vkrJHaxSXwqsyj4979mQIsevJO4Bib5qE87kA46pA46MdIUEP/pERsjCG/49cUQPMZe1jUExJOZ+wNmZdr8qF5+/FLz4nPg63E85dG/46sP/jXnqlrzmsNy0Y6l3nvTmsnYMS6wq2WkIuM0Qht0Eug4/A94fywXkyjsx5Nl/Usy1ATZsJ3Z4Bv6XYYZGBMifv1fbD75pNSNMQ6raRcu0cJVWKPuxuuZSsNYUo6CcbM13dQYOwakWzqvEdDeFOidynjo+BKLjxMEGg6zsnTdH3v5PzkWMRpnTQzBlNi1UMcNa8SOllCFlvNlekAYZ0KcWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744112708; c=relaxed/relaxed;
	bh=BqZWTIZ7e6ej2vIjCy7sCUZGfP06XjXg1jXPbyRYLgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hy67oN1WbHeG2Mc0TZW/hgacCWl4ZjcXEsyM10nj4lyrz3jz4BHXqI7A1+WtRPFgz+3E0FqESbVNsXLgEUFhW1OoG91pqUZ/LsYocfeYCsp6FB52p4sCjhQoq4T/C16pSejALeNCWIG7r95lqrStVFcuRmtNtpp0Vy86r5xz3Ou5mTRuTjp9HpESHKcJ9GX2n7skBvZynuVANpLz1w5ELP2m4vyBArRxB/rQweZfE9kpYIPSG1NNtG4hPkkefZyl8p9OfPpqzJJG+e7+mBvmKp1RczSU3Tyq9ac90epmNLQpB4Hz1YL3WvWSnb4WoRZUGi6mLS8L8CJEGBtrt8sqmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h9RYuhNj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h9RYuhNj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX44w0LNpz306S
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 21:45:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744112696; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BqZWTIZ7e6ej2vIjCy7sCUZGfP06XjXg1jXPbyRYLgU=;
	b=h9RYuhNjlQeVhZZvPdHzga0dq9UrUT3fqX0cqDMJle+l9HTLNKMSeAQJl/Y1SL3Mu9/sg+F6DVoDXdSQZbVA70MxIp+LEfTb8yas+uvaMjx+M1QNF6a62SobX37P1EwU2gzhGnicWYEdxXEOOCQSbafkuQZJjJ6qfc2+08oZ79o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWFISUC_1744112689 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 19:44:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] erofs: add __packed annotation to union(__le16..)
Date: Tue,  8 Apr 2025 19:44:47 +0800
Message-ID: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I'm unsure why they aren't 2 bytes in size only in arm-linux-gnueabi.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202504051202.DS7QIknJ-lkp@intel.com
Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 61a5ee11f187..94bf636776b0 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -56,7 +56,7 @@ struct erofs_super_block {
 	union {
 		__le16 rootnid_2b;	/* nid of root directory */
 		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
-	} rb;
+	} __packed rb;
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
 	__le64 epoch;		/* base seconds used for compact inodes */
 	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
@@ -148,7 +148,7 @@ union erofs_inode_i_nb {
 	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
 	__le16 blocks_hi;	/* total blocks count MSB */
 	__le16 startblk_hi;	/* starting block number MSB */
-};
+} __packed;
 
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
@@ -369,9 +369,9 @@ struct z_erofs_map_header {
 			 * bit 7   : pack the whole file into packed inode
 			 */
 			__u8	h_clusterbits;
-		};
+		} __packed;
 		__le16 h_extents_hi;	/* extent count MSB */
-	};
+	} __packed;
 };
 
 enum {
-- 
2.43.5


