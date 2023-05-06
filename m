Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB96F8E21
	for <lists+linux-erofs@lfdr.de>; Sat,  6 May 2023 04:51:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QCsWn173Vz3f5J
	for <lists+linux-erofs@lfdr.de>; Sat,  6 May 2023 12:51:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QCsWj49dNz2ym7
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 May 2023 12:51:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VhraFEG_1683341478;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VhraFEG_1683341478)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 10:51:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix `-Ededupe` crash without fragments enabled
Date: Sat,  6 May 2023 10:51:17 +0800
Message-Id: <20230506025117.99972-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise, an unexpected segfault will happen since
  EROFS_FEATURE_INCOMPAT_FRAGMENTS and
  EROFS_FEATURE_INCOMPAT_DEDUPE    share the same bit.

Fixes: 18fbf7d12e4f ("erofs-utils: build xattrs upon extra long name prefixes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 1 +
 mkfs/main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 5e9e413..9c87227 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -646,6 +646,7 @@ int erofs_xattr_write_name_prefixes(FILE *f)
 		if (fseek(f, offset, SEEK_SET))
 			return -errno;
 	}
+	cfg.c_fragments = true;
 	erofs_sb_set_fragments();
 	erofs_sb_set_xattr_prefixes();
 	return 0;
diff --git a/mkfs/main.c b/mkfs/main.c
index 467ea86..ddedfde 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -903,7 +903,7 @@ int main(int argc, char **argv)
 	}
 
 	packed_nid = 0;
-	if (erofs_sb_has_fragments()) {
+	if (cfg.c_fragments && erofs_sb_has_fragments()) {
 		erofs_update_progressinfo("Handling packed_file ...");
 		packed_inode = erofs_mkfs_build_packedfile();
 		if (IS_ERR(packed_inode)) {
-- 
2.24.4

