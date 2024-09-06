Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069596F3C3
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 13:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725623790;
	bh=3aE2peu4ZfsfJOKptuUx4U0fDQHBWA9bVQqTdXY+k+U=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=FILiHDwHrt3gxo1Fwj/rIDn3fdMlEF59g2nIE7EWwOmXmZJw/79LVwi8YHUiaM4Bv
	 pupBdNkZWiNrhrQ6KKGuuh1dzovvv2BEPvnh/Z6HHDQj5jBKyw+VQ4LrN+crYnwWQI
	 D7PIsd56zEOHJesm1iaf/efmufbH8uhfeGkGRg9AX67FwCQlZ0a/Ux/NzkG12ftYeZ
	 FJ8is7lR44FVBA6I8Q3PP+G4RnpGXDXD60o9+cgS5cZlhYxjqgpI5j/rXHqnIIINhM
	 iJCA/GAzS2mIw9sOuKQaRJqfKAdOWYMHVKr+bhjbK+yAQFq4wITcPS4pwqfgiOeA3D
	 CeBpEqtBGNgIw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0ZSt4T2Xz3c6n
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 21:56:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f400:feab::606" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725623787;
	cv=pass; b=Iib/lcT/jjIAcTq+x+xlByn35G6/k1ETAHqii/MgUoMK+qUiW1qiM5rirXBxiY6w6daP6++xywDc35bVBYqvEv0+df/xTTFdf8FIUP22sa6VcRAgD86i1nX9Xmg+CnMMgihNQCdxvZRcaD3Ecsj2ZNfhL4FXscceNPylTvoWZRVeJfQSpz5+80E7KKOwAROM+wEnPxck4UxItdqVJR788U6Vka7XY9s+xw7g126eapApveSfrINfoQhaI3B04e5SH6JFcKgBqBfWLlD4oxBpIXgGmuc3+rFbGS0su5WQyf3P/qOWFe60e+KstjKE8DbkN4TABNfeS+phvhHG2EEGhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725623787; c=relaxed/relaxed;
	bh=3aE2peu4ZfsfJOKptuUx4U0fDQHBWA9bVQqTdXY+k+U=;
	h=ARC-Authentication-Results:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:Content-Type:MIME-Version; b=Db4ZxzhTgNeynD9t4XACOxYhwIZNpsVefo6IIEPsIXRetSdeTwvtoKEWO2AnWD5BtQ0izmll6y/1i8O3ROsnvdKAQ90ICoHt4CsnMXl6Y9D2lty8b/5yIGxEdc/Y+AvCHv4s+m8jR08J9AXNsI0AgH8/Y6AIyf3audTaLPLwZBWRNRlYHJh4L8iV2eBrD4fBCLo8ELUsh9Isv0Z8bkNQFM8jgCTq2c7QhZzFVl7grDpp7hNhqxbn3FUDLSLGxpOqIXe1+kuEmXSvpybvNk6+PP44EFaVMuBOBT1VRUDKXiJAhU/r0s1Hn8hoev072W5PgxOAKEJZRP74jd6pveXjLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Ho2shqbz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f400:feab::606; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Ho2shqbz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::606; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::606])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0ZSp24Q2z307f
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 21:56:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiB/O//fV6z9L8fKzoJaZehlqYv+YKNbbIi5pUHYEKJzW+M29iGWBXpMry9JlyjP0aVRZSOZdmX3o2zv42REGCNRDfgcF1yvXvLOcU6luIDzgSn/xtpa9uRaNoVLJbpOXulPwa9bmRdwRPXSMSDLkCG8JQdLToMSYvBKf4y6E8Tpn/5ve+N5ubL9Cq2gN1Q/cKp1E+t4LEtFqCyi5FRTzsW3WnN4D7+dlJVV3hQ2J1tF97wTns4EvUcFhKcyj6jhgXSGO/3Tr2vOM7Rle7dQwPwB/q6qsfMfYBuuZwHFMHBVfKQF5bzbTh390yrk6ZyO3v/deKkoDdMFWfkHlPGBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aE2peu4ZfsfJOKptuUx4U0fDQHBWA9bVQqTdXY+k+U=;
 b=FNbjTorcSfe39as3X16zPNt4NLp2+94AEoyMN8jpeV+Woae8MwSDFcL29kMJD0lzFLtluK3AO5iyNlCWyZhFQ64s6K6kNPL11nuQY0WBsOHETwZ5sxUp0yL8AK2asG4cT8CoCCRJoB02FpuOwjiWdUKJPUnobh+tf6OOCQGZ3rcqUC4GnHiObkWxIKN0FbH6e76LUBr0jNjyzTCF/mLVZXmA03C22ByGGj8Rxk09SYAQPcRjkCiajYFymJbg8p96A9qMjwlRQVyKQUFu/pRyqNZ73wP7Q48w58+ha30xOSMU2m1KMJN9/sI9fI+zcdY58i2tWUBbKaZc3HDbmCnMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aE2peu4ZfsfJOKptuUx4U0fDQHBWA9bVQqTdXY+k+U=;
 b=Ho2shqbzLvPeFnmWwvtMlhMxRR4ClHCtQLFRL6s1sVvOhtmzO7tvDtCxggKXImra5pqDiJYgbxWX+Q2PX0kQPVYra1Zvwj+aoziEQQkaDyBY8NL1zwbpED1LFrQkfx+rJ3Y3KDz52zAYcTKf6Mdq4vpi0Wdqr9RUHkhzjkMGm3LQBuB5sZEH4Hsg9TczWbPKIBuDMTXaRQhjKvMg8TmkeiBwZXSellskXvu8xr2XtdF8VwKWCbi2eKHezR6Vmt+y7bsXZvybISVuh11NmL+A3l7T9r77xZ5zLSWUIuT0ito3ymrz9UeUKhZHLvgHFjNt80UfIFVaVkX6vDBtdCTt2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by OSQPR06MB7280.apcprd06.prod.outlook.com (2603:1096:604:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 11:56:02 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 11:56:02 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: allocate more short-lived pages from reserved pool first
Date: Fri,  6 Sep 2024 06:11:10 -0600
Message-Id: <20240906121110.3701889-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|OSQPR06MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: de1a89e4-840b-4d95-b563-08dcce6ae177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?SQRilI8wcQEo5Ev9Qp3wONXf2Mo/jHykDcKtWzXkSYY9gEuO1SccWrAvpP1G?=
 =?us-ascii?Q?xy0rgwKMh3+WO2E2Or2s1YAG/Fmdwib9AoGNL4iw1Gz8klonQKXTdzcXUkm9?=
 =?us-ascii?Q?r4XxyuBfPRj0zsK9M/FRkvSns63uyRE4P/M34jUS2NFapcctLUlfd1RlRT3Q?=
 =?us-ascii?Q?8x2A4a2R/vHXjA8UQ9DJpe7pmOgfA+g2xQCVlIZSbBcX52FWW70o7LFh1Spm?=
 =?us-ascii?Q?3tb/76bRgJk+9SWJds+6BXvKp9LMMWoCFdo9AVh1as0A7oHCXznue19LDpTN?=
 =?us-ascii?Q?TuwnEGn4SDWHMC/MROG+GOiF0IQ/SBBzPPu2gT1WC3qObaFhDsInObQPItCT?=
 =?us-ascii?Q?XR9jWT2xPhRG1EnPbGvQbbDHzlUvtnf3c9krYFXc0zVbp/NkNydYr/GoSONZ?=
 =?us-ascii?Q?DKEo25Pl0+On33adwbPDj5GGitI/EbU48R8dAushmSImB0QXj966URpzaW21?=
 =?us-ascii?Q?lWaI1c7k+Rvns6RtaDA3cUHVbnWCLD2RGc87JvSj/B8XIOFVAfg5Ex7KKHpU?=
 =?us-ascii?Q?bVkbJp7dOq7ax3dEeBjkz4hM7LQvIuZBz1hl4ukQEisAweB5GRQHuAaSbr9x?=
 =?us-ascii?Q?X4KPT+tPlxC7wRl2OhZG/A2241eqxZhASnTXOmo3u+fA51inwi8ho8CC3Vi/?=
 =?us-ascii?Q?5muPCTIHqSshnSZGpLvKuh8KbehDHhEWjQh/RA6xkUJGMWjZRrE7YkHNItcY?=
 =?us-ascii?Q?rVt5ZgqwAO/msUn+5AdCfwZVcYiDfazGDQXTnDhhE32rxb/qArHDpZ36m4xi?=
 =?us-ascii?Q?wwqXL9qW2fG/fwPeqifCKFOnalgA/8GvewlLKDfkE6Z+OYHyP331p1dhRWk5?=
 =?us-ascii?Q?AVPkWEBqwDFL2WUhedKAHOrBsU9W5Y7pDG62edmqdL99vMyHPw3On9aNA33I?=
 =?us-ascii?Q?qQ5IOCWNFrwA1OdVzW1opXDZgTzShmxCjAqoaMaICMI0JKAbyv6YMgPawKPB?=
 =?us-ascii?Q?Pxt3KKFJnSlPxiBWvTehVPJhfSIrp0exABruMFpKtzWvgeRLIBx33VWrLxnp?=
 =?us-ascii?Q?6OkMKiFTAotZVvMHvLaJIda2obXrlZGtPUQGf8+4JXeNWaaUADLqTVtoQml8?=
 =?us-ascii?Q?vrf+jHhiSkP1MdllSTF19cuI2AHQYP5ZAF/iplXi7GQbhW4G+YBrFU2tj2zG?=
 =?us-ascii?Q?2412ok9+u8GgIj0is/wloWbB7Anx4y4+hZKcWb1C9WAmQQHB+Z83691Ii+px?=
 =?us-ascii?Q?aQgvnpQPS7ybvlC2N0zEpel9db2yVgRS8HdUvm7ky5+9dAIvQFhbBAm9y2BP?=
 =?us-ascii?Q?8qUmA1hgY1f7o0xEWmo7jpJwfc/DHRCk7/Rqw8s36wPIz8/MGizKxJ5D9brZ?=
 =?us-ascii?Q?Ecdz9yZ8RbfsNjQdbUfwkN+MO1smJZB2h/SGztop3uzqswuQFm0MGwpJa3qB?=
 =?us-ascii?Q?7+nkVYuP3uc2S+iQXyX81lRFvmdAHeTbCbDAC3XugvmiXYrHbQ=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ivlk3w3CybBF1j0b8sroOuTb3YGIIXVe0TFtV85GYdd4tng/YM7Ne5gTG3Me?=
 =?us-ascii?Q?2C4ugyPsnUSoUj+58A4RKIriyZrURcsFSxCpC7a7h0fFp6aUts9V81Sg9O47?=
 =?us-ascii?Q?T1HfVQ5jHR4/omD0zCLpB+BhedoH4gsYoqGonUEet5ZwON1DkFApz9U4frLl?=
 =?us-ascii?Q?HXV4zGsjj2LScHnh+b5ve/Wuy7DzJRoK8/yRkMm4oXL8BQNNjlHMBxOpikrD?=
 =?us-ascii?Q?L9NeWjEny8DLvbtx4W6fOqw9ukLnHm7O/fRTVhyMevVowo6UU/spueZG5MHB?=
 =?us-ascii?Q?/yJJ39rVnTP2Y+2SaYSZsSNyd0Qs5s7V6w3r9V+S8EIOi1QEB/upVIwNhrun?=
 =?us-ascii?Q?KiK5vMrWEC8PNMJzobNvWbY/6Ugl0F9YgB3wZuCI77hnEE5eontSDaa5xB5I?=
 =?us-ascii?Q?h5Ca6bzXW4em4wSIIoRHQCCdaSaCcAsabXYmNseTYXx+HqxL4uRkb1I4xJVg?=
 =?us-ascii?Q?RaciQAEdBoLiQd3z6dnbXTco9oAyhus7/SWdMlpXxIYI3URn0jmlPOANIcCp?=
 =?us-ascii?Q?+F24ONanLtAGXcDHx3cg3YotPgCWvdIiQnohU0QmWlbJupTRrOkOTvMdXoWQ?=
 =?us-ascii?Q?7ZGnYWrcpMT9gsAoRBffonnGxGIf6nhAH++HoWkyh1SPTcpQn/RMKzilMonp?=
 =?us-ascii?Q?m2VbYelyJdJAPcXszmD7TKdjeRJIcRREVogcDZd5BYxA2qDGAszHlB93A+yX?=
 =?us-ascii?Q?9GMjwUcwu0+/z67/JGWr8kVbi2LWPmyXNX1qIlgGS1YwuVUBoJ50T5oghw1O?=
 =?us-ascii?Q?iMGvIEl8QkTQMuOHs9cqa0Wa3So6NxEt1QUTkyBT5P1Eq8JGtkinfym5+2l+?=
 =?us-ascii?Q?Mnvs4AyHk1Ju7ZGKIgl/wzJlAWGw6ZotIQfzdaafq8izWMEgTW25TAZ5Gai2?=
 =?us-ascii?Q?E+NQkzmWhOARwYuHCEY88x9c8kIkhGs5xUsc+7HzjbQv/i1RNmaeyCDPxyVV?=
 =?us-ascii?Q?+EzOB13nEURwfB4/CBs8N1S3iaD2eQLTUVHMlWu5pz7VStd77PZxq4Lwwf0v?=
 =?us-ascii?Q?aeD7SLlVE1bhZigXaFkC9g51rm1rqS37OedQZiJebgqB6NjhvhNZrapgqtdG?=
 =?us-ascii?Q?ekvqRJptcf5y+Wgu0U5GkC15Vv+4Yr6aYqPA5fSWTxZ03XzOm1GuItkqBpdC?=
 =?us-ascii?Q?+2EZi9BTMi9Emt6uzvX0OqClIJf3xUI065h6GMq1Z1dpaIUhrYQ9exf/YYNx?=
 =?us-ascii?Q?j0UnVOHlupOC0ZBbC8E+OJPca2jwo0zTbCbQF/WKRmnXSDtaknvzR3s5MEAs?=
 =?us-ascii?Q?uuq++q0NVaYB+slFpxXkXPcHkB08uKYZHDZ7xA9xabll/k27VqFix1RAyw/u?=
 =?us-ascii?Q?S8uxuJYdlkChRzUZKAxI1N9L/KOY962ADJ4d9inRswFOeHpxe2kRQiifhi+2?=
 =?us-ascii?Q?2aMQxB4kZ4ZkdOJOqOq6pVl702pYczQLOhaiXaKUaTwktiAJHF5jNot3xXf7?=
 =?us-ascii?Q?4Xov8ftb3B96nyV0XytIyxlBf5R/Vipuc3gzizVJbODQ4fR8YIyNfTv8H58u?=
 =?us-ascii?Q?0E6Ic8X0H3pv9Kshuz5EAypkxHxf8FrEn4+9C6P8y2FudOk7ybh+7BEBJWLQ?=
 =?us-ascii?Q?fCM4O1PhnVvJ22562/UI41B02J9QK22CNN0rw6LG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1a89e4-840b-4d95-b563-08dcce6ae177
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:56:02.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VsLYhJisYORbC5FwAW5eyLcCKaF7pJPTZYWzV8jwsVTK9648RMG6QrAi8IZfoZy7JQxyDTgU26sa3yTOG4fDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7280
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
Cc: huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch aims to allocate bvpages and short-lived compressed pages
from the reserved pool first.

After applying this patch, there are three benefits.

1. It reduces the page allocation time.
 The bvpages and short-lived compressed pages account for about 4% of
the pages allocated from the system in the multi-app launch benchmarks
[1]. It reduces the page allocation time accordingly and lowers the
likelihood of blockage by page allocation in low memory scenarios.

2. The pages in the reserved pool will be allocated on demand.
 Currently, bvpages and short-lived compressed pages are short-lived
pages allocated from the system, and the pages in the reserved pool all
originate from short-lived pages. Consequently, the number of reserved
pool pages will increase to z_erofs_rsv_nrpages over time.
 With this patch, all short-lived pages are allocated from the reserved
pool first, so the number of reserved pool pages will only increase when
there are not enough pages. Thus, even if z_erofs_rsv_nrpages is set to
a large number for specific reasons, the actual number of reserved pool
pages may remain low as per demand. In the multi-app launch benchmarks
[1], z_erofs_rsv_nrpages is set at 256, while the number of reserved
pool pages remains below 64.

3. When erofs cache decompression is disabled
   (EROFS_ZIP_CACHE_DISABLED), all pages will *only* be allocated from
the reserved pool for erofs. This will significantly reduce the memory
pressure from erofs.

[1] For additional details on the multi-app launch benchmarks, please
refer to commit 0f6273ab4637 ("erofs: add a reserved buffer pool for lz4
decompression").

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zdata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3039b2a80ca7..5fd399c638c4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -196,7 +196,8 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 		struct page *nextpage = *candidate_bvpage;
 
 		if (!nextpage) {
-			nextpage = erofs_allocpage(pagepool, GFP_KERNEL);
+			nextpage = __erofs_allocpage(pagepool, GFP_KERNEL,
+					true);
 			if (!nextpage)
 				return -ENOMEM;
 			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
@@ -1464,7 +1465,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp);
+	page = __erofs_allocpage(&f->pagepool, gfp, true);
 	spin_lock(&pcl->obj.lockref.lock);
 	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
 		if (page)
-- 
2.25.1

