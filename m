Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE64544DD
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 11:22:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvJrQ40Hcz2yZh
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 21:21:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637144518;
	bh=J3PX+jtIplpKmKS0nuqkecOfMwrEXrgDOZ2CLOaIpe8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GX3DJ33hRTQe6NvZG0RDjJbEWHkyS5mWN+9kqAf9R/zxXMci7uSgRF6hduAEgNnTE
	 fLnx7FPeleZBnKZ9NK8BMX2Q9nYsFGlTUsU4u5l4Qbsp6n8BfjfQtw/OstCtsF0Ery
	 TIoMJVFBmLP1xZGhg1y0v8IMU4vqHgnv8n9i+gXmUke9CyohVxmmXAkT8YvyOZxmZ2
	 Km/IJbtsY1Vqevz+34BPafKR7LSx5Nk1e6cxM5A30APrl6PMVBwcLPhcFQypK+o6vn
	 lJXqFotm3AuCBEvhjql6Ks4ONt4nbXlq2NbQQhxr+Cg1Sh7KZMb7q9KnSN7W5T9bXs
	 E5QU7dNOS0/Ig==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.58;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Fx0C4hSE; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvJrD1fNSz2yJ5
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 21:21:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmZu/zIvqYtC1JWyZOGAHdj4n2mgDOeP2NaC5+4ohQ6my7QjMJEjOZ2z0ck0eA6GkVTDWRO3DvtBIJU0wuUgqFf7fZAQcYtjFrI8KtvQ7xoL/gaR4nL2pnH7PVGoEc9JDYuuKuv+Spr9FZ22g/c1QK27C/6ToqQ5yOV8VVNKqVoBDwwBSi1MOn/9xz+5jblT68vEam/wvSd1SRyNJskoOwXapigqdWUkIkHlSAVn7VQXFeRE7noc7AsMiDqpF+8Dc/kNl8haBg63eZ7MIGMtPZvYOfOTpz2Xnc9gheU7C+QXXFr9ynwFAlMpfefM8bPiNp05X9+hKW0Kgdv2CWX1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3PX+jtIplpKmKS0nuqkecOfMwrEXrgDOZ2CLOaIpe8=;
 b=AVdHF6KsHbDt+td855axnoWkvJB99esD3KTdKg2OTEeJgfsIJFadIc2CBEJ7Qx562yPDlq9aKT9ejOg/FoVatn9anuowyx0NV6sc+XlAEtVPg/nDp2lSPD4ftY4Xzm2O3Xh6yCQleXMB8OO94DpSWRG37QYgOgpF0g8T1aZ1ks77uYaldk5r4WQdAkMHMLkLW9d+mmPWomktOrfWOkGeZTWaLmbG7hAQ3WK3FWmlxVMmv4pseocK02yZix88LikjCr6EQYp/V5zTppBjVLd0ipqMtfVuCYfcBdgubwMSKaQqB3gfqrrl3FW04No6UEXkMiDwTvtTAlrRiQX/4vYhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3481.apcprd02.prod.outlook.com (2603:1096:4:42::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Wed, 17 Nov 2021 10:21:27 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 10:21:27 +0000
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: fix memory leak when get blob chunk
Date: Wed, 17 Nov 2021 18:21:20 +0800
Message-Id: <20211117102120.30203-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117102120.30203-1-huangjianan@oppo.com>
References: <20211117102120.30203-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:202:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Wed, 17 Nov 2021 10:21:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae476b9f-6f58-4348-7db7-08d9a9b40379
X-MS-TrafficTypeDiagnostic: SG2PR02MB3481:
X-Microsoft-Antispam-PRVS: <SG2PR02MB3481E3889AB61766DA055B15C39A9@SG2PR02MB3481.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzOj3Y+nfVplZ7iT3dH3lQUHeLBZ4Zy5PyeoIG2mNbBToW+jr5YbWTFifj9ad57Woey6vsid+zZ1Rp16aXPNkoEblpWhukWt9KLkfxukAizmwb08ntxI40JtzbhhRvsBLKuzOke+OPM3Ui02iu4FszgIIXNhQtzbiwSfFUnsq4SoqiqN7yfXD2JSpK2lKDu0QfwUyaBf1jlcDmoxQ2sLJ9BHxmOlAx/acCaLn6J4NiE6HggJ8NBcC8SgN88jtcjTWiUMFQ57swfTi6UjkHkQmlFcm5GVmeTH5iALvRH8Xe8oSh/ktPK0SbeNHcNxSR6rgfwZW6lXNS7YBHKUFHmxKVOpzT+3oEJ5BrkvieTOgmiWAjvOj6xsf3M7AEN/AJSOS8dUljOmtvj2ooT7diFfY3WyThazLaNuQ7CHEo2zvRyy17fOjHtZKbjCoWQ1m1uWmw79Pbt6hYSReKMRRMYdlHP0imXLM9BIXKaWhzVUwFuxBSD7W9AO4u5mTCFMW8r1GtD+Gu7A664elFnV1nef8T/TdytoHDZLOd3Re1+zDBKGxx9PguiWzjczbV7pWkqBbYcJSBPHbWYHBgO8ubEjSFa2XrjqnvD9Vb/aaNaQn2cTnuEDFbbEsqzG9VWmK2PUUWbAgOacdbpLIqfkupot4RNCr76Rg/AzOCRLMZK2dwPVdXVkJg/SpyBGsbeq5W7qxWrIfvk5X3jBHIExXzqhaOhl6U/3yzOC5HYV73ntUds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(6666004)(6506007)(4326008)(2616005)(6486002)(66476007)(8936002)(4744005)(956004)(26005)(8676002)(66946007)(2906002)(316002)(38100700002)(5660300002)(38350700002)(36756003)(107886003)(86362001)(508600001)(186003)(1076003)(66556008)(52116002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MyRyfCGq16V3ZleM/uIq5uU1sZQZ19HGI3QaVPoeLRLMYf+BKSG5GZLCtJpl?=
 =?us-ascii?Q?Wf1AEaqrWiFNNkgCn3RUR+rBG+arPsctZ/Od6xev0Ll0sZsLX6CDEf3ve4pO?=
 =?us-ascii?Q?e7YiiBfdKnnYasMlnZYGAx9G0+wz+r5ynR1GvnLfvGjOXORGUvLH2//Q97TS?=
 =?us-ascii?Q?Sa1IDum97YFv5n4UEzpnA7L0MFp24tlky2GOk0C9pB5p7Jxa1LwSai1BLObC?=
 =?us-ascii?Q?VMLkOejqR6LBLugoKWMAB9PlO8oRbG3kaSkERdVAzr+Fgs3dl57/uTtFzrAR?=
 =?us-ascii?Q?HFH1thOAlQApvrld7/v8NFLpOK3GZ4jrhyt5mdRFFMA9kd0+FqJNddn9mVck?=
 =?us-ascii?Q?+rAzUoP3nfSuEedVN6EiZ4H2yHyYVv7DiYeNnla0X+vwYoE6PRgk0oNgprpk?=
 =?us-ascii?Q?06BwWWilGM+7PJDk6vB9snEytzXG/82WpCvPBnzEqMNo+nJBETmjCdk00X0K?=
 =?us-ascii?Q?9DSgHFAfL7mj/q0Nv9cbqBEzg/8nHSSdj6bpK7R9MDKs79g1JfJTqYJJvrB/?=
 =?us-ascii?Q?SvbXOQ4z0xiG1dfKQofbcITdRgaV2ru649jzD7s7ng2crkwGBWwMqoxzPhBx?=
 =?us-ascii?Q?QeiPd0vzpHZp0VexoC2LRm018aZthnykcKA6//eeV5CEUzyjXgoVox9S0T1V?=
 =?us-ascii?Q?Qu2+gr00qUzprKfGLiw+buW0BxqmEr1WcwRdhjtS1mTOVG6J8SxmvPlUkAjk?=
 =?us-ascii?Q?s9kW812P0CkVyCi4e1TJrc4fntwNgf6zrOAdGNKPHHhdp3j6RPxpG+nWa70w?=
 =?us-ascii?Q?gIsGB3bF/1knbRmAktXQ7k4UctlpvYhAxg6zrNBXiOFs9fIAI7wDscL2e+bH?=
 =?us-ascii?Q?/Zcd884m0a3BR41qjL80lfBFsA8SO+zw9MW/bVveRPtkqA1oGhZKuSQpip17?=
 =?us-ascii?Q?ig4S9LTnnC9R09QFZWK64Sn4Q50nE3lROG4xq+RV4iWGP2qBxpCzI008p/SD?=
 =?us-ascii?Q?Syvc1wyT0zZU+A5SfkE1/e/xz4qnrFXs3S4pvSq073MxD5r+kjbtV9vNAMqk?=
 =?us-ascii?Q?5T8n4fIaMSh+Xe8g+WxX1UuuhkPkToarmCslzqmWJkXWUEtisiaD4YcVdCPM?=
 =?us-ascii?Q?5oXYIXEenX+bLVrXMr1+OF/UtWIT/n3Lu8XU+SD/M/IAN8cOzzzas5JdVy7p?=
 =?us-ascii?Q?+q5uWFvwqY970DWcDVenLyMxZfT3kIjQ3mKRgCvoyRiVPrz5K0YUjh1TT5S9?=
 =?us-ascii?Q?bD9q5Iwrq3HPYGz2KxSCcIGBBON48Go8J19ApnTjG0YhIt7fbwa7eTdk0Lt1?=
 =?us-ascii?Q?a0HxYeWv/UuqPUYBz9cEc9iqZBkl0y6WyzOxGm1bCAbWSteJ4N+s5rijvAvr?=
 =?us-ascii?Q?N0zzgXMauG7EXdSHjEGl+1LQrkRiTnT9Ew4QwzV1O0JweUXGgBxyH2zJfq+N?=
 =?us-ascii?Q?Cb5rIGvTTvzjc1XD0Yl+AGOvP2LvXOlvbjkBXEX2Zjx7nrsWK22Bv/FleiYl?=
 =?us-ascii?Q?734/89DYl9CWtLUl14H9TteIGegbxG9ynDWYaBUPzy+Lbb9PhjDbIAGiFf4f?=
 =?us-ascii?Q?W1/KttApv/0o2TuJdfIJkqg5IoN7E3K0LnMbTCWtIs6OGcRnvTuYPwxfJDkV?=
 =?us-ascii?Q?4Xyhj/MgUzEm7lB9t0rbXecNGQs4xwZimZROqHJ7KHuGSojSJ1SvihRoaAw8?=
 =?us-ascii?Q?I+4znkv2OZNAD2Bf6yGrApo=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae476b9f-6f58-4348-7db7-08d9a9b40379
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 10:21:26.9455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxk8E4OSPQb375X7hwgBHgFCsA2n1f7kwg0nSh3zqpJgYccxi4zqGjV0PX15TZkV4HURme8l4Rt0i5f5lgKWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3481
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Release memory allocated for chunk before return error.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/blobchunk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 5cbb831..b605b0b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -78,6 +78,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 
 		hashmap_entry_init(&key, hash);
 		hashmap_remove(&blob_hashmap, &key, sha256);
+		free(chunk);
 		chunk = ERR_PTR(-ENOSPC);
 		goto out;
 	}
-- 
2.25.1

