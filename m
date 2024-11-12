Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C109C5656
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 12:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731410678;
	bh=E/1/UxBloOLNJMsMuCZVi5UF3yiF3HPmHn1WM2SYY5c=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=lWDWp3LvvJ82Wl4wST/BPlfiEhMGJLD4SdKpDHyldSm8Sudpw3pCwNgaI0XlFmtUF
	 ajqCr1UsZ6qdFKagfuQLUbciovoMxQTsvJYHQw57zEDf39OOBbFOt9gFz7STbrJiXN
	 6s10B2BNMPPtW6xYlDAgWH8I76I1T5nRZ43i+5fhWJNRv6Q2c84pJ1joiB5mgICB/J
	 F+uwF/1yq0lSegXUYFpcCJtW4S7xzK/ghzI3NfcdrhAEuhzMdKdbIh5YkqATJJ00/1
	 9oNm+Lw3kA6USk4Y2RF6hf5IGmmAP9/FsMu65Qxm6hImydkmXyfvbDrrMOqS4PntJL
	 9qmI6OSBYTghg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnkbB1fZGz2yZd
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 22:24:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::615" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731410675;
	cv=pass; b=noMG/FLov69EUv1wljPHHojzmpbMQmuWV7/pywq8JVxKE12pEMhSaBXUGN+TKrWss7vYHVpu9M845b9OkPqUvg+OzWMbTW5anXyEn5n64fEP8DD4KBfXIDGEoTayXewnTr0ItILGQmdluhED95FR5bUntdflIh+rtaTaGhjD2f0jpiklxEsJN4K6p+lzxPqH1/pepmaG2giLvDE//MZbYYBfw0qHPv64iTI3kQL1q7iVvGTBKGMAM+JoDOa9lgOpD4nvZ4fIQcSu49z1dOtNOCFQmM35mTR80+A7khmdLfR6jV+jBrhAM5TGv/MlmETWGBsW4L0mhsBRET3Py6sFFg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731410675; c=relaxed/relaxed;
	bh=E/1/UxBloOLNJMsMuCZVi5UF3yiF3HPmHn1WM2SYY5c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cF7RGYEGUtGL+r9edcah2nqD+X+u38iXj51pnBgqIsg1JquGOt0+VtRmy5Kj+j+appQh+ZLIphLlazyIZ/blNwlJmEL+ZwWXmV2FwubvxDiNSJy5BFSSPMFGBZazb73yg1NsPmNHYruyc7w97dBS/BRR3AyJqBrQeWZ+QcYbvPOIty4Pps9ADRKIngflfW+39yjt1m9ZD/ipZ4L3JD0koXsYeHZD+zw359wUN3g39RJHmOTk0/6q7b5AadPbXfn0v07BFqud6sN37o9jU1TwlTRU7t5I5r0d+UIjkgp/UjqXcbmDZpikXdVWWJ3aOA/S8DQaGNqOXfM2CpWhwGn+Gw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=hO7wlBau; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::615; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=hO7wlBau;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::615; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20615.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::615])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnkb50YJFz2xZt
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 22:24:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGvaebhFllnpLVUTNxyQKzhBtxAQOj2hkQhkSZbPiDN2STIboy0HOphDvQyENZasa2G261SOk4OUcVYgbQPK4qO7O3vkpmBKH2gICFWUNc+RIgTjDxE+uijx4UOxWaMVzlvgRn8rOUrfE+JLhrVyNb9qKvISlPqXhmotBPWPKlX+MfKi9z8gy+BnY5rVgJWhKklO/jTGHiDUYv6l6ymWkhxOdehLkkP1SkAnKxqyOdAul9UJyCvREiL83tDK+jvFH+ZIxKED+Wayp+B0ZzPD6HtRdYqyQ8DoBnth+RkkNCvzBQO/Pialj4RdIGn02IYZrPGmVJpbsfzOm1Z0xNeBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/1/UxBloOLNJMsMuCZVi5UF3yiF3HPmHn1WM2SYY5c=;
 b=DO09jtMsqR1Xl5QmcFRZNRJKpl6atvPHZYv2cVkk3PlNyCqoo3xe3BxnlyJIC9P06LMmT3Ra8IF/1vNA7VhDSAZcrgK4IZEYjSapaUzsxXZO3uyojVR0gxjrO1EsRHF/cFeQ2mGs0nH1V44Jq0IwEK+8AR/CBeQOW5IVJr4UQFfAxqJEIQhZFRvf6FaZIWwfjQtNgrVCa1qUpJMu6u/LQzK1ugwswgpmH6ObGEnKRV9ZylxFuibDF7Yia0dXDFUhVVK6hdlOC+ujonOPq1UTcgLs7SmVR4QK1Mvy/vKiGh+AfO8TFzzdkyd7xvnparbOUtzfgmr36DNLfdT5cIRcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/1/UxBloOLNJMsMuCZVi5UF3yiF3HPmHn1WM2SYY5c=;
 b=hO7wlBauLTzYDMt0l/betyPfoNxmMFfmqJhA11PmKaIoKM5R/a/5DkkTpNZFsnFwyALeiZJUNaluQluKw9cXLOxLQgh/wjWxw9o/azpdqr0qGjI9LSPLIBI2dVDlFs2tXx3smyDc5X36D+MOqmjCXSzk/GnpnDnYr/WuJIm5Rwc2cb1rTmb0Dxcn8hRl44QbG58LKH3mGcFAo5iwf4sTYmtxvRKqKgcKBbtU+D3JceGZ9fiKhOMWyR4CIoC5fx6+mLWhbI2RXYtp4gi7Kb28r/7DBR7Lj40vF5TUnkfRIWxbgQhQ4Ezp1RuqitpazOVRZ4aa3232OHewoqc7Y6QG1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEYPR06MB6613.apcprd06.prod.outlook.com (2603:1096:101:169::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 11:24:10 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 11:24:10 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: add sysfs node to drop internal caches
Date: Tue, 12 Nov 2024 04:40:34 -0700
Message-Id: <20241112114034.618402-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEYPR06MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7ec70b-9820-4d51-443e-08dd030c8722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?SNwdJ3Mqo8kfX2DRWz1KfVsKRus5CBB+ZPiEB6BwQzSFzbE9v2e3Casn9jLv?=
 =?us-ascii?Q?ExVIXUbg4J79ZG7O1UjS9PQkF1/XisGDraEZ2YKHbIeY0/PBCJn144utlgRY?=
 =?us-ascii?Q?atec17zpLx59Tzg+g+Bq5TOksQLppvvjmR+48qmi6+rkDkgi4bq31WPoaUwW?=
 =?us-ascii?Q?1MukpUoTVLkrsc3zF77woOhylxe7dCYKlXNHsaT7jBs5EAHfTiwhZOoqqOTP?=
 =?us-ascii?Q?i46ByWl9RVKo6QyueHgUU8aqsQQa9+yqYGOb+SYGKPlPe+lhRAFX1x1Q9Nvj?=
 =?us-ascii?Q?/PRb6bYIKkwyy4G8RJ9rU8HK+JZ5ydZYO1yA+vga+7p3g4EeBrHZof+MmjTp?=
 =?us-ascii?Q?UOuBhKmDvNA1wrzZAg+KOhDK2rM+dpNpZEVhkKVjuVKQS3+gxMCrCXvYRtK6?=
 =?us-ascii?Q?ZzRHDHypYM9TPgABOVYilMjj4hhyC6R67kAmMa5EHjRv4hGrFSH3+aBN+ZOF?=
 =?us-ascii?Q?P7BdNFq33s8AK9JNTSty4+/gNxIiMkr9w+JoesaLwmmocP84lyC6sxELynuc?=
 =?us-ascii?Q?VysxrUsc0Igm8CZ5R9X94AKmZ3PgtgqbTwN4MBtfjnduJkPmihLTM5ILu38B?=
 =?us-ascii?Q?IqrfdRQ2GXg36rSfIMeHUqKXCUM4mrHjGxE2KnajDLWkgKAaGoK6lqliNSlq?=
 =?us-ascii?Q?IdnFvr/RLhIYC69eAfm1CRiBKfoYIVMLJnF29rJZPoV4WXUX/J8APKcGZ2x4?=
 =?us-ascii?Q?M+box+dNUWSPzq+cyCpuxUxtNydlerO6Y0DAt2z5Q4x+jBWi+0vMaPBssiOS?=
 =?us-ascii?Q?7FR2U6mue+ceN6U/zKkYmnmWHjfDZ2nDBaJZslpm1oGeSV/jAF2Q5LIXelXQ?=
 =?us-ascii?Q?CviO0d1TVCHaGx9f+Mij0Vk/my7SMNLQMb1CPw6wnMeoFLPo+pZH1Oxrbqob?=
 =?us-ascii?Q?VWpeVE0ilMGEBfqCSCIYCnzQyC2syo1/NrgJpU56pYxjekgR0uUAho88RS8c?=
 =?us-ascii?Q?Lpblkok5DOuyFpY7hKesDvG5MCLEcWP9BDPO5QfQ8WCYIjDsz3HfYXlYk6/0?=
 =?us-ascii?Q?oMSdIvq/dYNK1OGoqrhTk40YZZVRv7ZUQXY3tFBurUiMZDWgyoVgJR+J5AjN?=
 =?us-ascii?Q?G8CLUECCZcbCTbxXEDeFGvakR38DNhrGJO1SdZVAM4CeAtBXapN7TOnTGQT8?=
 =?us-ascii?Q?Jgioh8VWfP/CC0qjQ2bMAksL0ylPw2qHcpcBPt10585ijNBe29Agec8sENlz?=
 =?us-ascii?Q?iqeFAyJVDspAvzjNfgWuwRg9+iyBaIxxyZ8LdoYE2aoH0vQ75m59d3a2YybW?=
 =?us-ascii?Q?dXPrT/gWEtFZbFFEYVSSLPJNdB1VKsbgrV4psn/K9ezqYbHiyur0wsKgDx7X?=
 =?us-ascii?Q?Tqros3MjIGMbvuWJPtxHLTaNR1MLkqIiArpQkcrGwEpf5NJSUZAJMbSqMFEZ?=
 =?us-ascii?Q?u/p2ADk=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?HbJZDJoDFq2uD3fGruxNEYL6xVCFxWlgz99rqJIuLVf7wb9NJRTwyVXuzdfS?=
 =?us-ascii?Q?pSWLnf6Quwxbo71JYHV0ICnpmaRvs8VWm4gDI7bmtsK3NNwPdNEzE3z2bO/t?=
 =?us-ascii?Q?kSKMrPPBGUuV+MLSqTyKu2QP9jMbr8KHsMGD6I73B4tOtpLFm71QckGTnWE1?=
 =?us-ascii?Q?CKwjNegG7okQBDgATIU9y7DbjPo2hEvGv97BLp2Onvonhn0pqYNRj+uaQ28r?=
 =?us-ascii?Q?K8DQEf7ApI7/SnQs5tynafV9cBXGmnj/hbLBTRhu23JA/c0CR0TrrSkCZVnF?=
 =?us-ascii?Q?VVVApKJ3JP3XyytmcdXiR7QwhA9pgbcDxSsbyQ023r9gMMHg1oRmnJcd9Nw+?=
 =?us-ascii?Q?Tl91DIHxzrqF39oE8shqYleOqhZL87zp2p5bBJ35x2qbK4D5WhvQNtqmbmrI?=
 =?us-ascii?Q?kD06DB5ji0nxsKxSOjA95JKInDNKPTDpxUNKZk+6hs7mrxwuJVIpSCa5s2rG?=
 =?us-ascii?Q?3MgsYWPdEQurBs46besZBaeKkb2EPw5YOYUGTb1hODSG0YCA/JkCl5PZbm7B?=
 =?us-ascii?Q?Xrn06DQDECoE3bHiiurdw3dpDgONGeJS72ZdhjYzI/I/sc0q+zAUxLt8JY/j?=
 =?us-ascii?Q?1k/gEAe2tULESalI9Mr96T1awUioP8TldG29fXhx3eWbUHr8D9HsQw2m7vP3?=
 =?us-ascii?Q?PxRWkwniYH538Dk33NvzbWOiJmyHWRWzk8Ku3i7RkdX1fPLI5oVIh5ZtGO8a?=
 =?us-ascii?Q?JXoFfzdC/vVzOQ/iMtsnrWCk0rOEGmM+nWkZm1JGW/+08oNEJ875DRIVGn+1?=
 =?us-ascii?Q?LwVuXxyr1D4Sc7YuFmVB0h7vHyfuVK/bKN79zbfvXHGxuI6di9OTvzfFK9uK?=
 =?us-ascii?Q?ICs1S4l4E1AuK8G/cWKTWySxR1QCfoSUpinVSQ0/uxWyt/nqr+pPp/Ar74yh?=
 =?us-ascii?Q?+Ws0nhPtOTjSCt6ELxeN69FFr6gXda1WqJitLdw5FPQS4XXpIMhr2DNYKN0s?=
 =?us-ascii?Q?8hEo6XrhR0UUM1oGTfltE4P5pDIMdyxGfEDPnz4f/8Y18CKkLzg9l/6Tpi6d?=
 =?us-ascii?Q?oOdvXJ/3MNvB73OsGCJ+pDBYmlW+r6t3+OyrQ6ILN9KFijvmpbhXnJ9sIqxR?=
 =?us-ascii?Q?kGyCSXqxJoru+RKON8GccRrXDyh7RWyuPxvWgpz1b5TlnurQLK+zCWx1ueRH?=
 =?us-ascii?Q?9uzuK1R18wnzyW3bv8O5sm83PhvEG2/4yQFEdiPg89X31njVY8UmVFwYwTjT?=
 =?us-ascii?Q?Bj453u+wzEF6LlGc9YuRdwNrgv9Qgrg6aMJDd8fyjjFS9kGfyvs/NAJRfQV7?=
 =?us-ascii?Q?S7AYsS6WPYLPe2/A86m4fhRKRI61eGjCTn2oa6m0wsQQXaofLC1+KjeKnq19?=
 =?us-ascii?Q?r3CerkfppAH0Ws6kOWgSDSFlaX7LBDcwaYW9RsrMXvocJ59OK6KThsV/l1e+?=
 =?us-ascii?Q?dQlKVJoZRZbuChNiFLQ/F40zpfBDTSY1UrM4oWzhogcnXDo/XX83T9niyTDo?=
 =?us-ascii?Q?r/YupfxEfyQS+aVwtn+nFZiBQ6LGZ5DLSEiGVgOKzMsC0r7JUhw4qLnpwqRE?=
 =?us-ascii?Q?X1bpJ/K9KdaX7B9q/6zM8f1kbqzbf6cikhrFO5hypfrX+65BqVa0m5huEdVw?=
 =?us-ascii?Q?pe6h62EY+zPtHqDtHRaGy3UvC79vq9SeAQ61rUkg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7ec70b-9820-4d51-443e-08dd030c8722
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 11:24:09.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHMWIDkhNEju+MAYPmcuYMKYjmtes55S4HI8O+e1YJQjAurBSElVSGC5RJhg2lhoDmuwmoHMPlfbSVR9xEQ0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6613
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a sysfs node to drop compression-related caches, currently used to
drop in-memory pclusters and compressed folios.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v1: https://lore.kernel.org/linux-erofs/fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com
change since v1:
 - Change subject as suggested by Gao Xiang.
 - Use different bits to indicate different meanings in the sysfs node.
---
 Documentation/ABI/testing/sysfs-fs-erofs | 11 +++++++++++
 fs/erofs/internal.h                      |  2 ++
 fs/erofs/sysfs.c                         | 15 +++++++++++++++
 fs/erofs/zdata.c                         |  1 -
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 284224d1b56f..44d863cd07b5 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -16,3 +16,14 @@ Description:	Control strategy of sync decompression:
 		  readahead on atomic contexts only.
 		- 1 (force on): enable for readpage and readahead.
 		- 2 (force off): disable for all situations.
+
+What:		/sys/fs/erofs/<disk>/drop_caches
+Date:		November 2024
+Contact:	"Guo Chunhai" <guochunhai@vivo.com>
+Description:	Writing to this will drop compression-related caches,
+		currently used to drop in-memory pclusters and
+		compressed folios:
+
+		- 1 : drop in-memory compressed folios
+		- 2 : drop in-memory pclusters
+		- 3 : drop in-memory pclusters and compressed folios
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3905d991c49b..0328e6b98c1b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -450,6 +450,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+
 extern atomic_long_t erofs_global_shrink_cnt;
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 63cffd0fd261..01d509e43827 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -10,6 +10,7 @@
 
 enum {
 	attr_feature,
+	attr_drop_caches,
 	attr_pointer_ui,
 	attr_pointer_bool,
 };
@@ -57,11 +58,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #ifdef CONFIG_EROFS_FS_ZIP
 EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+EROFS_ATTR_FUNC(drop_caches, 0200);
 #endif
 
 static struct attribute *erofs_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
+	ATTR_LIST(drop_caches),
 #endif
 	NULL,
 };
@@ -163,6 +166,18 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return -EINVAL;
 		*(bool *)ptr = !!t;
 		return len;
+	case attr_drop_caches:
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t < 1 || t > 3)
+			return -EINVAL;
+
+		if (t & 1)
+			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
+		if (t & 2)
+			z_erofs_shrink_scan(sbi, ~0UL);
+		return len;
 	}
 	return 0;
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 877bce7709d5..01f147505487 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -119,7 +119,6 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 	return PAGE_ALIGN(pcl->pclustersize) >> PAGE_SHIFT;
 }
 
-#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
 static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
 {
 	return fo->mapping == MNGD_MAPPING(sbi);
-- 
2.34.1

