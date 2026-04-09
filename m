Return-Path: <linux-erofs+bounces-3230-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA6YIJdO12mvMQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3230-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 09:00:39 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFA3C6C9C
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 09:00:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frrRd3Q3yz2ySj;
	Thu, 09 Apr 2026 17:00:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40d::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775718029;
	cv=pass; b=HS0DK8wD7zpILd/GLFJdRBwROMv4s1RQiwIBG6MtQFPkm244YjZ7jhu8PbSzXN1nsh4/gOJ3YJEIJrUj+sR+jV7ZPS4vbZZ7Tc2GO/HglSxpsAqZTdHgF2FPDKsjRPfrQiWSY5rs/Pv4gVAD42gUr7wf0qFG4hpwvTq5DitrBT7y1sZFQjKUDu6um6J9hccn95Nw8pvwvaZJQdRuUT+BKO8EBohx7FYa+Lk7bt0YmZu3wzvsX5XyQ+rkHq909W/I0Gh3d2RQf2/SNkQWzlxVQmL1b0LGfI8ArJ790eulHNpoF3hOPZR33b8kBL5xEqeT30UelW0tLpKB99wxFzl0pg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775718029; c=relaxed/relaxed;
	bh=u0A90H3PNiZygE2kCrjwLqfHQ9O9Y60djh3tubzFnLU=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=jdg9M0xGcH6+J37yskMBttlxxlaud4jeSVJs2dEFlgrRqHbIJClrG7l9d4UonKQanSmyDh1kR8zXy1iYXYUW6CJ+YK2Tqt47xRAAINq45Pkdl0xlIn9Cd7Q/sfsrmTPjglx5TEvjPttR9eyRam98aBd0IRmFBM48qNLnvSttQX9zHDa3NHNQwnsrh6q/SmqyPWF+F5b9VQ4wPGXNLBD1pFwbmXrejWzhDasTdWkj57Z2P0nF1XVi/gE0WkztDC3AsP+gWBrYBrMdQ6RkXDrlM+3EmAg7xY7bU+VSMQRzC4QRDBFD2FFyOd2BqtZ/qMFf7OLHtAtNNgBy9tzcPCugFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FpL6Q2GO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FpL6Q2GO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40d::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frrRc3BsXz2xTh
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 17:00:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9n7h9p3RNA6DuTlr70eW3bb6cilX2BnAzsCrExCbJaRoakW0fGrPCNs5mgHOd0IhN/p6ocrUAHeen9jrh5Sp+IPVxUx9PHmqeBfzXJDNnDmSE8/O8kLlWxyg62WWYOvCf8dNmktfhN7BpClFSinZ4pammkooooyOc8KuYFbESev+XUmm6GpDB/mTY7CSiUypKVS2+QMGVO90UujWudoI/BSzrE2dmv+bxB0a5pW9A3+rA258hh4dMZj5yvkej9rFUO4+b668y/4boRsR1y263APANLejfGYeo1TgzditC9I1DzwgOA2H7AM0DvlR0TvZhEiOommaUL7T1m28gfjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0A90H3PNiZygE2kCrjwLqfHQ9O9Y60djh3tubzFnLU=;
 b=FjeHZY7bp/Qoav8zYBwg62hr8FDGeUahUVacvGa0h9AjmGFBUHglYPr1OCVS7/BRHe1lSr7tCXt4XH0ggqat+848B9/ZumJeZ8/c+4Y4LLS6BlyF1HUquyTu0KSzH9RXuCR0oYqnkqFCAikfZi70IgcIirjRPGUgoQrpOKojC/EOuKwrgcWgH4TbWJoDebCfR9ckz05hjMpFHWSx2IOSZudqTNrC3dEjzV2LEsFGm3mGj/GK/wTvfoNiPAnlu2nQCQQ0NHjzmZ5Zv+J9HuGB2lB/FeqzssHX1G3eYUnd+5zyrvXMxT15FnGYYsw4FUpXRgZTC7u89lyGXszadBaztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0A90H3PNiZygE2kCrjwLqfHQ9O9Y60djh3tubzFnLU=;
 b=FpL6Q2GOEwgTqbUARrN4YRP6SAAjRjVPxf0X3W8M5sMnESpOB9rI3Z5oZ8FoO0CMs2tyZ/vnxE2SUsT1zN/GqxJkNME5QV6vpfDasaWYsreYrNuXpjV7d3sqn243pYY3uljJlA4+SUqI/uv3MHTKprURuBhL92oS9o89XSj79WLRzJt5VPiOS9FcXnb7VLT3dnRa3kG4Y0My2ZSuy9x5pJKJ8iKHY1u8k3aTDprHVdvQYuHnwODOQ5qCUpjmVTJUA/Oq/Y8nLibRiZDnmgmR3n87ahdS/dDjn5YusWJZAC4CLHIpO6bnwluaw77VCmqSmQ7BqdnW2z+QWG+XIfp5+Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6349.ausprd01.prod.outlook.com (2603:10c6:10:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 07:00:03 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 07:00:03 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 09 Apr 2026 14:57:31 +0800
Subject: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIANpN12kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3bTMitRiXUsTY4PExDRLU4sUUyWg2oKiVLAEUGl0bG0tAIn2sSx
 XAAAA
X-Change-ID: 20260409-fixes-9430aaf958d5
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=ndXl2p/IZPVU0XXg5XH39mwvEBfcJW+WVc8aHB5iE+s=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzOu+t3acz+yZzaYT9sBgQWDuhta5DJe/b0868mZ9A
 T9feMpxrokdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJG/fYwMm+QYd3UWaJ37
 36tvamx+Pkzz2Nulv4LPse2SOZ9zimtdK8Nf2Z5Dd+U+uR2u4/JbuzMkoCc3/WOevaBT0sIln5j
 m5L3lBwBHsUy8
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260409-fixes-v1-1-d16acabae4a1@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 312534e0-8883-4c00-b4be-08de96059f5d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|461199028|12121999013|19110799012|23021999003|5062599005|6090799003|5072599009|24121999003|22091999003|440099028|3412199025|12091999003|26121999003|40105399003|53005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1R6NjU1cjhFSjB3bldMMld3UUIxeWIyRmNURGhRRVJwVHJzdUt6WXVFbi9P?=
 =?utf-8?B?d1I5MFdoc1k3WDFNQWtPbnZ0LzRZcG05allYZmtYQThPVm94TmZKWHhiMEtr?=
 =?utf-8?B?MkhiNmh1S0hZc096N1U2RjJ3SHd0T0lwNFB5ckN1NTNLVXJRdmtQWjdxY0g5?=
 =?utf-8?B?YWxQK21pMGNnOFZGSk5ZY3pRUTFETGZDbk8zVEN1UFE2VVN2d3FhMTlEUG8r?=
 =?utf-8?B?QlQzQ0hucGZCek5RcHMxdytRVE0rb1VkZ3ZHVmFkSDBoalhUM1lzY2gzY1Zn?=
 =?utf-8?B?UmZCbEFKMTcrUkxIbURJYVoyejBMdGZSUm1xTzY2ZDRvdzV4Wi9tRjJSQnNr?=
 =?utf-8?B?TWViTEJHRmRJVUVjK0tLaHc2eGlELzlVUXRyMHdiUlFzUlRIcEd6alpzWFBD?=
 =?utf-8?B?YWplbDBKMjdVZVUyeUtCdDMxOWRnUVFXQXBNdW5kTVNhM3V5VTgvS0FUcVpv?=
 =?utf-8?B?MHhkemNaWVlaaE52VDdSMEE5bHdHckdXWDgxNXVGRzRxaU5qU3llbFR6Ujdj?=
 =?utf-8?B?UDdhcmhpVW5QcDRhdmR1aFk4cmRudmFpSmljM1IxcVFKZElNOHZWbzZUcG9P?=
 =?utf-8?B?UDh2TG5NeWFaRXJ6eWRxMHcwMWgwalViYUFINXhMcnh4YSt6Y2s0VlN5Q0xD?=
 =?utf-8?B?cUxFem56MXlRaDhtVlRZTHhnVi9zUm4rSmgwbUJJSUR0d281WjNYYUFvT0xH?=
 =?utf-8?B?Q09XU2NESG9EdURVYWVSWDZ5bGJpYkVPK3dZMkc5OTFmNit2ekN2VUYrM2Rk?=
 =?utf-8?B?aE9QYXdjN3l6WTZpWnJHNy8vdFpqWTh5Z2lwV0dBcCtjWUVCakdWTFN6WW5X?=
 =?utf-8?B?cWFCSHdBODFoSTUwb095WkZJZ1M4ZTJaMTlJOXU4VG14S0pRbFcxZlVwWkJ0?=
 =?utf-8?B?NWd2N0Y4REtoTnoyMHppY3FZNE1GWit1bmNDNFdRUTR1ckVvZTdMeC9nV0Jy?=
 =?utf-8?B?aEttUDdkQlk0R202MDRmSERpamFiQ0hiSi94Ui9zZjVZNnNRbDRoMFZWSmVv?=
 =?utf-8?B?RVcxVjRXY1hSRlI3Y1F2SDNTYW5yY0RNRWlmZ3BTOGVYc2pxTFhDMWh3WUc0?=
 =?utf-8?B?Wm1BVWVPOVZ2WnpBRnZkKzN6Tmp1N1V2V1paUkFaQVNKM2Q5THgrMEhjYm05?=
 =?utf-8?B?alRUckVyT1ZvTWdIbkxDSHdpTWtSSXBhQnVGUFFKbkRDK1N5eUhqQmlONnhO?=
 =?utf-8?B?MWhRS3hOU3hDcWpDTHBzck83ZCticnJxMFNWQWZXUXptTENXUkhycWN2QTdS?=
 =?utf-8?B?UzJWblBNRC8rN0FkTUMxeUFTZlN4aVZJTXJnVHpQN1BPU0ZkenJSZm5kRXB3?=
 =?utf-8?B?WWFTd2xIc0g1cmlWYU5BRitLU1ZnWWpWVU11TDAvclZxY1lWdlJGcEsyeExZ?=
 =?utf-8?B?V2pNc2NkdUpqS20wVkVYY1ZIR1lhbWZZS3JhRlE3VHVoelBrSDZWT3N0QjhN?=
 =?utf-8?B?a1RWREM2WU9XK3BaWHh5VVkrZENNcWJNckFtclNVZW1tWDFZU2xuc0xSK3h6?=
 =?utf-8?B?dzAwRndTZFNleCtOVUE0SURucHJrbThvSzZDSlhiZDB0UW0xbjY4dktWbzhr?=
 =?utf-8?B?VGxNQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhTMnNtRktXdzhPUjZ2b3hUZi9EcE9CaUNwMHZYQ0E0VUtCbUFQU0ZLZ1Jw?=
 =?utf-8?B?aUhjTWdwNml4clQxdnhnOGltc3gvaXg2Z05UaFc2QzRKUmNVWTdteUlkTGUz?=
 =?utf-8?B?b2dVWDJYaHFaUWNmSlU2cE1GZmpaTk9OcU9RTlNweEVnUzJEUUJEN2h3UHpJ?=
 =?utf-8?B?ZGh0WVhIanpXbVFrcEtMQW05RzBuSTZvM0d4MFNUdy9xbFdNazhpQnVIaW9i?=
 =?utf-8?B?QUxuZDY0MCs0bU5idXNFdjFnOHlZNngzeXAweHNrRUdLWSs3dFNCeDdjaUNC?=
 =?utf-8?B?M2ZnR09pNlV2VmJOUTRiS2V0WmlNNjNPMjUxdmdrM2VCVEtOd3M4M1VQWHRU?=
 =?utf-8?B?UHBqVTZKRkxxSUdPUWY4amhqMmpxNyt6Q2MwU0NOTXgyekhzdlo3UkRHcFAr?=
 =?utf-8?B?d1h0L0FzelArSmplWVZ0eU1RNklkZ3AvbFYzd1haNTlGMFlSaWNibkk4aTZY?=
 =?utf-8?B?RGs4Q21JZ0tmVm1oSHhvaVVJcVMxaGVxOThsTGhvL3Mya0dYYzRMRVhMeDdy?=
 =?utf-8?B?eExYYjBlRWpYbFVkaDNVOVJZb2lSS1dkaG5oU3FwNUxXc25kNlB2Q2lCejU1?=
 =?utf-8?B?WDdHWXhGdFMxanV2dnNMbi9pTnhLalk4bDlQSzQzMmhSVjZrUEMvbzY5MDNZ?=
 =?utf-8?B?YUpyQ2NmZjhHbEhuUTZYa2xWbW5aeGw3RmxZam1rYTY1L0UwUFFwdHVmWDhH?=
 =?utf-8?B?UzhITVBSWStPTVVPeEptV2UxcWRRS2huUTUvM2RtWTZYNXZZaDRZS0xPeWo4?=
 =?utf-8?B?WjZVTW1SZHk0OG5HSGQzRVZrSmcyWWowUVkrNTAyRmdVVVdKdWlQa3hhN3Fr?=
 =?utf-8?B?VVRhSC82Rmk2NTRJb1c0dmtOUE91U3FlTUV5OVRUVXVQQXYxV3c4cUdiekxn?=
 =?utf-8?B?SmJ0RFVIZ0N1dzBabjRIZlBSWjdqcC9WQVh4b2JqZ1hVOW1lKytFVUJPR05V?=
 =?utf-8?B?M0lMQnVvUWpFejZNaEZwU0x1bGtjVzVYRk01ZTVhOHpWVE1mOHFwemE5bm9h?=
 =?utf-8?B?VkNZNE5GWTIvNkRzMFdUcXBTcG5rOG15dHd3Ry9CclFoL1BzQU1LS1BYSFdw?=
 =?utf-8?B?bVVkaVE5RzJGYUJBYWZsWWpUMjRMWU5UVGdvejBWUnJ6RWcxcjNPTE9ob2wr?=
 =?utf-8?B?MkZvYjBuR09nVzlMUkwrbzFvbVdnRVdnRzJzaFZyeXFXcDZWYUlSd29KTFpR?=
 =?utf-8?B?S25hRjRNeDBVTEQvY0twQmgyRGNZN2g3YWhqTWo2elRqU1ZaOHNYUEZ1amhW?=
 =?utf-8?B?ZEM4UDhTL3AyQ3FlWVMvRFFRVmRSYk1FQ3NTRHNIczJ2Wk9kS2d2MklMeWNm?=
 =?utf-8?B?NHRoSldWUS8zUUZNT0ZNWXpWZWFNME16bnlHTk43amdDZmNVVFBkeTRsbXFx?=
 =?utf-8?B?VXd0THVuOTRmOHRJc01DWDdWeFlNS25GbXZFZ1lDZ09OSWE4NE4xZ28za2xP?=
 =?utf-8?B?N0QrRGZ0bXMrRzVoN29FQVgyN1dWUDhKdTl0bG5xYzVJRmFzM0ZYZExzVnVu?=
 =?utf-8?B?MzFUNWVKQTI3YUhlREp1QW10L1BGS0ZMOWZEWDA3bmdtM0VNQkx2K1h6MG1w?=
 =?utf-8?B?ZWtIcS9aTWVLTU5KNVBBcGo3eFJ1RjhMOXNPZ1Z4NlVjRU1PQ0RHcHFWcXNK?=
 =?utf-8?B?ZE81T08yaENmZHBWcEJsOGswSThiWjBNU2VnNWpOdmVoZ01ISUdXaDBadlpt?=
 =?utf-8?B?cDRWSG5QeklzMnZ3T1RpU1FkK21RTGlLbVoybjRYcjFHOUFDQ0txZEdWZDk4?=
 =?utf-8?B?SFFMaWxiUDR5b2JSYkFMa25pdmpUSmZVK2VYbzZQRENSbzJxaTl4N201Wnps?=
 =?utf-8?B?VzZvc1V5L0YvUFJ1WjkvL0U5OUdveXV5L3c5aVIxRnJzc0JsNlkyKzhOaUpW?=
 =?utf-8?Q?e+C1NV3nHouNB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312534e0-8883-4c00-b4be-08de96059f5d
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:00:03.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6349
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,m:moonafterrain@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	ASN_FAIL(0.00)[117.38.213.112.asn.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,outlook.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3230-lists,linux-erofs=lfdr.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SYBPR01MB7881.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: E0BFA3C6C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In z_erofs_lz4_handle_overlap(), the index expression
"rq->outpages - rq->inpages + i" is computed in unsigned arithmetic.
If outpages < inpages, the subtraction wraps to a large value and
the subsequent rq->out[] access reads past the decompressed_pages
array.

z_erofs_map_sanity_check() does not enforce m_plen <= m_llen, so a
crafted image declaring m_plen > m_llen can produce outpages < inpages.

The in-place branch is currently unreachable: it requires both
partial_decoding == false and omargin > 0, but these are mutually
exclusive. partial_decoding == false requires pcl->length == m_llen,
which in turn requires (offset + end == m_la + m_llen) where
offset + end is page-aligned from folio boundaries. This forces
m_la + m_llen to be page-aligned, making oend page-aligned and
omargin zero.

Nonetheless, guard the branch with an explicit outpages >= inpages
check so the underflow cannot occur if future changes break this
alignment invariant.

Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 fs/erofs/decompressor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3c54e95964c9..2b065f8c3f71 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -145,6 +145,7 @@ static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
 	oend = rq->pageofs_out + rq->outputsize;
 	omargin = PAGE_ALIGN(oend) - oend;
 	if (!rq->partial_decoding && may_inplace &&
+	    rq->outpages >= rq->inpages &&
 	    omargin >= LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize)) {
 		for (i = 0; i < rq->inpages; ++i)
 			if (rq->out[rq->outpages - rq->inpages + i] !=

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260409-fixes-9430aaf958d5

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


