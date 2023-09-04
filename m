Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2C791502
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Sep 2023 11:51:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RfP6r4zxrz30hn
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Sep 2023 19:51:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RfP6j3Slfz2xpd
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Sep 2023 19:51:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrJ6MXZ_1693821088;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrJ6MXZ_1693821088)
          by smtp.aliyun-inc.com;
          Mon, 04 Sep 2023 17:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: refuse illegel filename
Date: Mon,  4 Sep 2023 17:51:27 +0800
Message-Id: <20230904095127.61351-1-hsiangkao@linux.alibaba.com>
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

From: Guo Xuenan <guoxuenan@huawei.com>

In some crafted erofs images, fsck.erofs may write outside the
destination directory, which may be used to do some dangerous things.

This commit fixes by checking all directory entry names with a '/'
character when fscking.  Squashfs also met the same situation [1],
and have already fixed it here [2].

[1] https://github.com/plougher/squashfs-tools/issues/72
[2] https://github.com/plougher/squashfs-tools/commit/79b5a555058eef4e1e7ff220c344d39f8cd09646
Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20230531072612.2643983-2-guoxuenan@huawei.com

changes since v1:
 - check this only if fsck is enabled (extraction and fsck is impacted);

 - don't treat the middle '\0' as an illegel name since such cases are
   actually reserved and can be handled properly.

 lib/dir.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/dir.c b/lib/dir.c
index fff0bc0..3731f0c 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -4,6 +4,19 @@
 #include "erofs/print.h"
 #include "erofs/dir.h"
 
+/* filename should not have a '/' in the name string */
+static bool erofs_validate_filename(const char *dname, int size)
+{
+	char *name = (char *)dname;
+
+	while (name - dname < size) {
+		if (*name == '/')
+			return false;
+		++name;
+	}
+	return true;
+}
+
 static int traverse_dirents(struct erofs_dir_context *ctx,
 			    void *dentry_blk, unsigned int lblk,
 			    unsigned int next_nameoff, unsigned int maxsize,
@@ -102,6 +115,10 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 				}
 				break;
 			}
+		} else if (fsck &&
+			   erofs_validate_filename(de_name, de_namelen)) {
+			errmsg = "corrupted dirent with illegal filename";
+			goto out;
 		}
 		ret = ctx->cb(ctx);
 		if (ret) {
-- 
2.24.4

