Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE19548B7
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 14:29:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="::1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723811388;
	bh=kWSGBZ1QZtussu4eOipYgmXCvJ9U8JdIrbweChsC3mo=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=g7PggXnUoRUsW68eXkea7CrJvxnv+/PQF8xBDfwFIVVUxbQSDHR3ytKI8IVlS7PHj
	 Vcr/IA8XZZz6DQq3VX1nTaKMNK5R0fP0hhe1o1jlVP+qYrkgEPvhSz8IturrtjDadZ
	 SUmH/WbwADB+keNwYwPcnC45v/mz6pw1ASKHzwfgdg7LCNPgCDUt2vJv3clYOyNn6O
	 zGWrdrU3RhGBDCxq5aGEKklh2XAQZkhPjLeFDrBZWQEKwwQvySdJlNGGYxkMJxlxvl
	 CtnK1k3k5Hj4O+I8gSvHxFOW2UOfYBJQvlcHmUjz/xrZHUfffakZ/XG5LgkIJENY2P
	 EqPmMDArgbgcw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlhC02y8yz2yqB
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 22:29:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AT2PRwpK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlhBv6hLWz2y8W
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 22:29:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrj0RbkhazhlvZNBQQQZZo1NQM4+A643PKNrbdEYYOlaUzKdfvULKVO5VOR1DQF7jHQ7Z4kiu8T+3PoB0drVXNvmqAZ6o1H7yzHu0HIHSnjIDReQqOc+CKyJ65nRr2/UL8S1zqKb5S0VI2ukB50kat+CfZ1ZFxwLVkLWZ4nLvwrQMJ7wB48h6HurNRW0KThOcpqEQZJr3LDdnbiFcB5N9CnrcmQJT+eqp3XhclmNf7wKTaoBEEZzb8xqhTQd1L6hR1yM15uLqkX6PWVDeW9Lmzlgbs70uatuSxkAKlpDylj1Nl89mK0y+r5L2QYA6971OE0UZpC3HUrBIpLSKfXFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWSGBZ1QZtussu4eOipYgmXCvJ9U8JdIrbweChsC3mo=;
 b=VSAWAApTztOYccF0qUybRiZinOC0nZClOZbij3N6IUZanhrkLH10YYUT0qzt/gHCroxzfd8FeTTjFlIQUtvXL0GbllcIflWjyymDk+ZxhfENHq7MsTWp1lyItpzF9xHCofFNNNOitiC4nva3Zl0beluUql3IfBkAcLmYxHlhpQq1yWxfY8ZKociTXkawwT9dygSxuf9lYweJwEQAH+DOJ69bRNiMkLH0XArO/LST4MK36gRu/eE3WIl0juQ50WN1FoHTTjbfxoWRjnFG5bVOTPY/xMdiwE1maQxxuZEM55dpH1Hyc6VvCB5NUmaueiWq996UXI70vs/km0c1XZJlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWSGBZ1QZtussu4eOipYgmXCvJ9U8JdIrbweChsC3mo=;
 b=AT2PRwpKIeO55M6mwWZHIUHpNgPzV42c7S1/7tTNoiNw5ysZCo3e0dtzW3P+5ZCVsClRigs6PO/kBLIefuf7ltlBrfWIpvCIuQXVB9zfMvFFRVBb1S8CxgBS21oew9ZDElROQ7xZl/F0cw1oJ3XK93ILTd9EssvVkGZAaG9mqyYAs2BT4pB0yV25hKzuG2G8N76bGFExc7PNqUOLiy+i5WudSp7KCG/iep8M01uLt6TncNvsroAyR+s3Va/oobugPPh6LYmRaDsYbhRliCsjcr24HnvDHc0RwA7NCD8gmd3kIA1G7z8QD8cBRAgTJsNY1PMKPehfVpHkrlL4vQGAeA==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by JH0PR06MB6809.apcprd06.prod.outlook.com (2603:1096:990:4c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 12:29:13 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 12:29:13 +0000
To: Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
Thread-Topic: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
Thread-Index: AQHa7WlYD138MipB3kSR9SoEb+aiYrImCpAAgACWwICAAfZBgIABPWmA
Date: Fri, 16 Aug 2024 12:29:13 +0000
Message-ID: <ff19185f-465e-47e7-bfd1-f13c89d85cea@vivo.com>
References: <20240813102723.640311-1-guochunhai@vivo.com>
 <d6f177fe-0263-489b-968f-189a923e089b@linux.alibaba.com>
 <52c4bcf8-dfb2-43ac-9b94-91b4bd7821ba@vivo.com>
 <CAB=BE-S4iH-+JupZ2N=Z7phx0E4jq61oq_GGbY16BdnWd95c+w@mail.gmail.com>
In-Reply-To:  <CAB=BE-S4iH-+JupZ2N=Z7phx0E4jq61oq_GGbY16BdnWd95c+w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|JH0PR06MB6809:EE_
x-ms-office365-filtering-correlation-id: f8257edf-c489-4c1f-b772-08dcbdef0995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:  =?utf-8?B?ajBSb09UcW1YRkhPQi8weEloSEk0TkZRTGMvekkybFJ1VFZ3ZlhIV3dYQytL?=
 =?utf-8?B?dmhNRTFaZGRaeWlsZisrL1dLYmlnYXBOMGF4SlB6VHVjSXY4eFBPOWdMQXpC?=
 =?utf-8?B?N2duVDdwVTZoZXBIYzRrUk5Sb0g4UVd1aFZtUTJVUWQ5R1NNVGNiaEhpb0lv?=
 =?utf-8?B?cEZhSnhFa0g1QjJXRkxTVTFJdkdVb1o4aG40c0lkeFFrN3k4UzZEcTB1RTJZ?=
 =?utf-8?B?cDBremphWWFhQWxMSk81SGxaditCRUIzK1JTOTd6d1NRVFBqaS8yVHFYcTV2?=
 =?utf-8?B?U05QOTlqZXNyWTFZbUFKc3RVUXk3MFhqSlozYW5EV09yLzRURmpBbnZQbnlx?=
 =?utf-8?B?dkxidExSdVVVVGdwWjAxbUdhT0JzcUxyZUdORXd2aHlTZmRtdVRzY1krYWhF?=
 =?utf-8?B?aWRzTkpMaDBnTVFEdVp4THExR1RmeFd1Y0dCUVBOVjZlVmFQV28rVmxoMFhp?=
 =?utf-8?B?M1hpU2RJa0hLeEZ2SjJ2VmVmL1k5Vkxlb09NdVhGZ0RMS1Bpb0V2RTV1MTda?=
 =?utf-8?B?aWovUi9ZWXZFSnlCSlFGaEdmbEEzN05MRmI3enNVQWw5dmdKMm9qbFBlNUhX?=
 =?utf-8?B?OE1qTS9jNFNXLzV4ZkJPdW1lTHpsV3pZSURscWk2ZFgzREVHVC85NjFyWnZH?=
 =?utf-8?B?QUJiVW9iUStSNm8zWGlrZlo1SlhaaEZYRUJGTFl3R1lvd1JHUXVXWTRtQ0p1?=
 =?utf-8?B?MnlLWHN0NGJ6VENIeEZjV3pVNG1tZnBMOGdzNVg0NnoxajFlSHg2VDZOY3hP?=
 =?utf-8?B?Qk9kV1lVVTJNYndIZUl5T1NUbDdiZFZyL2M0Tjlaa05OcU5nbFdpVHFMK2px?=
 =?utf-8?B?NjJJalhib1UzcWxMOE5EMWtvdWVPelBiM0krb0w0MEpnZDB4K3AzWDc0aDhm?=
 =?utf-8?B?VEVhWElEanN4c0lXRmFNUWNHckhicWphOGZWSGNMNjBIMHhRS0paL1JPZTdM?=
 =?utf-8?B?ZEpyVE1jV09iZUUvTnVFSndhbTNNKzNGbDIvUnUwa0xjOU5tZkpIQlloV2ZC?=
 =?utf-8?B?WWltaVhjc002NloyUmx5eVh1RkJUNS9Jdnc4L3NHT1JRVjZCemROV1ljeG9m?=
 =?utf-8?B?RHlON2FJeEExTEtPU1dtaDBpSmtGVzdnZG43NnBVL2lpNWx2VWc2ZU9tMWR5?=
 =?utf-8?B?L1JZZnc4QmhuRC93RXZEZDVoQmE5RklIQTgzOHdGMHA5ZTVoeXlZRjA5V1hZ?=
 =?utf-8?B?M0lLOWZnSkF4dnViM2lyd1loNnlXOG9wTHNyR2FLejVkTW1iWU5BYndXMVNr?=
 =?utf-8?B?WFVNK0M0dHZtV2JiaUlFdTlvLzlxTnFTNmNaZStMeW8wV3E2UU1uM1hYNzhE?=
 =?utf-8?B?RWRjY1lldWJkNVU3SnlndTEvN1hFUTR5RkNydWdkQlAyR2s2K3AzYVV0SUtZ?=
 =?utf-8?B?S0ptUXFhOCtNSWVSZ3dxcTRHN0labExEbkZVaXI4dkFjVk5YT1Bkb0w0SFhu?=
 =?utf-8?B?UFhVc2RvOG53MjRtQmt5ZVlvNXRuUDN6QkJaVmV2UDlFMnZYOVFQeU9sdExV?=
 =?utf-8?B?NkhkcEo3aWxBVm16MmtkMk5JVVE4MGc5L2U1TnRtaUFhbTA1UXpSRTZ6R3lD?=
 =?utf-8?B?YVZnMXBWakVSYzFSZXNPRm5ROHo1YjZ6d21SSGR0cEl5T2RVTzhTcnhrOXN1?=
 =?utf-8?B?YkhLNHpic3V5bkJURCtrNDM3OW5JNGRhbnEvdWtQVFk2aEJ4ZFdXNTMvdzF0?=
 =?utf-8?B?Lzc0dzhmNGdyR2FYZHY3cXVzNEFYM0ZrclYzdmRxR1F5cDhaTElIVTljN2Zv?=
 =?utf-8?B?a0w2QlVUL0RTQ0l0RktUNlNTdG1sWjZaNU9KMnZmeWNIYWhlckFmRTdrTllM?=
 =?utf-8?B?anI2VndJREhZaVg5RFN4M0xvRTR1TitpZFdQVndad2x5T3ZITk5zTVM3cXc1?=
 =?utf-8?B?ZktWZG5xN29sb3MrYkxTc1Yzamw0V0hJazN5SVpWbm5GOGc9PQ==?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?emVEWjlyU0pZOEtGNnF3bEhHazRqRlBXcWJ3ZFFQR1ZLckorVDlRM2dKY1pE?=
 =?utf-8?B?YkxxUjdYTDIwdEpjaFlpYllzR0NnNHJNRGNxdGtabmVJWlFoZDR0QkJsZ0xH?=
 =?utf-8?B?K2hETUx5eEFDb21kR1BaY2hReEZmUGVuSlJvNGNBRFNrdDBZMUpBSzhHdUVO?=
 =?utf-8?B?MFFvY3NHMFRFc0xVU1diRHgxT3k3ZUp4QmpsMHluZnlpMVQzcGVTVjdGaFhu?=
 =?utf-8?B?b2RVTUkxakREY1FhR0RKZ2ZvdkVSckJuajVDNEF5clE5OVc4WEx1VzVXRmF2?=
 =?utf-8?B?WVRKTWhPMkcxRnVNRXVJTmMxOXpYbHpGaHhOc1JzL0NBcTd0ME5WcVl2bENX?=
 =?utf-8?B?RGE1by9LSThjU2doUUlFS05YUXBzV2hCODA4UTFqOUFtVlV1Y0NTcG9vNTZ5?=
 =?utf-8?B?YVZNdTNZNXVHM3lwTWYzVnBTRit6NU1ZaHdicFE4d3I3bDgyQ01QaDBneXk3?=
 =?utf-8?B?ZFNoSnVxbEVCRDBFRVVCVVdURUFoU0hnYzlUQ3ZQeFVmM3kwamtoRFhlT1F2?=
 =?utf-8?B?MWZGNDd5alhiaXJvMWpiNmhDbTZoY2xHZm9IZXIvdEZaTjB1MHc2VHJ4bVE4?=
 =?utf-8?B?R01LcjBHOHpqS0NaNEdSQlZ1NGZSYlN2US9uczNuak90ZVVnSjViMmxWQkI2?=
 =?utf-8?B?eXVlTE1zZit6YkY2clVXQ0NEaGVpR3l1WG1reVhJUzNQSllkOSsvdGFtVk1u?=
 =?utf-8?B?bmFKakRlWE5zWi9qK1hJaGdCbXdTL3JJMDQ2T0QrVWFZVnJxbDdEdHZTb2pL?=
 =?utf-8?B?YmFvdEYzTWNjZ2lLV1d6c0lqM1pNTmlxMW1sTGY4KzdBTWg0Ykx4QXR2bGxT?=
 =?utf-8?B?RFdKQVhNaXN3RUNTUEsvMHFVRmNUVEFoRmR2MTdVN0JJWFh5ZWwzM2M5YlFy?=
 =?utf-8?B?Mm9BdGY2SEVjRTRwUURlVmRPaGZKN1NKMzZDM3BqZnhZVHkxSmJYbzdYTE05?=
 =?utf-8?B?UEg3cXMyVXhkMkdVYnRhR0NDSGNDc202emZrZjlmckMvMkcxaDlKRWdwQ1Mw?=
 =?utf-8?B?YXhhdGRFQ3dsYlMzN0szMEdQMFJUUlRaa1g0ekpJMnpBeHdhQTBUY3Fxays0?=
 =?utf-8?B?MFcrM2xYeDdDbnVaZ095SnJ5bTR5UmxneVFMbWNwbkRSbkFleFVqTVQ1Y3JO?=
 =?utf-8?B?VGJuQjlidGlPb05aYWdNTVlEUXpqa2pYSDlTWlM4R2ZhMU9EeGxnYk1XOHdS?=
 =?utf-8?B?YWY4THhLckFRbzVYbENtc1l5ejlXY2dmRWVZQTU0YnFMRUdDS1JPNERxbHMv?=
 =?utf-8?B?QmczcnAxR1BoRFpWTDM5YnBCTjNHRDZLWUpJZXdhZks1UFRnMVNIS1lwclRD?=
 =?utf-8?B?UHluUm41MWlicWZPRzJhWGM3c25tRDVqaTkwMndJcjhNZ2xDUVBFSm55UENy?=
 =?utf-8?B?VzJ6RTFDQXhqNFVhU1NFem5SQkY0UFNYZUV6ZVY4bFAxSG56TFllQjE1K1Er?=
 =?utf-8?B?Z21rUVVVL2hZMTZCdktkSUYzZ3cwblZqR0lHR3E5YkljVXplYkQ0MWliZVAv?=
 =?utf-8?B?Zy9GTUlCM2R4VndCT0dHT0x6RWpSbXI5a3Z5R0RLaVd3K3BiYmw2UHlJVEpU?=
 =?utf-8?B?LzlzRTlZS0NWRmdNVVVjVytpWm45T25GS2orNEQwV0ZlT3R3aHRmbWQxRmZV?=
 =?utf-8?B?SEhKMHM3TS9NY21kN1ZOTFI2akVUbjZrdmVHZm1EUW0rNi9MeGp2YWI3cWdD?=
 =?utf-8?B?Y0JVK1REaHM5TlJCeEo2SnhicnR3N0lWZGZ0TldGc2QvMWM3TmFBY0JKbkZZ?=
 =?utf-8?B?Nk5yMTluWTFyMzNRQ3FuNTdCb1ZuSEdxUmF2Ky9YOERWc0g2SVpMK3g1MGRj?=
 =?utf-8?B?azZ2anhxT2ZUcTcwS3Q5WmFHRXRxT1dLY1VRd0FuTjVYc3ZTSm1DSGFpd0xm?=
 =?utf-8?B?cWNYRXRMMFNVbk5BWGFucTBRVDZ2bzdib1N0RExZeHlJT2RibTN3TU9HaVFB?=
 =?utf-8?B?ekJJRUJ0OWF5Z0t2d1M0OVVpWjgzbWNPM1hCOXBjaXBYUWNNa1ROVnBPQmlr?=
 =?utf-8?B?b3dSQVdSV2d3NjhNVTE4bEdER1BoZHZTb3hMdVRlTnhNaWVqdExEMjJweEVM?=
 =?utf-8?B?OWh6N0s4TnhjZm1PcStZcGJIOG9ZVmszN0ZqNEoyQ0FqY2lMNTQzTjV2TWxy?=
 =?utf-8?Q?dR+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2180712376683F448D5E5AFC0A0E3D48@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8257edf-c489-4c1f-b772-08dcbdef0995
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:29:13.5290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5yDrUcrRfUXYQEln0v7DBoxxSaZUQwPKAA9HxRq0vpVHXROvArjnPFEV0xVrcGLxajYFPaY3GBrQAu8GP1waA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6809
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: "huyue2@coolpad.com" <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

5ZyoIDIwMjQvOC8xNiAxOjMzLCBTYW5kZWVwIERoYXZhbGUg5YaZ6YGTOg0KPj4gSSBkbyBub3Qg
aGF2ZSBhIGdvb2QgbnVtYmVyIGZvciBpdCBub3cuIFdoaWxlIHRoZSBtb2RpZmljYXRpb24gaXMg
bWlub3INCj4+IGFuZCB3aXRob3V0IGFueSBzaWRlIGVmZmVjdHMuIEkgc3VnZ2VzdCB0aGF0IHdl
IG1ha2UgdGhlIGNoYW5nZS4NCj4+DQo+PiBUaGFua3MsDQo+IEhpIENodW5oYWksDQo+IEV2ZW4g
dGhvdWdoIGl0IG1heSBub3QgYmUgZWFzaWx5IHZpc2libGUgaW4gY29tcHJlaGVuc2l2ZSB0ZXN0
cyBsaWtlDQo+IGFwcCBsYXVuY2ggaW4gYW5kcm9pZCwgcHJvYmFibHkgaXQncyB3b3J0aCB0cnlp
bmcgd2l0aCBtaWNyb2JlbmNobWFyaw0KPiBhbmQgcHJvZmlsZSBqdXN0IHRoaXMgc21hbGwgZnVu
Y3Rpb24vcGF0aCB0byBxdWFudGlmeSB0aGUgYmVuZWZpdHMuDQoNCkhpIFNhbmRlZXAsDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdpbCB0cnkgdG8gZ2V0IHNvbWUgZGF0YSBp
biB0aGUgVjIgcGF0Y2guDQoNClRoYW5rcywNCg0KPiBUaGFua3MsDQo+IFNhbmRlZXAuDQoNCg0K
