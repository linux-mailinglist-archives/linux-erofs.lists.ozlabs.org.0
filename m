Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7492CD15
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 10:35:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cQbg59FT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJrll4H8hz3cY1
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 18:35:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cQbg59FT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJrlb6XzPz3c3H
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 18:35:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720600519; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k7jYTwlNcnly6TKJbGHDE72bqvysWO2rZe0L8M+H4K8=;
	b=cQbg59FT0FMWEuqQW0Ht8xd0SDj4F7+dte2/cetUA+3BvyfH4K8hP7Rb6N4LkZwE2x1Um/cUKRZ7JviG5YIdxkdDIeBtvUJ8iL7vkaxoonMhqrhWV2ffwCl9Ec5EXJGsK+tydlLLYWs7wMbBby+WWWGAKRAfG4QTz4A8MramVWM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAEb4aJ_1720600516;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAEb4aJ_1720600516)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 16:35:16 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: get rid of z_erofs_map_blocks_iter_* tracepoints
Date: Wed, 10 Jul 2024 16:34:59 +0800
Message-ID: <20240710083459.208362-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Consolidate them under erofs_map_blocks_* for simplicity since we
have many other ways to know if a given inode is compressed or not.


Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/zmap.c              |  4 ++--
 include/trace/events/erofs.h | 32 +++-----------------------------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 74d3d7bffcf3..403af6e31d5b 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -686,7 +686,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	struct erofs_inode *const vi = EROFS_I(inode);
 	int err = 0;
 
-	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+	trace_erofs_map_blocks_enter(inode, map, flags);
 
 	/* when trying to read beyond EOF, leave it unmapped */
 	if (map->m_la >= inode->i_size) {
@@ -713,7 +713,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 out:
 	if (err)
 		map->m_llen = 0;
-	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
+	trace_erofs_map_blocks_exit(inode, map, flags, err);
 	return err;
 }
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index b9bbfd855f2a..57df3843e650 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -143,7 +143,8 @@ TRACE_EVENT(erofs_readpages,
 		__entry->raw)
 );
 
-DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
+TRACE_EVENT(erofs_map_blocks_enter,
+
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned int flags),
 
@@ -171,21 +172,8 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
 		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
 );
 
-DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
-	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
-		 unsigned flags),
-
-	TP_ARGS(inode, map, flags)
-);
-
-DEFINE_EVENT(erofs__map_blocks_enter, z_erofs_map_blocks_iter_enter,
-	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
-		 unsigned int flags),
-
-	TP_ARGS(inode, map, flags)
-);
+TRACE_EVENT(erofs_map_blocks_exit,
 
-DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned int flags, int ret),
 
@@ -223,20 +211,6 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
-	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
-		 unsigned flags, int ret),
-
-	TP_ARGS(inode, map, flags, ret)
-);
-
-DEFINE_EVENT(erofs__map_blocks_exit, z_erofs_map_blocks_iter_exit,
-	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
-		 unsigned int flags, int ret),
-
-	TP_ARGS(inode, map, flags, ret)
-);
-
 TRACE_EVENT(erofs_destroy_inode,
 	TP_PROTO(struct inode *inode),
 
-- 
2.43.5
