Return-Path: <linux-erofs+bounces-2467-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNlRIOvspWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2467-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E91DF12E
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqbj4JbPz3bn7;
	Tue, 03 Mar 2026 07:02:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481761;
	cv=pass; b=hBZUlQcmeAkXZmq9NTT7QXn42VZvaHXATN2z4Ew6TgIXqJwLdA19/lKOjXcAi6G/wObkB90tIfpIPsiPJmzirAfLcKkl4o+cMHbvW8b1oB0WbYAI1LKll0GKHgAMl0f1EyTzqEdXjUgAK6FFdCvpQv6CsW2OBNLOwr9NanLmpTvTx0srwZtyFnNgwd1V1d8zbI5wkoSuvxKG69YrvqQ+I1ejMVINTgC1RWAYleulZ/qEpACVTXrqzYdqyrajC/w6yGO4z2v02K9Y2dTMA5u011BxTzw2JvQnlP0Lsk2z2Sl4EAaaUIaoSis+oBzVqKF68IsjbWi4yNKD4m6lyBHY8w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481761; c=relaxed/relaxed;
	bh=4Mibit3rg75FY8cAhryOXH50OLJ8mlPg11tj0EUDmys=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=la2ajvUwDpBDNGLAufME9N4k42Vfj0Kc2LUEkPdB8uQ4wnScxdDL7e+n+ahgqT5p6iDdp9L2LmroDqwelxpZOZurMI/xc0iqpoH9YjQRFbna1e0hoWd2+g5FQdC8pWrQXdoURw/6eIIfTsqDVujke+0EESdxFuDs4NF2/zKFqQgYGB2zzU3cdozcQQVRGwhunOwClUK9zyO110mYITGh+rv8bgoWZ0FGVPArR3s6H75G7wqghG+JKGgkQ25KfKeLACkFG4jyIbIbFIo3hbyjOYCoo8b0rcbLOptpySGZ7RRAiBm2r4tzjNVeZaR6we+nEffA2UfgvL+Za1BHnBsznQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kT12302b; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kT12302b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqbh37Cbz3bn4
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfldQTa2Ee/WsoMvgwMH16QC+mxnDAXqpoZidQIj3pq9frAQpahcaliB6d/RXkowVuH4lmLt/qPv8s8tUi7KP87/cbNh50AZB0SoqF8XSQylhfo5qavLX1oJqc5Mp8gl6yuHgvf19oZfYu/7QhYjmCP8eLuFXwb+nL2FTxvOWMCPgZP/5vkWtTEsxGxzpQq+prjSxgQjU0TUOKv/hV5Y781zY7Ulz/z4mi5Bw2V/L9eZGwDi/7EMrA2RYpcg9zswcC5X/ntF6fChAcXtN1fTwXPzIfMYu4dGLxgOvsxu37TVpwdI4Z2VG8wVW/nb+IyAWAwIhPFaj7mbgimKu/Rksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mibit3rg75FY8cAhryOXH50OLJ8mlPg11tj0EUDmys=;
 b=gQdfOOURBD9V01QJJSFgjxtVYNk2umyRi/+r7dB5EKGTXA4p8Hw7Ss2vvQtQVaeZJSKOPqDH0CjA2qn/LXp0gFSeX5AfQBg2Wjzch1AOP4XBAD0Yz0HllEwnq344yPfhVaNmw1OGnnKRG/M5ZKAG26bWpFSTOpWaD2Ze4PTnbCrzLCh55baHIZwBnChHsEh4z5p78KtlW2VrbfL+ED466KBWvkYX065f7xmVp480Qe7/OIynalEBbNdi6tQ6UIIaSTnGre0iKYUuQhYaND1cvTXlMeNIwUFuT9JnJJez2pA23IxZvvPrv2a/RBcZo007Efuppo496QkRWrAcP17nRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mibit3rg75FY8cAhryOXH50OLJ8mlPg11tj0EUDmys=;
 b=kT12302brW8AqcrZJOjDpAIP0NGNvB5u6KDWZlavjLBXTLS08crUSHP4x6NFgqZXaOseAu/IjAEODe+2Ol0ZS9pvZMBGEzyHuTNYwdVnsbXb5zCmUKfq0pFJ1ic85i1/3mJnGc1Hjtv/EJUHbgOp8PfQDFwPb16nve4teBIj602wEFNl2Qiem8XJDLQsJcC5CiHVnk92hO6VHrDu0TR41Dm44iieHFI0lB4t1aWCaecIQiwIpg80UgIiRspyg3DzUkwNwMlyA2YbA8nrBe50b1A7RWTVgcy8s0ThOd/+8w5q2o+Unhp3nLgFQkDNjkmqDw2gDbja1Hd1YBDXxmNN1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 20:02:14 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:14 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 0/5] erofs-utils: implement the FULLDATA rebuild mode
Date: Mon,  2 Mar 2026 15:01:49 -0500
Message-ID: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-merge-fs-e6231a3a3a1c
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ba67ff-e3f7-4887-4e06-08de789698b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	RNvX0pf1zb4Fqq6KZiGDgjnBDUy8XnJF3uU26aOPSRsdM5YznjC0zje6crISljqnOeJccsDJ2yzV9jakCm2YKClf/uXISdSGYXHcw+QBvMWeU4zOiWe8J8Wu7pkamBKVdLtUHGng6prIz7xRKLaUTsZB+en9mHwZ+8KTHqRA5SgoXGnqSMJJfZk9vfblrQXXJ6ui3rHQSECHdDV0gSz6/X5WUtU9vSoGI6YWE+qg9YeFKLRq8YlcFI8yQuIasCIFPyGoDcKDgPA1neRGVXuQZtLVnemTH75eOfXchivlg5J6YZttJdeu71jblNpGO03HQ78quTkZk+ZYymN7d0AmcbFDYMKgThPms6xdurPyLHDFjkQv5zu9BnkFGT+fqaKhQ4STtzEsyxFCuQ8rd8Au/Y53HekQgfxhr8MEMYMbRxCEYKrFs2DGKvlIhgdJEBH9scNvaIpKUSv/EU55xuqE0OmFIkcivcZaWM136BgD9sMKg1HY5mrHZXuhbGbbxdmigekeQ963XzpNzAHu6mXjFrUsIZ1TkP9nc5G9HT/UNSgd7GH+utxDjD6snEM1h4OkwP1AGCAAOuLfCqmrdXi+szOb9ER0VsfMslkZwc1apB7KfZ84b5W8x/YadyhBpbjSElUBsj2iCdxtXntvuPDnT5fNweuuVIHZoBqfOj6sRUAq/XhaLmgp8ubBgwh+graqrWjiy46QE/0K3xz0CwlneVD6PRP1RMYEdTtEYCimiZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2xmM2ZIUDd6WDMzbFBCQVJDdkJlZUM5QVhEd2paYzh0L01LYW1sZFUyQzJS?=
 =?utf-8?B?eGRYUWtQcEZETWc2T1BVaHZUQnhwUmlsNHF4MmJ1WkFVU2tFSVVBUmpRSUJJ?=
 =?utf-8?B?SWxncWdYMWpVQUc3TjZnVDVPK1RSN2svazViYkNmK1h1NzVmMkVoVXZyckdn?=
 =?utf-8?B?NVN5VzVMc1BVek1Dd2wxRFJablRwd3NkN2Zncjl1RDJsQjdYS3YvTGJKTGYz?=
 =?utf-8?B?bmFRQWp5aUdvcTIvR05iS2sxcFFSTU9rM0pDOFovM0poaWVWZitqb2sxZkx5?=
 =?utf-8?B?Y2owNis1TTUvZnRlOWxFRU5ISkxTVEV1ZHBwaG1aSWRaY2hEWm83a0pWTWpT?=
 =?utf-8?B?MFlmc05HcTlOTFVvaEdVMk0xUHNNVGhpMmNtRTcweEhPd1FWM3RxcVdJamU0?=
 =?utf-8?B?L3JXV0R5Qzhmc0Q4eXo0UzV3Q3gxWXdkM3VBTjJUV1lqczZDUlViNU9tNU5R?=
 =?utf-8?B?U3cvS2E5a1d1Qk1NRWZoZlhnRll1d3dXSmdtOUFKNFdMdjE5OHdjd1ltd3B4?=
 =?utf-8?B?MHlHT2p1eG16WFQxN3NkakJmM3lZVUNIVEF4T2MwcDNUUVhoSmI2U29xSllm?=
 =?utf-8?B?QUZ6QW9pY1ovRkQzSlhVVFB2dGVXcjFmdDFGZUlZbE1HNkh0RXdzZWdGRHEv?=
 =?utf-8?B?YWFjcGRVNDlNRnRTMmYzYTlOa2xFOEQ5WkNkYzB1Q0pWVnpHYzdTYUJWZzln?=
 =?utf-8?B?M1lvczI5OTJPelJpcUVaMHJocm5IcUhsbUZBUC8ySUMvUjJmTysrZkw4YkxV?=
 =?utf-8?B?RzA3eG5NajZheER4aGltV2FJNjAxb2RQMTBhS1BQYmpwQi9PNTFrOXRVeWZW?=
 =?utf-8?B?ckFQMG1IMzQ0QjYyT2ZXdXBBK21mY3FDajJkT2YrbkpTbnRSYmpYOTcrMlRl?=
 =?utf-8?B?dzUyQWZvWk92R3dtMVFkL0pzOEhlayt1amxsS00wZlNmcW5MVWpTNk9McFRq?=
 =?utf-8?B?c1VzM05mb3dxajE2cFQ0ZlJOWHBZdk5BYWFlY1J5bkR2Tm1DUnBodGlZZzk3?=
 =?utf-8?B?VjdBRGNYa0lMSXpRM1RkVHlKN3VRZFM5YTlhb1pNR0hMVEZiQ3BTbkIwdUR0?=
 =?utf-8?B?M1NsQ1VhUzErMU9BamlPSmZyZ2VWSEh2dHZ4NGdGVjBjd1RwYXl4b2FuRmlG?=
 =?utf-8?B?bE5IM1liRGwrbmN6a1lidU9NTXFBRE5CMmFGazNpSGxhNHV2MkY0QXdsY2tO?=
 =?utf-8?B?Tjg5UHE4TTZYd3V1aUlXWFBreHRuN3FTN2lrRjJqdGpBNWc0YzRITDRidGtB?=
 =?utf-8?B?ZUtRbXZJYjRtMWJqODkxcCtsZW9IdE5QQURIcVExRUpudk9JQUpjMGtRK2pQ?=
 =?utf-8?B?c2tGUG05SGJoOWNaMGxTN0Q3YXBORFZ1Qm9LSFFLSVV6S3ZhNFJGUjJ2TXYv?=
 =?utf-8?B?RmZwejA4WWhvMFFYMFNDa1pmUVZ5S2tCdndVY0hnMFM2UXhUaGsvRFRQcXBl?=
 =?utf-8?B?cEpRZWNpYzJMZlNrcFE0NzVIempQLzZ2TzArUzdTbVVtVmhtendTdHM2dWpv?=
 =?utf-8?B?cWE2NTdWNnVXNzJDaFhrbDgvN1hIMFE3TTRjWHpHSkx5K29vOHVSaXJVcW9q?=
 =?utf-8?B?aVRsNWdxSjhRMnVuR0ZUWUpueG5EZnlGTEUxUGh5b1RjaktMcFlnOFM3M0xG?=
 =?utf-8?B?ZVByOWozMUF6OFBuQXlvVTVzY3AvQktnV21HMXdMWEJ0OUVpc3VZdnRTQk5Y?=
 =?utf-8?B?QnZNOEhmSWVFRXI5VDlLeTBYVXBKdVBxMGVoODBiSzQyRFpHNUQzb1JsWnFv?=
 =?utf-8?B?cG1FR3M0TERVRkh5ZS84R2lSK0Q5OU5MNTlBc0lEQmx5WHlPSTBrTXc2K0tj?=
 =?utf-8?B?WURxUGpYek5pMEFWQk9GK2MrdnVWcmpMeE11TDhvUy9YcUdEWDZ2RHk2V3Fi?=
 =?utf-8?B?SWtuUzZ2VHFpQ3FyZ05ya1dxVExKUXFmODJJNTUwaGNpNFFGRUVOd3VVQTQ5?=
 =?utf-8?B?K0JYNW91dUxpVlR3a1k2Y1NvbGkvZi9QUVhJejB4QVovNTI4UUlGWVdyVVBn?=
 =?utf-8?B?VFZBOE96d2R2TzNFbUU0REI0U2JBZVpGejYweDRlOEdncFBzYldYREs0ditS?=
 =?utf-8?B?KzUvYXorK0dWeVN0UEYzTlh2Y0dzM2RncC83Tm84d3UyRzA1K3ZBYkowdGhh?=
 =?utf-8?B?ZlRONFA2U0hTNWphdTg3NUQ3MFBWZ09GdllyNVBUZXBBRmlmNmZEdi92R1pB?=
 =?utf-8?B?QVB5a1hDMTdESkNZK2NMdmZ1QWNMUWNGVUZxWHg3eW5DNmorQ0dnMTRkSUpB?=
 =?utf-8?B?aGwrVHIrTllxKzVYSFlaQ1Nsc2xOU2NqMExtUVV6dkNkMDk3WXhOVmJDbFBK?=
 =?utf-8?B?am1sVTlkNHdHKzlvbi93WXZqSDhQUnloK0JuTmw3OG5qT01PNFArdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba67ff-e3f7-4887-4e06-08de789698b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:13.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGbbVuMxp6+1eehdGmeqZZzDAGtsFxibBlrM8M0hC0entk+oAFV3h18rlD4aW0+sUtPunegAtSASUr6TxRMBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B57E91DF12E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2467-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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

Currently, erofs-utils supports backing blobs for multi-image setups.
This implements the FULLDATA import which allows for the merging of
multiple source images into a single self-contained erofs image.

To optimize the rebuild process, erofs_copy_file_range() is used to
leverage the copy_file_range(2) if available. This bypasses userspace
buffering and enables kernel side data transfers.

Verification:
1. Created a source directory containing flat inodes, inline inodes,
   symlinks and absoltue symlinks. Verified data integrity by comparing
   checksums of files within the mounted image.
2. Built same image with default rebuild and rebuild with FULLDATA. Then
   ran F-i-f/tdiff comparing the two.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
Lucas Karpinski (5):
      erofs-utils: lib: pass uniaddr_offset to erofs_rebuild_load_tree
      erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
      erofs-utils: lib: preserve primarydevice_blocks if already larger
      erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
      erofs-utils: mkfs: enable experimental rebuild fulldata mode

 lib/cache.c            |   6 ++
 lib/importer.c         |   5 +-
 lib/liberofs_cache.h   |   1 +
 lib/liberofs_rebuild.h |   8 ++-
 lib/liberofs_uuid.h    |   1 +
 lib/rebuild.c          | 174 +++++++++++++++++++++++++++++++++++++++++++++++--
 lib/uuid_unparse.c     |  16 ++++-
 mkfs/main.c            |  30 +++++----
 8 files changed, 220 insertions(+), 21 deletions(-)
---

