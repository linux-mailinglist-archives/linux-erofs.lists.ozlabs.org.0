Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE2937FFA
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jul 2024 10:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721463522;
	bh=IeXZiN5vrC6OiXySHX0hbPO1SStBVnjIAAMPhr8iXDM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=DO0F2ZbwTRDoHdtf2PSwxFPqXpyr9t4K9qY+8+hEnxEaYIt5FtVpPkwXldvSPct4c
	 rKQzTCOul0JoNf3IMxIqO9Gu4AIit/53dfypzqg3JWER97Br6Op08YAuCX6pTwaRey
	 U3834h1uGjNA3f2j7EzdUjfrEXUxUfgLtSvyHHgM41OkY8YRQDnyYpULNqyCv7ZLwQ
	 sXBeTKl+qZv+JaJpcZw2MoBMHNfJcC1xNB5PInY6SO7CDfCxg79oDskDFKk3t8kB5K
	 DKzseRjQL/JZENP5b2VSxceHLnMtyJ5kOdMM97s3+bJHdxHXPcv42KgRc/7xSUE1Z0
	 BkPAwKmHZqatw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQzvk1ysFz3ccf
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jul 2024 18:18:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=huangxiaojia2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQzvd69vCz30fM
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jul 2024 18:18:34 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQzsS0m6VzdjVw;
	Sat, 20 Jul 2024 16:16:44 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id 4176214038F;
	Sat, 20 Jul 2024 16:18:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 20 Jul
 2024 16:18:29 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <yuehaibing@huawei.com>
Subject: [PATCH -next v3] erofs: add support for FS_IOC_GETFSSYSFSPATH
Date: Sat, 20 Jul 2024 16:23:35 +0800
Message-ID: <20240720082335.441563-1-huangxiaojia2@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500021.china.huawei.com (7.185.36.109)
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
From: Huang Xiaojia via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Xiaojia <huangxiaojia2@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

FS_IOC_GETFSSYSFSPATH ioctl exposes /sys/fs path of a given filesystem,
potentially standarizing sysfs reporting. This patch add support for
FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outputted for bdev
cases, "erofs/[domain_id,]<fs_id>" will be outputted for fscache cases.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
v3: fix commit message, overly long line and an else branch.
For bdev, it's tested as following:
mkfs.erofs test.img <SOURCES>
mount -t erofs test.img <mntdir>
ioctl_getfssysfspath <mntdir>
erofs/<dev> will be outputted.
For fscache, it's tested via  https://github.com/lostjeffle/demand-read-cachefilesd.git
./run.sh inputdir mntdir fscachedir
ioctl_getfssysfspath mntdir
erofs/[domain_id,]<fs_id> will be outputted
v2: handle non-bdev case. https://lore.kernel.org/all/20240716112939.2355999-1-huangxiaojia2@huawei.com/
v1: https://lore.kernel.org/all/20240624063801.2476116-1-huangxiaojia2@huawei.com/
---
 fs/erofs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1b91d9513013..d7900262aa75 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -576,6 +576,21 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
+static void erofs_set_sysfs_name(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (erofs_is_fscache_mode(sb)) {
+		if (sbi->domain_id)
+			super_set_sysfs_name_generic(sb, "%s,%s",sbi->domain_id,
+						     sbi->fsid);
+		else
+			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
+		return;
+	}
+	super_set_sysfs_name_id(sb);
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -643,6 +658,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
+	erofs_set_sysfs_name(sb);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
-- 
2.34.1

