Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E41322669
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 08:31:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl9jD0Cxmz3cGJ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 18:31:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614065504;
	bh=JJWnQSPoY6vJ4o+0Hz/raRTPPLOMh3LiL6XmBSKftw8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=YSe0/euOJpfvkOBufMGRRZXJvNuq10Eq7PylH1aPAWZBuvfDpmaNPXNbb7IzAEJ8A
	 ey1Zckt79MkU4JU20r2MiWP07Ciud9Tk5R422k7xCBWD9JqUuh5rJzUnxNGhbGmL6U
	 r63QREacD7hk1Eoy28Gx/mP3wLY8ziJiYEU2frEqodIdW8XgMjnra8h4zqNhANdS0t
	 EbOryo/eOVjkk+fq429olkaXXkS5yfUm82pMENOhJc4LIV7apP17KISot/Y6oOIoqE
	 AetXlpKIWRp3RacYs8aGgDblPsjsSi5EA3G8z2HLIUXQXeHv2DSu9BXPwZDSFxsqFf
	 Y1Ma3I74H417g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.42;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=jad0mVyY; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320042.outbound.protection.outlook.com [40.107.132.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl9jB0gWhz30Gn
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 18:31:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMrytBV9LsvWK1jST4cq29T8g3t6YaCoiU7gz7+6aayibboHFtoLSaL2jPFTP0eszzpYCiB4iM/2CUNHkHUVQnRl//pnYxakKwSECXpb2uF7k+q6EzqoZRG79EQm8qo3pOeH4rCw75hJCXbObrRmTNTLAVKTgafGnjyDY24HlfwH9w2W4uoyl8GFH/AOIuzwZ75oQkqx3gYf6QaRdUzd7yPF055AOKl5PoWpettHg0EjwGEBnmr43aXI2hcUc/Up6J34Nz2qjQDwpdgjsCNS6C8KM6KkR4IyTSXHGBZiWd52apSbHU0unFjNQCzom8rDKdORZaA20fam51RuKFWPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJWnQSPoY6vJ4o+0Hz/raRTPPLOMh3LiL6XmBSKftw8=;
 b=l/S52iiAKLX+bI6Kau7L5s3Ycc4O44ClW06T7lJ77BfeXiEqV+FmnZEGBr2uJsziQtm6kQwfHSmqspfZ6DFV8YTWnjRhG7lKhAOycoqABeV/8fwo7YtSJ7XhmCjw9NVfbxzG8MV+elnnw1MXQ3yiYy3lIkeg5F8PLWqhj9wZ6K3dtp+kcfLTb6aCgNlpOOVUB4zHF+vebcj343OY/CdP+6rV5kbjMBwM1hHDCRQ1VQCdvQ2s1k/WXTF+pUkZWJT+01WOxCR+P+1DS4lD/SOGh6EO9OREvUsL1GOLvAramaqq8pH6W1yzfcSTaBTHTHuRplGfkzgVxkBV4gBc5uGzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3114.apcprd02.prod.outlook.com (2603:1096:4:62::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30; Tue, 23 Feb 2021 07:31:31 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 07:31:31 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs: support adjust lz4 history window size
Date: Tue, 23 Feb 2021 15:31:19 +0800
Message-Id: <20210223073119.69232-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Tue, 23 Feb 2021 07:31:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c32b237-fa82-4169-e224-08d8d7cd0a47
X-MS-TrafficTypeDiagnostic: SG2PR02MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3114EFB5FE7C9819FB3C1F32C3809@SG2PR02MB3114.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i50+opXKtR8um6ArntVYkAsjPnSCh559Vad75k/lNQ+a8Hxdi2sJnXdbbou7yDyR1MCLiAWon51MVKM0CrX+uJjxNXZxshM4/dba2wGUst0sa1zD2wSMT68Ms3P6KneoTD7mQikaGt7Hewd6HXKHnIFwUWDcaXgOCVuWhVz0lEwHqy+YZwqQ4pDtByIcQXv+b0tL8AqwZLmR2/Ck6m5x7gHDzlR4cERpNc739Yohx5vgbmIW+9t3H+t0ctiu9JAbDNy4APC1FJ5yE9zj5/WAm/hfWCT5ZQio+7xxpqq1pVLWIMn1nKI09KyWjNYf1TEP3oSs/8Q6BVLVAOPIWpjhitaS7nkquHR3bxmygyOKbrte5B031FkUpBPhbMP4r+bNprNzzOO0rz++FJVDrxIEzMShf5NR96ipSiw1XV7vQje5XUfj9bi09twAEujn4VX7BX94Z+d8U+eaUNCUMK4ochPb7CS+CoG7zS3jXZNZm2EBy6X6xgG2Za3N+CfTyTriTiVxEBALqst5CmksxX/FLi3Wzfu8rprnDOmNmQxKdv5oprwwSWUy+nxnrvPSNsMz0Ht5gtnbEBcc1Iz7zHxcE5FpCf9kw8DVnjXUTwdDLZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(66946007)(66556008)(5660300002)(36756003)(8676002)(4326008)(86362001)(186003)(16526019)(66476007)(6486002)(8936002)(52116002)(83380400001)(478600001)(6666004)(956004)(2616005)(6506007)(316002)(26005)(1076003)(6916009)(2906002)(6512007)(69590400012)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cPxBKrk9LAEOnqOGh8PVQgZCDfLKmph5rTYEOtR6adMgFsNbCafytlVxYJp5?=
 =?us-ascii?Q?JdcjBAJNZjdVxeB9G4HJTbQVbfwhPwiUvoaQykBZdgnBiDGaO6QIrDuLjapa?=
 =?us-ascii?Q?S9zL6zqBhaRVEdo9Dq7ANGYmOPaJQnELdHool7uUNJ3cOL4i+gcXAZveNb6m?=
 =?us-ascii?Q?LVB4Z6yOLenuu1SXY4e5zXj6/ySSNoLi3/mHz4ZAcguo1URsch0MuaAYP2Zx?=
 =?us-ascii?Q?yYlDq9V+HEshw9JFIoM4rGV881LGJB5DyQ06Iiu8bqs+vPnkT2koDM/WnSEM?=
 =?us-ascii?Q?JfQm8zMUZCFAmKA+srWpoRnRvu5PlnpNWr5zh//ApuzygBbE+vBLwXCTFmOt?=
 =?us-ascii?Q?pUOFYspqXXVSTJCJxN9OIoJ3YYV4o2AVsWFpxa3XOROHwEYmxtFtDsp2eSVE?=
 =?us-ascii?Q?oFwKlIt97TdM7Lk0fOIwihwwx1AOX5nYZXLMyJdPp9gUCDHlMdBQgRNljbZD?=
 =?us-ascii?Q?e4A/Ua/lZU4++/0MD1NuQA+TAhcozQIFfnt68D1t4eFWzrwxg1QkfbIoclBT?=
 =?us-ascii?Q?7Die52D1aT4nDSPDY1AYm/3tsl9/F1nKysZlhNUa8hZhznd3Ug1YuVpNr5HV?=
 =?us-ascii?Q?kOe9AQM9G44LJPde5WHljUbQPNtz9BajzScDkol7WypX91CGMjqkhD4lW5g/?=
 =?us-ascii?Q?7+9eg3wnxHcjmU8Kkb0CF9zwl8EtfRgxfwLNR1BkNkNRtK5+NHSJruQqmT5Q?=
 =?us-ascii?Q?54MApbkBeF5BMK+HHSLNGgjUiq7qW+bws7aokpMaPvPVioQEpmv9cWPbXXCi?=
 =?us-ascii?Q?m4+pPF9QGqVw8PTENYYgK3585Tj1kl5Cpc1b9hV6bcZUVzDWrWCnE89Lpa5c?=
 =?us-ascii?Q?twQ12r+QMTaKgYjX3Vwyrl0+Us9ZJcHIlwjVfKpeFwxCiLCo9jZpYQ2CSZl5?=
 =?us-ascii?Q?wKL7sN4effnAggIukK18wM5u9f1z50Moq4UQlTaZSdskP1ISfRKE40ifz8Du?=
 =?us-ascii?Q?ZfoXbYdptLBLmUN0Q3e96In4fs8wYsY2PXcNNw5SbIm3w762T/x0OFs24o8U?=
 =?us-ascii?Q?07cjGX5txzlDpwNuEONkcR7yU/k10LGX8grJcn0zxOW4QdOXBc7rFW6YUH1X?=
 =?us-ascii?Q?Km9dVsQ9x88WjLDE+E+3tiL3cFTOpzEoUAlrJf4hwTcZAk3yhtnZPSVmtuTk?=
 =?us-ascii?Q?3nyCkuYZjw5zm1fsD/UsTK6C87o+mYssKIJ2HGCL7KtxYIvHpJSKnq5vP1Li?=
 =?us-ascii?Q?u1taa4Z3vgV+6BLerT+WCf0jYAFukenDefOKVcAof75AXcr5zzpLwb7s6lM3?=
 =?us-ascii?Q?XgiZ+eFpeKBV1vdW2TJm/hrCXzjXu4adf5wj1hwDXZJd/IlFV4n8OqiRYh32?=
 =?us-ascii?Q?cOZDdLqkcR6oblWfCYbcjCwI?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c32b237-fa82-4169-e224-08d8d7cd0a47
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 07:31:31.6104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW/KZPNOZgnBbNybWanuqSPJDlj52XTulySI6eT7VtbSd1/HekqmhBiEBGkYClayGbdfpJ5CtYFBAuqWztgAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3114
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
using rolling decompression, a block with a higher compression
ratio will cause a larger memory allocation (up to 64k). It may
cause a large resource burden in extreme cases on devices with
small memory and a large number of concurrent IOs. So appropriately
reducing this value can improve performance.

Decreasing this value will reduce the compression ratio (except
when input_size <LZ4_DISTANCE_MAX). But considering that erofs
currently only supports 4k output, reducing this value will not
significantly reduce the compression benefits.

The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
we can only reduce this value. For the old kernel, it just can't
reduce the memory allocation during rolling decompression without
affecting the decompression result.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---

change since v2:
- use z_erofs_load_lz4_config to calculate lz4_distance_pages
- add description about the compatibility of the old kernel version
- drop useless comment

 fs/erofs/decompressor.c | 22 ++++++++++++++++++----
 fs/erofs/erofs_fs.h     |  3 ++-
 fs/erofs/internal.h     |  7 +++++++
 fs/erofs/super.c        |  2 ++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..0bb7903e3f9b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -28,6 +28,18 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
+int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
+			    struct erofs_super_block *dsb)
+{
+	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
+
+	sbi->lz4_max_distance_pages = distance ?
+					(DIV_ROUND_UP(distance, PAGE_SIZE) + 1) :
+					LZ4_MAX_DISTANCE_PAGES;
+
+	return 0;
+}
+
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 					 struct list_head *pagepool)
 {
@@ -36,6 +48,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
+	unsigned int lz4_max_distance_pages =
+				EROFS_SB(rq->sb)->lz4_max_distance_pages;
 	void *kaddr = NULL;
 	unsigned int i, j, top;
 
@@ -44,14 +58,14 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 		struct page *const page = rq->out[i];
 		struct page *victim;
 
-		if (j >= LZ4_MAX_DISTANCE_PAGES)
+		if (j >= lz4_max_distance_pages)
 			j = 0;
 
 		/* 'valid' bounced can only be tested after a complete round */
 		if (test_bit(j, bounced)) {
-			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
-			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
-			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
+			DBG_BUGON(i < lz4_max_distance_pages);
+			DBG_BUGON(top >= lz4_max_distance_pages);
+			availables[top++] = rq->out[i - lz4_max_distance_pages];
 		}
 
 		if (page) {
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 9ad1615f4474..b27d0e4e4ab5 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -39,7 +39,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..4cb2395db45c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -70,6 +70,9 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	/* # of pages needed for EROFS lz4 rolling decompression */
+	u16 lz4_max_distance_pages;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
@@ -420,6 +423,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page);
+int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
+			    struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -427,6 +432,8 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
+static inline int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
+					  struct erofs_super_block *dsb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..11bc51e488dd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -166,6 +166,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
+	z_erofs_load_lz4_config(sbi, dsb);
+
 	sbi->blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
-- 
2.25.1

