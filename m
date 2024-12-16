Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1119F30ED
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 13:53:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBfy204qJz304x
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 23:53:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734353607;
	cv=none; b=ICgvMrqeNoLQuokk8qeNzxiEIh2BQ8sVUdctEUtGeZINHkTlNqBQfL2kQOZ+Ap+D0srhZskfVJz8rKMy0ZiRAJBHv0Av4zuHWU6/heSU2y56L7MwL/RRwp0KHv4UY6DG8fDgC/7zRuBL7MCzlq+gh86UBMnO56DBlZ5oMq5rf2FdGJHgW0xOBzoDXCGEZsH18edVWPdibF0KFzyfR5L1aBhTnRe+xS3NEPYnXdPVITLRBrGFGqf0bhme4lOOfhg0e37kidbtBQ5o8l+wEcXMYT0y4R3pqFdY2azHRQTbaEFXhKPP/S6aiK3nmuGFxCZayo6Lqx74ryQHhKq6RXpsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734353607; c=relaxed/relaxed;
	bh=igS+vMvKO7ShxBR7rp8ORXO+whr6YQCKn1xoR3jaKug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ob9aoJDRI7B5d0JbEsm1Ji1qJQqzDGltIzxCsnvAm7Qzi2soJ3ygWbT7NDvg2XutEWHFhRcgZU9FCoFpCj8s8bl8Uww0uwh5UH9+d4q1RGgzDhOrdkuU9eV6pAyrpESCjXzb5VyCqxDF82KbTjvv4MzdVLDoiGXQcu7LsFkPZMRXRRfQEF8G9j8OcJWchHC60kavj/154U/h5dY9YA4U88U4SubrmDeIJJdlvcM2z8knh+Bleg+ci+cnWYH8HY9ADQ3k0yydJ/kTNZ0pMQFDhQ1H2x5BfA47AsgxYkYioo2FPOGCVwnE2dv9kWKHB+/7WOe+YNYF7CEMqp4FFJSykA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vT2OitTD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vT2OitTD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBfxx6Q3Zz2yys
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 23:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353598; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=igS+vMvKO7ShxBR7rp8ORXO+whr6YQCKn1xoR3jaKug=;
	b=vT2OitTDEUV3Hq0lirZbWg4so7nuZCfJMDX32v6nVDLFathXnMYSJsWBqdbc1rCYICgQop6Ta9gps0Pa7xXdHCYFpmerncInJ8y79zQlLnBHhrzha8BtvDjC0pGG+sSKcDLT+r24tPLgkqX8OjLFsaaXigCgGt/pRFQWmqIOcdw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksKQ_1734353592 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/4] erofs: add erofs_sb_free() helper
Date: Mon, 16 Dec 2024 20:53:07 +0800
Message-ID: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Unify the common parts of erofs_fc_free() and erofs_kill_sb() as
erofs_sb_free().

Thus, fput() in erofs_fc_get_tree() is no longer needed, too.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c235a8e4315e..de8e3ecc6381 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -703,16 +703,19 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			GET_TREE_BDEV_QUIET_LOOKUP : 0);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
+		struct file *file;
+
 		if (!fc->source)
 			return invalf(fc, "No source specified");
-		sbi->fdev = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
-		if (IS_ERR(sbi->fdev))
-			return PTR_ERR(sbi->fdev);
+
+		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+		sbi->fdev = file;
 
 		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
 		    sbi->fdev->f_mapping->a_ops->read_folio)
 			return get_tree_nodev(fc, erofs_fc_fill_super);
-		fput(sbi->fdev);
 	}
 #endif
 	return ret;
@@ -763,19 +766,24 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 	kfree(devs);
 }
 
-static void erofs_fc_free(struct fs_context *fc)
+static void erofs_sb_free(struct erofs_sb_info *sbi)
 {
-	struct erofs_sb_info *sbi = fc->s_fs_info;
-
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
+	if (sbi->fdev)
+		fput(sbi->fdev);
 	kfree(sbi);
 }
 
+static void erofs_fc_free(struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi) /* free here if an error occurs before transferring to sb */
+		erofs_sb_free(sbi);
+}
+
 static const struct fs_context_operations erofs_context_ops = {
 	.parse_param	= erofs_fc_parse_param,
 	.get_tree       = erofs_fc_get_tree,
@@ -813,15 +821,9 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-
-	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-	kfree(sbi->fsid);
-	kfree(sbi->domain_id);
-	if (sbi->fdev)
-		fput(sbi->fdev);
-	kfree(sbi);
+	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
 }
 
-- 
2.43.5

