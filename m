Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35A6A8FBA
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 04:15:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSY4P3Mmsz3cNG
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 14:15:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HKFr+bJw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::70a; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HKFr+bJw;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::70a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSY4C6ZcWz2ymk
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 14:14:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW9OB7PpYassP/qQFvFRR7ZYR9oueODpgixj3k4eqO4aqUfNTPR3ujpJeezzTYn4YW0CYH9OXxkDsMIY+rH3R+VqtuONfGQl8eiJAPmRk3EIq0F76YoPfb7647RGwC3KMEqq3lPPlWynyxbeaAF3J4M5jGD4vO908g5WgeO6fSahLSNbcJtkEoeeX8XjTh3PeaS4CLeoZpnlbHsHCCBGy6vPxjjkmzgUs92H7vQIf0XIHn5fzKGCe70mqV2Iy28X6tLwEJvxTd24TqYkWtMV6LLX0S4s25TMc5KAFI7e5zOF7nTHD+9ZsQxWIv4BAPUelqacg726UR3aVs86m+ivNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htIaonteASquIZopdEAhRBYIskX7U4t2h/T935emIBM=;
 b=I0vYCqaRHdiDGrf9XdjXqcvBDmKn2GBqwfK9G5ERL7w0o3Eks57LHx7tuDOT2Ew2sJlR1ACBbWtGO5tJsYzg5Jx5b7M3EyIAAtwWiMv0piQ+5rSA6TY4UUdHklqe+xBThkU1zcFeJvO8t0yzJafuFqKClrN226M3Ayl0nWOTIAa+qtpL4409R7bJ5bz2TxCVAICmXPKEKQmWuroiihx2syeHPfWF1aug00IP7RV2fD+6ytRMd4mjZbAo1z3tvksC+enskgoFJP9cN9UaGUyFCDVZYN1z4KHmKDIZTXBenVGWN9ALP5eKaLZrjN8r6vIOO+zRXPte655Ot6dMQHLnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htIaonteASquIZopdEAhRBYIskX7U4t2h/T935emIBM=;
 b=HKFr+bJwHFtsptu8r1oD0oFOZJ68s+TakZFao4B2vujJxLMUJ/NH9WJTRMPzkgkKMZjCupNnnIfWYpEiuch8zueIht3icW/5HEWeA+tL/01xyuJSCr+zFq3bCLETLUay05cuq5B6uMsAOwN/vGRXkb+4i3Ved9I3GYw6agegzugXMHhrTogpPANDCVhki3nhfotN7b/0NRA2l58ORFLNmd7COqQCeac+AR8mMv479CucanGgeziTwUg0gZ7Er407v/JB4g/+MUf+BqiZDCoLOWX0YpavvV/6q+v+LUR7mMFr2uwSK374P8kmKl+8chA9oOIDHq+aBCbyKwV3vbaAtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4038.apcprd06.prod.outlook.com (2603:1096:301:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 03:14:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6156.016; Fri, 3 Mar 2023
 03:14:29 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init
Date: Fri,  3 Mar 2023 11:14:18 +0800
Message-Id: <20230303031418.64553-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: db02a2e6-9da2-40e5-a80e-08db1b9566f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	fVZ+ZVjPNH0fzvht+K/yjia9J5kJJzl9Imtvu+gtuvpDOhSLaakBlDEjQ7vRts1U+jmnsVJUS6RE2wMoQlzLy9ux9/zjiYrYTgfgZx6IbWmVA33CQrnenAIhslRGH/wt0HcMCB1OKCqRIFk4twf0Os1X9h0xYKh8bXPuylOy3Hn2seEtinpPOKR9gCB8/qKQn8BvK08LCJZUHKbwQ5PgDxLHmqOOHGxmq1tJxCNP4OObbOqKWgJ9j7oz+g7G2UTI4ZeySmCZqw4y9okFccgxp+L2FZYF9rigpwja447yy/tXTjKPDmVFSmdLxaX/EwzGo2X8C8JOK2sEkW8cmgLXjlEEgXlO7bmWKs1O+wu9C6g6AOtV/dqTftyM/lvc0QJRDuvqGwmzJpIrM5jDt74nK7iXcKnbPIq/UOeCJ8l9yRtFq5su/A2bWb+cIaUV1OwSgVK99nju+AHkN6FCYfvPmOkfmmbuf3zafMG/PaODbJClrVKmI3/mzlY/TKyfMRjnIaulovjYEtJKdcuagUk54CqQSdVwIXQKz96dOR8nEV6CNLypONdMk69fmvxn5AZxdOzFvqnY2G8aRlVSwS8pFzNZ2CpwgfP2nbd8C3hZFPQXTNrkLazcEZKU15dkRPImPxfJaNgWCNRkAQKE7F+b91520hltgoxhfvP1U4bSerlF14EQ66ebU2/YfuPFN9t8qn4Zarf8wDP3WTl0PjjzAw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(5660300002)(38350700002)(36756003)(86362001)(8936002)(66946007)(41300700001)(8676002)(66556008)(2906002)(4326008)(38100700002)(4744005)(66476007)(6506007)(6512007)(26005)(2616005)(1076003)(186003)(83380400001)(52116002)(6666004)(107886003)(6486002)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?7ehR4egpONoH221Vzaro2CI54vzoYW3c5dFf3GxZ03XcLVuHwO77l9Ei/o3A?=
 =?us-ascii?Q?XIFAqKY8y9NiuNuuq6QFUnI2niMZifnfekMm0REIb50uHz9B6um1xoyhLq9s?=
 =?us-ascii?Q?9OqGIyPOTJdTw4FmcyELGk3b0r+VRNPwL0NZvgbUPz2jiXcGEwsKgGMjY1rd?=
 =?us-ascii?Q?exLMUmgWckzy6vFzq2aY2P8DDqqeuBWvTP4wlBkJtzdtW/bKd19P6Dfp6l46?=
 =?us-ascii?Q?yT0aAj7a1uXC3ZRzXo/44nfvrxk0VdAVtqjtQAidVjL7JN7qRC0hIdADrrRY?=
 =?us-ascii?Q?DmkekV4uNmC6d3P9hK6N2XFyc8Nkw7cY4E4OP/ST+BJ5jqvd7txbsShWzIuq?=
 =?us-ascii?Q?uzO6bq5D/g6yTpGaW9gLXoyfilPOQjjbs3yrL+7FnM8U7Nui3EnpHgjGUCgT?=
 =?us-ascii?Q?LKfT3cwMjwQpDqNOScOb8JlgR60TwugKD3pts/WhvL6CaShECnjzc6/RlQ0T?=
 =?us-ascii?Q?B32QOSaXqQrNqwvwOg5HtqWmq5UVdq3U+uCgO6jvJ3CBwAOAZrPHFmxEDLvr?=
 =?us-ascii?Q?aJmR7SeQkXEDQ6I6sSnCjXS+I+YE0L8L92MX/g0qmxt4jZBQFP5bf+oVhtO0?=
 =?us-ascii?Q?Yqfc/Z+OIim0Sa/SWAVdZOyUqYgFK+l0zCX32MAN/ru9wG/Ib67V9TktjbBR?=
 =?us-ascii?Q?WvBz9D1y9ucS8/V4UAd239edRQZ7izJ9x5YUuZW//NTk7ePuuA8gtWYO61OC?=
 =?us-ascii?Q?emi665cmSVaMW1ixOw60KElQ8MuY8Z2uAUi/8pd/y+XnOt/w9iTlucXPfym6?=
 =?us-ascii?Q?XBonQiYBthz+YPfJzHEcmowKaJrKBZQuYHcdmbaE5RLgFqM9QheeHXwYy2nr?=
 =?us-ascii?Q?SkR6Kd51gt79HO4g67fX6AfbNNw8jP1cHk4BD/0RMp/iGv1F+l7/MbWGyt2U?=
 =?us-ascii?Q?DlmDKst+mVc1CewIhVtslJ3BdTT9EtmqFlYptfwz2veEgYuWapuDo3Kv6mWw?=
 =?us-ascii?Q?vqDsbiXjL6yJW51LZ9gvj12ltBuxXc+UAWhU1y9nlwUYgYeNBmD9aICK3n6J?=
 =?us-ascii?Q?ptvREF5ej5sCXQMO7nzqUiYqTd20hO+24c1CODMmvIbXsjS2Sen05X1lmDHF?=
 =?us-ascii?Q?KD5eJCc25PiGxasee3stpKgEIF0fICHyS1l+esrnn46m6qNumlwSflBpXVUo?=
 =?us-ascii?Q?Oi3Sbk4YwPRwQLaROu1CVpdWUtGWR9Z1litw2LkyzuTfrRNl63P0XwE/MEn2?=
 =?us-ascii?Q?ken30HY0q2SDoImDafdDf5oRpWuG9Y8El0aLtreAUw6paOYGIvBEArRAD8Ia?=
 =?us-ascii?Q?aQEnhwp/ruEONz19hfklHy68LUg0EVcO0PUdVmQkoplGBnzM9byDL0+hjh8r?=
 =?us-ascii?Q?Ocd3zDA1VlI5CpMrcf9VeBSe2BjUe4iNfSHO3YBxgbTJWeU1gTkcwv72Bdrl?=
 =?us-ascii?Q?zREQYV+r1lQssCWqk4kxE8ZVGjmwsRdNkG/8nPXcASnSlFUmkoLdeIwv7DU0?=
 =?us-ascii?Q?w50XjAtMt86mG2DBlfybpmF1bH64fGxzM/xoDRe0/Omj9B4utoqpZMqjCWoa?=
 =?us-ascii?Q?zNjM5VvOkdjnV7hAll5LUX2asD9uY9pUs/2lHtxeNRnvsnBq3dfuqJML50oI?=
 =?us-ascii?Q?PJpJS2CABrMelCDT33GHZoLkSx6kw3nmPF/ubS+l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db02a2e6-9da2-40e5-a80e-08db1b9566f5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 03:14:29.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYc3At/dFuW0QU4zbjKUoIOHXvSfSqEFzBtxxwPb+2gDVQ2sjeY++cFzCz89USP3yurh+3fbc1ZvkLAHijXBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4038
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

They are used during the erofs module init phase. Let's mark it as
__init like any other function.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/decompressor_lzma.c | 2 +-
 fs/erofs/pcpubuf.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 091fd5adf818..307b37f0b9f5 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
 	}
 }
 
-int z_erofs_lzma_init(void)
+int __init z_erofs_lzma_init(void)
 {
 	unsigned int i;
 
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
index a2efd833d1b6..c7a4b1d77069 100644
--- a/fs/erofs/pcpubuf.c
+++ b/fs/erofs/pcpubuf.c
@@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
 	return ret;
 }
 
-void erofs_pcpubuf_init(void)
+void __init erofs_pcpubuf_init(void)
 {
 	int cpu;
 
-- 
2.25.1

