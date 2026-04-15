Return-Path: <linux-erofs+bounces-3314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKG/JkCc32kEWwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:10:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C904405270
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:10:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwjhY0dtvz2yvh;
	Thu, 16 Apr 2026 00:10:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776262205;
	cv=pass; b=RNh8WOvbHudTpRuP/ofIPtvpoTBgHY9hF4nSu/KIm+aRLvm9Qx8eylMNDNjeZqO3flyyVIsRoSc6CKLznPHgpVbi8DAMcN4v1zueYKnZzKbkKj1etmWO+jExa/J287u2znqJPMi5q8etnQv4w4NNoW2SU9MR4ouMNGbJqVsc6bmUBUoQ7eJerggKaKWndvNijGIQX9TqROZxQEYGi3ojdyNFfl0u9vlMn9+VaWFTlY09r3PK6iqnGWZWRc8dn2HdNe9xM1ifpxXOYrio2DwkBFqv/WUiyL4bp/ENyxNwkLHGNRLjfQdBfNUT5epvpP3jBMd2VM567H2Eir4wPj8ymQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776262205; c=relaxed/relaxed;
	bh=nK9l9KYMK+wkhpXZXWEY5p6XqK31hHbRsjQh5c5ltic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpt8vIYJ4pJ2oFCQ4RUnY2dPdQ9DJ26KBI70B97m7AazyrQ68cdsNPE16rQXIE+NSyfI/P9uUvdru8XZd+3ChcaAElr9EtjT/lJxG4AdJ1g14AT+X5kOVww9tsHsF+tic4lS6GtuGG7GJNzzD0Qh6xJSSrEpk6tcEz0DqJSmFfQJlItYc+cwZAU3ZIyWqdvO4SLmAyHNEJ62MwvT/+p4K8zluHuax2IvgD8hM9k1YSoM4ONlJKXQjFkDvDAh2QiiubNIRTR/QXatfAtFRMAdEL85v8h9fI56L57gkIQboP/xmv9SudSkkNzfGyICeUrfwdF0FYyMxCjirK+fC8SnNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eWR1+wS4; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eWR1+wS4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwjhX3XpQz2yvY
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Apr 2026 00:10:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPuwp59twivp3z0zmlwRiJ+i/jDySLXX+y4i3JLCZSgB/9RSKe1lqiiyBFW5N5c2TFgGC2F9j7Yu3Mc2UsrRdU+UGVHR6NDaA03eyCA3hmEx3WVwWuEMLmFEgb4mwXi3Pz59geJWhH+8awJAc003+cK0sjT1VzVKzajq1GbuvRUg4CQ37M0vLpdmQ511+AIzLusjR3DTqrQhlOCvoUCaAowN/DWCQ9eHumSAbxnQ1Y0RXhDYD8XeXWlQUeA1g0NQeLzGrz+PEiYFIFbm2PZqfCPZhz6fkN2LitfNa35I9g2jPsphSL8NZ4SA1Dps/3OjVhU0rS0/XwHw81rXLEHZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK9l9KYMK+wkhpXZXWEY5p6XqK31hHbRsjQh5c5ltic=;
 b=M+dLT6lQ9hYvSxxg8bCuXI4gR1ckAyQr6xHafTGTcZWzb9SSt29Agse6EU4hwP7M4fJNwnuM2HNJrRjPBcOqxvKCo5hZsto59CAWA8gbK6SlE4dd61d33UAdDl83E0PRf613ScLLNYX8FPBK2XRf8VO7LiaZgQZEVwFNXmxVT1lIDOLsQNRmhfLTJyEkd6pvdd9W1OvU09PRQhy7qo+eLz507N332xBHrO/Bu5eAeLXSBlZq3gZifKstmZoONHLFWp3+APPaaj04p8AzMDsPU4N821twvC+GlYkKO6BtD8uQk3SvU8xjxZ1FBepkP5wgIORuW/W0JmhXvGFxs6Qinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK9l9KYMK+wkhpXZXWEY5p6XqK31hHbRsjQh5c5ltic=;
 b=eWR1+wS49jolDahiM2b1GNvDU1qkvXaI0esX0KNvAdAP1aM2cUvXEoU/zSqnVgwFDXDoU6JxnemUkW1HrmoZ/cGWo+hioLKxKdiCDzFOGAhc6LjXOPr3m1pH+d7XPfcwB145wYVbgbN8pahKU9bSAFXX1MCfGoKyl5IC/XMZAIKsS3+L4c1+L2CZ9LdgOS1eg+ISa2cOMn6Mr6WfaSvVGkRza4aKjsoHLixtmJt57dJXNAsNXLMERY179j7diRFMx4a4AIRmyxbMlfdCS0wa48h1LoDZtAR9I3WTX0V+3rvliuZhc0qNw0lQB0O6oJAyx5lNU+sb8kBVy6Q6TH5pGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Wed, 15 Apr
 2026 14:09:41 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 14:09:40 +0000
Message-ID: <85015a5a-a5f2-44de-8cd0-dac477bebffa@nvidia.com>
Date: Wed, 15 Apr 2026 10:09:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] erofs-utils: implement the FULLDATA rebuild mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
 <c91f39f7-4563-4514-b1dc-437ceb81423e@linux.alibaba.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <c91f39f7-4563-4514-b1dc-437ceb81423e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::19) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: e245b1e7-4e1d-4b40-82d9-08de9af8a296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wEVqJ+Bev+ul2cQhjK64eQtojjei+DVA6jzZkFt4Mo53uwLpI4ZXeOtsuCyV3HGXuhznL5D20zoVC3OnCCwmo3Co/GeB8Oa7GYFliJPVnSN5fPLwqwznqQEn1ObViDT75o0kDydvGBmbvPEC62SvxifPQIs7utxjmIzpvputg/egoIQOyOE6cAEKvx5/mrKDS/cXCPHjgrezJRQzg9zr0y4sPG/dIgXFTTcMV6FmYdc2NAUB2T2pxBGOFgNwzwrqGHjCwBU4RpwAu2xsoBHwc3X1cX477SqrCjp5W7FkbQ8eXSysU9tGoYn5wauace2SiY+MRKXBdfo6Z9a7XB12gG8pjtLf1zXQFJSWBRjTR1v196hqs5CGBqtIkMq09u7noADVGHzlbLdwD0SSBZTU+ju43ZnGpPIBNqThuCvMYB0F3Gw4rOJWRrc2feK/KYd/LhImyBwOJavricHdAUWJoS99nSGb42yQhvQBFvL6FcZUl3Qx4HozU9ynt6Nkj1df8A66yYc/juIoGiuSiatV/oyla+r3G+iyvadigzzMIdx4AIt+6etAPUm46yy1ddV1ngjwI+NQnyIVZTv4EQBZg2a9Ihj8386JYvLFNlHgoUjLY8RA2f7lg2izPGJCsNhjOMG9OdcdGVaMdUU0vnV9Raa6qioh7Z1d/A5FZw7PwSBWXDn9ZJ0Jy9EYGZbnOQ0nHlhm+XpYOfghGC3WVnv11/USNVFo9bvUFhoVJ/YUYc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2VYTlRQQ0t5K3djR0IvcW44SmwwaTF3ZWpIVFFPSjJ3cEtwYXV0bHhBQVFJ?=
 =?utf-8?B?QlAweFVwMnJ5NVE4YmloL0xWMVhoK0krMVhNdHp3czdadnFVNEpFRVZ6a0RF?=
 =?utf-8?B?T3RsSTVEVWRzZTZQTkdCaTUvMlpycVd0a1lCeVNabWlZa1RIWGZqb1F3cnh2?=
 =?utf-8?B?aTRwR2pMbEVscGNOWFcxUFZIU0I1Q0tncm5FbXh3SE1LNjkwcTdtSDhBbjE3?=
 =?utf-8?B?N21BV3lCVGJXU01XaWR3Z3FBMTUxTUZNQ1J2UlppZ3dGdGZFMXdNQml6Qk5k?=
 =?utf-8?B?aUNvcW41VU9XM1g3Y1dtc01lV3JSVkMwcGFuYnpsN1dGdnNKQWFBd2tmdjRp?=
 =?utf-8?B?Rjh2YWZDb2N0U0JtOHQ5Nms1Q2VRbFVlVGwweXR6eFRBcHp5NG5NenBlMEpx?=
 =?utf-8?B?aThIMVhiZTVub0JzUS9LSENDbTYzVzFobjBIUFpqNWZQZis5MVJuM3Z4MXRY?=
 =?utf-8?B?UlFOS0dmdjl1a2d6WTdSSU5HdlJkNkVYRVYyS2E4M3dGM2hmdmltMjh2ME9R?=
 =?utf-8?B?MTNsVkgzc2FDWllENHJOZVVzWXcwdVF6WUwrN25qanVQUngrK1d0SUxlTGkr?=
 =?utf-8?B?ZkoxOVppSTNlVk1Yd1ZqTkhsaGplOVQvTzdtbjNMRDA4TlVtdTRCTXJYLzAy?=
 =?utf-8?B?L1NVYzJla2dtZm9XVzYwSllKTWhPR2tJUUJFWkJTNnFTU2dldjlwRHVkYng5?=
 =?utf-8?B?anBzUUp6TjR5VTE1bmNYVkE3UWZnSXh3aEN1TlR0b292OVI1SkRORG0xUFYx?=
 =?utf-8?B?WDJtZ0lEanJkWGI1b0dqc0JjaUtEVGZteUdnckNrcXF3QkRpZTVaaTJQdFU2?=
 =?utf-8?B?d1lsYkl3Vk4rcmwrazNGbHlaU1BCWXFnd0pEZG9PY2FVanNIZXgwcUdKY2tU?=
 =?utf-8?B?cW9UTGswdGlKaGQrdnFIZllWSFZPb1NoMHN2TTZNVTFYVGhwK1Q1TGtoQ2Zz?=
 =?utf-8?B?dkVHWm41Nkt5M3BuR1l3alZMME5FMG8xMTJaVWcyYlpaZStNejd0Z0RJVURZ?=
 =?utf-8?B?M3dqR2s3M0NXeS9raVJpdWhxN0lmZSt4WmI5dDgzczRUSjFMYUVlUnhiNzhC?=
 =?utf-8?B?Qi9YTUovUGN1N1VLdkI2L2YxMXp0MGZ2UkhwZmljVWw0cGFmQUdFcHZOQlgx?=
 =?utf-8?B?dmhXN1pxR3BGN1pTZFl5bVZXNThSV3dSY2h4S3ZQd29LNDIweVRZb2RFa1lt?=
 =?utf-8?B?WHhXd1lrZjBKcCt4S2dVd0g4bjZXTThNSTA0NWRTMFlZcUVvSVZJa2lMdGJ1?=
 =?utf-8?B?aFEyaVJTaTNIWVpLS1BGVGVDUy9RMDkxTjZmQU03YXJ1K1gwb2diQnVvTGRq?=
 =?utf-8?B?YWJrQVJ4Tks3WVRSaVd2SUdzcWFjVGYyQ0tRSmRlTWtXdUt5RUNoQ2R5OHVW?=
 =?utf-8?B?bWw2M0Fwc1pzV1pvVkFQUUg0SUZrSkJTSkpmSmdseWJVVmdXUzh2VjNkUzFp?=
 =?utf-8?B?ZVJyemVXUy9HRDM2NHBESUFWaVB4SUhRdC9OMHg4Y0Vrdk5ieXVkUUlTUHMy?=
 =?utf-8?B?MEpYaEtVMHhIVWlOajZKaTRISlFmMnUzdlhOK1JOcUNSdG12R2VyeXpmMmdt?=
 =?utf-8?B?Q1dpdTVwR253R01KNFlPdE9BVzlGUUJNTk9oMTFvTEtDWUZraURnOXVzS0Ew?=
 =?utf-8?B?Tm5ZQU1aUFNCYTZTNWJjdVlybW11OTl1WlRFUjlFbG1zREYyVFNTMFRTQnFY?=
 =?utf-8?B?WitHVXdpQ2J3amtxeWIwbGdxc1Q5djhoT3k2cGxkZVRFVWcydC8zMllZMkd4?=
 =?utf-8?B?K1pyUGo1ZEtUSHNiMGMyOFNOM2pHREttcUU5SWdiTW5kUVlZLzFDbjN6MkdW?=
 =?utf-8?B?Z092UC84Qkg1S01iMEdacDdBS3JZYW5EUXBNOXJ0aFdPOWVrUElnN2tlNEow?=
 =?utf-8?B?cHoyamd3M1haVUxwaWhmRFVjZFM3TG1LMFpacGdtcHdCRHAzVjNocXQ0bi9t?=
 =?utf-8?B?ZlpLbFhweXJIWVphVnNSU1cyTTZlYjRScTJJeHhaQWZ6V09vZlV0VFo4RkdS?=
 =?utf-8?B?cW5mSGI1OXdNZUZwV0Mrb2xjM0lsYTN4aW1JaVk2b0grSWFYeDVMclRuZ3Fh?=
 =?utf-8?B?bFR4cFExNEl5SkphWUdqUVJLakdWMnR5N3lYUHhwSThHWWViRnloZG9BNEZY?=
 =?utf-8?B?NENxM2hPN2lLdjlUZTJ0bm1EZFBGN1lZdEZMRnNSOURURWdTaHd1QlFqZ3Zz?=
 =?utf-8?B?YjVEMVpWWjRwUkYxQnh3Y1BxWUc2V01TTWwvMTRmZDNHaVVST1pIRGI1SG53?=
 =?utf-8?B?YkxRQmdBSWFrKzYrTnp4NlpVcjA0b08yQnRveWtNSmhWd3JHL3hSSmhxVUpa?=
 =?utf-8?B?dlM0NDYveVZxSklZOEZGeldLOE1GVmdwYU9pT1BreXI4ZHlpaGNPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e245b1e7-4e1d-4b40-82d9-08de9af8a296
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 14:09:40.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU4rBONsg40wjJeCukxN6IOIvC4yXw8SsF24MB818GSqhz/KpiWCCWMvQ31Y8pRDr/12ycsrJJgB2sEM2AdoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3314-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8C904405270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-14 10:07 p.m., Gao Xiang wrote:
> 
> 
> On 2026/4/15 03:10, Lucas Karpinski wrote:
>> Currently, erofs-utils supports backing blobs for multi-image setups. 
>> This
>> implements the FULLDATA import which allows for the merging of multiple
>> source images into a single self-contained erofs image.
>>
>> To optimize the rebuild process, erofs_io_xcopy() is used to leverage the
>> copy_file_range(2) if available. This bypasses userspace buffering and
>> enables kernel side data transfers.
>>   Verification: Built same image with default rebuild and rebuild with
>> FULLDATA. Then ran F-i-f/tdiff comparing the two.
>>
>> changes in v3:
>> - adhere to uniaddress semantics.
>> - take advantage of existing infrastructure which allows us to drop a
>>    significant amount of complexity + code.
>>
>> changes in v2:
>> - reworked erofs_rebuild_load_trees_full into
>>    erofs_mkfs_rebuild_load_trees.
>> - removed --merge option (use --clean=data instead).
>> - updated man.
>>
>> Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
> 
> Overally looks good to me, will apply to -experimental branch.
> 
> ... Would you mind taking some time working on some tests
> in experimental-tests branch?
> 
> Thanks,
> Gao Xiang

Yes, I'll work on adding some tests.

Regards,
Lucas

