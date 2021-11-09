Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20244A7CB
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 08:46:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpKmR2LGwz2ygC
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 18:46:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636443975;
	bh=8LJuLaqHVSF+O11qR204oEXZNdY2GlpCvJsLYFTDuRI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S2aptlTpYjqBAk/nVEljbU4qrySoHDD0gnsVe3pae1+BOhzjh71KquYL3qDArB/rT
	 EWpNHEnm26wk4jwT2oLPZEaF9pUUpSnTTqe6N1rYEDRN99isChqobkHa6rW0i6yivQ
	 dTWtzxFob6v0PUwqM9V3kYmdKUxH5+KG2WzTxRh5qL5favmipJo4uFbni3mmIiieTL
	 NaofY5U/fEahPPisVI0MhRRWaMFz0qcptixJgbR+dB3w/4A3I6OY6QxmsssDNDJfyg
	 vsiw5E72WVF5W8bsArG4E0x6EEuCQ3pa9ACvjytoORLWzJ+YOVCQzMOG/0sn4YWQa7
	 E9BbtRIvJ2RCg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.58;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=SBaeK6qR; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320058.outbound.protection.outlook.com [40.107.132.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpKmH27Nxz2y7M
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 18:46:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHDl2U+vMeOX6TQZIKKp0SEnk7/Fz33uiXlzmOnJ/ppvBY/p0i7SrBHy89JdQHgj+fdcZYIkjgAgHqDI8HJEe8gQUvdWv2BvqQX/06a9g8RDIOG5/ZnvyPxYrHarV8TCtfLvgpEQX484LbRo6tgQAKdPyY76Cktjaf3Sq5JN55U2wfMOWs44JJa1D5HvX0KGgAtfurVjHI4R+44kVuVsE7ooMcw3o3LeOcSkk4I6W2sPTMQHZ7QMh64gfD3uzPuqHznoFR/2Kvj6B1DXgYz1J7jZNPZwA+P3BmZNckZmAVXnGTCyvmJQQ3rQpXG6nAGpk5lCvqfXXSlZuyVSboKJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LJuLaqHVSF+O11qR204oEXZNdY2GlpCvJsLYFTDuRI=;
 b=E/mzQlwUqC0RnvDpzALmVQpE/cbMAIVqCsX2c7Xh5hxrMLE+bcBMH66E+J9zo+rAdq+0sqtebv7anPS3SIVtIJKy/D4oSWndn0X4jSH2yil/Gpi2a2paYpVi33xULqM86aDi34PGdxuIl31LXXShpvOJ33lnI5D/wfH0S2y73CeuBuyt2aUMiLbWR8Qs88g4ozwoXRNXYCHILEwWRbb3yFm1cyEZllponp5/UxNHTz0FWIhfUz1p2s2bz1/AB0jQQEwn7xJNnmsyxb8ep7JHNR8hln/UmaULH7+UiQ5ACy1R06C0c1vJ5jXX7zkG3bcQFY26rpnA5rN95jiKAN0jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2383.apcprd02.prod.outlook.com (2603:1096:3:1b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Tue, 9 Nov 2021 07:45:45 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:45:45 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: add sysfs node to control sync decompression
 strategy
Date: Tue,  9 Nov 2021 15:45:36 +0800
Message-Id: <20211109074536.23137-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109074536.23137-1-huangjianan@oppo.com>
References: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
 <20211109074536.23137-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR06CA0024.apcprd06.prod.outlook.com (2603:1096:202:2e::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 07:45:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def9433b-d898-4e43-ea8c-08d9a354f001
X-MS-TrafficTypeDiagnostic: SG2PR02MB2383:
X-Microsoft-Antispam-PRVS: <SG2PR02MB2383702241C718103F391828C3929@SG2PR02MB2383.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lccatYzM0CJvIFhK21GwTvFdBeJBeXpJIjRFvv4uUMnN26RqyFpp3iwKUDrrptvahiCzDJ6KmFISN/Aad43T3Q4SoXy5vjOzPDMsOAjHanPysPNlzi4cPXzkB5JOUP+SZG9plK9tjjkc4DUShxmbsNbFhoBHd9i8NTlYq6QLRy90lkHp4qfTJg/Zp3KP+MG4+swK/U0OPbAFGY0bCzuKCoHeNzPgkpjbruf0JvAyWutWtL2ZIzrZC/XZzq3p7KRxERr1yYXpE4frBbwMUxIZs3CPgYfJZfynrEcLt/hQZf6x9rtz0uGfKZDKqF3k3NJxW6RX08o6UhNKNGq4soJUXqb9PFgbWFgLNqs3prqD/J8mEjggA41PIPjH1EZn9WqQMT20/h4bsRJPJqrxzBJYEyi4cE+B3cFumKMjPPPhJoIclO78lJzylkEt8s0leNy3Tjjfnyn2DG/2b76MaGJw78UKi3PilLqItcuGzSmiDApklTvbzEqfOYJZHZGoyYbDCJiKlA6Af6P4+T95DlJEWgtmfaoKUZPeWvrZgjLzJowO/J02ozARkbiRx08/R/o/RdCc7ZobpgWzndgCcbJ5qCKk1Is9xlUlrH/+C7jgecJyFnxyeLHzS5MbZivC3HKzDelg8Ds08aGkt+6lGW+t4KE4lotTHNtXwydpIeyMop8oK6hcZhSzqTrem3cWSKPdIVD5qutRucl/7Mr66r/We7kKY5Si5l/6Wis1sW0/MAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6666004)(4326008)(66556008)(508600001)(86362001)(6512007)(38100700002)(8676002)(66946007)(6506007)(52116002)(66476007)(26005)(316002)(186003)(38350700002)(36756003)(5660300002)(6916009)(6486002)(83380400001)(2906002)(2616005)(1076003)(956004)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cv1qI5uDVkRrHLiKLzyv0Hyz61CRgQhf+laOGV7hvTTSvKhIPH/HdSSv9Wif?=
 =?us-ascii?Q?dYBl5B9JoF5m2+BdsVmQpHSBovOUbsvJUdsWLQ2R/C0+Zi6msBqxMaUP9u9V?=
 =?us-ascii?Q?Gr1DRgCaKFI6ILlEITgFrnIAbWlrThEcGdj7JZVKVFZJDk3i3gUGHwMyzPXC?=
 =?us-ascii?Q?oUF0shYfiP8UOfXtEQcbNjNmj1GGSiDNOSX5O6gXcIlyFRPXY/wn/iL4SySk?=
 =?us-ascii?Q?nCqWUCqJrErm5vMuTLwbOGgRsFEYYMIgiSTFLAVEzFWYtxetizzlBTYJaf5T?=
 =?us-ascii?Q?vH2QE2cGOrsiPaXYHp4ke+tSYWK43Cwh5DMEQhV3qLsPDj+hZhrLREluJxDY?=
 =?us-ascii?Q?IRKRpoQchRNi+Uwr0EhTuAwFWKGUrDKU0TtntRJzkZbILv9wtvVfxpblH7ei?=
 =?us-ascii?Q?sUUFV0ViPLFElUbvFxLze0NSotBC1AOaPpjir+EP0QchjamGXNRNWCzw7aWL?=
 =?us-ascii?Q?Mill9LqTI78kRyjWT4QpFH1USsggZxC8M4uBbBdRNr7/pisF5s7UPXmnZFz0?=
 =?us-ascii?Q?tNqkj3nhCZaeUY2FKPaYQz1KdxQY8QQfWAE1HS+D0uwckkqq/9fTV1wrFs+u?=
 =?us-ascii?Q?AFC24+Mn+0UU2OXbGPohXbvT3XTpfCHCnqUovuq4bh8iMpAXKNLLiMQ+hDGw?=
 =?us-ascii?Q?c8l8kLS/opwKbFvGhBsXosJ6tnAVtrtYdi5EVmDa6+I6TYTPnYqO79D7Jnnl?=
 =?us-ascii?Q?hH07hXEo03VH/UMPfIuXmV+Ia+nUiDuGmE0LEosz4fxA/OzA4EbAmQgc/Gki?=
 =?us-ascii?Q?FNMEJSA2W56QzbHHrhFbZuJpBli4hYA5vawBHTBrFgnzxZSFzgnHZeSj3dri?=
 =?us-ascii?Q?Y2BmG1mtYNDs7u5ukacCYOwpLosmLES34kiQIadPBNbrswN0R3kx73O8WiAg?=
 =?us-ascii?Q?J3PmXTBdPQUkmkH7rphcVp1sZSB5ncKsQ78xkdraIIe4H0wqWNtcuSIsPZAa?=
 =?us-ascii?Q?b5+Uc9SU1H4rA7rBgGi2skmxYo1Fq54uDpi+yrGj0mO2FM+9MkIDlS0fQatr?=
 =?us-ascii?Q?aDqJlvAj6rkNItchGn2pdJLKAKU+IsVRBckHVK3VA/9iLKguLo4AF7lWaO2l?=
 =?us-ascii?Q?FyeLskZasjHLC41g6WEK9zWKSkaokR1UGgHIjfXcl33T1aFz3qqAEtvFWf1g?=
 =?us-ascii?Q?9K1VjQC2aq5MCxve4arDARky6RiI0prQ6KZjPOI4XidwLJhG76grj+ZdVeWo?=
 =?us-ascii?Q?+yX70eAE7HAvffhaBOKCLuCVAKNNilBbZmnqsjXu17pWG7Ge8BJqbMGqqQ5E?=
 =?us-ascii?Q?7tC0jnmvz9NbMQrbkR85K2UVtlrbvdveRIkecB8j3v7jQzFUeaGR8WB0bH31?=
 =?us-ascii?Q?E0v4+T+GP0d0LFKhvyfpN03L951dEzocOMjeuRoO23KQ0diZGV1WF/FyMhD7?=
 =?us-ascii?Q?SoGG94dSFYpSrAKAmHKwwGk0Ig9vQVrI4XriPEM8MAte8iBypCS7TtbgacGZ?=
 =?us-ascii?Q?e6o7Jhbsq8t66UFETjXZgzjJoO936VULeUTWztWUCeKO9r+NXU3+tMB2OWUV?=
 =?us-ascii?Q?0Ltk1fW8J2tWMWuAzRacBIoJWTGTxNgbaQYW4jRnxTkVU7HxykIbE1q4CdiL?=
 =?us-ascii?Q?Dnx+OYjT68fXICajWsAARWG1tpOcYWxL2hayQANMm2YshAx4u+nKDUIsJKhl?=
 =?us-ascii?Q?dOiTc44OgprcG8Kf0A1T5Co=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def9433b-d898-4e43-ea8c-08d9a354f001
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:45:45.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23OLy/G64blS/a/6Q1aH6FkJNGcDH7yjhxMjWJCs8Uzp/Wk4D9SW+IyiT+JojXP+It9X8JeQ35enFyz8qKupJw==
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

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So add a sysfs
node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
changes since v1:
- leave auto default
- add a disable strategy for sync_decompress

 Documentation/ABI/testing/sysfs-fs-erofs |  9 +++++++++
 fs/erofs/internal.h                      |  4 ++--
 fs/erofs/super.c                         |  2 +-
 fs/erofs/sysfs.c                         | 10 ++++++++++
 fs/erofs/zdata.c                         | 19 ++++++++++++++-----
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 86d0d0234473..c84f12004f02 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		lz4_0padding, compr_cfgs, big_pcluster, device_table,
 		sb_chksum.
+
+What:		/sys/fs/erofs/<disk>/sync_decompress
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Control strategy of sync decompression
+		- 0 (defalut, auto): enable for readpage, and enable for
+				     readahead on atomic contexts only,
+		- 1 (force on): enable for readpage and readahead.
+		- 2 (disable): disable for all situations.
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d0cd712dc222..06a8bbdb378f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -60,8 +60,8 @@ struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (false - auto, true - force on) */
-	bool readahead_sync_decompress;
+	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - disable) */
+	unsigned int sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index abc1da5d1719..ea223d6c7985 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.readahead_sync_decompress = false;
+	ctx->opt.sync_decompress = 0;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&ctx->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dd328d20c451..a8889b2b65f3 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -16,6 +16,7 @@ enum {
 
 enum {
 	struct_erofs_sb_info,
+	struct_erofs_mount_opts,
 };
 
 struct erofs_attr {
@@ -55,7 +56,10 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
+EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+
 static struct attribute *erofs_attrs[] = {
+	ATTR_LIST(sync_decompress),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs);
@@ -82,6 +86,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
@@ -126,6 +132,10 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 		ret = kstrtoul(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
+		
+		if (!strcmp(a->attr.name, "sync_decompress") && (t > 2))
+			return -EINVAL;
+
 		*((unsigned int *) ptr) = t;
 		return len;
 	case attr_pointer_bool:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..70ec51fa7131 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -794,7 +794,8 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
+		if (sbi->opt.sync_decompress == 0)
+			sbi->opt.sync_decompress = 1;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1454,9 +1455,11 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
+	bool force_fg = true;
 
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
@@ -1468,8 +1471,11 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	(void)z_erofs_collector_end(&f.clt);
 
+	if (sbi->opt.sync_decompress == 2)
+		force_fg = false;
+
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1488,6 +1494,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
+	bool force_fg = false;
 
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
@@ -1519,9 +1526,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
-			 sbi->opt.readahead_sync_decompress &&
-			 nr_pages <= sbi->opt.max_sync_decompress_pages);
+	if (sbi->opt.sync_decompress == 1)
+		force_fg = true;
+
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg
+			 && nr_pages <= sbi->opt.max_sync_decompress_pages);
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 	erofs_release_pages(&pagepool);
-- 
2.25.1

