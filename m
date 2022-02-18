Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 952364BB007
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 04:12:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K0GwG0Thnz3cP3
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 14:12:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645153966;
	bh=kRWN1JhyyGYciPPD4rbmijDurRpt7HlpL+F19KliKps=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EP7IyRCicHTS69TUxeFAC2DhmwV+2+T1OEvGh0wzoCADa8lYnDvAsLhniqBC8RoOD
	 SaVIwohQwbKtwiPkWuILC5TG8ZNYsp7aYxtUn7hQqTikHbt8kN7FunhhBn+kzY5THV
	 AYXeLiKU5WXLFNw8LYzM7u5XAbOYfrjzzMQX0yw61X0NEobBHYdaZ11Jlc3WEWLi4g
	 qv1C21UIEWtNRI5GXV3fj97Cvd0kEqzSsZ76ro9KHsk50Ht0hEieo0m3kFZfMshlZZ
	 Ed9F+kXkdgaHbzMGIGjLEWXsRY8ZmPCqy0K+EFMVnqZCsxgRiJRTicmfRzx13BheKj
	 S/EZo7OMR/INg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feae::62a;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=EvQeLmcI; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K0Gw71q4vz3bPW
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Feb 2022 14:12:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCpLNWMZMosLygTLh0GPly6M6hbsVI4Mli3z9cJbU57wMd0YkPKxT1Do1Kfiq3ATo3MWlOSzmWKIMdf4qDIcqJCKJxyOEcdM0KRMSviNuvGIQP6XSTq0m90igl3QX5RolwjKW1tio1OGQezXLnmVXk1b9xqlopdMA5OI4bSiFZ0fGUYf1A2PiJTMGoW0ck8/U6HJmuAEnlAhG35a3mfWqIfRc8oDh7J2TwP+kA3OUuTmCKSAwyS8cG9rUZxEc9Lc/ZVsyuRErHDacUu8Xl0IV5Nm4cOFqsD62zSeb75rLEPXWikrR+yWrhYK/4XZ5ntU6ysvixHg87mUau0hnGX8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRWN1JhyyGYciPPD4rbmijDurRpt7HlpL+F19KliKps=;
 b=TGh2PlCamRXZYdGlg7bJca1CxeWE+pHETqls5NvqQN80/xFfPbLGl7aIfN0EynSlEIU8Fy7iqmOMhDMM9VQwxr9vCXvPByxL6ZM32lTeR/yBJQRmA94iQa05kO7nYKQizDATaSBgsvlXvRn3DjuWhL27wZ7KLTTHNi4/ylflrLGNQ12jNflpSoK+r3CKmhnPZvA6k3/wt6pXOWuwhf21nMd9m2wELpnpbSp4kHKP5TSdzAMxjeTQWzL/8VajJhr8ljCG+QjPy7YXGVrIQb3Glne5MKCSpwRIIEqmVwWQA5fwEYFLBjP5Nc6VB8R6+i7O/bJ85TDavCDJiDIaio3eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 PSAPR02MB4870.apcprd02.prod.outlook.com (2603:1096:301:90::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.18; Fri, 18 Feb 2022 03:11:51 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0%4]) with mapi id 15.20.4995.018; Fri, 18 Feb 2022
 03:11:51 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix memory leak when load compress hints file
Date: Fri, 18 Feb 2022 11:11:36 +0800
Message-Id: <20220218031137.18716-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218031137.18716-1-huangjianan@oppo.com>
References: <20220218031137.18716-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5023e13d-19a9-4790-cfb4-08d9f28c6898
X-MS-TrafficTypeDiagnostic: PSAPR02MB4870:EE_
X-Microsoft-Antispam-PRVS: <PSAPR02MB487041092FA36ED5DBC60E1FC3379@PSAPR02MB4870.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MQJ/pqcW8d0uIBvAExEPSS+DDOJnbod+KhY3FRzWKi3iweOpvJfphvqrLOzmG2kK0eAmA6O5PQq7O/nIO+UanT1cqsg9PX8ybSnmk3dy6LUV7sI2i68KeeAmQjZKcrivrdl79Jy3c/VdqifFuRIjMlvHPTNW5YqigVLIwhdUpM70CCdvudtRhjsSg1Dg0a8LtL0DQUHEVxUgB/dLjflchR5n02Z/PxQi6w5pOw2J93cxe6M3hhv0QLBvWxzWmF1x8MlWfbRbnTUStKCrLJZygf8aDDrXyjI2/hFUQcyMxJpsrOSaSrw8jdSzhx1oL9BM4ErGbtUvQ5TUK7dI4xIekmczIx1wtdRy7b2wvPuYSeGbUzUFqvKmgIR2beMJY0fUBku8WrY+APUCq6ULrMX1k2t3iWdKqenWTIJdZnEhaz9PkMIrhgSgqt+Mf4RjXaAiujpecMKsbrP8AycNiZdrVKAKIeTMoOm9smETuLSySs62ZLxYqSdRJAnOlpYHkANfa8Edzelqs0KtNCbUak8YiUqC6F7kOYWQmtDxUBA9GNExUKnUGKS7oBARMPQNykO2sTUZ/xTRhxPbO6rLViWsETOFK3o0YuL38IpYJSo2fNkmoawk/q7SOQ1eG7eySFmF5aGI7JcYSwMa19OB+2FiX3VsMfZmfvGPMEcxAYaUa7kdWaVsoxqJ2jrpLmGKTjSedWEKDWjLWpDevigu2410g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66476007)(52116002)(6506007)(6512007)(6916009)(6666004)(508600001)(6486002)(4326008)(8676002)(2616005)(66946007)(107886003)(26005)(186003)(316002)(1076003)(66556008)(86362001)(36756003)(2906002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJJdV/+FTqxSBtSbZlHPOGbWpUlHe8pK+SOhXGFSOWSNG+XsNLxlBhegUUde?=
 =?us-ascii?Q?fvjEMkALCj8+/m6juGhhWEH6Ke9/v+eYzAca0MoFECAzfrrfOh0EPHYPhcZv?=
 =?us-ascii?Q?tpkj1FiqIsxLq7bMW+wCBz8IDmtj0KrzhhkqdF1Hob6dxnnmi0y77ZSDuI1J?=
 =?us-ascii?Q?Hgt+Vutx8jGePRFTk1XTWwap7GNlFG/+utnwxGuxXg4OyQwprIiEuqKm5KUs?=
 =?us-ascii?Q?IylJe/LFHR9VdqjWFm66Hu9njMValYzrBF4inCkryTd+xt/uQ6H8Iazpb/Jv?=
 =?us-ascii?Q?pOm0KpxU5cKtVz4CpA8JbgkKQypRdFEx7ONI0jQKPXlvXe14FytKybuoKOuH?=
 =?us-ascii?Q?FPSRCGBdVeV6VfQibfk3eWgCJfdIBs9wyNd0Hl7vpIxI0oIlsMdS8ITIiyP0?=
 =?us-ascii?Q?iMMudMgjAUOsA4y2Ccog72aJr6+rRdt5iL/PKOTC5PH84x9aPw9ZFOns+MQf?=
 =?us-ascii?Q?xmYlTsnq7n8QLp0OAxYOrutFvHZN4EGAj0B0Nr3XcKDnjnz+FlcFr2z9Irz1?=
 =?us-ascii?Q?7qjz/BDpRpz3xGdYoFxc2AQn+00lzKOwTgdlpS7ujAWqp3MGVglP/BbsOZ/8?=
 =?us-ascii?Q?Cgh3tRB4PgnTmXvSvgChXara25Lc2X3ZVaSRq/QZJCJ/YEf+gG4nNZh0eFUT?=
 =?us-ascii?Q?TwaPjmyfnlLM0MNnAg1ndB1V8r1AO4+E8wbZ+1oRcrNPCslGqVuX4sLFHh5Y?=
 =?us-ascii?Q?8lAaMRJeSs3XQAjILN4wzm1ViV6KK8R+wCChO80kD0MWSnfJGPiDks1kXsj2?=
 =?us-ascii?Q?WYGhC6Jqdhdg5y5uvLjs9R9bE+lf6yLiGfZ5sus/JQLjYA3efKCJxi5MzY1R?=
 =?us-ascii?Q?XsELEAyPlHrNS3mDzXbov41GqjH3GZaQ72Wx3gzfYFRZGjn7szcdENKLpvFt?=
 =?us-ascii?Q?Sl0VD99IdJNSkuj8iMb38Km9heaV6Wq6hdOqJEkN4VrsVv9gsZSmAFhN2TOL?=
 =?us-ascii?Q?t9IBmZTrdoD+89NelrzIhJ0pt8HkhPlBYOJD+pfqkr2CroVku0ksrphxmJ1B?=
 =?us-ascii?Q?b7f4qo7CE/DSaCHlHRj87vLPo3w/8Go+zOBjg3NV1O6pWfN405eB72FBYhH0?=
 =?us-ascii?Q?Gy5/BZmCeVCjd0+2SfE3oE+K78rHX6alckyMD9NC7pybN+CTShJ5szE0Npjp?=
 =?us-ascii?Q?q4kw8a+UT0++ij0UjPNyskiOXDELLM/Q32MpdkYENHtyc3KKyvg6woajcAAl?=
 =?us-ascii?Q?zrniAKqqqGA/utncvjoCcSfGadKo77wwOdTuc8/Eci7Mo0uf/14KltDryR0y?=
 =?us-ascii?Q?7whPJJqpMYvQQvCdixpDq1OPoKpT5IP7DTbWxK3705TXqTH+khwyrQ/tLGHl?=
 =?us-ascii?Q?wu19CEqdEX1wkHKcPrvpFw454qHXRBn6/31RlNMJj2bi0cv0UNro5W39yWaR?=
 =?us-ascii?Q?jmCxxUpp02FpBG7dH5A3pkkGKaDgYFLqQgXKM4ONVZYBXmiKXMgzKtkkWro/?=
 =?us-ascii?Q?ukTNEDAPq9WlLL3wjm49Q67FNL5aKPTN69EFGkUDjBjULO1Nf4N+QhoLzdJa?=
 =?us-ascii?Q?R/7zZnLzfRqU29wMRW2Z8bzha67dFg4JOIsxrZ0sXr01jaOfC2QIYO8U1TgL?=
 =?us-ascii?Q?ZiXS+QEo4AuqxdStTctcI2GJ0J0jD2oRQH/XejkvzwFqCm42Jh5toCxfxWa/?=
 =?us-ascii?Q?JXYzljFF3gcLHcAG8951FOM=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5023e13d-19a9-4790-cfb4-08d9f28c6898
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 03:11:51.5542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7e1ETP4uTsZxDBwcHp7c2tlgDKsvlS6Qg9rCLXXUQ5gaiJSnrKfubKtN3dug6J+8kDLPjq8Mk+i+w9eyNm5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4870
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
index c3f3d48..c52e2d3 100644
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

