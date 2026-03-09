Return-Path: <linux-erofs+bounces-2550-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDxABsD3rmnZKgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2550-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:28 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 626EA23CDC4
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV2lv33Tjz3cBP;
	Tue, 10 Mar 2026 03:39:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773074363;
	cv=pass; b=QT2+LKiyf5xtRaNov6ms5BUXqqXE+snHhN2NuxePotIE4ywiXHj8sWMzRgU0mXyFIXoLT52oerh3UIebIq0gG20NuKm79KiFwR+VO4u4O/Ycfso4lQ+XJwAhzlV0HSnf7KS1stLWYNTmTj+hoziPZA2XfZY3e/LwEM7SPUK8NzOKgk5SABCTnc2m0Aq63fzzSy/Gya5ezQ05HzRi8PINAFObuR7cA3fompjK2HQMHtdxhO2s4t7kp49PFq58S3n5MJYun6u6B/LwOM6//dW0ZgWhJIQMtx4gjJE0asV0kTzBuCjhMkxgUJv2RZTjK7NbYm/4VtnRR/XuR8g7lo5bkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773074363; c=relaxed/relaxed;
	bh=QlnZpnY53JO84rUTkNY+xZhccTcnArYoYnsN7BT0DI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABAXgYGYBur4ltmNsi4SA+wxR+O6Q0SouPHysB6Gy/AD1PJHeqBy1JQ2UI0pt3TW3kldbuQ1kz+JgBLgylDJeeZI1XfsFIL46YhyUkO3dX2Qrayj1EtiYkTQKJnWBVwrbO9LaxGgUosdWD6oFZYCivODGIv9vinrHgp88Z5cTH+TQHVpqTBsuTn+u4W/GwyhLb9f8KLxXNg2HYPMYrlw8KVNwKahBAwZJN9CL/7Co/VmV/8eM0yXcAHPTdu6ZNufxHLkXbs4zn2ytvNFK7gg/2Km3gGrjjxWCWnVZBKNaNc0FHIVgAUpqRuEDdYpruVMQfG7wTcq/x6y5Nq64ntEyQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oLn8mrbQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oLn8mrbQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2lt5bbgz3cBN
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 03:39:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6oQLaSR9KBi9qZ/x08N/rZk2xPkhqIqgEama3WrB9qGQFW0w26HLoHW8JIgF0rgMqDdMBCbAZbka78I5y+rLOEIt7QcndAFUvs+TGjCAhQ2SZardDnlb5k6uebWvmUNuDPHicQ+YFAvSdr4tTv+cv7xPhyGxWiH530greUlE9OaLsnBIFDMT4/azVb58Jb2JegugIzFluJ4Copu55u4bz5Ax/1WWvEasYLmoRMeDHk1d75nQ0+PW2lCWZx+MAwcF863uk9CwG356IObe3NWYqHirXzlDUJjyNyrHntDHtKmjVNMO9TqW18cS7MLj3fPHCxn/uF33Dbt+Z+r6MpbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlnZpnY53JO84rUTkNY+xZhccTcnArYoYnsN7BT0DI4=;
 b=sM6vtSj4R9/nW4NycLHccitmIcbe7AzBuUORDDhhPa+ydmPCBOp3sOCYu/F9f4V5xdnNfw3JrkFhxVOagbHbWpUZUP/0mYxiIF3hXYVwC/mSKct4DW4bmJgyy1YS8ajYZtrHm4xTobHcCVlABNmTkVV/NDmWSGNEHE0E8ej0XSglzQpoz68JAt8EkJKtd776l64LGx7ORB8pJlUJ5vgagm1MxM0WeY3gwN7EO6gWjN/1kb99gv4ll+bXf2yN2VZeafH19S9IrY4XTa5OKJpvFQuVi0RQoiQ8I94L+pzrjpBoxK3UJI5VCwqXuOVhKSf3El6U+E3aM2Ug58BcHUtWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlnZpnY53JO84rUTkNY+xZhccTcnArYoYnsN7BT0DI4=;
 b=oLn8mrbQXSpqpbvz+McyLDO/MM+higyOEDOWj417Qgzkz2EiCJnA3exIUV1jf1V8m5UxjC8f0xTKhKNJtTlHo+S3XnjWgO2S2M/ahPRfxIm/Pl1jpS6bHRSJnjQc77C/h5+d9fX1Ko0QH0oRH8Pi1ognHppp4LQNNpKN6LdHfNqUPIRK8YkutRIqkPGm8yTl7dWeGZeqh3JF8+6hyuvyCwUteDYTsvleh7gm+7/uws6wYiOio8dm3l5mJz78FYhhKUzzcapjguDz98/9Vg2Hj4c37UI12ElfGhnwWPcoO2k4b9oV8/mO/9ui81GQrvJKl8ipbjTJswabkz/6k/eVsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:56 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 16:38:56 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 4/5] erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
Date: Mon,  9 Mar 2026 12:38:20 -0400
Message-ID: <20260309-merge-fs-v2-4-2dd0ef53db4d@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
References: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: fd832d31-9b4d-4a58-24e5-08de7dfa560c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	EiLGoqwhX7LwpZ9uKaEHBiK02itIo+bVtB92nDrdRMt+PXnYzwAK7I+hy5zC1AO/e/grX2eVSNi9AkSOx9WaTDbJpPqsWGm/dcdMmsooqcbN8DGe3gEq6jJoC6HToa+2Ubgb+Nxc2aH/i23IgBEJB9xCZc4OXl0z7DBMNKvk1CaM4ySy2OMZdGX6MYUJWQNQX27Bi/FAAW5UaGR3NLhFn51ceuSHe2wrboZxFsGTeMnhmoW6WvKwGRAil9acmyjo+TNDnAzvP2hMrJ+nU6NG0rJFq+RJ0jmdLLUYdKIaHgEl6lbzDgSI4MFJKA0RM9ltzdTyI+Ck5VrUWaCvSAbh/AL6LNRgdGmo5n2yf3JXPOw0VJgXTk03/LeYDIedB9gd/W6kLR8xqcAkA01QNdbhw5lCQIFasJ/v5IuiJQyiFCVVafjrLTYye+DXYutLoe5b69i23PGbao4IqePOgGkvswwnqq4IEEpcRadpzNJ3SBcIOTPUAkpiYuupA1ND8Ot6dZPIaHcNboJoXXuRUjNt9VPqGSc6lVfgonYAwQI29I07Gxww0SkMogbwPmHUURt+yMe0ThkbO98AZbjaZmmO+MhW7HYkPxuKCZrdwG6rbrs7to0v86sCTqMY+PMqQxWpTw6tlpNMWWCrI5f8bGZXJnN4FMUmBIvAZYT6wcCf7LkBnFnfmxkqWqNGzE8fSZwXFU8nHcwYBizrNXPO0Y+xkErgyG/3GQ/Igi1yVuPMhqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW1LR2J5akpUM1RVUmVPK0pMaFh5aVBnd0F6Sk5BaEFjWUpWWXhiNFgzbGNP?=
 =?utf-8?B?NitLRnlqekxwbmU1U2JRMW1GSnJ1aHczY3JrV2kxOS9TcFNkcmppVmpwYXZt?=
 =?utf-8?B?cU1laTNUa1YxT0N2NmI3UHVTQXFZT3ZmbzJEeHVyUWYvOWVtQVN5NHpVVk5D?=
 =?utf-8?B?bjgzcCtKM0d5RnpGN1FoRWxHamlPUUNTWU9lcUNXRng2dUFPeVZ4bGdzTEIw?=
 =?utf-8?B?d3VWelVGay80d1VYZkIwYUlzUXdXSHd1eEs3YkE3TnFUbGZZeHFmdzlZOWZX?=
 =?utf-8?B?UFNjQ3o3Z09nWCtvN3R3VE52bXY2MURQb1lLdE1HenBxUmc4SG1CL2tZOC9u?=
 =?utf-8?B?VXBOenlydWdoY2NqNlJ4aW1tYlNLUEd4SVZVSlZ3MFNyM1B2MkRuQW5OTmZM?=
 =?utf-8?B?RXFrUDdyd3JnREtnWWZDbncwcjZWTExKeWxwME9nM1phNEZueDRYcVBJNHJo?=
 =?utf-8?B?VzF3VFdwemNENys0ZkJvZ205akNRS0NOMTBkNU5WOHdpcEMzcHpoeDBVck9C?=
 =?utf-8?B?cDZFSlhuMGJTWXFvb2NwcUZ3MDBpUUpoelVIa04rUDJKMzREUmk1Z204RHFj?=
 =?utf-8?B?QVhZbVR6SnVybWVaVW5iREhvKzFTZUg4dTZJaEVkbjYvZFhsRFJucWJxSUdy?=
 =?utf-8?B?ZXQ0cWloem9WTEVYb1o3UFRHcDkrRGdFWlZmOWZ3YWhadG4xUTFkaldRMnVl?=
 =?utf-8?B?emdHMTRsV0ZseC95QlZXa1FuSDVFeFNRMUF3YUZpRUNqWUFyYlRKak5IMk94?=
 =?utf-8?B?RmxweHNFZmMxci9Xa3QvM1VJNDJlQXRISzYvZ0xYcklFUm53NWVUc3JIdkZB?=
 =?utf-8?B?QXM2cnhSdkpwOWk2YkJJenFKZEh3Q0lpS2xzZ1pWc2dtNGJOb0lRWGk5bkxJ?=
 =?utf-8?B?Ty9YUDdEd3d2WUpiTGMvVFByVFdLYm9ESndCRm5NUSszMmtjVWV6Vkd2U29p?=
 =?utf-8?B?bHRGdzJaaGpab1hVWEpxWlBLNWdORG9ZZ3VXRExydUwyNmFkRG1oQUk5WGVn?=
 =?utf-8?B?VGxDMm9aNXo0ZlRBZFRSeDd5SkFPOHdLOXFWU0ZrT0VpOHZnZ1V4MTE0S0lv?=
 =?utf-8?B?T3dXcXVKRUxkRmo4MnB0aTFQVEZoUUgzNUFBTlhuR2R5dEJWekN1dVFzUDZM?=
 =?utf-8?B?K0w1V2pqUktlTVZLN3VQZ2FKbEFQaGF3Z1duT2dLZXpFVDN4bXFkaGlkNmNH?=
 =?utf-8?B?U3VUeDhPQkJoYnBRTkhXRGdvVWR2aUtsZmlIZmM4ZmpCYkNIQktUU3MzMnVV?=
 =?utf-8?B?OFArd1lOVVczdVdzeUNLYmI1WlBoYkZXZzNCQ21qNVRxQjVka1VSUVk3UTlM?=
 =?utf-8?B?cnRoTUtCM0NyU3c2dGc0aUVCOGY0YTFPOEFzUHFscnlKZjJiT244ODlPKzJM?=
 =?utf-8?B?eldLdEFMUlNHNy85OTd6V29KVUU3UkI0S2RrcGxOOTRJWkVSR3F5TmZ5cjhG?=
 =?utf-8?B?SUNUVDdFa1c4WERoNWhYd0hjWjJxNmtCdGduemxlMEpTVHcxM2hqVlhyM0RK?=
 =?utf-8?B?c29HSkRqbExiTjRLVis2WllvUkpGWXJaNmRpNWpRUDN0TVg2bnZsQkQxdVlK?=
 =?utf-8?B?VVlXYjAwV1FpQjVJMDFKcjdLYnNUZHVQWlkzb1hWUGJtS2pDc09mM1pCdkM4?=
 =?utf-8?B?T2RZQ243QW1Rb1RqSHkyOXBhaENGcGluMk9vM1pEVmFxams4Y1g1SEkyckRM?=
 =?utf-8?B?MzFNTUtPL014US9nYXJDMXJjaG50dlE2Q2JFc1NBUTMyUFUxbGxOWE05Qk9Q?=
 =?utf-8?B?dnozZjhjUU94dVpRN0lSYk9aY3VoNTFGRmt2YkNUbmtJQ3Q3NDFzajRHcTRS?=
 =?utf-8?B?b0hVbHNGWjcwdjk1dXp0cE9jcUJSWkI0L3hYU2ZtUzArR3JtVzFkVHNneFc4?=
 =?utf-8?B?Y21VR3AxZXY4enVBZjVXalM0b2xnNUxidGxrSzNTM0F4VEt1VC9uS2lxV2o3?=
 =?utf-8?B?UjFnSTZGMXo5ZElMS0NmT1IxK3RlYW5UcUE5bkNiaHpjemZCSmtoZjJnOFc4?=
 =?utf-8?B?Q1VSMzJIUUxuYmw1U1JBa0NiVDd4NXA5UUE5YXd6d3pIUUdRUHI4WTY5bHd6?=
 =?utf-8?B?ckNYcElmTzJoWnBBN1BoWU9CeFRFdnlWSSsxRW1SZllqV0pIWVFIbG9JK2tL?=
 =?utf-8?B?LzYzcEV6NEpSemkvQVBPVW9neXF1QzM5ejAza1JTNkRwSDhETWQrYWZ4eHVW?=
 =?utf-8?B?VmVjYU4wR095eDZuUVcvbFljT1pSdXJ6dEJCL0lMZi9JKzlteVd0UzJzMVpW?=
 =?utf-8?B?WDJpZTZLY08vL0VSamJMOFFCOTUrZjJXaTFvemVvYnFyV3A2S2hidHdyNnQw?=
 =?utf-8?B?U0tCRGhDczVTRWNwU3lMV2NXNGkwbkFGeEN3Y3hNZHQwMlJSNFBnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd832d31-9b4d-4a58-24e5-08de7dfa560c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:47.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnJ0jdv2K2b3ODz8fe6PzLwEZfS7vAjCYm19jrPwKhv1nr2Ce8+t1zzB5+2PuQF9TUjmc962ceTNqzUfXMGKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 626EA23CDC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2550-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

This patch introduces experimental support for merging multiple source
images in mkfs. Each source image becomes a directory directly under root
and keeps its UUID stored as a device table tag. The raw block data from
each source is copied using erofs_copy_file_range. We preserve the file
metadata and layout (FLAT_PLAIN and FLAT_INLINE). Symlink paths are handled
by reading and copy link targets.

This does not yet support chunk-based files at this time or compressed
images.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/cache.c            |   6 +++
 lib/liberofs_cache.h   |   1 +
 lib/liberofs_rebuild.h |   4 ++
 lib/rebuild.c          | 112 +++++++++++++++++++++++++++++++++++++++++++++++--
 mkfs/main.c            |  44 ++++++++++++++-----
 5 files changed, 154 insertions(+), 13 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 4c7c386..49742bc 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -544,6 +544,12 @@ erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr)
 	return bmgr->metablkcnt;
 }
 
+void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr)
+{
+	if (blkaddr > bmgr->tail_blkaddr)
+		bmgr->tail_blkaddr = blkaddr;
+}
+
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr)
 {
 	DBG_BUGON(__erofs_bflush(bmgr, NULL, true));
diff --git a/lib/liberofs_cache.h b/lib/liberofs_cache.h
index baac609..55e8f25 100644
--- a/lib/liberofs_cache.h
+++ b/lib/liberofs_cache.h
@@ -138,6 +138,7 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 		 struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
+void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr);
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr);
 
 #ifdef __cplusplus
diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index d8c4c8a..fba7f39 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -17,6 +17,10 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode,
 			    erofs_blk_t uniaddr_offset);
 
+int erofs_rebuild_copy_src(struct erofs_sb_info *sbi,
+			   struct erofs_sb_info *src,
+			   struct erofs_device_info *dev);
+
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 			       unsigned int *i_nlink);
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7e62bc9..451307a 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -14,8 +14,10 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "erofs/io.h"
 #include "liberofs_rebuild.h"
 #include "liberofs_uuid.h"
+#include "liberofs_cache.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
 #include <linux/aufs_type.h>
@@ -221,9 +223,60 @@ err:
 	return ret;
 }
 
+static int erofs_rebuild_write_full_data(struct erofs_inode *inode,
+					 erofs_blk_t uniaddr_offset)
+{
+	struct erofs_sb_info *src_sbi = inode->sbi;
+	int err = 0;
+
+	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
+		if (inode->u.i_blkaddr != EROFS_NULL_ADDR)
+			inode->u.i_blkaddr += uniaddr_offset;
+	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
+		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
+		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
+
+		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR)
+			inode->u.i_blkaddr += uniaddr_offset;
+
+		inode->idata_size = inline_size;
+		if (inline_size > 0) {
+			struct erofs_vfile vf;
+			erofs_off_t tail_offset = erofs_pos(src_sbi, nblocks);
+
+			inode->idata = malloc(inline_size);
+			if (!inode->idata)
+				return -ENOMEM;
+			err = erofs_iopen(&vf, inode);
+			if (err) {
+				free(inode->idata);
+				inode->idata = NULL;
+				return err;
+			}
+			err = erofs_pread(&vf, inode->idata, inline_size,
+					  tail_offset);
+			if (err) {
+				free(inode->idata);
+				inode->idata = NULL;
+				return err;
+			}
+		}
+	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		erofs_err("chunk-based files not yet supported: %s",
+			  inode->i_srcpath);
+		err = -EOPNOTSUPP;
+	} else if (is_inode_layout_compression(inode)) {
+		erofs_err("compressed files not yet supported: %s",
+			  inode->i_srcpath);
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
 static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 				      struct erofs_inode *inode,
-				      enum erofs_rebuild_datamode datamode)
+				      enum erofs_rebuild_datamode datamode,
+				      erofs_blk_t uniaddr_offset)
 {
 	int err = 0;
 
@@ -265,6 +318,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 			err = erofs_rebuild_write_blob_index(dst_sb, inode);
 		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
 			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+		else if (datamode == EROFS_REBUILD_DATA_FULL)
+			err = erofs_rebuild_write_full_data(inode, uniaddr_offset);
 		else
 			err = -EOPNOTSUPP;
 		break;
@@ -387,7 +442,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			inode->i_nlink = 1;
 
 			ret = erofs_rebuild_update_inode(&g_sbi, inode,
-							 rctx->datamode);
+							 rctx->datamode,
+							 rctx->uniaddr_offset);
 			if (ret) {
 				erofs_iput(inode);
 				goto out;
@@ -425,6 +481,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 {
 	struct erofs_inode inode = {};
 	struct erofs_rebuild_dir_context ctx;
+	struct erofs_inode *mergedir;
 	char uuid_str[37];
 	char *fsid = sbi->devname;
 	int ret;
@@ -447,16 +504,19 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		erofs_err("failed to read root inode of %s", fsid);
 		return ret;
 	}
+
+	mergedir = root;
 	inode.i_srcpath = strdup("/");
 
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &inode,
 		.ctx.cb = erofs_rebuild_dirent_iter,
-		.mergedir = root,
+		.mergedir = mergedir,
 		.datamode = mode,
 		.uniaddr_offset = uniaddr_offset,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
+
 	free(inode.i_srcpath);
 	return ret;
 }
@@ -556,3 +616,49 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 	};
 	return erofs_iterate_dir(&ctx.ctx, false);
 }
+
+int erofs_rebuild_copy_src(struct erofs_sb_info *sbi,
+			   struct erofs_sb_info *src,
+			   struct erofs_device_info *dev)
+{
+	erofs_blk_t cur = sbi->primarydevice_blocks;
+	u64 src_off = 0, dst_off, len;
+	int src_fd, dst_fd;
+	int ret;
+
+	ret = erofs_read_superblock(src);
+	if (ret) {
+		erofs_err("failed to read superblock of %s: %s",
+			  src->devname, erofs_strerror(ret));
+		return ret;
+	}
+
+	dev->blocks = src->primarydevice_blocks;
+	dev->uniaddr = cur;
+
+	erofs_info("Copying %s: %u blocks at unified address %u",
+		   src->devname, dev->blocks, cur);
+
+	src_fd = src->bdev.fd;
+	dst_fd = sbi->bdev.fd;
+	if (src_fd < 0 || dst_fd < 0) {
+		erofs_err("failed to get file descriptors");
+		return -EINVAL;
+	}
+	dst_off = erofs_pos(sbi, cur);
+	len = erofs_pos(src, dev->blocks);
+	while (len > 0) {
+		ssize_t copied = erofs_copy_file_range(src_fd, &src_off,
+						       dst_fd, &dst_off, len);
+		if (copied < 0) {
+			erofs_err("failed to copy data from %s: %s",
+				  src->devname, erofs_strerror(-copied));
+			return copied;
+		}
+		if (copied == 0)
+			break;
+		len -= copied;
+	}
+	sbi->primarydevice_blocks += dev->blocks;
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 48da20f..4ac835f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -15,9 +15,11 @@
 #include <getopt.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
+#include "erofs/io.h"
 #include "erofs/importer.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
+#include "erofs/dir.h"
 #include "erofs/tar.h"
 #include "erofs/dedupe.h"
 #include "erofs/xattr.h"
@@ -30,6 +32,7 @@
 #include "../lib/liberofs_metabox.h"
 #include "../lib/liberofs_oci.h"
 #include "../lib/liberofs_private.h"
+#include "../lib/liberofs_cache.h"
 #include "../lib/liberofs_rebuild.h"
 #include "../lib/liberofs_s3.h"
 #include "../lib/liberofs_uuid.h"
@@ -1717,7 +1720,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	struct erofs_sb_info *src;
 	unsigned int extra_devices = 0;
 	erofs_blk_t nblocks;
-	int ret, idx;
+	int ret, idx = 0;
 	enum erofs_rebuild_datamode datamode;
 
 	switch (dataimport_mode) {
@@ -1734,9 +1737,33 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		return -EINVAL;
 	}
 
+	if (datamode != EROFS_REBUILD_DATA_RESVSP) {
+		ret = erofs_mkfs_init_devices(&g_sbi, rebuild_src_count);
+		if (ret) {
+			erofs_err("failed to initialize devices: %s",
+				  erofs_strerror(ret));
+			return ret;
+		}
+		devs = g_sbi.devs;
+	}
+
 	list_for_each_entry(src, &rebuild_src_list, list) {
+		erofs_blk_t uniaddr = 0;
+
+		if (datamode == EROFS_REBUILD_DATA_FULL) {
+			/* Copy source data blocks */
+			ret = erofs_rebuild_copy_src(&g_sbi, src, &devs[idx]);
+			if (ret)
+				return ret;
+
+			uniaddr = devs[idx].uniaddr;
+
+			/* Advance buffer manager past copied data */
+			erofs_bset_tail(g_sbi.bmgr, g_sbi.primarydevice_blocks);
+		}
+
 		src->xamgr = g_sbi.xamgr;
-		ret = erofs_rebuild_load_tree(root, src, datamode, 0);
+		ret = erofs_rebuild_load_tree(root, src, datamode, uniaddr);
 		src->xamgr = NULL;
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);
@@ -1748,9 +1775,10 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 			return -EOPNOTSUPP;
 		}
 		extra_devices += src->extra_devices;
+		idx++;
 	}
 
-	if (datamode != EROFS_REBUILD_DATA_BLOB_INDEX)
+	if (datamode == EROFS_REBUILD_DATA_RESVSP)
 		return 0;
 
 	/* Each blob has either no extra device or only one device for TarFS */
@@ -1760,11 +1788,6 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		return -EOPNOTSUPP;
 	}
 
-	ret = erofs_mkfs_init_devices(&g_sbi, rebuild_src_count);
-	if (ret)
-		return ret;
-
-	devs = g_sbi.devs;
 	list_for_each_entry(src, &rebuild_src_list, list) {
 		u8 *tag = NULL;
 
@@ -1775,14 +1798,15 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 			tag = src->devs[0].tag;
 		} else {
 			nblocks = src->primarydevice_blocks;
-			devs[idx].src_path = strdup(src->devname);
+			if (datamode == EROFS_REBUILD_DATA_BLOB_INDEX)
+				devs[idx].src_path = strdup(src->devname);
 		}
 		devs[idx].blocks = nblocks;
 		if (tag && *tag)
 			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
-			erofs_uuid_unparse_as_tag(src->uuid, (char *)g_sbi.devs[idx].tag);
+			erofs_uuid_unparse_as_tag(src->uuid, (char *)devs[idx].tag);
 	}
 	return 0;
 }

-- 
Git-155)

