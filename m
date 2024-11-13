Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB39C67EA
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 04:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731470171;
	bh=uDjBDGM9sl7HR7f182CjRzeEADxB6c8tQaOxxCyTI8I=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=CjDR9Q0L1PEovqxfCvNBRQKnt3Zzn5+pEntqNvQBsKgBnfXJYRFfFFoEzJbpFIqdZ
	 3bbsWsqwgEGPX26EDqrGWaHjn/JRx4bFDMIQ+3CsCBbqGCMZIjuZakRY7UIcXnzz5v
	 dj96TU9zcf3eJG6n3efKGKa7l3uKf2SOBNhJfnEDMz4yIhNSH9SwQ4yCoKPGrBi1dI
	 6RxWg0bE9gBDrInnGSobVnTHPMqSDdjS/lqBGnRO5K7dsI9kweEZ1zwKt6Kza4O/XY
	 3E7E3+HirVR1g4xx3wizP3vc4qD8itQtXPLGL3O22DvMx2DtdZ2xKHikYDKmTlbken
	 RuFzGkDQN6gRg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xp8bH16sPz2yYd
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 14:56:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731470169;
	cv=pass; b=CvBUxdppqV3JS5EMAT8xCErD6kl6y2V2vltGx2HdqL4kZAlVlMU8Ut2EcNSFUtJsweCmRUyOgFsci824pJ/xikP3ngylvQM7cHqJLas8iZCMtTwv1zOHcCOvVrhoBpCzIkiMnIq7+wbSJZbMnXQI0yofGgpznT0xnEGUJ/KScxTIq6/0XZpGQbVuuPE2OiYGqQJYKclR5it9ZPEPdbV+JD92UcfpssBGYBWdZBMxuGC2c9WGKQvWy4ynD3scxtdZxs07EbCbFHH19kXuWsWo1kgz3MnYk1PKRj/IbWZJVw6ZDeZJaKNEvz99/20GrWB+bgIFD+d5d0NrJz+5HqjPsw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731470169; c=relaxed/relaxed;
	bh=uDjBDGM9sl7HR7f182CjRzeEADxB6c8tQaOxxCyTI8I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mDlxpNrBOeazcpOb7QFeV2BrktWhs4F23i4kDtzfUO/4yrTa7hHCvOLmcAHvQ94B4/LsKcIR4gHT5WVc1S0zUsjF6+RXUrKoUrjRuUCfT00XOTszzWrquKYcCf3ayscPOQXY4cVVYzbVPn4DICvimdxLD970DJhSRqKOYGmXLM7qZMOrCT7v4KQ+U1E5UeUBPzwNjVt3mSh7XX5G4K2goNvnSrylcl9YV6R4Nf3QqdGs0+Rpyr18FIEI8NM8dKinzifs2jNsNyp0yMYxVjLLECeGXJHRJMvo+D2ceS8MWul3+LsGm99WdHwQMFvqzUW7QUJALd8OamtiVbnS5dlLbg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=afbjvbbm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=afbjvbbm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xp8b73nKyz2xjL
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 14:56:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdZV189kjEbcTo5EYIui/iIVxNCE6PieX/Z9ife26LTDkoNLC1SE66MtdqxHAOcnibOfAvOxEIGEwhr8Dvj7QHoSV7pmueEfybWwl3hm9TUORBW8hcdM7g6oviUN3wUHtIm+5GpS4VjryTpMLDyksUCo/sXrwtRdRW8bXmYwXos5S+SAEWhHeOPICT6LbwrhJbJZgKOlDRkU0Il9UNlrk2kX47XpvGpred5DeuWJBuvsC7JDO4wyIVbHq8cB1YHHFTHHnrJJSSnZjt/+seYsy0ybhcDS/okVv2eslcgvaAsSAbC537akSSsqYuoRVLtlrODll/5wOLCDJ+jwZJHtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDjBDGM9sl7HR7f182CjRzeEADxB6c8tQaOxxCyTI8I=;
 b=g36juR4Iju9fS/9u0ENBdpsN0vgd5K1ZVpg29keLSrJ3TDmngbQ/mXMBaPIDeLpaoITF2Bg4XNzHNGPipOD4xLbxqqedWaU968Ahvb/KedAeRgIvqi77Ib7v9O5XAV8POU6Tu57E/Pw/S7NJ2zFw0fFgqMLJO7DCBK5SAU1Lg00I9Q+O3SxWShlB7rSDXTdhkKgTYMWuHbO9e0ABs8TW0+mH6tKFPmP18UA5v1PiGLdZj4oSFAepeRAgqsfyIsyOEHz4FbOfUz8KIH4Gi0qDU+DDaNR6I+3D/k8W9aHnyAF4tBNH3JNzIPpRfjz4rJIXbGxsifoHNkjA7P9w34HFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDjBDGM9sl7HR7f182CjRzeEADxB6c8tQaOxxCyTI8I=;
 b=afbjvbbmRBBfI7xGRwOEsZi2Wp4fc9lMb+MOoDN3Q1kYbwrQW1i3VlB1Uc9mD+vbzyqdM9QKVDkUzf4Y4ScQVGnox6LGuG/jiB6GllWi7gmIlYNBEVwn5EFae20htT2bM6EiJh8qNrqumRqu8WNW1ew/u2ThmKFyby9Nxt6/45RYzo1GIJw7Q/pURhotQZhmjtewgFnHea9V8+mlRo1P9Ivk842f+XSI4UP0IQuTAnE8V6HIZmEHZkeVFHsWR/gqnKXgzR2PjnRkJzAinmpgSKNP7MfDjJUmxHDIDCK3QJvHUje0fFZWQW+t4tlaRgxnlqI1d/QeDOmXIbT6SeYTzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB6735.apcprd06.prod.outlook.com (2603:1096:820:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Wed, 13 Nov
 2024 03:55:37 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Wed, 13 Nov 2024
 03:55:37 +0000
To: xiang@kernel.org
Subject: [PATCH v3] erofs: add sysfs node to drop internal caches
Date: Tue, 12 Nov 2024 21:11:48 -0700
Message-Id: <20241113041148.749129-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 332b4ef8-e957-4c7d-bd42-08dd03970859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?+JCNc0hYYmJ3fmSZRx1GtF+1hHa+rtnP1Tdx0uUCAHyRw/rFxcO9xuU6i7oC?=
 =?us-ascii?Q?+ZpFWWn1f1z2SqFwoWvjWUuMoVjs4vlFI8xcbXxIGtDQbzoLIp3qjzVJ4r5P?=
 =?us-ascii?Q?YNY2b2pK8hRJlLsOapNfVg1ymA1cuPhb6A/RTqTrr1ct8rgy9YaLrhtSPn9q?=
 =?us-ascii?Q?x9v6iK4GmvhEdABBJD3TQDWD2zaM7zzt4Yi41WAwG3FX30vnJlP3/H1bjDyr?=
 =?us-ascii?Q?z7S+Au9uHQ919UfG6++a+HYa9k7PDSSGPNYN/Wytt4r2CRt7MPRtuuCOpReu?=
 =?us-ascii?Q?MRGA2tbNjAEs3DK97jPxs5oGsNajOj9h0SNdu/p83wil8pXwK8yJbJfguiFH?=
 =?us-ascii?Q?PVbLWg2LlYpXWlWwUYL/L3x/OckUpcUWvO0yLRS+6b6B2R7/4hBJcVNgJBe4?=
 =?us-ascii?Q?Z3f00GWTyqsizegpFsmZGaHqEgfH8cPnBaV3/kgfvjC+3QvwFNpMAJXBRmQ8?=
 =?us-ascii?Q?zsrCO1hOq5r7laZS5g905uB9KBpTWl2W40N/DM2DC+mM9Dj6sgHDr532ZBn7?=
 =?us-ascii?Q?8lop44u/UhkHumjuGzirk7h3J5yDWF+mmR0TFm24ZlXarCsElKW91tfkscdC?=
 =?us-ascii?Q?i/F8owUgq+Ie/z74k02yhH39I8jy0VmenDGNYs2pIbPbyQv294u5pfFb/mBZ?=
 =?us-ascii?Q?nWHh/spQawS/IQSHJiL5x9FOJy5Z4gvW6VmJStIru91ThB3wvt5hzg4t3Mxs?=
 =?us-ascii?Q?a/7cwdGTluG1sfGyxEO8bx46zJkzMoTgayNhbYmiTjs5HgXN+qyWABjx7DkB?=
 =?us-ascii?Q?xXUmX6CuzEJ8io8/dHGJTf1W393y6TESXDm8c6sa7z5B9Ihds7LqPEOlVYAm?=
 =?us-ascii?Q?gpOkojjg+dtUAr0w2jTpSQhixKkgqpbEBGhwH/mOQItBcCYyhx9Sp4oEyoHw?=
 =?us-ascii?Q?aMMb80TH1NtFj4jwYt0bKmmECAhIhfURXnlPTEjsp1mxyB9Csp2D2ucDFUVq?=
 =?us-ascii?Q?yaVP64gnScFhO8K4pOPCBa8ExG+FXgfJpz42vc9xL81HjEsDdc1b/Q2NrxMM?=
 =?us-ascii?Q?jCltF/isnZr7IHAeiEAplB/I1UbtlK/wSsW+I377/BHcYIeooyRqU2mIVtTY?=
 =?us-ascii?Q?OLYhNgb/IoUb/dpDoOU2tMnuthGGRkhVGm87WJ8qqbfyVbZHB/zkMeuoHd07?=
 =?us-ascii?Q?Hku5u6gEznAuYS0g4bwtd2MJp+lx3h54cEHGTva6h40q4p+2ObwTcXiV5PrU?=
 =?us-ascii?Q?s81p6gyZ0EWgKV3aiNSeWWjPspeUSpuEWZG5U9lHVLm1t9vk10+/Ku3Tlaky?=
 =?us-ascii?Q?5GfBMNgOmE6hgP3DR+PwhAFVfjw2jl2Sy7YF8b9x4PzougU+2/vx7jbnzdyH?=
 =?us-ascii?Q?KsvHzF8I0s1S2MdiG0EoiAtyGLewCypuWu3TDOAyGrrLar7paOqkNEgu2ppx?=
 =?us-ascii?Q?w/Ts8xw=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?zLoiU7faCOhcvms3M9FhPIXZzoN6QpytegjpTcMY5tJKL3Jiht/G76W2xOdN?=
 =?us-ascii?Q?HjyoepYoIDjcsbMD5zjRzeFBloOKrTGelA0kvypvUyOA/HAMdU9iKkcdXc5q?=
 =?us-ascii?Q?W4wYZtcJOeRKiXDtjf6EPKslQ0gt3Bw+EwASHsj7RiOtJWezcnMpgMj8rTff?=
 =?us-ascii?Q?jTBtsQXlfqRDbcEUU7YkCtYdzIZxAYF5t9AzEMkteqJaWzuYOnL2hRyCYDho?=
 =?us-ascii?Q?biTbN2SrXplYMaOd4UZFANWOL6ajQ6Ucqx4l5J61orCdJzX/ANmvS5aF1bMN?=
 =?us-ascii?Q?prsy9SQBQSFLiOvh9Lc6qbZnTCPS26mYgPlaj0XO83NNBxdQmNKZCfkgA0rx?=
 =?us-ascii?Q?u0Caq28srkmwNZzM0GwJdLvfXieTHL2hF3yHp9Xvc1QsBv1eQ2PywislVzBG?=
 =?us-ascii?Q?SECry5aIOnvGjgZa94s5I+Cl4TsTtsGqDx3YnfAerentpVaNY1V2kximqww2?=
 =?us-ascii?Q?7HXeHPuROmhQodEdYCRH4/EdOtBz7YCThi7ju+hMP/PDwFP2Dfd/wpqgH+8r?=
 =?us-ascii?Q?UfV+FrGEuhzF/lSgkMMH5TG6bDgEIQsYIdEqMuFbQ62wQk6WZAksIcO30iMM?=
 =?us-ascii?Q?QAQQ53r6k7D0BcXxeWXokV/Nbcqlm0JwEUS7bQzRugo4dFkLXXZFWHhoLjrY?=
 =?us-ascii?Q?ms7703P/y5eTGpCPHakC54VQcy3tjLtfD3NuSvp3kR+Sfd7TuegW5bsNMqT0?=
 =?us-ascii?Q?fCO0ZTLQaneNXIT8Cdn5EDJLurN2NCaodO/r1x/qzlZ/iD6zvcqLkT1sxgtj?=
 =?us-ascii?Q?MsF/UkWpsEIATA2d4dc3cTJGs7MoL7c0E2+qs2ODSo9iyvDyz14L9fe6wOFJ?=
 =?us-ascii?Q?ol/CsAlTgJuxW9hhnhdDGiWimFXFkB3bqjMDvq+GMCKgEpleueVdWDvLtFPy?=
 =?us-ascii?Q?MyHLJMm0+sy8AziHLxPCcEvoAvMymcnudfHJP7E3BiXV0tlZstwowVHaYspn?=
 =?us-ascii?Q?LWzfaQZJBOwSDJGbbnYq+tqwmIaUR0rR3uCx6zwl9lWnguOU+7FS3So1IWGe?=
 =?us-ascii?Q?Tq3LcLCfdZOLn8d+H7IWtBLgw4TtkIxbnXY3Ovoaln9YayTvVM4jbzF/z34y?=
 =?us-ascii?Q?7a2Cs8x2NRZNz3Q3w7wonJOYwZQMIJN/v8NFmbZPimI5NKc3mdOqkp0dltxz?=
 =?us-ascii?Q?YyQJnKx3F8N3+P28uzkG+c+OmFDxt7ea5YpQIoGTO7o8RFibtAnShq6WP4sb?=
 =?us-ascii?Q?GKi+BCnMHAaKHRvh2muVknLUofRoYzlo1u/8tsdt54olPdZxjlflZDEWu0fq?=
 =?us-ascii?Q?FxXP7YFSk8H6E+IxMqv7V4qlg5xBuSWhBXsa30u3xV3j+XBsMGihivXZX0Hk?=
 =?us-ascii?Q?wuyOyA+nDG6UwTY0Gm+6fv7whSQVI3uj4HMRtbyQ1p/o5hBlqUDCuYcViZN0?=
 =?us-ascii?Q?MDIKzkmCSdJiBVM1DdAjesyRprzJGcBHjmE0G67MKfgioBp+JBkSJbeqw/fh?=
 =?us-ascii?Q?QrcHfkhtGdruDqqr9upKLNeIxvzjRdOuve0Lx4L3kjt/EdWA6Qi/+WPl2DGu?=
 =?us-ascii?Q?UZ32HZuzqVdBPjNhu5YlFqGaHWcrRfMpFpU79dQqsv1vNiTDJ6PHpn1tFOKh?=
 =?us-ascii?Q?YozAaUvVTS6R6dmolhH8G63AkcJQ+L+6U+rJItQJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332b4ef8-e957-4c7d-bd42-08dd03970859
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:55:37.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv9jQd5LckDT1Um3Y6lKR9zFDo/nguw/u2pHId1ApJzwXUdwDHyZ3ZdThXXW6RfEMpfAzBs5lHQdsqn2hYDweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6735
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
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
drop in-memory pclusters and cached compressed folios.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v2->v3:
 - All cached folios should be disconnected before invalidating.
 - Only add sysfs node when CONFIG_EROFS_FS_ZIP is enabled.

v1: https://lore.kernel.org/linux-erofs/fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com
v1->v2:
 - Change subject as suggested by Gao Xiang.
 - Use different bits to indicate different meanings in the sysfs node.
---
 Documentation/ABI/testing/sysfs-fs-erofs | 11 +++++++++++
 fs/erofs/internal.h                      |  2 ++
 fs/erofs/sysfs.c                         | 18 ++++++++++++++++++
 fs/erofs/zdata.c                         |  1 -
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 284224d1b56f..b134146d735b 100644
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
+		currently used to drop in-memory pclusters and cached
+		compressed folios:
+
+		- 1 : invalidate cached compressed folios
+		- 2 : drop in-memory pclusters
+		- 3 : drop in-memory pclusters and cached compressed folios
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
index 63cffd0fd261..4145b732d30f 100644
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
@@ -163,6 +166,21 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return -EINVAL;
 		*(bool *)ptr = !!t;
 		return len;
+#ifdef CONFIG_EROFS_FS_ZIP
+	case attr_drop_caches:
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t < 1 || t > 3)
+			return -EINVAL;
+
+		if (t & 2)
+			z_erofs_shrink_scan(sbi, ~0UL);
+
+		if (t & 1)
+			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
+		return len;
+#endif
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

