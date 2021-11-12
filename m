Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A010E44E04D
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 03:30:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hr2cx3HSYz2ywJ
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 13:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636684241;
	bh=Tqe0iQjPvUoySnWGEDA0cZNVD2zX0qO6RfF7suvtNk8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jqAYuDUPzbacrJj2+Km02ZWDFH+FU7kRkM/dHi+jkr9GFEUXp8BOxQqtwbykFke2h
	 qwPOpYB+RxGLxEJNyxv96OX2XhzS1rN3xtLmcYP3mRRhiWE9gV3pCdD59f/UlvwgxT
	 uI/3cm0q8j57tC54s2ZSfG6nCoQ69yorXlZMJrlENBNipxYMlNT2N4Z+6tpp9pJM4D
	 Um1x4HMt3N9p8/Cz8C0ziAK+NCKDg0/pdkaX/wvDDmpVSXmg4TM7sviSz/g5FS/bN9
	 UCiRbIeMbINioRQznMik4yJsLRATBBHYDDym4M1Jp5qKVbL0DNafvlifpNwuZ/RUhB
	 TTvkc8c7I8GuA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.71;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=NwB1NyO4; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310071.outbound.protection.outlook.com [40.107.131.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hr2cq2kTYz2y0G
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 13:30:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8+AfNVWH/S0Y46ou796q3qNZGf6h7HxBKTdyViPqbbBNZ8bkHOizSf4JWMwaj5myzr1GsBMZxTz4BFEzgeLleXq8id7F+ElWh0WlFvOGEvnEFzR7/HCWkWrz3NNcLng/+2sMJOrT7nTMiCVNLnbHIN7nNnsuKqru7AU6bQZ2p41pTThWFCZTXmpIhwLolZYOv0ADAO7yXK41rcfrGxSH4LwRncOEUDWGNI/CiFqE7ztP+cSQzQqZ66WBR+HTEZ8IjS5GvWMQaBHa5VRD+r4PGmaeQjozUnIJjPrtRbcMSOas850+B6JbWbgYNwu5lELHUdVzns13keKnrSnSykLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqe0iQjPvUoySnWGEDA0cZNVD2zX0qO6RfF7suvtNk8=;
 b=SenDaeGCfwEO5fFp4J3s8Z8zhZL0t3Y+dqnNGcfYCQ26R0hgqQHn9hWRNACaAS+NZvpCTmZxhJUk9AF+x/5qS/6OlcfSA5kcUG9eNAV3CwWS6hcxnZcaKNg/wqpd5taSdPJgy6Y6qee7OuIRwCi2od+6aYz6xVqNdfsKb8p4mFP65pmgGy6lpyaXPqTdOoVixYUSH1JphOFdWZajkY83QwATAbBUNGHSbB2NZDZ89vc4SfDtLUmlyy4a7NboTE/K6uN/DMjJ3I7sB6DD/yxJLlWbZNLCtFkmfUspzc8QN3f4KrOE0VpcKN0WFiHEh31RPHsZRfzYH7h4M03zOq9sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2384.apcprd02.prod.outlook.com (2603:1096:3:1f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 12 Nov 2021 02:30:09 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 02:30:09 +0000
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v5 1/2] erofs: add sysfs interface
Date: Fri, 12 Nov 2021 10:30:02 +0800
Message-Id: <20211112023003.10712-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 SG2PR04CA0181.apcprd04.prod.outlook.com (2603:1096:4:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 02:30:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a5cbfb-2432-4fc3-8585-08d9a5845868
X-MS-TrafficTypeDiagnostic: SG2PR02MB2384:
X-Microsoft-Antispam-PRVS: <SG2PR02MB2384597B0D583EE377E43F5DC3959@SG2PR02MB2384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6wkOpB96ECEb98wvEiBtYcUt7fKVG2EAf+OcKpgW+uPx15kQyToH2jpGnDWNLiJmfdwZ/faLLua1toJoro9vBv90m5IckQBP5cRClt1S4Hv+qoeeSy0Nyzh2UbRtsDLejgYLyavXla0z0HYP/vOGnz/yLU6d0qL0p3bu3jmjvJ5SIyTkG5gMaeMoH4EteZuqDfrV/XkutUsOqGRpqKuCC3qFQdMEpX59f6vqUR0W8gLcqJNqsiXoFAFlaJZ0VFin0FX+3lGiw1N57nqzIoBfcg2hG+zXVoISMUOQ5s9UIhPc3eDibBditmwcW52WiNmVDp9pRYw5PVhM9gY2WRSza5Nrpbk7TMnIEPy6WYQeofPScrcKs0vGdyDAtvsv8RTB44TnKgtWy4SNQlyxmoAWAJIn7bc5MFJRZUS4fWTE9bX7slA5uMgrpN+GEImWMAXyU1g1cfp/5JPgZASC+H3ogrGtmDekbw4U8odJBMl27f2muel7Z2YSfaM3C+QZ9sKyNk4cWRj1rh55xxdl8hxd471lP24n7cWy4muB6TlJaiOwiZEC4AYizRd1l8GcQQbRZeigoMqi7ZybOjNrXuChwcax2CSyaloHSe9MtWMHrtYvuUrLknX7Cj1jkwvLNCjuXcabgmZRAxGzcEhDU1inocXrlB1pGO5NY1HtExdFzuO1apWys6UnWMUmV5AG5mQtKnMaTPUH1HYBNxB311QQn8SIgxBvoLfIOjJdTE2sOy/1uJs6JNM/w9z457t7zvhvodNb9QxiWYAMq+P2QprF8Jvqi5BD3QXPXyxusV+7As36zZoFhS1iGfgt8GK1Aa9fDN8BXqiAzE0u7RVwiI18w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(8936002)(6486002)(36756003)(4326008)(2616005)(2906002)(6512007)(956004)(8676002)(38100700002)(186003)(1076003)(66946007)(26005)(38350700002)(6506007)(316002)(66556008)(30864003)(52116002)(508600001)(66476007)(6666004)(83380400001)(5660300002)(86362001)(11606007)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEEfscSuxiWpWtbpMh4ToSvgKaAvxiQotmUNZOu1sSrzHfI7xHweWHm7SWzP?=
 =?us-ascii?Q?5d5XI2XSLwX50eBd8AnVvH3ZIA4rbteEzbCTny6K68RwMdgr8ZBAiPLJvPgv?=
 =?us-ascii?Q?OwPod2ET4Gf1rqxGVqfYNWwH8UfKen/KkCN85YC/4CfA5kaSLSuDvflPofbw?=
 =?us-ascii?Q?xztJVOftZZB31kQZwk+BbU4wLJeQlFe329IPWgHUc4PNZdN2q1FDfi+hVZrI?=
 =?us-ascii?Q?wKwJeAdopOb8Nykz5oHHn45Ac6+HaTJVzpP1LNTlb9mhateyJvawRS7xt4cR?=
 =?us-ascii?Q?BqUk02aCZFE2opCZy0NkeW8UtIZksgzF7wha40rfWlhqzE0SpR2o/WrssbFm?=
 =?us-ascii?Q?wrzpVY5PkL7WrIjDSoDJl8z3sY7RWbkfC4RTXWo7nglLNdRcnBGlxb+aUcRX?=
 =?us-ascii?Q?eXOF32QofA5kIqgzUW9wmbDqeNw5jlUGPtruwxjhgOnrNWsbXhMuZGZgs1gZ?=
 =?us-ascii?Q?2FWj3NugXtSYv3h4XUKw0jabL66KugjS3lFEXZ2D33bRNq0cQZHOt+RODB+d?=
 =?us-ascii?Q?F2u/il7ttFOqyuUGX9Wz2KpC/HsU5pGRPtot/Adg09lGKt7ASHw3dQ+kJiB8?=
 =?us-ascii?Q?usDEqZAPnk4kZCuVwkEWhfBKWynuYxdV2g5gBxK/tr/V7uJlMdP07DtnYi+Q?=
 =?us-ascii?Q?QBKGnhDfVYF3RSeisBrp+DaC6vcmrEibf0MMJOQ7xPECum2U4mkE5dfDzKZx?=
 =?us-ascii?Q?k9gU4uH3q+kALnMRtu8tXG1u2VDytLsgCpjsHtmQmTYBzTsan6hKp/MFH/1S?=
 =?us-ascii?Q?QjQJxvATRR7bjbnYETWhU4+zY+qC6ETa7FBugU0efuAPe21diOWBB2VbmhWI?=
 =?us-ascii?Q?xNfw/FfkBbTKjUYUVTvmC74HPDhSL85JKvsmYGDNQ81s37KHlI724iImGqVx?=
 =?us-ascii?Q?W3MGLGn8izepgGlcvIsq726RY3bVr+ERy/mgcKeJune6qkLfSidgS8/92sTm?=
 =?us-ascii?Q?R2hfL2yANgdsUa7DIlPC0CPClpuw63CtrHEJIi4I2XspTeiuTKuTeVIrjU7o?=
 =?us-ascii?Q?1cfopvmw2T53iYRLG+fPYi17b8yXStKsTKJng3kFVTjnNvI6IJv8Ls5wkD9O?=
 =?us-ascii?Q?ACCaviQ4Uyr0ti2r4lNy0ZrmmTP04s/414+Ax+wA7jn9Tu3QNdIOMvsEJ2Ow?=
 =?us-ascii?Q?8J1UB5VmGLVvzUZ9AwL/mNJSpdQQPYE80ygX8M/U9UnxSx1GyaLKAFpN8Ooo?=
 =?us-ascii?Q?5t4WH7l2plifOUtS2Rxi+XITyRMBSAdQOuNcYkdGLb9gQfXVvH/4nts+sMcq?=
 =?us-ascii?Q?gv/oXphP+XwSoXiCtvYp3GP+4o05UP1sMnamIUrJSri9tOMrE67Xwb/636jG?=
 =?us-ascii?Q?8+DnSSyfgtCaZmGbG4f4e1S7wmA2S0woOtJ/Gga97f8aZNMdgVLsdw8AHsCi?=
 =?us-ascii?Q?lyQrsRv1lO+p09e1MYfQtRyaVxs9KUY6QBrxSEM1LhSBSxMlJ/vZaqHiITvv?=
 =?us-ascii?Q?85TP/9ZI9ifDg/GQoIedyNoO5gShkze+ptYFoYB0ssKSVT3VX1ouYOgXqoIA?=
 =?us-ascii?Q?Knj3FEA6VHsrEAuEBoKs1zmnrQzCijA2ecS+ZXfypsW0Ym8SzEqlydyASH42?=
 =?us-ascii?Q?CsOqpFe0it4UBIZocGFZnJyHzmuohK67hBrfdpHD3mMYF4l+eEl7GtrEsYmV?=
 =?us-ascii?Q?DK8VMx1qaJj9+1kVGvaBkCw=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a5cbfb-2432-4fc3-8585-08d9a5845868
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 02:30:09.0594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqp63y96sY+SNZ6t0WY64vXnGVhn/FaSVbSVRQL4fFgZC2B8o+mkj9Pl4YEM5IVqwBsfhwXHB2lXpdjBmEw2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2384
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

Add sysfs interface to configure erofs related parameters later.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
since v4:
- Resend in a clean chain.

since v3:
- Add description of sysfs in erofs documentation.

since v2:
- Check whether t in erofs_attr_store is illegal.
- Print raw value for bool entry.

since v1:
- Add sysfs API documentation.
- Use sysfs_emit over snprintf.

 Documentation/ABI/testing/sysfs-fs-erofs |   7 +
 Documentation/filesystems/erofs.rst      |   8 +
 fs/erofs/Makefile                        |   2 +-
 fs/erofs/internal.h                      |  10 +
 fs/erofs/super.c                         |  12 ++
 fs/erofs/sysfs.c                         | 240 +++++++++++++++++++++++
 6 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
 create mode 100644 fs/erofs/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
new file mode 100644
index 000000000000..86d0d0234473
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -0,0 +1,7 @@
+What:		/sys/fs/erofs/features/
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Shows all enabled kernel features.
+		Supported features:
+		lz4_0padding, compr_cfgs, big_pcluster, device_table,
+		sb_chksum.
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 01df283c7d04..7119aa213be7 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -93,6 +93,14 @@ dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
 ===================    =========================================================
 
+Sysfs Entries
+=============
+
+Information about mounted erofs file systems can be found in /sys/fs/erofs.
+Each mounted filesystem will have a directory in /sys/fs/erofs based on its
+device name (i.e., /sys/fs/erofs/sda).
+(see also Documentation/ABI/testing/sysfs-fs-erofs)
+
 On-disk details
 ===============
 
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
index 000000000000..cf88e083eea5
--- /dev/null
+++ b/fs/erofs/sysfs.c
@@ -0,0 +1,240 @@
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
+#define EROFS_ATTR_FEATURE(_name)	EROFS_ATTR(_name, 0444, feature)
+
+#define EROFS_ATTR_OFFSET(_name, _mode, _id, _struct)	\
+static struct erofs_attr erofs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr_id = attr_##_id,					\
+	.struct_type = struct_##_struct,			\
+	.offset = offsetof(struct _struct, _name),\
+}
+
+#define EROFS_ATTR_RW(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
+
+#define EROFS_RO_ATTR(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0444, _id, _struct)
+
+#define EROFS_ATTR_RW_UI(_name, _struct)	\
+	EROFS_ATTR_RW(_name, pointer_ui, _struct)
+
+#define EROFS_ATTR_RW_BOOL(_name, _struct)	\
+	EROFS_ATTR_RW(_name, pointer_bool, _struct)
+
+#define ATTR_LIST(name) (&erofs_attr_##name.attr)
+
+static struct attribute *erofs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(erofs);
+
+/* Features this copy of erofs supports */
+EROFS_ATTR_FEATURE(lz4_0padding);
+EROFS_ATTR_FEATURE(compr_cfgs);
+EROFS_ATTR_FEATURE(big_pcluster);
+EROFS_ATTR_FEATURE(device_table);
+EROFS_ATTR_FEATURE(sb_chksum);
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
+		return sysfs_emit(buf, "supported\n");
+	case attr_pointer_ui:
+		if (!ptr)
+			return 0;
+		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
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
+		if (t > UINT_MAX)
+			return -EINVAL;
+		*(unsigned int *)ptr = t;
+		return len;
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t != 0 && t != 1)
+			return -EINVAL;
+		*(bool *)ptr = !!t;
+		return len;
+	}
+
+	return 0;
+}
+
+static void erofs_sb_release(struct kobject *kobj)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						 s_kobj);
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
+				   "%s", sb->s_id);
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
-- 
2.25.1

