Return-Path: <linux-erofs+bounces-559-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6FAFCF0B
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 17:23:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc4cp2KYRz3bkb;
	Wed,  9 Jul 2025 01:23:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751988202;
	cv=pass; b=nPxJyEcqe9oZq1SHuNYoyZPsxTbSQ4UwG3gpGVllcwKzUkjvOlKVOD2RTbT5c+XJXUBEhmFlxSb36ZhCWHj7SExPKDJt3/xmIpRz0mptzH13P2PX/GnqzoE25u/9uixfR/L3oy0TsdJ2uhohIfC5FuaxopiIA4EIP7OcpiGcQRbBuGX3xrgcdKRLAnXL64fFgq1ooFj/6j3ozn2trj6NtC40F2buROrknl40o1oKkij3y+3Lf58TGY3tDviv6OuVlYBlVYPsfbg22VbLhoRoiCwWsfdt/f0/T888MJKBVhgZrchEMzrBWjtFIMz88WIJQoxkCKjoLXrdjFta4+7OKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751988202; c=relaxed/relaxed;
	bh=8TgXro4VLT5bjdFIIgqMOYlNhWc7aBMYWOabYaUKbMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f31JOJYLaTrDLYdiOQkZdEAF1svQpoUowMDOYaCB4OZbWYB8pJYnFDBYGs764zUUcvQnrzH2HXzxkCbBV6t8Q8OiFwkDJZNxSAtCHtIPzimj82+ASyI/Lgk0LPglHxTG2M03jiW/zSRdtjUOLmMqWZLuMb/tmAOEOmrmpf02HNrewMopUs685BG/1wWWs1f2qYODtPtqSFLhIgPyRYllpr4CLM+VBMMY4FRbHPQQh+rZ51Ia1z8BJHJPxmNLq1K5ydtjr+bKxsJEW5PC7oIdUEcEPseAKv4RG6uwnMdFyb9lNzTHQw4vCGWd0ErZ+2Lao7AIOgrcMe3BEYI6qzMp7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dz5KYNsY; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dz5KYNsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc4cl67pkz3bVW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 01:23:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHHDbwrT0mh6cC2YPwtXwaEfHVPsfPl/4km8XV2AZ3WI9SK6YtdKrY8+3qvhY4wfSC1XKxosIW//w+Yx7SAAXzZA3s/h3GwShcnbIfVqDYiwG7ubWjHsX4YrvLBrX+Wly4MVWt6MVc95np4+dRPbCveBvDsDsKcx4qZid2iwghBbW6HgC8XpZET6ZImrHqW3vqf8kMQbO6UIYJV+wguzXXHGaz+l4TQrKzw/cQdeQ3+sW5Ubt0wSeNJ0xK00fwhCVowJEoylnEfK6HDlJHvYtouRXihGQ0HYxFfj81N0m8A/jcJZZas4ICLGtC3UkWNXnHa67H+X49P15nYdxt7Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TgXro4VLT5bjdFIIgqMOYlNhWc7aBMYWOabYaUKbMs=;
 b=JILSAfSXj0vmIN2I4Lub1FKMfqboEsmBFYSIZhG/cfuUx9tSy9LDGbC/pQOOHDqw4cz7jsewm14ym8DC4g270EAXYYn/l69J89P0b96mEIuzSJVL5oUotD/9CQmPk0fssICDs/TYxR1Edtr8J+iysOzvpWzuWYmiE9OP6UI2CCSApfeYcwu7xSZjvvMTWjO3qWpFyHRFDbkBANnotM7AIHhiicyctwTpu6s8dPU7RHMYdKdn4ag4S8fPM3eyKllsOhNzfOXWqtjDWoMlkBMtpPo+5S6WJIm3OifYocwACq/35tkRYfCUhHNmiYTu6Bgfa4X/dKg7MZ4WknJAW2amVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TgXro4VLT5bjdFIIgqMOYlNhWc7aBMYWOabYaUKbMs=;
 b=dz5KYNsYBewWnECTdVlfrl3EHfl7Ee/ku26vmQM5BKyrLVm18NtOw7OEo2DBAByNdhiznipHYewN+vWWYXh4/gObpsFsk8GbIiMqn1I/H8MklufOCLTecz3fm7bF6k2oJCJXH0Yusst4q+Qswow2hHSt6lNVe0NMTHH8KfmBWuyi9kfTZFI2fTHvEwMqh/mCoh+wzOFAeybBvAJMrFBvivNPYRF3vTww3eeACupagtv4QRb2jrOZ8G2saY3gRJBN4b1rd9rIrTuWY1ny8pinqcpoEYCDudCxDEpAMDLRIi6DqxFzWPY79WRLQGrJ4JZ8Zb6ZIroHEtpQB89k2fonmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 15:22:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:22:51 +0000
Message-ID: <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
Date: Tue, 8 Jul 2025 17:22:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: c72c58de-1670-4fa7-6732-08ddbe334d8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEMyTmtFekkxamFtbTZVbEpzdVNIQ2IxbUFxbFIzalFPWHY0dVdQM20xbllI?=
 =?utf-8?B?VkJRTThsVnF4dUY4NXp1Qmh3TXBuN3NpaDVRYituRlcyV25rTXlWLzhzKzJO?=
 =?utf-8?B?QUtBVVdJQW9IK3IvRHE0bEhDU3BSemhOa1EzbmtINkliQ29ObUM5TFByZmNZ?=
 =?utf-8?B?ei84RTRNRlZ5OXQ2WVFvN3MvcWtWaWxGOEwzOWlWeTZQUmt2d2V2dXFhQVhv?=
 =?utf-8?B?YmxGZzZwY0J6bFFwSTJVVldpeEJORy9jVjFsNFVnV01FQ3JMYlo5U1I0VUxh?=
 =?utf-8?B?WDFCN2syVnNqdE9wckZPU21LZzdzYkxnSnhUMFp2L0NFVmtMTUtjalBieVU0?=
 =?utf-8?B?ZmIyOFBDQkwySkN0QVJDMXZ0NE9tYURjai9oTnRKNWtBWnZCYWtsdWsweFVt?=
 =?utf-8?B?djhyTTIxV1hRblF2QWkzMHNvN3VaMkpMTlgzWWxmRklFdFY0eXVBQ0xBTjVq?=
 =?utf-8?B?UGJacUkrTC92MklZZVdlU25QKy9UUW13RDZrZkVORTEwejhURGF0Yjc1ZjNM?=
 =?utf-8?B?c3dvUFlocVlvRjFaOUt0SnFqaEtvNkpzTWx5Q3FvRFNOdDRWK01rNUFBVDRi?=
 =?utf-8?B?RC93dVZvQ3ZMTjA4V2FPL2dFMnB1NE9OT1cyQXFrUHFickJOaGtpY2J3VW1E?=
 =?utf-8?B?MDE5TDlMU2hMb3BtVi9IalFnb0RpYnhSMHN3N2dQOU9TUE56czlDN0FVdlNl?=
 =?utf-8?B?S0FzamJtKy9EdkJ6MitQNDd5SmtyMFZEOVh4UnUwdTFzc1ZaRXRwKzdreVlp?=
 =?utf-8?B?MTczWHBoT3oydkZXcGRsQm41TzAzdkJXUVo0aGlIUUordTdZdkhIRVhqSlZC?=
 =?utf-8?B?VWQ2UFprekdhZlhYTEdJYmMvZVJaSC9pSGFRSXFUWlZZWnE4Sm5EQnJUSWxK?=
 =?utf-8?B?ZFRtTmc3VWN0ZFB4WThlS0FPemp1MEt6TUE2MmY5SS83Z0p6YkExTExIMHU4?=
 =?utf-8?B?Tk5CUGYwQ1pENkdjZk5jZkw0dnAwOE5qcXhiKzRMZ2dhVEJxR1pEUHR2SVdO?=
 =?utf-8?B?VW1WeGk5Nm9teUllcVk3RjFaMDIzSVg1SXlzeGtxeVk2bTFTdTB2MmNFT2Zj?=
 =?utf-8?B?UEhsa25aemU5OCt4V05FcW14ZFpsU284TUFzUEtkRjkyQlUydVZ4cktpVXVB?=
 =?utf-8?B?aWxWRmhTbm1EYXNhUk9IbXN1TWQrNHUyQm51UTNXb2pVb29ZbExlNUhaQ1J2?=
 =?utf-8?B?cklJNkVmWnFzQjVwbFBPSTUxcGllZlRJK1lucllhMTBZYndFdFhGTHRYS2wy?=
 =?utf-8?B?TEU2YzNiTHgrWFQ3WEF6RDR0Zk95eGNxWENLaXBwMFkrSCtKcGRTcGp3ZXdM?=
 =?utf-8?B?dlY4dW1TRDN3RUhPSzhjNDNISWROc0hUUmprSmlhV1BFdXZGREw1VTVVZlly?=
 =?utf-8?B?aWdHa0pwZHpFVmVGcnVFMDJ5MEhFbzFjbVl2SDYzaVRiOXdKdmdQUmdOYk40?=
 =?utf-8?B?amtJZGFITEpuQUNSZlU2RGxwQUJyOEtCdytZQkRpNUF4M3JEVUk0cnFPeVJX?=
 =?utf-8?B?R1VxamVxYXdsY29rbnJ3QzlKY2R2YWVRK3ZkaHAxdzdhdFBDSzRIWmFTU2ZZ?=
 =?utf-8?B?cXFiOU9iNVNMMVlETTRvbHpoSzZHaS9uRmpyQmRDZXFZUFg4ZmE1Yy96ZTc3?=
 =?utf-8?B?SE5JK0xIa2FPTzMxazN0WEo5dEJtdVZGUDdSN1JiN01pUXFKRE9uSmh5Q1Zo?=
 =?utf-8?B?UHlNQUhjeWNkcDdHdkFaNUFuNlJHYUNHTkVqQ2NaamwrRDNRenRzV0xDZnZ4?=
 =?utf-8?B?dGtqUjVmUXovSkY2NmE3UmYvb2U5SmIxTXUwUk1rNWZhaGtjNHNmb0lhZlRn?=
 =?utf-8?B?SXRHNFlLVjlIWHRxMWE4NDQ1NEp3enFueFZ6M1JaNDBhNUhQcGFXOFEzVnp3?=
 =?utf-8?B?WkdKdzB5SXFCNGdZN2lnWDVBaVV3c3EyZVl0bjNyMmdvZmJOR3czMUl2blI3?=
 =?utf-8?Q?JUAs4y6w484=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU9Tdjh2c0J1aG9MQ1hxK1FNemJKdzhmZy9NZG1GRmVvbUtldmUrcEdmZ3d2?=
 =?utf-8?B?Z3ZnK0JEVHpDdzRxOE0rVDQwWEJnczJrR2NabnVEbUxsSUpqdmJJZ1RkdXM0?=
 =?utf-8?B?YjNBcmk1R0tHMURUK2JxN1FIQS9QWnVOMktUalhFS2FNNnRKYmg3SiswQk4y?=
 =?utf-8?B?UjMxdlNqbzVHeE9rd0pZQXpQTWZxZ1NSRmhYWmRzbmozVmZZUlB6WnZPYXlN?=
 =?utf-8?B?cGY0eFFGRmkyV2svMzloT2RnbGR6MlBwZ3BLMmlvY2JnQy9jL2hNeTBaQVBL?=
 =?utf-8?B?TFlzWVROc1dmd1ZPMXFmbTJRMWVyclE4U3BkRG1SZlZXeGFBZHNVSUpLMFlF?=
 =?utf-8?B?Q3lsWFBObllLWkluM0VidytjaUlvR3FzbG9jbThLckV5eW05eWI2VHB6bzRD?=
 =?utf-8?B?RnFyZ2o0ais0VTdjOUd3bG9BRE05aHhBeXk3cUo0S1RQbjlLaERJd0xxZ29r?=
 =?utf-8?B?ZkFzTks5NFFtd0hkeWVPNlEzYXkyM0tlZC8wYnBxRnFYYURNaTNRb1k3amZz?=
 =?utf-8?B?ZVl1c0xQMUFDN29td1pIRTBlSUtWSEZibGVpNk1pV0pTQ3lqUDZaSTRZN3M4?=
 =?utf-8?B?L2wxSlVOcnRWYXNwVTVxMDJ6UkZFdkI1WDJKWm96eFB1SWtVVEU1bWxmWlpN?=
 =?utf-8?B?RktaT3dTMEZuMDVVWXBZUktsbE9aVm1UMEtpNFVGNzEyQUt2cjRIKzNpMVlX?=
 =?utf-8?B?UXh6eTI3TXZNaXJZdVB3KzViZlJqNDBVdk9pczdUMVIxVWNBSTgxdkpHcG52?=
 =?utf-8?B?MDZScFd1WGJpL2lNUk9Zc0RwVnVXYmFPNUtjWDMrL2dEQzNNeUduaHhiUDRQ?=
 =?utf-8?B?Q1Z1Sk1CRW0rQUFwRGxmRDJhanltZ0hKQTBZNXhBN2ZjRTJaRUk0V21adUps?=
 =?utf-8?B?VGViR0lBNSs0ZkJDdVBBMFp2eU10M1BlTGFvM0k2NFdwVFdkSDRRR1owaDRv?=
 =?utf-8?B?K3lPdnI4R1RTckgxcEVkdEpnLzQrZllKcGJrdGNTQVg2RGF4b1dvbE9TU0Fw?=
 =?utf-8?B?dytkVUwrMTdySHlYSm9TdFZ3NDJDcUJBT2Rtc3haMUpGMzduWU1lRW5rQmM4?=
 =?utf-8?B?ZllUNUg3ZTBqU1JUcHM2c2ZPNFNjT2VqTEVteXlVRjZGdHUxWjliWFFYS1JG?=
 =?utf-8?B?UHJIbEdMbVNuMmFIOTVtYzZhSERMYzNyd2xJWjVsODdXbUg4NFZwUjIzbG9P?=
 =?utf-8?B?UjNsdlpxMEg0VEhVUDdnRUxvM3B4ZU1YRzVFY01ZT2hCaytBdmdkMi9xcG1n?=
 =?utf-8?B?NG1HN2lsZ3hqMEY4UzdyU1NIcnRrNlpjVHFuOURpUnZ4MkIxSzhYNUg3RVFY?=
 =?utf-8?B?UTE2Ny9mRjV3NUpCRW9BeEsydzVTby8rb2hPSDEvdFdCN1lhT3hLYXFJMXNl?=
 =?utf-8?B?ai9EZGJwdkVDcThlb0JWMmsyemRHSU1uMUk5UTJhcVlvcUJFN2FjTU4ycXFJ?=
 =?utf-8?B?K3BiWHdWeEVvdUdLUFQ4WDJXdUNhaUNZK1h1d3EycWxLSXNkT282TmJlTUN5?=
 =?utf-8?B?Nk1ybFJFU2xkL05DUHltbnBnZWlwcDFkSFpVUHM0WVJOSFVFS3QwZTEva3B5?=
 =?utf-8?B?UzFBMlgvWDlGZnBHNUQvYS9VV2s5cXdHclJuRmx3SStrL1BIaXM1bkROUi9W?=
 =?utf-8?B?dGU2bWJEcFA3a0s3WmNrQ2QrMUV1WEsvSW5Bb3lvVlBHcTRlckR4ajdGeUNN?=
 =?utf-8?B?aGVOT1o4RTQ5djFDQXdVUWxGSnN5UE9EN2R1STgrVHh0T2ZiWmU4QWpPTSs4?=
 =?utf-8?B?Mm1DZmVZN052czJpSWRwa3hOUGZsMHpkYkw2ZEZJZEFTRUVVeUpJeVZlWXYx?=
 =?utf-8?B?NVA2WnRSMTB2N0xjaTdNeHNNRXMyN1lKMk5qNzlhWVVMd3ZpY3pLZk9DZXR3?=
 =?utf-8?B?djl5S3FuVEJFTHIvcFA0TFI2RHcyaUZldERQR3NRQ1ZrMkdaR2hyUCtVU2Jn?=
 =?utf-8?B?d2t5NUJrWjQxY1pZcWRuOFhncXhGZVJaRUh1NFpPQm9yendhZCtudVRUVVoy?=
 =?utf-8?B?MFV4TUg1aGo1OHRZOGpFYS9vK0ZVT1ZtNEw3UTdrUVZ2SXdzRFpzRi90Q1VR?=
 =?utf-8?B?RUdlZThrSnV5aUJzVEdCMVhKWkNsMjdoZjZsM2dHZUozYWVDamFwMnRpVm1O?=
 =?utf-8?Q?iSbuiapUIIr6y1HezT2q49a+n?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72c58de-1670-4fa7-6732-08ddbe334d8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:22:51.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr6TyWYak3TVEIfs8O/NPenPEy/lVbn2Bg3nrRrUOgdrSWm1M4Ux3uvndPWvOc72qL9mbCsUkZJMKcSeFEu1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9202
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 08.07.25 17:12, Gao Xiang wrote:
> Hi Jan,
> 
> On 2025/7/8 20:43, Jan Kiszka wrote:
>> On 08.07.25 14:41, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> for some days, I'm trying to understand if we have an integration issue
>>> with erofs or rather some upstream bug. After playing with various
>>> parameters, it rather looks like the latter:
>>>
>>> $ ls -l erofs-dir/
>>> total 132
>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>> (from Debian bookworm)
>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>>> Build completed.
>>> ------
>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>> Filesystem total inodes: 2
>>> Filesystem total metadata blocks: 1
>>> Filesystem total deduplicated bytes (of source files): 0
>>>
>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>>
>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>> # /mnt/dash
>>> Segmentation fault
>>>
>>> I once also got this:
>>>
>>> Alignment trap: not handling instruction 2b00 at [<004debc0>]
>>> 8<--- cut here ---
>>> Unhandled fault: alignment exception (0x001) at 0x000004d9
>>> [000004d9] *pgd=00000000
>>> Bus error
>>>
>>> All is fine if I
>>>   - run the command once more
>>>   - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)
>>
>> Forgot to mention: That first dump when done via md5sum or so actually
>> gives the right checksum. So pure reading of the binary is also ok, just
>> trying to load it for execution fails on the first attempt.
> 
> Thanks for your report.  I rarely take care arm32 platform
> because I don't have such setup.
> 
> but could you share a reproducible rootfs image and
> I wonder if qemu could reproduce this?

The image can be generated from isar-cip-core
(https://gitlab.com/cip-project/cip-core/isar-cip-core), bbb image with
swupdate extension and erofs as immutable rootfs. As I wrote, those will
be 6.12 or 6.1 based, but I also injected a mainline kernel into that
with the same result. But all that only helps if you have some
beaglebone black in reach right now.

The same configuration, just for qemuarm as target, unfortunately does
not reproduce the issue.

> 
> Otherwise it's hard for me to debug this issue...

If you tell me how I could do that, I'm happy to instrument and analyze.
I just have no understanding of erofs yet, specifically how reading
files might be different from loading executables.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

