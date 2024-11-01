Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 007129B8B32
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Nov 2024 07:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730442229;
	bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=BBene27Bu+1gw5f54rlpOHSj9L/jeFC6sKgINNpbShE6k3/y9aIBGX+4Jcf5a1G9H
	 71onGIS/fAGe34tfNio1Uv13cA/Xc6Q1lIOE293o+y7cP9dWoVBfID9WTHlkWCbJjm
	 Hb6XvAbrnGjKkJvMzvzPMpt0HDl1vu12PYGDSbMYnBl3liXoVozNnCZsAAOAGXX5bC
	 b7EBnKYoDyvgh1NO6ngPynwOI4llSg5kiS7SL/6L+xSrOEoUXnNAj2FZouxZSpOsYM
	 rWl3HBux0XupLCQmbBkhHiewIjcBoLWh9QMGnBx7DBNvKnhqHqHZmcoKETxbTP4Zyt
	 MoxQrhFe9cPwg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XfrR96jwZz30Ns
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Nov 2024 17:23:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730442227;
	cv=pass; b=WCYMJCnHR9hcI5rwKyr8WI1olq3f0weZudXEyArCOxd5Hgr5XYytMAIdCfGMOz9YarWSs6UTDTeA74XSH+Vdj6lWPIpoDCct4vUSaOo35UPo54Vwka3tvfuTw6B9wVJXKWFUJXzFFDrl1e9VxxreJ+ruOvcoStJFWZp/D5U6uSMHTBMewJIbwvYTXB35Dp3oht0U+PKUmQ5JwoVvLDxhYdL2AQh/1CBU7nRE928nakBzeFBD4YKxOJkedDOhF8Gz4phf6lQLwGnatdjMihhOdxO1ETYdFTE4D4w4yUCP5lO0g/snAYXWiRKO0pSXGfFiEuhPVugOAMiZDo3tQBD2sQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730442227; c=relaxed/relaxed;
	bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=THumg6lAUQxLxwZV0rkaUchICBjanJ4P60uloP/f96Y2ybfNVhuriCca6GMKEgkEq4uATlc1fFM0bGL3H6apb2JbZxeI6Tt4ACm7RkknWgYwpsiuJ8oKnjMrs2Ve/YV32im+vKYN1xe0NVxYDG2+vHCEW6+tRAR3Ig8hCXcNTCv/2KSPiYOc1b21pTXvX6VcVrLWmabefFtsg7iwSXPhvNlZL/ogM/Ohj5VkkPjb6dCrmpqItdldW+ofnMSE5yGBpTvo7sgBGCfufkbfR9NgNPYGWewmCaRcCZy7li+j8623GRpLcxo/fryZm5tF0zzT9EPgC3x051yl11UNDXfmZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=esOz+Cu2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=esOz+Cu2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XfrR46HYDz2xxy
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Nov 2024 17:23:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYAr4KV8fEM0ywRA3f6xyE8O1ZDySrfUiIJg1ODgCJ5vtG73iU7v1EIx0oI5oVEOOGJ4OtVQcq1U/wiLVsPEhdOTRbi57e+9WId9Z3+cZSP0Vn606TRHvA0OIfZD8UrZf4X6E9EMQw8UaQtPlin9e25dXcXS6f7SY3Qy7NpXG2tj+pJKrUH/Tf+2FMBaV7oiRJmGg0dozHtscy4s/cQnLJk+mnwEd/tliP6YaruUXJMpmw1+atkj0R2gQihrzbDwX6xefTL3gSm66Slxywfdfhncs/A7vLK9GxYBjS4jhJyV1uPbyVMOtD8FEiIbrz+KbezSz07pAjmJ0aQXIVLVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
 b=HEol03gd4ms9NIpWscD+9QcEloS3EijVPpS05/IFKSJWs6DRPmlqtSyl/rvzWglcrvq7U1h6cTfVnl4Dj1CX0cgC9My7PT1XPYqZIHu9n+edWZxl7MdSz+jpe4pIuB+7TQw++uuWd2Re+82Ubi3z6uVPjYw0f2JYLcHk+6cCPZoC1iMEV6TU8vdk0M5Hmt8w3Bt5icHQauxEy+cLyTIXgdJp/t6IXz9jHE8CET+cxdThHGHWWlqdfg64zELt5nM7t8s0W/b5WMTATS2MvqBpE8ncltuEFgQGww6Pi+a5qkSNFYTsbacj/pVe9hn4zhtvtKN4xIIX3pLL/ewVZ3Ke/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
 b=esOz+Cu2UR+vfylt654UqfHORQ5lYrsQkAXyEUyJVXaygxkUngHUG9fY2Z9lrWIFINwBUHYqlWrYqUygmG6MzC3+RIwZuhKdF+3N6Zl9mRnoFdTeSl/84toA4F2CneI52pQP5Cg2seOXc4wEQFYMUJdde5C/kL27TLuSC1Pum3YnYBtATv5HAhi7Q7gR3e1/yVsQx843jqau5igDTVwhjfHhCCaYLq8ItPEYRPpyBLZT8VU/fhwSI38rntkTFInnY5qHBv0jwhFTgYH0TnLcFRU1DKieZxLXb5WLZGKoryZTaXwDTayzNcS9YwkB5iMkZ6DPl+DeMy4U3VhCKbdq/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB6321.apcprd06.prod.outlook.com (2603:1096:820:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.12; Fri, 1 Nov
 2024 06:23:16 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%2]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:23:16 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: free pclusters if no cached folio attached
Date: Fri,  1 Nov 2024 00:38:21 -0600
Message-Id: <20241101063821.3021559-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: dda2d886-21c4-44a0-f81d-08dcfa3dabf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?R3GvzyzIY0YqIBeyy/MXXLx3MvX2CS7knMXztNAgJNPfAespsaNhF4bwB5w5?=
 =?us-ascii?Q?FHJAdcth4uGfU9ohIX+kMF073lOR1CE6atglFTvYj1ex8X9LrHI0XpzNRmbq?=
 =?us-ascii?Q?vhPoeePB7LindOf21r79E84tiLlpyo63lqXUdSpunfOZstji77MS5QXIg0gs?=
 =?us-ascii?Q?rJmZc5B3K48C2Ige6qwMmS9cjhnEGiCpF90/wxKvDDdA5/qHq0ABIchXupDE?=
 =?us-ascii?Q?c4Uqu7DVouxid4G3/G6LW7kk8mFKYH7tDTfbAc8+dIZXGXple3uSKvCVt5jZ?=
 =?us-ascii?Q?iEu25DiNrT2Zz/4y6x8oCFvYUwc/2qpy2T5Fk8c6RJ4atNv6TU0GWd7KLBSC?=
 =?us-ascii?Q?af3+D0uEV9ZWmSRZsi9d8agUIZJ7Aqp5ugYYm4hL99/JLg3u8ZDw8OQHONaf?=
 =?us-ascii?Q?wI9jcLBFgl49vv+UmzadG7hre76DJWcxivzu5/bJTbcHt4A/VblvFjM6GT9i?=
 =?us-ascii?Q?inzo49ZXrxEdHixeHROkGRlEk6EfyqieihsutcM9Rqq3e696lThxRibWwUBw?=
 =?us-ascii?Q?1T6Js7qnGN1lX0oT2xH2zk+LWVnzuU2ohBeXGGZ6Rro4wlPm5WAp5sdQO2Dp?=
 =?us-ascii?Q?WSDYV8/9WVyN6VUst31tHFt0HHXFQOgq93ZGaF2aYALyE3rXajcZeveLbZHb?=
 =?us-ascii?Q?diI26pX23Q+ius/OqfUesVwPEYSgNj+uVXlB4EPsj+Il6D7nT74onjotpM/H?=
 =?us-ascii?Q?bXcqZPnrOBun/JxJE2F977gm2UX64i0DGPfaNiPkKotMMSf1y3jrjWhf/d3U?=
 =?us-ascii?Q?LqXgCa5zTOjW3AqBD2fhObetToRHGvkNvTpupnpiWg64zycXPV0gggt3nFcm?=
 =?us-ascii?Q?qRLBHHXqR3KEr3MfeM80fKfdnk8A87iXR3DY1qRlJwqKyoMeHQuFD7DxfDOJ?=
 =?us-ascii?Q?C07NeltjnAjzCHyo2630nG/iHz7xaTv283B/L+W+k9eXuZS8n3MYQjVQO3B4?=
 =?us-ascii?Q?VbqXSDXwfNQbp64tqpZtGmGzuyJWDpRV3fa8SOvn86j6Bf9eaDnYTo8CKL83?=
 =?us-ascii?Q?D24VE+zuqUvOJU6Se47egDCzH8Q8M5CCwJbpzpivnwxvN0iQsZL4lEQELcl+?=
 =?us-ascii?Q?2soM5bdIOr3ZqXOpViNZ7mQTmBvuaY0UiUrYQvx5aPel8ADfJBI8cuecq7yw?=
 =?us-ascii?Q?eMdPePtUdpI0IW4HB2KizWz1ReobD0TAxvBAXK/v6Sdl9Ldq6CmaTxY0MpCm?=
 =?us-ascii?Q?TPFcCLsL4sIP11I+YTx+owKop5c0dYuyMrCxTq9yfNXO/dnE7PBg4Abbpq7U?=
 =?us-ascii?Q?V0T1GTG1CiVi9FbpeH8JEWD3g2xtORVYMFidu/HOxUaS+DS01cD5OnXy9CZ4?=
 =?us-ascii?Q?CT9xfQWKIA6aLxiDJHBaIhEGIgbJXDfjKHQ8KfDNfmj1J2SDwb25uqRW2fWD?=
 =?us-ascii?Q?aWM3sqrrHVb6cpdWvjdBT20lKNOO?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?RrMWwl4UUS73KbO9nbnsI37TTirCpangyv/SarrZ035CYGLxW3oaobWQl4Qu?=
 =?us-ascii?Q?5K+KESttzNseI9xJ2esu4y/lWk7/wz7S+YasYsGYrcA5HH2OqBJ9dKfFUA//?=
 =?us-ascii?Q?iHVkpGKbJ2Vo9ukbRs2GPvxapKkDTyXvAPy9SKSV6dhWE/Dn9GW9V1vb7WZs?=
 =?us-ascii?Q?viS8q+Dv1wuniPjyh6EwQe+mlK33y4xlfiJjrUVm3LCpfZDS+ANir2cas+9k?=
 =?us-ascii?Q?X9/L/TQLZ644KU3/Q/312RFiQwF7kkJXt8MjTZOvjgxycg2TYs98E6I9+my4?=
 =?us-ascii?Q?FNYuF6HojSrenkNdbm0UKS0F+f94/lhLoHrhsBRkS91jaxj1ICY59s3WzQGZ?=
 =?us-ascii?Q?D/kqLnZM2/FspCXR7bO5Sj30DFSEDMrJdGwYMszbb6tR0fQNR+G1/CPVY7mK?=
 =?us-ascii?Q?jXE7F6RHJXRWYayCdl+If2RbSRgQJBQmo8aty8zaZJyxdPgeVTcPE16x93V1?=
 =?us-ascii?Q?6eL7wqb+rL2t2gxYe5eDw/8pWv88DCj5PkKv+mp6Xn5Wne3bUS8oJUwqAvTt?=
 =?us-ascii?Q?kg5xD4knhSuB7RfNSV7fciJtBm2YYgFzgO4xxhOcloKJ2i34nZzkgIlVNh6o?=
 =?us-ascii?Q?eqogL5qPcYY2V8M5ny9KMWXYL6C9MYCeFANbJVvKplYQSz63PtNra5qjbuTd?=
 =?us-ascii?Q?HBaSahLzf1Vn9WZvuVyzmmzxOG3wMvASpw/JjUxXFeVlBrvVd1wqCT8MkxP0?=
 =?us-ascii?Q?aKbC/JwdAkLixHso6DMuCmia78wt0Pb+Ngyu08z5dSGxcJFQTq7dwJbqwbQb?=
 =?us-ascii?Q?DKC/6z88WKY3XOAigwoXSupSovKXKWVpPy5oo2LWTmNiQCVC58PNjAGXUuhy?=
 =?us-ascii?Q?N4ZHdU3GQv3gMXvc8oXXW6JZ8koOSNkNXKq+iSNLKUSSbxeb26ZLTUbpDdIJ?=
 =?us-ascii?Q?hZD58eIPYlVgpsBgpi7+1OH1wkqhBQwKUaWUc9Q2B2WQh+YjlqJjmlAH35eo?=
 =?us-ascii?Q?d7enavqUKZaICIzgWPLZWGV7ut/9WqxoqWySERfCoAX2hL49I/+Rc3ZPFkEc?=
 =?us-ascii?Q?a2ng0+T/F/KOxn/G3zkCV+8ae2FzlqRZTCA8k23qlDmU8aUuztUV50SWlHEq?=
 =?us-ascii?Q?i5LZ0mHnQlCzhp6jGr6u2bGpRr0MlExXNZcKf5Ox1jumdkSsFhH2GmfOiP7a?=
 =?us-ascii?Q?RhVKCe9MILzmPqlS9oTuR424fiqENmNkbMHESp+9vOcjcVVwPIk59RXW9Bw4?=
 =?us-ascii?Q?O5QGxdFTk8ciI50LVE2V1rXXySIKEuEX35u8vW0dNNgkqZeATofF0xreeaVA?=
 =?us-ascii?Q?XCz4pstDGvWJPEKGXTMJSAIa/rKJ3RffVCNfz2oLh7bl4/wJvBqaXT5yNqn8?=
 =?us-ascii?Q?uLQm/41PxqSVDDk72suDDpWlyuI4ETLHxuXaxQsF8imzDdBkAHsIzT6PBmny?=
 =?us-ascii?Q?4TkjcFxHpG7shAt2h2D3GMb02oPyk368zBJVeFNAWwqeNooOUTlKvcogchCz?=
 =?us-ascii?Q?M/8m0KhcsnUSh/g1ttqGvjUdi0MmBoJH7Cd0aDvErVK09mqkEUgLLJPY+dBQ?=
 =?us-ascii?Q?nQKiP9xwnFvwGCmBlm08eWr1vJs1PhYB7pU2mSqX7T8DjRiAdwEjgOPkY7Xj?=
 =?us-ascii?Q?lGsGYFW7BF9OBMKQeXfpzCP50GnGMCi50IzOCOyP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2d886-21c4-44a0-f81d-08dcfa3dabf5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:23:16.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiAlmyD9Z+kgpQjwavTXLEEgVuMN/jfb/xYrvPcUPobXLJOuGoNFlSohArklEz4FT1IA40kGVMBDJTgqoh+bDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6321
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Once a pcluster is fully decompressed and there are no attached cached
folios, its corresponding `struct z_erofs_pcluster` will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for `struct z_erofs_pcluster`.

The tables below show approximately a 96% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for `struct
z_erofs_pcluster` after applying this patch. The results were obtained
by performing a test to copy a 4.1GB partition on ARM64 Android devices
running the 6.6 kernel with an 8-core CPU and 12GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   11390   |   390    | -96.57% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 133612656 | 4434552  | -96.68% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 59 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4558e6a98336..1a7f56259f45 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -896,14 +896,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool erofs_prepare_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -911,7 +908,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -920,8 +917,18 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free = false;
+
+	/* Using trylock to avoid deadlock with z_erofs_put_pcluster() */
+	if (!spin_trylock(&pcl->lockref.lock))
+		return free;
+	free = erofs_prepare_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -953,16 +960,27 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (--pcl->lockref.count == 0) {
+		if (try_free) {
+			xa_lock(&sbi->managed_pslots);
+			free = erofs_prepare_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		if (!free)
+			atomic_long_inc(&erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -983,7 +1001,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1285,6 +1303,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1343,8 +1362,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
 			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			    erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
 				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1390,6 +1411,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
+
 	return err;
 }
 
@@ -1412,10 +1439,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
-- 
2.25.1

