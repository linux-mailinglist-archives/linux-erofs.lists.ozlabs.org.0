Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30A4CB53F
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 04:12:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K8GHL0zfhz3brJ
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 14:11:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646277118;
	bh=RahX0oLQn7QsM3oAzU4I7iSskiGBjt2iKyXMDQF9yRI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CnN+lVZZ9GhQs4qCGwiSCov5e9N3xQmjwvWZRPki0PHyhYUIS7sdsdQfZ6277bE8N
	 7uwk/tA9JGxjNXPcvwwZf2kelfnSK+u20VMmOtPuEZSjXC9TDU5JpLau+lGF7Tim6g
	 F2mazA0+OcNcewGw/HbFTI2PEK+ojpeQQltmdlWp0DrOiAMBuMFyDP7muvhELBXUdu
	 YodrPHijM0XkdlQsAhTlpTOCIFPnFB66NSND/jXKfocgupt8zQVV4cjErh/DnkCxT9
	 xJomuoLeh115CuS7U6atX+cFTjpfFJmCbQaFoF/rU5n4NxWvfKBhvQg2iWQaMZpmF9
	 O5+0GqUlXc4Tg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febc::62f;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=jhXLgfx7; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febc::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K8GH94mWKz30Qg
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Mar 2022 14:11:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laOkYyOOVPzI0h6hIts11dDiGPjkDzNqio+nmC3ULdVDKm/rjsTofhlbGc40Rax/EdwXyAef8Dmb1w3Izr8Xyn5ImiPSKPOr5g7M4XP11W2ju2QS7Zv8B3+2cIir9VDkXp7zTzRGP5THNSNB/cwIdaQvwziMN7cyZbfVP7pGaRXB1kwnfyFMESvpxuAJ3kGHzYOhjkVnHoWkiXJ3iFFO+UKCuLEEx/lgWcdPJkivQ+2fk9zDmeXTL28ae9hUA7wzcF2HTCk/KqJkwgkmEpF3YFAw7DTsnjtUn3bUtRnRvicBPw6uq4W1es74VbDVAGdGi3fzuqiYvmdWNzQItJQZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RahX0oLQn7QsM3oAzU4I7iSskiGBjt2iKyXMDQF9yRI=;
 b=ASJROjbPz/+Vn7CuJnhBM+YxzXEtNGUZzMlVDvheB8Ny8m/XlT4ab/deKUMCDcBR+3RegH4+yJ9iEWn39Zya6+bSPTcfpCmlkINxj7ITiQXmzL1hNlr5JN32Sk4B4vf52dYnfEpwg6gYyBAx1v5iTRMqQugSOU33OEJ0i3W30mksArKYuXZAWbiEyH8xlQv0FkCwvo6dSqYONFcGjA/fSudMq3EBKHjDlSLP4aVkZKy3WkCNBBaODgcp7QNtTgapPC/h5wUfwQLAFv6I5u+GCnUxnU7R74WzR5xmOHR0o32zdqUK5Icu5CHGqpvSc/1xCNMOk5lDmBZj3NbbvwjWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 TY2PR02MB4064.apcprd02.prod.outlook.com (2603:1096:404:f8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Thu, 3 Mar 2022 03:11:16 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3997:a3a3:5d7c:31bf]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3997:a3a3:5d7c:31bf%6]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 03:11:16 +0000
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: fix some style problems
Date: Thu,  3 Mar 2022 11:10:55 +0800
Message-Id: <20220303031055.2433-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YhXiAg7BlhNqQDBe@B-P7TQMD6M-0146.local>
References: <YhXiAg7BlhNqQDBe@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0680c343-7c19-416a-3be7-08d9fcc37afb
X-MS-TrafficTypeDiagnostic: TY2PR02MB4064:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB4064696CA6B3B2D0A17ACFEAC3049@TY2PR02MB4064.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5TVmbZEJSWn/iIIE5gI2vzEXRcuNIL7fDZjj+vRFhiMebWbZkG1uhtXQHQ/daSZPbIk7FxJtu+HJwOWSJvt6wGiW95yaoQpprEc4vo3j6bbLCOsq0zWhVwMjTKS8qH7qYXlckZv6Gizg94G89gnj/6SZ8vjCsJpFMbFs+7QAVofTZf3QD6hoONGcQtsOlhH78WZVPGLWQeD+0DJnDznbrNdu7Jg+4biHABzt/w/2H1LRWRBY7IJfA7/iA5SSIOdXZS3f/h9eD9x0hMNy6jCWsYW/bXcqTv38d3tmMJAq5ax6o//EotPjsifgnrH1Czdsxy1ayYDWa0g48NYnIIpMfMEZKzZKu0S9bcwXcoeJ8auC+zFUh5FOkNY6ejnajcInG2wDxl0ZIWpa9lHvtzivLJc0P5iXgFuBZBu9TtNfkwMvzOt9sVhuIfJ2fkPDbulVL72UBW1VU4IcNYbslpPPELhR04UJ+W7ek01RDfc0lazn7ESfKvOsGtaKc6+PUHImuCPR2SPvH2d9pBApMxTvOXoPHnwtX2Y0k5LJ7geXXJNIdJPpbUqgt8jmG4y6jNbRNk9PzQrIlauPNrFVI6t4aSajKKo1PVjVCiiLvOQg2PpPVvsCPgtnccZfcWbExECuF0PhH7kIHw6XokF4owI1Ys+lQazZc5ezRiZBC/ZvYwy5Rx288hDpE8mzijoIqoqCo9/3CbZyVc0z7VWoZ0HvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(52116002)(508600001)(66946007)(66476007)(6512007)(8676002)(6506007)(6486002)(6666004)(4326008)(107886003)(36756003)(316002)(8936002)(2616005)(38350700002)(1076003)(2906002)(5660300002)(186003)(83380400001)(38100700002)(26005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ub+K9+mTMMhDrEqNoeywtnofIxyhX3en3/z8zjyY/hILtXWM1YhsT1CIjAqX?=
 =?us-ascii?Q?oUWp6LS5xlkzMSLpbOQsEh15HhUerLaY6vVDfGV9T3ti3ruuXqzyKiIggfvs?=
 =?us-ascii?Q?goHFv9McGDzpHr8msRTOXTKsFZi+7fm9swFQnix3abXPD8U/oxZpvbB2ZB40?=
 =?us-ascii?Q?9HQfekQPB7KEBtJmB3b+p9XtrwhIBdVx0+JT2nK6O0Y0yCVqeOuhWvVU1iGq?=
 =?us-ascii?Q?fheD7nzRspYeBUhqEwE3bl5M5bHcHWi8UNgXNNvgHRzH3oSzOHzR34TgepeC?=
 =?us-ascii?Q?whMNmPLDVJiQFNBY6t8YZCy6w16nWHfLYnoKDl/w53qNRmV3uaxIjFrs35ef?=
 =?us-ascii?Q?pIpwAmI4FnnFHMTTD2gXlq32qHyZgrpLzjSYp8B+fOiY24m3lbcrBR1SLxw/?=
 =?us-ascii?Q?ifGSu8tWuqvGd7z+D45tH6onu5N1F3ukTRCFTfNmJ5m7gDuZKZXv6TDg2ti7?=
 =?us-ascii?Q?i0+UDrtyxsCUutMdhD9MdRfyVBthufU7riUNtibX4EpmoK/ZAVUuI/G8ZRAY?=
 =?us-ascii?Q?qGUVYNYzFmLxp0DgrNz4ZQQlsUmEkAUuEZPJx9oaE0hyaXgf1IvK39uCMA/d?=
 =?us-ascii?Q?0xoPZM0CWygxqQX/bjkdwJNAa5PgtdwGJHKSR1eFoHo29UtmBOwFUEg623n8?=
 =?us-ascii?Q?/ZQVTNGnRKAKJP6w8Mg09z0fl+TZy36OKnLEMSEHr7IEcyGS9TYTgSqZk3uv?=
 =?us-ascii?Q?E4qGoXo3GvW6vsMYO7pfV/9HZszhHxXfFiP+sZJIrPCfAd79iMq1iJDAlbob?=
 =?us-ascii?Q?iNjQH7Fpsgn23nrULH3kI1Qrbc7JYYpQtJm+oEJ4VFuNX/sDPIehkrjfy5hu?=
 =?us-ascii?Q?T/ltsRqjNh83O+gA7jromC3K7SWlJgQc0UgHPB67h23YkXSUQz87R6UYdH+A?=
 =?us-ascii?Q?9fi6ON2JoPhr0A2aU9oz18XP4+kwCMn+XBWc2sLJJr8B7QQhpJBT6k5DR9aL?=
 =?us-ascii?Q?niHbutLXt0rh4N6zBnpJsWljNfnNstc80vcRRPjkm7KYwH6yY+ywovsJ3SYT?=
 =?us-ascii?Q?jdN9/80tcaQsEbmzGP9XB8YMDgrTSlrjz5Nh66waFy+pSQEvbBGgCysSeq+q?=
 =?us-ascii?Q?+PHKc4ptECK7N2qrmNRap+kap65MzgXVlxr9ENVtd/Rhn7K8W1ZLNFvwOXf5?=
 =?us-ascii?Q?n9ku++c8qDzufPKrZVLmgArsE0unyKDcvlfHwh3e8fYAjUI+TC0v5IhujnL9?=
 =?us-ascii?Q?omEySQGV27LrgR58u9hyeHjRjQ2XSexTQc/m70TdcnECK3+IVFFfRbQ9+xsu?=
 =?us-ascii?Q?eo2bZ5VafytaScfxkEj83L4T26TZKNvO9xTZ7YxP/17y3Nt4bSJuK44MibcI?=
 =?us-ascii?Q?8XCp92drnZfJRHYMrQRdTEI7R5L3j8P2CVSVBhW74KfSHa3w4Nm+YAjomwUL?=
 =?us-ascii?Q?8F/VJT9AcCXX8Hs/R87V/fLh0JJbTb4nrX+JL3W0LK7b/WhAdqUbTgxmKILS?=
 =?us-ascii?Q?GdFMnIyvRQxcYeUnMZlmo+sr/rVrUtBw3GyWyP6SnZ+Su5DjqR2rBwz3CCsq?=
 =?us-ascii?Q?Rl8fHtcJ4tBYmPEBrkcdyyJGOToUZ1vrVObkvy1HJrEq8ROF+0ogNKlepkOl?=
 =?us-ascii?Q?uiKTNem39yfmYuiZ4Cg6m7tBgo6uUUQbYcsUVZRDomn5rVBoymx2smhUPZCq?=
 =?us-ascii?Q?o6Twq0NMgnlFkf8uO2h4s1A=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0680c343-7c19-416a-3be7-08d9fcc37afb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:11:16.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ7kKfoE3J9hVK3SNziDDf+403C03M7hHiCkj9966wbfYspwrp20Tx6WNhFYUtjuLIJGCgkefT98Rq7dZ+MsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4064
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
Cc: zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix some minor issues, including:
  - Spelling mistakes;
  - Remove redundant spaces and parenthesis;
  - clean up file headers;
  - Match parameters with format parameters.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
Changes since v1:
 - Removed modification related to alignment format;

 fuse/main.c              | 1 -
 include/erofs/defs.h     | 1 -
 include/erofs/dir.h      | 2 +-
 include/erofs/list.h     | 1 -
 lib/cache.c              | 1 -
 lib/compressor_liblzma.c | 2 --
 lib/inode.c              | 2 +-
 lib/io.c                 | 2 +-
 lib/namei.c              | 1 -
 lib/super.c              | 4 ++--
 mkfs/main.c              | 2 +-
 11 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index b869a00..90ed611 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -61,7 +61,6 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 #else
 	return erofs_iterate_dir(&ctx.ctx, true);
 #endif
-
 }
 
 static void *erofsfuse_init(struct fuse_conn_info *info)
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e745bc0..e5aa23c 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -61,7 +61,6 @@ typedef int16_t         s16;
 typedef int32_t         s32;
 typedef int64_t         s64;
 
-
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 /*
  * The host byte order is the same as network byte order,
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
index 1627d3d..74bffb5 100644
--- a/include/erofs/dir.h
+++ b/include/erofs/dir.h
@@ -42,7 +42,7 @@ struct erofs_dir_context {
 	/*
 	 * During execution of |erofs_iterate_dir|, the function needs to
 	 * read the values inside |erofs_inode* dir|. So it is important
-	 * that the callback function does not modify stuct pointed by
+	 * that the callback function does not modify struct pointed by
 	 * |dir|. It is OK to repoint |dir| to other objects.
 	 * Unfortunately, it's not possible to enforce this restriction
 	 * with const keyword, as |erofs_iterate_dir| needs to modify
diff --git a/include/erofs/list.h b/include/erofs/list.h
index 2a0e961..3f5da1a 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -110,7 +110,6 @@ static inline int list_empty(struct list_head *head)
 	     &pos->member != (head);                                           \
 	     pos = n, n = list_next_entry(n, member))
 
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/cache.c b/lib/cache.c
index f820c0b..c735363 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -331,7 +331,6 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 		return ERR_PTR(ret);
 	}
 	return nbh;
-
 }
 
 static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index acf442f..4886d6a 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
- * erofs-utils/lib/compressor_liblzma.c
- *
  * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
  */
 #include <stdlib.h>
diff --git a/lib/inode.c b/lib/inode.c
index e680b23..5db4691 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1108,7 +1108,7 @@ fail:
 		d->type = ftype;
 
 		erofs_d_invalidate(d);
-		erofs_info("add file %s/%s (nid %llu, type %d)",
+		erofs_info("add file %s/%s (nid %llu, type %u)",
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
 			   d->type);
 	}
diff --git a/lib/io.c b/lib/io.c
index 5bc3432..9c663c5 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -370,7 +370,7 @@ ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 	ssize_t ret;
 
 	ret = copy_file_range(fd_in, &off64_in, fd_out, &off64_out,
-                              length, 0);
+			      length, 0);
 	if (ret >= 0)
 		goto out;
 	if (errno != ENOSYS) {
diff --git a/lib/namei.c b/lib/namei.c
index 97f0f80..6163238 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -144,7 +144,6 @@ bogusimode:
 	return -EFSCORRUPTED;
 }
 
-
 struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 					void *dentry_blk,
 					const char *name, unsigned int len,
diff --git a/lib/super.c b/lib/super.c
index 69522bd..f486eb7 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -15,7 +15,7 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 	sbi->feature_incompat = feature;
 
 	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+	if (feature & ~EROFS_ALL_FEATURE_INCOMPAT) {
 		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
 			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
@@ -87,7 +87,7 @@ int erofs_read_superblock(void)
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err("blksize %u isn't supported on this platform",
+		erofs_err("blksize %d isn't supported on this platform",
 			  1 << blkszbits);
 		return ret;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 282126a..0724212 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -204,7 +204,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
-				 long_options, NULL)) != -1) {
+				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
-- 
2.25.1

