Return-Path: <linux-erofs+bounces-569-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93503AFDF9A
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 07:50:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcRsb02R7z2y8p;
	Wed,  9 Jul 2025 15:50:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752040242;
	cv=pass; b=LyE2tZqKPa8+3T3yb1AEud2QhRy4TEs9pFnmtCRcV6jQf8htQ4Z0T9BGH8yinWc8SP+HR/4gW/CrBGVEmcxI3+SKj7AwpOukHD+ePSXDm0gds9GR25eV6qNsoA+nWCaPda6cZo6nKFl91EdEMs80gUSwGzurTNmK6Ong+WVhL26fLDZk0kiYepNZlV3Yn9XyJ5TgOuHhMploeL+99a7FpC3F7uiUxCBimb9p714NFzeYxXIuao5HG9CyzSulAH7RUA3uaUhT1NuHgHhieGa0UO69TqQEGWCW/3OASV0v8xH7m5+i9xq8fjjxRjRSCjRrCAMuDin36K2I5NgArNem+g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752040242; c=relaxed/relaxed;
	bh=r2+UcIK81SKdvsUuVETX2MQxhvWj0ebgTDRkGyXMsMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmFgStiPE3XT/N5zwEnjpU/zJ3JHNiKE1epAVuUtqnVjrM3oMr+6Qkfh1mP3/2OyXMXi2ZFOQg2fiD+RtrET1p1RY+RfjOcPFFd1CD/a56w9VU89poRXnpxrwswHxkHJiAXmiGZGAOooZa6HJf08J8GzeEoc4vHvfA6ahXWFW680TcX+pzZpXSSV6GH5x9EWlQRtm6EbR8jjWNqDfbpS6b1h4eEv9RCeSp5lBYN7C3+KxYiEukdhOltvjaeFf75P1ta37PAO5ejZjX3LXlXYzDhVUEIFOtEkgnHk6PfpeE2eqA1E19i8LUzZPnTYcFdmtkdsdLCs+ym5tHRq2Ak2xw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=IdXJkGcn; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=IdXJkGcn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcRsX4rLmz2xCW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 15:50:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkUb15jbFgE2dIGMyfGUdCB3r4PKJ0wx4lCponIU7YCoXNcG/5MR7H1AC1m3sslwkB1C+5986uVpR4kI/xc15w6GxspOsIk+jkX7DutReKEQ1y4TsYAm8NEKb1xFGs8SjKJd33kmI4GXxD9weBqer+f+GEr1hlbsa0Vyc88KR/tlrVw2kVwyan9JQPoucTt8ygi3oni3Bmb+00BHbInHA7AoANJsJWU0g+RZ4+Q6QVMmMoOAaNdNpFODyNSJBJg2WwE/eMOZrD4Yh5vdUuhQspQ3VdtncaGTrGt9s1m1k+dwgFO7f4JXyMfeou36k9Ki3rk6Xa+aeWhi1Thj/ORwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2+UcIK81SKdvsUuVETX2MQxhvWj0ebgTDRkGyXMsMw=;
 b=gyimcq6bH1jfcHGuTPR+odbgNqRQxLq2PJLya+MkTbZefM70nzEqmI+e91HjdhYVPUkOBMceONlgV43A2Gt2luPaBU9XvOF78w8pEyE/YkYHLWZ5dKywbkunifeHnP6L3GwB1969AaZbN6lcgh2EIYFCe7vnHpR2d1op1Rx/QvZBB6sZgS6lAeziP+UqGHW4ljt1DOWN3oKFdnYg88zRZ2SBYPKPps6nvcTNRJp7YAqpNsn1ddFbSgFy7hPSe/yiWxLFLFJa2sPS4PTfho/q0XGQWn7iSKYzEFRIlVVJtqstitvwBJa6yLUpj2oRnuSEgfz5yPVH9zcNZfa+XStUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2+UcIK81SKdvsUuVETX2MQxhvWj0ebgTDRkGyXMsMw=;
 b=IdXJkGcnUEYOACINt0j1aQu6XCdhp9+GwI5OLmycYfBkj3xtIZuaOCae09O1CpwgZqkiDmHaNVT22adxa5f+6LbR4OIB2NhV6GDZDqJ+QlJvT6C+tOwY7OMg55sCRFo44LoTWAH88wSwMBSw64Hhu3JoABLrLfhqYe3yY/gCzQlmq0+IXFzgtqmvyePN4Xky9F30RVQZBEI3rrNVVdWdo995p3gXIAyigiLiurXDAZdO+TtEAJgn7VRh6m5laczsLuJCiAPOW47v3mjnqmL/8aXFgwmm0BoSbs6H0hJDifAD3tIEFTC8W3vSW8UMUFfB3gi7OISCG5uk8tbn/nanRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 05:50:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:50:12 +0000
Message-ID: <bbe6cac3-7792-4d85-b5ec-124f7eec20c5@siemens.com>
Date: Wed, 9 Jul 2025 07:50:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: da96c89e-24e4-406a-17cc-08ddbeac784e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDllOUowa09neHJXOUxhejcxOFkydUZjdVU1L3IrY3JNSnhnd2VSMUhUS3B2?=
 =?utf-8?B?QzllcWYzeHdsdFhMc2FqUlp4NWFqSEJKWkpRb2RBUjZMTC9yVk9WVmtwd1l1?=
 =?utf-8?B?aFdFcFJmWloxdFhwOVMwNDFSNEFFZFZyQy9RLzU4SVVPeFpVWWNOU0ZDbkYv?=
 =?utf-8?B?Y0d6RzVvUXUvekE2ZENWem9wQ1ltNElSbnZtS1BRWGM4bzZVUXVrZno0SDl2?=
 =?utf-8?B?bmYwaGpFWE5MRHdOU0txTHJic2tuS0JGTFJRN2RDdjBpN0RRQzhJQkwyMTNj?=
 =?utf-8?B?SWxTMFk4UExhMUMrWWVabWhIRFlwRUErVEhHQTEyNmVNOHFVdHdZOUkrVGpY?=
 =?utf-8?B?ZWVEQ3lRV1FXL3ZKd2lNVkxzeERCZmQrdUFYVG9pRjJFQ2FTNEJEc1BNcE1X?=
 =?utf-8?B?NVZFaXAxdEJWRm9VZjBENUs4eEJuODFVdWlCMCtYRThzSnZTNUZISGVEdFBO?=
 =?utf-8?B?cFd3ZXRJek11Z1VTdE5HM3dwamh2Z0c2RHo3ZHNnR0tGTW5IYjBzeWp6VklS?=
 =?utf-8?B?dkdjekZwV2QwcXFwVWltbm16WnZTRllGbnhMdldyc3JqL2pPQU10dEV0ZHBD?=
 =?utf-8?B?L1BVNDA5RXhQNkZtaTB6emJBYnlaQTVrNVBrd1R3cnVLYmxhc0J5aVdYQU9I?=
 =?utf-8?B?QVJlVEdNT2J4elN3T3ZxcXlpS2EyUkFuOHdZYXZMT0Z2SWZjU3BlZDJleVpQ?=
 =?utf-8?B?K1dIQnNPZEFPZ1BUS29YZ0t2d1F2UkdNdTVTRTB2Wmswa3Y0ZGJrajc3YUhl?=
 =?utf-8?B?RWRuU0tmOUkwaXZSdEV3eDFWdnZkaWZQSVcwRGJ2M0lKOG9SUHkrbFo3Mjhh?=
 =?utf-8?B?RXZaV1U5VEU0VFFsT0tRU2I3Q2RZYmlQSmZkcW5zT3NoME9pT0JicmdUNFBF?=
 =?utf-8?B?WWxhVFhtdVhneUhjRmR4Ui8wN3liMXBIS2JRSTdjODlnR3VlRXFHbUVIQjhz?=
 =?utf-8?B?di82WWR3WjdCU0hTZmo4WDZCcytOdnV1VTRXcTYrMmRoYjZ6djA4Q3JmOUE0?=
 =?utf-8?B?NE94Tk9JL1VxcWdwL21EQlZ4bFdLMmJlUmMrOFFnTVZONUFtU2tuMlRwQkQ0?=
 =?utf-8?B?L2JhUVM4ak1KUDZoTU1nRFdPTmVIRTBMdHBZbW1zdnk2M3RKbUxqM0duQzZ6?=
 =?utf-8?B?NGdCbC95eHh0ejJDRnlCVWRONzR2aUszSnZmaktoZDRjUG5ab0U4R0ZCUndy?=
 =?utf-8?B?WjFJaEpwTWlkNEZpV1h4NUFSalpocjFRWFpKdkxvRWZFenl5N1YxdHNwYjMx?=
 =?utf-8?B?dHo3ZHFTWEZzWlRRT3lBRHJBVjBwcTFhKzFaV1M1bFh3NWpmZUxidEVkT2x5?=
 =?utf-8?B?NXpNaTV2NVh5ZkVkQ2xuTXV6U0hnekdzREpwREVmTnZzci83cHVQa2hCd2Jo?=
 =?utf-8?B?S3pjMS9YZGVkQkRucEdOMWJGeFJFUkZpT3MwdW40TGtjekpMV3l1M1RaaDVK?=
 =?utf-8?B?Y0pxakhVUTZYcmtQN0pIcVpkZVRwZjEyQ0M5T1BxeERLUW1VcVR6dTFicXp1?=
 =?utf-8?B?czJwcWkzb2EyaUpsRkNrVnRhV2RPL1FUYVFQSzVPanFBTjVDODNxeEJYMkNk?=
 =?utf-8?B?Yk5WdWlHcEZrSXdtSSsva3VYRHBzT3FoMnpQRmNNcnpiOGU4SStyckxmNGxv?=
 =?utf-8?B?TFhmMkU3ejhTdGlic2UyeWh4M05yNm9BWE0xdlViMWxtdjJDTXF0Y2dYcWtu?=
 =?utf-8?B?eVN4SlRYamFUUEYwa2w0SGFqM2NQcmdNZEJwZEcrZzUvcEhweCs1cEtJTENW?=
 =?utf-8?B?NFhtTy9WRUQ1UHd5YjcvdTQ0TzNKU2dSY3M5QWlzclNCR2lVYTUzUGlhNFQ3?=
 =?utf-8?B?STM3eHl4U1VBK0JXSnFCR3ZPWTZpSWlZME9iMEN0VjlWenoxQ1lrSERmUE4r?=
 =?utf-8?B?SE1iREcyV09HUlllamlGeFV0bHpRS0pWT25pbGlVdFpkSitDK251SC9Cdm4v?=
 =?utf-8?Q?5nuglVYCLGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRrcUk4M1Q1VWtLejdNeVdFMHRKVkJTT2xtcCtkb3Uxcnhpd04zTERTZUhS?=
 =?utf-8?B?NERNYURJVzBzaktiN2tTRVdUNmdWZHRPMkJBQi9ySzV3OENONVBZdDRlMlRB?=
 =?utf-8?B?SjJXUWN5WWtQaHRDVDh6SUdXeEhQdGc1ZENMclhrUFZlcUcyOVdMZzQycEFE?=
 =?utf-8?B?Um1ES1pNOE90RDNtY2gzcjlRMlp2SlJjS0huKzZGRmRaMHUyMVF2NjNaakRD?=
 =?utf-8?B?UDNqTHBIaGsyTGhIS0wrMVp5SEpSZmtHMUxTbkcwajJXUnNlQmxjdHNBNURv?=
 =?utf-8?B?d2ZpVU9TNis3eENiTWtnRVNGWTc4bjI0VjNCNFhRV1QvQUZRUGJmSVJkSmQz?=
 =?utf-8?B?cWg4aTR6RXZnc2hYSXpSc2Yva2ROd1JMdnliWWUyc1FXT1MwdDhOKzZvZE82?=
 =?utf-8?B?VU9WY2R0aWdpU3FFTHBNV1N4V0VmOUY1TVQ4dG1wMTQ5RExZSVR1UUUxWjNk?=
 =?utf-8?B?VkFlRkNJVGFYUzh3MFBOdy9scm1nVWRFYUdwV2dUNGYwb2lGL1U1RUZrRmlx?=
 =?utf-8?B?Y3EzZ2NrRWg3RW5MUk84ZWJZcGRUYjBlYTRYc3lsY1NBcEI0SUd1Y0U1OXFk?=
 =?utf-8?B?WXpqUEFxL3prei9XdThybm9FYnVQSFdOUHc0MCtHRmNVZ29vUTQrZHlFOTdL?=
 =?utf-8?B?ZGpweXVjUkNvSVdNczRyUjJiQk5uek1QakwrZG5WZEtTMzZVQTUyNHNUT1pC?=
 =?utf-8?B?THY5R2RwaHcySmFTOGJzRXQ3V0hPZng2dCtCeTlzMFpqZnhzUVY2WHFsY01N?=
 =?utf-8?B?bFB1MC80dktVWEZnZ245YVdTZVJQQzdtRThIazdSK3I1VGxWcGV2ZHhBcXFK?=
 =?utf-8?B?NXBRc2ZIZHIyazJ4MHBjUDdQRHhTdDlNU1dCWFU2dDdsVEFQRjBZQW5PaFZn?=
 =?utf-8?B?MXFFVisySmkzcFRtRkZzM21IU1Z0cjZ5MnU4NkNyR3Bab1VMQzhpV2VTV0Jm?=
 =?utf-8?B?YXZPdmZqZnZycisxZ25DUUc0Z0JPdFlybENkNlpLRXZab013REtjWS93WFl5?=
 =?utf-8?B?a3d1RXpRU2NGNEFNMzI1anJHWTdMdzBBSWtwenNhaGM1UStIUDZIbnZraDg5?=
 =?utf-8?B?QjZPQXNMZ0JtU3FSdDNFZ0JNYzd6MEF2OVlxR21OZ3RNcFh6aXNVNTc3bzFN?=
 =?utf-8?B?WEx2L2M0NGtSYWlHblkyR09aSXZTNkQ1Ym40bVpwUkdvVEx2blJBZE90RDFX?=
 =?utf-8?B?L082a1dTTjNPRW92bHpDcjFIemFqTjBjbmJ3TXdoTGQzSFQ4OXM4cVZ2TXBr?=
 =?utf-8?B?SXdwZlZyMlhZT3FxWEdtankvTDg5RVUxc2Y3Z3hUVHpCUzJ0Q3c0RUpuTFhC?=
 =?utf-8?B?cjNva2ZpZXFad2ZtMStYckxVK2VVK05CVUNrL0RSeFd5N1l4Rk92VUVrSEdY?=
 =?utf-8?B?TW5ENk1wZFJSK2s5Ukg4N0xiSVpHYlIzMS9oTFNZRlptMFJnVDlUL2N1YVZM?=
 =?utf-8?B?amdDZ3lHenRtWXNvNTlPVm1RbHVHc2dqWUpNdnAxZ2JSNzdqeEo1UUhLbHVH?=
 =?utf-8?B?bWR4cFFXUTJuVjc1S09NZ0JjVWJ3THV3czZOcVptWmR0OW13K2M4bGV4THNK?=
 =?utf-8?B?azlUeWZIMUpieStKVkVMNXAweE10eGNySGV2OGhaUmJsUHdqTG9vNm9tTGFx?=
 =?utf-8?B?UjgwaUNuSDZPMU5UNWZVdUN2TWFkNnZGckJXdXN1S3ZDMHRGQ280YVNzK0lY?=
 =?utf-8?B?TmhkMHRPazJzVE0wRTNKcWdoQUV4T2JDZ1cwV3RFS1Y3eWZwZE82L3FYcVJ4?=
 =?utf-8?B?ZlUvQ3VWMDdBNm93ck94UlVpUjdQUGY1TE1wcmtXbzZLZS9hWVdjSURQNkRF?=
 =?utf-8?B?YXMvMUt0bVgxWTN4WlVmeHg4MlB2RmhaYlVtWTltMkZoRVlQY1g1OVdZSE1S?=
 =?utf-8?B?QnRDUkYwMjY3KzJsYmlsa0NjYjR2KzIxVmovWWhxdk5scUp3aTdQL21JRldi?=
 =?utf-8?B?OFB1VWJVdVQwL1UrQ3dHcE5wS2ZSMitZaGlFWkM5b3crMlFQeXZVM3dWK0V6?=
 =?utf-8?B?US9DNnZmRmxqT2l6VlNVOCtVa3V5cEZDU2s4UkQyNnFvWjVDdHFLUDRPbXlK?=
 =?utf-8?B?azIybk0yRmIzNC9PNE10QzQ2ZDZDZy9kRnlVcURHaFFpWlU1dGFZSGVjcDJN?=
 =?utf-8?Q?WIAIUxis84zBt0cSudOXp5Xw9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da96c89e-24e4-406a-17cc-08ddbeac784e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:50:12.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLAWPk9GLoh1fFVu/iLvySbK8UzFZcLvhCBPM+w8+2+rQyDvEDocQ7zp8oVnL1C2zbj+QuB/8PSfxKYEpUB3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 09.07.25 05:46, Gao Xiang wrote:
> Flush the D-cache before unlocking folios for compressed inodes, as
> they are dirtied during decompression.
> 
> Avoid calling flush_dcache_folio() on every CPU write, since it's more
> like playing whack-a-mole without real benefit.
> 
> It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
> is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
> for new page cache folios.  However, certain ARM boards are affected,
> as reported.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
> Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Jan and Stefan,
> 
> if possible, please help test this patch on your arm devices,
> many thanks!  I will submit this later but if it's urgent you
> could also apply this locally in advance.
> 
> Thanks,
> Gao Xiang
>  fs/erofs/data.c         | 16 +++++++++++-----
>  fs/erofs/decompressor.c | 12 ++++--------
>  fs/erofs/fileio.c       |  4 ++--
>  fs/erofs/internal.h     |  2 +-
>  fs/erofs/zdata.c        |  6 +++---
>  5 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 221e0ff1ed0d..16e4a6bd9b97 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -214,9 +214,11 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  
>  /*
>   * bit 30: I/O error occurred on this folio
> + * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
>   * bit 0 - 29: remaining parts to complete this folio
>   */
> -#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
> +#define EROFS_ONLINEFOLIO_EIO		30
> +#define EROFS_ONLINEFOLIO_DIRTY		29
>  
>  void erofs_onlinefolio_init(struct folio *folio)
>  {
> @@ -233,19 +235,23 @@ void erofs_onlinefolio_split(struct folio *folio)
>  	atomic_inc((atomic_t *)&folio->private);
>  }
>  
> -void erofs_onlinefolio_end(struct folio *folio, int err)
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>  {
>  	int orig, v;
>  
>  	do {
>  		orig = atomic_read((atomic_t *)&folio->private);
> -		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
> +		DBG_BUGON(orig <= 0);
> +		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
> +		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>  	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>  
> -	if (v & ~EROFS_ONLINEFOLIO_EIO)
> +	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
>  		return;
>  	folio->private = 0;
> -	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
> +	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
> +		flush_dcache_folio(folio);
> +	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>  }
>  
>  static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index bf62e2836b60..358061d7b660 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -301,13 +301,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  		cur = min(cur, rq->outputsize);
>  		if (cur && rq->out[0]) {
>  			kin = kmap_local_page(rq->in[nrpages_in - 1]);
> -			if (rq->out[0] == rq->in[nrpages_in - 1]) {
> +			if (rq->out[0] == rq->in[nrpages_in - 1])
>  				memmove(kin + rq->pageofs_out, kin + pi, cur);
> -				flush_dcache_page(rq->out[0]);
> -			} else {
> +			else
>  				memcpy_to_page(rq->out[0], rq->pageofs_out,
>  					       kin + pi, cur);
> -			}
>  			kunmap_local(kin);
>  		}
>  		rq->outputsize -= cur;
> @@ -325,14 +323,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
>  			DBG_BUGON(no >= nrpages_out);
>  			cnt = min(insz - pi, PAGE_SIZE - po);
> -			if (rq->out[no] == rq->in[ni]) {
> +			if (rq->out[no] == rq->in[ni])
>  				memmove(kin + po,
>  					kin + rq->pageofs_in + pi, cnt);
> -				flush_dcache_page(rq->out[no]);
> -			} else if (rq->out[no]) {
> +			else if (rq->out[no])
>  				memcpy_to_page(rq->out[no], po,
>  					       kin + rq->pageofs_in + pi, cnt);
> -			}
>  			pi += cnt;
>  		} while (pi < insz);
>  		kunmap_local(kin);
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index fe2cd2982b4b..91781718199e 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>  	} else {
>  		bio_for_each_folio_all(fi, &rq->bio) {
>  			DBG_BUGON(folio_test_uptodate(fi.folio));
> -			erofs_onlinefolio_end(fi.folio, ret);
> +			erofs_onlinefolio_end(fi.folio, ret, false);
>  		}
>  	}
>  	bio_uninit(&rq->bio);
> @@ -154,7 +154,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>  		}
>  		cur += len;
>  	}
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>  	return err;
>  }
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a32c03a80c70..0d19bde8c094 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -390,7 +390,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>  void erofs_onlinefolio_init(struct folio *folio);
>  void erofs_onlinefolio_split(struct folio *folio);
> -void erofs_onlinefolio_end(struct folio *folio, int err);
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		  struct kstat *stat, u32 request_mask,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index d80e3bf4fa79..6f8402ed5b28 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1090,7 +1090,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
>  			tight = (bs == PAGE_SIZE);
>  		}
>  	} while ((end = cur) > 0);
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>  	return err;
>  }
>  
> @@ -1195,7 +1195,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
>  			cur += len;
>  		}
>  		kunmap_local(dst);
> -		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
> +		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
>  		list_del(p);
>  		kfree(bvi);
>  	}
> @@ -1353,7 +1353,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
>  
>  		DBG_BUGON(z_erofs_page_is_invalidated(page));
>  		if (!z_erofs_is_shortlived_page(page)) {
> -			erofs_onlinefolio_end(page_folio(page), err);
> +			erofs_onlinefolio_end(page_folio(page), err, true);
>  			continue;
>  		}
>  		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Please make sure to address stable versions as well once this is merged.
I've so far only checked 6.12 (besides top of tree) where this applies
as-is. Other versions likely need extra effort.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

