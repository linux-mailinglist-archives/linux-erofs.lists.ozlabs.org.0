Return-Path: <linux-erofs+bounces-3350-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KmyEzqu52lZ/QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3350-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 19:04:58 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6643DB47
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 19:04:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0THV2nlWz30VM;
	Wed, 22 Apr 2026 03:04:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776791094;
	cv=pass; b=W14sGDIvLShRzaMAcHnCOaX1xO0nq/VSiCUCD0UnFAKuJkiOzSFmBaPQjX0ypRSp4LLIdStHO8S93tAWX0F7mMaTYzFRikSEB21gReV+8CVB8l+DkPTsIbD+gjMBIYT78Hfc6ydShkNfOEhQbwxnxHa68BH9fRuvu+I8YlABvKjY/oJciNWmxB03yMGselNreWkhga45Y/Oq0ysiuDkuynCI3Ch8f0z2fE9S3gpHfCz3hUNzSaieWWcxUS7EAxWaS3E7vOnPv+umz4Hbf/QGhuJgIG53ktK5KjR3VHappaoYq3DSwHcVrTyJYaTtjIoHlSVqa66f9o6AL41wUcdKYw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776791094; c=relaxed/relaxed;
	bh=wf3Luf2WioQTAsTWMsr2Gqmrr3uAtB6eGv9hgAmFxPc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKgwAyHP9Ttacwr1im3RSxHU6XCF4pIoB2aSZFZXqBSLfuMngIXOe4oFnrCz2duj13AHU7JyiLGOEJ4KJ1Jef7/KW99mTdMGUDKjh+YvVwWPQ0P1BfYGlvDE8YyAyyl68f2CTgqtDWaTEbmeX25nbYv8/ylILME6utk7IDYWeKVDyM7HSxg4pLwR1ngYYXgMBz7yu/xHG00T7mgwOM9lDVOXdCpx1DXBymymO/Dgh1qaKuMVbDmpgsnVAc3NA1Zi551AeZrHSOGCw+3NmYAFqFdZp7x2b6Xz8SHzY3cnGHq1ZeSWX66qDtF1q97huyG8VQZU9WckiozXIf9uAWxBWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jowZ5QFy; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jowZ5QFy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0THR2ynyz30VL
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Apr 2026 03:04:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVK50hjVyNXH9llj4OjxNaSZni+Xk5dy+6x48G3hSXOlqW25xcWyEcNpLXivlaLLfxudZfsaiRG+q8GOgU1osXUQUQgVpAO1on2ApJVffAuiAuR/oy7Z0FSgRRLxcm/n7Or2fITFcYnpqdtCMQ4GDJ1myM/4TxxVYzRjpV+nvTFRwO96klqYgTZxiJxFf1+3X/5yvkkZ1RxXz9Zhip/P5foQ5LhrryeSzltFdf57ZHQogCgx96hLaPrNWNhT1Sc+43MBp8+58jA/NLza2+UUJ4yFWNZ8rFVuRlVq6qoytQwerQS4pi6vIvtbY19wfQFIlYE74s9f0zn62F7uYRQ2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf3Luf2WioQTAsTWMsr2Gqmrr3uAtB6eGv9hgAmFxPc=;
 b=eyMzVpKwyVs/Yv3c9/QBlIwp4eni3M6rogoH+x2k9aF+nOR/j7MbdALfKPFQlXqcWq/UhSpGyaAQRGOS33I/tOuLLQoBRoc3LXoFEZFXe2PG4feb8eK3++WIzvPXGs8CP8XW7ZOpRDqaLNlBGKyCUTj3vPc0vLssHFEE/BIifEnNpgxW1aSseKxjUfh//6UW9lcDIfDsUnUWFQpFZwcZdQc6o0pcj6bjUW8CLSgt4sTv5BbXEePRC7LzcNeqqhGj3MjbE626ZUeROQKdSbFSdaCHsCxxtV0O0NMHPOHCInTS4g+sekfN67hWIVul8QW48VeI/iyFmVuHGmgTZjvkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf3Luf2WioQTAsTWMsr2Gqmrr3uAtB6eGv9hgAmFxPc=;
 b=jowZ5QFyA7lW+FSmYDPY33RucxUisxp9mN66/66y4WFb0QSj9QN4UPZ1/4NhD87Al1ElCT3rGEJL6SN7l91GVmZootoLV5pWBL576AYVUQS85rAodd9kAqZx93es+MquYaQPa9+vjOnOCEqNkhgY3XXBSO8vbpuLB1oRboh5pv+RRvVGSLwf2v+F/Xc/5POU4wFgD0mt0HhT/cQZyAU2rg+K6SIx4p2gLLLt1iQ1PkmRQ6ya7qZ8J4UmCYSL6X3rL9X8fNRTZMROQborZCq0vAUkghss8BAY5r7zb6JJumosghOUQWc+ZLMuGtjftaFOnakxrTot9gEo7nsB4YvxuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:04:24 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 17:04:23 +0000
Message-ID: <1dca8e53-3a58-41e1-8f0e-407fefd9aa98@nvidia.com>
Date: Tue, 21 Apr 2026 13:04:21 -0400
User-Agent: Mozilla Thunderbird
From: Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 experimental-tests] erofs-utils: tests: add test for
 rebuild fulldata
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260417-b4-fulldata-test-v1-1-234654bdb930@nvidia.com>
Content-Language: en-CA
In-Reply-To: <20260417-b4-fulldata-test-v1-1-234654bdb930@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:806:f3::8) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a05848-7609-465f-8d5c-08de9fc8094e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YX/SOhC9fm7JOO4OVB5Rkz+13qihkPy5sFWLMxNjQXWZtAAVBzF+x/PBXISg8k9NMqY1W1RBHaW+CiAdQRRhWPNsva4u+TbdrKx3VgsB4S+CC6YOgF557mBBamPIOaUgOmYOAW/ObRMcjQ/W7g3IcHXOUEznCGV585iYO88YjuOZbJuJAKOp8WggZP3EnZM7wUHlIlVewoqSV8fbnl631KHPX4kzqo+WbOZFZfjOxS6xvD3UNyMT7DjDgs1uydtJgG0Vb517Rd2IySl8H56I8gyiV4ZScyI1tob8zHp/gX8Fj0uqWdOGkzcPZVA9Tnuwstu3eK3u8LtpCbfBVmUZr2WzhtxUPyUvNZIgMVcyitauNCKKr0D1ECGoQTMUO4U42ybFbP1CPqKfDe9gU/FieJa3OxkWQvXRqgQIZGcNx83MRV865WvWjuvGW3EqKT4bfkFgqhYRtF6JLk4YBckXmUyM8VD3CrvC/C3ptpLA5GWrCOSB9Cu4P4LqHQ6XV129VXJQkbdRp4udpIdV06banGheGsDvrcbye8PoPXTkVQJ8SzDX59zGy/nx8bMtzgEHu4p3MjdCA81Ts2cQyxcAa6iqLCKJSoR/y2dMxCpSNvBAcT4f/VJwxpgc/rPr3Ua3D91VHNHTLIe0KbkN4bnVHEAWIKxYchGI0M6Ag/TAS8DPpbVNGqDY0Ra+8YzkmcE3h8IfgJ7uUhk2kptl5bzXe8PayAiZKzsM7hf1e0Sa4QQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am5OQjRlUEdNTWw5L3ZjQk95MHhsSTRrYmRhVVh3TG4ySGxVSFBhZWhuMHVj?=
 =?utf-8?B?cTdrWmJ3Z3FnUElwTERBL2dQYjhrblU1azFJVGlPbHVUYVQya0hZODVCOC8x?=
 =?utf-8?B?SUtOTm85UlNLcTNQSkhsanJlY2diWXh0MGw2WklodnpWSEZUWVRSTUJ4Tlh0?=
 =?utf-8?B?RzIzeVkvTmFHZGhlVjlteXkzVGRraFdmT3dsa2N2TGNPc0RxTlhNQ1JEMlRp?=
 =?utf-8?B?UjFCRmVZdjZzWlhtblF4WHJpejJrTUV0aUdNUFRtWWllSkowelNDR015dHdj?=
 =?utf-8?B?L0FNZGxjblM3SmxrTy8rbGFUUDQxeXhibkVaNlg0WVpCcXV3Y1BJVUpqOXIy?=
 =?utf-8?B?dkFYakRQQjJsTDlkbUpObWw0T0g4RlArd0ZyajlwYTFBRWpScHVHdDRwS3px?=
 =?utf-8?B?RGVTRlBmSXFpd2x2bGdUdEpOVlJ6bWwzVitZK2JXcEMwbFpOVzlDSGZIbFFn?=
 =?utf-8?B?TWUzWXVvZ2lUSFR3VEhBZjNybDA2T0xXUHIyZnh0alpGOUV3UnRBTlQ0a1ow?=
 =?utf-8?B?NXh5cGVVZXBISFhwODRFVmR4Q2Nncm1hMEc3Z01qdk4zL1k3ZWF2Rnl5RDhE?=
 =?utf-8?B?NFpLODlVcGxYUnVNU0FkMmQyNDZXWnZvZkJGZXZ1N3hpdWlSVDc2R0pJbjF0?=
 =?utf-8?B?dEJ1MlpyUllSNUZ6Z1FnZzFib2U1T09BYUtoNnkzWnRnSyswejlLOU9QbWtn?=
 =?utf-8?B?RG1BMEpWaCt4ZTV6V1Z3YlgyblV6Nzc1ZXN6WDR0ZUpOUmwrYUFBcGJ5b2Ir?=
 =?utf-8?B?UlEzMXk0ZlN5Ym5PSmxSTFliWHdXcFFTRXBtd3p4KzFOSVh1UDNIZ3hBN0lB?=
 =?utf-8?B?eUh4dlBXbFBoMHBPdTZOb2t4VEpYZ0JYWTdQSWVyNFB6OHB5OExiVVFROEhG?=
 =?utf-8?B?eXh0bytyVVFqL1FhZElkaDlUV0E0V0JHMXExdWoyMGg5dzlkV1N5blRvWWZT?=
 =?utf-8?B?a0tieE5WTXhqOWlVMk5hSjRXSjJsMEJzejBTdG5NT2FKTlc2S2drM3draGNH?=
 =?utf-8?B?YjRyWkMxYWRGd1hZSGxIZjMyUkFiTEZLQ2ZlZkRzWnpVN2d2NW9kWFhhTHZH?=
 =?utf-8?B?Z2R4L3k1a0tOVHJNZnBmL296ZXVpTEdUM3hqKzg2Y1BzQ2xmMFBTY05aSzZJ?=
 =?utf-8?B?MzRaRU5IQU1Ra0dWenovL1FvSGdNNjF2d0piamNsSWt2NnRFNG1xRDBVbzZH?=
 =?utf-8?B?WGlrZFZWVVEwMnlEUHFzTERmZFJMMUJMYW1XNEx4RU05SXZzSHRLaTk5SnBP?=
 =?utf-8?B?VTdpN0NwSUluWnk0dksra0hTRUV3WW02ZDZVdk9vNFl2bk1iRXpzTU5mZ3JO?=
 =?utf-8?B?OHJkZzd6WTFpTlJtN0pTSmFUazhsL0RSU1MrU0tWbTloUnozTHErcmlCTXlS?=
 =?utf-8?B?NzlEZ0psN3dncXJtTWlZVDZXVE1hWm1jZWRFM3hsa25oUnl6SUlnd2NGQlUz?=
 =?utf-8?B?VHlRRHNGbmpZNmVUeXppZTlEcXRPQkZMS0FKczhxN1hrWnBUSi9ZcDlJQlFP?=
 =?utf-8?B?ekRPMzRNZDF4OWwwOUhaZzJrb3NRT0FaNkdPaDZoOTJwb0d1UkE3R05UYkJu?=
 =?utf-8?B?MUNqdFltYm9VVlVxZys1SFllYVBjSnhYZjJVdnRNNG1lY1d4VG9vQWVuVVJr?=
 =?utf-8?B?Wmo2TFFReTcrY1ZNU3dPSlFTK0djSmRGbTN4ckdVd1ZGVHljMHZvQlFZVkhQ?=
 =?utf-8?B?WGVWeC8zVkNHRFdFZlpqakc2anRvdnZFV0NNZU9XOUx6RSsvS3hER0VoVDRS?=
 =?utf-8?B?NnpIYmFqS3lOcE12YjhZQUlXb2Z3Z0hDa09tNkd6Vnh1Wm90RFdhYW1iVjJI?=
 =?utf-8?B?OGhNVGs1azVhaVh0UGprcXZ1RXdoUTZzRHRweEtIUlZzVGhremYvZUZLbGZm?=
 =?utf-8?B?ei8wMjZtYlhOVmVoVHdSczRwZkpSSzU5aE04YU1iTURwbWpiQzlIZ1hRenIx?=
 =?utf-8?B?RnJ6alFvVGE4V2x5d2NyM3NhR1lUL3Q0RVZwYk1XMzZETnBwMVU1Tm4ycEZZ?=
 =?utf-8?B?STRNeVVYQzNqbTlkaVl4NENtRlNtRHltYXppblBCbTZDcEJuakNmRWZGc2Fv?=
 =?utf-8?B?bHJFdEgzNXJxVVp0ajdUU1kvMXlGTTduM3N6cldvakhoL05MTStyc0trZUdh?=
 =?utf-8?B?SUxkU0p4LzJlS0dyZ0EvMlBWSkNRT2gxL28xazQ5VGlNUmpLNXdHS21iRzNx?=
 =?utf-8?B?UCtwaDNkTC9ORmYzcnkxT0JQZmw4WWplL2ZyazkvUzh4bWkrME5yZXVpY0hr?=
 =?utf-8?B?YkE3dnNmQ1ljaHJTc3NzYUowQk03bVlLZDQvUDI3eGt0elRJWU93OHllQ3FQ?=
 =?utf-8?B?a0NPTEpkRDY4UTNlaTBVN1RjVTRqQmkwR0ZISzZIVS9JM1djeU5zdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a05848-7609-465f-8d5c-08de9fc8094e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:04:23.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2TsWfgmuUUyXYhl8wXWfh1AfBdlr4E+EFUMfnJ6XX1skASTJxOSkzCWnZH/SWD7IQyZoq+MHQF92HTD3jJhJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3350-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A7A6643DB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for building a self-contained image out of two other
erofs images. Validate that image against a live overlayfs mount.

1. Build a base erofs image with deterministic fixtures.
2. Produce two overlayfs upperdirs; generating whitouts and opaque markers.
3. Build an erofs image per layer, then merge all three.
4. Delete the source layers to validate the merged image is self-contained.
5. Mount the merged image and a read-only stacked overlayfs and assert both
have identical checksums.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 tests/Makefile.am   |   3 +
 tests/erofs/030     | 179 ++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/030.out |   2 +
 3 files changed, 184 insertions(+)
 create mode 100755 tests/erofs/030
 create mode 100644 tests/erofs/030.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index d8ac0678..125aa8f6 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -126,6 +126,9 @@ TESTS += erofs/028
 # 029 - test FUSE daemon and kernel error handling on corrupted inodes
 TESTS += erofs/029

+# 030 - verify multi-source fulldata rebuild
+TESTS += erofs/030
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999

diff --git a/tests/erofs/030 b/tests/erofs/030
new file mode 100755
index 00000000..afbb69dd
--- /dev/null
+++ b/tests/erofs/030
@@ -0,0 +1,179 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# verify `mkfs.erofs --clean=data` merges a base image and two
+# overlayfs-derived layers into an image matching a live overlayfs view
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	for m in "$ref_mnt" "$ovl2_mnt" "$ovl1_mnt"; do
+		[ -n "$m" ] || continue
+		$UMOUNT_PROG "$m" 2>/dev/null || $UMOUNT_PROG -l "$m" 2>/dev/null
+	done
+	rm -rf $tmp.*
+}
+
+# _mount_overlay_rw <lowers> <upper> <work> <mnt>
+_mount_overlay_rw()
+{
+	$MOUNT_PROG -t overlay overlay \
+		-o lowerdir="$1",upperdir="$2",workdir="$3" "$4" \
+		>>$seqres.full 2>&1 || _fail "failed to mount overlay at $4"
+}
+
+# overlay teardown can race with kernel dentry release; fall back to lazy
+_overlay_unmount()
+{
+	sync
+	$UMOUNT_PROG "$1" >>$seqres.full 2>&1 && return
+	$UMOUNT_PROG -l "$1" >>$seqres.full 2>&1 ||
+		_fail "failed to unmount overlay at $1"
+}
+
+# kernel overlay can uses chrdev(0,0) or trusted.overlay.whiteout=y, but
+# mkfs.erofs only understands the chrdev form, so promote
+_normalize_overlay_whiteouts()
+{
+	local p
+
+	for p in `find "$1" -type f`; do
+		getfattr -n trusted.overlay.whiteout "$p" >/dev/null 2>&1 || continue
+		rm -f "$p" && mknod "$p" c 0 0 >>$seqres.full 2>&1 ||
+			_fail "failed to convert whiteout $p"
+	done
+}
+
+# drop overlay bookkeeping xattrs (origin/impure/uuid/...) that are
+# invisible through a live overlay; keep opaque, --ovlfs-strip=1 handles it
+_strip_overlay_bookkeeping_xattrs()
+{
+	local name p
+
+	for p in `find "$1" -mindepth 1`; do
+		getfattr -d -m 'trusted\.overlay\.' --absolute-names "$p" \
+			2>/dev/null |
+		awk -F= '/^trusted\.overlay\./ {print $1}' |
+		while read name; do
+			[ "$name" = "trusted.overlay.opaque" ] && continue
+			setfattr -x "$name" "$p" >>$seqres.full 2>&1 ||
+				_fail "failed to strip $name from $p"
+		done
+	done
+}
+
+# normalize a kernel-produced upperdir and build an EROFS image from it
+_build_layer_image()
+{
+	local upper="$1" img="$2"
+
+	_normalize_overlay_whiteouts "$upper"
+	_strip_overlay_bookkeeping_xattrs "$upper"
+	$MKFS_EROFS_PROG "$img" "$upper" >>$seqres.full 2>&1 ||
+		_fail "failed to build layer image $img"
+}
+
+_require_erofs
+_require_overlayfs
+_require_fssum
+_require_xattr
+
+rm -f $seqres.full
+echo "QA output created by $seq"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+basedir="$tmp/$seq.base"
+baseimg="$tmp/$seq.base.erofs"
+img1="$tmp/$seq.layer1.erofs"
+img2="$tmp/$seq.layer2.erofs"
+upper1="$tmp/$seq.upper1"; work1="$tmp/$seq.work1"
+upper2="$tmp/$seq.upper2"; work2="$tmp/$seq.work2"
+ovl1_mnt="$tmp/$seq.ovl1.mnt"
+ovl2_mnt="$tmp/$seq.ovl2.mnt"
+ref_mnt="$tmp/$seq.ref.mnt"
+
+mkdir -p "$basedir" "$upper1" "$work1" "$upper2" "$work2" \
+	"$ovl1_mnt" "$ovl2_mnt" "$ref_mnt"
+
+# collect files pending for verification
+dirs=`find ../ -maxdepth 1 -type d -exec printf {}: \;`
+IFS=':'
+for d in $dirs; do
+	[ "$d" = '../' ] && continue
+	[ -z "${d##\.\./tests*}" ] && continue
+	[ -z "${d##\.\./\.*}" ] && continue
+	cp -R "$d" "$basedir"
+done
+unset IFS
+
+# deterministic fixtures for the overlay layers to manipulate
+mkdir -p "$basedir/app/opaque_dir/subdir" "$basedir/app/delete_dir" \
+	"$basedir/app/keep_dir"
+echo "base content" > "$basedir/app/keep_dir/change.txt"
+echo "base whiteout target" > "$basedir/app/keep_dir/remove_l1.txt"
+echo "base layer2 target" > "$basedir/app/keep_dir/remove_l2.txt"
+echo "from base" > "$basedir/app/opaque_dir/subdir/original.txt"
+echo "to be removed" > "$basedir/app/delete_dir/original.txt"
+
+$MKFS_EROFS_PROG "$baseimg" "$basedir" >>$seqres.full 2>&1 ||
+	_fail "failed to create base image"
+
+# layer 1: add dir+file, modify a file, delete a file (whiteout)
+_mount_overlay_rw "$basedir" "$upper1" "$work1" "$ovl1_mnt"
+mkdir -p "$ovl1_mnt/app/l1_new"
+echo "layer1 add" > "$ovl1_mnt/app/l1_new/new.txt"
+echo "layer1 edit" > "$ovl1_mnt/app/keep_dir/change.txt"
+rm -f "$ovl1_mnt/app/keep_dir/remove_l1.txt"
+_overlay_unmount "$ovl1_mnt"
+_build_layer_image "$upper1" "$img1"
+
+# layer 2 stacked on (upper1, basedir): whiteout file+dir, add file,
+# opaque-replace a directory so the lower subtree is fully hidden
+_mount_overlay_rw "$upper1:$basedir" "$upper2" "$work2" "$ovl2_mnt"
+rm -rf "$ovl2_mnt/app/delete_dir" "$ovl2_mnt/app/opaque_dir"
+rm -f "$ovl2_mnt/app/keep_dir/remove_l2.txt"
+mkdir -p "$ovl2_mnt/app/l2_new" "$ovl2_mnt/app/opaque_dir"
+echo "layer2 add" > "$ovl2_mnt/app/l2_new/new2.txt"
+echo "opaque replaces lower" > "$ovl2_mnt/app/opaque_dir/replacement.txt"
+_overlay_unmount "$ovl2_mnt"
+_build_layer_image "$upper2" "$img2"
+
+# merge both source images into a single self-contained image
+$MKFS_EROFS_PROG --clean=data --ovlfs-strip=1 "$SCRATCH_DEV" \
+	"$baseimg" "$img1" "$img2" >>$seqres.full 2>&1 ||
+	_fail "failed to rebuild merged image with --clean=data"
+
+# remove both source images: the merged image must be self-contained
+rm -f "$img1" "$img2"
+
+# live read-only stacked overlay of the same layers
+$MOUNT_PROG -t overlay overlay \
+	-o ro,lowerdir="$upper2:$upper1:$basedir" "$ref_mnt" \
+	>>$seqres.full 2>&1 || _fail "failed to mount reference overlay"
+_scratch_mount 2>>$seqres.full
+
+FSSUM_OPTS="-MAC"
+[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+sum_overlay=`$FSSUM_PROG $FSSUM_OPTS "$ref_mnt"`
+sum_fsmerged=`$FSSUM_PROG $FSSUM_OPTS "$SCRATCH_MNT"`
+echo "overlayfs checksum:  $sum_overlay"  >>$seqres.full
+echo "fsmerged checksum:   $sum_fsmerged" >>$seqres.full
+
+_scratch_unmount
+_overlay_unmount "$ref_mnt"
+
+[ "x$sum_overlay" = "x$sum_fsmerged" ] ||
+	_fail "overlayfs and fsmerged checksums mismatch"
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/030.out b/tests/erofs/030.out
new file mode 100644
index 00000000..06a1c8fe
--- /dev/null
+++ b/tests/erofs/030.out
@@ -0,0 +1,2 @@
+QA output created by 030
+Silence is golden
-- 


