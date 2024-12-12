Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 483629EE7C0
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 14:35:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D4F5N7Kz3c5t
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 00:35:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010521;
	cv=none; b=kdPoL4rcGO7/9CywVm7jHzUcm0W7YydXpOsj7/fQqGiH2+MuTD9MF6JlMIKpyZWbeCSfZxwC4Zn6rF/ZCRtx8w6GzQAqBgHeUepMXnR/xSioK9OK8WxWhUGguFKMoO/i4s5Fw+eo38z1XCtek3Pk9fi5cvh+b52ikZ3W3AdHZHmmj1+5h/7RxkeX5l/w89Fwp64FupQfWSeD9hiOCNDmLBkvzewhtklI3a9OoF2JairVBXieXazqIw6KBX2kPA17Tca9/bs+WO9m3LiHYwUryPm/V9RULJd/zBpJmv5p2D8WD0dXyNw+MNwY7y325YuqFtjPkgaSRM+/BTwFlVE3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010521; c=relaxed/relaxed;
	bh=Bep53u066GuA/RqqrsrzhZPJEa3VMPrE3kZ/DxaEDko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAIG6ptFDSlSFcHmZfX83hicngckXgwI9McYWTOpHd/9FKC3BpW/NmIZ7cQxZKpxdZxKccM5CD8sw6CpONZIgvGBhzHt71hXuQQOi9PdYvcFjKtEVVlYjHq3jpzXI2SDyORKkOAbAjkc34PPLntjCXZaVOIovEJ2drT/Xa//vmEuJHpmBL/dmABgoDyvaDH5z2znZRZ1ba1dx3X3g3/s7CHEO/8LoFp5LeokJPlyJkZYAeV+BIEFyWTG9HDVyvgPI2Qn0f20ns953gcWlIMaGC1ab8+4s+wJIGSSfBBOmIxXeQBnCG9apAA6GpAZNe8wBAuw9Xj97XzrDFOUNtx+hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ro4D/85n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ro4D/85n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D4703MXz30WD
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 00:35:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734010513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bep53u066GuA/RqqrsrzhZPJEa3VMPrE3kZ/DxaEDko=;
	b=ro4D/85npPupCh4ig7cKRCaBahSSgEeMnCL+hmj9u+Aaq0pY4yuQC2DQ8gkY04flNlJiYvEG7w9uxse3MMJT4yHSiN93IyukND8rtXB7I7LUtkh+9ZyDDO2IKpWB7cF7qcJzzzjlKtqjxOg4JL7+Ix4lIjhYt90BenGThoi9iB0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvJn5_1734010505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:35:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs: add erofs_sb_free() helper
Date: Thu, 12 Dec 2024 21:35:01 +0800
Message-ID: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c235a8e4315e..1ce5ca11d32b 100644
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

