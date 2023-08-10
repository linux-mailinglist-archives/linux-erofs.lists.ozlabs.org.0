Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01A7770A4
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 08:46:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLyBy53T8z3cGC
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 16:46:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLyBr1MLsz2y9d
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 16:46:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpSi1co_1691649994;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpSi1co_1691649994)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 14:46:35 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: remove prototypes of removed functions
Date: Thu, 10 Aug 2023 14:46:33 +0800
Message-Id: <20230810064633.56218-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230810064633.56218-1-jefflexu@linux.alibaba.com>
References: <20230810064633.56218-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove prototypes of those that have been deleted.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/tar.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index b7c2ef8..d5648f6 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -29,10 +29,7 @@ struct erofs_tarfile {
 	bool index_mode, aufs;
 };
 
-int tarerofs_init_empty_dir(struct erofs_inode *inode);
 int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
-int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices);
-int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar);
 
 #ifdef __cplusplus
 }
-- 
2.19.1.6.gb485710b

