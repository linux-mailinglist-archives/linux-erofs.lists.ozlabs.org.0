Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4E44A506
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 03:55:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpCK10Tn0z2yHX
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 13:55:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636426533;
	bh=w8fjnS7GeKd5M4/cKlKazIrkCip+UiwPOP3sDvx67pg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=TWdqvHrCIEu500Jbl6xlDbuWXXFGbGfulwzCyfoDaLW7R429Rg5/g3zlqgvVW8bnR
	 8Utx5seKjmEHBpVbMOKZqoXxjrQ3aro2qMh7Z/kxUn22IZhSWDZ2rxHbRJzKwR/V2L
	 SzXESdGPh2XTz8oBYngK1BXNk2glbnyNDD38JlBy8LEri38qNLoxUhOipB1deq/LM0
	 F8/W3ZLASJIcbTLkvh2YFyVu3ab6fDu61j9AsOtffLzM/H+Ot+OB5PBkp/5gqfZxmI
	 4xDdVYpLTpvYe6YSLd2icMlPyjS9HFWLvi3ufKpCiR1oUDclEa9Fd7/ms6AmhOuTik
	 e3LAEG0bbUJfw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.41;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=e6eh0lOZ; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320041.outbound.protection.outlook.com [40.107.132.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpCJr4KHKz2xXW
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 13:55:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmLdjA5aN1UgGfv/yULWytpmM0vSD13tYyTPz5+HoItv0XWxDjhbc2/umMKDHxhDJAhrAoBFoo4nMY7jzX2Xs9atmBkfAVfyfWdWD3fseUwQmtqi66OWbGKpSAHERBF3ri06zuWjHmwYxVvUfHkft4Fs0XQwA8kNyM5aRT5rmf/lwrY16XiL3UPutAGftOHjUctlqP11+ZxjMAqZG+A0mon1oyaRCqopS4usQQUKI+CnVJCjV4VdtG0gccIHvwt3cvhC2Wvcyg+47IFGLasZJi/OfsKiUxWvgMJPwBJukEfaHylcEJHyp1DsqO6SppNpjopZYkMgtLBagUpYSI7nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8fjnS7GeKd5M4/cKlKazIrkCip+UiwPOP3sDvx67pg=;
 b=lBodlDvfvKe2lsUu8lziIEa4cQ1vEzRJ8ioiU7buOKAr9yvYdCgihqJsynmasDW3OcxJvbkLzAYr/0ZCyx9kZ3i9UDBbsRDy+m3QxVqrsJZAFURSaVj5PmK0TqpA12yUlgLhwWTd9f6zjKN8E9XsjCoBRN4gr62Xsz1q3OtGvEc4bioNqtxfIlD2iAlnkL7vwp6Wo95BSRSdLG7eV9SIegkPrW2CWomKAe2EuAEieICiyxVMpbsfyb3EcRSfVOd2HjGhT13UtvXt6L0DGknKO31Jt4CeRtA7Oz57VrMuw+m5xiM1brBRGLjKJjiD9aBLKNiTnyE8dCd2X+jRwcf1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2699.apcprd02.prod.outlook.com (2603:1096:4:58::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Tue, 9 Nov 2021 02:55:02 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 02:55:01 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: add sysfs interface
Date: Tue,  9 Nov 2021 10:54:44 +0800
Message-Id: <20211109025445.12427-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 02:55:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 220689a9-ca64-470b-c610-08d9a32c52bc
X-MS-TrafficTypeDiagnostic: SG2PR02MB2699:
X-Microsoft-Antispam-PRVS: <SG2PR02MB2699DC99BED4DC0CD4C4ABF4C3929@SG2PR02MB2699.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:197;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrOGhYp9GhxADeNoYqmM0BEX+UUzizD1uKW8SCi6RGwYydaIlpX6cFm3KWct44rjZ/B5NTbufvEXhbCKyTjw+7LlRQtNBkVS3bPBW4zHEJgJ2P/lZPK7BhYSpMtjPeIWxUki1ong8Nx336Oj2Uk82DVRCLJlSMaXi2yTJUosStBw6S4Yq5pB4sE+MQvNmyD5JmzUEDTFj6uDTJqg/pI3YhVjLaHLQUBPuM4WSA8hZH7atSjAZALSqz9T196zxIXWb4yRr4crhxYxdYdxiyjJYd4zTyyKwAADDjPZ6TTeF/cxGoRu+cbh6gkFMzfCmU5UI2CZooHu4JIksPGHMd5XuDHIoIe0m3m3Ups4MNpPC6iWbsQZlY3aRTD16dIvZp6WNSQKNfa0mnafaouJR8eWdrrYhOdP7QMEqcT2386W3l49q1zDnb9EG8rCUeatpzJBYofYQyW3SalYZY8dHikjJCZvvI2EK1NjqoOj1/4WPFr0oDaZ3EnAa/M+Kc8UwlOj1ZxzmhUB1+JaXC5zGtsbslaYw+cFm19Yek1U1GuiK+Ax8vOIIZQtxyLzSRq8qhIKFAoz3bnFXH8M0uq1IqQhw8DV408eo/wgp5L+B0rdNrc2hUAvxjqRJDtJwsJczLMhFGTa5s4vUxKmCj90+kL09px1EcBVWpye6qUlUg7io4KOCB2sMUod/tgJswiiWR3Y+gfE/+5s2RsNxfxaw78L1E31GKur+aoqRMbT/RJF9+2dwXMyeNrTKh8eeKiPwTc4WDQPFWSVwrHhPOEOa/pLYLTeA4QYDHqa6xQKtsQ+a/OYB+pgFEWQivTjK3IhyjLcip+qQGiq4a70UI5zP6oqmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(36756003)(6916009)(52116002)(66556008)(38350700002)(6506007)(6486002)(316002)(83380400001)(6512007)(4326008)(2906002)(86362001)(26005)(186003)(2616005)(1076003)(966005)(8936002)(5660300002)(956004)(66476007)(6666004)(66946007)(8676002)(11606007)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkiBLcCKPXO+jy0D7tkpsYAbvSxAJ2n52Zdp0GET7XZkwB+huLDPIAT+GzeK?=
 =?us-ascii?Q?GVgZkcuOMjapo29PeS5qqOSBac5/J1ufvG4aq2vfwmf/LuKp/uKxjzCQ/weS?=
 =?us-ascii?Q?s4wsLqoyiHAJsKMQIDSDpDv+GfcRtN3whst4iq0gK4Tyrlc6ylcE+kcx7P2M?=
 =?us-ascii?Q?i4J9mIY76YQT+BkKjAC725zMkaP7+M0IRtSjpSzvZ0QSoY2k+cwXhE8vowSl?=
 =?us-ascii?Q?iqMOiJye1PbYykW74YsANgTVbkOYtDSjWZ4zDPbN9xpodBILZvJ2F7S0x12F?=
 =?us-ascii?Q?OCiHd3Og7uM9NUiN4kwc1e86/waT7tjGvm/LeOCW6nLZWpqJVPA/JkohuA8F?=
 =?us-ascii?Q?AcKL+fx5npMj10XECYZ/dPCv6ekHiXRf/Mc6DIPjXAJfLIQkbVrcFJrk4MEI?=
 =?us-ascii?Q?m50ZOz2NN5kDa/hWaSzu09EVRDowzmNSLLUQmFPZleUYR0B6Kbt76Uw4L5VW?=
 =?us-ascii?Q?ffZISbPoK/QpffTu62CVzIzKHPQv/jaEtuX9f4uoesW8g7oYbm/1fzsT1ewP?=
 =?us-ascii?Q?x9EHwVv99t0fErsaKCxSJM6MuCRuKYinmD1f8FbG3GQ54K1Vl8y+OproIz24?=
 =?us-ascii?Q?eJtqTryf7Z+NpquzZIkghEOdjykdjsKvKMRV6FuaJWos/w9pCD7Ue2Qz66H4?=
 =?us-ascii?Q?XSQWF7fpogcPx+dxQn7hPLF3NOVtVfNa+wQB3ewnENmVUeLXu4O3BsW6zekT?=
 =?us-ascii?Q?jI5vx2u30mOXERHu4dHC/nCTHt9kJVubkcz9C9xy4sOcy0nOUTT/k6Ve+3rj?=
 =?us-ascii?Q?5QWnoKSRmyA/b3zSHckU0qLTy60Sr2LsZiujF0i5qn2seL8jr1U38TH5j6jc?=
 =?us-ascii?Q?NvodLWd+BdGRpOb0pvXVlTGKOceSlwiLw2TmC15wlU6WMOJw+6ajxcoKDaHu?=
 =?us-ascii?Q?uU9O5W8PwyHpy/NQ3W0FPJiQbyy+oqD8KVWpG4MAauYr4W5h1tnXfiAzsnCy?=
 =?us-ascii?Q?OICVKi6gv7DMOYlvz5nJ3/gu7lDLFMS8537wJu/a6tsUZtHPtpthRFF9rIIU?=
 =?us-ascii?Q?7xwvqKitHB05j3rXuhkycrQKoGXkTTdQ6eUjpPIzdcPKZdgM6q2eOiJmQBI2?=
 =?us-ascii?Q?MdUhF2Z//XK+Tepy6rbq40YoiscDoo+W5miO3Ea7DSH0uCHMO/92i0e3B1/I?=
 =?us-ascii?Q?QG0ypDVW3GsWkqA818ZjTQw7iVE5Di4qmJ80daAC7FR7onJeyDjR84Lznd+R?=
 =?us-ascii?Q?WqINSsSaWDcjbYDmU6jP39zLQyVAsxXNEsxHz9D9br5/hG4nVze4nUP49D3M?=
 =?us-ascii?Q?Z6BCGQGgUgXjUOs6qNAGDJZVruMQqaicDNuacxDvMGHUr/f/ucg2xiEdjJbF?=
 =?us-ascii?Q?YhARmHBH8R/NkolJkNaal2VjmugssqE2Ch8uCddX3mP+4mymIrpOJ8W0jhlL?=
 =?us-ascii?Q?cPsrIxv2cg0Vt6dtW0m9vQdxIgGbJUDEvfFTo0eaJlizfrQ7yFDhRzQb4VQa?=
 =?us-ascii?Q?rZQZ6rjtgqzNjk5L2HEsPB+m2ddc2CmR26pvU6Fnkp+8NdWpZahn6HJbHVio?=
 =?us-ascii?Q?oeATxBK2k4mydtpkDuuTeLf+6NNZq89Y9g5wSfK/bry6E8zLuCdMVP0FitSE?=
 =?us-ascii?Q?Nny5DR+HJfA/nOxJD6GAp2IejyeQbysxGQQj3Y2p2rT57d3UD1akG+ZCXiaI?=
 =?us-ascii?Q?/AMsW+OVMJyCnvKpnV+HNmc=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220689a9-ca64-470b-c610-08d9a32c52bc
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 02:55:01.4935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuGCPTHXeqrxD4gyu1eAzNAx/dE0N7wLxG1tBjT5rkuhDSNY6xL3AURwRvq6Ns69wqQwF4nb4X9CCum0bWphiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2699
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add sysfs interface to configure erofs related parameters in the
future.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fs/erofs/Makefile   |   2 +-
 fs/erofs/internal.h |  10 ++
 fs/erofs/super.c    |  12 +++
 fs/erofs/sysfs.c    | 239 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/sysfs.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 756fe2d65272..8a3317e38e5a 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9..d0cd712dc222 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,10 @@ struct erofs_sb_info {
 	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
+
+	/* sysfs support */
+	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
+	struct completion s_kobj_unregister;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -498,6 +502,12 @@ int erofs_pcpubuf_growsize(unsigned int nrpages);
 void erofs_pcpubuf_init(void);
 void erofs_pcpubuf_exit(void);
 
+/* sysfs.c */
+int erofs_register_sysfs(struct super_block *sb);
+void erofs_unregister_sysfs(struct super_block *sb);
+int __init erofs_init_sysfs(void);
+void erofs_exit_sysfs(void);
+
 /* utils.c / zdata.c */
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
 static inline void erofs_pagepool_add(struct page **pagepool,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a969b1e0ee6..abc1da5d1719 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -695,6 +695,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_register_sysfs(sb);
+	if (err)
+		return err;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
 	return 0;
 }
@@ -808,6 +812,7 @@ static void erofs_put_super(struct super_block *sb)
 
 	DBG_BUGON(!sbi);
 
+	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
@@ -852,6 +857,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto zip_err;
 
+	err = erofs_init_sysfs();
+	if (err)
+		goto sysfs_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -859,6 +868,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_sysfs();
+sysfs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
 	z_erofs_lzma_exit();
@@ -877,6 +888,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_exit_sysfs();
 	z_erofs_exit_zip_subsystem();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
new file mode 100644
index 000000000000..c7685f1a8f34
--- /dev/null
+++ b/fs/erofs/sysfs.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ *             https://www.oppo.com/
+ */
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+
+#include "internal.h"
+
+enum {
+	attr_feature,
+	attr_pointer_ui,
+	attr_pointer_bool,
+};
+
+enum {
+	struct_erofs_sb_info,
+};
+
+struct erofs_attr {
+	struct attribute attr;
+	short attr_id;
+	int struct_type;
+	int offset;
+};
+
+#define EROFS_ATTR(_name, _mode, _id)					\
+static struct erofs_attr erofs_attr_##_name = {				\
+	.attr = {.name = __stringify(_name), .mode = _mode },		\
+	.attr_id = attr_##_id,						\
+}
+#define EROFS_ATTR_FUNC(_name, _mode)	EROFS_ATTR(_name, _mode, _name)
+#define EROFS_FEATURE_ATTR(_name)	EROFS_ATTR(_name, 0444, feature)
+
+#define EROFS_ATTR_OFFSET(_name, _mode, _id, _struct)	\
+static struct erofs_attr erofs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr_id = attr_##_id,					\
+	.struct_type = struct_##_struct,			\
+	.offset = offsetof(struct _struct, _name),\
+}
+
+#define EROFS_RW_ATTR(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
+
+#define EROFS_RO_ATTR(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0444, _id, _struct)
+
+#define EROFS_RW_ATTR_UI(_name, _struct)	\
+	EROFS_RW_ATTR(_name, pointer_ui, _struct)
+
+#define EROFS_RW_ATTR_BOOL(_name, _struct)	\
+	EROFS_RW_ATTR(_name, pointer_bool, _struct)
+
+#define ATTR_LIST(name) (&erofs_attr_##name.attr)
+
+static struct attribute *erofs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(erofs);
+
+/* Features this copy of erofs supports */
+EROFS_FEATURE_ATTR(lz4_0padding);
+EROFS_FEATURE_ATTR(compr_cfgs);
+EROFS_FEATURE_ATTR(big_pcluster);
+EROFS_FEATURE_ATTR(device_table);
+EROFS_FEATURE_ATTR(sb_chksum);
+
+static struct attribute *erofs_feat_attrs[] = {
+	ATTR_LIST(lz4_0padding),
+	ATTR_LIST(compr_cfgs),
+	ATTR_LIST(big_pcluster),
+	ATTR_LIST(device_table),
+	ATTR_LIST(sb_chksum),
+	NULL,
+};
+ATTRIBUTE_GROUPS(erofs_feat);
+
+static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
+					  int struct_type, int offset)
+{
+	if (struct_type == struct_erofs_sb_info)
+		return (unsigned char *)sbi + offset;
+	return NULL;
+}
+
+static ssize_t erofs_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						s_kobj);
+	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
+	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
+
+	switch (a->attr_id) {
+	case attr_feature:
+		return snprintf(buf, PAGE_SIZE, "supported\n");
+	case attr_pointer_ui:
+		if (!ptr)
+			return 0;
+		return snprintf(buf, PAGE_SIZE, "%u\n",
+				*((unsigned int *) ptr));
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		return snprintf(buf, PAGE_SIZE,
+				*((bool *) ptr) ? "true\n" : "false\n");
+	}
+
+	return 0;
+}
+
+static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
+						const char *buf, size_t len)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						s_kobj);
+	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
+	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
+	unsigned long t;
+	int ret;
+
+	switch (a->attr_id) {
+	case attr_pointer_ui:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		*((unsigned int *) ptr) = t;
+		return len;
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		*((bool *) ptr) = !!t;
+		return len;
+	}
+
+	return 0;
+}
+
+static void erofs_sb_release(struct kobject *kobj)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+								s_kobj);
+	complete(&sbi->s_kobj_unregister);
+}
+
+static const struct sysfs_ops erofs_attr_ops = {
+	.show	= erofs_attr_show,
+	.store	= erofs_attr_store,
+};
+
+static struct kobj_type erofs_sb_ktype = {
+	.default_groups = erofs_groups,
+	.sysfs_ops	= &erofs_attr_ops,
+	.release	= erofs_sb_release,
+};
+
+static struct kobj_type erofs_ktype = {
+	.sysfs_ops	= &erofs_attr_ops,
+};
+
+static struct kset erofs_root = {
+	.kobj	= {.ktype = &erofs_ktype},
+};
+
+static struct kobj_type erofs_feat_ktype = {
+	.default_groups = erofs_feat_groups,
+	.sysfs_ops	= &erofs_attr_ops,
+};
+
+static struct kobject erofs_feat = {
+	.kset	= &erofs_root,
+};
+
+int erofs_register_sysfs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	int err;
+
+	sbi->s_kobj.kset = &erofs_root;
+	init_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL,
+				"%s", sb->s_id);
+	if (err)
+		goto put_sb_kobj;
+
+	return 0;
+
+put_sb_kobj:
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+	return err;
+}
+
+void erofs_unregister_sysfs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+}
+
+int __init erofs_init_sysfs(void)
+{
+	int ret;
+
+	kobject_set_name(&erofs_root.kobj, "erofs");
+	erofs_root.kobj.parent = fs_kobj;
+	ret = kset_register(&erofs_root);
+	if (ret)
+		goto root_err;
+
+	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
+				   NULL, "features");
+	if (ret)
+		goto feat_err;
+
+	return ret;
+
+feat_err:
+	kobject_put(&erofs_feat);
+	kset_unregister(&erofs_root);
+root_err:
+	return ret;
+}
+
+void erofs_exit_sysfs(void)
+{
+	kobject_put(&erofs_feat);
+	kset_unregister(&erofs_root);
+}
+
-- 
2.25.1

