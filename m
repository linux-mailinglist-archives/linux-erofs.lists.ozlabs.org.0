Return-Path: <linux-erofs+bounces-2470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGQJHvLspWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32A1DF144
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqbx1mrMz3bnr;
	Tue, 03 Mar 2026 07:02:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481773;
	cv=pass; b=Ia4S6SiEh3ylAZzjy26v/q1e3hhyXj3DBlQjTSmDfro9WVeh+Pbqi/2F2ToLNZJwpk8WUk0IoQc5eDzLE7FF6rjunADc7uPh2zVdztG8esD8ronTMZOtvls38dHq6/P6io02IQTIYrPF1Jy97fvLrmZD4oj9gyPvgr65EDrHIfZBk/ALWpSv/aIcYkAlpN9E7IVVLY4uXIRbtu/TLnGCpZGam9gI20RcMSXiMjYALfzFfq4F6nqtKo0VTC7uXnwzCxXfjZG0imaqqWhTn2JK/vhPXN1kAzSC2oc6KGaFfnhadgEEqdXXltAqzIwcse9yw5fUrCsyfhW0I7CeSJbb1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481773; c=relaxed/relaxed;
	bh=2ZEa4Md6K9ngNQn8nCxwxSfS6pNZu+FBHensqT0iJ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgGNlkGdhAxL1bBYRlxuLFy4VallK24f1dPfLupDPTg6UqLz1Fz/ohk+CLxpfB1BasfLXxjVzXWG6w+pRklTqL3N0ykdVRlLMhGj2S+jfVsyOb44JN2XEStC9eGr7JWJk65RP61P6Jk9YcFYlBY20EyiOt6ZsdtZmI/LzQg4iLdMNIJUXOJ/6umlx1cMXaQwdmaPwiicn4ZrWjxP5UxsaM+qZgWT0l8RRuAwZrPxCKXZeslCdZ9lppQbcFINkjRx3CUDvXIxh01DlRelGWMnA0JnPDB1Km0j2e36Bzof1Z85WEnA8p+dvxfA2BtZ9SPpp69sZUKEraUO4viy04fEDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oa+nkqiI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oa+nkqiI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqbw3SWqz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruqJF3xvqFt73d93rDyj4DAtJE8kmDpIKHn5X3kpJs3nToYJ3prGCX+l6RR0EeIiMS8IzpDJqbbcFWKrACMjP4R8uF0z4hoBeoBlFgoJgA6NXCXwhe8LCHxMkF/5xXaQ495S3CCtGw7tx7H0rLL+aJQNKHNUH6oO1xDE1Q/2sQuteA9zNQfWNuCp1wTaypKqu5e8QgxffMeEaJRAgjEmjBPU0fGoeFdB1cht4voDVC+oJjqQxVdfsLH4d0jFASOW+QcpLoK9GItggTzxz3g33Ab07bv44Vj8fomoSYXRJM38dg9W08CJJNi/TTd+B4xQqGNfWcLb26Qr0T92sq0aHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZEa4Md6K9ngNQn8nCxwxSfS6pNZu+FBHensqT0iJ0w=;
 b=iE9qbc/k3QaN9QslOp49n2EtfnWGaOrrdYLJCiGyQ7fFMb0S8CpQ35O1TTpT78sAy/yulHCIqp1A+YRHWaqwqbb7rXCFbWeDdvVVhByFAsuxNtiCuER2go9GrxGCNiG5zTjU/R0es1FkJpeaecvxlOO+nhbwF5rVBXL1mS4nl1LxByEtFEupZpFBeIJ9k42opMb5s4tZwfZST2HX2Ki8/ANAV7DX7dhUb9Spv506KEzQhmZ9HryRhWDSHi69dVl0VfBJjxOAHGpOc5R4X46p/+oL19o2e3wb8wvGyVa/lUl53ZGQR/uYNBvOnK6K6KAOhsNF9DUesuduxTEq+sy8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZEa4Md6K9ngNQn8nCxwxSfS6pNZu+FBHensqT0iJ0w=;
 b=Oa+nkqiIzoB6u/dOusgub7Xryo32k/kvmE6sfZRZi9wv4VfALVAgQDl5wXNSphkt0PTOwD8g7XWHl/OeJKpw0CW88zw0B88oZng5YerWxvppcJm9diLTwBMD5ErIXgKSrvGambybIxIretKrupqssI0rYsVmfSmz4xnu9xwMpea0FeewZrdtN0aE5KPPcPgVctVBxnFDlN0iHvsubRaxgXRKNnBgJbzoeWT+9Cc+3ckqaS2Y3iBo06estbLFG2qrYta0BQMX+nBN3saq8LQGRkHx8/4V4GD46E5+ASoYPEzpxgSWoWIHi/43tWDr1mCzlAtpH2Fu55ZQzaRH4bC0HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:02:34 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:34 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 3/5] erofs-utils: lib: preserve primarydevice_blocks if already larger
Date: Mon,  2 Mar 2026 15:01:52 -0500
Message-ID: <20260302-merge-fs-v1-3-a7254423447c@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DS0PR12MB8502.namprd12.prod.outlook.com
 (2603:10b6:8:15b::16)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: eaea4f49-c9f9-483f-b670-08de7896a4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	OQsYkKAFUYuwuW8oetUjepcuJBnw5nj6gqIRPogjTNR9MaW3dYkFftN6C4aNgRRKF10l+U3bzFFjnf4RwEArMxo8SL1x5/k0hoDxJ/x/aaOk8SzGfbOyZuo2rKB8Xuso02PsF3JGN4UGcb1h9YvVHvC7frvwn+se+xSLoKt+0PHgDQ5WEdj/27nP1lEabDjZCa8CjQGqZwyPVtnwWi/meFlvvxP+qDNWceJoSBWD5CP6Ehke60XbFvcU92TpK4bOYPWayd8c+d/makvejUwRChqdnzPRGEiaXIDxF2serzbVUM966+VwfuvjHEk8r2XLycUUbLO4jxEy37lRi6KYcylcNY3AFNQarLVpEmDncfjxviYN9sGw3qX6cMRUwIBqD0FVD0ch+f1BmsoQ4kTf4OxSaE7cAivet936BPKJo/jMrQ3hHDVwvDe99sRiNiQc0pIWfD7liD6OJ1YHRzrcWKlkcaQLUohsk/d8+QP+RnRaL+v/dqfmcAhX4/bTI28u/2TyHqG9qWR/8h5UV4yHugX5vsFrKKT+0rWt67f0krAwRORgBokT1INCMmx8Ahdhw3yAbCP3jqXdSkG3h+mrVFKTk15ffhdfvX3TXQeHgjs0W23xmFMEG1sIUSw86sZj1ZO7ziNY98KGa0K6Sx4bNZa/QQCXmnvwlvEiwgh3oZUjh2J2OH2OoxzxUCctgzrGOilX2UnS+9PgUSDX6XJPZHi0tir9D8pKNyTaqwPdFGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZQT3hHV2lXaWVoQ0JwWGxNMGgrRmlKcURmSGMycUZhYzVwSWxZdzFNMzY1?=
 =?utf-8?B?Z25ENHd6Sk5yRGo3c2U0MkVzZzN4M1lBVGVaV2ZnMk9OQWZvT084ZHdsQkNF?=
 =?utf-8?B?VTR5NWpDWFl4ajdpYlFoNGVQUTNEQ24xcWpUL202ejd4bS80cGdheEluRHB6?=
 =?utf-8?B?RWZadXFZVElmUXhGOXplWmFmMXpseldUT2lpZkpudjhlcWxheG9lNmplZ09a?=
 =?utf-8?B?QkVPV1FKYkFvVW0rN1JBUjA2MitGWkR3eWZDWlM2M0xyRGNwUlJNWmJBRTRr?=
 =?utf-8?B?cVp5Q1lNVEt5RXRmVlRYamFmdEpCeDRxdGEyeEhBNFJSZFFmNUhVRGNCVEl5?=
 =?utf-8?B?dHM5Z2U4dkc3b0tIQklwYmpUL2ZEdmp0NGtLZ25aTFBZQjNUcEhhUnpFSXZm?=
 =?utf-8?B?VUIrb0hqZFBnNS9Ma1d4WVVjS3lmT0E1ZEFXNnpHNWhKQi91anJlMjYyMGNw?=
 =?utf-8?B?a3FRZDFWS0ROY3gyREZ2WklPOUdPR0JpZnF4eGowZnF3N2VGZ0xiRGhCRk1H?=
 =?utf-8?B?MGI2R080Qkd6cEdpZTU1ZGJFRlBCc1orSFZqK0duNmszbUw2NUtMeGNhd05q?=
 =?utf-8?B?WE85MVpBS0RnOGd2UTdqWkNacDBYVFMweXFHVndhUjc1WUZ2cHZBM2RJY1VL?=
 =?utf-8?B?RXkxNXdxd21GZWFFSTVQQTRzVms5eWZoSHBSbWg1ZmRLV1NsWTRhaWZ5Yy9C?=
 =?utf-8?B?TlA5MndhL1J2UmIvU0xEOGNyZlk5YmV0c25vWmxMMmNhclp0eFNPM2tiT2xL?=
 =?utf-8?B?cHFVNUZXdEQ5SUtLdGgrd2JJT0ZOeGtZR1RLb0x2YXNCMXM5c0ZDTDJoc0Nz?=
 =?utf-8?B?MDdaTTZicnhESGNBOUppUSswRE91SjlmcC9VOHNJQ2t0TE1jZ3NqaHRnNkow?=
 =?utf-8?B?RXdScU5DZWtoSlUvK01BVGRqMVM5YzhnZnNCTFNlNytjY0VUUnVhSlE3bUV0?=
 =?utf-8?B?bG1lbDh3VndwNjBqUkdzR2dLQVYvME50aXNMeTBwdkdNNDBUWDBjaDg1WURa?=
 =?utf-8?B?bnpBdWUrUXlnU0UvdUsza3NkUy9WOUVWU2kralR3TnppOHhZckZ6QStYT0pu?=
 =?utf-8?B?NVR2OGwxd3U1c0oyc1hhcGJqQ2xYNzR3VUtEN1BYc0o5Y0NYdGlzcVd0cTRn?=
 =?utf-8?B?aWJ3bUsyYXhVSHpJRFBrSVpYUm9xVXd0cHFVQWk1M2dJalRqZ09Rd3hVYndB?=
 =?utf-8?B?eHNmRlFYMzZWOEVPQm9vNnBaVUdxNVoyalEwL3U3QzRoN1NaQlhFRGlpVjBB?=
 =?utf-8?B?bDczODQ4V1FPS2UzQ3M1a1BvL0svQTZPb2FVRGFDTnIzSzFHNkFtdDJnbUZW?=
 =?utf-8?B?OTdMM09ZVTY5WE1PVUoyWlJ2b0FjLzFmaWJ4T01xMUgvYjZuTVJXbFlhRENC?=
 =?utf-8?B?VzF4Q2s1UmRxWHdPM3l4dkx3T3M4Y3ltRlJpcC85dS84dGRaUm5pbGprclN5?=
 =?utf-8?B?Sk5oV3lLYXVveHRqRzA4dHZDaTFRQzgwZ0xSN0NXK0VWZmUwNHBmazFwU0Fr?=
 =?utf-8?B?amFIeHNNSFRaUStkZFZndVVzalNpcGg2b1FlMkV2L1pPVVp0bVBBRUR5aEZE?=
 =?utf-8?B?ZDdmRG4xQ3RKTXRNczFMQkpFQXVDYTVXNUJGR2Z6MkJ3RzFaRXcrTDNNamJX?=
 =?utf-8?B?Rjc2bitqVzNCKzJBYWNoRXZWRWFVYlRiYlY3Yjk5SkZob09tM1pGUXZyTmo4?=
 =?utf-8?B?UzQ1R2w3Zjh0MkdzcnRUeFdvS01ERDA4VzE3WWhWV054MUY1WkpncVczTE1Z?=
 =?utf-8?B?ZElrT1JqRHJIeUR6VEhGbi9Bc3luSkNhemI2eDM0U1RQdkxZZU11Vm5TWndt?=
 =?utf-8?B?SlBSVUpOWEhhSFdBdExwZ0k2bFlVWENHa2ZUektCYWJuUkVMbWMwbEVKYkR5?=
 =?utf-8?B?dEJDQ1Jra25aM1hkRm1WM1VrRmlzcUxJWDBsckRRT2t3RWFDRmRqODJYNEF2?=
 =?utf-8?B?a3VneDE1N3RBVkRkTFNQQUQrQ2RiMit6RHd3VnhrZmtKZXl2M1gyZjlDd25w?=
 =?utf-8?B?cmU2MHFKT1dLd3h3b3kwKzhhYXJRRHF4bW5xVkd3dzBDRktSckowRTBDZm0v?=
 =?utf-8?B?bDhnYUpoRjgxOTF5ZnEwTTlQRExlM0oxY0VtTzhmK2ppUWR0TlNJMmdjZTdn?=
 =?utf-8?B?M3FVc1pRSzdubFlvUVVMT0lhNThVK3RPTk5Ia0l6bnhybjhLbWhPUEhrT3h1?=
 =?utf-8?B?OXdORWhvY0hDbi9idGFBSU1yWWppRkZVYzhHeENLTjA3UUE0dGxtajBsME1n?=
 =?utf-8?B?WlIwNXcvZDFNMms4V0xIK2JadHM4a1lWSHlnY1NoRjJUcmFXQzRnbzJHdjNp?=
 =?utf-8?B?ZjFWTHdsbTl6Q0VOaDJKUlpPUkVoL3F0WU5vTUQxeFhrMFNPbzFYdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaea4f49-c9f9-483f-b670-08de7896a4e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:34.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZbOEhMHjhKelMp5vmlZGHlIKu2+Vvkb1eq5a9vp7W9Xio9xm5bhNFPlZtxufz+fdC2HtUqMyayja1xMPBTxVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: CC32A1DF144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2470-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

Change erofs_importer_flush_all() to use max(). This allows callers to
pre-allocate space for data beyond the metadata region.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/importer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/importer.c b/lib/importer.c
index 26c86a0..56c8ea8 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -126,8 +126,9 @@ int erofs_importer_flush_all(struct erofs_importer *im)
 
 	fsalignblks = im->params->fsalignblks ?
 		roundup_pow_of_two(im->params->fsalignblks) : 1;
-	sbi->primarydevice_blocks = roundup(erofs_mapbh(sbi->bmgr, NULL),
-					    fsalignblks);
+	sbi->primarydevice_blocks = max_t(erofs_blk_t, sbi->primarydevice_blocks,
+					  roundup(erofs_mapbh(sbi->bmgr, NULL),
+						  fsalignblks));
 	err = erofs_write_device_table(sbi);
 	if (err)
 		return err;

-- 
Git-155)

