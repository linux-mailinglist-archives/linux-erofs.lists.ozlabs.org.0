Return-Path: <linux-erofs+bounces-563-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DCAFD1C7
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 18:39:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc6K81RVmz2xS2;
	Wed,  9 Jul 2025 02:39:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751992796;
	cv=pass; b=E7dLpuPqc8vsHDr95e3ty3s8YhX0anGcDwQ3FdPyFbE2K0okrsrCaHylHGc73PMFOXGjQFVke9y+dmagM8EhFKHTSl7qjMJ9aUBP7S4TTOBWCpQsGGYuy0shrTv1U4l5KOLX0doUEy6jTVlRXnKTWHbLWBBebkeAB+zo9dXM7W6E6uLHyqqguB7uqIqzRSxirerNC7OLcB833XnayU0y8HAXOyRut0KPy4r9NiZrNOqI2jw4K1FISGZZBkzVkBOCRIvoSQB7bhPKQq7IBUDklfi9zKz8+mQsNhL61lrInh1Z38w8P5AkQQs/8uUP/6DZ/idxsNn9S9BY1O3ybmA9KQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751992796; c=relaxed/relaxed;
	bh=fgTDMeQ0so2NULltxhwsiJM76IId+pVWtNFCBzg6Meo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEnXb6q2zQsKk6qZlS5L0pFtly3wmkosFLaCExeMkG6FIHqhvuDiGIBjTPeV/fpD7Sc1/B6JOob/DPCNjldonX/DdcEVkmM+BN5NVv9UwyqdISM7kh47POJnmaP8trMsOzUb/MgzWeVzvk370EUU7KjBtymFbpHk6Z1x8LubK9m/xxoAhXYVaAfPPyZJUOROLaV+Mk4idED+iKlWXcL+1zlivOrBAWQpKrIXrbx12dAOwiZG6lQNrDOVfhU+HgljqZzgTuRTill0U1jp/+6dfIFVeJIwizI4PhPggrglK9R+FkpRJBeA2OB4E9UKwO7hVerigytqw9GcEcSY5IGfjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ntaB8MgU; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ntaB8MgU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc6K46H7Cz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 02:39:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS/AT77YGBxHBJVQRJc2FT+HFQPFegaxFsI4WMCCzECkcHPjjIRnpDSg/r0USjEc4AJ4r7O666XdQZFXtvTDGaUQPXIOhxw7tmp70/+/UA9GVRuSkdtoSPSDwO8MOXPdrC+c/lPdynWV6cd9HzSl+rLyNu+mw8Jy39GMnZrAsKazeZ31tk4zE8DMg7d/QX9/eLTx+JMx+oGyYcP+JRlZs1VEyEKyFbB8SPCJ5ecHtt8BpwVs+a7vuzGmHH7fTNQNLNJIQ7XPCSiWiaabDBvGfmBgp6uacNGKHV+PnRPe4QWJ2O/EYEmxL4IinYFdsQD9vXuEan6B4vQF1zZ/hkATQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgTDMeQ0so2NULltxhwsiJM76IId+pVWtNFCBzg6Meo=;
 b=OgFD6PpNQGhp1UKdgIoC1lXTuhWr1NwbjdMc8BBnvwOMHW3AF9w7btTAPqNGSAt+kyMrK0DBUG/+0xFt49DWtCaah2qVh7O6sIaIxT9r1V8WqBkvEmfGt7pYkm9K4IM2KsajjdxbUgv142TBLYmbR+rOX72Bp3eRxAcSEPlP0cBbLlhbrhqYiqS7MwhqAqzEdJr5Wdm2Y8jCrPpzc2EQR4QEflFX0wXPGmJCGvRs8yEphtVSKoAXOPSLJwA0F7O5ZP8JvGt7oC14tmDwNYnThhINrGZECAQ4UBRL0C56DVb1WdlwwTy3p0jU5vfOa+J3bezSgCbb7powZppVjxTLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgTDMeQ0so2NULltxhwsiJM76IId+pVWtNFCBzg6Meo=;
 b=ntaB8MgUvq391h1W8oAnY6V3ypGlINgi6Y/+RF1LwbzsWnnz2nchYKrfy7DRxuhCJ3E9999fNccr79+S074ICLvBLREG6Z96e3dkaN4U/vTuuHVTcWcO8HwhCa/KtACtMRAP9FqoR+cESLNlFeZzRutQPihkUBdMR56TIVFxaIlLHjh0gV1AucszzBAzeHPu74ELUTOF+CtjYZtPYk+1TzCzpPXPXT2/RqsvPnFLcjCxyoiEuoq5ORuihquXyvtwlQ15ygxc4XB5SHNd5ihrQXzDXfX0jHsbz1PeafrxZ1IX/gekYYa/D8/fEFhu6+tSdOTiMXKWlXszyZhHkKnn4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 16:39:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 16:39:24 +0000
Message-ID: <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
Date: Tue, 8 Jul 2025 18:39:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
 <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3518:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f263dc-3ab8-4472-a1c0-08ddbe3dff34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXBOdTRjWnMzQlNLWXB1b2NoMkpYVm50ZXVla3JtdkhrRGZsb3lPSHNRRk1o?=
 =?utf-8?B?VE5ETlVNS3ZRcDRyMTNrVzk3MTBXOHc0TXEyR0wwMHI3dTM0WjloQjh0VzEx?=
 =?utf-8?B?OHNVV3FjTVA0dlU5eFFBZEs3QWhMd3ZUOW1zVi9PVVhqTFVyN0JJVFNsOC9u?=
 =?utf-8?B?cVhXN1BDdldEdFMwNkNrdksrcG9vbm9GeU8zWDk1QkRpV3VmVnRtWVdDSnZs?=
 =?utf-8?B?R2tnd1pMN1BkdWowcjU5eDBnUlhWNjBmdlp4YjdxOGt2a3JhbUNhczk3Q21I?=
 =?utf-8?B?Qlp3ckpqWU5ONDFPTVBWSVZwbTFiYTY2WFRBVTlpaU1tKzdNK1ppMUZPZk9Z?=
 =?utf-8?B?UkRJR0xwVkF6Zjc0aDl5R28yUEo3Rk45eDhhWm5zdThSdnhieks5RG1RTlUx?=
 =?utf-8?B?TEJQL0EwZklJaTJPSU1zYkNQVFIzMEtnNWU1eHZTRzdOOXVxc0NHOHhBVVJx?=
 =?utf-8?B?REd0VEY1Y0FvRFliWC9KT09jUDRYcmZqU0g2ZCtwMzZ4bUhNTEwzS2dDVjNr?=
 =?utf-8?B?THcxYmVhc0p6b3V6cDl2a01DbVQwa1FCazhGczljNzhmS3QzUzZ6eHgvN2Vn?=
 =?utf-8?B?akZSTnVtRm1MNitkTTdWam50Q04zanNHK3czcjBQZWZINGEraHJVSFJXT3l2?=
 =?utf-8?B?UnRKa0FDbzh1d0tvR1J1RzUrSkJSeEc2a0NtSG1iVWFjaUZTOWk5L2J0VzRZ?=
 =?utf-8?B?WVZCcFlKZWlDYURkUzdKOC9xb1dZUWNkaytiVWV3c0JIdTUrOU5zOXFFc0Ev?=
 =?utf-8?B?ZnlDYXNKM0Q0VVI0bm5HaEgwRGtvWjM3cnA5NTFjOXVzaWJ0Q3FPdTZlR2ls?=
 =?utf-8?B?SWRyNFpzV1VXWmhQZ0JjL1ZWNXBOc08zcHoyR2tqdm1lRU52WWk4LzQ0THRI?=
 =?utf-8?B?b3haWmxBVWV3VEV0VmhWek1SRDlSWjIyZUpLaXplVkFua3lWbkJ2ZEtFa0hD?=
 =?utf-8?B?dFpWcUJFRXl0Qzg5eldra1dlU3NuNzBaNUQ4WXc5by9HeEoxZytkUDNBTnhR?=
 =?utf-8?B?VVlGVS80bnNkVnM3U1NLNy9ra2cvc3J5WDNNeTF3TmxrSzRwSUQzMURQUDg3?=
 =?utf-8?B?b2F6dkpRdWRXelZid05WTnF3NE1vL2JYZGpvVnpoYXBESVUzNm9yWkEweEpQ?=
 =?utf-8?B?a2R4dG9jYmpiSzQwa2RuUmFKLzhrMFpZV09rSkRIREVYVERjWW9xN3IzWUFW?=
 =?utf-8?B?U2VNV25LdkVHRVhMbk5ub2NZbzNQcFpVWTBIRU1YWTNHRHppaXY3cStqUkQ0?=
 =?utf-8?B?OC9KNzl6N0MvaGVWT1NSanB1VnhyUzdGb3NseE9JR3BzMlBpQS80d1lqeGpk?=
 =?utf-8?B?dW5JRHJab0VmS0hMb1NjLzhKTGJBZ1dxK2pjMDFXNUhxdENVVm8zUGQyVWVW?=
 =?utf-8?B?eXNUN1R5b3ZubTFNZ2taRmxNWk05RC94NDhaVHpQWW42VUpRSGF0NGJsM0kx?=
 =?utf-8?B?bUVacHVwRzFpNklZMUs4WW0yQWZoQ05oaTlUdUp1eG9OeTN0N0NKUlZ5MkpU?=
 =?utf-8?B?UENzeVB6YzUyYWphSFFSMzFBWGs1b0dKWWFoNmlFRXVnSncxZHRVenpGVE9K?=
 =?utf-8?B?U2xSMjZtMm4raWlTTHNlMENncVVqVGxGbXE3Njc0QndleHFzbDJaaGhFMita?=
 =?utf-8?B?NC9ta0lsYUZETlZDcWM3VXZCSGpMMGdsL3IvVmN3MHgwaGVBdG1YZngrN2pw?=
 =?utf-8?B?UDdJYTBEOWpCNjBzaFMycDBudEt5c0E5UUhuVDBWaEk2RTREZGZSQlFZMG1R?=
 =?utf-8?B?VGsyVHlBTjFjTnI0VTBzRFVDMXhoNU12MXdmZjJ1R3FiYWo4NGhESUd2Qk5s?=
 =?utf-8?B?S1pzbkFPSENuK1M3cjRISndnMmtrcFFGNWMwc0oxVDBnYnpRV1RPLzE3ZTBt?=
 =?utf-8?B?WXdSSEM1Q1dSNXdOemEvM0pDMTBROUpYc25pOUcwZm1GZ1JmaFY4R0did1Ro?=
 =?utf-8?Q?rq/eUYCne8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NxR2FEUmpxbU1iRllrMEFkTUJSUU1zZTU0V2Vpb3FacHlZKzNWUWxpcEtR?=
 =?utf-8?B?UmZLT3dNZWZFMjFvQmNtV0pFVU1vM3FLNEwwVThkMGNnWmhzWkFXdFFjTzVM?=
 =?utf-8?B?MC8vQ3ZpMThOd2hZUHF6T1ZpZ1J3SUJFdzFNbEQxVGdycWZtakZCNDhHQXEy?=
 =?utf-8?B?T3lFaU9qZlFBNFRPWlBhdkdLOGRjUUNnNE05empXbGpLcXRLV3pyZ0pVMUJh?=
 =?utf-8?B?WFg0SWk3RTBHclhNcHczdE9GSGc4NHlJWHFqRjBUYk8zMmVqbzNuOFJvVnZO?=
 =?utf-8?B?SFF5dTREU29oVUJRcGtQYkZaWVJWSVNMZmFMWm5kZWdtRS96dCtsZXBzSDJG?=
 =?utf-8?B?ZDRobmFRRG93T3Q2enlkQXhuRHpxUXRucnpob3VpN0YzMUFhV2lqOW16Rmxj?=
 =?utf-8?B?RFVYcmdwcFRDT216cXFocWNOS3kyZ1FYVHFlQmQycWZVaFZXaC80bUdVMEc3?=
 =?utf-8?B?OFRNbW1VRDMydGNZYmNCUzhKZDJhY09Rd3U3VWxEVXh0RUIrZHpsSVFHTXlq?=
 =?utf-8?B?aW1uenZzTnptTFVlUUpSa1UzUjB2cGdoRVQvZjJMTG5oYnB1K3RrVHJ5bXk3?=
 =?utf-8?B?WE9UMVN0elB1VCtxMkFVc1lpOUhTK25kazUxWHlsOE00UENFNzg3ditiUy9x?=
 =?utf-8?B?dXU3SjZuUm1URGtlaHJ4eG5NZHZmUHFwVnFwVmc3SnMwQWNEOVIwYnJVQkM3?=
 =?utf-8?B?VUYxTWpIOENKZHZLUWlEMEROcWhUQW5BK0FZR3ZyYjFQUDlFN1k3c0xzSHlw?=
 =?utf-8?B?U2FWWkdNMEJYYnNRSjdlUnpHR1BJWTQ3RzV3M1hBaERPREtyNDcvUGtJMURB?=
 =?utf-8?B?anNvYk5oUkpVK3VKY2p6TkVUa3o3azJMcmw1NXovVHJ5bHlsZyt6WE0wc0RN?=
 =?utf-8?B?WTRGSVJhSUVLUDdkT2VhMXhDdVc2UEpyUlhUTXRtNHVTYnJkbFpqTDU3ZWhE?=
 =?utf-8?B?KzVpNTZjd252TmZKQ1h0QmlIdlBTTXlmMnJvS0hxSk4xbkYyZ0VIcHU1US9Q?=
 =?utf-8?B?ZEI3NUVPWUd3NjF2Y3BtUXY5aXcyNXAzc3ZCenpSRFFHQ1NWcWFwSWlTSEs0?=
 =?utf-8?B?NVpuQmZEaE90bVFzOFZqblMzeUF5bWRVYU9CWXlIOFRYZk5nL25WWktsbmgv?=
 =?utf-8?B?MEplYUJXNmpjNW14NjlPdWRRREhkL0h2MnIvMlJtZE5xZFVlU01JbzJGL3VB?=
 =?utf-8?B?WFJzbG1mWDBJUnNycm41M05qTDhkKzhzN1NKOFRJNmVlTGsrbVBUa1YxWTRE?=
 =?utf-8?B?clZCNDlpSS9INExTRUo3Q09uc09TZnkzcG9YTk0vWDZGdkpscC9jZUdraXk0?=
 =?utf-8?B?KzlWeVBvZmY0bUptUHpCdzhWM3hhaGRHZVhESFBQWlpPbjVidWNtYmU2Q09Q?=
 =?utf-8?B?WmptWWk2aUxteDZyKzRMb05GRklsRkNpQnZLYTZIV09PYlJ6ZVg1dlo5R2tY?=
 =?utf-8?B?S1JWdmEyajFyQ0VlQmhUOXRPUWRvRzJ2WmhUWmlNOVY1RlNFeDdTSnlMNldE?=
 =?utf-8?B?UGxZRldEdCtLbFpSb2pwQzN0YnY5M3FIT0dRMDc1M05zQXplTEt4djR6elNn?=
 =?utf-8?B?c3RDcW1BRXdOdkZFZHRubnNxZDdiZERUbE9NeFNQY29QWExDTnhUS2hya2lH?=
 =?utf-8?B?ZUYraVBra2Voc3Y1T2dXeFdndTZhc0pqeUtsNUNqaWJjYVMyWkpUWmptdDM1?=
 =?utf-8?B?RUJwSzd4M1ZkL0RtSXNOY3hLbG5nMjNxc2ttVERFYkR6Y1ltaUZvNHA2Um1y?=
 =?utf-8?B?cUNvQ1FTMGVleDk5NTNqM1ErODNncXNQSWROQ0kzUmJ4N2xMRlNmT1gwZUZr?=
 =?utf-8?B?aVk0NnVIWXN3UUlKWElRY3AvRWR4NEdNVnJyMXIrNDlEZ2F4QmY5QkdqaTMz?=
 =?utf-8?B?cGNCWEdjM3VIMkdFc3BjN1JVcEt6dUN5UE56cW45U2RNT3poKzZCM1dPUkdK?=
 =?utf-8?B?VSt1eEt0T0IyWjdabUlxa09oRnpsS2ZKWWt4cFhvSks2Qm9mUmR2QUFodEoy?=
 =?utf-8?B?Z0djY1J0cWRLWWZ3ajdxL1pxVkhlVTRveWVpeEhwZ29kLzlyMldFS2diZjBX?=
 =?utf-8?B?Z284YU9qblBjQlIrMWZseHBDdEdmMDRnYlEzcTZsQUlpTEswU290VWkvOVFO?=
 =?utf-8?Q?y3MaNuyuvejy53iqXXp9hzI4f?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f263dc-3ab8-4472-a1c0-08ddbe3dff34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 16:39:24.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2jzkI2L+yUL4xqXg0n7NQ4NkW7WUoK0cO6KlDprHr/1frRrvitxulMddrg3ly++GTk4r0DIguEDTZSLaxS8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3518
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 08.07.25 17:57, Gao Xiang wrote:
> 
> 
> On 2025/7/8 23:36, Gao Xiang wrote:
>>
>>
>> On 2025/7/8 23:32, Gao Xiang wrote:
>>>
>>>
>>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> for some days, I'm trying to understand if we have an integration
>>>>>>> issue
>>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>>> parameters, it rather looks like the latter:
>>>>>>>
>>>>>>> $ ls -l erofs-dir/
>>>>>>> total 132
>>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>>> (from Debian bookworm)
>>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm
>>>>>>> 1.5)
>>>>>>> Build completed.
>>>>>>> ------
>>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>>> Filesystem total inodes: 2
>>>>>>> Filesystem total metadata blocks: 1
>>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>>
>>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then
>>>>>>> running
>>>>>>>
>>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>>> # /mnt/dash
>>>>>>> Segmentation fault
>>
>> Two extra quick questions:
>>   - If the segfault happens, then if you run /mnt/dash again, does
>>     segfault still happen?
>>
>>   - If the /mnt/dash segfault happens, then if you run
>>       cat /mnt/dash > /dev/null
>>       /mnt/dash
>>     does segfault still happen?
> 
> Oh, sorry I didn't read the full hints, could you check if
> the following patch resolve the issue (space-damaged)?
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6a329c329f43..701490b3ef7d 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int
> err)
>         if (v & ~EROFS_ONLINEFOLIO_EIO)
>                 return;
>         folio->private = 0;
> +       flush_dcache_folio(folio);
>         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>  }
> 

Yeah, indeed that seem to have helped with the minimal test. Will do the
full scenario test (complete rootfs) next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

