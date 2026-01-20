Return-Path: <linux-erofs+bounces-2068-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDBDD3BD82
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 03:24:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwB3v65yKz2y7b;
	Tue, 20 Jan 2026 13:24:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768875883;
	cv=pass; b=PDXgwi/eHTp9LQZQqFCMyzKqR/OhgTLLx6FNGBpO1sCEibujKIL39tN9fOTksOVeN1g+wDPjEmh7MIBALfqQLSi4LKG40XfeMuE4k2CjklYxsAoCQ64ps3tHkpCCvJIvu4yZY9vPBRr0Lr/eomd1jxczdomlb6CsdV+hXb6ryEdECujUT3NeZxrksx6AK7GmD4ymCfwzwkfbqHFA2BmUEBUWYvGYc9t25MTZbLO/cpjBBhG3zfa+mMlq9h5Dbk2MtJy0Jdv8UYeq0xUaYLj2BKOSQtcQPb3EDdgJ4Gylc0s0trDLfeTmobDZPhrEG8usLvPp9aPJpl3VSnt1jIdiXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768875883; c=relaxed/relaxed;
	bh=yywwhbHf0nYbDqvERKUlnnyg83OqLvxWRL8zUStGPIQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GC8Czsa0LLUYXp9D7nrrqmQMkzcM6oslo6UsknbVXZ14t5Lb4hqSxLW9AHC+D29LsHGTN8GCeeT+7C8+ClqyzF3EpZBV7z8MDj2dWPOO8COc56J7Dq2HNbZxDpxgT/Xg8BLh1vEvWfqXIxas23GM3lv8iSesfPDB9FkYYXW9Iusg6bgRZldN1RtgCX9LU4EFd6hZh5tV2K7bRn6Q8R/tV4BPYvcBEpY7He9nFdPE5Q+BPSCr/E1mLXcq22qyDMfPNRYrk2c6SWsKAlaiJ0FhaNcEjhrADoOPfvo1nq3KL6lESW1F377hE3vnAn0q0twnKGM0AS4T0FBzx5k2JLtHlQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=OwE/eH2S; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=OwE/eH2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwB3s1NwLz2xSN
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 13:24:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlEKsHA6+igBIzBpsSas1cftwffUtgX5OZ1u1hU+QEyGJSJPuyeHOWcN8cUflTEiIhmHaf84WOcJyy2Nf1uC8sivBU75DKuhRyu3nYRiDLPnso5bFXtNPbMHve1nFyfeuRq//qZ639nReF+A9126hSLznER50Xwg+kllVZRV0ZjO/2VdZHBY/+MGVA3wlCqFvHq7IhJ2mUgHAa6/a4guvUf4tfKbe7rA/WaRGhY3zd3YiKZY4CIcMNYaWXy8XrGUi/xIAp0kUo9O6G6WhDB989hy3fhNyhAdOQZu/qzJ7JvXoMjv2/znmqTOrurqr1MHcMWkoZQQxZzLMzlwC0WuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yywwhbHf0nYbDqvERKUlnnyg83OqLvxWRL8zUStGPIQ=;
 b=iMPV2gtY1iXLQhyATjeCxQeNr1uVy+0nTKgrqqx7BenWdDU3Ra2u82SlXLjsCiA8QiPp1VEum4BQrTMgpDnyCqCmx7ZvyTpHvPopzsEQ0Zz5l7AqllZXECCzv8K92TAD1BOVQK4o98ohRABgQUOn6EI+/JJ8trU3P1k0FhzSNBxzm+VkbJeWdJWt9lgVVRrj81mmLXgFjFzyWrX5zX3OBEza8pA1mpMzXx+XEl4ln/86Zy1cLlRFkh/la1Z4gtgj1CT2JR/L3bPTqOUhs9EkE/32omWANARvZxbkQprsXazYzqeagpRgNtQzf/m/hI3BhSLOVGGDRZ4KolTx7CyKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yywwhbHf0nYbDqvERKUlnnyg83OqLvxWRL8zUStGPIQ=;
 b=OwE/eH2SLtQa2/SvkBcr4gGfp/6kTnPPJSGnyeE3UPZVbpKLSRfZj2b9qyKcIerq0ClVkPHZ7Fk1xVklTKgUyiKzAgJN5moLhNCMrVsnfEd3VfbdOgtdeXz6CbV3PZSLsD2Vf+uVx0uiIrlEjKnbsJQWWaQ/ieltAWry0ta8h9k59PFPbRBk+98SufIXQhMqpUrwgNItZvOtMq5hKD6FmSnqcthMYyjN7UDmsdssd12wS64iv39IUZzxXxW/nYtrGgWxpsnFyagSDyyi6+ypzugeu2T6crm08LXE5jYKH008ReLlDxT2B/9ot6q5Pci7t6IqdVG9hZ6eVKbGHP4EFw==
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com (2603:1096:308::24e)
 by TY2PPF1C65AA8C1.apcprd06.prod.outlook.com (2603:1096:408::787) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:24:14 +0000
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::a3e6:d089:f88a:4412]) by PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::a3e6:d089:f88a:4412%8]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 02:24:13 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: tidy up synchronous decompression
Thread-Topic: [PATCH] erofs: tidy up synchronous decompression
Thread-Index: AQHcg3Wt1n1tUcyo/kS/hKqlxK+fFrVaYM8A
Date: Tue, 20 Jan 2026 02:24:13 +0000
Message-ID: <ef9679a7-bff2-4acd-bfdf-2c324b857a75@vivo.com>
References: <20260112034330.2263034-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260112034330.2263034-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PPF5540628D6:EE_|TY2PPF1C65AA8C1:EE_
x-ms-office365-filtering-correlation-id: 01a8c876-83bd-4016-fc7b-08de57cb00a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXRNUzRiQW4vUkdiLzJtakFTMUtnRjUrMlJLeDBYQWYvUGJFYzVEbUorYUFz?=
 =?utf-8?B?T28vbGlwNVlnM2cwbllTUW0ranRERFhpTldOd3h2aVhjYUd5ZXlZTmY4NlZD?=
 =?utf-8?B?UHZRQjBvQ0ROd2lrMkJMb24zNWdLelp4dHFYUGk5TVRkTDNVdDFiWDVYYjVR?=
 =?utf-8?B?ekFsSU0yQm5qaUNNODdoaXorM1luZk1kZUpSS2VVL1doYnE5Snl4MFBJd3Fw?=
 =?utf-8?B?YVVDR0tSdDg1dkM5SzRzK0t5bk1BQmZQbzFiUG9ockZoMFN0YWVqbXVIdURj?=
 =?utf-8?B?YTdRNHFDMXNCeGdhQm5ocFkwSnZsK2hhazhNWmZhbXpjdUorU3M0c2srNzR2?=
 =?utf-8?B?WExYeHYybjVOVHRRWExJYzBUSm9uR1BPdjcrcld3ZEdSRlgwcTZLK0V4N1I4?=
 =?utf-8?B?WXU3MTZYblVYZjlCNklvZys4cjlad2RJTmI2TUs5TUlEY0JwVVlNMk02dFQ4?=
 =?utf-8?B?Q1RIdmZER0FCV3hmNHZ5bWs1cUNBYWJBR1JZbzF0WUtXOHhWZzlMcHVMYTJm?=
 =?utf-8?B?WjBtR2tEN3grSktNaXdibTEwNGhhSzFUNnJqeDZOakc2QTBac2tWZVppWjNS?=
 =?utf-8?B?bmFaRWZacWN6VU0wakJwVys5MVZTczBlaWZBOWlRZmRUVVpBaW9XUWthSmho?=
 =?utf-8?B?TTRibUV2VTgvRjBBQ09LcUFDNHJob2NJeFl4Rm9PUWFKNFRTTC8raGdPTk9S?=
 =?utf-8?B?bkdkV0U2SG5IY3BnTTBFb2NURmF4Q0llc2FsUml4RFFqczRRdE43clpxSkpi?=
 =?utf-8?B?aTcraFRKZ2dsYzUyM1J6MlNGa2VCdmtPbjZrUThsT05FUm9RQVNGTUZhM21u?=
 =?utf-8?B?anovZE9DQjM5NzFPR3Nndm0vZ3E2WXUvaUJoY040Q041L2puMVhua1dZZVds?=
 =?utf-8?B?UlFaTG0yeTVkU29iVGpDbFM3TGdOZmFHRVd6UVk1VnRoQmh4djlUdnpod2tv?=
 =?utf-8?B?Wit6Vld5WkdOMW5iNUxQU0lMSEZ2VkdyNHV4NlNyajVrRFcwL0VCUlQwaUhE?=
 =?utf-8?B?eUtPeXh0TExnUWF2azlVYWgxa1pVaTZ4bUt2d2FXNSsrMGgyNmhHRDJTZ1kr?=
 =?utf-8?B?RmxlZkpHVmtYbXdKTDd6eGJFZyttZTcyU0g4QzQ5RnNVQ3VkL1JMY0hxcjgy?=
 =?utf-8?B?QlB1N2JZeVRwL2t3KzhRU1h5R3J5TDhNVyt3cWYrdXZQOHk5VVFISmJVNVJX?=
 =?utf-8?B?eXJNVTBvM2s4YTdnUmpHMWxoVlY1L0EybUdDL0ZQaTdmQm5EeVgvc1p4RWFo?=
 =?utf-8?B?cDE1enVuQ3BGRVd3anlzbTZCSDU4WmRqV2JQSHVRd2VnTitWUFJFN1FLRVh6?=
 =?utf-8?B?UHNjWExUQkJ4clB0V255cEFmTEdtTi9Ja2VtUEE1V3lNUkZTQWFyT2VmVTdX?=
 =?utf-8?B?b1NISHFrZ2huMktEb2dZT3g0SjVaaFNoYnRNb2xIalNEc3M3UW1NRVVMYnlZ?=
 =?utf-8?B?MWM4Skw1aWZwVmZGZjlobTMzQ0ZOSWFtQ09tbWhtSlJ0NVUzTzhOZERjdnJL?=
 =?utf-8?B?UFRGNXRYSXgxeXJVYWpqVVhMUjY3bzFlV2NsL1BQV2xJbmRpSzMzUklSZjhs?=
 =?utf-8?B?ejd4R0taTXJZcWwyekE4dHpYVUl5Qk1pVVlTbktoM3BaV1ZzUVAzb3RXT3VO?=
 =?utf-8?B?cjlyZlNXQjM0TmRmUjdKeFFwd2FGRHhKZ2FFbVhMdTB4eWZqQkNIamU4OWVp?=
 =?utf-8?B?bGpaVitaWElTemVNWlZFditLdFA4d05uYlE4WmRIL2VFMmtNS0E3U2tpTEZh?=
 =?utf-8?B?aklObXV2N1lXbExrd1JGU3M0NXJBdUt4WjNHSkdOVjhCcDdGakVjN2VuOEZu?=
 =?utf-8?B?WklaWm92WnRGWWI4WS9MRk1NRDdCUHBOcXUzYnBBYWtVSWdqQ2ZPMUxkT0hT?=
 =?utf-8?B?eG4zTTlFV3F4RElROFdXQnA3a0JZVXRVM1M3N3lkQnJ6dGgxMWxUeUlvTlF3?=
 =?utf-8?B?VjRPcDNLMXFqUXdwWkl4QkZGSU9KT2tuNEszN3lSQ0hLUzV2eDhDOVpUd1ZB?=
 =?utf-8?B?VmN3d3pYUE1rMmJWNWNyQzFNRlU3Q01rdC9sUmdKK2Y0SjZ4NkNqYm5haU1K?=
 =?utf-8?B?V0twcFdVeDZtZit1TmhiVVpIWGVvVnN6MkFYM1pSYVJTRllRclVuVy83TDQx?=
 =?utf-8?B?WTZMTDZiclZ3TUpoNWdjWjdFUnNqN21QUmlzNlVTaytrTGd0Yk9jNkJhOTdx?=
 =?utf-8?Q?hOOawc3m5Tmy9Oo4khUWjqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF5540628D6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEt4Q1p2QzB3N2Y4Y2VtUFkvOFNnM3RWVzFGVytNWStKV2pZQnIxbzFidE42?=
 =?utf-8?B?WVo0Q3Y3eXl1WTUzZHBxWVdhV0tHcU5LeUg5Nmc4aHFKbTkwMWFYQTkzN2Fn?=
 =?utf-8?B?UzlLWTJKaXJGU1B2NS9jTU9NWjNkeVllUkxQd0RXV1FyZ3J3TjlCQVUwVm14?=
 =?utf-8?B?MDNJeVp2aDBxSmVDN0QwUk5CNktXWUZXcHN1bUhSdEJsZzZpU3htaTMxUXZ1?=
 =?utf-8?B?NXRoVDV3aEpSczdjcDB2NGsvZDFZYitmSU1ack1hK083Y0lsajVXMTJIRXRY?=
 =?utf-8?B?UGpZMXpDaG15S0F2NUV0RzNNNkpMbnc5ZExPSVdCMHNMQ0YveW0xTm83SDhJ?=
 =?utf-8?B?Skc1M0ZVUXpQNzJic2Q2czM3bkswQTNjRGk0aWlFK1BtdVVldTVoQzB5RHkz?=
 =?utf-8?B?U1ExVmV5QW1nbnZZV2VuV3JTWE1HdWJDY2tJM3c3dGJ0dzlrZEdjbHBsZHds?=
 =?utf-8?B?ZnZLM2JZOVFmY2hlaWNwNm1qWXF5WFZic1M1bGwrT3hsR3JZRmtiZ2RIaTlY?=
 =?utf-8?B?aTUrUWVBb2VwNFQ0NkFzYjVBemNFdXJKcS9uM1Bab3pLYm9ndWI5MTNzTTlT?=
 =?utf-8?B?b29FL3VTeXgzQm5KVE51d0hiWXRyMDVtdXFyZG9rclJUUE9oSXMwcmlaMEVq?=
 =?utf-8?B?aEFBQXdCRmlzYzBYdDNWZTRBTHJSRU5UUDhRbGowMm4yL0RVMDdXM2JpYkhZ?=
 =?utf-8?B?TVZrOWgwc3JMM3U3S0lSNXFyZDZVMXlWd0czcDVSR2RsUXB5QXB2dFFpU0Nv?=
 =?utf-8?B?eGQyTmlNMk1XN3RxOWM5S1kvNnR0NGc5NXlFbk50dVRFY3JZc2M2Y1dWQTR0?=
 =?utf-8?B?d0Y3bXczc1IwRm8zWmxNaU10VG9YWlVMdTFpekxzbGExVWdWSTJ5NFZUK0Rz?=
 =?utf-8?B?TEFDa0NoWkJBWVZKMDd3TU1CbzliK1ZQczlJZC9OVmZaY0dDOWRuanZadjVk?=
 =?utf-8?B?Y3ZxdVVqdWIzNUtXc0RVWVoyS1h2MFBsMEJiaWdpZUphSEd1b0tCRzJkMmtQ?=
 =?utf-8?B?dStCeEIzM0lIRG41SUg3NkwvMDhVTVlpVHlVRU5sL2NLamV4NjEzZytVOXJo?=
 =?utf-8?B?VmNHYnI2aTZ4MmFkdkNCOFpZb3ViS0pPTC8zMUZsNzhrZUtNMU9vaDVKYmRn?=
 =?utf-8?B?d2JaRTYzd3kybHNPQzgrYjRXRWNiNkdSK0VxemY3YWNxa1NnYkM0MzNJZ0ZW?=
 =?utf-8?B?MTZYS1JWdGo2TURmZHc3ODFLUnFWUEg4aUZ1a0g4TUJCL0VUMmZuMW5kNmhF?=
 =?utf-8?B?TUVMcWxFRS9helE4R3FvczhFRHJadkd2TllQQzB3UW9lV1pSTmU5SnBOU1ha?=
 =?utf-8?B?NStRQS8yVitEajNDbE1TN3g1VGFub2RmTmUrNisrbTY5bDVaWGFuemtuaWNT?=
 =?utf-8?B?cHFZMTQvRmdMYzVFNkk4MUdQTGhYQU91ZWJqbXNkSDFpeVpNVmV6OE00K1p4?=
 =?utf-8?B?WE5LWndNRXNFNFFhVHUwNGxBR2ZlbFZDdXFwZnMya1owU21ISlR1WUZJL2tS?=
 =?utf-8?B?UGMzVk1xbk1obHFSNjFpUTFLdkRRb3ptT0JMdW16SVdJcUlPZ0hwdXVSSzYy?=
 =?utf-8?B?Rzh5NGdTR3JWWlhZSTBLOFoyQjJUL0w5aldWWmNvZzdOU3BEUE1rL0xRSExI?=
 =?utf-8?B?Z0xIQWl4ZUE5QjhaeGJyZUxLTUtvdjZYdTh0MWJWSFhqeW5HNUhiZm9TaktS?=
 =?utf-8?B?bURKSXh2MTVCd3poaFZwLzV4QXFoL0xNYVptOVdySlRhMXI2VzVVZWxhKzFH?=
 =?utf-8?B?cldKeVRERmRhNTlGRHV1bFlyOFJ3OGZ5N1JLcm9ldzJRQ2llUEZ0ekRhbUpy?=
 =?utf-8?B?UnBnSEJqSjdxL29CNGVhV2xwTlg1UVFZN2lvSTFuQlJjdUZMb0pUaFlVb25Z?=
 =?utf-8?B?ek0rTmcvZnRoRGFlWVpEVVNQY3cxMXV2TmNXZ0syTm1NRDhsWXVxbXYxR0lk?=
 =?utf-8?B?UXM1OC9vZEtGSjhTbFhWcTFwNllxZ2J2SjI2NXhjMlQ0eDYrSWpia21FVmwy?=
 =?utf-8?B?NDFWVnV3OEdqeGMxZjJqakhsUm90UHh3T0dMUldwMFhpNWhKbUxsSURWVHZ5?=
 =?utf-8?B?RmFaOEhPVXpjSS9TSWZyQ2w0eW1pWGdnYlJTZGp6UTVpZEszK3l2UHFUWitS?=
 =?utf-8?B?a1Z6clJtVlRjUjR3cmkvYXlaN2tTQVVaaVpnL041VU9PTHA2NFBXOHhIVFI4?=
 =?utf-8?B?c2tSemx2VUdub3dQOGo2UzFtYWdaL2hkTXM3dzJ4UWd1OTJZbzJBcVQ1THIx?=
 =?utf-8?B?TlNSVHl5TVgwRUgrVHVueUhCcW5KR2sxWVJzZGFRMVBndTJWZFJWdVBhTk1X?=
 =?utf-8?Q?TinXsQmtwrZsJOyreL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8BB29F0903C314196B34845B148B68B@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF5540628D6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a8c876-83bd-4016-fc7b-08de57cb00a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 02:24:13.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OHnqw3uXMp3azv+FXIWcoEiViab1D2+22vsQYPKnDbWxr+TLG0knGzGlRpoXn+SRfgC4Kp7pYfV4HXza+rHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1C65AA8C1
X-Spam-Status: No, score=-0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL_A autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

5ZyoIDEvMTIvMjAyNiAxMTo0MyBBTSwgR2FvIFhpYW5nIOWGmemBkzoNCj4gICAtIEdldCByaWQg
b2YgYHNiaS0+b3B0Lm1heF9zeW5jX2RlY29tcHJlc3NfcGFnZXNgIHNpbmNlIGl0J3MgZml4ZWQg
YXMNCj4gICAgIDMgYWxsIHRoZSB0aW1lOw0KPg0KPiAgIC0gQWRkIFpfRVJPRlNfTUFYX1NZTkNf
REVDT01QUkVTU19CWVRFUyBpbiBieXRlcyBpbnN0ZWFkIG9mIGluIHBhZ2VzLA0KPiAgICAgc2lu
Y2UgZm9yIG5vbi00SyBwYWdlcywgMy1wYWdlIGxpbWl0YXRpb24gbWFrZXMgbm8gc2Vuc2U7DQo+
DQo+ICAgLSBNb3ZlIGBzeW5jX2RlY29tcHJlc3NgIHRvIHNiaSB0byBhdm9pZCB1bmV4cGVjdGVk
IHJlbW91bnQgaW1wYWN0Ow0KPg0KPiAgIC0gRm9sZCB6X2Vyb2ZzX2lzX3N5bmNfZGVjb21wcmVz
cygpIGludG8gaXRzIGNhbGxlcjsNCj4NCj4gICAtIEJldHRlciBkZXNjcmlwdGlvbiBvZiBzeXNm
cyBlbnRyeSBgc3luY19kZWNvbXByZXNzYC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR2FvIFhpYW5n
IDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+DQoNCg0KQWNrZWQtYnk6IENodW5oYWkgR3Vv
IDxndW9jaHVuaGFpQHZpdm8uY29tPg0KDQoNClRoYW5rcywNCg==

