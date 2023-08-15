Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105577CAB9
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 11:49:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ61V6fbYz3cQd
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 19:49:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ61M3bz5z3bc0
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 19:49:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VprTEA4_1692092959;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VprTEA4_1692092959)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:49:21 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs: remove redundant erofs_fs_type declaration in super.c
Date: Tue, 15 Aug 2023 17:48:49 +0800
Message-Id: <20230815094849.53249-3-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230815094849.53249-1-mengferry@linux.alibaba.com>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As erofs_fs_type has been declared in internal.h, there is no use to
declare repeatedly in super.c.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 82f41d09f8d8..78a94955dd61 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -19,7 +19,6 @@
 #include <trace/events/erofs.h>
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
-struct file_system_type erofs_fs_type;
 
 void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 {
-- 
2.19.1.6.gb485710b

