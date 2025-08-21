Return-Path: <linux-erofs+bounces-850-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DBB2EBD0
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 05:18:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6pRR5qt8z2xc8;
	Thu, 21 Aug 2025 13:17:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755746275;
	cv=fail; b=EG6ODqh9OrydtEBHGnjPhUFXWqvoh9bpG2d4Y4yjytVXHEgX0hNZXAiBGFIHFa4flr8XmWOiHZLBvQlDos4KA7llEEJVK+/4APAnoiAdB0ugu/Q77eHfbxL5Fgma8Rq7xEwHi5nQ2uxoQa8FCczrsGot9avjx+H5/7kG9H8f8wEjUDVKLjauHBcPhc0zzh4PbLb95qtmh4f5W3elFT/M0k72o5l4sb9FPtbx+pEcyvd2QJQLn2HC8GyZQ1mde5vt/PW5UPaapETVAq7Oij3PO1EH1YENB5Z+6NxEDCEEWBZ6cKO8qEd9W2/3HTJOFTtpEkFBCuKxW/fCl9sloS3npQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755746275; c=relaxed/relaxed;
	bh=ryQc+ooO5MChIyPg49hiClXJnfY9V7G6GkY4w4NwI/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=moIg88tCPTFsF60GnzVl4LTdGm5m52cAVvM5BuVgP3xRrkr+bnq5/ersOFybyFuIYPhQaloI8p2xRPUq5kbxLav1/epx4tyq6rXCCLPgc6MskQa96d4F3GkkIkox2TK5jmsfJ57tW4NeDXVEd7xKDZSzsY9GLmyhT0VLmTSvqwO6XLIxv9MVXHTfwMHaPRsF5nfYABOdlFmAG1K6RdcoWNzVFx8VA9y2+UpTAqRlKf5Biqn3DlSguj4Hz9lp3YXhtr0FgyT/qfY35hs7y2y2u9Qt1SZD19SW5FjWhj/uMLsN4HWQsT2Zylfcq81MhnYPgoxS33THFIOsYhaRzi7uzg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=i9alRMMe; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=i9alRMMe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6pRQ5JxQz2xQt
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 13:17:53 +1000 (AEST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0nrcw002183;
	Thu, 21 Aug 2025 03:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=ryQc+oo
	O5MChIyPg49hiClXJnfY9V7G6GkY4w4NwI/4=; b=i9alRMMen1cRII7uquteU/g
	TCP4T066HDuziZWIhQ6tMFzBx/w/+AKNtguKnD82yhUTWJkPAzQo8AAmTzKHW1f1
	+g1Unj2lAxOKTwSGeZPp/jn11clhbK/SefWO+si//xLJVY5FmpByOOVYRPvgIeqk
	PKG8YVoun4Y3YtpoM+mPWU4JhSaCVmrtZw97RVRBC1hZoGPrFazNb+yzBmoBTDEe
	S+RFBVTmUmxQBIeZx5rDGO3uAERn6OIOZDqfibzsFQJgPMgOwy4sm9iqXyIU9zf3
	7n6lpJBVAXZSMqjiDG92g23sJRMc0GbwNUQNzdyaA0QAJq3BC/5ZXUuOazQ7TMw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37j992b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 03:17:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB+hNKLHn162YTmdxGNTu+qIEyLYwSc0x+fUoz0CHuNAFt4TzmVCBuSonMFyO0AB1wQJIRblL/kPWKdHwT7s/dmA6KCWez86NHSYz7rRRxBzwNNwVD67+DAG5iJDH9VmsX1B0nthVbq1myjtlzAWcr4RCFgiL9Rtej1s1UW8qAhPBmqzVkmZi/PcOm/PyeoJ92YO1dfZLKCIiXRpcYN90zo6QW9KtiMD0Adkvc1chB8E1I1mP+BqTVA0xUPxCtxEtGRuyxJ7wFiayGDZRRqsh/olr4TZonrkt0MjLtzsezQ7oR5x5RHR8NQUxChl5ZQKngaMAjr25NAOc0uxvVtE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gbbNs29lG+gCW84hVT0EIXpLt5WBp0ZJw2RKyR6cJw=;
 b=gqrq+QDGf/mWdXcOzmO5eh+H2qW/7SxFQORoJxctEQmh1EyhVbfYeWHu4I1jMw5R0mX12Kt+MSh5N3KhEN/dvUU6lM4EttLaCA5DcGCRzaKPgLEoLCDoyF4HQDUCQBJ4flh6OiMOWg8F0AVTKBoHXTt0Dr6bZxwzE9FLTE1GgqqVG7ulAYSXZC8IIb/7ZIVLmAufb9EOrfTve2UQ+M8lECKNTlSeCMLF8SRwO9WDf5EpTeUJbjh+r7ZEaJ6mbX8WJs9weX1rVesEJz4nDmWHFL9cx5kKD/c4HB7e6Pm41sa2Y6iSYZXpQLX5u+ohQhim3bpKvWqVlvChTpABMRe3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEYPR04MB7721.apcprd04.prod.outlook.com (2603:1096:101:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 03:17:34 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:17:34 +0000
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
 AQHcEaR09AqiVESPN0KCsjRcUS8Fb7RrKVGAgAAPTIqAAAkdgIAAAwxBgAEWsQCAAAc61w==
Date: Thu, 21 Aug 2025 03:17:34 +0000
Message-ID:
 <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
In-Reply-To: <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEYPR04MB7721:EE_
x-ms-office365-filtering-correlation-id: bf0fa0e7-afcf-4860-6071-08dde06145c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2oxSEo2eFcrczRTTnh1cUtqVkFYSGduNGttNG55YTZGQW1qZFVHNHhNdTlI?=
 =?utf-8?B?ZW5IVjRac2hLQVk5RGpjV0N1V3pGNGpFU1MwUUFzRFdoOXQ1R3d6MjJUSUVB?=
 =?utf-8?B?YVdjTk16WUpJQnZaVTJnNWpjeEVWZWJUc0kyRmNWaG1VVW0rUnF4dzdFMkJk?=
 =?utf-8?B?ckZ5R29zbEhZNThmV2dSSUxUUi9NMkk5bWZ3Rjh2aWNWZEJSSnlMRHQvMkhn?=
 =?utf-8?B?cnVlZEJJY0QwUEhoTVhvdEIvcHRtOHJWVUx2RHpvdis4cFJRZVhmY2lqdFV0?=
 =?utf-8?B?bm1aem9JYlhidk9YcFBJNTBmRnhmSGtETHVPbGNMQUVpQVBhaDFJWE1aMGpl?=
 =?utf-8?B?QXpIeVV4UHVIelNWck10aVRXZmVOS1VieVptVnlDSVo0eDdtVm5RL1dNODVC?=
 =?utf-8?B?VlNObmFEeGNadnVqVjN3VWFRZk0yNkVreWd0K3dGNjZxOURTczllZ0pGK3A1?=
 =?utf-8?B?WW92UWFsZGtrQ2JzYlFzSFdrS1VYaWhObFZDdlJxSEJ4RFJTbkVzLzZqek5S?=
 =?utf-8?B?VmR1M256cG5YSE5GUlRzNHBmNTZKK0JlT1Q2T3k3N2xSdUxLd2FVUEM2akNS?=
 =?utf-8?B?cTltSmo2YVFFUDYwR3pOcktDa1lEeDc2bzNiRE9LcklLWSt0VUpNSUtzeTlE?=
 =?utf-8?B?THVBTDBKWCtkNm93VW1mU3cyMEVNNklGcVlqczZXMzl6aG9vQ25ySGw5NlBP?=
 =?utf-8?B?ZDhTVGRZc0REVGRpZXFzKytaQkNVeFNWRHVUMDViM0JFM2xGaGhpSUpPdld0?=
 =?utf-8?B?c2c1cHYvKzAzYW5Lbi82TXhiL0JvVjFNdFN0azdFa2V4amJyUXZEc1BuNTVu?=
 =?utf-8?B?MXlQNUt0UzRaNzc5TUpLOVpPU1NKMkhPTlN2OFhmMDhENm9hNWh2bkNPd0hZ?=
 =?utf-8?B?U3ZCdjhJdHl1NVV0UjFROXdWdW12VVkzeld4dWNDWXFzaTBXam9uZ0ZobDVW?=
 =?utf-8?B?dkloTU9kUTVQcFNkb055ZlpBdHFsRHJ3VXZuTGZ6Q2dXanY4UlVzU1BiQ0dC?=
 =?utf-8?B?N3pMY3BFQUl2S2N1ZFhnazlQcXN3UVdDZi9KbnUyLzVWd2dQY0VNaDJnMzN4?=
 =?utf-8?B?NXYwMjcxaEc4KzhzT3hQYVhyWWxHZ2xzUWlDYmFWODAxc1NJN0ZGYWZSNXVk?=
 =?utf-8?B?bFdRZkpQbFZ1TVNNSWoyZTVhbGdhOXREdUY1NDMrTVZhU3NBeVJOSER6ME5J?=
 =?utf-8?B?bFVacHZNeWlJVkdKa2RZeDd0Q3JYV0xNSDNVbis2M2VBZlNtdExnSiszSk8x?=
 =?utf-8?B?ai92WFQ0TXVFMU1GLzBTSFEvMi9kaVRITkdUVVdQVnhmaitwY2g1Qm94U3Yw?=
 =?utf-8?B?RThzNU03QnFqMGtzR05KeHNzRzEwRzJ1V0JhaUZwaFJKZmt1SEFxekZOaVph?=
 =?utf-8?B?cEFwV0tQQkduaDFBMHFYNlBlT2tZU0dTd3Z2Vzg0MGtjeWZ5d3pMMk0yQ3Rx?=
 =?utf-8?B?QnRXNmxFRkF1SUlkTWZHSFQ5cmVZNE9zOW0zVnVvQlpzYy9WWkJLakl3bFFL?=
 =?utf-8?B?TnBJWko3NmVjVU50QUl3eWp3OUNaVkZtaVJ0VDRqQnVUUGtDVFk2U21wT2tH?=
 =?utf-8?B?cm9uZ0ZxdWNsNHJzaW9JVDFHVmR2dlNOT3gyWDlzVzFycEgyS2dTKzR6OVVu?=
 =?utf-8?B?SmN2RkgwK25IYjZhaU1rYTdlb0h2MVhpWmw0ZjNGdU5YQ2Fxc1drQjhnQlpX?=
 =?utf-8?B?djJVNnlBVjFNT0NUMjhHelBvSitwb0RVdG0zdzVYVEl6YVl4YmtFUjh2b3hU?=
 =?utf-8?B?RU5XMHk0ZlNzL012RG5zWEtPTWUxM2pNSUlLYStMcnIvNU05YkVzTVU4MnRr?=
 =?utf-8?B?emlNeGJiUlFCQThRVXZUQjJDNXpJRmVSdUJTcUlzNFJDeTFXNHZtc0MwZnFI?=
 =?utf-8?B?cklvcVByZU5TM3YxZjlkSGpMLzY5VDdIZmZ5VFZaMGF0a2RYVUtYTFN2QkhG?=
 =?utf-8?B?YmVkMmIrTzk1ZHo5NUM1cHRBUzBUY05YWnRvNzkwQXdIc0FnMEhnQ3JjZGZ5?=
 =?utf-8?Q?JZyAlHqUHMSFe9OisSWoQefUmmCT9A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWxQRG9Nd2lnMVdkTUg1Y2pSVFhQM2Mra3RZVXQwK2JRZGs0YXdhSEZRSzNV?=
 =?utf-8?B?VVpPVE0ySjY1SE84ejBpUGMwV3hmT1Btb0FzSDlySFlBVTBxL0tqbVY1bkt4?=
 =?utf-8?B?dG1HZ1JYcWdKUW9PVnhDVmFxWjdFeTdJbDR2bzM5RXNhZmlpNXJ5a05KN3NK?=
 =?utf-8?B?MUtFMUpRNmlBbmZjRXA1SS9vSDZ5VW5IRkZubmRxM0pXUklYaExKQ0xJSm11?=
 =?utf-8?B?Qy92Nk5Fa2JWbUtlVEtvQjR3VWlabE9vbHJXOXZ2STZjZmEvOUd1emJ0cHg5?=
 =?utf-8?B?Y2xTMVI3VzUrZ0NlSVNIeFNqYUE4SUdQVWNQcS80YjVmb1VveVlsQk53eHVu?=
 =?utf-8?B?MEdqNWR3UmM2ZWp6UDFGYnBKNnVsdmp5RUs2MUJWK0RXT3VwM3hWTnlyL2xn?=
 =?utf-8?B?OTEyYm9PaitKWjVqOHhQTm5lbFQ1M3JteVdhNjdRbDRoaE42WnczOG1EN3Rv?=
 =?utf-8?B?NHlhZWtlbE1LaWUxWEEvN0dRQUJiZjBlTzFBUVNITEVyUWozTmdQaTdqaVJr?=
 =?utf-8?B?SEhrek5VNHhSdk1tdURMY2l5Y25FVWp4SFhPTHhGam0wWmc0T3RLQmlsZnYw?=
 =?utf-8?B?SjJwWGlhUlhNdXo5UC9CN2h2OWhybmltcHFnRjg0dFF3R2N5UjRtTUcyc3ly?=
 =?utf-8?B?Q0tyd2lkd2xNQTZNbW4rTk5mOHlJNHQvRWhnRDVyNGF3MThyMnpVTUN5RXJy?=
 =?utf-8?B?eDRkOUpSWFl6NTFZSTV3RnFCLysvTWJ2Q2RNSlNqYjc2K2phYVBORE9KR2Q0?=
 =?utf-8?B?b3hhNTFEUHMrejNpVmJFdE1oS3JXYVdFZ25UM1ZlS1c5bGNTK3NlWTI3M25t?=
 =?utf-8?B?MExXalpoWVI2OEpqTHJGTTdXeVlicG5LSmtPbGRrMXJVaTNsbUF5djRQKzRS?=
 =?utf-8?B?RmxKdWtCekFJckNXQndjN0VpS2duYTFTdmdiVDdYMzFQMElyTzBGNnJaN3dI?=
 =?utf-8?B?VHk2L1pUcUFmNkFLZW5JSmJTVVVoSkJPcDJjeFRjMkpmWXA2T2N1Ynlxbzk3?=
 =?utf-8?B?bXdTU0VPdkRNQlFWdXFYbzRDdUg4enNTVmgrcjBqNmpQSXNLc1pnMk5lWjF4?=
 =?utf-8?B?eEt5b1N4cmV0dEVHZ0J4TUdMQ1pUcDVQOEtRV2ZEaE5GZXZ0bTcxTmlVSUFP?=
 =?utf-8?B?SCtwM3JhQk1aMmxGMEovakhxZlNXL0Z1K1ZlTXRhRHBrcmNhellmM1N0bTNm?=
 =?utf-8?B?bml6QW1Pa1AyZ1lmN2ZESjNXZFFoY1NRMXUvMVd5VWhFOWltV2hKa3lsM0kr?=
 =?utf-8?B?YVVnKzlNMFVZdFBDK3lLaG5PSjRaMUgvY1gzSFk0LzJwaEZ4ZFI1MDZSYVU4?=
 =?utf-8?B?Wk9oUy9xY0RtRXd0ektrSjAyT28vUW5haFZvK256NHlXSGZvakpLVkNCWkNq?=
 =?utf-8?B?Q1I0UEdzb0tHZjN6KzRqcG1RbVhBTVV2Y01DTjZNdWtJQWc0Sm82cWgxL28y?=
 =?utf-8?B?LzNmMnNWdnFYeFBvdG1ScVBoblBLeXNKeDhjL01oL21NdFE3aGdoRTBaRjgz?=
 =?utf-8?B?US9hZEFYZkpNcU9rNW43azcyRjl1TnlMQjlWcUREZ2xyN0ZwYTRaWjVxbVl0?=
 =?utf-8?B?SktaM0JMcndnTnM3ZWV0OUR5d3cxckF4amxNYXhOTldUM3VBc3prR1lFS0Nr?=
 =?utf-8?B?RkhxZW9GUWpFU3IxVDdGY2RzMmNlOWtnMEZWTXVoQjNyck5GQUVndDd6VllL?=
 =?utf-8?B?QUJ4WkMyWmZyUTZKQVU2M0dxSjJWWFh5cmEvc3R4Z09SOVloTFhmYlBUVkUy?=
 =?utf-8?B?N3ZOeU54UXlxdEJkOWxaY1BBYXFNTE1PWFpidVZBeEZWRDV3NFNqUENqdy9I?=
 =?utf-8?B?cktNR2ZuMzhYd1FqWnB6K21NamhTazJTcE5va0dOY3hEQlVEam4zYXYyNS96?=
 =?utf-8?B?LzdnZ2JEOTdkeHR3NzlHTXpFUGlLYkNDL0phQ1piTTZMamMySUQzMHJSN2g4?=
 =?utf-8?B?RVZrNFE4dlJQaDdXU1FZS0lZRmxLdFAycHExaEloRDNCb2ptRFp5UnZhL090?=
 =?utf-8?B?cXU4SFowMHpOcUsrNGsyOEVYa3Y5R3YweUFvMCs3WTJacVJVSEhKRTFLa25R?=
 =?utf-8?B?dUx5cjhJVlpkSWM0aUx4U0hPanVzbkE4MkJsWkgyMUVicitVTE1QbHZEZlBL?=
 =?utf-8?B?eCtpbWN6TFdoYWJia0hsS1cyRTB3YlU1R1JSYWxkeUtxSSs3a1l4TGZWcThC?=
 =?utf-8?Q?fgfzsIpnyieJhsDyMEu+i+E=3D?=
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
	aKze/qJ13LHTvwDbuTRYWjpjGTXBXYN/XHcD9BEKK1hnh+ieOhzbufvBHzmn7cMBZw+su9MPEfU+CJfPqNyCppKClgSHGFvzKDnwe4RMZPguSEtx45OuiVevvtMIg/fM2vEfnauhls5vmrWOSnsHn4Dg7S8v8gAipF++XT2khHwOo3gBw1OSiD3iHBj0Zthn8a6IoMMCeN2FJBna4kLKZsWP68kAl/RqmeA5H86Bw+Yk1SEfKJpeeQPaAh9YNeB3/jTzfnC8K5hIavGehkHsJbyJR3DoM7jgF8i6JB/8nk5g+Cy+ersDzLq4Xy9UaO2LVyxBzKXNbtFK8ZERXrzot6a3DOGzES3klxwAIfr5iXLU8YfUo3QPqDyhfljpVfLQnC6DPXe9aM9aZEpakRikkplZGh5IXnumWDJ4f3iZCE1zwa1QmOIbIJObEffndlH2DcQhTOtNEAOLJwgIHvfO8BBWBDHyNn6rqiMGXPbcrRyTz7h2JgYRb3RB9LIJmhPOwlBPte1lTNX21LbJ+M3L+2wSQrC2kVhZvhKmF4sTGnqydFaJ/n6KTqbltWIZ+EUSUG3KkXq2tYm29lBPDwWsl4TuxYFnrmu61b3aW3+3vLxP6Tzk/uWjVR2GH1MRncJM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0fa0e7-afcf-4860-6071-08dde06145c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:17:34.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g24aRsPym+XQXmmSIPNYhnorjCSC1EM1gOZZSzYQaxTzpczdIkDQH+8y5EcDoJ0RTOLgZL5b2qMjMesNe3xp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7721
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX8nbsLTVX0BRK +2+pzGSpr84To65VsTwGHqFGwidq3uhazZZpvVPIPQ0hEpvLaJgpQ/pdMMc7JMLOI1i2VamAfuV Nb4OFTZzYf5oM7EEKOPd2EQc9DwUZruDbR1avjJ6hsolXi+sQoNZlfXv7gVBcvYuzEq7IM8FdcI
 kuxoFUV83EatUzN/FxHw60Ut7kBLj1cEjrSZhw0eucTCjhABmxm3/UkfFQmnuzk8fxrgKj3hGrz 7RyWlygdM2Yt0pW2cQXZsHo4j3oYdzsq3IZdrM6ptyByq36r8cNiRsBD/RCs6fSszxXNufiF5i1 iWB0UE8wqCS59+5YppSKr0Xamy8+xbBNY4g8qT0McshtyLMGc0P/yKSKVSsGpbQPm6ETAPOoQWj
 1UE0yjgPZ5b1+WJNgTkDaYvqqXkkrA==
X-Proofpoint-GUID: RD5pVKGKomuf0d0US6vBCLKFIPj2Lt8L
X-Proofpoint-ORIG-GUID: RD5pVKGKomuf0d0US6vBCLKFIPj2Lt8L
X-Authority-Analysis: v=2.4 cv=A8A1/6WG c=1 sm=1 tr=0 ts=68a68fd9 cx=c_pps a=kRlYcyTrbgrkg8r9Qj6YbQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=ziBiD3pvh6hlvc8l1uUA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: RD5pVKGKomuf0d0US6vBCLKFIPj2Lt8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,

>So I tend to just constrain the case to your limited case
>first, could you explain more if chunk deduplication is
>needed for your scenarios? and what's your real `chunksize`?

chunk deduplication is needed.=20

As I wrote in commit msg, we expect scenario below:

1. mount with -o dax=3Dalways,=20
2. application calls mmap(addr, file).
3. application read from addr, page fault is triggered.=20
We hope in kernel, erofs_dax_vm_ops.huge_fault() can be handled, do not fal=
lback to erofs_dax_vm_ops.fault().

This required file body on blob devices aligned on huge page(2M), and dedup=
licate unit also is 2M. We can specify --dsunit=3D512, --chunksize=3D2*1024=
*1024 to fulfill this.

I don't think need a new command option.=20
Currently, '--dsunit' can be set for formatting blobdev. The following cmdl=
ine completes successfully. User certainly thinks mkfs.erofs has executed -=
-dsunit alignment.=20
But actually, it does not.  This patch just simply makes actual runtime fit=
 for cmdline looks like.

mkfs.erofs --blobdev /dev/sdb1 --dsunit 512 ......

If actually `--dsunit` does not work on blobdev, should prompt warning msg =
to user.

Best Regards
Friendy Su

________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Thursday, August 21, 2025 10:00
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/20 17:=E2=80=8A38, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom=
 wrote: > Hi, Gao, > >> What's your `--chunksize` ? consider the following:=
 > > chunksize =3D 4096 > dsunit =3D 512 =3D 2M > >> and two inodes: > >> i=
node A (8k) 2M, 2M+4k




On 2025/8/20 17:38, Friendy.Su@sony.com wrote:
> Hi, Gao,
>
>> What's your `--chunksize` ? consider the following:
>
>    chunksize =3D 4096
>    dsunit =3D 512 =3D 2M
>
>> and two inodes:
>
>> inode A (8k)    2M, 2M+4k
>
>> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?
>
>> Is it possible? what's the expected behavior of
>> this case.
>
> Yes. This is the expected behavior. See runtime below:

I understand that is the expected behavior according to this
patch, but I'm just unsure if it's an expected behavior for
the future wider setups (because some users may use `--dsunit`
for other usage).

So I tend to just constrain the case to your limited case
first, could you explain more if chunk deduplication is
needed for your scenarios? and what's your real `chunksize`?

Maybe adding another command option for this is better.

Thanks,
Gao Xiang


