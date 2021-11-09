Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FF44A7CA
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 08:46:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpKmM2q4mz2yPd
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 18:46:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636443971;
	bh=i0Z+u5p57uLkV2SnBs4BOvRsrLHzJljPAF1IdamQmJE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YWAOnEMdfowAqiNmbV8p69j24qFhNyyowUkXeGPBoRmpywsb9hSlylYvGkSfAypqx
	 hWG/oL2Ai5oAZ5r6mQuDcxHfiCrBV432uxyG9F8ksW5tv7NYLQRHuU2JAe1oiIrUCF
	 ituQps0MqUnLod+5dcsg+j4utsj7FEisG3o/yPV8kAtsR8G7u4d3mcpO8WIj/M+NlJ
	 vRvetHAT8XKVoe2Xw+UWbn1Yqn/TJ9IDrZT5IX40FHwEdWVEdd4e/x5fY7fKRnKw9s
	 O5isv1ERW7uQiO7JhLHCf1rpt1pgWD40ktvEO/glXp9N6xO/4RD0wsl9gnl8W1Wbh2
	 BVgNCIBGfhQUw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.58;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Wa6Xi2Hn; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320058.outbound.protection.outlook.com [40.107.132.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpKmG4ywTz2y7M
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 18:46:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmVtITYu1APH9C1z1aMS/DHJ5/FmqXn3l2Q0vKLMTEdR/iynna6XJHSn8qalm0YDTNowFvaXRi1VO0DnMjhiu0kR0CBnis84XTqR3jIzLCunyGbnrbsTl8jro73Qs4VlpYFyxru/QVNJRRkMwf79WShXP/ADEhYI1+aAuKKxdeE+AZXQBNk5KZfZYDyu814tT003ldMulrS0qDA0nPeh2eHLv6qqMRH8ySDr95N4jxXIiDgG12HEZIrmpMbqRbNtz5/eNXbg6of3Zx7N7CByg6Qrkg1UucS1vPsNr9KyrzAvYKcSwCdN8wlsBwqfSmCwEEXLiIz8Im7gFSj2PlL8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Z+u5p57uLkV2SnBs4BOvRsrLHzJljPAF1IdamQmJE=;
 b=JWkECC+FVA2bPOgj/NBypp0FQ6qCvUjK7eE2chQ7oq/8Cx/CCfTfNwCi9/z1uvTuKxEa14yWMI5llKOI0HStXwZ/6qFTHoTIACTpxawYVW7eoQgRUhEIksG37NIPatR7fTEVsxXAcXzoW7VWChiQpRuPUXB3SDoFfi7GCu/tHnR2yygZPRzYw00r1+SxRR2Cw6MiKeuWI6JdEoEsia1nsErWnQ1zopED3UTPYljUGzTVIKEZQhAmDMQBl/h9Vq8dOup2q9WqprsMNl+5+lEWQoblnyKrmBCToH4VuqY8p+C+JgHU5WoDKa0wdP5wtWMm+OZjklBbmFUFIepyeEdw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2383.apcprd02.prod.outlook.com (2603:1096:3:1b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Tue, 9 Nov 2021 07:45:43 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:45:43 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs: add sysfs interface
Date: Tue,  9 Nov 2021 15:45:35 +0800
Message-Id: <20211109074536.23137-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
References: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR06CA0024.apcprd06.prod.outlook.com (2603:1096:202:2e::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 07:45:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff4491b2-e44b-41f5-3fa6-08d9a354ef25
X-MS-TrafficTypeDiagnostic: SG2PR02MB2383:
X-Microsoft-Antispam-PRVS: <SG2PR02MB2383AA5559F82EE3D1360195C3929@SG2PR02MB2383.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuBCYxKPFqJ/tBUp4CYjRgh9zMmvJD8BKK5TfCGR4p2glknsy+VZMgMbKyvNzQ47dm1Uho4DtmfNXTL214oNDaxFwutQINCT2nYovmES4T6Zx55M0sCyrHYb+lgiwPNFa7+UZvyuaXwcGdVjOOFntPkQsm6aK7AZgjlUp0ijCsMVzwAsi3n4FpWlg4aH8dyyZiharofGPrBtkJ98tnH9WlSODZ66AW+qrGWTtDoGBUJ8kH1A52nn36knrpMFcdQ4+I2oV7uAEO3fxuGTmjOTTSE9/VFKNNprr680a2wFyYvDDqFupNe9VcgY2jWVoMX87e5SZ1xTScLTdjYBzJt2Z0hZrgh+3mao95G0FhESoztKyUsbNmihQY3nJrx+0SG8OfhwUSoUUT8xa78zvzZlvLAJNx23xsB0p2FODhkWSCC8tleYNS0G/tIFUY5GH9NZ4s1p08bXzbMOCbd+HtONMygF2de05qffcHgkwq/UVaQF0VMzQ92YJXpP1PcGOeu6tURrykDOQaMBWiKyA0ZMAMKA7WX0D8q48H1zaielk8UmxhIhYcHd5fli9jII/TBnyavXPDLPHo0YX9A6/BO5xnZnVY+Iq2K/ZIYXc+BVSa6+8/4tGZjzTLqIZLIDwpRTLMk2I1bSMBlWasfpJqtW0gVah3U9O0grk6Spqrym8k/vaDSxbb8qDZy6c0eguTqzIvcf9mxpeapryF6H+RtwUSTIZB7dMo59qfcuD49jlDi2FmClKs6rdKZpkYYVrtnZp8BErZmZSTOKyTp98iCHMSZxoSUzlVrtmfsCdhPtWqB8XrrS+IkSoI+GLKwGoKV3bPORAsrnVnyM30thrxlcKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6666004)(4326008)(66556008)(508600001)(86362001)(6512007)(38100700002)(8676002)(66946007)(6506007)(52116002)(66476007)(26005)(316002)(186003)(38350700002)(36756003)(5660300002)(6916009)(6486002)(83380400001)(2906002)(2616005)(966005)(1076003)(956004)(11606007)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4m0rqYlEeKwL/ke12PYXwaL372pivXfWghKRm9YttluVC5drjO9JGqfoqnj?=
 =?us-ascii?Q?tyq7TXFt22f1fW0cT+c6gQo8sntU8B1HXZl+aQK9gVIme7gFaD3zSYUgx3Pw?=
 =?us-ascii?Q?z1YUtOtHL3DDxnu0XHdqGQ/CNcbxDwHZHqyADspkbEyX97PAWbFBlqFqmmyX?=
 =?us-ascii?Q?wjmoq15ccxa1MtQB0+AdfRmxGnR4vtel+xFE9mdhUDBy/azzDXl4QMB6dW3C?=
 =?us-ascii?Q?ivFYVimtsapgCVgSXV0Z9HhFkZ24sCX3gIaT8A8Td8FsIB7n/xx8V3jHCKRJ?=
 =?us-ascii?Q?5fWPZSHAXzI0Pfj+c1qxIvPd5bfm4EbYCQy/bAqzkXoMQQ2sV4M3IDaTVIaW?=
 =?us-ascii?Q?WAV/oGyT2sA+U8Vn6ocNhYFKCFYW2DLiL7HH9ebLPfJtR1/5Tyfq88osKa6G?=
 =?us-ascii?Q?SeUXomjiGbyu9f3/VhBLwqMf0dMR+i75Caat/XuQJqKo6qp0bkA9ae6T+4cU?=
 =?us-ascii?Q?ZO3c1G3WK1r3EfKs6cKI2I/rWjJHB3m1x2rrh27Fgfyr7yjApLTKXMrD0n6Y?=
 =?us-ascii?Q?ARH21pcbAh0bB9IlkkARxgk+y8Vi4BVcaG7FhV6tDSRDKIDGFn5xh9EKUvCW?=
 =?us-ascii?Q?qqkc/oaRgHi0FI6bkdHsvm8if/CGC8UPWXR8MsrChA4z/tAyi9alQF01v9Im?=
 =?us-ascii?Q?58MTF0p9QtBPzUuuNW6tEYgSFiol/jgfjugXty1sOdE+OipqBvoANCtdWjpP?=
 =?us-ascii?Q?SJMEKyDUne0jXASvo64IrYm5y4xP5pfM5WuAHv+6C+vfwsm+DXnLtd8NzYz0?=
 =?us-ascii?Q?rWYkyN0wge/Ydo/a4nvc6SN9vlOK+juqkep53rF8WIRlqAvSDgyjKGgSxBvp?=
 =?us-ascii?Q?H2zYd9sc82KIdg6/tXgMO85KrxosrQoXr7Bjx9+CGGaoa/p7R7KsQj9KDme5?=
 =?us-ascii?Q?ZxL4ctzcf5lLb70igQKG1GIMzfLblF9pC0XlHam80kva0n+njWkzZUxvQt4g?=
 =?us-ascii?Q?k+NVsc+Djbyplp6q8K+fb80VZq6ILv466Fxg+WG8E2QhPnFeoGcU+AxckA/X?=
 =?us-ascii?Q?soJMMTX22Lfeou4ptQXhffpim6pfYUHDMk0tfuGGJfjdFg7wADaEFSg0kdHc?=
 =?us-ascii?Q?PpOGKm6L2LBu5CBILuawrtv5QMzzJDxmlY/Xn31vQ4wDGvNhfy2jT3l5GFsa?=
 =?us-ascii?Q?oyOPtOfQjXkHmHuNz/DzQcKMu3MVOFV4krL7MDPGHgAg0rL8tC7Kjdd8CCz3?=
 =?us-ascii?Q?ByQqdMJJvw6rTFWsz5CT57PCZkyxwEEWdPKX/uEIczrDFGtQMctDEE0t+J86?=
 =?us-ascii?Q?aYoCV906m07dikwKFlDO28STyRrl/zy0CKmBItRLBjiinJx9giZdz/EXQmgf?=
 =?us-ascii?Q?NDWfn9imgPk24HPWosh0Qq387pXIt8CH+i022/EuGS1D4HYyDR4Bureo8wIn?=
 =?us-ascii?Q?RJrK7SwobJVjbAU5Vn5vhKLM1Gu/8PvOx9S+DKL85uAKS5Mq4DXtLeHSUsqW?=
 =?us-ascii?Q?/mEDr0zKeRS2c9bD0Z6pOEv1q446CA4ZYHdjRNjpD5Klh9Yv19IZQOS2yxh4?=
 =?us-ascii?Q?uWor5gHgkItnmB51f/Af/TtmPC7i3CIvU3cmJPaFKfj/MKOJF9l1jBYSMWex?=
 =?us-ascii?Q?igFlHHSGJ2v1RfLQP8Hn+JE+q1LadvzrWwy/mA2w+OYPaPfr6C+Dc4zPU/hd?=
 =?us-ascii?Q?d1NJOc1e1YIwIpwZq5wSdRQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4491b2-e44b-41f5-3fa6-08d9a354ef25
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:45:43.6330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HTcbJxQgpDNyja21WQfv7jF+CSS9bD6xw4go5+/u8hh6pOdewIkCoykd9OjwU/eN8Ccp49i0aJFk9w13e+ChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2383
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
---
changes since v1:
- Add sysfs API documentation.
- Use sysfs_emit over snprintf.

 Documentation/ABI/testing/sysfs-fs-erofs |   7 +
 fs/erofs/Makefile                        |   2 +-
 fs/erofs/internal.h                      |  10 +
 fs/erofs/super.c                         |  12 ++
 fs/erofs/sysfs.c                         | 237 +++++++++++++++++++++++
 5 files changed, 267 insertions(+), 1 deletion(-)
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
index 000000000000..dd328d20c451
--- /dev/null
+++ b/fs/erofs/sysfs.c
@@ -0,0 +1,237 @@
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
+		return sysfs_emit(buf, *(bool *)ptr ? "true\n" : "false\n");
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

