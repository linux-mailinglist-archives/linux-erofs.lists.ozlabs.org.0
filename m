Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7502E8360
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 10:17:27 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D6fYc3hLWzDqKh
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 20:17:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=outlook.com (client-ip=40.92.253.29;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huww98@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=UjZOH97y; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253029.outbound.protection.outlook.com [40.92.253.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6fYX2b11zDqK1
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jan 2021 20:17:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU+U9npIVv8td7FOVulFsdBrc+bqQCem0tEB5sxP20viZc0gezbwHlf1ZPM8qDK1i2yThM4M/OsSDGjTpsKN+JEAXmkR00KQzyWW12zB+bs7grwiNtt1vdMIdzovyAWFresH5yFJvBWFTXlAjf4lkatyuwrVxDO5jXdUNcxL9xDlegsWuaS5uPYoJE0up8sXIuCapIdvv5NQZZslFcEEkyX14qD3+3XOaz1MffNILF7ioB8yOslf3IkalbL5+B1HLTiroqVhELyx+c7eyi78MA+JeqYk5vpT6p675vkgsFQaYrbZfv1v4FBdtgZuqL/nIWSHhikooKpKjebboW25/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNIt7dDrRb02DWomKLN6SlwlNpG6pqKLBtTTKua7ElM=;
 b=aKGNvcF2AzJZb/HibOdrbJV8uG5+WvMdeaeqTy+HCd+1zDRH1cR95br9mqKMpSKG5nphazvnPou0yaJ9VVmkimUalZm/RjmtyY/mmmEeWQ4VqjIKazxbjue3/rDztX8JVGVInqLuId1Tp+/Sq9r4VFAwDPlT9XhWDXyytK4iVqZd4xTL1oR0HiEMpRmB6wDZP8aYHhLRCJHnxdDEjMGnb3mfdsx/TvV8aXQ2pJeugZdeMc1EjcuiOCBFc0ftGs46e03sY5vD+OpjMitRATwj1kHifHU2iGFHpLP2yIyD6zCbPBcobmVTGwbsn0e4SMOvd9I8AyOTafjjyC4GSlhiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNIt7dDrRb02DWomKLN6SlwlNpG6pqKLBtTTKua7ElM=;
 b=UjZOH97y7llRJ+J0T5NWummY3sKXZg3W6lcwa1rbrw4RypmPb2G9D+AMuXkTcuowErkTLFfE/kYLv0pxr7NRMHpcU9TVqvNbVOGhC8Qz7AR11MFOlFHe7CZERWijZoJNGz33jAXJ9LJjeYOXXikJcdaxTUN2aVXk2ZEGXTn2Bmyl+9Ib4W/8slUHX1BqzXsMKhVoie1ROy7ZDUFKJNUlKjXffrTr1k5fL6yurs1WE93YmfcGclnSu7P+aOgtgPt///f8QV4qA8YBZfGm/3LgwRbJU6EB9Pd3j+epgNzAPwvCF4LzHk7LNY97Edx2gn87gWEm8TJjA8snqojNPJjOLw==
Received: from HK2APC01FT033.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::44) by
 HK2APC01HT048.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::326)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 1 Jan
 2021 09:17:06 +0000
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebc::4c)
 by HK2APC01FT033.mail.protection.outlook.com
 (2a01:111:e400:7ebc::190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Fri, 1 Jan 2021 09:17:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:49799041DDE1103FABF329DB2042BC9E3308BC923DE62B4623924F263E420C4C;
 UpperCasedChecksum:4DF5FC4FE3B44E926E24AC32C428BCEFB2522B24357C7131935097965C21ED63;
 SizeAsReceived:7648; Count:47
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e]) by ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e%7]) with mapi id 15.20.3721.020; Fri, 1 Jan 2021
 09:17:06 +0000
From: =?UTF-8?q?=E8=83=A1=E7=8E=AE=E6=96=87?= <huww98@outlook.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Fang Wei <fangwei1@huawei.com>
Subject: [PATCH 2/2] erofs-utils: refactor: remove end argument from
 erofs_mapbh
Date: Fri,  1 Jan 2021 17:11:58 +0800
Message-ID: <ME3P282MB19387A6D70997B82DE981954C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101091158.13896-1-huww98@outlook.com>
References: <20210101091158.13896-1-huww98@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Sp88DXqa7YJld1o2KvTOlNvYrQhmrbN+]
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:a2::12)
X-Microsoft-Original-Message-ID: <20210101091158.13896-2-huww98@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-N4CECTO.scut-smil.cn (125.216.246.30) by
 BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Fri, 1 Jan 2021 09:17:02 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d1348167-629a-40c4-8de7-08d8ae36025d
X-MS-Exchange-SLBlob-MailProps: CaK+F7me6CkMFf4nnBntWC3ZhywmAFgdr56PQafaNxVQrpt4Dm/xYzQV8huFTkR+87r91XO0P8yGA0rS/gW1EClYEu+GOLdjspfokHwvummltxl8smP5hz0S4FzkmCqDRvUG+O+7W63mMTZrr5zU3aQDIH6FtZsSfj0g1Ue7bkAkLzwEp4XKwQJJmGqdzFnwS6V5HNgeRCjlpdSQy4Sg3nhf7ifGc/GyhFQtGLD+BAk/iljvjJUcIGcKxeUXmr6LWuR+NLVpFXe0OQ2nvzL2D3HUmZ3hirGMTIGlWXncTrBYsnTbb7i5WwYQ7ylLTBVftYZrB+IP5SCBVsuoXfdFmPwTJ6gnUNRJJGEYZHbMjZx5U2pAuSffmcY4fhW/1acY/lTSFj+ehThrH3RSYek5izd/qytecEXiENbvMUh78qFUex9YUbyEyK8ujqe0LPUNA3WD5pat4YfDqrFZfGTu3yG/DP2hbPoCjCrc+3ElPPfZKQgmNMhNxtdTL+EpLMitWLzRT7TQB/12BKVVCe/Wm8DKxnBq5rKsVv72Bm30NfJmb3sHDj+vgPFmCmEjcmYjkY4ywQTnjkJcW8f/5t418GjgvULGX/DcaIY6rxG0BTvdP4w6yhc7S3FQG2CUuVI9E0q4pd6jSQgsEYvi9AHMZUfYI1PYUI176GOMtbgP961j0DgdTDh+BE6UJpV+BAkHVxjA9LW1ZNG+deruxhGg0fRFMUQZVk86OOEIu9/Wwx/WtosBHqZ/gw==
X-MS-TrafficTypeDiagnostic: HK2APC01HT048:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W81vmmzGLgcKFPXqi6/a1+pKX7WFYV1qyB5YRmWEeVknMKqBTDdDV5LHMEe3bLCPguRn91XwO5mGMQQx2hD7yYu0MUKS1rDFhmi5cRCWv/hFX/e6WlINFheeRC54KsVFm0Rqqt6RGgfBHWBg9tMwALI2fXAAdm9JRiCAx6lT1pLr4ebsWboklI3MdMm+EVU4bFbX7PO1CI2e3auHoIy1bYK3AAo4VdY1gaLUxlv1oXuL7gMyF4Y9Kccp4UgvO29x
X-MS-Exchange-AntiSpam-MessageData: Bkfzv5sjBioz9ZsB/+WVyur/gz+onR2zKYe7LIKMPyU6l05cewkc1Y3SE5VNiTO4Xq/16hElCTRgx4atyt33oXKI67ali2Bk6tntWysYziYdzUl3VoqeLbdJwdHa3eZ5ynOrlQ2BcimtfjnZY+3X5g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2021 09:17:06.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-Network-Message-Id: d1348167-629a-40c4-8de7-08d8ae36025d
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT033.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT048
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
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <gaoxiang25@huawei.com>,
 =?UTF-8?q?=E8=83=A1=E7=8E=AE=E6=96=87?= <huww98@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Hu Weiwen <huww98@outlook.com>
---
 include/erofs/cache.h |  2 +-
 lib/cache.c           |  3 +--
 lib/compress.c        |  2 +-
 lib/inode.c           | 10 +++++-----
 lib/xattr.c           |  2 +-
 mkfs/main.c           |  2 +-
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 8c171f5..f8dff67 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -95,7 +95,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
 bool erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
diff --git a/lib/cache.c b/lib/cache.c
index 3412a0b..9765cfd 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -329,9 +329,8 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 	return blkaddr;
 }
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 {
-	DBG_BUGON(!end);
 	struct erofs_buffer_block *t = last_mapped_block;
 	while (1) {
 		t = list_next_entry(t, list);
diff --git a/lib/compress.c b/lib/compress.c
index 86db940..2b1f93c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -416,7 +416,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 
-	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
+	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
diff --git a/lib/inode.c b/lib/inode.c
index 3d634fc..60666bb 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -150,7 +150,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	inode->bh_data = bh;
 
 	/* get blkaddr of the bh */
-	ret = erofs_mapbh(bh->block, true);
+	ret = erofs_mapbh(bh->block);
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
@@ -524,7 +524,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 		bh->op = &erofs_skip_write_bhops;
 
 		/* get blkaddr of bh */
-		ret = erofs_mapbh(bh->block, true);
+		ret = erofs_mapbh(bh->block);
 		DBG_BUGON(ret < 0);
 		inode->u.i_blkaddr = bh->block->blkaddr;
 
@@ -634,7 +634,7 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		int ret;
 		erofs_off_t pos;
 
-		erofs_mapbh(bh->block, true);
+		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
 		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
@@ -871,7 +871,7 @@ void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_buffer_head *const bh = rootdir->bh;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
@@ -890,7 +890,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	if (!bh)
 		return inode->nid;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
diff --git a/lib/xattr.c b/lib/xattr.c
index 49ebb9c..8b7bcb1 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -575,7 +575,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	}
 	bh->op = &erofs_skip_write_bhops;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
diff --git a/mkfs/main.c b/mkfs/main.c
index c63b274..1c23560 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -304,7 +304,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
 	char *buf;
 
-	*blocks         = erofs_mapbh(NULL, true);
+	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
-- 
2.30.0

