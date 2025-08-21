Return-Path: <linux-erofs+bounces-858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD43B2F41A
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 11:37:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6yrv1VF8z2yhD;
	Thu, 21 Aug 2025 19:37:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755769023;
	cv=fail; b=gfD61BstoZFU479+uxQAzK+DF8ZmLUy9MH8C/c6fMb1HJJ7bDHLKLZKKWw3XHHp5DehbKXJehDElgJjkYVVbh+2cNI1ll4HdEkrFGMjxnDQa7jp08UwDz5NSikWmVd93sjHsnyKcwVjHGinvjO9fAvBTe83vev9heqYR9jbKVbJDV4ILoUlV/gVJcU3Whb5hvopZ9D8B6i5PcBa9ht652OXww6P8PURgSPnp1Kk2qHZ+jKFy9QGQH+7EwLm96LbjjmqjyZvalkAdIKMtERKw9oD//lCxXuGvW9OSy87nBMNkJtqbsWbhYf4F91dfVqouLNpjDoDFhxW/fTxtrLv1bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755769023; c=relaxed/relaxed;
	bh=GyGbNHdak8YrMbZYliAHr2HET4nogQdcVImIMiW/3v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cwtmSXYdbP8scCGLwyQx4r4itBj0cLBy3OvFgOxS4iBhmeudhTVEDdqizOgnXiSw+Klxe7OOea7qRPhkvKzHOalErFYMKLztZY4jUSXbOpe6czhcdw6v7sAFoLAU8cyPJWKI2WhDVFCN8ZpxH0c7z7wGOzycw9FfHnHyjDNrxh/8SQ+LQT01P1LxnVvaKtVAaZf0mSYqYJS8i8LhkqbKMAhUxTr3WFcGuIJ1GtICKN6ckfEkKlr780Ul08TeiI4s+BfugS9ueR9Wu4vibVLCP37ySLPRn80rQZ8ekZWYtKfKrxmqL+TdxV01hEgHbDaoibAx4fysBomJZdxy9QLxEg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=UW5UHrfH; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=UW5UHrfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6yrs54xtz2ydj
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 19:36:59 +1000 (AEST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L5KLh2017211;
	Thu, 21 Aug 2025 09:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=GyGbNHd
	ak8YrMbZYliAHr2HET4nogQdcVImIMiW/3v0=; b=UW5UHrfHub0XqN8XcCJOQVZ
	is+nT2Tr1t1hcgKAr9zBF1nUJ2l1asc88b5XXIAEnArj3hff1Iq+4UTZFkLT84L8
	704OCjqymZQopnFOgCWL7UPxXGSPywtWamIhnxW2Jnlhy5RpMmzYZGZVfpu4zWPh
	ktMrMaXOppqrIqglONW6/mpVN4TBx+URRE1Vv8sFR5eXj5hof20BMIcg/Yq8cIqC
	1s3tOk3umI7lLJT+3e0OM7yT/Fcf4Rt7R1J7Ej+Gro8kO0GUi+1wMs98P5XdnM/T
	c+JpxA2q0wRMs9ILbR9DIR2qk1Pr/ptb/GECP07LnZz9NNFh0SB/UebwJwR6iOg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012052.outbound.protection.outlook.com [52.101.126.52])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37j9kuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:36:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYJj2Z5in5a83Qi9GPC+JLYeTPgZNC8gNmRutpBkQKU0SBAHHwqDrM9IOJM06MaPc41RAHiOGW7UJrB8zSARf5S90E2kie63gXN4Iz4Gk2EO85OkpE6Ai21cvdKlCDVXsMgqT9l8kGFqtXxk2NObB8974xG9a6Qo5WU2Vh/9bk8vTCf7mZUja/iCNLUH+dUxwny0lnCx0IpfwQPlIPiDHhRlmphS2hLEne3hLLj7RXGe270v3/2zsCnwBxgdNJ/FVJkC5potjaEedJliQoCrenIjkK0BShe1T4IGbB48q75QBWldg238zmQi2N+xNqF4qSn2Mfmbs/9I7Cix6Q+9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAsYHqUMzGD374l1yvim4BKdX0Q/AMjUzGKZiyOpDb0=;
 b=SgD1HE9jGxDqj61fS96QLmr087H1k/116XNa1IyW2N8WehkXwQWHQoAP6PB0/8bOqeMr2CNPuxFMXNzpmurGFNSMSY3YSX2/O1zJwr7xbFmGNtV/9DZzbIV79DjJMawO/SItWa65JTxlyEbATOi01JRH1J9ENri0a3q7UYVbG/2atXLRrargZaslLK6VOF0yvA2NgnkuD95aRV98lu5xiXm6kICMOtbFouTtbVLFOi4Wi2jfTFs6v3MCCUwCARNjXfeAK2HeNUkPWcrfJbpAXRRybYv5kbACNbYxmDSrn5C/MZc3ofaqNZhjDXT6dvk4qho+08BemqnUMO5MtIL5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by JH0PR04MB7624.apcprd04.prod.outlook.com (2603:1096:990:62::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 09:36:41 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:36:41 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Topic: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Index:
 AQHcEaR09AqiVESPN0KCsjRcUS8Fb7RrKVGAgAAPTIqAAAkdgIAAAwxBgAEWsQCAAAc614AAErQAgAABnACAAFAwXw==
Date: Thu, 21 Aug 2025 09:36:41 +0000
Message-ID:
 <TY0PR04MB6191740A411A08FFABE272EFFD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
 <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
 <97d6c19f-1faf-423f-83e7-0996fff2ca26@linux.alibaba.com>
In-Reply-To: <97d6c19f-1faf-423f-83e7-0996fff2ca26@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|JH0PR04MB7624:EE_
x-ms-office365-filtering-correlation-id: b9db4c5c-4906-4bca-5f8d-08dde0963c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1hXYWh2d3hQZTc2Z3FCcE9WT3REM01XV2FMdEVrdENHbUo3N081aDh0V0dU?=
 =?utf-8?B?MXJkbjVWZkJBd3VXQnl5YmRENUpzOEQ3SG03VExUYmIxTm1INVJFRXdtUkNM?=
 =?utf-8?B?eEVjOS8xNjlWSVJ6QXA4TVI5QSs5YkFmcEhhaXRsY0FueHBSOWp0TDVKNXVQ?=
 =?utf-8?B?aDBZSlkxbHhiWGw0Z2dYTXIzUW83dE5sdUlmVE1tOHJ3VWVNL1hPVW5UTFZy?=
 =?utf-8?B?Z293eUFzbnFZTURJVEEyUE9qTG1odEFERVVha2NNWTRIMFArZUtyakI0SERo?=
 =?utf-8?B?OUR2ZHRtNWNsOStQVFFYdHFEZjdHRW5OWFJTcnF0djVLVHVTdnFjSkdFVW52?=
 =?utf-8?B?TGtwcTZDcGp0cllCRmVkazJuaFR4dHI2Y0t0Z3hYUTQxSEg4Qnk2NGh4WWk3?=
 =?utf-8?B?K25UMFpBTjZnL0Y2U0R2NWNaeXk1bkZNRzIzaE5wMTJ4UzNTMER6cVJxTGlL?=
 =?utf-8?B?UnpWR3d5RUtRZWFEOHNmR3lFYTJpQmEvRDNOVmVkNERXc3p3c0NjQ2h0WDlC?=
 =?utf-8?B?eC9zTHJNODZnUzI4WE11UjhOMmEzdjY4VjJnUTJiaXgxS2h6eFY3RllHTGhR?=
 =?utf-8?B?YnRMY3MyRVIvUjBTMlZpaWlCSS9ObjZheGNTbHlZbDA4WmxSbUJJdmZDeUht?=
 =?utf-8?B?UFY5WlZOTGhvcFp5UkZ5MG1LZ05nY2w4aVp5ZDFpTXBaT3hIcmlhRDE4Vlpx?=
 =?utf-8?B?QWxqZDNoT1ZZQUhzaUxzaHhiNGEvYUpXdDU2OVBiU21XMHM0TUdESzNSaEZz?=
 =?utf-8?B?ZXJUb0R1OCtYUHZiN2haME1BOGw3Q2JNV1NqVzVueHMrTjdoamFBQnRJL1k4?=
 =?utf-8?B?QVdWcTAyeWU4dTlPTmloRGdkcDQxTWJLYjdhUlBsa3ZBaDdRK05Yck50VWpJ?=
 =?utf-8?B?czdqY0NVZitwTU50OWdYVmIvQXhEeldxNnlkenpOWjk4elBXWFZmM2szb0Jx?=
 =?utf-8?B?VGgxcHliTUJGZXk2UCtmQmlmZkxlTFU0SjlmTGk5N0hBUmgwSTN5Y2h1N24r?=
 =?utf-8?B?QXdpcHBIUXQwVmJsYlJnbXZZbk1WMkt5dzN1WlBxV0JtaVJKdGRNM1JKMm9J?=
 =?utf-8?B?VUZMUFIyc25sVFBHVlpFV0MzY0ZxbElOTXkwc00xN01SR2xYcUZxdU91OXF0?=
 =?utf-8?B?bkljaE5KYVpqSFJZWUNjaDBRUDZXa2RDUFZXMG13aDhzNUwveWgwZ2NpOVNY?=
 =?utf-8?B?dmFBd0ppVHpnQmVJQllxWW5XSG1Gb2VGYzlWZlg1WkRNT3JRbVl4R0Z3aHJi?=
 =?utf-8?B?NjdRamFYOTRyTW5LT09LeUJYLzNzMFAydm11eXBZZXkwZ3JRSzVZYnhLaFZl?=
 =?utf-8?B?M216UDlFTXI3SXJmeG9ZNVBDSUg5K2tkTVFxbm5WWTdCWWs0aHN0ZFA0QVBN?=
 =?utf-8?B?Q1BhbWhsUXlTMThnOWk0YW1ZSGFKNzk0ZnRJcnB0cG1iQ3c1Y3lVcVJqcGZ2?=
 =?utf-8?B?Y2FKUjZHYy80MVJ4WVA1eWpEeURnc3lkbXdENDRhS2ljSmtQTENDOXJSc2V5?=
 =?utf-8?B?WFBlTWpUUTFscFNRam5kK0lHQ1N2VjA1eW5mSFFHNEJtWnB0T3RIS1h6ZVFC?=
 =?utf-8?B?UGJLdG5rYnppYlpGOWkxNXljOGtBbWVwNVBxei80em4xZVUvWUJSZ01NelA0?=
 =?utf-8?B?QTdnd1pDMkNpMnZsb3hoUzZOb0RwcjFWNW1rS2FLQkJVdnpQZzZLL0tsZ0ZU?=
 =?utf-8?B?NFpIL0pPUHdLbjlIY2pKRldwVURLSWQ5OXI0WWNOdlRwZ0dCbzdRRG05UHl0?=
 =?utf-8?B?RVhOSHNMbWdrZHo3aTlYelV4a2pSMS9PcWQrY1dXU2Jmb1cvMkQvcWJhR1p3?=
 =?utf-8?B?eFNrQjk3RTNldi9PdHIzMU56MVlKWlZoemNYWEgwekpVR2xSOVZVZm5tZytv?=
 =?utf-8?B?YzBOVFREQXdZWUczeGNnQXdmREwxME9KYzRzZStLUitBanJJMTR3VmpObUxY?=
 =?utf-8?B?TGkwbFdXUUN3Zi9KdzhNY1NvanJkWjMxQkIwL2dLRkUyaUJNMXNPSnFkR1R2?=
 =?utf-8?Q?A1wcDK2ko/yOVVrEXQs7Kq871xT9MQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUZMZHNWN1J6Wi9OdUpnMmNFc1Y2NVJqTlZUVnZ4Wm1tcWFYWjVFdFFkMFNr?=
 =?utf-8?B?ZzlzeHNyWW9ORHlRMGFrTVNhb3FHYjgvUXgxTjVWY0ZoQklsWlhtUU43MjRY?=
 =?utf-8?B?czgxcjN6SEU0SXdwYnhScGtlYW5haTIzZDR3TkZzdUt3dlgxeGkzOUJCZFli?=
 =?utf-8?B?dXVnR3RRWEF1NEg3RVF2Yjl6bVJLYktSS04yWmdNM2tpZEwvamo3MStsVk5O?=
 =?utf-8?B?YUpmbXVyOFpNNWJPczFzT0FhM2ZVZlMzMGZYQlJqZ1NzS0hVdTlpOGlVTW5Y?=
 =?utf-8?B?T05kOUhZOHdEbkU1NjRMMWpQTGFLZ1FFR3NvbytRTFRMTUxyMWg4VmpUMkRM?=
 =?utf-8?B?elY1NURreHdITkcxSTJ0S2NFajV4VStXUTY1c1R5RHkxUDRJbjBvUkhrSWxo?=
 =?utf-8?B?N1FPS1VvQjB4WjdWbTlZVVFGNGJkVFFXYlFEdlVqTmJqMmVYdFpsWm1tZkRh?=
 =?utf-8?B?U3dDUENsYXVwVUxwNmlCWllta0JlNEJ6Tno5bXAvYmJ3TTJhSDQxUFB1aVcy?=
 =?utf-8?B?NGNOSE0raDlDVG1wamRWOW1aU1RIeGRPa1RJdHVEUWNLR082UHlDWHdlclpj?=
 =?utf-8?B?TVJvSmFRTU9RZ2lmVC9nSGZDVzI2QS9WVWt2NDNYdXRobjVQKzNYTGJqbnlP?=
 =?utf-8?B?QTJwa1NvQmd6WjNrbXhEU1duV3kxU2JpTXk5aXczUHFOWHN3N3owbnJBMHVY?=
 =?utf-8?B?YncrL29pM0UyZk9xdDBkem1sQzRGcVNHQk83VFRhMGxFTXNmU1JYSzlrVldF?=
 =?utf-8?B?dk5sTGFZM2dEamtmcDArRXN1dXByWnJENkl4OGN5Sk1YTW1INU5vc0VoNlN4?=
 =?utf-8?B?MUV2YVZGZlBZT0VXejZpUUxYb2U0MjFRaVBhN0Nqc1d5b0hLT1VOT3pvbW9l?=
 =?utf-8?B?dEFYd3ZnQWRQemFKdnR6Q0EycXNlTmJwc0pXcHc2bnN4U0UrQk12dlZiWkYw?=
 =?utf-8?B?eEtRbkpURXBlWiszQkV3UlFqd3cwK1ZHVnAvTjBFci9VN09KUy81YnNrbzhF?=
 =?utf-8?B?MExBU1JCQnErSkpUTExzbFV1RjRhZnZ6NjB0bFVtc3dsSTZJemxMUnN6MDF6?=
 =?utf-8?B?WDlFZDlXUFNUQ0k1a05OUkUvbTFwWXVVZXFieXB3b0ZhdXM4SkRqazhUWGRY?=
 =?utf-8?B?cVRqRVJBTjV0ZkdVU09iMmtBblI1RHp1Z3NhL09tQ21LcEFrczFRTzFvWFFn?=
 =?utf-8?B?d21MU0l1ZmlEcTMzVWtidUsrRUpUTE1zSHpKYm9MWkhTbklUSkk5Zksyekdw?=
 =?utf-8?B?dU5BY1h6VUUrQ2c2UE1Uc3RQQU5HSXdWKzdTUHEwV2pkQy9IS2ZKOGtmdXdQ?=
 =?utf-8?B?Wi8ydDNTYXhaMXllNEo3Z1dTTDdEc2hXejJRRnVKU1VQY0ZROTNUU2R5eW5y?=
 =?utf-8?B?V2pKbStuUmpXdUpWZUgvNHpiUVNyUGZUQ1NUQTdnSStvNTdDampjdGRsZWNR?=
 =?utf-8?B?emhQK2ZVUTFCNmJGVFZPUm1qb0J6bHg3MUU1Qko5NkthdnVXQ3V1N2R5eEc2?=
 =?utf-8?B?T215ZldvaFRraGp3bC9hVVhoZ2FpQVpxOEQ2dEV1NmNLTEVKOG9wUkZNUWUv?=
 =?utf-8?B?TE94S2pFL1MySkJrSXRQY2dHVGl1TW9yTU5xRjlFQ0QrempNN0FDOGZjN3Qv?=
 =?utf-8?B?bTVBalRKNmU1UWNheHFHSkdJa2NWemY4bkhFUitBZmcra1F1cWNMc1BweEJo?=
 =?utf-8?B?WDAzRmVUTEVXeVliR1JOVlhHS1ZFKzRtOUdFT21qMVZDSkZqbnNibVdoL1lZ?=
 =?utf-8?B?ZHdseUhlak1KSWVlWnpvT0N5REVxL2sxNHpRbGhHYlduM2Y0WGNZMXBaQVBp?=
 =?utf-8?B?UTFHbWsydTA2RmhUTUtUQlRybytTbUt5NkpyUUhSWUhVTVl1WFVXQ0pnejF3?=
 =?utf-8?B?Mld3RnQ1YlYydHNkK2hHeWViM3cyeTJrditMMVluaW1uMDZBQmY0Q1RhTW52?=
 =?utf-8?B?RDRXSm10Y25neGVvbWtEcUVZNFBYTEdoUGpJRFA3YVloM2JDU05vajRMOEdU?=
 =?utf-8?B?eGdrd0MzV0FiK1VJZ2djdTRMQW5VUDBqbHEyM0Z2OVBReVVrOHdSYmppem1w?=
 =?utf-8?B?Wk1QaVNNVFYxNEN5aHlGT0ZLWkJuWUFqVmNaRnlCUVg5U3NVUFJCUFQ3YlVX?=
 =?utf-8?B?cldVNlNxL29kZmRPWDhFNVJGVHBYUXlXSytzSUNHMTcvWm9aY0lUMXRsUnB4?=
 =?utf-8?Q?9JOEAXc73Eq3Ex7o0N/Ryd8=3D?=
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
	qqIOsrM52+oaEguOkiG6RMP3qVweB7hLD6JtkdhlzvXM7TCGGOAUBJ0TPL5X43KIxKMEdmojcG0LFmgnmyxi1G7L0IaSx5Toc59ZAwaY75HtsAV2d9AsqLlAPdeYuR92OK+EROoOejyhY/4a9xhBwwCzB71Foj7o8oWOh9JY3tQF68Ew6KZGAMf4dZQr9Ib+L01Rtj3hNeIIaBzAFmDMqGulK84RJeOSezl6VMopQD5S/LPEpKG0PoE0H1gP3rm7E8iX30VKx0ubdd6ozqmXnGAJkjbP6Lnpiox62sNUC0PAmuN1M9Sf/VV5wfn2En5ewNFk6XnRiYPHO63FtWDl0o2ItBArp9QYNPxn9fQjte2ClDqQRhdXDI31VRcPzELakfzmszGwVcQxQZA/U734olxYL4lvDwXfkPFt0j0ImRdWNI6cZj7xiJKrX4zPVD6GnPIEH6wWanAEDvar8tGqw5uRj3V49hMJqI0zpRFVPbc0Pbt9NLuwe3JRftLuW37AGIUJJS6/yAdP2x8EPB+AZXF3S+2L4a1y157lov4rE6e6cYI8MfvR2oanCWEO/jYhY3IqznvUCL1FqWnIyO97SgVAoRivVYiQdtCWHrAt67wjr7DNnGYPVhd+Mu+g7c+3
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9db4c5c-4906-4bca-5f8d-08dde0963c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 09:36:41.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAvtFDPOa+QPv5RzUpQ7Bsf1pwTEIVofeKljCGuBNwC0t1iqnmdToRxPKIOTd6MqPY0lJ/rP/2qapZ0Sk7PtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7624
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX5R0/p+IUD/oR YWg4SjY1+/3qsWMECTojf3ScPGwMCoT+h+mUak+2E/uE7or4pbjmHK5YoBIi+BCRWkwwTz3HhI2 01zWvFgx+XnuvYt4v/K8RcHVTUCg9noPeuuNVS9I4xrnSwrNLYqNUKgE4tabXruIf2Sm7vP66ro
 1vyCbnl0Ujwto6Q8GTjkgcAnZwRxG/D2zUavRqa0ZQnVDXif5a9pmpnbYrn2pw6k83641uHRg0I TU7+gJuEHRz6lkmR0EncWI3e6iLtDG+1WdRp+ySx9wDClwG7v2N0nRx4IMjy2tivoznL/8w3p64 HqgFV5MTokfi+6y5QyrW0kBgBv++T7lZ/t+xgUrwVTKJDiWufYYBWy4BPygqH03162CYa60yoUy
 xR2OoAAfuqcwB7teRL9qcst1GP42KQ==
X-Proofpoint-GUID: KeVmGC_LGQMY6k7At7eIy3ZFm-mhg8tD
X-Proofpoint-ORIG-GUID: KeVmGC_LGQMY6k7At7eIy3ZFm-mhg8tD
X-Authority-Analysis: v=2.4 cv=A8A1/6WG c=1 sm=1 tr=0 ts=68a6e8b3 cx=c_pps a=/r23toIrMTbB0C7u6HAPag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=61dmBc3scJhz3e39i-wA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: KeVmGC_LGQMY6k7At7eIy3ZFm-mhg8tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,

> But if there is some deduplciated chunks in the logical dsunit
> boundary, don't align it at all since there is no real benefit.
> Although I'm still not sure what's the default behavior of `dsunit`
> for chunks.

Exactly, if `--chunksize=3D4096 --dsunit=3D512`, any 4K deduplicated will c=
ause PMD map failure.  Can we consider the following countermeasure as defa=
ult behavior:

1. In man page, describe 'chunksize' and 'dsunit' should be collaborated to=
 achieve the best performance.

2. At runtime, if chunksize < dsunit,=20
  prompt alert message, tell user it is better set chunksize=3Ddsunit. But =
still format with user set options.=20
  The benefit is user can still set as desired. Current, for the use cases =
we can imagine, chunksize=3Ddsunit is best. But maybe users have their own =
use cases, it is better let users do what they really wanted.


If mkfs.erofs force to align every 2M, even there is only 4K not deduplicat=
ed in 2M, the 4K actually still occupies 2M.=20
0, 2M(only 4K data new, others all deduplicated), 4M........
Space usage efficiency is same as chunksize=3Ddsunit=3D2M.


Best Regards
Friendy=20




________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Thursday, August 21, 2025 11:39
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/21 11:=E2=80=8A33, Gao Xiang wrote: > Hi Friendy, > > On 2025/8/2=
1 11:=E2=80=8A17, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom wrote: >> =
Hi, Gao, >> >>> So I tend to just constrain the case to your limited case >=
>> first, could you explain




On 2025/8/21 11:33, Gao Xiang wrote:
> Hi Friendy,
>
> On 2025/8/21 11:17, Friendy.Su@sony.com wrote:
>> Hi, Gao,
>>
>>> So I tend to just constrain the case to your limited case
>>> first, could you explain more if chunk deduplication is
>>> needed for your scenarios? and what's your real `chunksize`?
>>
>> chunk deduplication is needed.
>>
>> As I wrote in commit msg, we expect scenario below:
>>
>> 1. mount with -o dax=3Dalways,
>> 2. application calls mmap(addr, file).
>> 3. application read from addr, page fault is triggered.
>> We hope in kernel, erofs_dax_vm_ops.huge_fault() can be handled, do not =
fallback to erofs_dax_vm_ops.fault().
>
> I totally understand the runtime side, but in short:
>
>>
>> This required file body on blob devices aligned on huge page(2M), and de=
duplicate unit also is 2M. We can specify --dsunit=3D512, --chunksize=3D2*1=
024*1024 to fulfill this.
>>
>> I don't think need a new command option.
>> Currently, '--dsunit' can be set for formatting blobdev. The following c=
mdline completes successfully. User certainly thinks mkfs.erofs has execute=
d --dsunit alignment.
>> But actually, it does not.  This patch just simply makes actual runtime =
fit for cmdline looks like.
>>
>> mkfs.erofs --blobdev /dev/sdb1 --dsunit 512 ......
>>
>> If actually `--dsunit` does not work on blobdev, should prompt warning m=
sg to user.
>
> My cercern is why `--chunksize=3D4096 --dsunit=3D512` will not
> lead to each 4k chunk to the 2M data boundary, is it obvious?
>
> chunksize =3D 4096
> dsunit =3D 512 =3D 2M
>
> inode A (8k)    2M, 4M
> inode B (12k)    6M, 2M, 4M, 8M?
>
> Are you sure if there is no such use case in the
> future? Mixing `--chunksize=3D4096 --dsunit=3D512` seems
> non-obvious for this case.

Or as I mentioned before, I'm fine to leave each `dsunit` logical
aligned chunks (but not any deduplicated chunk in this logical range)
alignes with dsunit value, it enables PMD-mapping as you mentioned.

But if there is some deduplciated chunks in the logical dsunit
boundary, don't align it at all since there is no real benefit.
Although I'm still not sure what's the default behavior of `dsunit`
for chunks.

Thanks,
Gao Xiang

>
> Thanks,
> Gao Xiang
>
>
>>
>> Best Regards
>> Friendy Su
>>
>> ________________________________________
>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Sent: Thursday, August 21, 2025 10:00
>> To: Su, Friendy; linux-erofs@lists.ozlabs.org
>> Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
>> Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment =
on blobdev
>>
>> On 2025/8/20 17:=E2=80=8A38, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8A=
com wrote: > Hi, Gao, > >> What's your `--chunksize` ? consider the followi=
ng: > > chunksize =3D 4096 > dsunit =3D 512 =3D 2M > >> and two inodes: > >=
> inode A (8k) 2M, 2M+4k
>>
>>
>>
>>
>> On 2025/8/20 17:38, Friendy.Su@sony.com wrote:
>>> Hi, Gao,
>>>
>>>> What's your `--chunksize` ? consider the following:
>>>
>>>     chunksize =3D 4096
>>>     dsunit =3D 512 =3D 2M
>>>
>>>> and two inodes:
>>>
>>>> inode A (8k)    2M, 2M+4k
>>>
>>>> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?
>>>
>>>> Is it possible? what's the expected behavior of
>>>> this case.
>>>
>>> Yes. This is the expected behavior. See runtime below:
>>
>> I understand that is the expected behavior according to this
>> patch, but I'm just unsure if it's an expected behavior for
>> the future wider setups (because some users may use `--dsunit`
>> for other usage).
>>
>> So I tend to just constrain the case to your limited case
>> first, could you explain more if chunk deduplication is
>> needed for your scenarios? and what's your real `chunksize`?
>>
>> Maybe adding another command option for this is better.
>>
>> Thanks,
>> Gao Xiang
>



