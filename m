Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A83F6DB5
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 05:35:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvWng2kbJz2yK4
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 13:35:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629862503;
	bh=+vstBd+Cdly6OAt8gReL5nauU2rd4l2BWvQxCtJtw1M=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WHQYK4JrMFscUkxUlVSvYkbpCHdLThZlZ9Iu3qphAuxFviUT1feY430LsW/PW/u5L
	 3rgmsttZs0tCuatgIpoQs1WqIrZ3z408c049/I/u+YjVZ+ZhZCaPYnOFlppNZ+qBop
	 FEPQrSLu9ILL+jviMoD3+6Gx+mYL4rpmwEmAiM0chq7QsLeT3FeX1JnxwvmVs8IfsE
	 RbLsM2QiRRNhLkfpFPBtDKNEB0fym1R2WD4/lGc1ljpHChFrwKhe+wWalFTTDP2z4Y
	 KRzfEsx9qHNFVs+PmGaEd46tc8OjuTK++DMVvIGADJFisKiIhouKVZ1/RN8rbozzcc
	 UxeC2+SwzMxkg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.79;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=tzPKo9Rj; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320079.outbound.protection.outlook.com [40.107.132.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvWnT0zWrz2xrT
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 13:34:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWFIm0Y84J8r14cwHyhARAeotOTHKWjEvRLuBKqmpCrisqYrOKzxtT46gIJYXtOL11+v4OsH/Mo3EAjow+iOxYfU75PpOaiMB1i92R2n6L8blL2qa7Odvv1oZhj/MQexPe1+TGL0KSBLfiEk8961guGtm549a0owfncOkR63Z6+okbFebNR07qN5vZ7g8DKOaA/rmtFWE/ICLi/+OyXAvbV1jyyqsG2m+jM/Xe84zQ0LRpMJ0tFvnUXYw2xVrEfJfyvzBgNtLXgxIZTG67mCDzyRtdRegDQEEdsgJexeLt3o4iEkhNDIOCOL8PIPRtWpZPxQmNZbOZjCThvraRhJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vstBd+Cdly6OAt8gReL5nauU2rd4l2BWvQxCtJtw1M=;
 b=jSEnGY+2+ux8OBhsgI+piJFl/AnFkE//Xqpi+U/Fi1SN465HQAUIt1WGeKvENbfplf05AtCQljGaOs89a2ty34f/pCMi1ZYcO9amZg6qzGiMVg3pp4lhCf8yhP4wJsCxMNlNRvFx2j7IQAM9zRFibngAfKU1xpWz7uFQ4aN80gjgwK/GC2O8T0zNz9wjC/7quO57g6PzMrE0KJRwVhMaAOgGqk7NjH3VqKWHZN7Id1ewjJnVTTiyNeVucuEgG1qXHR882zjy0rZgFqfVgEKjOW+tQhTbZE+W0VTBFn0FYnYQof2evd0lxccN7BYEzJuqTgAf0iTq/4M6Y8LMT17xWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3113.apcprd02.prod.outlook.com (2603:1096:4:5a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.24; Wed, 25 Aug 2021 03:34:26 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 03:34:26 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] AOSP: erofs-utils: increase val for WITH_ANDROID option
Date: Wed, 25 Aug 2021 11:34:16 +0800
Message-Id: <20210825033416.19868-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR0302CA0009.apcprd03.prod.outlook.com (2603:1096:202::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.6 via Frontend Transport; Wed, 25 Aug 2021 03:34:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc92f37c-de2e-4883-5fc3-08d967793cb0
X-MS-TrafficTypeDiagnostic: SG2PR02MB3113:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB311319B41C688080197DF9D8C3C69@SG2PR02MB3113.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1vTQDHO/K8PMmgMQNlCDuMvdoSEbsuGmHFDFV8SDXbwRJ//B55P+4LsdrC+FgCsDoAbY3fxH7ve0a9O/lAy7qgAN0aX2ukelPqgAXjafF89q8Sl9TidrmjkSlQOhoMoFw0l1Q1lZK7t+H9v81ICsI++LDSHLR5r2/yZbwu+JMC6e2eFQ5PuuU/jT28RleSdjJNfNpppM3FvZnuFTXRTlQaBC77VCF2QUxWymaWHvd31TmD25gbcN9CEa6gTqpBpuVTtsLSXDc/oscLtaTq2rAr2N/MnFTRZLMIeuajnG3MFA7yQK0eCio5nbHOQOgjnoe2vW5rH7WizxMS1F59P6ppqFMXIYMtXF2utDRSduS1AeK7mZP/4o+GCiHtMrZQr1+LpeAonGUH8Ak0yxyfUuu7sxBQpZ11GIce4i/AtjvGX0Ozl2danjH6MdIL8APcm9CyxsFJ+063tnUKzqQEB8Qo8IoSOFZbkpl7faiTZeGdTVy6VzHs/qkf1QTBXWrjqzhE/ZaNAtFPdYhmBc4Oz+kiV8JzWSf56peMiTLU96pQn+kGhhagx2o0gFbEyqb+gU6kdAIi4vVTwKjqc8j/kHUM4g49UwZzcLvhTVvTzEJ5WlKVTxhvS/raXlOU4GgQcLX+kHxCyChzzsuRsEVG7nm9HwIq4XGldlUWQ9tUOhxVy/mkmqsmxBvhCQGVY6s6btxzMMT1ld5fcjDx1NA6iut3ue3Td/VEx1g1BLmg+kCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(6486002)(1076003)(6916009)(8936002)(38350700002)(2906002)(478600001)(107886003)(8676002)(5660300002)(4326008)(66556008)(316002)(66476007)(38100700002)(2616005)(86362001)(956004)(6506007)(186003)(26005)(83380400001)(6666004)(6512007)(52116002)(66946007)(36756003)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Rwbnfk0R9brfkhbk/PtTOx9vzuYnDU27BJGfCaIE1ARanYsMJ/R0BRecLSb?=
 =?us-ascii?Q?yueNIRtIqdV/HB8B2HY3NY96IbpWqaO0spL4a7HKFT3Ui/OhuCZKUdg6o4lr?=
 =?us-ascii?Q?OZ19sP90fGuf7cQWAQnwLUGxijic03DqbbxvictNLRonIuT2S4W3VeOcRqUI?=
 =?us-ascii?Q?5oIsUrY+3vzbgZ3dMWl+LJNIrHd7bxRHMCqa0tzmfDvG70Fv1aC2eKs1Dr3/?=
 =?us-ascii?Q?t5z1Ec95nLXDUx/EwNCO4SuctxE7pEvHGui3duN9yophkpJA6gSg8dddGrgD?=
 =?us-ascii?Q?y/xtngkCLCo1pdGGJd2RmgJvsfxrJ/2TEYRg2wb6JMnZhvugpMtsXYdMackC?=
 =?us-ascii?Q?wSh+lOrVTa5KTHdpgpFghRez9Rvb9g7MBCeB6x9qbib30MD/HEJ8YMjvpBO0?=
 =?us-ascii?Q?OlyhuwRNESzdmu1SvzlN4Niz/ydPCTeZHZrtFRru3+XP7GAIwlX0laP8WFjR?=
 =?us-ascii?Q?6c4ew0nPdah2STF0vLYJBG7yWNoj2l4XrrqRVukABregiHg1bYp8CR9Rlvaq?=
 =?us-ascii?Q?PmGgKH5bsgkrChPOQ+O9zqLbJ9VeAyfv5ZG+i124v2by03stq68g8iLKVRkN?=
 =?us-ascii?Q?kvohAkRiI1mfsoNlOrnpQaaWD7evSDVea3SysX0/Iui662khcqIXdI+bsgYx?=
 =?us-ascii?Q?8f64Q3EVxVoLhzwn4xf6Z1vwmILlkWwyKA1SAefWb10VeTayMsby2f7S0Q91?=
 =?us-ascii?Q?xomHeJbt5oqRHPYY4vj8UeyfrqwMAd/0qY4c7KCOjPraoKH83ZMc4snTBGpE?=
 =?us-ascii?Q?coMIy090aiatkKn5hPykRafJXnMGh7++gopfj0rJr3rLUS9FE1tcONEoNRu5?=
 =?us-ascii?Q?z1VFKpSAPvfbsRCKaK6b5v0nYmZIraY3obBiIj4KWBc6ahO4tOLrMHQeJTpj?=
 =?us-ascii?Q?ypDfsq+oGz8jvzcgQrJC+sw9d8IK0rmgC/wimImWOWSHPmhVKJ79an/pCgef?=
 =?us-ascii?Q?/2ZwbE8UJAkf7//j1/IOSodACn9dz2auoPa2hF9nqgkLDHgM2GSQ9E1lc4+C?=
 =?us-ascii?Q?lvbFk9waEduUCoGdv9HzpXoYY/MTailwJcB81F0FP6Yupxzqj5eTHI+iNwgG?=
 =?us-ascii?Q?HVfWy68fDAo8Zvegld9zQKBOWXn+vahWWF7+sC7rUfXE1Sbtgu2UGVqb1bLG?=
 =?us-ascii?Q?KNSpI1P55A7nqVY0KhFSZHIrax+6io57hsdDHBUhbgrXXEYx95x9fEOtjVXo?=
 =?us-ascii?Q?QxSFd4UjnjnQF4iXzIRNcI2jh/ICq6L57T6VLyj6XtlQD5Zl+Kg+Gd0N2VpQ?=
 =?us-ascii?Q?W+RvOZi+FxyioAnt5B+6wRBQvA+kFgjYDcNRGBrExpPwi3TV4ScVVuh67bIy?=
 =?us-ascii?Q?MJQH4yjLFtoUrw2WfF3EZzOa?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc92f37c-de2e-4883-5fc3-08d967793cb0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 03:34:25.9489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ8NypasLW1sLXS8lxlEFw0f4vqW4e9O9C9zBupWwallHYRfR5I/WQDKNqStKBqgrEIKlsmvV/7PS8ngMm+9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3113
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 mkfs/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 10fe14d..9369b72 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -45,10 +45,10 @@ static struct option long_options[] = {
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
 #ifdef WITH_ANDROID
-	{"mount-point", required_argument, NULL, 10},
-	{"product-out", required_argument, NULL, 11},
-	{"fs-config-file", required_argument, NULL, 12},
-	{"block-list-file", required_argument, NULL, 13},
+	{"mount-point", required_argument, NULL, 256},
+	{"product-out", required_argument, NULL, 257},
+	{"fs-config-file", required_argument, NULL, 258},
+	{"block-list-file", required_argument, NULL, 259},
 #endif
 	{0, 0, 0, 0},
 };
@@ -289,20 +289,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 #ifdef WITH_ANDROID
-		case 10:
+		case 256:
 			cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
 			opt = strlen(cfg.mount_point);
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
-		case 11:
+		case 257:
 			cfg.target_out_path = optarg;
 			break;
-		case 12:
+		case 258:
 			cfg.fs_config_file = optarg;
 			break;
-		case 13:
+		case 259:
 			cfg.block_list_file = optarg;
 			break;
 #endif
-- 
2.25.1

