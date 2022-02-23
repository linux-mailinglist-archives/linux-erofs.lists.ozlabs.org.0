Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D50414C0D33
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 08:24:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K3SGr1H17z3bNg
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 18:24:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645601092;
	bh=6bP27lJJ++hCFh/Amraj6O5bn5e9boSWO87p6yoVDIU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=TPmx8an7cqG9MFtGbjGgD4GmSjO1MWXKQdDqfXjprDLb+vc4IvTxIA2CBa4szufiT
	 CzDoXFIiJwvISY+4vjlW33HAliPE0sf/cSiQ4GjZXEeRiqKKK6LJNXF+CSsju7+g6e
	 DM/r8UBNCCnrU6FEkzY3Cq+6xTds5+6MbqUSurGF4s7QuOt1V8DRhgXM1gP4/F4udI
	 AZOBKRfyIlhJGq3A7NWtaQfRWWRQMEEtHafPS0sorpGdb3av1LJDL0b7kR+LgLCaT8
	 I54MnJLkzCwNs/+UOjr/A1qMFFXgG+ObTleUn4dx7rUHG9m8BH2GNa6RFW87SYdGGX
	 5dWKz4qQeIT2Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feab::61d;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=fxDtFq3d; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K3SGp4HgSz2x9b
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Feb 2022 18:24:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjcXkyNbXXG39fCCKovrvNoC3QdkJ34d9kgUmsFXX2m7jZkgzFpxSgYWXvYLaiSDc5nrQOukdLaaNHJt/H57eg9WbXZCk6WsAOm/HnDg8YP7gHZS6Bi2kPeCOqTk8pagHBltqGurW7OXBy4KM5ypTp8BgirHWwUDfwDua5qzSgQSfBMJ+faQoLIe6SEuuob7id+wubld/N/VkuCf2+xFclwHuj4slU3dIAzZ5FbtNVDYF4dTEkVFlQTAMCB2czvDx4wGmPGwyBZcnsAqD4d6PdT2KnlrF7WDmI6sWn6AVjxqrIsXY0qFPJfzATJCTDqvz9GblaJ6F6xrIVNJnOOe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bP27lJJ++hCFh/Amraj6O5bn5e9boSWO87p6yoVDIU=;
 b=Q5qI3uG46LxkeCobjoD7RCpbtbofIYd9ssmXOUUDOhUp9TLqpYpcjwtf7DXNQIjctXmG7g2eAYWb7EvkgZplv+uy9zYSQd/eFamQRs6TYwWbDrGjJhdWgzVcCN4+cjD8Es8eh4p3w6/551+jbTNFXNAlOqpiIBgYXlB5hjzYGbp91sEqdzqR6iLXurM7gUFLA/hZfEe3NJvzv9YShmhOpKOIliSYjFjRR72AsTY5UZCu0qpDHaZtbY5EFWwYAeQJJzoV3eMK+enyWJPty0zog4jurx4deA0A8AZ3V4fmGsP1H2Tg+j1xDnaYTBp0EnsHtQnSTLL2qZ+dETuCf/1W9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com (2603:1096:202:2f::14)
 by TY2PR02MB2848.apcprd02.prod.outlook.com (2603:1096:404:47::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:24:28 +0000
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75]) by HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:24:28 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fix fd leak when load compress hints file
Date: Wed, 23 Feb 2022 15:24:18 +0800
Message-Id: <20220223072418.19180-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To HK2PR02MB4097.apcprd02.prod.outlook.com
 (2603:1096:202:2f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7f1f79-a2c9-4554-cee0-08d9f69d86a6
X-MS-TrafficTypeDiagnostic: TY2PR02MB2848:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB28489798B383EB22046F923AC33C9@TY2PR02MB2848.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3yRdv/kODY9QfxmlvdXb5Lub8yGvOzZLJd6PvYMiUCqCosXzR1mPFFFVnlltQYOsJ+YKN+CACbMJAap3zyl2MFShc1PQi/RAWoN4Aox+F+EYfmzxz1kdvTT6QDHkHJMcKI0HqJ3jNIaczIVxL/ycaCDURKQIdyNTB7USbutXIoHl1g86/uibuvP6VbQA4EQ8VnAVkzsf4cO0j60kvqxs3m9R5SEh8NqqMGWMlJVG+SOkUKsQaI2keforsF9CD1kfweTYJRv4plnkBshjwTTWmPdwqFBeADAuHNq0pj4RMgjhhsnLEW5i11pbNCq64a2onAHOcVbYqp3zncsWyZiEzhxGvHBkOOlHM8R6btahYpZ/JGh0OHLVtGKCtWr8B4CML6sCrqYrwvzjnF33k/Wyt2/56LmMruCEICZ+CZj/RXqe2eRvD53DClFUTmzpdIhMrTKlyxp3X8mvgtx97Ft35K4vuGXbyHN+8fOYO1jwvmBjeJUUmzTeigw2zW4sPRRFS2yXmai3RX1FtD2CoJoRJlXU7w9grpzG4xanWJlSly4ssvUHt+P2OYdWtkyNOOFPPmrjnOblRmn9z/ly3oyCzrzVPE9l+yfWeiwSLqIpu1qfD0xTXOajWhtOH6/NgF2ZTmpRkv69LaX41IcMg3lu0oYmj4YC2NcI+m9r6MWj4k9gFb93fk+adZm7BSsQ5qPBGrG3v99uecGEcFlSUSQMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR02MB4097.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(86362001)(38100700002)(5660300002)(38350700002)(1076003)(2906002)(6916009)(6512007)(2616005)(316002)(26005)(186003)(107886003)(52116002)(508600001)(6486002)(6506007)(6666004)(8676002)(4326008)(66476007)(66556008)(83380400001)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEOEvUIMC5ytAXRf+pqVQ9gHta75n1FwFLHJ2YDo7wDjqTuonhBUirc+V4cx?=
 =?us-ascii?Q?04ir3rLt3nRVAOD85T2YuPg1pL1Tn5L/DMtxcBjoMXa9oMrnIIusujw36Ovj?=
 =?us-ascii?Q?XofUIOv6codUBr8oeyaakIst4UnqzpasqV5yv0TX/ebwJU0dWtLOYVSMrEZ7?=
 =?us-ascii?Q?xrWaEeN1vzeMOu4GMEqreh38og5ADhqI7xN1J3hy5kQ93M5kt2D2odVZ8nul?=
 =?us-ascii?Q?FdI0G+zfVq7Byv9ktbL5JQMrxRVGLq6ay+7DyKktaZPG9hFVSenuzMcHNKMX?=
 =?us-ascii?Q?K2aao28R6cq9Pgfuaxx7XxOJZ0iuZneLcxWYP/MDARXPYnnQWi46XObhUHjp?=
 =?us-ascii?Q?w+8ANbM59iZqvkMrajDoIAcWH1VUckFoehKU2aaJeKkDiWVBUkFmk8EVy2Aa?=
 =?us-ascii?Q?NWu8l8k/XQWNETTFLaI4/46JNvkTPf2w1wisFebHdCJnv2m0JGFnJ01cVOeF?=
 =?us-ascii?Q?iiCb64UU5fYNv9IgbmCVZYqC6Zz3grdJ4utUlNrxsCz4gJNXs3NqHqQ3W7Ra?=
 =?us-ascii?Q?yssJ4Ot3BAp2NS6d/CisTocE2IUYbWP++b1lQHikXhE5+eOrdrf69eXZFCtV?=
 =?us-ascii?Q?ybcvcM8s6Gu2/qyjJgQIjM9CRCXpKV1L1uS4ix8ZQi5FwbAlGiAYby0vNKd7?=
 =?us-ascii?Q?dlmNuP5fKTJgaQLAqxzrvi4zC+YMwNg2OUFfGzagACSMX5tZoamEA3N8MpOG?=
 =?us-ascii?Q?eUjmCSL/LW5YPZbjpSIIPQ6xhy7Z7Lw8/WWlvty94Fo6edM1vdmdvQg/spsE?=
 =?us-ascii?Q?DeQqVcCwELZNrxXnfGCluO+dLcuo8PpIChHCdiIG7Y3i5VJ0Bec1vJNSV5f6?=
 =?us-ascii?Q?vAKq6z+4/HHYAfj77hX90/pGl64/vEBU2D0k97CpVYBegP65GkfPv7hEz3o6?=
 =?us-ascii?Q?0sGjgRqrI17V3uGvB6vJe6tixzeW8fd7dQ79DWxtaZMUYhujwoJHT8brr0k+?=
 =?us-ascii?Q?mMxLl+/K4K7UShjgOc1ip4MeH+4lbnt9JR/trBeTWcLrMVVpQZjghbB8jFzm?=
 =?us-ascii?Q?pGwsWrQ8Je9iBaX5gr/RgmUm/mE/ecLBiNLcmIxwjyeqFFiNXsjDUr8m7xiv?=
 =?us-ascii?Q?f4WxbZbuVnMjTkr+1PxSnIcHEqNS9HcQZ6JKO7UccH2OQu7DFEaWh+YB9tEK?=
 =?us-ascii?Q?i/BWYd9YtkdolcHxjNwcsr89Vyr8CrrMErZSV78ke5F87AZIcbH/DM3QvUPv?=
 =?us-ascii?Q?BSoQRqyV0OToSTm0eKN2xPeXZ+MLumiGzrpfQECjVHps3uN8U8dLLMIB+m/V?=
 =?us-ascii?Q?P/L4XUBh39LMHzl7PiQkSW3/u9j/t58w6kjOQhWBkIE9xxYmJDuCIi8p2fSo?=
 =?us-ascii?Q?dNAFFooq6FjE26MnxRLaI/3vdVli3nTFmAPXCxkDgMjonF5wKUia7qFnvqsJ?=
 =?us-ascii?Q?Km/irftDKTSOHZqV3R0GTGODXS1Y6LWD6hmPYBk7kAD7wsDXsHaEfVpGiC+z?=
 =?us-ascii?Q?jtEGFDg7vFoN6pPciS+xDT6CONsNpxLD9azubPowMjMTAnBMndVhe2B73E8F?=
 =?us-ascii?Q?LwMR+M8pnACYQXjJBm8AM+i19XawFsaG6zSQtuAAnGmhncmn+0BQluLlsAmY?=
 =?us-ascii?Q?DlnkJgfk4wdWApIZ33oDiTwiH32U+4gsJO0naGMt6GXCjVQ8WUQc+wqnEcBS?=
 =?us-ascii?Q?x1/yMLOQ9qst0LcdLpQk3zY=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7f1f79-a2c9-4554-cee0-08d9f69d86a6
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4097.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:24:28.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Uk2VWT3nApsgssVRh2PZucKp7q+cjN8iOTREsFIo7bUpmI0hKYEXNzUNVpxt+y0BZPb2MLIOotznV+zXvUEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB2848
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

Execute fclose before return error.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/compress_hints.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 25adf35..92964eb 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -88,6 +88,7 @@ int erofs_load_compress_hints(void)
 	char buf[PATH_MAX + 100];
 	FILE *f;
 	unsigned int line, max_pclustersize = 0;
+	int ret = 0;
 
 	if (!cfg.c_compress_hints_file)
 		return 0;
@@ -105,7 +106,8 @@ int erofs_load_compress_hints(void)
 		if (!pattern || *pattern == '\0') {
 			erofs_err("cannot find a match pattern at line %u",
 				  line);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (pclustersize % EROFS_BLKSIZ) {
 			erofs_warn("invalid physical clustersize %u, "
@@ -119,10 +121,12 @@ int erofs_load_compress_hints(void)
 		if (pclustersize > max_pclustersize)
 			max_pclustersize = pclustersize;
 	}
-	fclose(f);
+
 	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
 		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
 		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
 	}
-	return 0;
+out:
+	fclose(f);
+	return ret;
 }
-- 
2.25.1

