Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E02D995C
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Dec 2020 15:05:19 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cvjp41ZVszDqTy
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Dec 2020 01:05:16 +1100 (AEDT)
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
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=CA9xwBQl; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310083.outbound.protection.outlook.com [40.107.131.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cvjnp63qwzDqN8
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Dec 2020 01:05:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI5Zbivyqj03E+Jku3wvSqNEh1Xp5n4XOzyE4Ku7FNsos3hd2elEDhmcO7R1DHCPeC2nWCIs9cRYwNzICbR13tTGDLG948Ep4qk6XfiEsnAThcJahRlbAOGxXK8qWXayiCYDnTzJNsTkKjA7Umx2sbPYHasbG0g10rPEZ4MpoDWf7AUIi/YsZ1WNHcKgTSX0OgHPEe3azRODa4/qKg/ywg00gl45LUw0m0C5b8H5MFnFoezBQ73rGr9uxvbpwdMrwGJJ/imw4MV0mKjLRx0utYV0mLsRpQhK4DX7tLfNH0+dfSCRs+FsfRgLwMoE8VRcCjREDvV+IN9rQof1e5juZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeR/cC7zvZC9XQpB1xbZaj5H0RXVuNPit0SEe3LMXyw=;
 b=El/ojpr+DoCIsuDkenDvUv0o2F0Qia+iZsC9dpQDDJ05E8Tz+fXtEDtLLo67wRrMm7T+zk1mEWamehLfQj3Qq914/hQsC+w9IZhYAAW72MPq6qWH2uCaLQeDKjEk+VlRlehYtjIidCsIUI8oAcpH3yL/cAmWy3ICQvbAGgaELSe8DG3ujBqD7P9jJuf96EgRtfl0URU+aTK20+8QRRnNO05uMPeYp2QI25tfTWY8U+Q0I8V/MKfa9s4pbKZa1nLlN6v5wSoR+oEtdLG4Nyy29AtqQJwxQG4df6K/DzsaC0xHZyh5pIBnxR54awjWqR2zZp5sCE9CKhJja0nX/+s5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeR/cC7zvZC9XQpB1xbZaj5H0RXVuNPit0SEe3LMXyw=;
 b=CA9xwBQlK14LSGpnodXPlnGMuV9Skk2UnCLsVWXOuP8A3l5EoJ7u05VhooZP/LanLk9Cq//nm756II7QYj37eMpZ/SRPWoFzspfSoZah9cSSWYkFz17T9+dk66jLZl0u3CxJsntrAkFvZwUlWIdIcAxxqZJnLIEs9fSH/j58Trs=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2206.apcprd02.prod.outlook.com (2603:1096:3:4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.14; Mon, 14 Dec 2020 14:04:53 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 14:04:53 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] fsstress: support direct IO
Date: Mon, 14 Dec 2020 22:04:28 +0800
Message-Id: <20201214140428.44944-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214140428.44944-1-huangjianan@oppo.com>
References: <20201214140428.44944-1-huangjianan@oppo.com>
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
 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 14:04:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9441a54-60b6-417f-7fce-08d8a0393aae
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB2206A24454B0B9A0A4F96AFCC3C70@SG2PR0201MB2206.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cLCcUEnQZPICbmyEVpXGxzP3WVhOYX5W79rI5nsBp35imNRzGxFsh8KUAAF/9j/WDzMotZZLWgJuhVOoFVpfPLsRz3+SJ2fMWQkrWfqqLraMi1DvTc56ThUbLlkBZ7oWWjfZmXSk56ITyYDa1bBxZTS9Iy8egQwi8N4bco9uPDOPE7g4uJEkc9s58dBeGrJFQam/004KSDB+KJuDSk3VZLouAcigWntUuc1xYbZTRTIzgGMl/TNG7PnWzN71xOfn2y/VQXSYfLe6gE1A92SNA95bGceivy4DXuKRDPazKjDUG8j8y2rZ/iwWE7RcIXxlP2apQHcyPWR05cQwrfaGflVSrjgBGj6KuioZTUpWipBu46YqAgs0exaTbyQJ3WtEXKfC0s3NM/7nA1RkCoEma3gMaXqBUyrxqw3aAhnRRWVRyHF3dNu3DjoNWZTcWjPCc8VojLrIVvgtSxe7NKEDP4/6pi3CSO+FN/DqdI/RPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(1076003)(186003)(4326008)(69590400008)(86362001)(36756003)(6486002)(52116002)(6512007)(478600001)(5660300002)(16526019)(6506007)(966005)(6666004)(2616005)(2906002)(8676002)(66946007)(26005)(66476007)(66556008)(316002)(956004)(6916009)(8936002)(83380400001)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XhAHcaVvVEAwITqvY54LCy+8ckyML853DeLUbQfumrkHfni/Ddc09Ra8nUTU?=
 =?us-ascii?Q?m8tkj49yk+q498wNYJn3+fEZgEw7wzwlB+g6ajhQXghCmpAmfJ8oVwfzHL9U?=
 =?us-ascii?Q?hwAl5GMbVYozwglL8tsQc5nlGns8SqapPltiCZMzcD7fzqnRy6b0lQ5blNtJ?=
 =?us-ascii?Q?ySzrBElyyIuqVWETXw6l647aB1VThQNBh+YVQEV0eW8Ti5DtI4lvm26X6ulZ?=
 =?us-ascii?Q?lmoUAfQaIhlLTAbNnQrQaArezxnfVVGedX11tiIzBfVBwHKpRXU6hBkmGwqq?=
 =?us-ascii?Q?ZlI+uXYY4vzKW66TrmgCWuGnc1kbDsMOD5wwVkzPcMJSK5x9i94RQ/JQrpqa?=
 =?us-ascii?Q?agf5VPJ7qM1S2xuMCIW4DDmWCSRj/oYbTfk+61KKT+aX9ZHF+ngEWi1gkM6R?=
 =?us-ascii?Q?ezvIuK8R6obOFRSNN8jgOd8xVL4mRtrsCjfISPYuHR6bn3NRMerscAXuap0A?=
 =?us-ascii?Q?UR+ARjpYYTjC/Zjys1LkoPVISxYhO8eWgdQR88jB19gkag3I//kiZQjLMbx1?=
 =?us-ascii?Q?3zH1DApKBNxlJRQOpltIqXUJvmGm+sPRFKQj97cH8W/8ean/93yQzU/0EyLM?=
 =?us-ascii?Q?P7jfDmgJWmT3Rg7y6KRljJtNHtalMF4x+J98qBvzrK2MuK4/UvJ3JJLxSsjo?=
 =?us-ascii?Q?RFM6GCwshOmPaNuGzkOGA/DfX/DxmA+yIIVtgW6FWI2pY10GoLvNut/5RC1y?=
 =?us-ascii?Q?yM+Aq1GqhkNZ2cR0h90JTqXaV8MbNb4JFT6Y1aec5I95Orjut4gl1jZGpcs4?=
 =?us-ascii?Q?ECNRKY+u47OEF3/UDWDOGOXi5C2RSQY6PM3U1snsiSGrI3SYbACaE4hrobVm?=
 =?us-ascii?Q?cSQ7zID9ObdjXgbHlqOHZ5jIOaackvQTkCGFr+kHuy7y0Lr46Ng/KjDQOrpC?=
 =?us-ascii?Q?hzHYwg1WSEi7ZA8PCMul8RawdJJiKv04wOjoL3ttxV0muW9RvUq2z5xJAxDu?=
 =?us-ascii?Q?YWVJCvag69HEUfW8FK2tm6oedpcKeRNhc2EJIHZD0dQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 14:04:52.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: a9441a54-60b6-417f-7fce-08d8a0393aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajvjIcPTBHPrlqtPDdFfDANZgJfeUsTNS2kRtfVNu7/Bsg/b+gpmAB3OIedSNiLkweX7OZcFUyO/K13H3GBrWA==
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

From: huangjianan <huangjianan@oppo.com>

add direct IO test for the stress tool which was mentioned here:
https://lore.kernel.org/linux-erofs/20200206135631.1491-1-hsiangkao@aol.com/

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 stress.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/stress.c b/stress.c
index f4bf874..7e7cc93 100644
--- a/stress.c
+++ b/stress.c
@@ -4,12 +4,14 @@
  *
  * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
  */
+#define _GNU_SOURCE
 #define _LARGEFILE64_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -21,6 +23,7 @@
 #define MAX_CHUNKSIZE	(4 * 1024 * 1024)
 #define MAX_SCAN_CHUNKSIZE	(256 * 1024)
 
+bool direct_io = false;
 unsigned int nprocs = 512;
 sig_atomic_t should_stop = 0;
 
@@ -98,7 +101,7 @@ int drop_file_cache(int fd, int mode)
 
 int tryopen(char *filename)
 {
-	int fd = open(filename, O_RDONLY);
+	int fd = open(filename, direct_io ? O_RDONLY : O_RDONLY | O_DIRECT);
 
 	if (fd < 0)
 		return -errno;
@@ -166,6 +169,13 @@ int randread(int fd, int chkfd, uint64_t filesize)
 	if (start + length > filesize)
 		length = filesize - start;
 
+	if (direct_io) {
+		length = (((length - 1) >> PAGE_SHIFT) + 1)
+			<< PAGE_SHIFT;
+		if (!length || start + length > filesize)
+			return 0;
+	}
+
 	printf("randread(%u): %llu bytes @ %llu\n",
 	       getpid(), (unsigned long long)length,
 	       (unsigned long long)start);
@@ -212,7 +222,7 @@ int testfd(int fd, int chkfd, int mode)
 		err = doscan(fd, chkfd, filesize, chunksize);
 		if (err)
 			return err;
-	} else if (mode == RANDSCAN_UNALIGNED) {
+	} else if (mode == RANDSCAN_UNALIGNED && !direct_io) {
 		chunksize = (random() * random() % MAX_SCAN_CHUNKSIZE) + 1;
 		err = doscan(fd, chkfd, filesize, chunksize);
 		if (err)
@@ -252,8 +262,11 @@ static int parse_options(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "p:")) != -1) {
+	while ((opt = getopt(argc, argv, "dp:")) != -1) {
 		switch (opt) {
+		case 'd':
+			direct_io = true;
+			break;
 		case 'p':
 			nprocs = atoi(optarg);
 			if (nprocs < 0) {
@@ -281,6 +294,7 @@ void usage(void)
 {
 	fputs("usage: [options] TESTFILE [COMPRFILE]\n\n"
 	      "stress tester for read-only filesystems\n"
+	      " -d      use direct io\n"
 	      " -p#     set workers to #\n", stderr);
 }
 
-- 
2.7.4

