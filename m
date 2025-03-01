Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE21A4AC66
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0Q25jRz3ccV
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840625;
	cv=none; b=g5VEXvdRE3KBF6G4dpKH6eGXDHGVpzedaAxn0HDP0mJiBQGDDLjPHqG0woTi5ZE+2mgITSTXvR48S9BTZ/je43LIEAKwvfgVsBZxSHXk0VgdzvK6OJqau2xCRVIYRhq9xbadYP7LOd/VVlqZT4xhY7jo+X+niNNX2jMWrg5udYhV3n/SGisMeaDHZgyOTjnpMue3NuMjhEbExXVDXrm5WNa2umYgBHmIuK7+T3dV30L18kK5OhTQrChNOCsndzbmTLVb15A8ySKzbf5kTlGaUBzri2I6Da9SDPULhBHNGR60ZGrBJIKmcitEUnIFlcz3Y2Ay/u7Y/cnZIkGu/vCq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840625; c=relaxed/relaxed;
	bh=6USqGVcPTi586mkMaCckvU+yah8nBs9aiwe4n8Cy5OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnjHiaS4/vIDwr6gCP/+kjV/tPo/k5LdWivTpTEyMPZjSOLFEl5yOt+Z5Nix0qe3G+1b+g2JTt/jiRVdB9zgO0uE+EvK0RlRC/DdSgoXdegj/SQujr/n/nChyTbxAdg51wVD3H4DuixG/BIkzOdhCqGozrCHD5Kb5omA9MCoz0mUdrBMYFPyj1U3ssxtMx2UM3tJxmRVoyKB/PYB+PZuT3d/EbjlngyhzAyGIyWr4cXIsanLtycwgPWBY1G6p2hxAfp6vMzZ9rjG96Nq+Z7MYRYnoj7ooTOd1BUzOIFZge9ZOsjjKtog2U5b4GxG/JnBcpPQQtrNxdlAw5T7RGFF7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ke4fZbPz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ke4fZbPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0F14tJz2xBb
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6USqGVcPTi586mkMaCckvU+yah8nBs9aiwe4n8Cy5OI=;
	b=Ke4fZbPzE5selIlKd7PrZaBev1MRBTs1UwwYd4PZP1LJGnOFe3OLXKs1ru7RNjptHgKm6LIWF6nCoecyLT4Qd1AqygdGc0954YzLINgS4dcwejP9xUMiz0lvY+cm33dLClqobWiFBrRQWe9TAcVZeRI/adGsENZvDW0oXwMUdbM=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSgWQj_1740840614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:15 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 3/7] erofs: support domain-specific page cache share
Date: Sat,  1 Mar 2025 22:49:40 +0800
Message-ID: <20250301145002.2420830-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6af02cc8b8c6..ceab0c29b061 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -489,6 +489,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -558,16 +560,16 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !sbi->ishare_key)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
 		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
-	else if (erofs_is_fileio_mode(sbi))
+	else if (!sb->s_bdi || !sb->s_bdi->dev)
+		super_set_sysfs_name_id(sb);
+	else
 		super_set_sysfs_name_generic(sb, "%s",
 					     bdi_dev_name(sb->s_bdi));
-	else
-		super_set_sysfs_name_id(sb);
 }
 
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -965,6 +967,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
-- 
2.43.5

