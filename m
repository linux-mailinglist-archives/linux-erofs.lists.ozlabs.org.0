Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB5932590
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 13:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721129213;
	bh=YnPHcTqXqwT1025fNiBx/OxmlJST3Jab8WaXuDNl3Z8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=AtnY5WuPLm2M0OEK2P9Tp9wdftblimoj0TEiFt8TT/xSG+0BTzSeKUTlvIWZ7V5Zy
	 NJF6hXhkBnrSbJ+ymUH0jMnEmydzdWUboIYiP4m4QzUDT6S1Jo4/uXvT393wfJ/VxG
	 ZuqQnaYVqpJwDuZPd4iKcl6+r3PZeKFYv68S/kMmSBldQnVXhJaZ0MImHVYSwAzfoR
	 sv38XLMlOsoGy+kIJSdON3hYjuC8Ub38StI5zR9mv3neRdP39uRXUgteCJPeGk8fTy
	 S1rmsyh2SDv58MrMGHmsD6WHkfiA3VQEnGScimaNA+UliGqcbM4Qwfw7CPJVaAoWb2
	 LNPsmChVSpCbg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNcGj1Phzz3dKX
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 21:26:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=huangxiaojia2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNcDZ18yvz3dJs
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 21:24:58 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WNc9R19X6z1HFJv;
	Tue, 16 Jul 2024 19:22:19 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id 90A7E1A016C;
	Tue, 16 Jul 2024 19:24:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Jul
 2024 19:24:51 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <yuehaibing@huawei.com>
Subject: [PATCH-next v2] erofs: add support for FS_IOC_GETFSSYSFSPATH
Date: Tue, 16 Jul 2024 19:29:39 +0800
Message-ID: <20240716112939.2355999-1-huangxiaojia2@huawei.com>
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
FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outpt for bdev
case, and "erofs/[domain_id,]<fs_id>" will be output for non-bdev case.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
v2: handle non-bdev case.
v1: https://lore.kernel.org/all/20240624063801.2476116-1-huangxiaojia2@huawei.com/
---
 fs/erofs/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1b91d9513013..a24b6907363c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -576,6 +576,20 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
+static void erofs_set_sysfs_name(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (erofs_is_fscache_mode(sb)) {
+		if (sbi->domain_id)
+			super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id, sbi->fsid);
+		else
+			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
+	} else {
+		super_set_sysfs_name_id(sb);
+	}
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -643,6 +657,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
+	erofs_set_sysfs_name(sb);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
-- 
2.34.1

