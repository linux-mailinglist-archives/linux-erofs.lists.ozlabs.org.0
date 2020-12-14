Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D902C2D995B
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Dec 2020 15:05:11 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cvjnx0vglzDqNr
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Dec 2020 01:05:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.83;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=VlXPbLx/; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310083.outbound.protection.outlook.com [40.107.131.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cvjnm2QNjzDqN8
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Dec 2020 01:04:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffnlTqEY4b04mEWTWqt72l/hPWLEuPg43cCD0yaqR2X1Jzsp/8UhWumzeQerrf9W13/u95YZu5wqjDxNiSeZrNj2YW2jDsNAMgfC+Z/9tUmZWodVG3rMVLSP/cazij5TVusDTAtVCHtTZXrsByCR+OG8QeXLD7S3sRl70+b+bi5qZYRCYLLHxMeY739dc9PfR08Pbbtz8CUlZ3vlBlfWIGtaNPcTR2OZEwKa5DRCroajaqpDzUizrPLwsp228uUnnHjThgP0wFRkrP1b/c8fQRVOvsr6LC7Oz6ydYY7NX+mFZQKYe984QgyKAAda3EFG/3lado+JDZP4P24aExmMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SwaGsWMYxPzlgBHyGoYfcVweHnSNasWoaem5+DyvqE=;
 b=JNOBbL9mB78iNgblnQopb4DGvXwigUf+l2uwILrC15GkvN5rWfHgvVIaXrLPhDIQnCztUAXrOnw1I6L6mNzuQBvovz9R5p4q00fD+42K2N3Da9u8XizGSiFbqcdhFrQ+w+8qkYj7JCyLwICKPkimQp9lpU/Ei8wpM5SVlNjPWRUBgXwuv4BUGrhtSSV6Mt8qZyhL2OWA5tiv6nyOzqfnoSYB3n9Sxl+Fu6YLIK64vrOHvJ6lFX2Ko7AO8/Ocl+PKTA4/tfH/CyyUBo1I6P9K+tbsixJvJ3ar6J+fH7jt0EesIjpmdWCtnlD2VtqHNrwRT98v+yzXxCik6l0hmKmdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SwaGsWMYxPzlgBHyGoYfcVweHnSNasWoaem5+DyvqE=;
 b=VlXPbLx/1F/IgBRnET1smTzKIpmCkZNr3nl2P9JcIsbx2gReOdoQEKNPBMLiSa/2C/mH800w46CKZkpa9dnbH6XsANNyTy6VWipU7HCw1fJMcddC6YszWg6haOr6pEEM9YWQAW7v4ksqy9CT4k7ue+wwvOFepbpuZs2ORk6AVCQ=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2206.apcprd02.prod.outlook.com (2603:1096:3:4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.14; Mon, 14 Dec 2020 14:04:49 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 14:04:49 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: support direct IO for uncompressed file
Date: Mon, 14 Dec 2020 22:04:27 +0800
Message-Id: <20201214140428.44944-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR03CA0112.apcprd03.prod.outlook.com (2603:1096:203:b0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 14:04:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78157b6-c4aa-4efb-d9fb-08d8a0393858
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB22068DAA951E9A9DC70FB627C3C70@SG2PR0201MB2206.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyuX8K5s5/v6LjmfpyoudoVN81gSgYQYhqagDfkncHdo5K6MBEvjk40vwyUR8EjKRfDVyZWiQpUDXcuHlDWvF3ql1VoXTP/9gS8IyrG1/DoIFCxrqfV81LLGmVOKB4V5tU5LnuGb+MZDf4nfh2FV/H9B4fRrkhZJs/XIVsYZkkpfukQ4huqvk/p0wc94Tzcghp4RWcy79Ce6NTBj/NnFFrpuSvJFmLWseOCorCvgbaJE2YQoqWHyz5t2i5yZTyB0BErelB4F3VlvywQcsoQn6bk2y5T3UxsxN0bpsREuk6G0r7osTaxEM2KTppDbmsAsvkPsXTq3ylt8cPsvisAXu/V5hf7axBGcREKzQx+nht71ThhKq8LaijvCvrYSbaKQAhaBCmqDZ+9ViBJDhpmWCYl21q70Eui6WH53JxaaTtRC4eV58FsmdMfQcROBFrsSXQ3bnd/mWzippI/PoFTtTx3mhAtkJEnMW1gGVSZkuUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(1076003)(186003)(4326008)(69590400008)(86362001)(36756003)(6486002)(52116002)(6512007)(478600001)(5660300002)(16526019)(6506007)(966005)(6666004)(2616005)(2906002)(8676002)(66946007)(26005)(66476007)(66556008)(316002)(956004)(6916009)(8936002)(83380400001)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2ho/cmak17DwvJifexKPGAlJ+yI1MMF65qHsLynFg+R6nq5E2JwLgQISvMC+?=
 =?us-ascii?Q?K6tiyh0qVSpnCP/QP6LU4ZFySDXqCv/qlAWASj6HyL18iZj4CUzrX8gb9ugd?=
 =?us-ascii?Q?y3pgePW1OQOw/vVyApIsHG24bR/C+3z69MtSidBASLwpvPGoprCWhahC+QWn?=
 =?us-ascii?Q?sv4XLTjRb5FoXMnIr8N+L2CO/378+R1wismnkt4ubaWaoN8ynspcXM9/r0vU?=
 =?us-ascii?Q?GjfA2tCf65SiXbI/3nR7jbraOH+91x/RepbGvzFIaUjwvip3rw9lsmcJSpj+?=
 =?us-ascii?Q?rP401IcD2kP025XUqLoMJuf1SVhEqgqtiD2fvBEUEWieuiGIf+Uvp1nBvZSW?=
 =?us-ascii?Q?pSC7YcciJQ0QeoIZE6UYxBx26SQ2FpPKsFyJp0eF8Q95+U7+ELYq2q/SObya?=
 =?us-ascii?Q?kSXBklefybhKrzUikdSyuu24tY+TXB5iH57BPFfQYk2cXWYy3qlbvuMZW7yG?=
 =?us-ascii?Q?Gja+Q4lZ44emnG+GM8RpHfg2heTNyEiklLCAd8/HvqR8RvmCEb5iTFG76/X8?=
 =?us-ascii?Q?HsQ0nPmqam9lYnhsiEZG2S0ifgHQlfRay5bm5lW1j+OjRaMrhrIIUNhuVUoD?=
 =?us-ascii?Q?HL/vbsozZS1FeE3YzDG5iFT8TXynmYEKAv8R4xwCC9Q6cPkCaUJUXFP5WEjY?=
 =?us-ascii?Q?uiEJOw6vlYmlWLnonV97AzlWPq+XQSEOLX2MgQPVQSe24ol09EIzgRtQkzR+?=
 =?us-ascii?Q?Su1Rh9ITbQAgmoe3X9S7cZ7OdcddxqiJLKv7nXgUIJA6CjvSzjR9aTQmVFki?=
 =?us-ascii?Q?zUO/E0T2rS+Baj19nMZYuPUsjD2M3AqmkHyLqOUrH/bLPCV/qXy1ACMJrIRT?=
 =?us-ascii?Q?s8NiRJWSlCc7odH++seqSeu7wQYs6Xt2GULuVwnTj+i228qafmAGj5RYwvG5?=
 =?us-ascii?Q?23qYR8IU7oJQzz7TAMF0p6G4uJdqsGKOcQ4Wq7BgP8QiTiAGRkt5VEUa6FFE?=
 =?us-ascii?Q?7C8WDGuwSwqOB4Cli58n5Dmm8XEl539PDcfnKV36a8Y=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 14:04:49.0513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: c78157b6-c4aa-4efb-d9fb-08d8a0393858
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmgJ/onBbhN/h1MqrdqBJOj0OXQ/33iUf7aLQjIRrCyxjlE1Z8Pi77Digm9B5eXjXEXBfPNzHagtSr1/h4toKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2206
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

direct IO is useful in certain scenarios for uncompressed files.
For example, it can avoid double pagecache when use the uncompressed
file to mount upper layer filesystem.

In addition, another patch adds direct IO test for the stress tool
which was mentioned here:
https://lore.kernel.org/linux-erofs/20200206135631.1491-1-hsiangkao@aol.com/

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/data.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ea4f693bee22..3067aa3defff 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -6,6 +6,8 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
+#include <linux/uio.h>
+#include <linux/blkdev.h>
 
 #include <trace/events/erofs.h>
 
@@ -312,6 +314,60 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 		submit_bio(bio);
 }
 
+static int erofs_get_block(struct inode *inode, sector_t iblock,
+			   struct buffer_head *bh, int create)
+{
+	struct erofs_map_blocks map = {
+		.m_la = blknr_to_addr(iblock),
+	};
+	int err;
+
+	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (err)
+		return err;
+
+	if (map.m_flags & EROFS_MAP_MAPPED)
+		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
+
+	return err;
+}
+
+static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
+			   loff_t offset)
+{
+	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned blkbits = i_blkbits;
+	unsigned blocksize_mask = (1 << blkbits) - 1;
+	unsigned long align = offset | iov_iter_alignment(iter);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+
+	if (align & blocksize_mask) {
+		if (bdev)
+			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+		blocksize_mask = (1 << blkbits) - 1;
+		if (align & blocksize_mask)
+			return -EINVAL;
+		return 1;
+	}
+	return 0;
+}
+
+static ssize_t erofs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = mapping->host;
+	loff_t offset = iocb->ki_pos;
+	int err;
+
+	err = check_direct_IO(inode, iter, offset);
+	if (err)
+		return err < 0 ? err : 0;
+
+	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
+				    erofs_get_block, NULL, NULL,
+				    DIO_LOCKING | DIO_SKIP_HOLES);
+}
+
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
@@ -336,6 +392,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
 	.readahead = erofs_raw_access_readahead,
+	.direct_IO = erofs_direct_IO,
 	.bmap = erofs_bmap,
 };
 
-- 
2.25.1

