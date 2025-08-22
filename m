Return-Path: <linux-erofs+bounces-880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB22B3142F
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:53:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7b8r4bQ1z3cZB;
	Fri, 22 Aug 2025 19:53:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755856380;
	cv=fail; b=dq1ePRumOArDK1Pso2AyzdpFD6T1trTN2ALwKJeONaGz6MDsjQOABA7mMI6pZv/f94DJOh80GbrbZuMMVw4rgqudeqpiAQQyVMulV2K/mXV6jdTXLGPA/PVFP1zCRaGmsCcnYohccSC5OF4UDc6d+fceMGVvPThu67/JrKV60BcXMJFZWMaBYbw8RXxy7kIMPXvjTARy9s32s4XONRZhaJY22XquVHszBrf+7uLyX9gTEhgJ0QWlWbn6xk5oNUiDOv56XZEpmvhnS43mhIaJ5Jy2pVHMiWesurx01R9pM/FN9G+IJGb0Sw/JFbmwbLs6pvskaWJy3cKTLmYXafYeVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755856380; c=relaxed/relaxed;
	bh=AWL5HGzZwvkLGMhK+bqh3TcG2eG3O4/gXuOvsNQICfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lACCqo8vsZBSgZlOHtbZuBadqgMXCe75K4qKSRcYUkxGHCz6D6789Thzisrrs2G7WpKlH+F6FaBGemiim2n8nYB6BTmitpMVRD/4u2qG5PC9kNSgzwlasa2RL4L4FSc5KjygpCBoXXiIfm3rfl8/3af/ys85U0ssvkGSNlrdQ6wAvUaUBmffx8e3ydjPZUGh9YAompdQmdOUvc03XaF3nKFGOaytQZZgmIOwJARmLR+nOrf6UKMMtBveW6JS/d0jCvyHESgrp5ENLeGlw5polBNOkNjrGQemflI6CPiYQBFM9X+a2jjloBgeIi+zwLX1T8yE8Wxy30QH5tlQ8pa8mA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=VthrCsTb; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=VthrCsTb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7b8q2px9z3cZ8
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:52:57 +1000 (AEST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M79pTS004044;
	Fri, 22 Aug 2025 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=AWL5HGz
	ZwvkLGMhK+bqh3TcG2eG3O4/gXuOvsNQICfI=; b=VthrCsTbK1l1Dhp/BeXCfy6
	SVpgrhSB+IeCQGeJkAitWwJBoWq8gTCM6MfMDIefAKqD4LXuhH9y3jq3aCey1B77
	69nV83HQ+qPu9lMP5+6kCPURhD2LZf9hInAtVhibyaYqLN52nnTfMik6AYpXfZd6
	itrTSGcDMDYRK6zCMV1Njw4qF3xpqMh24MHmg+jLBRWGoHnvkgIJPMzm0GTynY+m
	aB3c0BgpNrKpErKrQsYnVH7znSPlJr5Sdlz+9MHvAofp73zd+U6tDXEYiYn2HGkX
	GK+NmEWgUhxdy3JkcPQgjPmiR55IPxlYgd4AgdVB0IW5LG/XijOUUV8Tk+j/9zw=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013004.outbound.protection.outlook.com [40.107.44.4])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37fjgf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 09:52:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCRW+Gnk/EZbJa/++u1qfVgTMy/c3mpRWRSa4ox615/jbzfpPEfIRQb92ElMANVM3g9i4A104S4aS3U3DrCqTAEEtLiz9FrWmuLCgFmimqqtIkmkRxptzLI5ilujMCa46713Ny9hZv2qbKlsCR+h1PGOhAJqUYBnIMKvnCXuds7lVgseO63VC+NYekWXes+1Nr+lNHbc47KBbuNfTlfO0Iu73wuiNmnbt9gJMapXBFrF3RQTedoNCSI3tR712HkM+45HBJHJ6odIy8dJd9vz7NSqCv6vzqTfMsJzo8zQFYXTzlUqzDOGrEuRKMqICgPSBuYa7Acofq39Jq57ogcf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsQlBq/3qgyZJT1tXXxdPZEHM7RB5owejgJLCQ1O004=;
 b=k46dGGY76LBZkV3+0ZM7O3lbpG5gKnBdx6OqOoyPW7oswP2HBwcPXDvFGUiFryzOBBGb5Z512iKUGk1SdCATc/pvIAAhrOuZCxSBbBgl6YF0L44x6+h6rgHARxpQs6XZMsxJUxoWsF0NjhkQEiTPaYsZOfKjMKigW312NZNrEhzxfJq+qfssszb6iKL51+17+y5k3Cgm/+9nhrw+Xn65jfYeCz3tvuSWitcvtM3nx9kYqkm/IhOgE8ityAo8wtauvEO5wNUoTtYCiQhjwpmfjT6adnXgF777gE21OxjYQm8uMPFdmXzxWGyxUt9x2ERBTSIOTJw6UYEnrs0CbYNFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TYZPR04MB7906.apcprd04.prod.outlook.com (2603:1096:405:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:52:43 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:52:43 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Topic: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Index: AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdaAAAx7ww==
Date: Fri, 22 Aug 2025 09:52:43 +0000
Message-ID:
 <TY0PR04MB6191A41E6265D02BCF22E8FBFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
In-Reply-To:
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TYZPR04MB7906:EE_
x-ms-office365-filtering-correlation-id: 02f53f5f-f083-4a93-e64d-08dde161a3ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3Z2MXc5RzErWDVISFY0RGdGL2t5Z0JoTThxcHZ2eERaUlNoWnVEdTR1NWlX?=
 =?utf-8?B?czdLeGxYbzJCZmpoaXZPcSt0blJGa1I1WFNqdDVyQ2pBWWhIL1NhRGs3dThF?=
 =?utf-8?B?Ui9JVnhrU0FETlhHZElLU2JESWwzY2s5S3ozOVBvTi8wYnovdzFtNWJuQWhQ?=
 =?utf-8?B?Y0x0UDBEL1lMSzVBK2Q0ZUZLQXRaa0pENGhKQmIxNm8zV1hzVXpDUzNkK0Vy?=
 =?utf-8?B?dExheitiL1A3SndoUHpMWG5HdFlwbVoxekU5SVc4K2s2UmZsdW5iSmI4bGdn?=
 =?utf-8?B?ZDRyeCs0SHRVVk1MRlRwL1VOei8wZFRhZ20zZHE5b2hzbW43eHdTQlk0bTRH?=
 =?utf-8?B?RjN6UzVEQStHVmNOTmhpK0RJSHkyWU5qZFdabnU3Y2cwdlRVdGdOUUJjVXlU?=
 =?utf-8?B?ZnN3b08vQjVUZW9uMjJMM0pHN1p6cjlLV2FTSjZQNlFJUW02dHl6RzIyUFpY?=
 =?utf-8?B?M3BRNUJIU0NkL0NBNmdHNTNIcjZqRE11b1pOSk9sdUt1QUIxRzVvU2c1MEVZ?=
 =?utf-8?B?MEN1Q3V2dXFiL25FbmVlVC9jNEIzSGhvaTNaNnkwRGdRNDZpUEZMMzY0eGNF?=
 =?utf-8?B?NUhlTVc0THJRQUZlK3Q2SS9yTTVqdUtjcEI1TW5sY2JvaFlXQlhNZkE3c3li?=
 =?utf-8?B?M21HVGFuR2hlV3c0UldjUVRNVEg2L0YraHQwemZZZ2JEMWw5dzZucGlUdFRR?=
 =?utf-8?B?RU5DcmNlTmMreEM4Q3g1NDJTR0dUcXFwYU8wTEkwUXh2OG1zczRtY1hud1Rs?=
 =?utf-8?B?ZS9uTm5WNHNzQ2RPTVhQUzBNOVZHVWIvS3BPdC9zVSt3bk85QUYvNCtweGZE?=
 =?utf-8?B?YnV6SVg5emNjeVBqczdqWWNub2g5VjRsYk8yR1dZNHNxOWptUU1qcUVVUEtQ?=
 =?utf-8?B?b3l0ZTl1Zm1BVXpvcFJ6VUhIa0hIenJDZm13U0RkR3JiWVo0TDVnRzQrQ29F?=
 =?utf-8?B?ZnhtOGRITnQyaitYcHRnSXUwL2UvN3RpZitOOUlESmxBTm5aT0pFWHRTMVJn?=
 =?utf-8?B?ZEdPa1pGd1JDYk5VZkFsUFpkSldCY0lLcnZzRENxc3VuWkVsR2dLL0FUZ0Rq?=
 =?utf-8?B?bnFXcjZwMHZ5Q1pzTkMralowNzN2RjJ3cnlTemJjOUJjc0RsenFsWThUZlZj?=
 =?utf-8?B?VDBWNlo5VXQzd0lOTmYrVWVvd2lJZ1grUEtaTE4rdzVMa0lFci8yMlBOdGha?=
 =?utf-8?B?NkRxWHdZd2swTmVmK0hOajhCU1dPY1h5Uzlxb3lYNXdTZ0h1SExHRUZWK05N?=
 =?utf-8?B?cHkraHZiUDBWRXNQYThqMm10RDluM0p3RzBKWUtzS0pUdUhVa1BEWUFMb3Jq?=
 =?utf-8?B?MmQxVWlQbDB5VUVHUk9ybkpTSUtBU2N0Q1g0UkdJTFlaME11NnpkR0pWc2t0?=
 =?utf-8?B?ZUxTamRZNnlSUllrUnhFNndaU0hkb1c5YVk3dHd3aUc1MktnY3FhNWpJcUl1?=
 =?utf-8?B?emVzd1ZMVHp5WktoR0NzMnFRMmNmTGwrVkpHMHRYMFJVclg4Z0MwOEU2Y2dJ?=
 =?utf-8?B?aG9sSTV1azMyK1hUM1BvcTJCbDlNMHBoUHZHdDV2bjl3bkY3K3NJeTJsblda?=
 =?utf-8?B?M3YzOTJuMnEyaE5RVDhmSDJnT2hKVzREamp5V05zd1M1VVZZUUt2WE80L0ti?=
 =?utf-8?B?YThKUkIvZGY2U29SeGJvMGE5QTVsTW9sUXJDMXFpZkQ1K1liRWtXNG1nbDRK?=
 =?utf-8?B?dWhCQlp1SUZVVW14UGp3eU45eVhzR3VyRk1YZDA2dlZOaDZtWHhjRWdVTWdv?=
 =?utf-8?B?QklUT2JuZFdIMDF3Y3Fab0FUWk9aamNhOXFTRzRVdTMxQlBCTjUySVVkb2o0?=
 =?utf-8?B?Z0dmTEhkM3hzWnlVZmtTK3VETmFHd2ErK2xlUDFyWU0vSlhQcEE5Njk5MFp6?=
 =?utf-8?B?RGp5S0tlaVRRejlMdjc3NUxzTGs5Z2ZXM2l5OU9rUFYvY3BSbXU1U2pxVm9j?=
 =?utf-8?B?TEIwbWFBMHdSbTRKUUtVVUs2NjlFbmwycm1Bb2o2cG5TNW44RHcyZWdneXQv?=
 =?utf-8?Q?JHqQY4ZUBt+ockmoiNoz+Xd+FzzDbc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anZLU3MzWTdtTTdtUFRQeGluOUg1WW9oTCtHV0d4ak1HN3A3cXZVa2R6YnpJ?=
 =?utf-8?B?dTlqM25VY2tYQTAybEY4Y1haRzVxL1luTTFmZUJoU0lmLzZzV05MQTJvd1NS?=
 =?utf-8?B?YklOaG9td2FnY2tscFNDdTBMMmgwRlc5aXEzY0l0VGpBcG8xUURERHk2Ty8w?=
 =?utf-8?B?bkxGa1cxVGU4SlhXTjVmR2R4enNuR2liS3hvd2t4blZtNFRHYWE3SWtuUmNa?=
 =?utf-8?B?aHNlKzMwb3JydXZwVkRHZDhZMXkyQ0JGYWIzUHpVcE5RazFRaDB4UUloOTJY?=
 =?utf-8?B?VVNHMG1pbkZ1cXgzL0t0SXVqUUVaSm5FRytoWkVOOU5rdU5LWUFta2lZUUt6?=
 =?utf-8?B?SzBFTElOWExtTUJITUt3MHVTcHZZYTVzdFRzQmN4aVBpZkdPR1RKQytLWnFJ?=
 =?utf-8?B?bmI4V0JWNG5STzJiRWxuOW1FVjRvbXJtOWR0elNFVnlJRVpONWFsOUtrSWJF?=
 =?utf-8?B?YWdCV3p4ZlVYWVFSKzF5NXp5YkMyb3V3MEQ0MnFDMG1FRFlPUFFpTlRia01l?=
 =?utf-8?B?dEFkZmxYeEthUk9WcHJEaUNuRlFJb2xTL0k2UFhyNnV1ZXI0emVYMndEK0x6?=
 =?utf-8?B?VUZpTWJSbHFtNjJHV1FaTGhWM1hEMDF6REcyRWkrZmUveEt2TmM5aXZuMWJq?=
 =?utf-8?B?azNIajdZcVRwL1ZjelBWd0lUMFlVVmJUYXhhbmhtU0NzRWtvZGtxYlVmYzRO?=
 =?utf-8?B?TmJQdFBGeCtLdG91RUMrL1BJdnkvLzE1MWVYcHNCa1NmTkc5UFRYandKRnZR?=
 =?utf-8?B?ek50bTU0OTYrayttVnhtRlJ5VkRIQnNYOXlsWEc2K0IzdkhZM0VaR1VIcW5F?=
 =?utf-8?B?T0FHYUN2OXJZakhtOFp0ZjR3OFl5bWs5MEV0eTZmNlZxVUtpQlZNV0N3bVor?=
 =?utf-8?B?bkZYcEhDNDNuWmVjaE4rL281K1JwR1MxY1pWbkVBMDdSUis1R1I2d0hnSU1V?=
 =?utf-8?B?QXBoMEowdGVoc05sN2dUVzNVbG1xY2lRVjFYU08yN0J4SEhRbkZ5NksxY3dV?=
 =?utf-8?B?ZUlVNmVWSkJVamo5UUJ2S1dPSlJVUDFPOThuVEIzMHlISWtMVmlGTjNjZWty?=
 =?utf-8?B?eWNGaEQ5S0dETzBWTVlUQ2hrS09WcFhTdmdwbG9DK0luWmRiUUtwTytCeElS?=
 =?utf-8?B?bjFNRkdIcmJBaGx6aG5STmVlMmdDdW1mVTQwYTdFWHhrZmM2U1N1T1AyYXlT?=
 =?utf-8?B?UFZTNk1vR2taNzdyM2hXSzAya3ZMVGdlY0wzSWRwaG9kU3JZTXdsM3pxN0hZ?=
 =?utf-8?B?aTNpcGhDd0tZWjNkU1RQc2IxT1BjKzlkb1hadHFGMDIxLzBoekdoY0ZGTVNr?=
 =?utf-8?B?RVhXNUZLd1h4V2d1c0xmMDdxVFhqNERLbHdYZHR0MTVnRk94dTVQeXBjU2xF?=
 =?utf-8?B?Ykp3ZndrQmFoZm5GdFBCblpWN1lYY1l2UnVQWFVSbVFLUEJBa0xsMHFSa2I1?=
 =?utf-8?B?WktOYWRTRkpCRUFobURtbWlwT2ZXazNjdVZnODVyM250Z3hzZFd3WnNoL1Bx?=
 =?utf-8?B?bWY0c2FwZUlQSGt4Wi9EMTE2MVlnUGVYeGZpTm13VHRMYWdDRTArWVZQUGIv?=
 =?utf-8?B?dEczN3hhVG44WWFSNHJISUVlb0RzSjZGYmdJeGlrK2JLMDFSOGUzcGNya0o5?=
 =?utf-8?B?QnpSVUUrVUkwbzhNcDJENHp5SzZEbkFDcFFnUzU4K0xPcStkZkNEcHFrRVNX?=
 =?utf-8?B?elp0OWpxalNWcVczazlsN0hZWXNxd0hTYk1RKzdZcHUwK1N1OHN1YVJBUUUx?=
 =?utf-8?B?a0ZPeXZHVkdvTiswdWZTNVlRTWFsdnVYbGRwWEg0MUNyY3o5ZHE3Q2VVN0Nn?=
 =?utf-8?B?bmR6dXg2QmwvSlVVL0V5c1B6V1JCeVFlV0tKYVpVU0E4MUlSbTZjUjVpR0Qv?=
 =?utf-8?B?dGhsQTdRc1VXemtpaThOajQxcUdMYlNCSVhoQWU3UERDZ2NZTVNPTXF1THNK?=
 =?utf-8?B?ei8xNlRDOFhxTjN6ZSsrSjFrUmNTL1U1R3FralJhS2Z5aEdsVDExWVpjQjVP?=
 =?utf-8?B?aGdYcTNkbjdtU2p1dWZzR3AzZjZJQVRXeTk4YlZtcExKY0FSc004U1JuRWU1?=
 =?utf-8?B?U2lFOVp4cEtGWHFvbjg4OFppbHFmOU5nQkN3SDhlWlZDTml3NTBJcXVDbG5U?=
 =?utf-8?B?WjVQOVFqa1lxc1VJTkNKYVpBMU45eHc2em5UMTdMOThFTnRyczRscXNqWlVC?=
 =?utf-8?Q?VZAaQZNwE1a8WP15ISzj8QI=3D?=
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
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RaSPM64ncFg4qF8iKMfnIcd6zvHwzTLqRef3BoS2WC9G7tM+LPl7iv4NKbGc8RfvtPM6TND/Wt6TQve+qNpmSXbvGlqJRqje2WMNYE0BtMV7A0MxEGCNj129AK0Cj5wBEY0C+hjGQv3xy8b2vq5MIlAlxzjeZv725bydP2DzoEnmnEhSEnLksV/RO/yGLfpTSomsH4urd8NUmweBv0w1etvLhzQm7UIBIVdqvwOCOGPLSwtBYARczV6AipBFzBGhzx2Mem+iMebBt55TeSkt0muj940//cT7xvKoSXp+yUzyjff4n83Ky9/+I8pUbSJWvWkCIrhW/URTmiCDg5wVVAYO7r4SPO/e0jVI8fz5fXD0lr9+p9GAGfNcqCFtXUe9+G1MXTpviYLcpZPC6l+FEjNVOcH1Gre7tN9ugZmIUZO4XElC+GE3wRcuIfraDF4c4kMLVcyfMUxBUhf6RsLcbBN2ZUvHzch1fd0ksK8F8Wgqteg153hxX6lADmrzMmMjyq6p/YhSNSinUIxWcVY1MiZaAs85+by2jCL9u5Fw2GS06jh7wpm39nbZvzZUD808W2CfTbOjmnq/JFdHMs8f+wKYfySPG6sDeh/ENbT4wRRKOl8zdMfHelfyv8ttDZAX
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f53f5f-f083-4a93-e64d-08dde161a3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:52:43.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/6/dMgqyOhA9OpMjipSnu1DpY0I5KW0E+/wxqDtLESy8ltlXlGeBQDa0rVdvN7xxIVi+vQ88YvVSPmfU/b9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7906
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: QYS30CSgagEC9pqrk1sjz1ciYYEe_QEm
X-Proofpoint-GUID: QYS30CSgagEC9pqrk1sjz1ciYYEe_QEm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX+rdjzNpjFScP ReJygvOgeRGd1zqMngPPfPyE455tVbgFBlQEs/jOpdPAQo6DJXIJglvthkyRf+v/JNnJxfGIHat fxB012VpbDovLmPXlMI1Jca2HnnmvTiFfoEO+DwGs5CcyQNOcX4oXakrbzVBuovC/0EECkc9oik
 DfPObQqKNzIdP4/zr7WnC8sIFdz0dfPO/X96FLVJN9x9ZeMWOrjDIzIkUmECF8Hce8wxyhQlJyg nK+vupOgOX33JLph8i3Q3l1zbbAItqXjUHoLp+5tUsfTfezzNO1FGN/WJNHSt/EsvuqPokEkQjM 2Wy2qIcHLqwncSgaxGvH5WNlWtsZdmI7u8VTTUgVU+RU+oH+Yf8wC4Nr1hEjBJhOEM+3GXc5sLh
 pDCczoR/9Qv1YPnnwWiSGtUPXG3Lzw==
X-Authority-Analysis: v=2.4 cv=Mas1e5/f c=1 sm=1 tr=0 ts=68a83df2 cx=c_pps a=mVWBFiwek1crlHwgb+BGCw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=voM4FWlXAAAA:8 a=SRrdq9N9AAAA:8 a=57PknESPhfnYMIdZ0J8A:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: QYS30CSgagEC9pqrk1sjz1ciYYEe_QEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

+       if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blk=
szbits) < dsunit) {
+               erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
+                               1u << cfg.c_chunkbits, dsunit);
+               dsunit =3D 0;
+       }

'ignore dsunit' means set it to default, default dsunit is 0. Is this corre=
ct?

Then sbi->bmgr->dsunit will be set to 'dsunit'.

________________________________________
From: Su, Friendy <Friendy.Su@sony.com>
Sent: Friday, August 22, 2025 17:05
To: Gao Xiang; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi, Gao,

> It should be

>        if (sbi->bmgr->dsunit >=3D 1u << (cfg.c_chunkbits - g_sbi.blkszbit=
s)) {

>        }

In main.c, dsunit is set to 0 if warns.

+       if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blk=
szbits) < dsunit) {
+               erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
+                               1u << cfg.c_chunkbits, dsunit);
+               dsunit =3D 0;
+       }

so here sbi->bmgr->dsunit is 0.



________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, August 22, 2025 16:55
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi Friendy, On 2025/8/22 16:=E2=80=8A42, Friendy Su wrote: > Set proper 'ds=
unit' to let file body align on huge page on blobdev, > > where 'dsunit' * =
'blocksize' =3D huge page size (2M). > > When do mmap() a file mounted with=
 dax=3Dalways,


Hi Friendy,

On 2025/8/22 16:42, Friendy Su wrote:
> Set proper 'dsunit' to let file body align on huge page on blobdev,
>
> where 'dsunit' * 'blocksize' =3D huge page size (2M).
>
> When do mmap() a file mounted with dax=3Dalways, aligning on huge page
> makes kernel map huge page(2M) per page fault exception, compared with
> mapping normal page(4K) per page fault.
>
> This greatly improves mmap() performance by reducing times of page
> fault being triggered.
>
> Considering deduplication, 'chunksize' should not be smaller than
> 'dsunit', then after dedupliation, still align on dsunit.
>
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   lib/blobchunk.c  | 15 +++++++++++++++
>   man/mkfs.erofs.1 | 15 +++++++++++++++
>   mkfs/main.c      | 13 +++++++++++++
>   3 files changed, 43 insertions(+)
>
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index bbc69cf..e47afb5 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode=
 *inode, int fd,
>       minextblks =3D BLK_ROUND_UP(sbi, inode->i_size);
>       interval_start =3D 0;
>
> +     /* Align file on 'dsunit' */
> +     if (sbi->bmgr->dsunit > 1) {

It should be

        if (sbi->bmgr->dsunit >=3D 1u << (cfg.c_chunkbits - g_sbi.blkszbits=
)) {

        }

?


> +             off_t off =3D lseek(blobfile, 0, SEEK_CUR);
> +
> +             erofs_dbg("Try to round up 0x%llx to align on %d blocks (ds=
unit)",
> +                             off, sbi->bmgr->dsunit);
> +             off =3D roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
> +             if (lseek(blobfile, off, SEEK_SET) !=3D off) {
> +                     ret =3D -errno;
> +                     erofs_err("lseek to blobdev 0x%llx error", off);
> +                     goto err;
> +             }
> +             erofs_dbg("Aligned on 0x%llx", off);

Could we combine these two debugging messages into one?

> +     }
> +
>       for (pos =3D 0; pos < inode->i_size; pos +=3D len) {
>   #ifdef SEEK_DATA
>               off_t offset =3D lseek(fd, pos + startoff, SEEK_DATA);
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 63f7a2f..9075522 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -168,6 +168,21 @@ the output filesystem, with no leading /.
>   .TP
>   .BI "\-\-dsunit=3D" #
>   Align all data block addresses to multiples of #.
> +
> +If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be i=
gnored
> +if it is bigger than \fBchunksize\fR.
> +
> +This is for keeping alignment after deduplication.
> +If \fBdsunit\fR is bigger, it contains several chunks,
> +
> +E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=
=3D4096
> +
> +Once 1 chunk is deduplicated, the chunks thereafter will not be aligned =
any
> +longer. In order to achieve the best performance, recommend to set \fBds=
unit\fR
> +same as \fBchunksize\fR.
> +
> +E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=
=3D$((4096*512))
> +
>   .TP
>   .BI "\-\-exclude-path=3D" path
>   Ignore file that matches the exact literal path.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 30804d1..fcb2b89 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1098,6 +1098,19 @@ static int mkfs_parse_options_cfg(int argc, char *=
argv[])
>               return -EINVAL;
>       }
>
> +     /*
> +      * once align data on dsunit, in order to keep alignment after dedu=
plication
> +      * chunksize should be equal to or bigger than dsunit.
> +      * if chunksize is smaller than dsunit, e.g. chunksize=3D4k, dsunit=
=3D2M,
> +      * once a chunk is deduplicated, all data thereafter will be unalig=
ned.
> +      * so ignore dsunit under such case.
> +      */
> +     if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blk=
szbits) < dsunit) {
> +             erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
> +                             1u << cfg.c_chunkbits, dsunit);

One tab is not 8 spaces here? it seems indent misalignment.

Thanks,
Gao Xiang


