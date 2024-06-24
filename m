Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9F914305
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 08:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719211984;
	bh=8Nb75vHFgKpC+zWlhq3PV82ykPYQt9OtwrmrV+N9Bcc=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=kjJ4sqmauVcrxwpatSCIfhthlheAVq8ty821vp7bYg+ZoAuvtLTpXJvHDRkUFUvJ9
	 zJSbdAVPmrR27QZze/RdWLtaxdLI3tSx9xXn/4nJ/XiVwQZfl3aHsNhd5CPyXaPwTL
	 xUi1JGHpwArJKa+Eg0WkKTW0lZqiqthv4IFwLmO0UDH/KlGytfAGLTbtZdGmCmIJmL
	 NLJodF0vsygwyzVmJvohDhJ0pSbECM9D+hY8xDUzO0Hukhjru8oVLgb5z3eSoOxV7V
	 URaNnRKI7jqxaXbcs0DWAochylDRwJgcr8JsAtdqBsUHTZVgjXe+mkxkIigpVb6/Rp
	 mjKG76Aa8fo7w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W6zDw0k1Pz3cSq
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 16:53:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=huangxiaojia2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W6zDr637Zz30VX
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 16:53:00 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W6ykx4xhBz1SDXd;
	Mon, 24 Jun 2024 14:30:33 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id E8590140156;
	Mon, 24 Jun 2024 14:34:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 14:34:54 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <yuehaibing@huawei.com>
Subject: [PATCH -next] erofs: add support for FS_IOC_GETFSSYSFSPATH
Date: Mon, 24 Jun 2024 14:38:01 +0800
Message-ID: <20240624063801.2476116-1-huangxiaojia2@huawei.com>
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
FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outpt.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
 fs/erofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1b91d9513013..19dfc1bd3666 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -643,6 +643,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
+	super_set_sysfs_name_bdev(sb);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
-- 
2.34.1

