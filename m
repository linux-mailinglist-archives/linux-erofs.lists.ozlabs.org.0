Return-Path: <linux-erofs+bounces-2474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNlJAbZBpmkTNQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:04:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E671E7E11
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:04:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPzdD6qpRz2xpk;
	Tue, 03 Mar 2026 13:04:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772503472;
	cv=pass; b=n3bBuVZOUZnfNcuxzf3KcXlhH32vE13RDClSYWU78wOoldfkfDGFcINiE3bCL8bLvjAei9gbr4Ni8nGSD+AtTCfcliaUsZ0Tf+uwk5l5daOF5mLYFqlW+fqzaLAK5YY8xwTtTc9XvpO6WSt9/dnjGLLjLK0jeKE3PL9D+B9gLEdzzVPgm/WypgNVvQ81R5C0ruTfwg/XGCHzwTXyNGEWvdaZ809YYTBfUEKRflEEk99xRmsoRdIIpmGwbW04Kq/uwm3+fSzj1wi8pG/VG+j95JxU6paIzqj8PX0pWQdbXf93Sk60rH3YxbRvPjKEdtZqFKlW+PS5+OhKDmfZf+5u0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772503472; c=relaxed/relaxed;
	bh=B7AajLuk3jeJMXCjIa4ixRFnwqT3oUT5OFsp1vXNZVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KC3x0DNy/7dmT1c+MjeB7Nh9AjsEvzYsaxeggY0EM2M/tN0NUeg7muR2GSXlp2SwQ4qF+TTaUcP8NoS3bTtdcyYMxKZawCZdL7Sc3upGKFVSddbMGmg+AItrwdAN/buSYi7ZOgzKFdxCRc1t4YVb8hsUFIcKCBtXWRFftntOUg02/P+tLcIscskDI5ln+IxtVVaUFnn0D9YagQxlwpGXfKxJPhK5iG1ZqUWFrBywdL+WVOZ6EZ/1Ng2YXsjxN//3hnDdFneSr7/dwbbaI4tMkNcuPsY5/jO+TQtePy2nhZ4avnvRTaf7FhaAP/qeHOMIbLqlmll1Oa15cTuQNAxiEg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; dkim=pass (2048-bit key; unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=yYD4Ww52; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jiucheng.xu@amlogic.com; receiver=lists.ozlabs.org) smtp.mailfrom=amlogic.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=yYD4Ww52;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amlogic.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jiucheng.xu@amlogic.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPzdB3xgTz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 13:04:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHYravd+B1remPjrIo18Yue0Bd8UA5mZOPlA63VSxXX6wQ9/Q1/h1+0DPpMw/ErC7L3bcqDiDtYq3azM3foOncJayXbyoG+s3NwUU3BzuDlyDZAvUfdFvn1oe4WTydWu+C9h1IJ0kYfw7qdgJ2zE7uvHiPxdTH8CvD1LMbc9dPfa5m6jjqRKCHV095qKABf02nzS+SVTyJjtUPKQnWmdBVpJkLiLHEtL5UfIydAuS1g9wzASV79kXJ+wpshccWFAacoBHsYmfyeGBzYG60e7v9IzsWnQbHqsITYkxUtAU3igh35T8ZXgx7pJeiYJMd0w3l7XxEqJNh/tNDFg+YZ+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7AajLuk3jeJMXCjIa4ixRFnwqT3oUT5OFsp1vXNZVk=;
 b=YnFz30AeYfeFZCGqJkoFcQwBUR4I/iPfRTYI+h1USoGzBTlWQvuKiRHSUkp2K4yIqXvZ2X5jm0RCmom6Tp3iOf6XzXAglr7884h5owxQ8j9kyYso/hLE1J+1K3uZopPV8DuE0x32otKYqIlW/Qss3Akj9Gx7oZ3WnzhXnDEPe0i/W7aRs+MzGeVzgLB3zcrR+YSfGpdvAS9m63Oqm6LVdvPqg3w618e3JRtmlH86EUMkhJuD+XzjQOHK6WLjOWFJzit87G83IEKbppWCHOOZQkoP1elC6q21WoGqBHg4I/JbZDgCFBGa0vKsjlJZ3v4r3Bcvrx3agJwN+XDTx6xMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7AajLuk3jeJMXCjIa4ixRFnwqT3oUT5OFsp1vXNZVk=;
 b=yYD4Ww52+SaIFQuNRU0MxRyfoT/HEuerAHJ+jhoQXHgukviU/y07ZK3cms7Ny9ARlqaN85u7m6uGphQOGjre/6jCHDIFR6da1/L1Tb5M0lIJbah8eIe/8uR9Og9rdX4b65W8Hz+1iCbSWrgt9+4WhX14r2hubC/Hs77EFhCg6vrka+B6hqhqniXfJUB23Y0FTJm0CUiOWx87WVfjNkG1chLqf4ZqY+9Uvu2FpyfgEJ3RPZFv2S1OCk9agMdzCGNmiGI62cTEqq2wqnxA7tY7nVHS1Wnt0tDN9RbDcJ/ZzU514bhkENMoxZDcpZppWJwh1ewi6O3IFIqEBbyGc3wpWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by SEYPR03MB9402.apcprd03.prod.outlook.com (2603:1096:101:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 02:03:59 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 02:03:59 +0000
Message-ID: <b2ad3f3f-105e-4171-b735-84051906cfb5@amlogic.com>
Date: Tue, 3 Mar 2026 10:03:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
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
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|SEYPR03MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 611cd03f-6332-4414-d263-08de78c9222b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	Vubf7vwljv5Fo82YIT5bWZNEOkaXq8MDgNq6qo0ctaotliCsZ5O9stIhzDG8eEwvPiVwbxgZ68YN+N6NrNd/Nvdq9xsaDGa/7Yw8Z09qCPMnFs2wZNXtFt3xhqFbo0kJnuv90GGPa0hzDsj8Sua/kUql0oSaKogcN1PX2wTDzSnG4Q0EKsWE2S4HTwiZnz7Sof+E5my9e9EK1vkifQ1oonU+vRdHWSCBJSuDsHilaaOZFwkREQ/lOcgWeEafPM00DrW5PAvrRiUAJHXTfHJahiG2TJySR+Z78ZYkMVjgvfF74LqKsgrx5H4de6Ptsct2/2B1Um4dZEVFiQ+dGv9emLn2TsJ9GejTtomb8kSg5Le2YVcaBkS1S+cmTZiv5mA8e06YrzdDgnQBcjVoxc4Tdh/rH4DnkF9pMNXVfoecIAqb0gZcpaPkqP0RBhzvqCxdQ5OKZlZuDiEFIGyo57suZTlgo3dD8NZ4ICy1ie6s4ygIA68w2i9QfZSlFurY1ptx0mB/onpBFZQL1BlYqzRt93FLEwdXQqRfEGVdW4mIme2tGLFb5YqUoBhjjJth1+7fFZumDe/25WoiSFcln04rOsFRleuabG+Cs+Xx8owRvwVcIo0Wj/58iPrOSucT2s0VV4nNUs26MfsXZMtjHNTu67ElFJXguPZQz73mpp170tmuvxoAUPi1diQD+kKn/f/vp+P8XLavixs+nQQwMVHuVtoqJVGJ4J4BpzqPzJNhi0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJnVFZUOFFMS2h5U0xSamw0QXNHdllOcldjUHNLY2FWM2xyWW82Nk9laDdw?=
 =?utf-8?B?dm9qbmZOUTczZjJNVHp2RUp6RTNmMjhjRkpWQ0JCL0ZMMDZkaU1ia3dDL2Ev?=
 =?utf-8?B?TXRjcE5ob1B1Tm1CM2ZpMmlFTm1uY3BGTVc0M3htNENPK0ZxQWJST2JRSkFn?=
 =?utf-8?B?emx3R0I4TnJUd3FzbUppeVpnTUdYamtvemg0TzhvRld6dGdjNTB2dWhUT0JS?=
 =?utf-8?B?czJIUURrbllUVEZsNUFFcUg3NFplaGNNa0JnWTQ0MmxxTXhIeVl4RktsdVNP?=
 =?utf-8?B?citQZGFwZUVLVEtPdndzZVBTNnZFdmlpL2pvZlpscHlYQzVGTU9PbFl4bU1K?=
 =?utf-8?B?VVFVNDNkYTZSQnhNRTdBa1J3YTBsYTZUOGo4ZUV6ZHo4aS9HS0tOVFRITmNv?=
 =?utf-8?B?aldHcnJ2SWlrOHhjMDU5R1NFMUcvWjUxVnFEdDNqMWFlQkI4Y3ZaQUxwWDhk?=
 =?utf-8?B?cDZuL2VWRXhyclVKMFh5Z2xTWDFYMlNBRG1SZzZhL3Q1SVM2Y3JTWlRIUDZK?=
 =?utf-8?B?aVljVmRJTXNFdXVWZ3dORXkwM0NJV1pmbkxUK0l1TnE4M1A4OFR4VHlZSGtl?=
 =?utf-8?B?Q3NnMXdvUVVVcFJjUUxPeHJwU01kUGpWeTBsSTZ5Z2ZzSTUzMUZXNHhHNERn?=
 =?utf-8?B?bXFSL1JSV3NHeDVJbjZDbC9zU05IL0psR01TT3h6TkEyWXY0Zld0cDNEdUNG?=
 =?utf-8?B?VGcralprd3Fzdk5nMmNkbjlPcjFPU1lLWXh3UWovYlRGbkZTR055MDUxdUFF?=
 =?utf-8?B?YmM1cHBSMlljZitUaVRHQlRLVFdwSUI3NS9DMUNjTDVESmZ2cCtiNWZpWnFU?=
 =?utf-8?B?QnJqSm1ySHc2RVJuN09ickNwV01LQWpDYkNnS29nclBzbENTMGpxTUM0cmVT?=
 =?utf-8?B?WUdWMTgrbGVQTnZjNGdhZlFoMjNYYi9vS0o1V3dBUjlWMGYzeXhWazdkS094?=
 =?utf-8?B?Q0JjWFlVWHgvck5hZlh2eVpKSFpLMUEwanMxMEFNa09vYm0wRVYrMWtrQ1BI?=
 =?utf-8?B?Q1pOd0MxWGVkL0owY2ttcFQranh6UFBLNXhXckdManJOT3prWkFnOVcyK0ZJ?=
 =?utf-8?B?YWNWRDhIcmFuaGMxS0VBQ0NoekV4T0dJd0tMYmNQWTNoWUJmOGcyWnp1aDlE?=
 =?utf-8?B?TW1MSmhuamhJZHVNRVcwcktuOEVCamMvNGNScDFtMU1EVTRJTGIrdWQyT1Nk?=
 =?utf-8?B?SFpGQktoak9aTmZOd3VhVWk0VG9kNy9KWjhzbkV1NXJPNlNZUXlKSnBoVGhj?=
 =?utf-8?B?RlpYWUsyZEdHWFJWaFdmNDJBVzFFZVFpdmJweVFLUlVKVUxtNTBBalEvMGRZ?=
 =?utf-8?B?d2c2UFJxbW1qb0tNR0xicGw2enpZTUQ1Z1FJRFFTTUxoSjRUczZTWktla3pj?=
 =?utf-8?B?Tis1dFhOT1JNcEhtNGdJVFJKR1haZTFBbGE1RGhkdVRPT0pGbzNUSFh6a0Js?=
 =?utf-8?B?bEdFQWdqemVYQ3ZtN3lNd3ZLaStEazVnU0lNRkozQk5SRC9ZdGZDR3pFbkJG?=
 =?utf-8?B?SVo5MjBVTnFDM0hLQkZyU3Q3THRlWGs3TWxSKzVqM1EzUnJnYThOTjVsS0pF?=
 =?utf-8?B?bG50cWdZYjl5UW9tVVk1ZHlUS0VzN1kvTFo2Yk1ubjFpUFB2Y3JnKzNLZGZP?=
 =?utf-8?B?bDZwcFhuN0NGay9yeTQrYlR3anArQklsaFozblBrL1MyM0hLOE9ycEtpVFEx?=
 =?utf-8?B?NEgvMzgzdWljOVNyOC91YXFLa2ZSeGlPS2FzSGxWNTFuUmQ2aFk2SHF5RTlM?=
 =?utf-8?B?ajkwUTFmazNMTVNZcFZsbDl2NzBOMVdZSHl5Y2J6SXlaaFhRZytkWWhOOGZB?=
 =?utf-8?B?akI3cGdnNDlpVEhSL3A5aURpa2g2SnJTNzBZQ1Z4TzZ0UWxHeFhaa2NGc3JQ?=
 =?utf-8?B?WXEyd2Z1WFZ0NVExak5tak1UNXVzWFFnaWU4eGxxVWYvRi9QNXd1aWNXWVZS?=
 =?utf-8?B?ZFFCR3d6a1UzTTczWkxuUDdyN09OWWZGYmU3b05YenVLb3VYTlBid1hiYm8x?=
 =?utf-8?B?RXB4QzBPZWZGYWg0Sis3T2Era1A5TkZhMlNhY3J0NHdWc0dGTGpBeHdGTEYz?=
 =?utf-8?B?eWYwbGR0eCtKQmFwVXZUQlU3VWpWSlNOK2o0L3MvTjlnQXp5REltNURzZnQr?=
 =?utf-8?B?YUlJVHBXa1VsanEvNFc3WjA4TVZGNklzbCtrUnYrQjkxWnBCZHhIMlNWRHdF?=
 =?utf-8?B?bVBhSEFIMkxQOGFxeFNiWlhWdVFISEpheFVJNEhwWEd0ZEV0RndidVNsQlAr?=
 =?utf-8?B?cEJzTjFFV1JsU0taMzFSa0F5WFlyamFhTThsSWJQOTR4YVVtU29RdlJseW00?=
 =?utf-8?B?MGoxdThBbENkcTUzZ3Z4enh0bXV0N0lpcnkvSEhXb3FWZGVaa003Zz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611cd03f-6332-4414-d263-08de78c9222b
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:03:59.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKmEp3p6p9Oc9xl1yZAbriHtxSl7N0ok1726c7ntBP+pkhr5AL6lqKtms7zw6VJFjpzH2F5a+6XBCWF7a88bFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9402
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: F0E671E7E11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2474-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiucheng.xu@amlogic.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiucheng.xu@amlogic.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,amlogic.com:dkim,amlogic.com:email,amlogic.com:mid,alibaba.com:email]
X-Rspamd-Action: no action



On 3/2/2026 10:23 PM, Gao Xiang wrote:
> [Some people who received this message don't often get email from 
> hsiangkao@linux.alibaba.com. Learn why this is important at https:// 
> aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> Hi Christoph,
> 
> On 2026/3/2 21:50, Christoph Hellwig wrote:
>> On Mon, Mar 02, 2026 at 10:51:03AM +0800, Jiucheng Xu via B4 Relay wrote:
>>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>>
>>> When current->bio_list is non-NULL in submit_bio_wait(),
>>> submit_bio_noacct_nocheck appends bio to bio_list but skips IO
>>> submission, causing submit_bio_wait() to hang indefinitely.
>>>
>>> Fix this by temporarily backup bio_list, setting bio_list to
>>> NULL before calling submit_bio(), then restoring bio_list
>>> after submit_bio() returns.
>>
>> No.  Fix this by not doing something that is a bad idea.
>>
>>> I've trimmed down the call stack, as follows:
>>>
>>> f2fs_submit_read_io
>>>    submit_bio
>>>      mmc_blk_mq_recovery
>>>        z_erofs_endio
>>>          vm_map_ram
>>
>> ->bi_end_io code really should not be having random in_atomic()
>> checks that make it completely different, but even if they have
> 
> Thanks for the head-up.
> 
> For this part, I'm pretty sure we need this particular one
> otherwise the scheduling performance (latency sensitive)
> is unacceptable for all Android phone users.
> 
>> that need to use GFP_NOIO.
> 
> Yes, it should make vm_map_ram() in the end_io path use
> GFP_NOIO instead.
> 
> Jiucheng, could you add memalloc_noio_{save,restore}() to
> wrap up this path?

Thanks for Christoph's and Xiang's comments, I will try it. Thanks!

Best Regards,
Jiucheng

