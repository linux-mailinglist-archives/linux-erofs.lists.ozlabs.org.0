Return-Path: <linux-erofs+bounces-874-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0EAB312BE
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:20:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7ZQs6PLsz3cZ1;
	Fri, 22 Aug 2025 19:20:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755854405;
	cv=fail; b=c7aDCucmQ/+kIP3o6nMOkzQlMKVCefxFkrMa6n8XxCygvlfBe1zN5MBbWVoiYoI5sJw0AbiyOozge0QpkHS0siEsRczX0Uvbdkrj+zh5IHZ48XjBId4wx6UxqiMs0/k3PCV6dWf1CVkFBjD0W/wQ/SXK6CQ0X/HN5sLPmL9sJ2zKRdvtfaJNxgv5fVlqA6tQ9tpHKpasux9Mrg06FZbscdQLTCtiN74aHczP5LQ2htYKIuAsnaMTrq5Bm8bti7VeIl3aXWPAu9qluZ+Mw3IqyUwYJc8PDYzI3hylbr/WBgwaHjGpHzdYyRFbpV/GQegTvW+Rul5otRqNCEd+NRGHQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755854405; c=relaxed/relaxed;
	bh=56EATrTz5Yy8t2+4Nt4fWPOOB1Mch9+SF4x3PW54Zq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NcTxti/AMJH/vq/1uiTSNxrpGrQXH4o0+gD0Ut4gnAgdR3gkU8XU4/BwMU3w8Kud7dPWFk2HJl0MM4+kDaQBwUAYxTb5f9uvCflsWVePu/OLRQGHQH1iTV1zxSslYGIWZOy5eW9DsqURr28ui/E/vIvp5BMl/UU1ycwrSD0YSlHbJxzG27ECUhdhFwKIW9SQm9uWR01wDWDmjx1Cb3HbTBVP2RTv9WUHIiyr9u2lU5jotf047wvYWRIc6BItncWX7KQXuX+1cwlOD8Ld960JHXig4M0gsTdz4Envj3pXykMR+ELvxxmtlbqsBAGhAP7UuqlZQBQPqcOKofIQw8Cf2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=EVjxdz1P; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=EVjxdz1P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7ZQr5MPwz2xd4
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:20:03 +1000 (AEST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7KCxY003187;
	Fri, 22 Aug 2025 09:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=56EATrT
	z5Yy8t2+4Nt4fWPOOB1Mch9+SF4x3PW54Zq4=; b=EVjxdz1P3K5dMD+CTvU+5IK
	i4Jc5aPJ88FZPtY1GvJcmn8CMBSn3gbDHP1XSGjFBNp9uAe2uaTRTUxQ6TTGwBQE
	piYs+soalSIqTx3sfhcAJqGlGyZeeMLINk1XjObFm3RgsoR+eI7Bqahy7T8TfGYp
	4MZBwtZYQ9X89nSo7pYeETj8bG91IfD6oHx2ColvP5giFKZrt7YwmRNJo+hFz2x6
	LR3WZHUhh9qGGKxEjmAYmNIpFFc/nV6n1yPVAjqiFWQ89lr68p/wv9KOXNdjBDbg
	zhJ9pLnps4qTbdqS6KRcXmyovVyk4THYEEdtNgo1rLlN7PYIToEi5nbG5s+8IAg=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012044.outbound.protection.outlook.com [40.107.75.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37f2fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 09:19:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja07NN655u+ekxEYmFXiiQYXL32ZkhCpbxL1FH0Or2mHl4j/dkBGNdmQLcoJninMInwQJnj+WdlKQxkb38LqOnlKwrNSXpFDTj9rUkB7guUn7/25Ba+84GaG3//k8GKMoEyoHHzz+HnaXwGn2XEZbuAHCX9OwbwLOW8wqgSobZIbgUGh1uXPanikIQDrym3/SpTtyASIsmekvR0Hi6gV8FuOHEFIEymbpa5q6t6EdYHGYGPhsbxLZz3oku1XqbEf7BKfSUPIJYJGmlEjy++ArcGEiBC/+RgrH6+hySBT3kG52tZ8+cXXMxHlL9me5TU8o46oKkv/lsLzKFmBxbZsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbnyABtV/I1XZmjhNqiKL/ptuPS91FPEB6axbjVmMGs=;
 b=CoOqlWDOHo5f9XW6bbUPNVBnEi+kpJjbU0s/GqF77f+qZwqgCuNsJUx7lBO/ktQu7jG9iEnAqm1b6rvDESJ61SoWr97EX67eaFpqonLCrs01+Tas/Xjv38rTuRR/awkP8ENp7s0SRvW3WkIO3LxLsyphjXoryfqwvNYx2qeDPB8IQVvgvBm27B23RYCJubgpcSYFBH5olvg91s7xVoXDJkqapPGPCTFLwLF9FfTqhqdryfEHqgup52e7XdVayJlhk3m5PNmz+ln0sLj4U0q1ZXTuGaAC0Ii0CxbUP6NsucjP4lseYBJrOvzWkhYjEb4FJ3HNMNCXXGFA7+r4wAeKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TYSPR04MB7749.apcprd04.prod.outlook.com (2603:1096:405:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:19:47 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:19:47 +0000
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
Thread-Index: AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdaAAAO7YQ==
Date: Fri, 22 Aug 2025 09:19:47 +0000
Message-ID:
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TYSPR04MB7749:EE_
x-ms-office365-filtering-correlation-id: e5b84d52-eea4-482f-a7ee-08dde15d0a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXMyQmpPN0VyS3JBYjRvVGgvYm1QUEtCcEJiYW44Umt5YWF1WGxQOWxLQzlN?=
 =?utf-8?B?alhubEdRL0k4dS8yTjhJbW5OWnRXaFFFN0Njb0RrdmJMNnhDWis4cDM0OXh3?=
 =?utf-8?B?WlpKcUU2dllQcG44VkRBdVgyRlR5U212bFRlbnZucnJxK2VwQ3lSczd5Y1Vu?=
 =?utf-8?B?UC9MZ05XVG1ZdkJmSitwdHk2a2o1WjhGdkg0bEdaZU5EdUFIeEhaenpVRUUy?=
 =?utf-8?B?SW1DMGxxNUpZZFNHZ29TSVpIQlhlQTNEc2hVOVJndkZnMnhLRXJOM3dub1Y1?=
 =?utf-8?B?RmljSWhIelpYeGsrSEdZdWhIbnNHUFVKZ2JGb0NScnNmKzlWbGlSSGwrOGdD?=
 =?utf-8?B?SjR1MDdhc3NOUzFpR2piWTR3eElBK0xTdFJ1Q3k2QTM4ZFloUSt0U2xIbGtr?=
 =?utf-8?B?V1JaeUxpSUJXWVd4TFNmNnY1WStVb3Q3ZDNKTGFBUURjdGRpWHNkbkltNzFW?=
 =?utf-8?B?R2xjbXRQRWRkUTFLblBSMzBBajlubkR4eVRhRG5PQVNYSFA0L0xhTlhLZFRT?=
 =?utf-8?B?Z1dnMTBnZWJuZndHbnhHRUpJREs4TjJaWTdLTUEvTzZ6dFEyMXVQM0hqVzd6?=
 =?utf-8?B?eStZYVl1a1NhNjJrVjAwSHdpRG11eFZUdmlLM0RJOVlCcGNaREd2bndxVGIy?=
 =?utf-8?B?NktpVGdiNGNraGJxWi9YVVR3WGpycFdOUmdoSFh0ZHdBamxTUG1VUEpNT00v?=
 =?utf-8?B?RFRrYWJPT1dzUFRoN2FySWNLYTlFWHhWSWhRbGpXNi9FaW1BS3VPT0JScUFh?=
 =?utf-8?B?SzNySytUbEk0VHZXOWRaanNJVnNOWmN0SHhtckUvZW1EazZycWVEQkdHZ01k?=
 =?utf-8?B?Sm9Ub1B4Q1dJaERsWnQ5OTlMSDdtNThFSkFnUWd2SG8rVUVhVmtUMWdQVzl4?=
 =?utf-8?B?ekVCRlFUVFNrN2t5VEl3R0g1aVAvQW96STVRQkhyempKVGJSRUNtdUl2YlhH?=
 =?utf-8?B?V3FKeFpvZnBsN2JoR2ZaNHYvQ0hqZFhSQVNWTWRtOE5LVzNha25vRTRud1dD?=
 =?utf-8?B?aDdsMWJwcnl3SEFPS053dWlVVWJTM3JlTlhHUDhKeXV0K1J4bEVmUEd5VzFL?=
 =?utf-8?B?RFZrQnlUNVV2SFpIUE1jR3BTOTE0ZStWQUFBQ2V3b2M1VEpzcXM1aWRIWURU?=
 =?utf-8?B?Q3BxenVoWllFcVNLVXR3NjhhK1kvWXpNSDJ5L0ttb0gycS9UY2RhR21PRlRS?=
 =?utf-8?B?c1B4d0pURmRrNWRqcENBQ1VmOGFjZ0t5QXlrcEJJTWE5a0JTZGJzUzdnSTlY?=
 =?utf-8?B?QmduNWg3SnM1Tk10RWhRWmRsL1JHQVJLVm4rYldoaFc3d3pIRmFSTDVUcHVW?=
 =?utf-8?B?N0VQM3B2TFRyR0dZMGJFL3JTWXd3TnRtUW5Wdzl6UzJPNzlGTWNoS2syU2xm?=
 =?utf-8?B?d2l1V2F4bU4ycmNnRlI5cE1HNy95RVVIR3NrWDEwc244UnB0TUErdmU0U01u?=
 =?utf-8?B?N2pQOEZWTXdEOFpPWjdicTdBbnZsNkFHeHFsUnlNOU1oaVZkaDVxSzRiV0VG?=
 =?utf-8?B?RnMyZlg2RXRNVzk5S3JuQXE0NVYxTFhtMjJVYXVBQURuelN2R29ZRlhiY0tz?=
 =?utf-8?B?ZlRGUytHMEJKOU43bUJTd2NtMkJicnFpTGVSVEJRejJmNlhuYjFPeVV1UC9u?=
 =?utf-8?B?TjJxS3Q5WGdEZXdUYTB2MFg2Y3ZIWTRneURvQkxLWEJKRjI4OHRKWU1RT2x5?=
 =?utf-8?B?OGhPTU43YnNtODFsMEc1M3BoSlVhM0YyMHpoWWVuMHBKNzdHMXUvMkxDUmdt?=
 =?utf-8?B?NHowcmhPaWNTSXF3REpZSEtwV0txdkF3YTdIL2tWUks2TlBFbG5QcmRyeUpT?=
 =?utf-8?B?TDRPczcya2V0ODNKVHFKNVlkN0lZMkZSZVhYZVpEUXJERFJQeDRHMXVXaUFx?=
 =?utf-8?B?S0dQSFJzQmRLTkMvZEZRRXpNT09FV2VodVh1TlN4WXBuSGJiYXNrck92YXhz?=
 =?utf-8?B?Mkhva1JScFE4RGNmQ3NhWW9hQXZKODFqVCs0ZnZnMFhxS012QzFIRXE0N01i?=
 =?utf-8?Q?nxAem5ixBuE4/Dzf42wXit5XG5Jjow=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUZMUHRMeEhMcFBxWGsvaW92cFJRRjkzL01sRDI0bC9lK1Z5WE1mQ1BFZ2ha?=
 =?utf-8?B?YndYWFFtbDcxdHBwamUzbXYrdWxTWmNOaDRWc0pmeUFLUDVnZlV2eWhBR1Va?=
 =?utf-8?B?NzJNWHF5Ti9EOGVxNDBub2l6SkpiL3JubldwUkZnaXF4em9MZlQ0TmpqZElZ?=
 =?utf-8?B?UDY5WE41a2I2dWFlK0grUXU4TUhnNTFhM3RtdUxRMWh6QVlPbll3K2lQc29Y?=
 =?utf-8?B?WTlnbk5kOVpLdGVCZ0d6VnlVekg3UXIwMVMxTHA4RFZ4Tmh4SkdaTzVrcXFi?=
 =?utf-8?B?MFlWa0IyaFpXL3MzWG15SnlOUDBpWVZLUDdEMEZiQS9jNUxyd09RcFp2dkkx?=
 =?utf-8?B?d1NQZGkzMDdKWDR5eGx6RjQ1N2tweEtrT3BoeTNCOHFwMVB4dkZNbDhOMFE5?=
 =?utf-8?B?N0Npc2JCeUp3Y1Nya2oySSsvMWM4NnBRUUtxQUl5dWljZDdoRnI4NUhZRGIv?=
 =?utf-8?B?TndGS0VvWTVqWlNIUjA1d1pQUTRyeDduemRKM3hpdlZEQ2VtMEtCenFkUUVE?=
 =?utf-8?B?TWt4MjFwSnlJMmpZcGREMHB1a3pBbUFzbEE3aWlBNjdTVmN1MWpmMVd4Ym1j?=
 =?utf-8?B?TGFXUUtQTU8waU00a3pGNzQvbm5DSTVqVFNaWGE3U3U2ajdDMklXWmx3QVhr?=
 =?utf-8?B?RUIvcHVHTFZSU1NrNi8reXYyamNBSkdOR0hRVWV1WXJkeFIyOTZpYWQrditx?=
 =?utf-8?B?ay91T3d1VTNkaU8xZjBaUlJNdll1S3BkT2RYYnMzOTQwR240TlpVaytwNy9t?=
 =?utf-8?B?OWgwWUQ2SjlTL2JhQmxUOHEzaXBXaUFkaWNtL3ZDd3FjaHN6ZHVQdCtIL0RX?=
 =?utf-8?B?cVlFT3ZHZVd4NzV6WHV4UlIzVlJzbmprQ00zbnhnd0EzTUY3Z2ppQXpodzR0?=
 =?utf-8?B?WTd2RFB1QUd2WmVZbmtDTThTWnpzUHp2eVFqd250Z1pXWlFWN3RXSHgzRk1J?=
 =?utf-8?B?VWtwY0tMaWtGYk5mRXBLVDZOaUVrVEIxOE1FSnVGOHh4TGZNWXlEeFluRDlL?=
 =?utf-8?B?cXk1ckdxVjdqemQ5VWhNSC9tZmJlZHpNMEswbU5NQnhvRzhjQjdxZ09tdGRr?=
 =?utf-8?B?NEdudmNuUSs4RUN0SVkzTHp4WVpYZGlOMlpiOXluejR4RlZTSGlaY3N2NGNq?=
 =?utf-8?B?eFpraHR2UUFId3VoNEJxZGIzLzQ5QUFjN0MxYVFvMFV4U0JoVzdicW1aczZE?=
 =?utf-8?B?OHNpTlJUYzVrN2YvR1NabVlsQkVKYXdjamI4YXJBa0hEdkJTQWE5ZlQxNEpx?=
 =?utf-8?B?ekVIallSSjR1b2UwY1V0MGp5Z20zbHljb2JoZHdkSE1nZldnckpNd3JMNWox?=
 =?utf-8?B?elN4WjFRZ2x2VCtRendUaDVRaTlidVRyMzV6MTNPKzRTbE1DN0ZBOWxKbHFT?=
 =?utf-8?B?WmYxcXpxQlRFVEs0clVPZXRxV05Sc0pQNy9LbWVEZEsvWm5oeWFacjlHTWdy?=
 =?utf-8?B?OU5zK01OUlRjSmhsREUyalFobkR3S3NmR041eEx5Y2RNYWcvMmpQT2xTeDMw?=
 =?utf-8?B?Zy80UTUwb1dUa2lUMm1SVXp3UWR6TXBja1MxcTdRZkpnUGMwdHJBdXdXYVhz?=
 =?utf-8?B?cDg0ZmpwYThudHdBQ2Q2WE5scFB5M1JqR0doTUtaYktqTkJwajdPSnlBbTZB?=
 =?utf-8?B?MU1TQytOSWFldUQxc1M1cHlBV2tVRFVXQzVMOGk3aTE4SGxlVDdrVGllYmxp?=
 =?utf-8?B?SHBZL2YwSGdBRjluaWFGYnVXR05tY0pnL0RWTkd4UHJwNzExSUtVUVQyNUtn?=
 =?utf-8?B?ZDlza0JydE5pdmcxMGxUS3NkbEdRODRZTHIyeGZLcEdNejBIQ0ZwTXlSUmQ2?=
 =?utf-8?B?NTMxWjBNV291RXRucHVEL3RpRU16dHhVSkZnQTVmN2FReklzeDZJWG9BUFM2?=
 =?utf-8?B?NkQreUZWZ1o0NGszS1h5ZWpNTXpBMzFLTGgzaitDSVpONFAwUVFuMmhMM25H?=
 =?utf-8?B?YmVuSDBaMzhOQjB6VTdGYVVGcGJWTVp0SDNZZVd1eFFkc2JKRHlCWHd3Mzh0?=
 =?utf-8?B?VElMZktLUG03clh6b09Ham1ram5KTy9SakkzUXhtUkQvd1RxdWVIUEpUSUUw?=
 =?utf-8?B?STZ5QWMrTGN0SnZsVFFkQi8zbjJSMHVhQ1gxN3VyZGp2d2xVNk1kd3F6YUt1?=
 =?utf-8?B?b3NIek56a0ptQ2VHakJzM24zNk9hblpHZm8xSFpFaEt6aS95ZThlampBUkJs?=
 =?utf-8?Q?1YdTo8JNGTp78I9tLJzdoCw=3D?=
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
	VQVnkiAfpvhVrXDqZr8++esClVFUYzk0/xjkLxdCyNCjhC3SZufHklmpbDXTVJZf5NJ5KZ5+aD+UQbSl1sD0LgX0HW7kfZgzvoX+U/9aZy4h4lAqrUep07dVM0p3HI08fWPBhdcVdtHDleMZc4HbLzvR1aFpF+e0xTGmbbqvAEdQQHyfxpoWx4F89bMan5tmT64tOoO35wEaLmHZY7i7nEGVnzWCnvdsE7ZjJenSeVY+mPFCDSriy91T93ROX+rQTvH7X0DSAFt1425I2GdhUA8VFQvwve6bEnPxJJhYv2Jdg1b5ded7K/UAsv67hmcy0ulqYIOjkDoaTw3At2NaXBbABdRmAcgIRHs1n38pNt3tYNUdsXdSDljP0fsGK9b3GCvBRxOTqpk2zRsEhbbdVSTNtcxwdY6mAdtNua2udtWy7bnC8ASWnGzJsolKO5iPYwy5K14qLP3OryA8S6SagakpvTsxgtWfYf7VxmvYhO3Z04YJriRznEUijvleuo0l6r6SrKG+KWi2+H/Bn3jZOOTNyJ75+owoJt1WbDX3yaCQ9zn3V5NjFqFMXRWEq2pIvOVdnR//JIDx9f+Ap1rw82ATy+MevUZqy3LmvbCEgJDkcbj2eP5+99JxnonKg4+3
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b84d52-eea4-482f-a7ee-08dde15d0a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:19:47.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NPVpElvyyOB3thtFbMSKSXyCrpRAbag8lsWfy3/wix7ox1SnwXfW67KV8sBEjUK6W1Hu2Wx580VOvYuq+MFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7749
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZpO0697G c=1 sm=1 tr=0 ts=68a8363b cx=c_pps a=RHkFnm9k6FAJ5OZb3b/A3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=voM4FWlXAAAA:8 a=SRrdq9N9AAAA:8 a=57PknESPhfnYMIdZ0J8A:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 35lmF2eFEG8vXNWT8X_LgyGj8ocyrr-5
X-Proofpoint-ORIG-GUID: 35lmF2eFEG8vXNWT8X_LgyGj8ocyrr-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX/ZVsyt+kbDap onkVkIoHsnIVMlpOusoqf5kZN/VjdxYwS7N//4POKk96tR5gL1N576EYLu6UzCvtQmGIULn+Bgu tU86YD32cm6nrlusgD5Sa7EyEn2CSRWGxz0AkuFDgZC0Cm5hwJpJjBJQ9NrhgFiYy7KslXXb1Z1
 zn6UuPe7ROL9Gj/0H/4/MPKJI6qSaJBk7Sdm6SIm5x4g+bOH5mmovKv+eOa78WhoEnwyN9ATJdp CCqXJW46YLomVY4vfFEL+N04uCOHPbJEil1I29LshVtbqa11F3gv/tmczUna9hj+LN7N4QHWNcN 0uMsN7pwuyDcbnUzcdP5wZb0b30KrEBX1Q0Wyx/Wy2lit1AVQsinZh2gpdCFJFejMmRpjEuuKNg
 Bwoj+H8zZ7B/BAMiCC0WkB8aIHErTg==
X-Sony-Outbound-GUID: 35lmF2eFEG8vXNWT8X_LgyGj8ocyrr-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

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

Here, 'off' is changed after roundup(), we need show both 'before' and 'aft=
er' by one variable 'off',  it is hard to combine.
Do you have better idea? ^_^



> One tab is not 8 spaces here? it seems indent misalignment.

It's my mis-aligned. I will correct.

Thanks for your comment.

Friendy



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


