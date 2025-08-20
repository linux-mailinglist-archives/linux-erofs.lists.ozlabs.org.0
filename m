Return-Path: <linux-erofs+bounces-847-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72459B2D8D1
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 11:44:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6M4B1Xbmz2yGM;
	Wed, 20 Aug 2025 19:44:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755683082;
	cv=fail; b=jxbbOZFehN/9A+ekSY5Y9j4ryW94o2CUzIELMclv/SN73W9brPC4nzhtg0D4wq5Q5V8YSVB/uIQwzN0phicFf0xll8njmd8brAuA3qatWBRu25WGETJNPI6kt3/4nFOIg/UXOhw2KrZ9J1BSwKxn1gTh4v7Bxz4xqNZwzDB0r3tyUuILxR5lMrOFSue83/cuN4KI1I2E7uSLIITcjeHXCeoR1epxlwDmPL/Q/oeOVsBrKJwbdVPd0sFREqlMbxwsyISLpE2DAdkaaf+vGjJ1dMg74fSrXBHwO9hV+gHAdFIl9d/qIOuOnfveyhFIhYrWm7UDplZ2MisWrRbrknLytA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755683082; c=relaxed/relaxed;
	bh=OakjKpSOUVncuz/Hv19V4yVsthE9rObBmc7ok2vMEH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FCFatKNLyEQVP6qKUuByAbo4fFLUlrzKC7zFV/aw9J8qQZ7oenm+bQJV/6MzDE5L9yLuA/mYXJKNtX5a+BEPlrkO/FvqtH2oT1pTYirpky5sWRuQLtz6R0kQnRGNaUWzCpR9czGRLDNL10hWCeJK9GhYBw88cLC1sAAAbzskZHgnmGoZ8ooXZyugEK0R/NJZO3Ks7WsLzApE6OSVXXR3Z6h7DFwVDOwmtVB0e52W5G/t0hCKrJACtbn4x1lHwuKVlKxCKQNekzagA/0OlptV1QECh3+iEZgUeRYL7iDGSYcqXNgrHXgnzZDukpqhMlCQfntS8qXh+ToiNpat+b3joQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=Hda8GjyV; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=Hda8GjyV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2650 seconds by postgrey-1.37 at boromir; Wed, 20 Aug 2025 19:44:41 AEST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6M490jNJz2xcC
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 19:44:40 +1000 (AEST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K6HVNh027594;
	Wed, 20 Aug 2025 09:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=OakjKpS
	OUVncuz/Hv19V4yVsthE9rObBmc7ok2vMEH0=; b=Hda8GjyVylFzBNal0hLrlec
	V0eRLmADmh2BnOwRbFc70cCJjOZFVEE0ntW8TyFQiN7NEKd8cajClol48Ng1h0Xw
	RufUib+w/XVQRCzVI96Q7INCJMtCp4AL7a64VwdZtBerZqXKsJWpdI8D6sXGjs7A
	k+1TmetHB4RlQIvKBYQ1KLYfBPHEajJdkvGpjZWiluETXvdQFR/I/Gvi0Fz30kJf
	vf86JTqBIok46hVLRCPTw+GUlJ+KdpFb0xTKc6EhLfz0BT/fl6SMeolt3hua8WL+
	Acukh8GLfgMJmZ7QpPWhK2BndP0jvzl4DM3T7kKBkcXz7XDB/jky8hQdqWnrsJg=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013035.outbound.protection.outlook.com [52.101.127.35])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37h8f57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 09:00:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck1L/oC73GOo5Mfeaz59mB+sGL3t5C00ran1pmfc0WVVTbull1gJbSvliM34X06vje8OTA343EPSGVE4RyVHbRbFEB/TOsYJvP9rFnOWUfgIsKo1H/EV2MfG3Qu7Y2BNJlB7obg4rfK5nr+81A8i91hcXD58j4PAL0RJXzm9/aOlGrGxKadhFgHvzXC8mlt+L5C38A7JT91FiZim+1d4+WsDTMA2asGecr6eHD1FDRAaGIPCBoAB6RWYjHm+x28ciM/DFWbiuXGENPAanXYLa0tkJHZ8jU2akEcI4N2T0lnraPXc+YSTzyMQ67NVR6wFdYGuSBuiF6kuIuE7BBlDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lHhnrBWBz44UNLm3nJ0p6JdRV0WYY5gZ3TLl41NDZE=;
 b=O/kXVIccFY1oxJbZH9W6TqM8UHVQlgyzdGcXw1GhK/q2F6rW0JUAscEjP3hwCToUow7NfWEGZwrNcEDv5Sy+tJEs5Mur96lM/OouQN9pwPXBZKKd+EIvXJDfS7YCBdnHlU/iUotmsh3EqL4NCN7HT2d0V8U+xlR0cWzqTEXfYShdvZOcuQP3/+iTNWJhYK2FSmFqODk9dq5Yur+ZqrSx1mCsFTnMByZkUBL+MhNsyFOKe6z7BTYkNcNrgjzJsVysBrCCkqVAHuBmBZhNpNwvztTLl5LEo7/QbCIOWrmpVa7bsLZ6tuDoZJts5JbvozOQ6Vuz4cAjbWcM7bSfR7peDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEZPR04MB8072.apcprd04.prod.outlook.com (2603:1096:101:230::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:00:14 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:00:14 +0000
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
Thread-Index: AQHcEaR09AqiVESPN0KCsjRcUS8Fb7RrKVGAgAAPTIo=
Date: Wed, 20 Aug 2025 09:00:14 +0000
Message-ID:
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
In-Reply-To: <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEZPR04MB8072:EE_
x-ms-office365-filtering-correlation-id: 29ccc251-46d3-4c6b-e450-08dddfc7fa2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmZPUjJMY3hWbXFjWC9JRDJzZFhaSVNYTEtVSHVmeWsrME9TbjJ1d2lPQ2RF?=
 =?utf-8?B?cy9ESzdLbEFXNWtUaWJrVVUzWDVaMHV1c1E0YVhaZkFZWm8rM1dZMDUwSHBz?=
 =?utf-8?B?TW9TWHAyazZCbytOTjBoMHdUUHIyby9ndnUxWDhvZVg0MEdKUjVMT1hrMno4?=
 =?utf-8?B?OW9jWjFDUklWVUhKL25NczRlcmNNcDJ5dXVlakY3bkVLYU9VWm55YTAyNUlX?=
 =?utf-8?B?Rm42Q3hqZEY1c0NLQUYwWWtiYXB2WnZGWTRtNVhMTnpuTzQ4TUVHVmpYT1NB?=
 =?utf-8?B?dm5DVSs3aytQYTh4MUlVRHpNdTZPT0NlK2tibE1idldUeDhaeUdsSUZtT01T?=
 =?utf-8?B?UlBJQlNDaTAvUm1uWC9haGRudTg2N3FXYmU2ZDdrMGluZ2NRRGIrNVlOckZ5?=
 =?utf-8?B?aXFIa2JNZXNMd3lmM1JzTXluTUtLTVNRbm9rZDZFU2RhaUw2YTVBbWRDZis0?=
 =?utf-8?B?ZnF4bENKMzBYdmNOMGU2VVhHTytxblYzNGJxd2FPUjc1TXgwek1EY1FQVWhp?=
 =?utf-8?B?d002M3UwTnE3WjlsZEcxR3MySlRzYStWWnNRQkFCOE93cE5NTVp1Q1hzZEZE?=
 =?utf-8?B?OXpSMUNydnpxcDhRRDNSYThuWGpWbm5ob0dSQytxS0lvbXZBcmpEUW1DT1Qx?=
 =?utf-8?B?cGJTSlpMeXdscmJLbnNqdForU24yK0NHd1ZiekUzd3RwMjc0cVNvc3RYWXJR?=
 =?utf-8?B?WmoxaFhnd2laS0ZKZFJGRTJ4U1BKN3F5aXNqODh2VTkrUWFBcTdnenkwQ1M2?=
 =?utf-8?B?Vk03SlRaOFNsS3FLM1pLdnVjTWxmKzNnUjNScGxoYjlabVoxcWJTQ0ZBYWpV?=
 =?utf-8?B?U0x1RDdNOHgvbGN5cjJkWk5XWTEwK1d3TnNYS0swQlFOMXIwMGN3WHplWm9r?=
 =?utf-8?B?R1pLOXhUcnBEbzdDaWlndXVRYUZGbjQ4cDdyc1Zua3REaUs5VXZFdWhoTWdv?=
 =?utf-8?B?eUkyeVpqWDdrVklpTUZkaGVvK0tEdWNrRW9FTGFBTDQ2WGFlRFB4Uit1K2w4?=
 =?utf-8?B?UEM0c3ArWEVFeHppM3o5R3FZd1VLcEV5bDVjRDVFaG9WaGxBcGl5NVloZklR?=
 =?utf-8?B?MkI5V0tEZWlwNCtudFBZV0pRK2JiU2tmbXFTWk8xSzkvTEszazA3U3BucHV1?=
 =?utf-8?B?cmFHeG96ZGM4OWtlODFDaEZxVUg1MENFVExvRTczeFFnQVo3dyt3R214bTcw?=
 =?utf-8?B?MTBkM3R4WmsvTXd1SlZRV1UvWTRTaXk1Vk9hZVBmd1JDNWxpMHpWUElySVBK?=
 =?utf-8?B?cWZIMGZVVjJFV0l3bmRya1N5c1R3M2ZIVStLZXFYZTNuZHRNMnc0N29iL2Mv?=
 =?utf-8?B?Y3FOSG0vZGFmV2tEUisvUHhQSm0wNzNmNEt2dGk2WVUvdzdiMmNEeEJYcVcz?=
 =?utf-8?B?Qkt3OWVVdkw3aTNlWDVRM1hteVlPSHF0YUh4ejQveXFFeDd0WjNwcG9tRUQ2?=
 =?utf-8?B?MHo4SVV1aFAxdjYvS1NCMzJPQ2d5NVl0UW9IVHpkdWxSTlNjR2c1dXlMNS9G?=
 =?utf-8?B?NmZLWnl4L0psMDgyWitCWTFjTjBsS0M4eWxSemFPODN3SGRxRTJuTTVGWUlM?=
 =?utf-8?B?dDNhVjBibWFPdXNCaWlqVTdNSzIxNFhsMUtSYnhHTE1oOXJvTWkreHdlcVBr?=
 =?utf-8?B?aTloMFVMUDZ2bEpHTGsxekFZN3JnR245WVhZcGpIZERNSCtDZmh2UEw1U2Va?=
 =?utf-8?B?NFhYMzhlQmhWV2NGdzBtd2t6TXBseUV4cnRvcWx5SXN6QjdWMDZvNlNpVy9a?=
 =?utf-8?B?US83RVl5Nk1nN1lyWWxWOThIT2tnTzBIRVJ4c2RyTk9GZUE2WDJyR0ZnNDlE?=
 =?utf-8?B?TlNFcUtGSWs0ZUM5ZXZOQzJHbmgyRlkwMGo1dE5Nd1lkY0RhRkpPSE9BSG9l?=
 =?utf-8?B?OFF4VkhMeElQUnJkdVA2TzVYWVd0Yi9iOE5OMU9TR3RJcUROenhhakxteXdz?=
 =?utf-8?B?aFkvMVJMQU1ZNmlHczZBa2JsM3RJenoweUltaFQvOXgyV05SVG1YVloydHcx?=
 =?utf-8?Q?r2idOdw6PCYWcQJnuqkJ/swQ+h2G5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUo5VU5nd3BYN3d3U2tWc25ZOVBnU2ZhbC9sVFdQZG5rWTRrcWJLNGcwTnMz?=
 =?utf-8?B?SlYyMEVVSWlvQ2FXTFRLZm9sOXdQTU1UOVZ5ZkF6bk8vaVVXaEtiYUJMeGJ1?=
 =?utf-8?B?QlZlendkam1ZVFBsSC9oekNBcFpPcTUrM3F1MDM4aXpRVlZib3pnY3RMMlhh?=
 =?utf-8?B?ZlNuYWk4V0svdmN6UUtvbXZRZ0l5UTk1VU1wcmdrN0dsdmx1TmtWNXduUXk3?=
 =?utf-8?B?V21lOElaY0k4Ykt6ck9IVnR4bWNZRWt0emdETUNpTG12dE5UMnpiQjkrQnox?=
 =?utf-8?B?S0JlZmFkUDdHWUNBeGJuTzQ2cU1IV29sTEM2SkhFTE14Q0d0TzZMZzlXdnU3?=
 =?utf-8?B?a2krV0NvcDdjQ0N4K1lPWHdTdkVXSlNCK1ZYSGxMdHY3VWh5Tm5GclB3MTly?=
 =?utf-8?B?VWZOT2haeEx2NThIMWpFYUdTZGlGazZIaWY5a1lpT2hyUEorZ3ZMQ0krbFhP?=
 =?utf-8?B?ejg0NktXWFRMaXZzbTVzL0NoM1JQdWVKL0ttVUJjQXBDUTJsQThLMndXWGRF?=
 =?utf-8?B?aEpyek01cTZnSlJwZG5wOFIwVFJ1MHlIQVRhR2MvTXVLVHR0R1M0U3JVNjl5?=
 =?utf-8?B?d1grdUpucDFyTnVoT291dXVweWZFRi96b0g0Z3p0bkFjaU0rdndLNTl5aVR5?=
 =?utf-8?B?YlB2M3hXYzFWam5FbXlzN3R5aFVFUktmdVlsMzJXUWllL0g3NEF6Ty9nb0FE?=
 =?utf-8?B?aWRIWXZ1dEtZaXY3MUpjcU01NGVRM0dDc2F2cHR0V1BtdkhjVGdWSTFRUmE2?=
 =?utf-8?B?Z3k0M0RaaXc3T1FJd1dGVTdEUXdVenRNYi90STdGUVNVZEpSUkl5M1pSUStu?=
 =?utf-8?B?ZGxmYm9xdWg5dDlmckx6S0R0Wk9DOExFZnAvWHF3cHpxQWwrRnpKYVJnYVBL?=
 =?utf-8?B?TXh2TnJJVmlGTmp6Rmthd2RMKzg3dU5mWFllZ0pqWkRFanhkcEErMmdERVFT?=
 =?utf-8?B?ZG9hemYvTWdWeVNoeEs5akcvaUNaSXM0Ly9MK2cxTldCL25ESGxiMW1Yb0VV?=
 =?utf-8?B?MWs0cTJpOHFYRjRyLys0dzNkUGF5NVZZaU1oNzA3NFp3bm15R1JTdHpTMGtU?=
 =?utf-8?B?VzZXR0pxQ3FVY05kMHdjR1JKY3BnU2JnNTBHVno0dVcwdEpoc0ZrOXdnbk5p?=
 =?utf-8?B?MWtvTW1nc3JLeVZYUFRYQmJydkF3cW5CNWdVZ05RazJSN2F0a1VxNHQwTmla?=
 =?utf-8?B?NHR1MHBxV0dWNTJkTk9jNU4wNHFQMWtiTHJ5VERjS2Z1ckp4SkpwV2hGellp?=
 =?utf-8?B?b3Z5NlV4dzB3NmNHNWUvNmRobWhRanFzaksvSjlmVTFGWXVxVVJoMTYzS2xQ?=
 =?utf-8?B?ZjBFQVdGL0ZRek1ucXM5dXRZWjRXY0d4cHlvODNpblZiSFBWaXlnSFl2aGhY?=
 =?utf-8?B?SkJvRzNzTGwxZmR4a1M5Rk9QUEM5c1czK0htSUxsYkJpWnREUjB6THIxZnEr?=
 =?utf-8?B?Q21GakxTQ0RVK3FzalliNlJYZkRzTjhNS1VpN3pib09WUG45WU5MdlE0dnVN?=
 =?utf-8?B?ZTJRSlM4ZXBrMjNXV2VSLzZwUHFIUWVuNWUvb0NwZlQzcERhQlZoN21udGhG?=
 =?utf-8?B?R3BzUHpsWngxb1gzR21RYTRyelJwUUV1ZGswOW90RTF6Uk8xNGVFck0xN1E5?=
 =?utf-8?B?MGF1RTR5bWd4dDJ4UkZ3T01CNmRuMEpMNnRjN25tUHI2NmFDekVXZ09DL0VK?=
 =?utf-8?B?bDU4UlFUQnVJUE8wTTRxbThjVmFqWGp3VUd0aTB2RERHUmpzc0tUZEcrWEhs?=
 =?utf-8?B?d1NwTFJnVk1GTUltVHcvQmM0SDZmUWxkelliZWtWcFFhVEZMMTdKT0JXdDdW?=
 =?utf-8?B?emdSM0ltWXkrQUNWZDhtSUtCZjZCSTVtb3pZc0JQRXNNMTdWVmxWNkdJTjhT?=
 =?utf-8?B?SC9lQkdiMVRZc3dmR2hyRDY0R0g5dGZpbEJqbmJIckN1eHEzNVIvVXdLaEll?=
 =?utf-8?B?QWxxc1QvV3NLQkx3K1RDbWIyQ0ZLbHg0Sk13VUlGVDdwRWdsQ2dUUUZzdUo5?=
 =?utf-8?B?TVlueFBMMmtnaEswcmNQekNpL0w1UVMzMUQxM05KcDRYb2YyWHc5SUZKTHBY?=
 =?utf-8?B?T3JwNFlBb3l6ck1DMnZ4L0hwWEwramt0bHVGT3NPSkxhblZFSHAxTHF1OEVm?=
 =?utf-8?B?ZXpPbkRhNVlNeTRjNjBmR3RnOERjNG14Q0Y2dW9zOFM4akR4eUhCb1ZCNklE?=
 =?utf-8?Q?3HenukRQa/w+ynGTOOnPihY=3D?=
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
	8dV5qPDXBfzzPVpZy93gle2WUb5vekuMeAQ8kowCGfUfrqUF6qnY1IeWpyMrrvGgirnYva/ZLpTG+btM6P0yXEZJeJ2JgW+tdmSgVwG/+wYP6wnX67mqQKUAOKoeFj66+3H0QUGUx5hZJRipSyAGMuBzrpF/+8gmxeji76ujRVrrSznr9ygMwA1vEXH6SrLofiPn3w1oWLSK81uT2XtxlhwO4W5U2QiYTMFOrIpKV0a+r0vay01al0w1scItd6ldpxLBGCrJIhhq5l9WJrU/vJF83ytK2SSqz6QIWplTRPJG/nVpI2kdqErp2NIpKdhjFsuc+fmhN4hAiQJBoXebfnQdWQSgQ4HPOigHTqnD336Jh3E87howsR/TLswBc5qY+PvpiRjGqQDIUgdPYwsiaGhX2XfrP/pA6yFutq+9cHxH17MtCZM244riYvh0E1+9+tcnuOV00TqZRvJjZtxy+XV8vWCwoTPY9HigtpgimrXZ4DvRdvk+yYaJaCrQlrzG6HwvDoptCOO5VFFwYSujT5zTowBabdUkEOQDXyz2JIqGUzSedEPrIOM7wuc5RwH98eXI07Qxvdx/DJ9xFf180DE5DReGoUOEVQGXkcgZ2FBCifA2DGFm5k2vnsrXj6JE
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ccc251-46d3-4c6b-e450-08dddfc7fa2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 09:00:14.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N34+oy9IZV5T1flME9VQ4GotXKG9kdsYh2lMwVN+M9du9VwBLVnn2/CnKVI3rv/0qK0fkRPCO7G0585BgkkbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8072
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RDaV-FsPpKa0qbhiw4RcD9UmXxslgIX8
X-Proofpoint-GUID: RDaV-FsPpKa0qbhiw4RcD9UmXxslgIX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX/F86Ny1WyfFd DVJFfxT0TQlBDiPy+3C1YaivxfOeGLj9hLdvgX5qBbIB4ccP0b3VsQpEM1lroLxnSL/p2XOAW1I Z96zTNY5jMQcTZRam+WLUu+3TABaoI1BEqWEqcNiCRyu8JrF345O9kbN7VfIsY30BGI20w/kTSI
 QrVyDPLYLSTgRL2XyAvkVsJ/RMKJzXNW94X98fgJdt2egm1BrLUjGx68m+opCZ0LmPywFrObtfh 9M7bIhFhYWauMzrLZQwcnqfYy0lqmIWV+zktyK5Ei15sq/hs1hbi2zng8tU/Qtkr2GF/ZUEKL+N q1Fi9k46SmmF6wwUTMqRNb2pRlDb+sSfqiTpnFfFSRXTTZKeXoAs4zp+2Rr0UftTkqOi0UdHMsj
 00h+FFH5wCNRh8WSAMjiq8Xg0R46/w==
X-Authority-Analysis: v=2.4 cv=WIMmnnsR c=1 sm=1 tr=0 ts=68a58ea4 cx=c_pps a=GWtXnVsILq5hUQoKyuHFWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=A1OA0lEPbZMAvFa-fiEA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: RDaV-FsPpKa0qbhiw4RcD9UmXxslgIX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,=20

Thanks for your review !

> As for this patch, what if the inode itself is
> chunk-deduplicated, could we apply this if the inode
> only has one new chunk instead at least for now?

Do you mean inode has 3 chunks, chunk#2 and chunk#3 duplicate chunck#1?

This patch only makes the 1st chunk exactly written to blobdev aligned on d=
sunit. Deduplicated chunks will not be written to blobdev.

In example above, chunk#1 is written to dsunit aligned block addr, chunk#2,=
#3 are not written. The next file will be written from next dsunit alignmen=
t addr.

Best Regards
Friendy Su

________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Wednesday, August 20, 2025 15:44
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi Friendly, On 2025/8/20 15:=E2=80=8A23, Friendy Su wrote: > Set proper 'd=
sunit' to let file body align on huge page on blobdev, > > where 'dsunit' *=
 'blocksize' =3D huge page size (2M). > > When do mmap() a file mounted wit=
h dax=3Dalways,


Hi Friendly,

On 2025/8/20 15:23, Friendy Su wrote:
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
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Sigh, thanks for the patch! Actually the blob chunk implementation
(this file) is now an implementation debt since:

  1) In principle, chunks (and deduplicated pclusters) should
     across blobs (considering the main device is also a blob);

  2) Each blob should have its own space allocation context
     which is independent to the in-memory chunk records...

My mid-term plan tends to use the current metabox way
(i.e. use buffer management for all extra blobs too..)

> ---
>   lib/blobchunk.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
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
> +     }

But since you have use case on the current chunk
approach, so...

As for this patch, what if the inode itself is
chunk-deduplicated, could we apply this if the inode
only has one new chunk instead at least for now?

Thanks,
Gao Xiang


