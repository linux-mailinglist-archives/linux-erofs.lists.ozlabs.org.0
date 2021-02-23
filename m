Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDC3224EC
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 05:37:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl5qf4j7Kz3cGR
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 15:37:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614055022;
	bh=Tt36ULHsa0O1uR+O66VNZnRTBZ1eOHHKsHUyMB+TEqQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ih8TbHhD5HQcd6RlwyINjT9rEoTR7sSJReYkVZZtgL1EtQkKDi+ayKY8LWnFXoJQw
	 CHx6CCCDFfVlcpK1gEFwYGd5kQivoHlR1VKR8v0fXGSb8ZuhZ3i0HjVnYDZEp7UYmW
	 kuS3hGRNpsopLFnzYD32vHoVH/WTzjSpVUonf9edCIuSf+a/IwEJ4qqU2Hd9Z81TB0
	 4IE2p64+sLIKZNO+3RE2UQrdTB7dTNG3XYG++OQn6+sHSqcfBZYwm6y/EUgDf3e+Nz
	 V4N882Gn/uKxqhzAINHIZqmYDYXPniZb+6jJrfoJ7ecJ6+o+HGfCKEvLe1xutPHQRK
	 YGOwNfDA2O3yA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.59;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=NLcOQZ9b; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310059.outbound.protection.outlook.com [40.107.131.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl5qX0vXGz30Kv
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 15:36:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG066AlxlYZ8PIfm1uMPdv43f0WsBpVUCTTrs5dppnRp6zZ6R+tAegqv/JCDCsCQiQG6540Nt3t5vhNKYFiCo4/61/3P5OFjVnKwF2SJaXHbwGO1BlnI25HB6v0NiR/5xkMKgkt2uBmLILQX9SHwbJdUgUn+jdmOqyqD0T1Yo+jXpfs+PGi/bDUs/m3OzIy+JyMCOV4YzRG953qz/Pvh9VJOdZZ/pHHwxLqH1JLdnk1IX1EG6TqI07gRAL5khlRZUhgHbQIwpVNAARHmkfLyePqFDjYuTOm8P9n96oGuEC7hp3xHbwPLvRy8+/FiRtlzPgnEvJqQOrTmY37Y/q+WIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt36ULHsa0O1uR+O66VNZnRTBZ1eOHHKsHUyMB+TEqQ=;
 b=G02SIfotBA0G8yJXb4UIO8y3jG7ng9R9C8K/0C/yLuNTwHu54f+QdZmzlLm7BVtLPMusIALXdWVZJidQzIgZMUjQ2KOt2E7Ly7pVHSXlOfGLWrlRLCW24GT+4I2R0V606h4xcZyBJSYMADYZ/Dw/2vHn6nkTV3GKZ384PnMdLleFFbDZz0yn3ZpS9FbKZWLiIaPeTLENHdbFYmLbQIWSHnPRFtaZr2ScMRcQcVXOJQzV3u2nS6Qc8HOK3bSytashD+pVmeGzpBc2SFY0DKX4hOQKCTsOuHhlLZ1ixv37GzbdwHJVAhmbEPt58Mr1oNz1My7cBZfiiUQL88Bg40es1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3576.apcprd02.prod.outlook.com (2603:1096:4:31::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Tue, 23 Feb 2021 04:36:48 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 04:36:48 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: support adjust lz4 history window size
Date: Tue, 23 Feb 2021 12:36:34 +0800
Message-Id: <20210223043634.36807-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.2 via Frontend Transport; Tue, 23 Feb 2021 04:36:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efd3622-b998-4249-b52b-08d8d7b4a1a6
X-MS-TrafficTypeDiagnostic: SG2PR02MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB357669FBCB7ACC83DA72E4D9C3809@SG2PR02MB3576.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNIvVYWZQcHA9qQmVoGS9c6XSuGZmun72FBFP5xq68krzVoN5VkHkXc7HZFGteZ5nj3sRqj7TvhKZ7LmUqadFHKQ8SmvUBqfBUzooOpLcFiAQMrwEbnNKvHjagXn0cagtmVZd5bn/A2loPNCm/3xFjdvuZaNZV5AoDV7GUnAGGDhcWlAG9ZJFgBdjaoo0TKaenbFgldbmmGPWBywHtVzkBFAp5OI9lKWfnWtj7gtb2d0Ai3DO3u2kXU7B+Ljdne2RpBupvkKG9Phm33/KV3NSnV7VLrbiVpFTaw9T21C4RKXvUuITQizrOBzpWTAHF5ejGYSULBu/Xc1W0alfR8zuqwNBlPWgxmVaw2YDZdYwV9MpcVoNQI4hq5Fndb/K0jJHFIsrsxd69w5NX0h11wcIloVnAAOQ2OjWzEYGmDx9seMNsadZe8b/Up5arXbgmXqDlgQCxkW87zXtDelWNkEmXn535SS4bngxjSB6gw69PLEULC4oxVrwlgK2lhqeag8c6c2nOheg3GUepEgVFNN7K7uQ+5aGLU+86Qr4331NXfkLjsbRDTbZkqlwqvd1SRQKsDUlVmWTvZr0T53QG9Dki8Vmlx6bPogWkvjNd51kRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(26005)(6486002)(8676002)(66946007)(36756003)(66556008)(16526019)(8936002)(316002)(956004)(6916009)(1076003)(83380400001)(186003)(2616005)(66476007)(5660300002)(52116002)(2906002)(6506007)(4326008)(69590400012)(6512007)(6666004)(478600001)(86362001)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hkTiTmy6JHYs+YuoMcOHCP5IHplYC1Crwpjr/tM1lBNTzhaiK4aY9kOIfKpO?=
 =?us-ascii?Q?/eA90qm2nWKSzMI4sR/tHj0rOF0Mkv3aSK7bthR+jintMl0ljErv/Q5TQE+e?=
 =?us-ascii?Q?woSOfEKByw+GUzGERE9ejtp9ekeNqPsf/DtQJxxi7t5kgRiCLzuc4RcsxSw4?=
 =?us-ascii?Q?KKxWB0NJv8EB3HlLT8Ko320o9TWhoQ+n3xIe3E4+hiTNxnPkmWjgeg4AzucW?=
 =?us-ascii?Q?muFgkEl6r3HO8CV2jtCCBCFF9MXAH6Sok2dkQ96epXjej3t/nD3lZY5EyM2F?=
 =?us-ascii?Q?hjh/bWHpMKq6WQeEo1qfjeSt7JS4VCpLHVYkEliqEbzBUAH5dGqaGwy6RTQz?=
 =?us-ascii?Q?TgM3Rju7RCytPwfNPztvpVvxasIGQo6EUiNmeFOmClqpCYySJU8EgGADuTd/?=
 =?us-ascii?Q?3q24EWdmrB0I9+v8DLJ+72mj1IOimzUESAe9aiIfZQQLi2xQvOFh34aksW6t?=
 =?us-ascii?Q?X8NcdzWgofqleIcPGD9VLik6//S1FtWfEGaXj5CQotokX3PZGJRutZXtmeKx?=
 =?us-ascii?Q?cdQwpnQK41dx6GSFrX1kiblEFnBGuvAuKQufMRMwTc4LbpgxouTYnovZdR/t?=
 =?us-ascii?Q?i3qbITxaesiwLbI/UKwuYYtvQLAVoOx/HHDPVT53vrUQOQmAUKzMXyg8IBsh?=
 =?us-ascii?Q?L+9qLub+VWfXAChLvKujZB3ltaNYUFlgpelvUy5Y3pF7Xv4bdGi3ur20S5b2?=
 =?us-ascii?Q?kOPrGABMOOHxXJSmMP4H/qFuNs0LliD27bT+Rc8c38spTCk6PYd8zdAlne25?=
 =?us-ascii?Q?NcMkr0Mu07sck6mWYxduQ8r4irkEcPEjUXkjl0AFP+PUr/8NOYSCk0PWGJV4?=
 =?us-ascii?Q?7WYpFLCQQHxzSx4nGgfkeTIY9WrvFBuL4b/HNh3qxQieGf/J7UlmXzMvqPDH?=
 =?us-ascii?Q?+6CeZgtgMmFRvxvBrOpVegbUfA2iEpSDPSzxhT4H/p9rnZEaW10QdYfu512l?=
 =?us-ascii?Q?hdSNDuuWzwNG+25OSvrdpFiV5SzIYL8Q2DmiSuat3+FmR3t6LE266zMZtvjA?=
 =?us-ascii?Q?aa50CyMjEpPhAMxHZC442o7rfvSihXMy8ioiuSjfOgAGMc+LI6ooJl7qEc1Z?=
 =?us-ascii?Q?oUINnKyr763HZhhTtHbdEXkVEq9PhcBOJ2OlEQYARvUqGI9aF34jvO8nnrjv?=
 =?us-ascii?Q?K3lPR2IF0l4E8QUSwMkmJB/kOJ79xpNLcnvX0+UztVgjXf8RdJxaIc7ECgu5?=
 =?us-ascii?Q?XJ72QvXsjA9NSIQkQkbvIF0GGb13sqnPWKBIY0APXT3ikID/bfNenW0nm+88?=
 =?us-ascii?Q?VetXsOMxSwWv/BPnQTsbTO99rV6eks+JB62vCne0cFMNJv6sfhTpQ/j5B7pV?=
 =?us-ascii?Q?oXRmpYseq11HsaQyzMQNgmp4?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efd3622-b998-4249-b52b-08d8d7b4a1a6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:36:48.3514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XFVPoCW3H35WOg7FCLq0uTkBVmZEMdG14iLHeZAKnPkMB1DMi2GXhH9tWOvWix5nkRRSkasz+6851QskN1DZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3576
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

From: huangjianan <huangjianan@oppo.com>

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

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---

changes since previous version
- change compr_alg to lz4_max_distance
- calculate lz4_max_distance_pages when reading super_block

 fs/erofs/decompressor.c | 12 ++++++++----
 fs/erofs/erofs_fs.h     |  3 ++-
 fs/erofs/internal.h     |  3 +++
 fs/erofs/super.c        |  5 +++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..fb2b4f1b8806 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -36,22 +36,26 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
+	unsigned int lz4_max_distance_pages = LZ4_MAX_DISTANCE_PAGES;
 	void *kaddr = NULL;
 	unsigned int i, j, top;
 
+	if (EROFS_SB(rq->sb)->lz4_max_distance_pages)
+		lz4_max_distance_pages = EROFS_SB(rq->sb)->lz4_max_distance_pages;
+
 	top = 0;
 	for (i = j = 0; i < nr; ++i, ++j) {
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
index 9ad1615f4474..5eb37002b1a3 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -39,7 +39,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;	/* lz4 max distance */
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..7457710a763a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -70,6 +70,9 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	/* lz4 max distance pages */
+	u16 lz4_max_distance_pages;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..3a3d235de7cc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,6 +174,11 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
+#ifdef CONFIG_EROFS_FS_ZIP
+	if (dsb->lz4_max_distance)
+		sbi->lz4_max_distance_pages =
+			DIV_ROUND_UP(le16_to_cpu(dsb->lz4_max_distance), PAGE_SIZE) + 1;
+#endif
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
-- 
2.25.1

