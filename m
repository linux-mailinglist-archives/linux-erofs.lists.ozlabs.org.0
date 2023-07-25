Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54A7609EA
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 08:00:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R95wq0fGRz3c1g
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 16:00:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R95wh0MNlz3bT8
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 16:00:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoBevWh_1690264813;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoBevWh_1690264813)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 14:00:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: tests: pass mkfs options with MKFS_OPTIONS for erofs/015
Date: Tue, 25 Jul 2023 14:00:11 +0800
Message-Id: <20230725060012.123661-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230725060012.123661-1-jefflexu@linux.alibaba.com>
References: <20230725060012.123661-1-jefflexu@linux.alibaba.com>
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

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/erofs/015 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/erofs/015 b/tests/erofs/015
index e008e98..8e562f6 100755
--- a/tests/erofs/015
+++ b/tests/erofs/015
@@ -38,7 +38,8 @@ head -c 4032 /dev/urandom > $localdir/1
 head -c 4095 /dev/urandom > $localdir/2
 head -c 12345 /dev/urandom > $localdir/3  # arbitrary size
 
-_scratch_mkfs -Eforce-inode-compact --ignore-mtime $localdir >> $seqres.full 2>&1 \
+MKFS_OPTIONS="$MKFS_OPTIONS -Eforce-inode-compact --ignore-mtime"
+_scratch_mkfs $localdir >> $seqres.full 2>&1 \
 	|| _fail "failed to mkfs"
 _scratch_mount 2>>$seqres.full
 
-- 
2.19.1.6.gb485710b

