Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E532E360
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 09:08:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsL390cZ6z3cVn
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 19:08:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614931717;
	bh=q/SavpxgFgkP8R9yK0wUwJHoeNWLE2hBFtKIweA7VfI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CUaseiMskScwstCk3hwhl7I/qms8s5LVMdpUfqDL+ycpD23gRZ5P92yA2eRSchgr9
	 hAP/7ftgtBDFLv6JEg/0wwsb/6+pZRt77NBfV22Ug3Kkh0xabQ6EUjoHCeu1xvBRz8
	 feK63Lz+ocPp7lnQMh9rLR9I7/7pSlLcN6eW3Od8Gr1mW/S+1Rw04oBcHiSqHObOEo
	 cdlzQxc/8slP1vO7KKl4nI0GwXTJSnSgmd3dsFl72Bn451gjEMmK06+5xV8sTQCj+N
	 N0sa86cZziWopaa32bfNIEDP24SBD8EBgCOr2EJMTt2hd6VVEsGUTUUdW6DyhLFDG7
	 in2e8U3K+ckkw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.81;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=vYq212ZL; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320081.outbound.protection.outlook.com [40.107.132.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsL335Plyz30Nx
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 19:08:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTo1HHpmYTUao2QnZuCqvhPBoKsk1s6fSMN7AzGuzMHSNPa7VOsV/B1xLHnkytl3aj2zowPrnmQDRY5nF3+M2SJi0DexorYQ79MmkmRouf0PuiI9nZOnbENeZTYjPAIdwj1gZKl7woCgea/A7ConJ8aGHS1SjwLZgLKjlXKy7logVWCwqkBPBYdUTKbsqdtvTGx+L99aO5/gFPAqSv1tfs/8GTZ4SI9N396IjL6VHd0fOZjKiw6qq3Yxqryw83ySlLTNMht6c5MfUS+cjTXfaz9MwzpfFkHcvlLW6aioC1OyyS76ZD0/35GGpkQ9gwb0UFp9idUV24GFa03JJrKuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/SavpxgFgkP8R9yK0wUwJHoeNWLE2hBFtKIweA7VfI=;
 b=NaNfSfWMRBbbcn7z0B7V1pEki6LN0W0P72vFIqTgA/BliU5rYsCtltqLzpToQvRTAKe66VQqh5byuON+Eu1okFrWNZt2MUru0dvpp6NOhOy7e7i1mz5CWUbW2hbGAIUmpXQLhwrst2FxOskcyTraGc9Ql9mVkKHT2fSUW6KJbJZWQGiEWUCcnAICwh3vo9xhvCc4UdKY5fIv3qXdTfDz6z10fnJ12XvPohPL63wqmPtKPoFj/K10hIEKukWI++XjiHroP9ceBukV7/+rju7xFnnVrp6X4jLrC7Za48UOpS/RFRpR1mRzsiBIZLe5tU/wKLz47uR1vXekBBfnsqVI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3020.apcprd02.prod.outlook.com (2603:1096:4:60::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Fri, 5 Mar 2021 08:08:19 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 08:08:19 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: decompress in endio if possible
Date: Fri,  5 Mar 2021 16:08:03 +0800
Message-Id: <20210305080803.789634-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305080803.789634-1-huangjianan@oppo.com>
References: <20210305080803.789634-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:08:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea830309-113d-404a-f869-08d8dfadd670
X-MS-TrafficTypeDiagnostic: SG2PR02MB3020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB30203EFC44A144B2F9D5B2CEC3969@SG2PR02MB3020.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWUWj2Ixz17eRDK23lAB2Dt3u99EEnxCpBVm2nXq1JQeukGdpO49weV2i5MwUUNsKY8D+Fyu7Ex4053TwgfRkTypJN6w4DU2Qdy5yIIy/SIMi/2P5Cle6MUMMsWjriHUVryKPW1NmRi4mRh/D2b7NoXKzzqjkjtu69L5hvXIKTRd8MsBPhD00sauaFR/bFlzyjJezyxpcJ8j7xN56bX9xrRuD9buMakdLUjq4H+bqyGe7OWoa6fZ8dRIOAkIzHvCzz4imtmV6sJpdu/z83NGgjiVP7sPLwyJEGr3AewwBLTn39YrwaXclHNdvC0AiCq3PTaOwq5qxVOJ+6ecc4jjY3GfHZ8FVOzIDl6hM49Cbsu7lpF5ZfPn3Cl+v0Tx17WFBN/mOveL1fa73Bz9T+rWev0A5tkkQYJFPOioCdWO/gEj1SXauI51D9dElT2U3WSCsD/a4SiqPF8wH+nN8GLzRVjdzy18jzyk1dZ/hftgu8VPhECFAlx1vGREZS0FIpU1NqOX/Vh50FUdPDH+7vjvsuSvxfqsiEK+4Iz5v5PPgI9gJCncaY1DkPFstLRnP5hDeX6o6nCdMoE2jx+hygckrR+xzqmej+Qt2Xy+nGStcZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(6486002)(316002)(83380400001)(478600001)(16526019)(6916009)(6666004)(66946007)(1076003)(66476007)(6506007)(6512007)(5660300002)(52116002)(66556008)(36756003)(8676002)(186003)(4326008)(956004)(2616005)(26005)(8936002)(86362001)(69590400012)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B1PdBis4Y5JKtFR0IJXYPBQftVAlM/vTshDidsTnazrWLdd0IarT9v+ZOJNJ?=
 =?us-ascii?Q?Fb3H3gTr6XyON4oG3BrNq8kLz3lRCX2umTulUlj8Nsu1DCPjEA6F6IqUFXmP?=
 =?us-ascii?Q?7a0QLzDX9T2MWSRcRyDVW8cznhcxDrVipRZ11NyQUZyT3f5kYgz5D3XOoACE?=
 =?us-ascii?Q?qfeXTAJ8QmrUCvG9KPEyl5eQ9YoUh3VaPNu2aor6ahj+eWpCOQmTcalzJsSU?=
 =?us-ascii?Q?EUFtmKVZ9yjvEc4K2EaY2iMiSHWb7r51G6IoHpibyIKMfPEg5VD2bACkyU1y?=
 =?us-ascii?Q?h6wNaSYJOxzc5WKWSQ6qBmGGOqEAZZWo8tUIcuJK2jQep3f4MH+ZiPF8XRo0?=
 =?us-ascii?Q?JKKF+gTqhKVt8MQzTMWS4PetXsWh1d9BxQX5b3IN9fur4o4Zq00jt3vX3QWa?=
 =?us-ascii?Q?yFVfmgIzwUvril4wrZuEGwhp4UAUnBMRJWTPdZceNxusYVihKbFc/UNK0eqU?=
 =?us-ascii?Q?jp2EYOXROVQmVaLWyFQyBVIYMyQR0YlyTCNgLEPrYocbYH594pixSt2BNjKA?=
 =?us-ascii?Q?5gnw2gmx0b1qJMcJgPo0raLaREHK/Lb7OmzV3NbRFTRfg17lfiwJR9K6ONmE?=
 =?us-ascii?Q?ouzJC3TY+ulb6kfXt3qq1DaZfEoqDnOJj1ue7Hd457IJM+F9ahH9hoPbCtcq?=
 =?us-ascii?Q?Ik06xIref9xGq+CauEaXvMJeToQW14YkHpg71+GRQGy2q9c4NmQ0Smbv/2Ny?=
 =?us-ascii?Q?u1CSYiFIy2TRbzXm70LtqYRKvSdlxZK0u1/H+HNZebZf68HysPRwuP3SxVl5?=
 =?us-ascii?Q?24jEOVo0/0lc4mGPXC5T4spQgjSof0gyW5pOvcwZ3Pd8ICEc1hQ8Td8ISchs?=
 =?us-ascii?Q?wjcXv3A0ZA1ITYzKOQaAyYgw35oCOQmRdm6cPUhjPcyBvXo0fwsLc2T/CDpP?=
 =?us-ascii?Q?Qbxq/pzcdUg2L1jKeQQFOnKGdoQRBeAKDKiHkBJ3wu0/bgQkp6vHvLrNZNMr?=
 =?us-ascii?Q?bDR2DVg3AFUjC9M5+4RDMQXZUcR1VZLPzCHivZFbQI+uTaWyMc3s9lTtYHw4?=
 =?us-ascii?Q?lZ9OtnE24R9FuLtof+GPePT52NlwKqGI3rgSnjJzDSKSnuRlLKdgsY2qWZ00?=
 =?us-ascii?Q?xAR69ykOFfjLtHd/YTBptmHXa+2ATd7Bj4M4HLvpF56ATRKKU+B470bqFk8P?=
 =?us-ascii?Q?9VDcIEjPJcS9YmsgCWVy6nP+RW96ZufvfMfLEy3oP00EThcvifE8dj6Hc97m?=
 =?us-ascii?Q?O3RMWqBTJvgCYwWbMye9NRCPmQ6ToFguhZCkyD8OfUq1gy5new32hRLKWSOl?=
 =?us-ascii?Q?J3NSsFwXF99LNYl7l7eOLUyxRQCeS7Dheeq2XfBM2lf9hUYfTq/4MYRScklK?=
 =?us-ascii?Q?cKwerdezP8csIminuQecTbTp?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea830309-113d-404a-f869-08d8dfadd670
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:08:19.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywVYyM4dCMYAvXuoTm/A38ou3BPGmt3V2+biOzvwxKjbdklMB1EXzcFBbyzZbRQSiq5MRzW9gklbk43okTUSMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3020
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
---
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  4 ++++
 fs/erofs/zdata.c    | 13 +++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..b817cb85d67b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -70,6 +70,9 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	/* decide whether to decompress synchronously */
+	bool readahead_sync_decompress;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..77819efe9b15 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -175,6 +175,10 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->readahead_sync_decompress = false;
+#endif
+
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..49ffc817dd9e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,6 +706,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
@@ -720,8 +721,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		return;
 	}
 
-	if (!atomic_add_return(bios, &io->pending_bios))
-		queue_work(z_erofs_workqueue, &io->u.work);
+	if (!atomic_add_return(bios, &io->pending_bios)) {
+		if (in_atomic() || irqs_disabled()) {
+			queue_work(z_erofs_workqueue, &io->u.work);
+			sbi->readahead_sync_decompress = true;
+		} else {
+			z_erofs_decompressqueue_work(&io->u.work);
+		}
+	}
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)
@@ -1333,6 +1340,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
+	bool sync = (sbi->readahead_sync_decompress &&
+			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
-- 
2.25.1

