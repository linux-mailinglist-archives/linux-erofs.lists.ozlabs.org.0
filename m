Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34519C3CC1
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 12:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731323431;
	bh=h0IwPpuia5BJ1mdlZQxcSEKwJfk0Z0+SpBa0+swQlwQ=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Lq9GzNXelOrmXYGOOcqCLHYH7mpYtf+/QhwDLiEK5UeMdY3Kec6h2LzI5Ph2AawZT
	 RqwzWS4pYUwn7idV33oIXhnSHVrRLUP77dxSRGAJnd5siPe2m154zusfnYIDqJbJjb
	 khD+Tk6CTYXC13Lu7y+C5RYYm6ta2IDUKPG+l8Sk/gSRzjUDvI35wAe1q4S4wu8B7H
	 GxVNl0WvFOCRo5LloscCLHUk8LPuLRXHSthPPYi+402U1H8VuD9rF5FTxAZFEOE1qs
	 +2x5VmnEyjJ9PhrFLNaybYkoKO35O7sxUxt5KQusm1TcmAyuK9zlqe99FOhaP5YZej
	 R2F/Sr0oe981g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn6KM73YGz2yfm
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 22:10:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::618" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731323430;
	cv=pass; b=DQACCf3kwaPwfCrctzFRvNtlzSbhM28SoHuMCN2/4FwMYBYO9ymhFBtldM6CgadIkJzUq6qTG2KS1dAkJ07oQgoH3oeE5eccEUKDvS1/zrWbj+U/EU8y9m4d70pMZdDQp/K1tguLF1ISw6MxK3kc0j/4tt3gM5j35Y14ecjJi94YzIOx2wl3CqZo1hm4EhFu6pLR7ZX4fbldssdlsOe44P1Cb0w9c9F1VdpZAdpf5L0pNnpxjiZ5iVLGHxfaWkKqPCGdvOwCZkAnk8Qr+Ku+y/PApvh3TDuMspT8ubJILuUFlSktzJBzSLDCf9cCfRzmNeFIrwdKI8KHHKxroL9PxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731323430; c=relaxed/relaxed;
	bh=h0IwPpuia5BJ1mdlZQxcSEKwJfk0Z0+SpBa0+swQlwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAXRQmtGe1a6PFT/foNdKOiXpSPZNsuzRISSHVRzwfjVLGysn+t6rz971pByAja01d1Wlxtdjbd0Tw9kDUpkG+kOTJKHGbNRFh7/x7vsV0+1sGVeglyE0IcuPeMkX5dTkz8uPY63eGYWzQGc2lR4v5YJ4coWgpxXTrVY3dFTRXZ9QxBH/ThThQNmpY3HDTO9qNvHnBJM8cionWcLA3g9npktzoAkElBXO94pKbzjwhkbGE3geh3e0O4J8TNsnVe+7jZO844tOr1ArlX+We90SuH7fSFTI6jCH13nIdVHF0zDwpFrGLcnpoKPLc/0bUzJdOMFH9PxLhv4PG0Wq5rJsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=oqB2h06i; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::618; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=oqB2h06i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::618; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20618.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::618])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn6KJ3mV8z2yG9
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 22:10:28 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bal6jdU0sKpxKG2e0YbZCg6GOXLG/1IIYyVqMH3W6TbEbUE9y4cRlD31QSaCkvsQ5UL6l+PHBT6VJh+4eGeRvGqquZADbFpe3mGL1LOBA4jhHO8pNVQ/hvklE7DHNyAx++hhhjnj/hM/cPBwGxBdsx7l7cogNr8cBV6or4Y+/7K9hRZEFBhDnC5YjGCcPNqnzFeX4uhv0eth7N5FaQUAqFAnuflOGrwb9ahSEJ00UrPmjH1oBVVcHPdvvsmdPfnO5jdkyGuKRvZmEAqkTamsKxfPNKtbMaIt47CueTgK5JhyJiDmR64zHSUZjqejtrgWKO1pxkClb9cZyw+wzqNDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0IwPpuia5BJ1mdlZQxcSEKwJfk0Z0+SpBa0+swQlwQ=;
 b=tK3NDtcHyPLS4+fmWJEPRQv+d/ms/KS9YeFtuJuujfpqOm75gVTEDksvh+tmgHW+LD1vUeD0iCPv+rthmhwVr9mjSPzN0cq6VjVMFb24G6KKwvjZeKm4NOU0pvCwXZRTMS0xqnn8pgxpxF49KVsilXnb9J6TllGgBOFX0Ko4Gf6LVlvY7vRq/nfznfzmYQP7OTJftclgQ5gOKKdKDM7TDRu/+ksnc7X44XkJ8NtMeTxt8MPJZOdfHzjOC5H8RBF9i696ha/dstMLUsx/r2MlQrkfOakIp6WgFPU1yMMQptZNb7dc3uCNSN4SpE5+P2FUIr2N8Yu2AGlLepcxo2++3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0IwPpuia5BJ1mdlZQxcSEKwJfk0Z0+SpBa0+swQlwQ=;
 b=oqB2h06iG2miwskDw86HK8TaIuvmUWEv1x+OWyFChIa4D4sUtyu9cidyqH7ghkhwHBpRHLpzryqv/yEOHo9Y4AjU5yqD7/vK+RlJMnolnWJyLhykY8TZDiRLTMBLLuxHgm+dlSRZsy5iLKupuPXXRKaaLhAyuDCubGEt3SWmGMQx/SmO4B+/0A/z4AN+xBaEq79MRNNOrSvnSuqb4JwdFBxdyd89n6yvo3Ae/5iAkJ/26sPVGWFDEqR1lgDxsmFxAFaO4h2p42V6laumXfhZZJ9/E2uOgh9aivh0l3fdCwUd49INyv/VH0x0Tb5ZeHyPDIr7NRibTrCQ/Y14cdnVTw==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEYPR06MB5157.apcprd06.prod.outlook.com (2603:1096:101:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10; Mon, 11 Nov
 2024 11:10:06 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Mon, 11 Nov 2024
 11:10:06 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH] erofs: add sysfs node to control cached decompression
 strategy
Thread-Topic: [PATCH] erofs: add sysfs node to control cached decompression
 strategy
Thread-Index: AQHbLFlCJx14bWEOn0mDZXMXerlpfrKxahEAgACRwYA=
Date: Mon, 11 Nov 2024 11:10:06 +0000
Message-ID: <e1b73e98-496c-4d39-b8b0-232cffa266ec@vivo.com>
References: <20241101124241.3090642-1-guochunhai@vivo.com>
 <0fa61236-e84b-4a3d-9804-612b33d166da@linux.alibaba.com>
In-Reply-To: <0fa61236-e84b-4a3d-9804-612b33d166da@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|SEYPR06MB5157:EE_
x-ms-office365-filtering-correlation-id: 1676962e-3693-4800-b673-08dd024165d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:  =?utf-8?B?TDM4U0RxT2NIeFVTKzl1cFdmU3ZKMDVmUmJQZVhyc2RxblA2eE95QmJJRkVm?=
 =?utf-8?B?NncrVlZUbGZibHYvb3E5eXU0Y0lhcWt2TTJNa0p3WndTVEVseCtRSDlBNlRD?=
 =?utf-8?B?Q0pRbTFWQytTSWpOZEk0K1drZHQxeDFyYmxmbk92SzYvc0lhU0FyYzRkNHJ3?=
 =?utf-8?B?TWVud3JrK3A4S3hDTlJPb0xrSjgzUGNWRWtnNjFQeThBVmMzV3pxV3ZTS005?=
 =?utf-8?B?bTJ2YVdOZkVsVG1FVXQxSEg1Nlo1L2xnTWtLTVJsRlQrV01EVWJoNThQZWNy?=
 =?utf-8?B?SjhBMzhNUTZHSHJsakJCNTczbHM5RHo0eEdmQWRUWHNBZ0RjSWdsRDdqMS9F?=
 =?utf-8?B?RnFLbE1LNURHbklzSUsxc1N4VXNJR2RtbEcvMm1zeHorSkJhVC9MRzhRYVZB?=
 =?utf-8?B?cG1KQkVtZWVPc1N0NThTaHljQk81d3kwWjc4dU91U2k4QXUvZUlSVC94YjJn?=
 =?utf-8?B?T1d4dENjUDgzN0xSQUhkZUszTnlWYkJ0Nk05V0Fsc3R5OERYQTJGLzdKUGxB?=
 =?utf-8?B?dHQ1WDk1Wm4ycXlEVVBEK0l0TTM5NFFETDlCKy8yajR2QkprL1NablZXdGJG?=
 =?utf-8?B?akZtK3M0SWplOTYxTGVMd0R0M0xYVHhNWmhLR29xc0VOM2QxdmJxUU1zNVBK?=
 =?utf-8?B?QlJHbkpKMGlkdWxKSlNjWjdMek8vOTh5ei8yS0pGVGthaG94aHhsZjdCRXVC?=
 =?utf-8?B?R3l2eUhaMmhYbllzZ1Iwb1NWZVpybk1NRlFFSVVvQ3VIa21TZmV0djBMdEsx?=
 =?utf-8?B?Q1FFYTFKRW92RE54cGxDTEtTMWRsM0hxSjR3bXhtWitScFRCZlRwNjJncnF1?=
 =?utf-8?B?WDQ4R0tkeHkxVys4aDkzeUtJOW81U0p0VDczZHhrV1doKzhoSWNiUEYyUkZl?=
 =?utf-8?B?cGMzdnZrbStZV3FCMm5CU3duZTN2Snl0VWVnN2ZBTW1xd2x0MGpEb1ZJaW94?=
 =?utf-8?B?N3lMd3BrWjBPQklEM3EzQkVRVXdzcnAyNldveHVRZXhTVDhBd1loOFRWN2k2?=
 =?utf-8?B?eEVQWG4zYjFVbDVFODJpT2hncWlOay85a0VtTFV0eUVPNDV1SVAvcmt4cjE4?=
 =?utf-8?B?VGJVcDcxOHVzOTRsN0V3cjh5U2s2a085SzlNa2xsTmw1aDhKZDBSM2I5RHF2?=
 =?utf-8?B?MFBla3gzS3BBVE5vNklmT0ZnVzNrMkZobEF3ODcxc0VxYUtiYkdtSTlJZEg2?=
 =?utf-8?B?enpydnl0MkMwTitQbHc2RDJXVXVtd0dJYjdwbkdJNnV1SVZONGlzQkZ3YmZl?=
 =?utf-8?B?U24vODJpV21qL2pCVUpBcVRnS3FBbGl2UVlCTXl6dXluY3B5VEVsak5YMEhL?=
 =?utf-8?B?T0hHL1JPSUIzM0tEYS8yRi9VUk14b2hBVmlIMUo2TjF4a21MYmhBMnJhaVcr?=
 =?utf-8?B?NHpHdXJDK1c5UU1VUVNlMFZmUDhnUUMwbUJnZndNSUpPWHZDcGRsampQNjND?=
 =?utf-8?B?MGVTRmJYMWRhaVlFc0RoK2VZQ093dVpFcGxtN1NTOWlJbHpSWUE0bkdvdWhr?=
 =?utf-8?B?TUNMb1pYa21NSEg3NjM0aGNOQUNHaENBSSt2TDF3bDk1VGlPdjFZbFRJM0dL?=
 =?utf-8?B?UGVMOUlWdC9Mcmcrb3NpMnZIbnJUS2NKRW9jUDh1U2dqSjIvRGVLTDJKUEo1?=
 =?utf-8?B?aEVBUHlFNlVldk5DRGtVRlBrUlhTNUdNNkI3V0dWai9NUGhHaW03cFNoNzBH?=
 =?utf-8?B?OTZMU0RpVVJ5Q0xhUW1UcnI2WjhpRDFFeTc0dUFPai9PelprdFdrSVNpdUlX?=
 =?utf-8?B?cnlCd0MwV3RhOUlQbDBWSVp2bnplbmt1bUErRHBHVWEwM2dMOFJKODI2QlNT?=
 =?utf-8?Q?Q1VFluTS1f+X2NAxywY5IfCcAUvh3CYJFRqrE=3D?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YndqOXkreFRLaTAyeWkzdU1BanVlcFNVSWhPVkNwQit2TjRKcTRXT05VS1Fu?=
 =?utf-8?B?ZnRaRlFzUm14SHNnWUxKQ2hXd1grVFZZQXJRRGhCNkNxZ0YzUGlBY1UrYnpo?=
 =?utf-8?B?UHY3anJMdUVwUnk1NmtaazFPbWcwNVArSllQTnc2bWJPd2JOM2FzYktHRnVx?=
 =?utf-8?B?cjArTUVyQml3a2U1eUJqRUVVUnN6RnBVbEUyYlpuWTRHZktKWEFHZllWd1BT?=
 =?utf-8?B?WXYyWjAxL3BONTMyall6U04rTUdhazUwdnRzeUZPTzBWYTJqc2I2a3NlNVh2?=
 =?utf-8?B?UHVxYkMwaUZ3em16MXZ5b1hqRHpYY21jN0xzajdIZkVNOGRIVzY0MkVSY3kv?=
 =?utf-8?B?dkdPYWdFak9aTUdXTmlJVEtNZVh0djNqYWltSkRDamVPVjVFSDlJbzRrN2lE?=
 =?utf-8?B?OFdVcWR3bXNPdHBFeWNQUS9sZ2FZS2ZJRDFLZzdPbnAweXVLMmp0UmpnOHpi?=
 =?utf-8?B?d2lROWZDSVBwYm0rVTNEclpGUVdObGU0WC9zRWlsNk5nSzcwL2VOMEhob1Bh?=
 =?utf-8?B?VWRXd0tSdTdBSVluRUZwSlNlNURmb29kMHh3VVloVDQvR0FBZkRHaEw1Rlkw?=
 =?utf-8?B?SGxkMWhqQVdWR0VmRXJ1L21vVkpuNGV0RHVTY2YyczAyNzdwUU82RHV6UHg2?=
 =?utf-8?B?ZzVuU1NTYVhyY3RiQmFYQlByeDdYbGkvOUdMMWlDM3NXN1ZiSGw1YW41VzEz?=
 =?utf-8?B?NERiSWs4Uk9ueC9YRnpuWDBGUVdWUnRrc2pLcnJtTmdaTVhIRC9ZWHpYamUw?=
 =?utf-8?B?V3JzUFFENjhtRUluVlFqNE1mZjBXY25JeW43d3gxSFpaU1UxalYwUjFEMTFH?=
 =?utf-8?B?ZUdob0k2SndnTFdVTFZZcXlPMnlMMmpoZnJiZTkrRWQ0SkozWkZDaWtXUmpq?=
 =?utf-8?B?OERpWG9taElFR2ZBVWxSazYvY3duZG1HQkFrdmk5NHhjYXYwOEMwbnVveXRN?=
 =?utf-8?B?SDlIa250L0FVRVVGNzB4S3FrVFlaaFF4NVVoMlNCaTFydkV6R0l1dXRSSFp1?=
 =?utf-8?B?OG1tVm9jR1AzWFZkZFZlQldDaEZJTVBRaUgrcEhVL1FmM2NkTmtWckd3VUxL?=
 =?utf-8?B?aEdOb3EyQ0JOeWtIZENMMWh3Z1VJaGF6blJzVnA1UU9pMVUxRUJTdUxieXhz?=
 =?utf-8?B?ZEVWUlhYYVRGL3BUaDROcTJDY09hQ3V5c3lCYjZhM0NybUlaRFJRUll5d241?=
 =?utf-8?B?UUJsVkpUdTFON05BcUNvSnR0cHh1eWR5eEFMeXh1SjJiMStWZTVwcnRockw0?=
 =?utf-8?B?aFRCTVh6NldCV0pCdDQ0T2xKLzhnRDJqbVFGam9aaHBoMXFCL00xdWNSVngy?=
 =?utf-8?B?OUxYUTBRWGZwdloxOE5VNTEzMTRzWlRNTU5sVm1BSGlxYU9vSGdWV2R2OUVV?=
 =?utf-8?B?Wkx2dGR0NnlITlRXUFRPTW1DZUhOQng4bU5IM1RoOUJiU2RXMUNXQlY4bEJz?=
 =?utf-8?B?VFZDQXVoR3NScUFuUFhLd3ZSaEJoRkc3NjEzVVFJWndIRTlZcTc4ekhxVGpv?=
 =?utf-8?B?WlB5QjljZ2FSaTR0VXVNWVZPL0s5VDl6Z0pDSDBvZDQ0MHlwZS80RUQyS1Iy?=
 =?utf-8?B?Q09FNWJLWkhia05TUTVndkRhdU9pSEhyL3FBZVM4ZWRYZ2k5SEJoUlZYR3dm?=
 =?utf-8?B?MkFHRzk2QUs3cDlwek9pMEtBTG8xUzBJRENFc2dFM3I3T1BsYTZ0MDRyb1Jk?=
 =?utf-8?B?d1ZpWkZSTlhQMDZXaE1ITytxTkZMbk9DS0NidHdRNG5aUTVqc0xrZDMzWXZV?=
 =?utf-8?B?WWxCV29hRzZFMjBZZGxtQ0hkRHZoc2V6RnFoUm0ySlgvNjZQb3Uzb0ZsdVJX?=
 =?utf-8?B?M2kyWUE5VThheExTMmZYYnVHRTlZaHJUVkl1dENvU2pUUzgvU2FMU3Q2Y0hQ?=
 =?utf-8?B?Sm1Dd0FhUDVVZnJNY3orZlQ5Yk5BWTFuTFppc3A2Nkl5dm1helNmRzdyOE9v?=
 =?utf-8?B?dGwyellydkhXalVxb21Vck5IV1RVSEFHVmRXY2poYm5hM0tUejhCSzdvdEZy?=
 =?utf-8?B?ZTN2cE1GTVhmK2MxZkNjbnBaSHBmb1lqbjQ0Q0VpL01NeVVOZW9tbFdsSDVK?=
 =?utf-8?B?MlZJVCt6UVp0c1NkZ2RMUks4bHlFUDZxMkVZYU51YXc0VmZ2a0pVR3dqNHFK?=
 =?utf-8?Q?bcMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09BE994812606649A5B4AA29401570E4@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1676962e-3693-4800-b673-08dd024165d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 11:10:06.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCVL2loJ6kRq/DCmSlBvpbGPJmlNj1qT0RbXg9f8wU/Kpq/oC0uJgm7BIVEFiXVu5k18jGmFfEimEVioo5MCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5157
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

5ZyoIDIwMjQvMTEvMTEgMTA6MjgsIEdhbyBYaWFuZyDlhpnpgZM6DQo+IEhpIENodW5oYWksDQo+
DQo+IE9uIDIwMjQvMTEvMSAyMDo0MiwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+PiBBZGQgc3lzZnMg
bm9kZSB0byBjb250cm9sIGNhY2hlZCBkZWNvbXByZXNzaW9uIHN0cmF0ZWd5LCBhbmQgYWxsIHRo
ZQ0KPj4gY2FjaGUgd2lsbCBiZSBjbGVhbmVkIHVwIHdoZW4gdGhlIHN0cmF0ZWd5IGlzIHNldCB0
bw0KPj4gRVJPRlNfWklQX0NBQ0hFX0RJU0FCTEVELg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENo
dW5oYWkgR3VvIDxndW9jaHVuaGFpQHZpdm8uY29tPg0KPiBJIGd1ZXNzIHJlbW91bnQgY291bGQg
YWxzbyBjaGFuZ2UgdGhlIGRlY29tcHJlc3Npb24gc3RyYXRlZ3k/DQo+IE9yIHRoZXJlIGFyZSBz
b21lIG90aGVyIGNvbmNlcm4gdGhhdCByZW1vdW50IGlzIG5vdCB1c2FibGUNCj4gZm9yIHlvdXIg
dXNlIGNhc2VzPw0KWWVzLCByZW1vdW50IGNhbiBjaGFuZ2UgdGhlIHN0cmF0ZWd5LiBIb3dldmVy
LCB0aGUgY2FjaGUgd2lsbCBub3QgYmUgDQpjbGVhbmVkIHdoZW4gdGhlIHN0cmF0ZWd5IGlzIGNo
YW5nZWQgdG8gRVJPRlNfWklQX0NBQ0hFX0RJU0FCTEVELiBJIHdpbGwgDQptYWtlIGFub3RoZXIg
cGF0Y2ggdG8gYWRkcmVzcyB0aGlzIGR1cmluZyByZW1vdW50LiBUaGFuayB5b3UgZm9yIHlvdXIg
DQpzdWdnZXN0aW9uLg0KPg0KPiBUaGFua3MsDQo+IEdhbyBYaWFuZw0KDQoNCg==
