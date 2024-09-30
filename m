Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1698A5DB
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 15:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727704178;
	bh=126COAvLR+mfAIPAAtUcG8djqtraYfYxcriyM7aH2Vo=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WVatMg5TeyLvJIDjV04PDZyBnOA9NdA3TRqkj8YukkujWuiVt+rx+BW2fZqu5v3eT
	 quupqeOm25jZcPTDT4akXkdLFrV7zZUHHd6kKTbOOtnpVq05IAwRDXX0Wvk6h99v+u
	 oLFuxT5NdqDl+eEXmVgg/iMXE6F7oOx0Ovjuv82sW8sA9X0CkwbEd9cVWsaLgzRrMX
	 BULNpCbZ18mlO5MTC3+kt/QnTL+338Y40ONLlTg64YdtmSOxuvVsFdg+ZP6ohK75ex
	 5CPmYcHv4HPnUVdjsLCAJ1pA3p8gB+y/+I6JhtbVru5QEToTdfxTWwOQIkVm5dqrMm
	 O1W6zYfhT9WSw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHMrL5G44z302P
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 23:49:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f400:feae::622" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727704176;
	cv=pass; b=omoEMEVK675xcOT8UfOG+8L1bRrkoOoum6u8EVAa8psuM7JsDOHexy2abdSCNOqrhJfguHX6eizSp/sx91SuPwrPV3Qfr4MX/HzIeHQm7vQ1tjqnrKxQdU+QPaE/u14i9qBBDeLUE67d9TbRvmh40X+Xxpp7Gl99hzzLDxXtJutqFPnA31Fhf7XFckREpYJbhr7dtT2gQzbBcw4tqcdsagJpMzX0mt7b03ljXHoB1hPseEN8MJsUjEHEx9rv0I/iK2JCXWKDTd5XiP7MAwXm72isLh8VOyIK+MIWiKd9c13ssGrLKD6EDCacR4g2zb05pxF51th5Ca0n6LXvGZQbBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727704176; c=relaxed/relaxed;
	bh=126COAvLR+mfAIPAAtUcG8djqtraYfYxcriyM7aH2Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mIoIpsTS15BhHV8ETxiVFrAQ26gIujPyNEnoTr3myhjKJ5OHy4ev/KrE53FGOGWlujkEKH+LKmfLss3MlDdV6R/y4zeAZSwAiNp7M13vDSO9shF/QmbPA6iQYq4YiW9N895hlMT7cjVIsqBKlgRycxIgxrSOxKy6e1odnRuAymkjJtlYyOHxXjEvWHbY3SQCODPW8QYKlzuG77/lN528jOyFx6K7Vgn/egT8kgHCgPR46AbIQzotNkuUKF3cOf/wxN4KyebeW/+W9/3ywvaSbvsQ8ONrWzqF/7x0+lU6xmiur5vR/maB4EcSOWDfIfK1fdFOmkHFg/iEhj0yz/bTKg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=V/ePQ6qn; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f400:feae::622; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=V/ePQ6qn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::622; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::622])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHMrH0ZPqz2ynn
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 23:49:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsDGALWplrYOfrTqf9ozPoiwib2KZaWY55Vncp+viI+y+RufuBJtg6/OryNOMkRNu7VoKif/QvHBG8N+z+Y9eQ9ll51isqIUySWoluxiMPudI/Qv+D+r4eu7/GTJK21nekb/8xP6Cujo3Io4XWZNM2U5DsfrvWL5uLO+v/KbD/OjvL9B7CrDTiSNeWWrPkA/abtbjaKNA7LVvDH6cngYMqsQYqIvL6HNu3612xyLatdbcCI/NnM8Vbg5fnPs/ekRuR5MmBox5PCjsY8wCAdX+cpdE14esAXBimxO+DAkImvmPr0LCFCE3pP2NsZCZwpzCesgxGTR/JEo4SUc1PWNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=126COAvLR+mfAIPAAtUcG8djqtraYfYxcriyM7aH2Vo=;
 b=d133PLWedXheXiz1oSnEASvZ24jCnYmblVHT10NE9N4kGlJQ9l7mmgh8i66UUPnIaipHS9L6X07B/hG9apRM13hVFuHjFBaioIK3AxQvPXm6BDrQ8sy3epvyNuntctIe2uekGTdbGIGqYAWemj2c04ExOTj2c78GyQBRavfD8mHR/x4bvs0Mmvm1PQQTIVW29SwuEz6vF9lBxkcW3LV6SY6ZYnL8nAV4zloWueHHKqezliW2UL5yoR6toENknUCxt8QJDqOFIhCCQW69+6s9a/CUzIOqyHbEjmamL4XFuSE3eldm+hgpca01irjGf0YrS4lQ2t6ZITBDJcZE8oTV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=126COAvLR+mfAIPAAtUcG8djqtraYfYxcriyM7aH2Vo=;
 b=V/ePQ6qnJ8K3dInoSPM/P7myfu2i/tuzRuF1Wu+9H/0RtP+493uVz97a8v7n2yQwJ2vhxQLXgPtUk4dLRhGGBbaaxjKSU+QzBCy/nXG3QVBgRwzx49y/CTRo/IdIznI0rvEQXgCbDubS7UBaYFVGb35wLgDRqHg8yc+UI8GkqDNAvUx5PCxQFqudDLx7hKxJ5yAY96aRR+mY2yed+4mnNoy6KZylt5Q5HBS1YW/y3qjULdAv9G2FsPBWfRjX1IvVPQ+wnbzjJuUo7ySPqnMqCMEodjEzqTlJsfWC6LkEcXGk1yCq6fkEkSuiew1RSzHBpFd8vhyc2iMGC37L0XIKCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB5413.apcprd06.prod.outlook.com (2603:1096:101:64::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 13:49:10 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 13:49:10 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: free pcluster right after decompression if possible
Date: Mon, 30 Sep 2024 08:04:24 -0600
Message-Id: <20240930140424.4049195-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbf5a39-ab96-4ad7-9da4-08dce156a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?UfN83kQeHi/eRjEsw6nId6JZ4ouhJbfLKWCprrTDMMZxt0dw8uQ9X2M6Ah/P?=
 =?us-ascii?Q?HwxYHh5H2EwxdP6Ujnggfpg9utwHOBN3wSbrOVhrCr60p79XLazOzHDebY5e?=
 =?us-ascii?Q?+xK06mgv2x8yJu4VNEnmYkRIPEvx4TTp+BdyDO1qWVAONmRkKLPQbvn5YbFI?=
 =?us-ascii?Q?pFHlK7s91GKKG3S1/8uQFkUtMXkh5lr235jUkc+t9ZMdKKRtl7uNaEqVlmNk?=
 =?us-ascii?Q?d9RWHza3N8Z2dyZhAJxtQYD1GQU0zGiSZTG4YO7geZ4T3U241YDazSq6Yheb?=
 =?us-ascii?Q?WCh80ixH0PCXEvwLd3Q3EjIGm//Ur6O+zpw/Qz8w1lUZMHQYy/XAT4Uhx3qn?=
 =?us-ascii?Q?T5bW3QiEtHfc/cJDaxUFRCYOEQC3wYajPUfEr8+JNORrtTvwEHub/vJnObmY?=
 =?us-ascii?Q?/xAG39Bd0gNt4fO0Yh+LwBMOqBhAueRY/VwKTnkay4+yo6OdIMVlzx+G9xCj?=
 =?us-ascii?Q?C+d0+QA0tvWcqhoBejt4otmOyvzV1eLFmvb7MBxkl7um6bsBSjX0EKTIvmqS?=
 =?us-ascii?Q?BHinezyuL/L2cKeE5SCGroH915DwtD1HECKNrFd9mcRM7vAIQkR0zW+vqLBs?=
 =?us-ascii?Q?HN4x/79KTZnbRUKQxzxZyCC6AZYWmqaTFkOyUMgUggpzAiSwHnrZkaaiKZmc?=
 =?us-ascii?Q?FU5GdWX9+pCnBiJGAGxeIKnEVyf17pUiKNYG0XmQECKhnVAN3JlpqHbvtZ6H?=
 =?us-ascii?Q?kRnSceve4nhKt3TjwvNL/yuS/TNlNdEkSfLArsQ7RIfzwSyHfNfUgb60tzF9?=
 =?us-ascii?Q?TCQov9XxohT9GMg4ZfFlplYDUXwu/Mi3DLRAwwZhUfKVJfGcAOjlsdOz96Lg?=
 =?us-ascii?Q?BAjDUXAYGmBDzOaJzsptu+0QcqQC0jR/0f7wyZqZWxdhxgxltyFeTiukm0Hp?=
 =?us-ascii?Q?Ah9/rxFsQpBG3GP8JOLNB+b6m8DU2rN6oThOYI4rgZfstYVOtI/FDQaEg5KW?=
 =?us-ascii?Q?me9lCQPTbBQPT0joRFe76sdK6BurmkPRbJr2sARTq1GSocQ7MWoYDpzOcKBz?=
 =?us-ascii?Q?yROM9d0tPHDJdPEllbaUOBTO4E+YjUNKNV1QKM2+eWA44tgLxE4sk43MowmH?=
 =?us-ascii?Q?7eo0AkFoFgeo5Pvp5SJawJtHVnnLos05e0cVa2ULohw5CGO3m8vnmeRWRJof?=
 =?us-ascii?Q?3OxzMsNPQ2NRLhT8uCXQvsEJHZbNRweysmuWHAKdQty/bIjAjaD4hImt4QY+?=
 =?us-ascii?Q?1pOO8SeKHO2/VzfMhqzpXYcGrwwpnnaFohsXoltN1JtTcqFv2YdmWO9/6j/D?=
 =?us-ascii?Q?dP5andjdU139TTbpjRtxWZR5+pngtvYYnk86TTRMhKCwnpo/W4gPB1324Ehn?=
 =?us-ascii?Q?R+uIJ25yPSpkom396nzumIbjwHTvNXUTq3BKE+UvSea8DOEgiQ4547mzZPpy?=
 =?us-ascii?Q?j6bmiXsVoSEhzy9hsznnOJD4r6T+0WbmvNScGFuTgOBnB3JKpw=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ycGYBBWnZFoOhBv6otp2qD1X6GenWlKNknrAuzMGd6acDMLrmUmyq3kTbhxr?=
 =?us-ascii?Q?cdMjA3gNlktRBHBrDqlpYgldR6Z3/HF3eqWeaEfC3fbRtgo0A8t/p95txjjf?=
 =?us-ascii?Q?S2EF0kWA0ARxiujl2cYTJF0oiFUKs6VT557Nzm8uhAJP3M0OcRVA8kmToEbR?=
 =?us-ascii?Q?Z03/ZpQbFBe4bHL3l11oAmNjxdHVIR6QBHwtCOPDvMv+9qn/2cEW7q0uyRvf?=
 =?us-ascii?Q?VkdIKcrCmucljMyjXRqKS6u37pCqb9D9RAVVbGq09tGyJ0COmOs8OTGjua/A?=
 =?us-ascii?Q?+TcIKfA4Npub/2wCfgKcKAMr/6YdMyoFqzFevded8FFvij+fdw666N0BpqN/?=
 =?us-ascii?Q?E8I1qJ7JNpgJkObihxjbaY7IaPGgk2dkWCzo0Gn/0A+TAfB1NiHlwwmgX/wT?=
 =?us-ascii?Q?D0ihGyk4ddXJyq4sVwY/0Hl7J0YKO2JSfTfzztFwE+m+3MZGqYsCJuYjBmv0?=
 =?us-ascii?Q?Uk2wZ5E2CjIPTdqjK2XlgEusmzVKKyC0SgrpI7yqXKQlePgrrNlbx0RRaRXN?=
 =?us-ascii?Q?td6l+JC6aKQj4gWgQOVGCPTQbjOZuX0xPY/embTNgZKNdCdn04A0nAr2brHX?=
 =?us-ascii?Q?aHi2BFhoWrPCVoe5CCA5Q+B0SLsuvVJ/BVrj+B2Ir7agXGpRRMjULUWyjna6?=
 =?us-ascii?Q?PoNgnrp9fiUMJg2ZWiLqPM7TILr9vuEbCosj1mN8LJPkZ/hdxHIirQ6qdWzv?=
 =?us-ascii?Q?Rk8L+uopN8c/OWdicp1HMhXtXxbTLnORJf/cA5U1b6Y/CqlT0bQ5UtAZnJ5f?=
 =?us-ascii?Q?1Qcw/dwsAeYJnpEOvFJ2IOqZOkLuImm/YBObwT1FS51HHSyrALZQXHVR1otE?=
 =?us-ascii?Q?gWac+tnf8BwP+nyo+QE0/T8giQZuuxhoT4yi/Hxjm2SZk7zgAcP/XcRi0B2v?=
 =?us-ascii?Q?S/H7zCrvdyIbqD+WOI1Bd7IsL0em7w0kp3pisJqkgWGhRgrMyzuSFeYPDGGl?=
 =?us-ascii?Q?1HkU+ps2sjdG37G3KHs0gmVNE5fbPoXtQQWiwP2zGjGvsz1Qxgov6aarzXYQ?=
 =?us-ascii?Q?E3dIgnvA7IT6lEx0JozkxMArA2i6YLDQLHEVdXZIQy6t7gWrbVFD5ZLI0CKm?=
 =?us-ascii?Q?pPKMS1FJWwb1nwO6ac8udGK6+0G0sHRWBH7P5HIEjGjznX3/QuuqrY5JggQ5?=
 =?us-ascii?Q?1TlY1Rv8sTlwemH4nVv50UijCTSSeBuYVSAWAvJ8XfyjwiLur5TZbt4Q+Jaz?=
 =?us-ascii?Q?cH2j0x1fvWoYkw4jrNOZNqMYpydtizjzr5fu81r6d22S1J5/JdPCLgi5klYC?=
 =?us-ascii?Q?PMxHMPVbGAXuOFRmimnVH8jIFFyCi6/+3mfZRCSM8TF/3dZWluo8MZ0FN/xX?=
 =?us-ascii?Q?72Q1LTqppVeYRd7/HbQCiIwzm1ougZ+pMjX5Q1dWa4Svdu2P+pSmuNobznVu?=
 =?us-ascii?Q?25p5AezVigC2xNEb3vQjK4I0hQtzaWG8BcHTKH45ISPThVd2uj8Y/fjoN00T?=
 =?us-ascii?Q?PqmCX1dHAnKWppuMuHpVI9DxMoC2zXTRAc196vwO7CoMLoVs0LrIbnJC+Lkr?=
 =?us-ascii?Q?PLslqjEPx11eGs0BxqWiXS+OwOA7QFpZbi9BYjDdRVljXhuHc3CpTGqFCRRu?=
 =?us-ascii?Q?4Xfx6vti9aBXcr1CcxmzBHBDdhrBe2pMYP8EUjda?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbf5a39-ab96-4ad7-9da4-08dce156a904
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:49:10.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgHDrTOBON5D1E363hINcojUPM49CrOKWsjTXN8EMynrqpLvDsMoQoG65i8gw5rlTybZyuet4e+XwHyICrDkng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5413
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Once a pcluster is fully decompressed and there are no attached cached
pages, its corresponding struct z_erofs_pcluster will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for struct z_erofs_pcluster.

The tables below show approximately a 95% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for struct
z_erofs_pcluster after applying this patch. The results were obtained by
performing a test to copy a 2.1 GB partition on ARM64 Android devices
running the 5.15 kernel with an 8-core CPU and 8GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   3152    |   160    | -94.92% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 44503200  | 2293760  | -94.84% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/internal.h |  3 ++-
 fs/erofs/zdata.c    | 14 ++++++++---
 fs/erofs/zutil.c    | 58 +++++++++++++++++++++++++++++----------------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..17b04bfd743f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -456,7 +456,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
+void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
+		bool can_released);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index);
 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8936790618c6..656fd65aec33 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -888,7 +888,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		erofs_workgroup_put(EROFS_I_SB(fe->inode), &pcl->obj, false);
 
 	fe->pcl = NULL;
 }
@@ -1046,6 +1046,9 @@ struct z_erofs_decompress_backend {
 	struct list_head decompressed_secondary_bvecs;
 	struct page **pagepool;
 	unsigned int onstack_used, nr_pages;
+
+	/* whether the pcluster can be released after its decompression */
+	bool try_free;
 };
 
 struct z_erofs_bvec_item {
@@ -1244,12 +1247,15 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
 		put_page(page);
 	} else {
+		be->try_free = true;
 		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
 			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			    erofs_folio_is_managed(sbi, page_folio(page))) {
+				be->try_free = false;
 				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1285,6 +1291,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (be->decompressed_pages != be->onstack_pages)
 		kvfree(be->decompressed_pages);
 
+	be->try_free = be->try_free && !pcl->partial;
 	pcl->length = 0;
 	pcl->partial = true;
 	pcl->multibases = false;
@@ -1320,7 +1327,8 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			erofs_workgroup_put(EROFS_SB(io->sb), &be.pcl->obj,
+					be.try_free);
 	}
 	return err;
 }
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 37afe2024840..cf59ba6a2322 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -285,26 +285,11 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
 	erofs_workgroup_free_rcu(grp);
 }
 
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
-static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+static bool erofs_prepare_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp)
 {
-	int free = false;
-
-	spin_lock(&grp->lockref.lock);
 	if (grp->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached pages should be detached before deleted from
@@ -312,7 +297,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * the orphan old workgroup when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, grp))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the workgroup is freezed,
@@ -322,14 +307,47 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
 	lockref_mark_dead(&grp->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+					   struct erofs_workgroup *grp)
+{
+	bool free = false;
+
+	/* Using trylock to avoid deadlock with erofs_workgroup_put() */
+	if (!spin_trylock(&grp->lockref.lock))
+		return free;
+	free = erofs_prepare_to_release_workgroup(sbi, grp);
 	spin_unlock(&grp->lockref.lock);
 	if (free)
 		__erofs_workgroup_free(grp);
 	return free;
 }
 
+void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
+		bool try_free)
+{
+	bool free = false;
+
+	if (lockref_put_or_lock(&grp->lockref))
+		return;
+
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (--grp->lockref.count == 0) {
+		atomic_long_inc(&erofs_global_shrink_cnt);
+
+		if (try_free) {
+			xa_lock(&sbi->managed_pslots);
+			free = erofs_prepare_to_release_workgroup(sbi, grp);
+			xa_unlock(&sbi->managed_pslots);
+		}
+	}
+	spin_unlock(&grp->lockref.lock);
+	if (free)
+		__erofs_workgroup_free(grp);
+}
+
 static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 					      unsigned long nr_shrink)
 {
-- 
2.25.1

