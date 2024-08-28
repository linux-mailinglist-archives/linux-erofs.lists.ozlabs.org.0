Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3109623FC
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 11:52:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv08N1B3nz2yfl
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 19:52:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724838766;
	cv=none; b=V8qkatWEVLQGK0pbs88pNNUMyruV6ZCMj6tlhntEp6vyNVZIim25m6Y9ugWfgQ0bwIAnnNqqFLAn8SeWY7F+8mhUPqxM0Hq1C7j/0eNJLwnDjL1zUaKN2jBT6OCvhxcSnGb6FNZIjowW0je9h4fiBG5hiD+UUxfHr4V1vO7SQ40GJTkAg4pzrQBjlLfcKk9fgnRpSaFb9lVWctLXHJOdxYPuAF07DyN4Cai9mqHMSE4ubwIvkVRK9m5uYJDIzxZQQe2LLdZjn8CED2b/L+vZIAId1BdbewMUH93/Yi6DPQxAYojl3ezTdHgGDP93xaQsUSZzZTC7vgikY0lggfJWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724838766; c=relaxed/relaxed;
	bh=Wiybu7Typ2/zR0lNiQSCRktnMCk0oKr/bTEJatprEbA=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=DTnu5UA+TADFD03VBGlIvoIBkDt1byFLFgNFJbvC/ORiV1VI05LjCWjUHV7iXdcAeTKNjU+3y8hjUIJ6mQHvo5yg6BLfcM+mHrabc6iq2ZosvJ1Iz3VYZHRNesoBt1jRB2I8V2ckNLZlSFf/k30y0asxpQt1RkrNT9x3i8TFOPPfjMTg1+tcoLvJx1OCQYmSUUDJcmlPglpTn/hRefBlpA6HYJaIn5GICUv10Jsa/q/UC5AFW1hmTrdbC0AcmFGR7uHYokoAvexrwHrFtRHHoRzG8sUqxI1NujCKSlNRQG/Hn2E5l+dYPgudQK+0jZk2dMpnfRKX6CIdzwrf+2Ribw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gHmeVfzL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gHmeVfzL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv08D6L1wz2xfb
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 19:52:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724838758; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Wiybu7Typ2/zR0lNiQSCRktnMCk0oKr/bTEJatprEbA=;
	b=gHmeVfzLLY+Nw2Ypn8zo/PF2xNEtaPTnjNzZUFyQ6FA6dFdXzuN0VoW+SpD8lpHSVYT5DetEJf9vvhRXz8CrFvGMTxTGSHkPWimgPwfalBrABE6VhYHk8FeEXpD6xmpaTU9a0Mmdpx/zqOm4hZn1pYAJP5RPgA4S+VyTLoPwiTA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDpX0E3_1724838752)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 17:52:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up erofs_register_sysfs()
Date: Wed, 28 Aug 2024 17:52:32 +0800
Message-ID: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 684b290abc77 ("erofs: add support for
FS_IOC_GETFSSYSFSPATH"), `sb->s_sysfs_name` is now valid.

Just use it to get rid of duplicated logic.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c |  2 +-
 fs/erofs/sysfs.c | 30 ++++++------------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 95b4faa0b245..5760b45252cc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -649,7 +649,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
-	erofs_set_sysfs_name(sb);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
@@ -687,6 +686,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
 		return err;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..63cffd0fd261 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -205,34 +205,16 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	char *name;
-	char *str = NULL;
 	int err;
 
-	if (erofs_is_fscache_mode(sb)) {
-		if (sbi->domain_id) {
-			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->domain_id,
-					sbi->fsid);
-			if (!str)
-				return -ENOMEM;
-			name = str;
-		} else {
-			name = sbi->fsid;
-		}
-	} else {
-		name = sb->s_id;
-	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
-	kfree(str);
-	if (err)
-		goto put_sb_kobj;
-	return 0;
-
-put_sb_kobj:
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
+				   sb->s_sysfs_name);
+	if (err) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 	return err;
 }
 
-- 
2.43.5

