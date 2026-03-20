Return-Path: <linux-erofs+bounces-2887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FzfEW5ovWnL9gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 16:31:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CC2DCB2D
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 16:31:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcmkx2F4Tz2yYy;
	Sat, 21 Mar 2026 02:31:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774020713;
	cv=pass; b=mXaUT86sj1LbOYOA7gMAHJbBDMgsl15HPjaFIHCoe98non8EWtsEE1uQUCqAa4YeMH0w15hUa9wVjKsVT9C6IKnNY3omqFt94wil3ny7G73OxgqCIP1kxWnvTPT+2N3Ikpl9sZ2pii/YVlybOfznv0muvfNY4fs4RuskwG+F1XC00wNPfBW056XOCo1FvGOpsuY98LMU7z50uZq1cHGAX1Kcy0e72Z42cM8e2wjSqmx/gDfkRd+gZX4YSQJXRZfpE3lxrgkyfoecYllqeOM/KDbZD0fDcldiWC4OLJ25xOavyhgsLEnWxORZglfEBj4kwyYoA26vKmBY7arluSSx1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774020713; c=relaxed/relaxed;
	bh=QjOAswVMkO+U4L9d/CKhZOBTZJ1+4L3GyMJsP1YbvRw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joqEikzER3UG6oAOrw3mpnpvuhpu6KR7eoK9sowWJoKDHEOIUbIRor+SkFANmD3CUg8dQoicw5ZvWfmd0OCTyylMFY81bC1m1c9dBeLeO4YobtbQ9HvY8SRIFGc2ajxXFIjItEJEulyT8RiMyu70RXsal0iKuUOj/gvscEL+jmiFldWnb09kmUFQwCD4Kt/4Z2Re50LKr4rDGEk0H0Th0cmQxsTOvmKo9mdFduEB32oMzmqTxZhOFVAxbRijqLE32T+cRI5KMaFgSxy6BHqzXodP7lAT4E30aDaN7PIoDsrilqwV3Dr3TsqXFEKwn31ywv6/JWLFhaEQw169zWRKhA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UYlEK/N8; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UYlEK/N8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcmkv1trDz2yY1
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 02:31:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv68F4uiJb7GByH+DZeXDewI2p24dLivpja0Z1r2MZpn5v6eW906PsACUhgHYQ4c9pvW88u0gNwqNv9joC6WUGbL2b8HTjugQlkgvf1ahrwAoE6MKGmlptXAPXWImDPFjbxhSqNW3AxWNwSUBPZNfNAQX/30npRa4jS3kXmYfzE/Bs8VA/de4nmevd2mXQ3bXnpzWFu4SyU9OG9sl0sVbPeKRHsEIOQcrHZaHl5KI2/+QTgAawhezFsxXW9aoCMqOxPSMi+koYgN69SbU7noX6bqgpkXQUWaljum5XdFp4SLT1k+HEZEEl6D30/D3PRKNKcmGhYgRfE84WF4wUkX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjOAswVMkO+U4L9d/CKhZOBTZJ1+4L3GyMJsP1YbvRw=;
 b=qBb9yidkXan9QVvSLJG4h42TT7aHBnObf5HEuk+TDLneoGWcEPpPQWVFF/iK/vR8q9nZT0bKQDF14pEB6w622bGN/Hz5zvFarnJSuQCPSI1L3yTNsIwpb1lhtOAIvHv2ixKR7Se+2SZDZXNYnf+MikbdE6sPaHsalj1WdSx5zjTR5ZCaaD+yRH6qi8uRIx7BQSeyEbhsHcY0mqCmgfckuQqBrVkjKB7U4DRj9uthWQb1bUYD4w11ZDwxlWjYnuTuYx//C9QsZVbMNw50HHi+paVeqFxb/EUl4/X+XUyZpVi465nVGFNEV5gg8Lna1a4yqJDzvrXPpGbf8toxVMbWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjOAswVMkO+U4L9d/CKhZOBTZJ1+4L3GyMJsP1YbvRw=;
 b=UYlEK/N8GBuHBRttPe84g0On2XJLl8sJl0qQuITdgjzenjKw9wejyePy5YEjkmBrTXrwjzxJPOPsZe+qHpTObxXVKcF6fKa+GkAMX1bxAnbbY6BXRVGPjIWy25zKujg6f/9TneCMmuKaNClkp0VW9IZF9wypkOXA+8ZNM6ZPAbdMXzb45d0Aa1QT6OOgpO/BiK9GgDewtrzm8Ah0iZdwfW9hz46N2VQr47yjmBC86oopCMJ3Sn/yOjSw38kSNr7P2yY3I4zCWD9msB0Aj9U++acp6yaxf+nQn35XF491G/XWyANPUzSkA37I2wQEqk38vTG6rhFKd3y9Pbzv6m9dPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:31:21 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 15:31:21 +0000
Message-ID: <0ad48452-f67e-402d-9a7b-073a645d530b@nvidia.com>
Date: Fri, 20 Mar 2026 11:31:18 -0400
User-Agent: Mozilla Thunderbird
From: Lucas Karpinski <lkarpinski@nvidia.com>
Subject: Re: [PATCH] erofs-utils: lib: fix infinite loop on EOF in
 erofs_io_xcopy
To: Ajay Rajera <newajay.11r@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260320002052.238-1-newajay.11r@gmail.com>
Content-Language: en-CA
In-Reply-To: <20260320002052.238-1-newajay.11r@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: b31e5b52-39d0-4236-896e-08de8695bcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SSvmPK/PipjPfRH2ST3RsTCg9v9NS8HPz8Z9paeQnPaXcH6b6HyG7//n5SJDnFHq8pManMQJTpNQ/i8MMCOfWmQyyvWj3zjusjiQGsRdCWGwEJaf28LAcqcJk7lAQ8oKciNpzk5Xj0DQhCja6C1XzH4q3p3A6ItwcPr883X3dXF9wRSmRgZmYh4gChXHSxta6N9M/NpqEen0AeW2xbxEwBLIR0exk/Uxf6e55qw57nQAEgfavOsfWGiZvjsL6q8zFDCseqtCmLZOqLFmwxuQR7hO/YqCyi/ZBe983MQJgFqeFdmf+dym6T6znftQstyBi6hqpqU2Psqlrzr5h3U9uipERYAEparHGuWM3IgPz8VZkgC8xUobd3Yy7KkWvmclKO8Xtwf1qRXRmd6zi2MnQNIQCnsaCybhsaih5qPBNFZBzhEa4+68L7ZZ0aGuG++BnW9RhybBOgO8xkILM9XlStePNfS3WpfxA78FajFCaC2CIr+C78ZRLl8Tb8hKQPYxz+8xbFIqtQOkRgVF9a0O+lVL8uQrUFfOWWmjOyLLIC0i37k0TcVFV0JawAwYCIsUEFLnLr/bkNJQ0Fi5+drgxyYFT9GsZDPVhDb8lT9DfaOdmP4Tplr7RhIOxyxTMBjwr56VWmocp5EH4MnicNL/M6pfMZL8JBnChVM15vKTkcTXaxQ80swRwCLGrxlirS7xm1MoxuveKKwmEVGvRR1p0avHKNO6EuQJBzM0UYNvGzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC82c0ovQ3Z2OHZhMnhlcGp0b1hPVjVsWUwwSWl4WGNoVjRXb3YyN1VDUTFV?=
 =?utf-8?B?MWRiakhsekl2UEw0c0VLd2hQTC8vVzBSV2QydFRhS3RQbmlCWnRUWkR5MGJt?=
 =?utf-8?B?UUxVS0V6cW02OU1CTEFhQUozT0N3U2xxajBFMWEzcGVna1Z0SlpmQ3VTMk9j?=
 =?utf-8?B?eTh1ZnVlUXU3ZnUwbVVpeC9zN1UwM3psWHlIemFyWmdBTEs3Q2VKWDU2QXFV?=
 =?utf-8?B?c202YXFQKzN6bXRoZ1JHOGIrS21VQWtVQTJ0ZStma2hHQ29jeWQwL3pLR0tR?=
 =?utf-8?B?WUMvSnVIb2FFaFl0V1gwTzYxK2ZrRTJhQU1MQmxCNWFGbjFCclNzR3ZhclNY?=
 =?utf-8?B?UU9PeHpsMHY4a2plRi83MG53SitIc0pRaXpRT2g3VFZ1QjRVVHZJWHY3M24r?=
 =?utf-8?B?cjRNMDFJd251b0VsVmxRSzlwTGNlQksvbUxubXRSczlDQ3FDNGFiNlREK0Ra?=
 =?utf-8?B?UzV5a01UblNPMi9pc25UNVdFSmV3bEd2THZrT2E5dkdwc05aWldlZUtEZTZR?=
 =?utf-8?B?SmxsaExLNzdFeS8yLzZSaWJ1czFZTDR1SVlncGxzV28rSEZsM2VpZU9wTzEz?=
 =?utf-8?B?MW9zN29rT0laRyt2V2ExdU5MOXlPeDNOcXJwSEpRTFY1WFM1Q3doZzhLbnJh?=
 =?utf-8?B?dGZhQTRyUml4VnZ2V2dMQUp5Ly9jSlpZc0VGbTA1cjlVZU5EN0c4cUVwS09B?=
 =?utf-8?B?YW9zVmJxaG4rUjBRT2RQemdqS3V2ZWZXZDVXZC9VQXR4Zm9PWEFETGhUeW0w?=
 =?utf-8?B?N2JXRGtVK0piN2wveTZheS9iRXRtM3h4S2FtMWRnV3o5aS9mbTFZNWIrTkpj?=
 =?utf-8?B?OGw4dWZnN1laMW5lbEN2SldYVXM1TXhHWGdhaExjSjhDcVpZSDlVeGF6U3J2?=
 =?utf-8?B?L1ZMNDJHZk1rdllFbTFDWmV2aWx5VnpDczZLdC9BTG9GNWova0VzZHp6cFhn?=
 =?utf-8?B?SU9wUFNzb2xGSEdQT1FUb0EzaU1ZcnI2SWV3cUREcC9idElNdW5ENy9SUTR3?=
 =?utf-8?B?a0JKQm9yTkZEVThuMVhTMk9LU0pUNFEvbEoydVE5ZDg1dE94bzJpcEd2RHlH?=
 =?utf-8?B?bS9WU0RUdmNadVdUajA3TnliK2diNFY2QVZXcjMrQmhibWNLR21ES1R3RHRO?=
 =?utf-8?B?a1pZck11TzdVS1BzQTVjZmJLenNmS0NYQ1BteitRUjB3Y1FPQ2JMcmdoSkdt?=
 =?utf-8?B?cmY1WUhka05CQlA5TGM5U0NQTWhNbUdDN3NxeTNjY01WTzZHZ3hJeHl0bjZP?=
 =?utf-8?B?c0JnYytnajZ1LzhWZElpNUZuOSszUDZuL1NQS3VtWUZCUFBHWUVnUjZjVDlm?=
 =?utf-8?B?VmpJZzBsWlFjK3dGSUJLS3NvR1RIKzVXT2EzM2xVVUNyOTZPdWxYbk1mU2Zr?=
 =?utf-8?B?M3dQODNxN0dNbUF1V2ZpRWVzUXFQOHFaeHJkdTFsOVJUNFVNcTA5Y1cwZkZ1?=
 =?utf-8?B?NklQbHByTzBMRWNMK1dmcVRqZVJiNHUrVzZFeXU2bTlTMTVma25CSGdpYTdk?=
 =?utf-8?B?WHV6T2NIamEwNzA2MVN3VXZsM3VQbFdZZDkwdGlSUjBzSm53VVdyMjN5T2c0?=
 =?utf-8?B?V0VQVzUwcnhZdHlZaklZWmpVN3Q2d0pWNjZDSEQzRUF4ZUhXS21HZEZpUHJM?=
 =?utf-8?B?azVvWjR2UHlFaDFjcDNUcERHTFRlb3JaUVFBT3k3UDkzZ0RiSkMwU3JTMjJx?=
 =?utf-8?B?SytWa0ZtMnlnUnNNSWkxbStveHVWOVRQN3dwYmNhYnduNWZ1WXVDamdzcXJO?=
 =?utf-8?B?Z1VENHJ5cVpWaUZXQWlhTTA4cTQ5endnMi93ZDdJQVBNYzRGWCs5NEpaZnlo?=
 =?utf-8?B?bWV1NzZPdDZMY245UC9YWk5XZ255SUdSd01QeGw1eDcvQisxVzlpb0o0WkJI?=
 =?utf-8?B?eGJZS01leWE2WDhWRHdsQmpHMGhERisxS3lSbFVpYUFXWXlGeHJiWGEyVWM1?=
 =?utf-8?B?RjJCRjJCRnFlWXVDNHdHRGVpYmxKOTI1eHhiYXpWN3ZPeno3cUJoQXBGVHQx?=
 =?utf-8?B?ZG4weWJINURqbGx6NVNVNHlyanBUb3JKUnZJMGJ1bm5nZS84WDJ0ZUlSQlJ6?=
 =?utf-8?B?b2NzOER6QkRqUm1UcjVxeTdXZTJMSGFMNkYrekJ1LzUrREtpdXl6UHVlY1J5?=
 =?utf-8?B?SUQ4NDRUZjAzMiszSTZBZkRHbEV5d3JUL1ExanFCMlNvWjVzT3pUbWxGcE9D?=
 =?utf-8?B?M3dManBhZmw5TW54eTJtWFE0anFxbTUrcERKVmJQTmdlNnVsSHowVDhqTHM3?=
 =?utf-8?B?aldhblI1WERuS09ySEtkQXlXTEtLZ3pyRXlBOFhCVE0yZjFqOVFFb2Z3b1hw?=
 =?utf-8?B?emNnOUtRL2IrRm4wZjI3TzloVDhpRGp0NFU5ckkyRWJKNHhIdUp0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31e5b52-39d0-4236-896e-08de8695bcba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:31:21.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/kcuekeu6eBy4syZaPSGC9Vqdi85J4McRI1eVtvMn4DVGvomzGrTucE//MVoMJcvVlBVlmWlsdjraLFSkX6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2887-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A16CC2DCB2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 8:20 p.m., Ajay Rajera wrote:
> erofs_io_xcopy() has a fallback do-while loop for when the
> kernel fast-paths (copy_file_range/sendfile) do not handle all
> the data.  The loop does:
> 
>     ret = erofs_io_read(vin, buf, ret);
>     if (ret < 0)
>         return ret;
>     if (ret > 0) { ... pos += ret; }
>     len -= ret;
>   } while (len);
> 
> When erofs_io_read() returns 0 (EOF -- source exhausted before
> all bytes were copied), only the ret < 0 and ret > 0 branches
> were handled.  Since ret == 0, `len -= ret` is a no-op and
> `while (len)` stays true, causing the loop to spin forever at
> 100% CPU with no error and no progress.
> 
> This can be triggered when building an EROFS image from an input
> file that is shorter than expected -- e.g. a truncated source
> file, a pipe/FIFO that closes early, or a file being modified
> concurrently during mkfs.
> 
> Fix it by treating a zero return as an error (-ENODATA) so the
> caller fails cleanly instead of hanging indefinitely.
> 
> Also fix the long-standing 'pading' -> 'padding' typo in the
> short-read diagnostic message of erofs_dev_read().
> 
> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> ---
>  lib/io.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/io.c b/lib/io.c
> index 0c5eb2c..583f52d 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -430,7 +430,7 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
>  	if (read < 0)
>  		return read;
>  	if (read < len) {
> -		erofs_info("reach EOF of device @ %llu, pading with zeroes",
> +		erofs_info("reach EOF of device @ %llu, padding with zeroes",
>  			   offset | 0ULL);
>  		memset(buf + read, 0, len - read);
>  	}
> @@ -665,14 +665,15 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
>  		int ret = min_t(unsigned int, len, sizeof(buf));
>  
>  		ret = erofs_io_read(vin, buf, ret);
> -		if (ret < 0)
> +		if (ret <= 0) {
> +			if (!ret)
> +				return -ENODATA;
>  			return ret;
> -		if (ret > 0) {
> -			ret = erofs_io_pwrite(vout, buf, pos, ret);

Change looks good to me, just minor nits.

Don't need the nested if and I think EIO would be better choice here
based on your description. We would expect to see 0 from erofs_io_read
when there is an issue with our input file, mostly caused by IO issues.

if (ret < 0)
	return ret;
else if (!ret)
	return -EIO;

ret = erofs_io_pwrite(vout, buf, pos, ret);

Regards,
Lucas Karpinski





