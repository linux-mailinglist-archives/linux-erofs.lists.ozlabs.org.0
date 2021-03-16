Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9C33CBC6
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 04:15:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dzz2C5Krwz304F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 14:15:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615864547;
	bh=ZgXp6cImmI/oYsRO0imoH6qZI3L0sWMP600/FGBl+Gc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CPPyXW4TBoqiShhyYJN4jj2vTyBK5GcgdAlCNBpOpbekRwuBuKm9BcNimGZSKSbVT
	 EmdH5uh9NATHHPP5B6zoG38cy6qBq4iXix6Ny4Q6raSDiISHfLzcg6F/gfbBHoky9z
	 rNT32ja2q45PBUikioJkFpXKx+VfHLhI+7cNOA17qizcZQSWiQB5Av7ttV+s33SEK2
	 tFQVdy7BddUKwX8Fwp9DrdnjOcytQMz61NBPpwxh8/yCfzDa9HX0G5mKTnWy105t16
	 xSIc25dv2ruyWH1iZ5Mlv3hZVPWV6yOFRL6nsh8053QeyCVqzFljBluXIRWDpjPzcF
	 Zt7TRlQAy42Lw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.80;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=McEqcTWX; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310080.outbound.protection.outlook.com [40.107.131.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dzz2707qzz2xYh
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Mar 2021 14:15:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD8gLA/2rhBrSTNAqbuUyumMYt8vUReXg2o9TKpbFjpVFHjRZU9RKe/xsAbmZgTh6Rvau0fby68x24+xxRDmcfGKP4cJh8uD6kudo50S7UxNpP9RamvZPdbL2pAIqV53x37ehsHq2JBjcODrdTlGusdmKvhgfMyWYRSLDFJVju3ibs7kpweYk+lo4gI0/CzQg/PCBMJppmrFN1ilrk70oPEJ3QkQm9fQqJuqEIPCJ3xQ/p7+jXoRJxJgjTqjfSvcPmdEeOxnOiG9SvIo2WwFfVEIKvf6m9/V4wIQjXAwHuwV/N/taih4ydSFCuafdJaRVT8KXqDgKU9WCDhIB0WDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgXp6cImmI/oYsRO0imoH6qZI3L0sWMP600/FGBl+Gc=;
 b=VazP6RMfDlDpZPTmiPpONwGMvdp6iKiZU7CSwv20hRItdNGio4Ez8zPnFMSDKQ440ONBjLN/0zNb5wd0omUaTu8AyNKHMKIJMTRqytLIMrn4WZGZdl6fkX0eQD/9/gcPGqxi6dEUM086GbtAnW+mWV7BHDPP/7VPUSHd3vxegdosdkZPv2kG3Yui+aNyIWEOTThFRjQSimw+U+Sdu+TSAjaatMFBdzGHRadD5sx7ZXLUuFsgaJfnI7vhtGMgNJXlJ+Zx+Rk7aTCkNvJvhprgez/jqpLZwm9oLeA2+MBjWM2NVq9Er2XkAk40wsiE75lG6yur0Y8iKVbSvl3NJkX6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4458.apcprd02.prod.outlook.com (2603:1096:0:d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Tue, 16 Mar 2021 03:15:32 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:15:32 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 2/2] erofs: decompress in endio if possible
Date: Tue, 16 Mar 2021 11:15:15 +0800
Message-Id: <20210316031515.90954-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316031515.90954-1-huangjianan@oppo.com>
References: <20210316031515.90954-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 03:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 257fca37-8bd1-4f48-d33c-08d8e829c258
X-MS-TrafficTypeDiagnostic: SG2PR02MB4458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4458C2BD611881FC72DA89BEC36B9@SG2PR02MB4458.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UELCWaTbK9MM8j3KmhVMDt6NK0Z1YYdX/s/ZwyF4fD+eqKaYSyMb1eRPAW5xb/HEZsDD0k5PPfYSM0YdLCMQbJLRrF/Nboyi8W4XAXb/L4FSTR9T/VQQvTjsX0WcfXo/RNdiCmD1ooqv08K1SQ8SR7QmMpfGINx7aJ98M9DnJvvluiomjkARqTWW3igoAX+X5k/2ltd7o+APWQnysDBtJlPluJZ0RyNSsuQ5UV0F/QzK4EWilfBg2wnl1DHT6hxTDoQ+9YxgRNVG7pqZR79GI7/+Uiv+RdEQt0UltRohXi5d/zRHRh4ATPrEi4ZU10PkzVhZOzIyF/4DZwDAVhhUNlPRxofGAWA5mxsgNynU0oTEmx/5imGti9fYK3ukeZ3UpOiBFTOJgoeKslLqXUVEvmvYKJAe+ZTUjNxV2K3UkaXLCK4DWgCWRcuJ37S6o64rJVQa/xHBmsMRznDOyYLou2hnytXa3pj4DNSqjkf3i5SWb5NUAZBE2A/bLQXU8j0FoNVys5fj6d2ppNoprv/skycOW1GxSJNr8yn47TFgxHbynIbSi8UZ57YXuTSLq1AkKl2St9Mbk63uO46hA/4adX7B9VhB4NzxL3QIFTSBhOD5BT5tQnLrn8NbA/mEROMdJQJZsjntaCWFw0pvgH2Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6506007)(66476007)(478600001)(66556008)(6486002)(36756003)(66946007)(316002)(5660300002)(69590400012)(8936002)(4326008)(2616005)(1076003)(186003)(6666004)(83380400001)(26005)(16526019)(956004)(52116002)(6512007)(6916009)(86362001)(8676002)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Prlg+WT48+zSQEy01pKGJURpUt727NXK+zMnHbyaj7N3EMCpPAP5H9lX9F7x?=
 =?us-ascii?Q?t5aKZcUi5jpkXO8QiLxQFfhEMki8ei3rdkYmoY+3uIAjdDRd3lP7g6HlByjY?=
 =?us-ascii?Q?8QoriDefCQi5MfdmRiDm1+df8slGkCzIeefUN/lfuwUL8pof25Z2syTV6WNu?=
 =?us-ascii?Q?GQ/ZFDdGv5rOmli61BamccEj1owOEbSBZ6X2I5/2y5EZ9Xb/dzFCFglluKkb?=
 =?us-ascii?Q?U3O9miNgCUg9MaASZxYEpwC/KAP90U3p/dUJJtoG9ZVwGCcON86BPCGr2Y6x?=
 =?us-ascii?Q?dXUvwxVgPIHp5sxDJftOOGBamg3L+mcfhkR/l3N9RcPDNpP6ZB+wejrtx2MR?=
 =?us-ascii?Q?gmQWz6K7/EXWjJBU/5iI7qjinZh6CBvM9zr08bapnOmcrvOrLJDnjw7h7O1F?=
 =?us-ascii?Q?gapYisfkCACjSXvYS4s3YLS5biJCx6aLFD1ZGik/VTUqHEQxI4d0d9Cn04/Z?=
 =?us-ascii?Q?3sIqoqvWGn8N0aZhD7tuwesxKBQ3KINKwKxR1YKA6w2merCcZMKmewkKtKZ4?=
 =?us-ascii?Q?oIEZeso3pn7hourNgMhSIx/MKyngxE2o6sywYmv6NDMWUjwVsAIqwuxvCkkh?=
 =?us-ascii?Q?3q8x+Mj+5IC/5Lc9skkPLW5pPIUnPZrD+ufnjaO+cL3pI/IiViX/TgyG2DDe?=
 =?us-ascii?Q?dYtPzaCafjFzlBjzOMTTKungGoXZpF1C+s4xIfxo0pF7kCaP+lH6fLTuOeJG?=
 =?us-ascii?Q?L6fOBwWFE6BjPqdeYa8PXKsz7pT6f4Bn19nYrP77q2ul43v18jO1BGeiDHEg?=
 =?us-ascii?Q?Fl1wrjoiGzD4zZmCVY/WC/M0gk+4yr0MXZOFPQwS5Gmk4rL1vGdRpA+zyXnP?=
 =?us-ascii?Q?HheE52BjBuw0szG4ZAhMXaqgu8hssXuXp/YIMzTQteKjBOakZiTzyp9+W2Lp?=
 =?us-ascii?Q?GBycmmHCG+8TuJKYWyGqTDsPlgs6LxB1+Sa1wXQYo/0rUtQ9CKATObGptAZR?=
 =?us-ascii?Q?F9IlVQZAzvshN3aICFGHS5sUm74EVFRYVOYcprzztOy6YpwEDBW3ZYoVfREQ?=
 =?us-ascii?Q?KnC7TurYHG8sbJ+2646gUox2INLzgdzva1U514DyQCoxx8dH1p/vS1n8MjEP?=
 =?us-ascii?Q?98BrKuG0K4XZcIkmyWU/4ancFZ14c4fX/a1fthcT7zXRZQOS/q1GGqUVU6ej?=
 =?us-ascii?Q?GUPvVKeAxpj4IDAFsS+mAej+v/DdQbWBtfIn62ljNitHXNNsalBXBu4omfEz?=
 =?us-ascii?Q?DJChOubyVHX3hhytqd+QmUkVPgDkNhoSfZCu/F0ZQbZnt9MmwxnRWMs7b0Qu?=
 =?us-ascii?Q?YcFoIIEwOLI5getXGk/0klJXWLa2xY9qzBrn1BI33rJweGPwCMR5SU68tBQu?=
 =?us-ascii?Q?8zwJ6B/3oS/RCqN4doo+qlh5?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257fca37-8bd1-4f48-d33c-08d8e829c258
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 03:15:32.6238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnzwgjKRlvY2fbDJNKkvTDJHRyx9IzC2fdiaVlJxKLz9PaumIy3WmbfsyPYDMWp35EDM2565IoO2VQU9P20x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4458
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

z_erofs_decompressqueue_endio may not be executed in the atomic
context, for example, when dm-verity is turned on. In this scenario,
data can be decompressed directly to get rid of additional kworker
scheduling overhead. Also, it makes no sense to apply synchronous
decompression for such case.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    |  1 +
 fs/erofs/zdata.c    | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..fbc4040715be 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -50,6 +50,8 @@ struct erofs_fs_context {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
+	/* strategy of sync decompression (false - auto, true - force on) */
+	bool readahead_sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..0445d09b6331 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -200,6 +200,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->max_sync_decompress_pages = 3;
+	ctx->readahead_sync_decompress = false;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(ctx, XATTR_USER);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..25a0c4890d0a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,9 +706,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
 		unsigned long flags;
@@ -720,8 +723,15 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		return;
 	}
 
-	if (!atomic_add_return(bios, &io->pending_bios))
+	if (atomic_add_return(bios, &io->pending_bios))
+		return;
+	/* Use workqueue and sync decompression for atomic contexts only */
+	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
+		sbi->ctx.readahead_sync_decompress = true;
+		return;
+	}
+	z_erofs_decompressqueue_work(&io->u.work);
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)
@@ -1333,7 +1343,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->ctx.readahead_sync_decompress &&
+			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.25.1

