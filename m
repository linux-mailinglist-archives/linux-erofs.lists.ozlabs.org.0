Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7671787D
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 09:44:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWLqy6fm0z3f5S
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 17:44:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1685519054;
	bh=laRAS7Yd8xS86/C/v2ASExm3n4+Fn8Ns9nTvQFz50jA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MWQcw8xqNWr36he3oaeKQxTsQm1mCqv9YeCysiDcLKinEk+TZQIhfZieTxwvz2vBB
	 lEfo6nk8mYxppycFrzXna4wp5lFFs68kLYStLFIACuJjoR6Moq8CTS1mhxUogfcSjt
	 MNmK9sLQmDPZITYAgZSFOtja3uF2UH4arbM1cMqPZ2TWP7ebVK/YxM5025sQilaZxZ
	 1ue5H4s7Wqu91PKBBTRJuLLzxyQMzjZ55L1bqm0Mhr0AnYI4BhzQ4iN9+4wHNeFLSR
	 pxdG1Te+OIFQ8wsqR7PggbXMOvFs/SmcUSiHqggtHZEMMSnSMyPDRmy0mcU3UVGSHD
	 mUSA55fp6ubKA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
X-Greylist: delayed 1039 seconds by postgrey-1.36 at boromir; Wed, 31 May 2023 17:44:08 AEST
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWLqr1nx5z3bgn
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 17:44:06 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QWLCv6C99z9yJjj
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 15:16:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP1 (Coremail) with SMTP id 76C_BwDXPTGi9nZk5ngiCA--.15676S3;
	Wed, 31 May 2023 07:26:32 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fsck: fix outside destination directory exploit
Date: Wed, 31 May 2023 15:26:11 +0800
Message-Id: <20230531072612.2643983-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531072612.2643983-1-guoxuenan@huawei.com>
References: <20230531072612.2643983-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 76C_BwDXPTGi9nZk5ngiCA--.15676S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4DWw4rWw4fJFW3CFWktFb_yoW8Xw45pF
	s7GrnIk3yIyr1Ika1SyF1kZa43KFZ29ry7Gw4fJr18Xry5W3sFqryxCF1YvF4fCrn5GayY
	qF4avw1UCw1kX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij2
	8IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UW5lbUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com, yangchaoming666@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In some crafted erofs image, fsck.erofs may write outside
destination directory, which may be used to do some very
dangerous things.

This commit fix this exploit by checking all directory
entry names. Squashfs also met same situation [1], and
already fixed it here [2].

[1]: https://github.com/plougher/squashfs-tools/issues/72
[2]: https://github.com/plougher/squashfs-tools/commit/79b5a555058eef4e1e7ff220c344d39f8cd09646
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 lib/dir.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/dir.c b/lib/dir.c
index cb8c188..074e7c3 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -4,6 +4,24 @@
 #include "erofs/print.h"
 #include "erofs/dir.h"
 
+/*
+ * Check name for validity, name should not
+ *  - have a "/" anywhere in the name, or
+ *  - be shorter than the expected size
+ */
+static int erofs_check_name(const char *dname, int size)
+{
+	char *name = (char *)dname;
+
+	while (*name != '/' && *name != '\0' && (name - dname < size))
+		name++;
+	if (*name == '/')
+		return false;
+	if ((name - dname) != size)
+		return false;
+	return true;
+}
+
 static int traverse_dirents(struct erofs_dir_context *ctx,
 			    void *dentry_blk, unsigned int lblk,
 			    unsigned int next_nameoff, unsigned int maxsize,
@@ -101,6 +119,9 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 				}
 				break;
 			}
+		} else if (!erofs_check_name(de_name, de_namelen)) {
+			errmsg = "corrupted dirent with illegal characters";
+			goto out;
 		}
 		ret = ctx->cb(ctx);
 		if (ret) {
-- 
2.31.1

