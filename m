Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63BA9C3D0B
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 12:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731324170;
	bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dVUNWe9DWZx/+joHDXtv4A47kSP9472ZZM1nUuM3XAV3vEj61jysmhO+Dlbn5EPrM
	 0kgVkwpSV4l4n3r4Y5iye5hnsjVJHpd+l8PVKoFIDX0bL7I3uUC5jdbxQMkLYCUx0d
	 MYSrfWZAOp7XsMAa5WNYl5pC2+yy1ozBszLKsV2DY64XGOrD7Tjr8pAYNWkm2odhUD
	 LtyQoqrnXZRAt8h08lQY7Sq2aWZEfvBqemNys05XkDn0/DkSZbo6s/y2WVGB29v1V/
	 WPrEkE3cWLT3d1e++LtRWqHixCG/HuDT6vFQtjar/kwU8mtwx5/7s0gNRnK5vJ9WPs
	 +7TNfWTS0YrHQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn6bZ5FJYz2ydW
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 22:22:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731324167;
	cv=pass; b=JHU0TMfLtOZXoZ8yhe6dVUHSp/SyfwLMgMo4Oxlmxm//qW2EAybsFXng+2eKUqZbbWqIOpWRagZ8f1EvXThARLDjifgmqHx44fXCn37Dw3TerEXEVyqKQvRRcxfcQrhfhoHK2corlcd4K4PBenan0c4Qp83zyvg/vjXzzO/Rg1WRuPr7FxKpVqRp6jCp09EyWk9mb1GLIB6DFOGELanDVqFOeCIe0TGLQuB5H4bqbmVgtmTIuQdWlhHte/VEam0rb+XszPxGkIBT0KCbOW74wEOW9DyQj7xX+h1xg/exnWM/NbvZE0lJjDv61ha+FXRhtC+27bFfzEzrEwC9jTYV9w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731324167; c=relaxed/relaxed;
	bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fRedR1V+ecSPhoG9ypwy/Ir9fFHv6pvN5IDpXR5WwVTnVBVExer2CBG1jGGotF80MhSaENHg7aVGLfUpchJizXLTZYjFNVvZqOwmfcSSfKZmZy8rtKwxGWQ/YO9G66uCSWvh+B1bUZlsBaVanzAooZHo5uiIZJOX9yVG2LPQi+UklfvHwPBhxbylTq3hjoiVuUi+fNZu5oqEdEug6rTMXrl5CuRR4THBfkpUDxbnvE9BwFYt1ZPnW+JlgmBqu0NUZfvhym4a2M8SKIrn4pRiyweyTNbpV2xT6hXMTTNxNjw+aV54bac3et5LvExgOePtUWR0YhYbiKBEcjd8kkpk1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=F9FNnlmX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=F9FNnlmX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn6bV1n7xz2xWZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 22:22:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvTaBHZEIKd/TpOgxzjsJfQbE36ZwjrWfO8SlFPDFtQNmLoKM3P9bTSdWpBcwqVBfVjqah/KWp6W01W4DOV6rUvU23m+UY8KgcOPcwuj1jWwx/WDP/QcOh6ugtTGHUSmfMhEFF5/5tsyAcfhAGrKThiWA6uMBnmzGlXB+fIwGuRCx16qXQ7gNg/p1qTbeohRRiSAEehdec+aOiN2hYObf1l6qlDV1t3vL1jQAby2xnjnYiDW5kOblQjIMUcKJrID1kiIGtOY5EfsmxERahcamiDqHnMQlW7zuaYpaqKMTUmPt/aeGLeZr+2Rcwm5IU6LVqB487NvxjQgr0RKvm3S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
 b=J3IA6CplCePTIrmpGxY9tf0/8tZzEB0wOge8jU4eqHwegUWWlppU+nK1WPG747ZswIBVq3DKafrdDTJx7MmAwnUI7dtrmKkFPeFwZGKlqdo1nWGEEMfgtzRYx8YZoDY4JGvObOKbhUfoGhPSIFlGYlhgx5pT4KmhPQWuzFc3dpbaztRCr46YC1VrehDbuVdc2Pq+tsIiTzaDJUkN0mFlKhV17G7CqRErDroicqhqF6eYakrg4u6Fd2Gxnv1ObMNuGse/BlaIUzp9vLQ2qepFKjgfqW6rOQ6jBW4OR2kbvAQKIeZjtdo762MD6ktkJwdCT7RVxXwq369i53CCRoeJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
 b=F9FNnlmXZrp/Bmr/HLkxVTmoB814vpgddQQQgb4JhrL2G8ZTwa/4pR9qwyEGlrIBKYY32gVYPba8tD0No7o7KeNI/G+VNJS0SSiM5+RBvRNG0kTlUYC8ObGvArVLFQMxgPvaAvjCLVToUMDaD2D0ByB995+iRAZ7cZKAGjRIK9PezU5n5E4rQu0ZmoJ+dqdtPcQ7QC+PGnkBE/Q9H6Lq3S0ypH0gDAeJR8v3EqUq54Ae3L+8CtxFpxMTxjt0zYiNGKQOn+/xXWlBwNQS3Y51AT4Xj/oK04sf/Pe25/cy5l1WWAbOsCENXT0Xvr+lkRpz2wP6tRMiB73U74FBHDXWKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB6348.apcprd06.prod.outlook.com (2603:1096:820:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 11:22:20 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Mon, 11 Nov 2024
 11:22:19 +0000
To: xiang@kernel.org
Subject: [PATCH v4] erofs: free pclusters if no cached folio attached
Date: Mon, 11 Nov 2024 04:38:42 -0700
Message-Id: <20241111113842.469080-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: d53c79a7-0fac-49e3-cfe1-08dd02431b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?PTx5Ix4LCETNnDzHwS65go5wohUviSaJPTv/24pQbphlfQ+hGXMNw5AajpsA?=
 =?us-ascii?Q?ZL+SIEiJzqbBtBtsCY/5AQbBXeDyJxtOo/Q6d0pjgB+XoqZ4uj/AkEBMyYDP?=
 =?us-ascii?Q?8tAltW8EhH9GhKeHnQNWtX2YBmvG0ARjKopaFwhnJAc+OCjyNWMVm9swDMMn?=
 =?us-ascii?Q?MmPMlNGQnerVNfHSYB5rBrXhRaFBwAAvedL07Tgp0yvGYJ2kBZU0LRsoKYR7?=
 =?us-ascii?Q?VnwlpFx0n0Uip/1LDw35NZUmchVd3AXBJG32jXYWTyKkaLZgahTyUoDGondN?=
 =?us-ascii?Q?squkqaKlViNWngzBXP+pJfmhUjE8yJuPPIZIyIlV5/mM9NU2ec/HI5/ea7Ky?=
 =?us-ascii?Q?D1STTG1mmwjXiQMD0aR3BHnHtKTHVFQ9xlamd9aoRH8IvLDm4ycDig1OzfNv?=
 =?us-ascii?Q?+ezLl+UxWwms8pJVV5WTGTBSLDxQINvH7+m5dctOjmofzqsACw3KKO+t2q9B?=
 =?us-ascii?Q?eyaDiyWPNW/t3dELMcJpEWJ4uebB+lMCS6fipNKl4HEKC3JuIvYYHf/AdIRu?=
 =?us-ascii?Q?VTdwnpC75YpPAd2stCcrc70JDyvVwGsXzfG/6pKmmzmApN0Lgql0nOx0qu1C?=
 =?us-ascii?Q?72ydxynPH9ESqMQ4PkgELGJgzMfHfgPnak5BjAdhEC9PJMm4n6ZCQvxyVD4w?=
 =?us-ascii?Q?x5vqKHSZYIjB6sIj9qJl6GLzHR88PyNb/nylkKUr1nKYBWreQnSK6FsyFPs2?=
 =?us-ascii?Q?yNeVA8NhVp2pGhJzUt4s35tIaD8LTZBHzMzqy0ZtXquO2/ZcB6t9prp3QaZm?=
 =?us-ascii?Q?MpYh1UcsFkFb7x6ZdbdJKwU4JfBvxTU/QsOyED+NwGW+zMgB/4Y78/6DpNPn?=
 =?us-ascii?Q?O+qDf64qUnHtP1g1AYtbdJRmg/OIqdwpn8GqGLwY+bG5RWMkg1/3XP2cgpXk?=
 =?us-ascii?Q?AATeMr5DTD3a/C0vXnpOswRG0fWnQnVsraqabvvur8nvFxIx1dHUb6SPUSz5?=
 =?us-ascii?Q?idIlAMo0nZwnqBu4hNg+AW8babPm5VtHguWcvPpu1kKysLRAq1foF1Ri1s0i?=
 =?us-ascii?Q?gDGj+aOKyHG5cJqpiYQ2qr2Qu0AhZmZWebnseJKvSr1ur3wBElvp2S9xiGY9?=
 =?us-ascii?Q?xk5hsOFsc2tWcAKceec3Tk55eRtkEXp03ipiNe54RBFeBa4R/JobAZfk47Ul?=
 =?us-ascii?Q?YTYvUTD/wkDXKfUdw53Hkll4dKwyzTwWoi4ikr7ikH+CdU435kZa2oWZg7SE?=
 =?us-ascii?Q?tvX7N9MRgGEorDx09EpljC2uyxz91O1TmUvM2qPPC8zZlScRmXbI23UKjBc5?=
 =?us-ascii?Q?HXjMX+tluAP/4L5pXdPEJ6hR65wyup+kae2ZnSswOdGTED2Zc3JaSuVxT3PL?=
 =?us-ascii?Q?mSSNevRCytoiI4USL17AnNZTLs08xb7Uo4247Ny0IolWO+GxgAaeza2H6rQx?=
 =?us-ascii?Q?r+LMVwImizZKyPBUDf7D11gd3QzJ?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?6jXLGVsEUY4Qs82Fa3iAhQq55UqS6sSWYZcrc4GLrEbk64kOqIvOYvasNB5C?=
 =?us-ascii?Q?mkpHkhBBUH/mWFgtgprayV54nc0zD8jZ0VKVQmP5y2MrzOJALiQwqNIQ3z3o?=
 =?us-ascii?Q?mk+oLIgkbjld/bQN4Gh73lQtkhWpf57lODHoNlS4Qnjc9soe3a/VlpiBF4Kr?=
 =?us-ascii?Q?QoQy0WrOGmwVjGjh2+IRcH3jmRH4au++Kyjyzxhp6ccabp9jbspGKvYU24rO?=
 =?us-ascii?Q?nhxCtwi6kcQplSzF0e8qCd+Uh61DE8Y93rzP/yua87ekEt3h741owPNUXga2?=
 =?us-ascii?Q?7fU0goAtqvgIG0RzQyG+rXCOsW42VDcPlyIeuFuFKkT2d6yrb6XLYQCvx5Sa?=
 =?us-ascii?Q?X9L5Y7MPBbEcoXJojKucUxp8Gp0VkF5gVyhcGjer8cNod9xAKRli8Rlk1fJ6?=
 =?us-ascii?Q?8DfCxv3qrKRD98Pxm2du4n2d6PhBNQWp+YynR6GBVtILtCMiNFEy9y88O/t6?=
 =?us-ascii?Q?X2vNhcr8Q0CxLkzKi46kTw5dloOciLxNuM43nLkx4+/ilbw77A6ykqsQ2XXU?=
 =?us-ascii?Q?pjFCMKXJuG1WV+ttOh+IxHXPpwSuKuIdztHfFmKXTwK0Nt7CW9DtgF7TvaSS?=
 =?us-ascii?Q?IVyl19e4DtswZnosbgc5obgS0lKq5l2MVusVWH/rYkPnRNdEFkQFxtM/QXpK?=
 =?us-ascii?Q?EQHx/pGzCISOUFbw2smMsmmO/DRXigPgoDshcWEKADZzBtvahWnTYgxgoUlQ?=
 =?us-ascii?Q?dAux/vyU13DdUr+TsmbcqxqlPL1tlDZOaXyxTe68xLtP09O7v5WWnK9ojNEn?=
 =?us-ascii?Q?HFQd55c54SZ45GaoWtM7vH2VtJBdp7ABTV0+X3MBcgNQv90TOX2mwZdELXu2?=
 =?us-ascii?Q?Aqsp54sO5MQau++jKuWyhK4ZeOM68EJ3LwRfAJZY8W8F4/0qkxQhtti7fDcu?=
 =?us-ascii?Q?hTudj0zzLgiUB5PSrSMwazM7JknQHJW473Rc6s7V4aYBaKaOKJOZctyguAJ2?=
 =?us-ascii?Q?GDmYLpg2xwnm3Z+KJmyYwAKVi2xB2b26ERbea+3P9TlLtOBGqdSMn1Q2j5uW?=
 =?us-ascii?Q?B3TBIQTehLCFSP71w5Dqq2vouQctIISozEZKXG4Oy4yu8hgkIu7e1NYVvhwo?=
 =?us-ascii?Q?b9bXlhf2TXxhmn1r+YVwa8vKjj6mhEGNeFyF0H7+O/b1O8o4egrXCKmv4v6I?=
 =?us-ascii?Q?v/BZi27xusD1pK5Lxy2cvEAvHAGYCCQyceNBp4h4FnJoR82KW9F2FsMj2sEP?=
 =?us-ascii?Q?pmUbVv/nmPaeFXdRPLs8St3rYzIckIZcteBmezQ5duhf7THPvkVtducCTIN/?=
 =?us-ascii?Q?VQfp4g69L7OpN8xrsJP+SKGD5QRz0jjyR7xnCa3Q06sbSHADVQe6mTOp/yHk?=
 =?us-ascii?Q?s2eux0QAUNhImJC5I+R6vKvT2NP+mZ/U865YSIGz6oc39TBImAxDFpzV2B/O?=
 =?us-ascii?Q?nWeXNuXoq6gR8ESXid7vcmvceuoHAZl198A02krnbDgZ1CEyvQlUzBV4nrdw?=
 =?us-ascii?Q?ZprNPr4SHkFlxfolE/ZNn7nDagWoVZtZYKW2B7qQ8NQLXG5wIrmf10lLia12?=
 =?us-ascii?Q?JpIhYDSMWR+rjtN6udIUJpdzcwRTzm5lhqnHr8OAPrXZnFW10Yg9wL0YTBng?=
 =?us-ascii?Q?EvOVu8h/99OGUu+/nwSsGvtIxx2K72SINJ6WxsF4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c79a7-0fac-49e3-cfe1-08dd02431b24
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:22:19.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCjgDiuwJNQxUNXJAjNgS3+DsF0jIC1OtgW6jwdrads3/f+RR+bx7u4pfJYde6ZtvtMQO2yM0GKHJGhXbNXQJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6348
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.0
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
v3 -> v4:
 - modify the patch as Gao Xiang suggested in v3.

v2 -> v3:
 - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
 - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()

v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6b73a2307460..d2338bd99811 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
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
@@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
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
+	bool free;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -942,16 +947,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
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
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		atomic_long_add(!free, &erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -972,7 +986,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1274,6 +1288,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1332,8 +1347,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
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
@@ -1379,6 +1396,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
 	return err;
 }
 
@@ -1401,10 +1423,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
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
2.34.1

