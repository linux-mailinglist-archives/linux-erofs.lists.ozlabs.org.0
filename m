Return-Path: <linux-erofs+bounces-3297-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEksGu9b3mlfCQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3297-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 17:23:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1A3FBB68
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 17:23:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw7MZ1NWcz2yVL;
	Wed, 15 Apr 2026 01:23:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40d::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776180202;
	cv=pass; b=kYnMZqkC7p1+19AMjWdNjt3I6Am0BTJ8o/bdNfuKQc69XQbeqDn/pzZc/WVmu4TK1oeocJUWezF3r8w9cq4JDLfZRl+sugjX/WJaY88rTwybdSMW8W2aTrRxLUgayta2aL/YghgNbNXe902oO5HtaoUexWzfouGaZkhFMRX4YUfVt2lcha72IFtXWCUTVJ2EVkp50l3kKoXzHYN0tzMNSDvv6XXvrMns3ESfaTK7+RudwFwCfEWGyiVxpePrntAHiewobcQ7UtaQVbS2zhXDApNDxUy+TQXlUKfzMQhRCjvohAbGmuLwJhrmXmbExiAxGP5o1BMecQLJA7jotPQLIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776180202; c=relaxed/relaxed;
	bh=a3iXHuwxCNonCqKPSE6/cHEYyFlT9zCQuk/zNKqypQY=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=eGO4x5Jsb1kkmyWwk9Gvh2dTJGESVrFrWRApuSBYzlUbsZ3gNcl0mA2bwZUtZ/zI5wT0YZXtfq5h/ch8WlwoP7/FGLxyLnmq9kNwvjlbzwV/UoneytQRQ+bnl7ROn+oRPH5i4+jC4q1Ls7etbac2YmybVIgfTEOsE4419/v34xa1URMB1K+EkvWKR5FmKgF1ZSkuGkGTKhzFEvNJkXAOk8dJT1GY8vTOJPCS/LxqX/lH65HkNnYzd6hhHX3a2cZC8z6sQSFTW58ukKSA/1YffRvnfKK0wLFAPjb7rAje+U1H7gcrpvujlNBaxJnMLzi+miClvpFd7G28//yEhAOREw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dPFrobPU; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dPFrobPU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40d::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw7MX6hlFz2xlh
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 01:23:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW/wOARiwPALp8DxTujR5S3ffGnpDteqQ13rlUH++iGDbtQ+b/B2IoLZK8lgfw9xWtUeCDi40PEYEuKXgkccCFpG6o/8yA1NofdcLQALZtW1XnfuLV7uEWjsT6k+Vs4SDFui6UVCnVJMqPnPZ36mYMUNyt59I/37FslmO+nNeiN4tiFQv/EJtWTGUTXZKuBbh44LB0Ma/ZX9amDky4ynTZ3jG1pCf1RnlXFm3MEsbQh9bK7XqovG52pVeY4xddUeY5BJ0xQvTJQyBj6vlfYTiMLwYAUxgJZR+8ao2FzbJLnP6JL/iEu2ZCxyyBmVvENxh96eSX5gozZdRO6E1Xq77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3iXHuwxCNonCqKPSE6/cHEYyFlT9zCQuk/zNKqypQY=;
 b=n4PzkkCBOats0N8tq16cc5Y8J6HTCdeLgV8SODFQrHdALoDuZHd2UvmuoSLQJmLuzhlDK2xpxISpwX11ri0Tiw/nxrBg7FDsdFWz7/FSpLxohOfHs/FiZQVgwZboFJJQPsZ0tauu/TKkzrwA2U+mlwMjlC/FYK3JcB3q5I79g4+q/EaE8dJb9GxCm4vifKzFLcCmwfWbJ2f0JxxeQFq8j5MZNNm/5NLzmc44LlSfH7zMT0w2YacTXAYu8KMvSj5gfbnzj1r5hkDAmzEH8waGyQeZhZTMfRknVLDM/Z+YjMpOeDsuSDygZCEUv3lXt1QSKHwtqaTyEnFTYe0zn9+Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3iXHuwxCNonCqKPSE6/cHEYyFlT9zCQuk/zNKqypQY=;
 b=dPFrobPUjFV7O9HDQ9dQA20JPTDIy9s0DvHjPfTMT/rGSzN7o38tmWERF4aENuuxGutuFVPukzyuS1RJp4E1+45Uo4mzKcyjgXFnOa09VTjBhbO5kQMaT0Xn15qYrBTJbJnJojs3BXIAQoPunjuZhMKrZdBEAIfJJacEG4mjQuAdoLeEOvF29Xzdc+b4jT/lwYF2cYt8NzG1KxJg+QscPlpWi4KV6FECdc06rfklnBc+RZjXmPMY3FAVLXI3KOY6XeasSMb1P2YnbztJby5Sq5a3iNZ5GZpIoTRhQ3ccddmQW5C5OU3BSiU+kUp4cPxvmPWjDd3C7Np9OKVaVi9y1Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME6PR01MB10662.ausprd01.prod.outlook.com (2603:10c6:220:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:22:55 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:22:55 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 14 Apr 2026 23:20:16 +0800
Subject: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAC9b3mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0MT3bTMitRi3cRUI4PkFGMLyzRTIyWg2oKiVLAEUGl0bG0tABmbLNF
 XAAAA
X-Change-ID: 20260414-fixes-ae20cd389f52
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=vtYEehdyHV3Jqp0DkVvKrtMxJHPC4jyhbxfoGHoxdrk=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzHvR+nunyb+7u2Vd47Mg/hWLWlbP5utivfbH++mR6
 phpj7v+7E/sKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgInMu8bIcKSde2e+6KZv
 yayWd9wUJ6np/5fxcp8xs67h/ucb3DMuXWT4X7B99S+djcHyvx7nv5X/3Pt2k4bwwcZHb7Ye+M3
 AKd9rzgQAemBQqA==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: PH7P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::18) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260414-fixes-v1-1-9ef86b484baa@outlook.com>
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
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME6PR01MB10662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5258c0-5f24-4abf-f962-08de9a39b34d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|41001999006|461199028|5072599009|19110799012|23021999003|51005399006|5062599005|6090799003|24121999003|22091999003|440099028|3412199025|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEU1Y3UvcnE3SFhVVGJyZllSTDljRVdOTnFqNVdnd1ZRMXNzM01JYmtnRXly?=
 =?utf-8?B?VWpxeFUwUDlNdmdZMU9QYzB4NlNLUkdtQU1yNTNVQXMwVm4yNlpMVVF0MlZG?=
 =?utf-8?B?N3lndFpwcW9LL1hpNGd3NTdJSDJJTHgrZjZKOVZGNm1ZYnV5ckJJM202NEll?=
 =?utf-8?B?Y3h6b3hndjF6TlJzbGVaQ3p2K1Vvd2tKVDNzZHZaNG1lUFByRHlUR0VReTBv?=
 =?utf-8?B?UG0yeTRFMW5Bc1Bsa0VCRU1EVndycmozdC9Yc2s5dVR5NnFXWVpjK0k5UEo5?=
 =?utf-8?B?L0xSNXgzM3hwajZiV05vd0Z1UUc2TnNVaCtySmV5dWxlTmQrelVZejV0U1FR?=
 =?utf-8?B?aGJUZGRSV3ZNREF1SHRKejZSZWI2V3UzdGhEb2NPRERaWjk0RGxLUzhGbnAy?=
 =?utf-8?B?eFFxb09TbHdUbzFEWVNFakpJakcxTG40SkxVSnZhdCtjQzJqWERhVUtOODNi?=
 =?utf-8?B?am03T2ZjQlFXN1ZISXZKTVFOUHB1VkhnQ3FwK0FDU1ZUS0NrdUdpSlAySGFI?=
 =?utf-8?B?bnJDUWJxbThzQjBoT1hDbHdRdnJxeFM4OUk1aDBOTitQR3dUTlp5bEN5WE14?=
 =?utf-8?B?bWViaktzL2g1SGZuajV2SWJkZUxldEthOUNacHZJV2wrNlhJOG1qNDFPN3pZ?=
 =?utf-8?B?REZWWmZZMXFadFlGNm9RcHF0aXBjbVRoOHVQOFFndDdJR3I2dTFEMTR6NER2?=
 =?utf-8?B?Ny9xV21TTEdqNkxoaVpmQU5FeloxdEdrTGw5ZytoajFOSWxmcWNhbUZlZEdp?=
 =?utf-8?B?UVZQSFZDSkRMNlZiMmYzaXcwcmYyRVRaQU0rZllmeHgrS2RQRDFtcFZUTDVH?=
 =?utf-8?B?N2MxYXI0blVLUU9MUkpjQXVTdUZiTitaSXdRYlJFZ1ZIS3BQOUpRTnZ3OU5a?=
 =?utf-8?B?Uklpc1ZUNktIM2habmpmY041RDg0eGNsdUtkMUhlMEc5VGtvbkVNblM2bVpZ?=
 =?utf-8?B?OEFMcUd1ZGpKMVB3SWpPYm1BVHdJMDFLSXVvQ05LZEkxWmY0cm1ZUGxDOXpr?=
 =?utf-8?B?VVdtbW5rTW4rTHBqd0JrWFpNeDJid1NiS2JzcEFMYXVUN1dkQ1pWWEY4NE92?=
 =?utf-8?B?dGZtYVJaY0IzUldvc3hyM0tnYmFnTEdOaXNqTmE1NitrNUJkSUhUSnlaMmpw?=
 =?utf-8?B?LzBBRXpYZjM2ejlEdTUreVR2R0FQKy9iazlzNnF2NzVzMWozdU9rdGVrTWdQ?=
 =?utf-8?B?RGNEa1JvNXFxQWVESW1UMHBEMURXRmlaVWNxbWIyZ1dPbXcyQ2w5R3BjbmdH?=
 =?utf-8?B?S3hnSGN5ZnNKcHlEV1phQ3JuRHhpL1o0ZTk1SlVXME1Hell6MTZ0Wk0wa1FR?=
 =?utf-8?B?a1p2UFNXV3VEdGJsaVdNTGtmbTRVM3JQc0xOKzlLc0tOQXBmT1FFMXRPeUNZ?=
 =?utf-8?B?Y0NCOEU3WHFhSktvajF1QWU1OHRoTkR4VHhEQ3lEYzR0Smgwa2Zvcy96RzEv?=
 =?utf-8?B?UzdPNkEra01LUkNoN0plekhDT21QY0tDQU9zbE5XUkhIQ2JucUI4dnQ2eWpV?=
 =?utf-8?Q?B26AJM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0ZHeHdEWDJRdUhkTm56VTRIMnZiM3htMlBjT1dEcS8rRWl2WkZPaHY4Snpv?=
 =?utf-8?B?WVFCRHRqVGpyT2lWU0hucjkvT1VkVTR6WUcwM2JDQXp1TlhYbzA5Wmx3bEwv?=
 =?utf-8?B?ZTcwRTdCN0grNnE3d1dscUFPZ0VPb1U0R3JQcThJZEZraENVc2NvNFA0SFov?=
 =?utf-8?B?MnJyUTVraTdoZGsrN2R4NnVTV1VTTStDS3ljQmxJTVYxRFExUEgrMmV0eUl5?=
 =?utf-8?B?TlZ3am4xNjRtOElQUm1Tc1JXRUZBU2VVS1JNeW5LeTFJcXBSZmdBVzZRL1Fw?=
 =?utf-8?B?cDlTZGVLT3hnalhac25LTDloNjhXUXRER0EwVmY5SjdMYXYrWFZFOWk1eHVt?=
 =?utf-8?B?SmdFakZGcXU1NzFoVHBndmxpWlp2VzdqbW54UkxXbkdhM0FXRjZZdkNFUG41?=
 =?utf-8?B?bVExOHBWTTdCVFpsK3hMN0hTdG16ZDdYWXVaZWd5SzlKNDl3N1pQL3psV3Vk?=
 =?utf-8?B?K0F5Rm1yMlhEZDVrQ1FOWndWc1NteXVxMi9FZEpNYlNZK2FFSGQxT3Z3ck42?=
 =?utf-8?B?Q1F1ZVlrRTFNdlVPRDlTNU9ObTdoMXY4ZDhhY1lZUStkZzZaNEpTYnFkeklt?=
 =?utf-8?B?T1NUSXpaVElPS0FHV2VuL0k0QklrU21lbjNjeDEwWHlqYjFTYzYxRkJvaVRC?=
 =?utf-8?B?SjVTbVk0U1gxSUFtOHRMMStaeWNad29FR3ZLSWNxcGIwcVljR0FsdkVuSjFi?=
 =?utf-8?B?ZFFlVURQQkVoVXh2ZnZRRERzMWtiZDlveEdlbGV2QmdlQmdsdllpRExqR2hO?=
 =?utf-8?B?SzFZc1lsWDZZTVpmWWw0c1pURXlZc1dXek9IYS9leXh4Y25wUjE5UWhLSnFj?=
 =?utf-8?B?MWlZb1pHOFFpcllDL2JnSUlXbk9LNWdVSXIwanBrWkJsbTZjOUR0NWgxdGgy?=
 =?utf-8?B?SUxYRGJ0aHRLeWZodmpLaGJtd1E2QWw2SkhaUVNYbHRrS3RoMTFES05RNnht?=
 =?utf-8?B?TjBRV2Z1ZTlFaUczNVNJajVqU2ZnR2xXMElCUTg3LzUzMm1GQyt2NW00eTky?=
 =?utf-8?B?d0pXZ2RLRHdsZHBxUXJlcTRMalpadUtyM2JpQUhTcm9hNitWb2pobGxFdW83?=
 =?utf-8?B?TjZqaFVYNGZ2UEdIUFltVVJmV0FsdDFyb05na2p3cFdUU0NxNnVDSUo2YzFN?=
 =?utf-8?B?ak43V0RpS0lrWFpxeCtqQUpmZ3BoMVBMRE1BQXhWaG9LQmpYTVpoZG1mNnRD?=
 =?utf-8?B?b3pGYW5DVVp0KzRTOUR1WnFzaFYzYXpVMXJ6Uy9VdjFqVmp0S2hzZmR6VFFx?=
 =?utf-8?B?ZTJiaEJTMzlvVEY3WGJnRGtRNEl6SXRYU1drejVvREt1SC9UalVjdGV0dzVm?=
 =?utf-8?B?NFBpbTdkQWZIVnZXOVJuTXdQRVcrTjFRZVdWK0h4MUhveEY1anJsbnRWNzdR?=
 =?utf-8?B?ejRBMWlOWjd5SUY4SExKcDBWNys2MGcxYWYxbjBwajVNSzFXaHdLSGlBQzE5?=
 =?utf-8?B?bXdKOXh3RjRsYld5WWVKNVliZ1dqTU1qak1BSC9GR0NpRjM5RlpoRVlacVBJ?=
 =?utf-8?B?TDVGYmlTbjVmK3FmQ3pCRjZFVU81a3RHOU95QlJNMlpHcVpqVE56ZlhTa0hK?=
 =?utf-8?B?aFhWR0syZDVpM2VsdTd4QkNVWGJhK3pFa0hobmM3Q0FRM0gxdmkzR3hyTmZo?=
 =?utf-8?B?UzVkSnpGbE1QdDlQQ092cVhYMWdZY3k0VllXTnFwWEY4MnZlRmZyOVE3amZ2?=
 =?utf-8?B?S3Y1dlhZUUsycEM4a2lLZnJiVnVBcUVlWm1NZlNpRzA4Z2lIR2ZMUmM1RDhk?=
 =?utf-8?B?N25qNVFheTRJKzlhZUNuMEtvY3psTzZaMjg5dmhiMlZQbWsxdXJDMGdGQ2tT?=
 =?utf-8?B?ekVNYjlVQmZrcTAwbE1oeHFaclF0U0luMURpbElmejY3dmcydlIxc0ZMVDBa?=
 =?utf-8?Q?QWF7U1vO+ccjA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5258c0-5f24-4abf-f962-08de9a39b34d
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:22:54.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME6PR01MB10662
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miaoxie@huawei.com,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linuxfoundation.org];
	FORGED_SENDER(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3297-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,outlook.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 78E1A3FBB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_readdir() validates de[0].nameoff before calling
erofs_fill_dentries(), but subsequent dirents are used without
validation. The loop computes `maxsize - nameoff` as an unsigned int
to bound strnlen().

If a crafted EROFS image has a dirent with nameoff >= maxsize, the
subtraction underflows, causing strnlen() to read past the block
buffer.

Fix by validating each entry's nameoff at the top of the loop: it
must be >= nameoff0 and <= maxsize.

Cc: stable@vger.kernel.org
Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 fs/erofs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..2efa16fa162f 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -19,6 +19,13 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		const char *de_name = (char *)dentry_blk + nameoff;
 		unsigned int de_namelen;
 
+		if (nameoff < nameoff0 || nameoff > maxsize) {
+			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
+				  EROFS_I(dir)->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+
 		/* the last dirent in the block? */
 		if (de + 1 >= end)
 			de_namelen = strnlen(de_name, maxsize - nameoff);

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260414-fixes-ae20cd389f52

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


