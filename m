Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B794A371
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 10:54:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mzs4h+sX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wf3rm2HwZz3cyg
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 18:54:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mzs4h+sX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wf3rg3vsYz3cND
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2024 18:54:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723020859; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iJU5PhZYjvTVAJzQnowo7haScUZ76jY8x/YcZfXpvvU=;
	b=mzs4h+sXr+fdoGTn5GptKKAn1/ijHHvI96pPlMmH36qdmSrhqpQLB+7jugfAaRYJoHeLffNWCSDk8zc6pWDAvAwQ6OxAxLLrXY60f6cV4LfedxR9imTMHf+6D6nvX40SAJEzyNkwctt5hDd0JkVrnLJeMa96XD06FaGxx1y/L5E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCIHvdq_1723020854;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCIHvdq_1723020854)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 16:54:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: enable multi-threaded support for `-Eall-fragments`
Date: Wed,  7 Aug 2024 16:54:13 +0800
Message-ID: <20240807085413.717066-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since `-Eall-fragments` packs the whole data into the special inode,
it's possible to use the multi-threaded compression for this.

Some users may be interested in `-Eall-fragments` for extreme
compression anyway.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index cea96f4..8655e78 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1763,7 +1763,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
-	if (cfg.c_mt_workers > 1 && (cfg.c_dedupe || cfg.c_fragments)) {
+	if (cfg.c_mt_workers >= 1 && (cfg.c_dedupe ||
+				      (cfg.c_fragments && !cfg.c_all_fragments))) {
 		if (cfg.c_dedupe)
 			erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		if (cfg.c_fragments)
@@ -1771,7 +1772,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		cfg.c_mt_workers = 0;
 	}
 
-	if (cfg.c_mt_workers > 1) {
+	if (cfg.c_mt_workers >= 1) {
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
 					    cfg.c_mt_workers,
 					    cfg.c_mt_workers << 2,
-- 
2.43.5

