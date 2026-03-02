Return-Path: <linux-erofs+bounces-2472-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCkIKvTspWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2472-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:03:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CA1DF158
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqby5hPfz3bsC;
	Tue, 03 Mar 2026 07:02:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481774;
	cv=pass; b=bheX+m35XNdRyM+4RO7XwuevVKLAh9YxOAX8zLfHT+lh3OsHG90BUCHNg4KMa4YwTVdPx9a6c2CADQcDpBkkYMmem6tb36m6QSM9awDwMpzOOGKZlSTIhZGSHoWAjkWn88QYHklBFdTMKrXkfUaQZ5BUD/HEyDF3e9kTNvC1W8s/8DDnTUbbmXE9c7RBODyYCrbvmNk4qiuWoGpf9iEGCU4viFVP8xniVb6WrRSMmHd3awDXtthEz6YCPTe6B5BjtYWzwyrVGj9UsGQOK55ZC56wXgMijpFxevrQGlxkzMf5ZLb1i3UvtT5F+BSvxOa9aeL3pLcMCm2r501Rnnu4uQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481774; c=relaxed/relaxed;
	bh=wHLhoq06aHVpNyWZRPSDja4bzuHeEFhkLbdSTlDW2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yttd6ntHdk+OGOagaL4KmCdDZgCbX3AtdTl+VVoWks+4US8AlidZDJr9ndXnOFKTIL9WTvkDSJcOU01GpZA88LLheYQhSmCQkVYjb5+oKjMCyfyoQo/tXPZLGAzlq+Ldy9erb5NiaSLvznbyf3dA0V13/7+TZaNu6vBUVqq4hKDj+Nu50sNvRJLPtpFSQhK8kfch85dR22OwdRU0zKmtGLg4VWekG1NfWIYKa2v5OHQ+IhQ344qwMVqBtsas7lGjFs3fZPypWwzIWVeZfXNRG89AzsDoOtLnBEtsooVPM/cluxqB969v4IxeTrCoHXlI1+b5LuhTBzTGiE2vNupcTA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CjQkkicr; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CjQkkicr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqby2JYwz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+jC63UAKeP/S1uZxi7QGpnKO6dnjbzdRMkU00BktCTBIkYm2OGrHeuPa68LiUlw8+3nloONXAWs5zKv3YqNodIQ9kQwoCE9P60rqfEukLOy6uSsLVXkakH5uqtrA7PT4IsbqGhMrj66aMip8FMNEuxmfikb34xbmQDD95YoKVLimRoT3vguHYwR2CRcj/3zM8svzaxXl+T0zR/NOdq9EshJyYzcl3sAPSCo6zJiDAav3QKucHy5rna3rJAX98WF+TW1bMiDsHY6xWlXkHOqbHyPXPnhVkGJPhrMdvgrNyv1KhIXUp61sArTB0z38rjUEdlgMtZpn5gQiEJeTk2TBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHLhoq06aHVpNyWZRPSDja4bzuHeEFhkLbdSTlDW2EE=;
 b=jLYupoZ45EpfsdpgtZxsmxX2dhmZwaCswxQPeekkNcyosHwK6qVKDZhMFXXxoi2dR7VHVHUiJNuLd38wzFQdGO8drQerhOg92fsiW6FqvyPyKoXg9jG9cFVN/c12YKixJT6Wm1vMdEM9/XBAVpj81v4y+JsDhADI7Q7PbutdoZaRwJfd05jF4/Cb9RnZaku/4siDw8mhlMuB6ykD7si7LKiHOvmSsNM2kljX5qrb4cV9NKFT5730jO5shIA0V5KLj4QF1hL0JOHy8GcHgVfCZbo0KhKDQsWyDNhTBZzKIIYl/cIcRJGeJeYtzclPwl7pbDPTmetZW62id2E+ZAMx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHLhoq06aHVpNyWZRPSDja4bzuHeEFhkLbdSTlDW2EE=;
 b=CjQkkicrNcBGDP5dxLDT803hC15L/Rrpgr9e78v1DtDzuuEyNLTgi/idtu7nYlIzZlgj7aZQca5H6R2LAqvoLC6ah9Ck20pNyBRwhYUfzIKS3lEpV3Z2ETJOXTzuXjbZIxgeLPA69cVsDXl/ssTBSoW4TfVj8h27dUUUXxYFBt1Hy5OS9Zk7qd1nPBZx3/HhGoNBozdcD285/DPaCIG5vAZG4WSrJ+qqjxd/6Z2NiyttzerNtRGQGXO7gAJ5iY4kJ+TkiJu87VaQcnAuPGl+okkZOR9BqM8tRteeZREfQOC6sGn3+yF48oahxMA3e+U1zYSNVN+N2nuw0GwabSpgcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:02:39 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:39 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 5/5] erofs-utils: mkfs: enable experimental rebuild fulldata mode
Date: Mon,  2 Mar 2026 15:01:54 -0500
Message-ID: <20260302-merge-fs-v1-5-a7254423447c@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c7723b3-640a-4c47-c32b-08de7896a7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	I+PFPPu2Utz7iA9QPFWKSDThsPSs8Myj5O8aVxe3O793UfxU8QKvJe/F24cKuZg2L9dZrv9sqHN1FPIWZodoqHk2FhRTbUCzglrp/a++yVGoI6SZ/Fm9xy5TAsn5r/JNKKABL1YHG5GT69VCBssfoEURBKoO6RZyS37YZ6oUHtY3TkONiq/poQEH8fz4sB++AZnS1lCGiAdy/TvYSRNEbpPJZAJJMwku5Xr6Gchb2jdA4J+u6oMQGX234y2gK78jUZE6riOZySYebkYwReCMq4LVDUfxrfryBAejXyj/tsmcfQndb45/wIKh4CRxrg6n122jEoBWqpFhpdrzSbxTO78afF1bVQAcV/WW97eMbopdXX/HNM3n9Z7pEdPBawgE0P1pz9WCoKqHYcG9mo1mJMHfiC3kabSfk5dm5P0+SpLn2r9JsFjrO68DiIZsZEPsXSc1L4GCdQZA30Ne1ftr2LsNxw8WX0e2gglPK8B/jZ6bToh14vaKfbtkRWHqcgkVHeT8OfFIdXYX6gtPBaTbvmgGOEWJpUELzjuxiTRgYzvRgSvRwT/j/FzcWgJaBruoR0acTvRwebYW2+P1m/6upEApGyNCWXCRLo6SMjPyYpUsmTGg6Agp5jq0KLbSdhAfzHO5qQt3pxDl1/zBuLIe8wEhnZ0ygMLMKO1WvPRlTnOYMtODCAlWH6kw+AZ826HYUorwYx9kazwWUlyYpTQnXykTnrrbjXL4opkMJI14AqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akhTaG9yTUZUNFlqbFZtajhpRzFlWkRXaFVzRFBLSnN5RkUwdUF2TU9pNzF3?=
 =?utf-8?B?YWxPdDFVbjVHVDlySGViWXZLOWYrSkUrN29ibjhRTGhuaUpQS1gyMDhyZllx?=
 =?utf-8?B?RUQrc1daTXkzbTQxUEdXZUJYRlE3cm5WU0JqVGIxQUJGMlVZKzM4NTZEb01p?=
 =?utf-8?B?ZURzcmgvVXVLcDY0V0ZpR2VxeWRISjJoQ0VzQWEwTCtrM0dDSG52WDdvMjJN?=
 =?utf-8?B?SUlINGNETUcwVksrcjZnMWVwb3RyU005Um9EVEZPOGJ1U0I5R2tQeDIrSE14?=
 =?utf-8?B?TFE5KzNlVGNLTUp0WWhZUVFITnhLbTNCOXN4MjFMMVQzYXJjdkFpRXZVZExp?=
 =?utf-8?B?K0t5WmI1c202bFBoSUlvOSt0cEZBTDNMY2pvbUV1QUVNZjY0VnBPMmxFZUZI?=
 =?utf-8?B?TVovQlFuMkRKMjBwMVlZemRDelRRZGhvT2xpOW91ejdwaHR0Zkgrbms3dHQw?=
 =?utf-8?B?ZXNtSVFqNWVQVjFtSTF6dzJENEpaQm4vaXJodFNMT0taUlZhbCtZYUxxa3M3?=
 =?utf-8?B?bHJoVTdseXZKUXZuN1FNamk2dnJGbDVWTVdvY0l6clc1K1FCWGttUi96TXRB?=
 =?utf-8?B?S3BITTJsUlJGMlo5RmljQWtTaHBmTFFDMXhpREtmWXBLSTR1cDQzQU1zUWRq?=
 =?utf-8?B?Q1dXTzVHdE9TbkxIcDB4amZ2TSs2aXIwbHBLYjNrNkwvSCtweUFvN2Z2Y2ZI?=
 =?utf-8?B?OWJOQUplS2hRZm5DVmh5RkNVcGI0V3hTcFpvNkVXM1JHMG1HYldQeVBkOUpX?=
 =?utf-8?B?YThUKytCeWFVaG5sVGluamZmZ0NBL2NibEV5SU5QU3ZkTlhkcFpPTUFvK3BE?=
 =?utf-8?B?VTZ5ektqbndKYU9NWXE3TG1sdGY0aDNPREtpVjVZYXlJU2dYZXNuSzNFZHZj?=
 =?utf-8?B?NDB4Z0F3ak96L1NXS1huWUkvVHlselI3bkJ4Um9sTS8vZFRJZ2hXMEFJT24r?=
 =?utf-8?B?N2FSOWpSblN6YkdYeVZadHUvRDRwQ1BmOVhUeGZaZ0czZDdvTTEzRFRQeE5L?=
 =?utf-8?B?NVN0N3NHRCtjL1hKcFIwVk1nRWJrc0tIYjZhbjhudVY4YjBmUEU5a1BYWUNT?=
 =?utf-8?B?VEwwQmNTSW9sTjFuTjdqbnkzWFJkaFVKNW9EVUc5eHNlWGhjdU9ySUpTQmVJ?=
 =?utf-8?B?OEhBcG9nYS8wa241anBhdkdqb0FHckRHMkFnUDVDc1p2YWtjNjQ2bDRUSlBL?=
 =?utf-8?B?aEwvYUJZSDRlMGx5N2hjMnBBcldxZXRoZHA5eHY5N1hDS1cvYUExeEp2U2lV?=
 =?utf-8?B?VjZJMERKaVpPZVphNkdaSERjRThWTFJFdFREaU0zMS9NRjVCY1laT29kTU1X?=
 =?utf-8?B?SWo0ZnJ3V1hxQW5OQXB6RGhKY1JKZ3ZwQTZaL0h6WC9vdzBJRXArZGtmZFU4?=
 =?utf-8?B?VjEvWlZVSjkwNzhIckpLYnJzSkJGdVhqMHhyd1c2RllWZE1vdTAzN0x2NHA1?=
 =?utf-8?B?eW44TnV3aG1PT1lDcTJXczljUnJnM1YrZzNSdTU4SVlEeU1qNDF3V1Q2bTlk?=
 =?utf-8?B?M0FYeWtOTXRUM0FvZ1RxSlBhNUxiSC9JNHVaeUczb3pZa3M2NmJVdEJLWExk?=
 =?utf-8?B?cytYc3UwaGVvVys2UFkyRE5Bc3lhNmo2ZGJUN2paK2hCUmJPc0JkT1F3Z1NG?=
 =?utf-8?B?MjdQSkhrUkNZVWcvSDk3S0lRTEgwdE8wdWg5VmtVYldGVkFNWVVWVE1PTGow?=
 =?utf-8?B?c0xMTG93NzBRbURsOGliRHpoczl3RVRmN2gxU2NxQ0l2bG9vT3pXeHhNdi9s?=
 =?utf-8?B?aVg3NHJPMmtLUmF6UlkxSzAvNmU4MWpKdms2Q2ZqcHk0dkQyYWVOM1d4UXBz?=
 =?utf-8?B?OEp4b29Vdm9uRC94eGZnUVMwRzEySnlWZU5YTHUvTWFqY3hhVUtDMW1nT0tF?=
 =?utf-8?B?cm5Ib2podXdXa0ZXN2xjMzJHN3ZoZ0lTU25ZMFNHLzBxWTlpQnVSZHczZWEr?=
 =?utf-8?B?ZE4rZUdSTlBXdThzS0FRdkprUDA3R2JjNUppTUZWRm5pODNMQmt6Z3VBL3BO?=
 =?utf-8?B?U05tTnhTM3lXNFpzTCt5b2VadTJMcjJqYkRvU0hFcVNWZHZ1K04vSG91M3hD?=
 =?utf-8?B?TUxIVHJUWGI5RnZMMTZ3dEtpZ1NIZ0ZTWnBDWERhdVY1NGNkU0VSOXF1cmZx?=
 =?utf-8?B?NkN6UEtGdktTazNrN0lhUHZrdXVxZ3A2RWtOeXdra3MrWVRwY3gxRDFGRnlw?=
 =?utf-8?B?VjVtMUVWalhRUTAwL05YNUJIQ01NSlYxNEVMWXNnVVlMUndVSUw2b0JCQmJY?=
 =?utf-8?B?eHRldVM3SHpnbkZCcVhueCt2bStma1ZaZ2kvekUwWXE2SFkzemRJWXJVZkdP?=
 =?utf-8?B?MTRHTExTYkd2QmhFRVN0UGFiNFJITTBJWmNrNEpmTDRNT3dzN1Nudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7723b3-640a-4c47-c32b-08de7896a7d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:39.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7w6YdnnpoxPuI16lznzcXmziKGZtNyoxLuNVpd4CP96ernXZuEqyVBHP2qXUDPi4SYW5VCOAOkiq7ObjS7E2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: F38CA1DF158
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2472-lists,linux-erofs=lfdr.de];
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

Finish enabling merge functionality for rebuild fulldata mode

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 mkfs/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 124a024..4c96e9d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -105,6 +105,7 @@ static struct option long_options[] = {
 	{"MZ", optional_argument, NULL, 537},
 	{"xattr-prefix", required_argument, NULL, 538},
 	{"xattr-inode-digest", required_argument, NULL, 539},
+	{"merge", no_argument, NULL, 540},
 	{0, 0, 0, 0},
 };
 
@@ -254,6 +255,8 @@ static void usage(int argc, char **argv)
 #ifdef HAVE_ZLIB
 		" --gzinfo[=X]           generate AWS SOCI-compatible zinfo in order to support random gzip access\n"
 #endif
+		" --merge                merge multiple EROFS images into one\n"
+		"                        Usage: mkfs.erofs --merge OUTPUT INPUT1 INPUT2 ...\n"
 		" --vmdk-desc=X          generate a VMDK descriptor file to merge sub-filesystems\n"
 #ifdef EROFS_MT_ENABLED
 		" --workers=#            set the number of worker threads to # (default: %u)\n"
@@ -1093,13 +1096,15 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 		}
 		break;
 #endif
+	case EROFS_MKFS_SOURCE_REBUILD:
+		break;
 	default:
 		erofs_err("unexpected source_mode: %d", source_mode);
 		return -EINVAL;
 	}
 
 	if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
-		char *srcpath = cfg.c_src_path;
+		char *srcpath = cfg.c_src_path ? cfg.c_src_path : argv[optind++];
 		struct erofs_sb_info *src;
 
 		do {
@@ -1550,6 +1555,10 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				return err;
 			}
 			break;
+		case 540:
+			source_mode = EROFS_MKFS_SOURCE_REBUILD;
+			dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
+			break;
 		case 'V':
 			version();
 			exit(0);

-- 
Git-155)

