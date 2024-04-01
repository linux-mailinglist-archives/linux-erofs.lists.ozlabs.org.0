Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD48893B94
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Apr 2024 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1711979042;
	bh=9WOs10zOcBoe1YW6B3+qWTZD6LuSJTqeTPfVFKBDES4=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IjVbPDWBSIcTIZoAKWbI4lqAieWFyf2MdxtSmoYaD16pK/cVDgcUkwQIlVz18uQS6
	 PdtKbkBOQX9KKL/a7dIpJFsLTVRzHUsBGtPq4CVeey7vb1FiPZ6fp4RjKmWX5kt882
	 kKJ1MS0S5zUdQ4MOP3ijUyFVpafpyRwHjaDw+Fb4/Qph5SDmvdYVQtg6ybgSCgFX2b
	 YnOtMLleAK9IbD3OSXS+BnQdEzjfuPAHHjFYOdbI3SPxHIyCzNWojjsFzayFH6W17m
	 cx2Q7c/iZJ2l0mOUnQ2hBSFzXaoQd1zLOWvCKyMpvwK7RAVzpFspyWvr+h1QtfFHyo
	 9JX452++4AMsg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7XKt5kCBz3d44
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 00:44:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=mT+Y7kRm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7XKk2MXlz3bmN
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 00:43:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+8DZBgM+qcUUKLDyYVr+cT016r+tu+HNeJDD3CgA3BXPYXxAA2FcWqYNQy7WYvXhtqoLRzyq+N7hO1jG28Upuv/roFzwF6KBzaZ5oa5Bt2SFn+50H7Gl5NylceIQysb6Ao9ZeEgMLjkpP/LVKN/mMKLSuiqIm4/M5jC8RtBtEnjFeMUtykqwchJNvGzw3MAqcVIOhPcva2NoYnlW38dH1974DfVfDIhLXDv0xdefCULMdrp449ayiWlsf+S015AkxBEZxykKLP13QcS3XkqBSgxZWRN4a9WSW0jk4FqDvsFBZNDEvQR80ilcasaASWheCKV73XesCt/dBvpJqC6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WOs10zOcBoe1YW6B3+qWTZD6LuSJTqeTPfVFKBDES4=;
 b=iRk/CAroFtCPA25TosqDgUtelLAf7IEqEjmwZCwR/LGUxmwjgvoCdTAPydgSMP76XJ4TQhxi+MmrQHCntu3P80VGVupyKGj+mCKl99Wnlw/LmofI/Ek5SpENsj6CF7gG9cVF/IRc4u7z7aJjnQkHTS1R9nQddK+V8M0QlB2zX+mx7ZS0sYrc+5G7PKK2aCJNsakpSFTZSQajvBgw+MIp0X7GhBu4KQ4hVHod2XGze7YtEhzfVbbco3tuvs1YTZVjIdCKvmtVWR2p7Hyxpue2hw8S5I9/4WhhrOdF1nxbEMHw1SnedIfP2U7ieppqYDHN5hkkFBPkGyYHOHFFmydLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Mon, 1 Apr
 2024 13:43:32 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:43:32 +0000
To: xiang@kernel.org
Subject: [PATCH 1/2] erofs: rename utils.c to zutil.c
Date: Mon,  1 Apr 2024 07:55:50 -0600
Message-Id: <20240401135550.2550043-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SI2PR06MB5090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	OweahjtNJkl2fB+ab7GPjNXtBdvDjg5SZGwGzic9APqQFI97X3RNpM+V9ly5qYfjgRRqw+1SoSn10jWZM4eIwFFlkIiDaF+RFUMc+EsFEd9CP2KNVCmZpXKK6rIn2W41d/iDkPLZ/XFF9aWjNiBFHYjqvotHWLF1c0wv9VvbO0Op20y3fJD9bN2XbnQFCGFdb+SA6s+5QQGbVmQhXhM1t6bQ6Gczh4/APcVHl4nnM4iSjSU6EopNCvboAoQrNVTQOykAqbbS5o0ZEKx+CPnnaYIIeMvsPQzlaHwaav4E5U3YQN5T0Ntg+jaKyoiGc2ptgkTU8OjZz/gVWxNhfV1XskV2Z3xnq9NCr7Tl5FpEyEimK2H7FjPh/8nGqNPNQADcYWpTUtQCOI6vAhi34Wkpmc208Upc7ZltgUSxqJ2M9YoWZ4sHnkRVh4Q6/JIsQMtjdHa4x6nxk/TAfCf61sir4uOY5+Bwfuu2w9mOnVf0HP0Rndld/TXacMOBO7pcSTdp6cxwNet/OfjkhzWS/ZOBDHREeRiblVYIqSrKllKu81sLzKaESy0XqYyH2pMpfVmO4drxpY4WKu9grCiKsx53WLnQovwxaJ99JJ0Hcar85ZCpNGgSiDOdkH8GQSRQNBleIIfWz+yonQlASj0GItVtii9lBVw+2WZ4KztiL4a18g0LA7bV/bH1JfNCnNAGw/HEKYXvOjYOE/ZfCN18UtoARA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?X7liZKdRDQi1soMy3WQr+QIgkiaQGK98lPMLT7JsNTvlHxlyA2PnOjxfd7W0?=
 =?us-ascii?Q?n4jwj/tzCQP0tLZjhVX/R/T7KHvzZfLyrzyMuJom9mLZk1wHWvfdkcXnDuXg?=
 =?us-ascii?Q?yRVafV5fwIHE0xUClTz3Kt3kOpFXBAbbUZ2uhKPjr986y7ihCVKCaxK78gJt?=
 =?us-ascii?Q?N2VOCRpliSZvbU/jMZS4D7ShxKKn735XJPbhojRW8wQ82IrZ/HZIoLHSowue?=
 =?us-ascii?Q?P3oF1Zi2UsHmp5UL5oLi2BL+enuk0qZPTARTRupAGBhUI7B1W84jqW9D8TgJ?=
 =?us-ascii?Q?uaHk0sgkv+/Ievfys+00MGyn7oNWRbDaSAGUxFpW6WIaMqDuM/C4JPGv3OGM?=
 =?us-ascii?Q?5y+Fca88XeTILJq+fQF04c3kOby5fbhulSVOBdapeIaER8ja01E0L68sN3fX?=
 =?us-ascii?Q?fI4nJX5oRCXEOCtDmQcHmKLR5Ec0bIQDxz+B7HfWaiJUe7OIadLv1RT3UOtN?=
 =?us-ascii?Q?1Xb69lCrTb1vibhdTsDrLtT/ihnEyrlKe33lfnTQ38KyjYLX8kiWGUDsLmHd?=
 =?us-ascii?Q?DzhHYMseHckkLIdPJX0TSARnC2SxnAIlFCHjzLsAqKbDaFdEFa9R/1lfwuhE?=
 =?us-ascii?Q?UIM1DUVRCy1Hm9e06+wwlnsFgH9uEInVqmZIwW9XGvWQCINV1k2nmGLNOQ0c?=
 =?us-ascii?Q?THnBNWfuo8HuYvoooSF6MS7zk4RTPTaP/AJp/otJ4gBL4GVf2/OGWBWqv6l7?=
 =?us-ascii?Q?YmayKgzgF9xymnCDB35Vn5GHrjPOEnSNi77j4y/ocD+AinTK535GPUZUthEZ?=
 =?us-ascii?Q?TBwbbQMi9UhPx7ky5/5Aul0YOt8w1DCdIaBSa3s+p7eWJvfiDoJEu3ZU0dmF?=
 =?us-ascii?Q?uXIzCiitbQPHkYbh+wtAMmfdAmVwlQxaKNY96s84k4fmtwxz3xXg7lcDMQv1?=
 =?us-ascii?Q?OvHcmBE40WcxotudZi/OMZxw0d1GDoTyw14X4FxPdm2m7LAqdv0AO+r7Zn8m?=
 =?us-ascii?Q?z4QRuHHMSOEDsF49tje8kXWfF7EJKOLG7ZPFCh2uQohhDlkV8Z3Hlw2jOs6J?=
 =?us-ascii?Q?f0OmRXhi5X11iJL3EcYFcc+f7KUjxmDGiMhnt56AzwxPzWVkLPYXDD0A8WHd?=
 =?us-ascii?Q?9MO0EpInDIibFOnMWbF4t7NoHrJPL6+4LjqSIiuboFeamW/8gv05b5fJtVEC?=
 =?us-ascii?Q?rbH05hOfi2OXfZWTG5W4RbGxI+Fo5SnX2sOQJRpE+E2REX2b897j2/afZ9nU?=
 =?us-ascii?Q?t+7Uc+e3ptXh75lUvvXZZ2JpWNnou2hPmqWVSGArXpsOD3i8pAi66gvxHsfH?=
 =?us-ascii?Q?mrXNXVtnCmHRfu+vFykOfoxeCzBIBPouQpnhdFNhMZVoD4RSFNPOdD++bQZC?=
 =?us-ascii?Q?M9JUweFOC4+TSmt8/AJtiyi/iUgz5rAZpkTl4jY2aTZW8oTYkhW5D8o3YDLy?=
 =?us-ascii?Q?RK1XE1f7L1YlMh08TUWAUly5nurq9+dtlZH3lNd1e6z/RrTdFIQLLa107kaY?=
 =?us-ascii?Q?UrxkZN3ha1Q/yYTzTFU3cuu5YtnGu2+quvKJ+0JYs3HIjNAps67xgWmsNHva?=
 =?us-ascii?Q?ivdzka5tonCCiqWrVqlsPnLtkNfSOnKYTUhPgMQ9t/RLjwNI0pC/F1zD0QIP?=
 =?us-ascii?Q?jcHe5pn9jI7uLwuAAlC9F5M8N4eCOOsMuzjFC1XE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8fdce-dc98-46a0-c312-08dc5251b8aa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:43:32.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CfXscyhY2M2lE9w8hCw2Quzkvwhm2QsX0o2evK9jDjPmUGgJi9eMwDYFyAxcxkEwM35OGvsG0zsXRqQX4Ph8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, utils.c is only useful if CONFIG_EROFS_FS_ZIP is on.
So let's rename as zutil.c as well as avoid its inclusion if
CONFIG_EROFS_FS_ZIP is explicitly disabled.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/Makefile             |  4 ++--
 fs/erofs/{utils.c => zutil.c} | 30 +++++++++++-------------------
 2 files changed, 13 insertions(+), 21 deletions(-)
 rename fs/erofs/{utils.c => zutil.c} (96%)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 994d0b9deddf..845eafdcee4a 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/utils.c b/fs/erofs/zutil.c
similarity index 96%
rename from fs/erofs/utils.c
rename to fs/erofs/zutil.c
index 518bdd69c823..8cd30ac2091f 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/zutil.c
@@ -5,6 +5,15 @@
  */
 #include "internal.h"
 
+static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
+/* protected by 'erofs_sb_list_lock' */
+static unsigned int shrinker_run_no;
+
+/* protects the mounted 'erofs_sb_list' */
+static DEFINE_SPINLOCK(erofs_sb_list_lock);
+static LIST_HEAD(erofs_sb_list);
+static struct shrinker *erofs_shrinker_info;
+
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
 	struct page *page = *pagepool;
@@ -12,10 +21,9 @@ struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 	if (page) {
 		DBG_BUGON(page_ref_count(page) != 1);
 		*pagepool = (struct page *)page_private(page);
-	} else {
-		page = alloc_page(gfp);
+		return page;
 	}
-	return page;
+	return alloc_page(gfp);
 }
 
 void erofs_release_pages(struct page **pagepool)
@@ -28,10 +36,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
-/* global shrink count (for all mounted EROFS instances) */
-static atomic_long_t erofs_global_shrink_cnt;
-
 static bool erofs_workgroup_get(struct erofs_workgroup *grp)
 {
 	if (lockref_get_not_zero(&grp->lockref))
@@ -171,13 +175,6 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-/* protected by 'erofs_sb_list_lock' */
-static unsigned int shrinker_run_no;
-
-/* protects the mounted 'erofs_sb_list' */
-static DEFINE_SPINLOCK(erofs_sb_list_lock);
-static LIST_HEAD(erofs_sb_list);
-
 void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -264,8 +261,6 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker *erofs_shrinker_info;
-
 int __init erofs_init_shrinker(void)
 {
 	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
@@ -274,9 +269,7 @@ int __init erofs_init_shrinker(void)
 
 	erofs_shrinker_info->count_objects = erofs_shrink_count;
 	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
-
 	shrinker_register(erofs_shrinker_info);
-
 	return 0;
 }
 
@@ -284,4 +277,3 @@ void erofs_exit_shrinker(void)
 {
 	shrinker_free(erofs_shrinker_info);
 }
-#endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.25.1

