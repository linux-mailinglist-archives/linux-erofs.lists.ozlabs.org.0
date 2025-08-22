Return-Path: <linux-erofs+bounces-883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11628B31492
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 12:02:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7bMK4HM9z3cZQ;
	Fri, 22 Aug 2025 20:02:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755856925;
	cv=fail; b=gGlvv6KXrFw9YNwrwYgmuSM1LXMUUMQnMfea6D+8NMnYc6RpIadl11sBNGJPBj5MsjKikTDx9NteevJVtgq1vdZVoQpjeY2FbfTf3i6ax3wCf04cyzz876fdlOZbQtorpprNjSFOS9YPvx6LQgqTVPvu5i6ZkQvq4ZEQCQy6nh4DovMXPF9Oo6+4KVb/pXJf63XChj+bh8juM52snoAqXvbqg9Mampj5/1z60UbK/JEDdJsSHzYk24yxy07ZXMDg5pndLpZgOAmu/SEiVJo1/opMSbcIsIzLOW9CYk1+03PRT4Ce3zZGoyCQ3efiKj341airADFDEsTF454aqWarXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755856925; c=relaxed/relaxed;
	bh=JRNUSpUQMku58WyTA53VTDsGvCK42nF2i0e+kMbvcBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=odPdf6/4OKb0L0FC3QAwLjtdpkzBv2kJicaVNYNpvJE86c3BcC8qx1tbZxd55RI7iUdq2/7NV34mmRwImyZOcoZWJYQPhdjJsB1v0QQnezuWuE+5t3cik+n/t1B9yRXZKG/0HaJfyO924Z07Rlr7VKM1KkKvTUxqeBBjVhiXTCTjTK+nCceZ2rcfcMq1gzL2VMunN7BhfMFH10EXd4944VG60O7u1RA5D9zUte6h4mBbr9cMKwX0Fbs5/tQSeLs3z4/jWGJtB+HFNdeP/REVeMVikf9yC2MUUQPAw+dTjHUBpmZRqrtbrJQp8ZuPgJwNEO4uRlw1lhEwcmq/j27TUA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=kECZfnXE; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=kECZfnXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7bMJ4v2Fz3cZN
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 20:02:03 +1000 (AEST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8PMrd017417;
	Fri, 22 Aug 2025 10:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=JRNUSpU
	QMku58WyTA53VTDsGvCK42nF2i0e+kMbvcBA=; b=kECZfnXEeB5FJ2vBz6f4FCA
	xERxW4padToeAlRkxUzvW+GO5Va4j7AASYgGhkSXKFjzroTeiVYOl1VSex4bn0uj
	fuEgmkyIhQSvcMbD81tElgeEHwTtdtDsADnfK0zwiknR0h1YRcHb1feWH8YYlkkN
	rUhvNPma592v+9WkeHHoHvHfKcah83HKabWXJlLFMDH6aeMKxtv63vUYsz2uJjAm
	d7ytWh8qwQrlt1fRScfDuf49ay8z2dM60vq7QB02zAQkuGX9xNXcb5OTS4CvwfOW
	Mne0Q3N20CtSZZy2XncYTMzZLKMHT86h/nvW70zUgFG1+LxKiAA5kVJMAILGyNQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37htqrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:01:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZBsbG01UiDzk//lrUWBusaEhJKS10ado7BRGfBX9fCg29MGXpbxgk7I0QQ9TKK2Ofne2/JMbiJVgJqutFJojT4/ewQTj66CGvjXhcA3X7yV8Y9hxXUaaa1mzULSiIBYokXQDIYQE51iSdXzP6kbqdBRvVuNWknkZt7x+N9UaTE5HNDW74UXnrouOfBgfBTttkBFxb3EWO+8rc9l+XeN0v3glVB8LAzyZe2oB9sZh5YVL6GQhq4YEbZlGsHef6Iu4MEYvYq24VFOFVgjUPYkX/LHnkRJ80Or4GVZ7Svzi975ks4j5rlV1v2ueXg7GHpjXarhTYIoQO5lOTjekweLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTwFn5XNTcyO4h0odWcfOrZUvQiCRYM4mStig5eRgqY=;
 b=cBonUI1CXjT1bNfRFPC/yCs93EEh2MmusVYRK9zpc1PAgtE+9P4D/iSNS825W8CmHH3Fwnauj9zedEd/vwBfI1dD1ilky7+hVw+P4OIkSyVZwxydZqo+dwrQdeATcCi9WAvUE88hl7xGhBuhkmugxCTPX/1zFDUCA7GjwZ+6fOSR1fkhdMaUQe/xiH7bUOrBfEXpYI6ueI3bAlMv3lhH+cSD9KmztHto5sr+UmWqteSRbZcFV+nlbx25WWm6K44jMRfCyAswwOr/ud8y9kjkM43mnp+wowziv81SuZjTyzX/p/weYEp6Qcy4YajnmRyLYsJ5Pxmq/1TGjHUOkmHq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TYZPR04MB7936.apcprd04.prod.outlook.com (2603:1096:405:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 10:01:50 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:01:50 +0000
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
Thread-Index:
 AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdaAAAx7w4AAAmQAgAAAlYCAAADmKQ==
Date: Fri, 22 Aug 2025 10:01:50 +0000
Message-ID:
 <TY0PR04MB61913A3AB4CF6B477439E6B4FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB6191A41E6265D02BCF22E8FBFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <a22386fd-d5b2-426f-a6d7-83abce5cf593@linux.alibaba.com>
 <888293c9-8fe7-4d5b-b5c5-b69196a8d854@linux.alibaba.com>
In-Reply-To: <888293c9-8fe7-4d5b-b5c5-b69196a8d854@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TYZPR04MB7936:EE_
x-ms-office365-filtering-correlation-id: 55fc316e-e7fd-42f6-edaf-08dde162e9f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkNQaURSSzdFTVAvZGZtZjgzNVFOYWhmMXlaeU9LOFU0Qmc0cXJienl5SFBG?=
 =?utf-8?B?NHdTS3U5ZW5nMUZXS0hZelQ3bjJkZ1VqYy96ejNVWFJuTWFnRzJwS1dyeFNM?=
 =?utf-8?B?bk16Szk4WVRVQk5uU0d2SEFOU1pOVlBBL3IzYmFzc2FVWmR6RlFpVnFXL0ly?=
 =?utf-8?B?NWNEUURsNHZ0Qy9hOStKRHJmWTRaYkN0aExXanZ3Si96L3paSVptcFdIUVJ6?=
 =?utf-8?B?YTBXUkNrdDI1eSsvbmMvOGEvN2Uvd1E3VkZPVzliYlY5alI0YXV0aStrTWoy?=
 =?utf-8?B?cnNWZmQrdmFlMUFEb0taN1h5VSt0NEFndDBXWisrMkhDOVFJYUMvL3hzZXhy?=
 =?utf-8?B?NHpOdzhwbHVzbXJWaHNpVDN6UVNGc0tJVmFnZzFKTFpMRUNoNDFTSFBISFgw?=
 =?utf-8?B?ZnBGZ2hVdk53S2IxNUkxL2JJaEMvS0ZiRWhRRmo4U3lRSnhrbnFIZE40alIw?=
 =?utf-8?B?Q1E1aXFtY09FdVIxRkl5TElmR3VGbDlSOVJVMDc4b1pFL2ZFYTZmWGpQS3Rv?=
 =?utf-8?B?M3NTbURoaXNGNzFmK3R4RUI1ZTVTQ2Y5Qkc4L2hNMG5SK25kb3VFbUdxQnNM?=
 =?utf-8?B?TlRHRDRmT1lBU2lyNWw0NDUrTUg5dVRvbEFRaURzQ0JYUWVpekRvd0dBSW0w?=
 =?utf-8?B?bU9GSXBkRi85dmRXK2tZS3FFQnRxeUJhSDM3YW1tOW5lYXM2OGxhQ25uZzRp?=
 =?utf-8?B?OFp4dXVMYWROWHpUMisvSG9VQlhBdVhIS0xmTVZOM29PT2RlUlQvODd1aVUz?=
 =?utf-8?B?cGt5YzNUSFFVc3NCd0UzRTN3UTVlNzZ5b3NlVnMybFl3cmJDYy85aHRIaVdj?=
 =?utf-8?B?SHdnNTRJbzFmdnA4c2g0eTJEckNJVFhjN29nTTVuUnpxcFpGNUs5YXdxMk1L?=
 =?utf-8?B?QzZQcDVMUDlqdmhka1prQXhnYWExc05yR1VUQmhPWWdNWlY2S1F1TElFcXFs?=
 =?utf-8?B?NVdISE5HN3dnUGlmRVVDQ0JxeHRKdEMxdEVOUG1RSDY5Z1NhZyt2QmlSTEEw?=
 =?utf-8?B?SWM1Qi96WHhPNmhvK3hIalhqKzNHRGkxUGZya0NXVnErbWZ3RlFJaGtFOHZk?=
 =?utf-8?B?czNBaWR0SVRoRndQcDRhZnpQZStKWXM2c0lhMVIvcjZwL3UvSXlSYTM5ZytE?=
 =?utf-8?B?QlJvL3hxZEp5VmYzQkY5dmY1K2wySVVrRGZFYjM5c2wrQWZ5aW1GelJaUXdY?=
 =?utf-8?B?VGdJODcyelhubVBJODFUVWwwcTJHRkg5aUZCUW9TTHVEQktLMkJVRmRleG52?=
 =?utf-8?B?NjdkV2FsQ3paR2c1MnV5dDdVVDUyS3RTck53WTF6b3BSdmhUbWxYaFNjRnZJ?=
 =?utf-8?B?RkZyeHZ2aFFHM1loTUZPVURZMi9uNXRJcTlKaXZXVkVSVUwwbWhyR2UzbVpM?=
 =?utf-8?B?YjBUTE5qczJWd2t6VUZFV0N2T25ubTcxd1hxOCtWL1F2cFBqdHQyT2hMUTdq?=
 =?utf-8?B?VEtGc0xqb050dXV6ZTIwSW1xc1Y5THorVnR2RGZhdXpNZVZVU09Oc3d1M3dU?=
 =?utf-8?B?UXp0aU9BU1pNQXpzZ1hNeWJIZ0pCQ084LzNPWHl2TjEvR1lOUGVGR0tkZXpC?=
 =?utf-8?B?SzRGWTUvei9rc01FVGFKZHdYSklPMS92bWNWMXhtKzZEcjh4a1Y1T05FYkFZ?=
 =?utf-8?B?Yzcxd085YVY1Zm1BbUtsVzNDelh6blMyaVFmdkthS0VDUU1XeG4yUkRnVjF4?=
 =?utf-8?B?VzR1VFRIYmdSV3pmTjE1U3lYWFExRTZ0dTNYSnJIK284SlJqV2lSeFhReWNm?=
 =?utf-8?B?ZkVSYlZLQ3Qrb01WNGZjVkpOWEU1NlZsMVEyVEkrOS9QbzdWV2VjdlJvbWRR?=
 =?utf-8?B?b05xMVp3VVQ5dVo5bzRSbkZNa2NpVWc3bWxqWUdQTjgrWGxDdlBYWGVzWjZ3?=
 =?utf-8?B?Q1NWTk9uZ2xpOUNNVVlOU3lpclBzQTlJM3NOWHFBZGdsUGlGam5keEw4cHFM?=
 =?utf-8?B?WDVVTHRyWlJFUHZXUGlxcnhqRnNCcVA2YWtCYnh3N2ZkT0F6SjRnbjd1Uk5J?=
 =?utf-8?Q?3S3jhNZtJrFDVCdqnH3aXEhJgEzuME=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGpTUUF5dVpXZlhIdDJIYW5oNDg3M3dXNTN3VlpnVUNNd0NWSW1xTmZrMTBr?=
 =?utf-8?B?dFZLTnFFYjVGWEFFcFhiR3dUNmIwdnlCaVF0dlhQeHZwUjVFL0hSUVJKdXl3?=
 =?utf-8?B?QUhQS1VLZzRSNVI0eUE1RlhQaHNLaU9GTkxJaUxHVkVQRTZucjVaRWdZMVdz?=
 =?utf-8?B?TzJUbTBnZG1hakQ3MWQzM0wxdjJZSktWRkRKMmcydnU0K3llcng4cURuU3Y5?=
 =?utf-8?B?VXhxR1EybzZDaUxoN3FIVVVOQTJLZXBYOGJscTQvS05sYjNYKzBPVTU2bTRs?=
 =?utf-8?B?OVVua0lxbSt4VlBjekxDSWQ1NjlIYTRocVM2TFZNam84S2dlVGRXa1ZYMGpV?=
 =?utf-8?B?TFNpeWl5bkNJSXUreU5CNjdFZTd5Z1BPUDF3OE45ZkZNYWJQRCtiSXczYnVz?=
 =?utf-8?B?cFZDQ1QzcjlNQ3dFUnlvWTRiRFhvckxySURZdzdTVmpZM3pXM3NqL0d2VDBK?=
 =?utf-8?B?cUxmYytyZWtwTkJ3RmVhcy9ubStCQjkxTTNSeFdUV2VxZ2lOM3NGVDdxTTla?=
 =?utf-8?B?dTJMMkxVV1N4YU9PTUtEVGNqMnU3T0tsc3ZRRHdzbGIvUEF4MlJHOWp2cC8y?=
 =?utf-8?B?dVIvQ2xoUlhXSUszSWRPRG9TM0NoTitPbENhWlI2REFPQ1ROMGdmeGw5T014?=
 =?utf-8?B?Y3czRWxGSW9GM1dDWDhHMUxCZEdSWUdvc1Nuay81UDFoa1VCTy9QVWoreVRO?=
 =?utf-8?B?aHBERVJFdXNwQU9mYmh6MzdtOExZVHZCL21kTXhLTm1HYk1WSE5zTUlBS1ZB?=
 =?utf-8?B?U0pNcDdFcGU4SUZkZEJuRStKd0VLZzZDUDBnazQ2dVk2ZzBaVjVpaFRuRFd1?=
 =?utf-8?B?L3Bzc2k0NCtyR0RFbFhjenJRZm9DY1pRUm1EcFdTVnJ5RWhHekJlMURKVDVP?=
 =?utf-8?B?ZTZMQzh4ZzZqam1OMmVna2tPaER5OURiMi94eERaTzhvOHVYUzJZc2d6SUg2?=
 =?utf-8?B?ZW16ZE5rQ1lGeEVhWExPMU5HQTNMRXNLc0c5OEtEdGVCTkpBcEJsTlRGS0V2?=
 =?utf-8?B?eTFXRmdaSm1QTHRJazhJVy9iKzRDWTNXMnhwUzJocUdiand4dG4vaEM5Qk83?=
 =?utf-8?B?ZjJ0ZDlxQjEyL2pIWTVJWUNKbjY4Qm1KRHU1QnVqeHhTR21mYjBZbkpJa0Rn?=
 =?utf-8?B?SXNOZG44cnJtdE9xdHV0b2lRN1BsT05nbEZwREFycEczUUZoUUlld0k2eW82?=
 =?utf-8?B?bCtlaStlUHhvbjlNalNHRkRxbWRvRE43THB4aS9vL3VSOUJpSEpFdEd1VHA3?=
 =?utf-8?B?bm5McEQvanhMSzNYQzZCM1ZNaFN1c1RmN2RRYjkvWUNnVERDQlpRMTlabC9Q?=
 =?utf-8?B?STdMeCtmb1AvL0ErMWYyYkxadTlyTDVMbk8xTUlndTRkYytqdEpaZTBsTmJB?=
 =?utf-8?B?bzh6c3NNcDNrK1NXWmNLNU9iVjFQampDRXBEZTNyVFRzZElmWFkwckVkZ2t5?=
 =?utf-8?B?cDRMeGcvVTJJSEt4Q0dQOTNTVWxYRk1RdGtIMng0cERKbW1OakZvMGJCWHR3?=
 =?utf-8?B?ZmVVS0d3a04xTFRrTjliUnZSNWdaRytveDRyNGZGYmVuV24wQlYxTENiOWI1?=
 =?utf-8?B?WWZuNHZtZVgxdElZQVF3Z3pIVGRMekVNeHhUaUEreDFSZHlGTjRrVUt3bE5X?=
 =?utf-8?B?SVdPWGNFd05KUkVlVGRpeDlmS2RHRGdMdlc4QzJkNi8wLzV1Z2Y0UHhwT2d1?=
 =?utf-8?B?cWVWTkRjTDZ4Y202dVJIeUs3OWZJL2E3M1BnWDBoaFJ4NmZYS1N3WHBoV2l1?=
 =?utf-8?B?ZlUzKzJsTFlna3Y0amJMcXo0V1g2K0pYVUloVVBpa2hjMjZWYzQ2V0ZaOU1N?=
 =?utf-8?B?NEtxUmxBMmhQWFM2U1ZIKy9hVDFxSTZvRlZiQ29WaElxcDk4c0p1V3J2elZu?=
 =?utf-8?B?YlRoL3c0TFVPOU9zY1d5a25Bd2wyQkRSOS9oUmpzZHRJR3M3dm0rNlM1ZlVV?=
 =?utf-8?B?MlBBM3V6b2crU1ZUeUtEWnl0a2VhMDYrQlRibExIbys3aEIrazJybjhFTVZM?=
 =?utf-8?B?UklvYlVyNDBrdUhrdmxnWHNIQ050Nk1lT2g0cjBIeVczOFVYL2VSTHpXMk91?=
 =?utf-8?B?eHdTVDVlMStINWQ1bkkwZ2hLekVxVnYyclZCREMyaGwxallUb1ZyMmlXdk9M?=
 =?utf-8?B?eTE0Y1RVTm5tTFA2OTU5a3JQN3RNSDY2aFdWaTl0dnNaUzlMY1VTOWp0OG9W?=
 =?utf-8?Q?6IIB2z6dG2JNVzZG0wLaoJQ=3D?=
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
	/WXTXh0/mvXajqZboDyBI0nEmnUnRmQt3oFoasN/X7KATTkB2p+ykZCE2QkqxlozLQLuIs/aRq7Wy9Suh89UXXlV2c3/3bAWNx+VP5pevVJv8Ia5qV1/Q9jnPKCcq43hm9hcxVzA/fLnh8L36+smOg4ecbScT1/7Szo8TymZeJtfflIPQrmFk1aiQh5tfCB+3VAHGAcXP8UqZm+Ehyy3GMWBC+Iap310fegqD5rV7WRT2w2+bDrh0ZBrqt6hPM3DOkJ3D8Wm4TBVRe398MFcJ4DRhkmGITyL8KFivyFrKml2qLrkWWGsjt9BykJvMWUr/Y6FrdoKKiQLusS19b9FSkHnagRUF2WM/CKlGGHNgXH78mUkR8C88SXtQIaU+1enZE9lljkxNvDjUndatJBPbCd59U8BDNc4ufhHkUAjx2K5IAm6ZnqzhOJN7+1qZHsxYq0doLAvLVvt9nglYpcuGcFABC1gIPd7kW9yRA8/QN9kP68eBCRO8uN3jQCjbyb49DAKMBCC55/j1N/NftXUNoD8IukwT/uLIIQY/wzquvdEuvFA58V1LqxOFi7RpCwvcDC9bixgX+h8kGa39mv4YcuF7pr0DDdJ26FjWpZrtwrwc8Os1akLI4lJ8RE8bZBx
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fc316e-e7fd-42f6-edaf-08dde162e9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:01:50.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92nLsp9dERqCM3nOIxnrIW35JCl2Q67Nymu8NVLUZ7fzWGPKuM2JbA3rpf/kiQmF+fbipp86Gk1CQOuI4cRR3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7936
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX1INvao/5J8MS woTuzzPlfiTSs2XPcTn7F2Ti6DAs7IAXsKH81SFXtfnNF8XjpiOw4qeA+nRPIt+XULTzHnXRR4N IiogeWukoCwzq8/qoevWImAXQCzODNAswOw2Zrl/OrYUme+MJcQRgnKB/hXvurfJ5RiWTFj7zA4
 PFjFEheUDK6p8cm1CswlYyDuidxMESfxwEAOcIWZIN+AElmVRTMFBF9rArDKmVTYt3CMDzeLdol 8UtAxMUtk+1ZKmAeVck625UJwBmIIN1t4qsYYnmy4zJD4JgBACjhqDQ6TlnYi0i6Alvb13FLs7I q4bR9Ll3ChE2dRdHN8TE2lMRxlakRxwuu4jlDPah+CFct7VeX6o9BfaBfOlLSx7GrDPCMQLLbVN
 HB6RC96C9PcMUpYW8b/hZ5ZGdRtUaw==
X-Proofpoint-ORIG-GUID: 0pMM8vl85tmt8hPdGqNqB3WC4a2VHqpV
X-Authority-Analysis: v=2.4 cv=S7uAAIsP c=1 sm=1 tr=0 ts=68a84013 cx=c_pps a=yzFcANwbdDXkjV0LA80XPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=Bj90jaK72LekJOHGxAoA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 0pMM8vl85tmt8hPdGqNqB3WC4a2VHqpV
X-Sony-Outbound-GUID: 0pMM8vl85tmt8hPdGqNqB3WC4a2VHqpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

OK, now I got your idea. :)


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, August 22, 2025 17:58
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/22 17:=E2=80=8A56, Gao Xiang wrote: > > > On 2025/8/22 17:=E2=80=
=8A52, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom wrote: >> +       if =
(cfg.=E2=80=8Ac_chunkbits && dsunit && 1u << (cfg.=E2=80=8Ac_chunkbits - g_=
sbi.=E2=80=8Ablkszbits) < dsunit) { >> +




On 2025/8/22 17:56, Gao Xiang wrote:
>
>
> On 2025/8/22 17:52, Friendy.Su@sony.com wrote:
>> +       if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.=
blkszbits) < dsunit) {
>> +               erofs_warn("chunksize %u bytes is smaller than dsunit %u=
 blocks, ignore dsunit !",
>> +                               1u << cfg.c_chunkbits, dsunit);
>> +               dsunit =3D 0;
>> +       }
>>
>> 'ignore dsunit' means set it to default, default dsunit is 0. Is this co=
rrect?
>> > Then sbi->bmgr->dsunit will be set to 'dsunit'.
>
> I think it just ignores `dsunit` since the current behavior also
> ignores `dsunit` for blobchunks.
>
> Let's not introduce extra behavior otherwise it could have three
> different behaviors among different mkfs.erofs versions.
>
> So you could just drop `dsunit =3D 0` line.

So I tend to just kill `dsunit =3D 0` here, and change

`if (sbi->bmgr->dsunit > 1) {` into
`if (sbi->bmgr->dsunit >=3D 1u << (cfg.c_chunkbits - g_sbi.blkszbits)) {`

to match the previous `ignore` behavior for dsunit < chunksize.

Thanks,
Gao Xiang


