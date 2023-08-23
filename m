Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB0B785143
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 09:15:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVyD53Tymz2yst
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:15:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVyCy4Xmzz2yhM
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 17:15:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqPEAPH_1692774918;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqPEAPH_1692774918)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 15:15:19 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 01/10] erofs-utils: lib: fix dirent type of whiteout in tarerofs
Date: Wed, 23 Aug 2023 15:15:08 +0800
Message-Id: <20230823071517.12303-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
References: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
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

Set the correct dirent type for whiteout.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/tar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tar.c b/lib/tar.c
index 42590d2..328ab98 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -694,6 +694,7 @@ new_inode:
 	if (whout) {
 		inode->i_mode = (inode->i_mode & ~S_IFMT) | S_IFCHR;
 		inode->u.i_rdev = EROFS_WHITEOUT_DEV;
+		d->type = EROFS_FT_CHRDEV;
 	} else {
 		inode->i_mode = st.st_mode;
 		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
-- 
2.19.1.6.gb485710b

