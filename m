Return-Path: <linux-erofs+bounces-862-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E3B2F4E6
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 12:14:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6zgp2frWz2yhD;
	Thu, 21 Aug 2025 20:14:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755771254;
	cv=fail; b=CuOZ3zvMqrCpsgFquU/KHohD0kxkZB+jjz0YRv45KLCByIva1lpAO0qE++dS0eR9gBQ4conzEua+ph6pswUKK2IzViS/04mBt9OOywdcSr1Spx7aiV0K3suTkDIYz0fa9+W9epDESgQA8QqdREFj/XnJ3yml9wN0S6nqUuxPgS+aqrbVlQA1HUrljH7M+/ZcVEPaA+ucuHrYaVQ4eMMbVbqeNHaPiZ8h7J3jP8BaDdUCcJieUxL36YVqdllCB+0rtBFDXsLRlnxkECCJHikzx+cYTiOEfiisIKAuzVR27KpIBmyBZ51U4/rhDhwRM+tAOeyJ0bpHTNU4IpJZnwwNsw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755771254; c=relaxed/relaxed;
	bh=fDcw8oCqZTahxAPF6KZuyOlMX8HBSFWSwHUnv6pdQlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fZ3fGFUQXfPJTOyDKk2oG6J0YGqxRgqwbVhWspigBQi1dc0KGuv7bpdGaD6CwLs8wrx4X2bnUVJV0vH8b9IHQZU53+OGd7CtfhgH6OfZmxfHLVoAOCAc3AKSdPe3GuHZ0wF1ZavebjQFJg6SBLKWzN3N3fKZ8FiEzgIPkjWuexyqXU92HG6RLFNhfCgSUC/nnDFDO6bP3DzGQrYxI2JBWJs63iw7KlKUnNDVXq3i+Bg07AsNH7uV/EEATNaCyF/wKwBBF5OxGalieZ+4xBKIpp3Giq8BkzdFkO3N0Epmw6wYhGKT1JCk90BUDFYdZwzeJRHD+1Pt4acplnzgbdQEKg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=OC/bFsSZ; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=OC/bFsSZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6zgn1T9sz2yCL
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 20:14:11 +1000 (AEST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L3bpbx020998;
	Thu, 21 Aug 2025 10:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=fDcw8oC
	qZTahxAPF6KZuyOlMX8HBSFWSwHUnv6pdQlw=; b=OC/bFsSZvW4k8IFHSuoDpOj
	yE5oBG7AzJqBxP+8CR9bgWHyCMdZ+YiUnNamuWYw79F6PgXHacLWVtHobJnPifgT
	SSUrpkV4Xsv9uyk+KdD6Xe5yPQZix8Nz9DSxCef2/l+Y94NocjD6/K8zpA4s4+ig
	+qN3iUmjJMPmi6cETAxOsOCkSo2FYAbdUdUEmdow0h/WsBK/Bi1R1qV974buYzrF
	2hupJqx/S70ijP5t6BKJplF3iBQ9DM/5UReiCCSXcl5u6PB7vZJyS+vc+wgFYIay
	L36pGFHI/qhbs+gSqNbvmOYCENhRciKbu3mYeUZ4zglPuq+iYyyQ3PiDEdBZU6g=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37ksmq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:14:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3A7TRb5MLwnXmn7LKBW9CEMyFoUR7s9pCV2yro4k1wH2eUPCnVLOJbNmKt3sWrmqj46yDar5O8unOvIvaGz9x+7Ic7WJSmb87GxYaQGDzozyn7Gz1O3f54XYi1NpAkTO0MRfpufbUQLnXGVJjUKL3NXR553JhpoZQLOgwM8tJE/7jz6z0wuNhVJGm/AySn2JlIPeDgXvUwvpen3IJ3oumBeJBgDKuaC7Hizh78sNPM6k9Hek8EyiiMBjTTYoEdaV3hd2MXNVzr/5fCQmzXuyjE++5OMFUJ3FdirKoJzWV30yneZTNt/XxOz+NzXh8j3KuBa1Hzp42847umujvzvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKJHP1rTyHUtLNXRiJJnOG8WfPkfpm1NAsrc+9yCckg=;
 b=sJpaQ1uzr9WTVTi9jXD0O89Tpfq+8ETFo4DUlEoKRV7rpmY6M70BAOvKVqut8Dmdi8EIYOYkxlWChuDDXkvRcmRC196mExG293XuwcGD4/IMocqYcslEsEJP3dQW2/NFpYDcSpLOi9z77V0DSPCUhW0guS9gFdqf7UeaYu22Ti2m5w4DiD/ogs2txJeLnaMun7soSPnEgnbN11jBTTxM4dUuZoYXj7jPj+jrQgjiukNBY7YuKjfb1otxjkEhX+QuZ8iST1ddnvndAl436Rhs5xYoxRZiNH4ScDMkh2wF3QEuW3JFf+FSls/1iBgQ/4bJU5IftI+CEpAM5YvHnK8wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TYSPR04MB8168.apcprd04.prod.outlook.com (2603:1096:405:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 10:13:53 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 10:13:53 +0000
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
 AQHcEaR09AqiVESPN0KCsjRcUS8Fb7RrKVGAgAAPTIqAAAkdgIAAAwxBgAEWsQCAAAc614AAErQAgAABnACAAFAwX4AAG0wAgAACpY4=
Date: Thu, 21 Aug 2025 10:13:52 +0000
Message-ID:
 <TY0PR04MB6191B38474EAFAE929062433FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
 <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
 <97d6c19f-1faf-423f-83e7-0996fff2ca26@linux.alibaba.com>
 <TY0PR04MB6191740A411A08FFABE272EFFD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <753b7f16-71ce-499d-8e1c-dac1503929b3@linux.alibaba.com>
In-Reply-To: <753b7f16-71ce-499d-8e1c-dac1503929b3@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TYSPR04MB8168:EE_
x-ms-office365-filtering-correlation-id: 8cd2d165-9504-41da-a0e4-08dde09b6e35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmxaSlJpZG1rcG1DN0hBZFZINVgrVXFRNjk4cm9MTE9pTjNSTitnT0hraGM3?=
 =?utf-8?B?RDNMUytsZTAxUS9IWDV4SlY5R09ndHZVcGRqd2F6dEltenN1N3lNOFpWTTJt?=
 =?utf-8?B?NFU5bVE2czdTdWo1VENCRWpudnZPZmxsSUpEUGFnZkVDR2VUSFZrS3RPNy9N?=
 =?utf-8?B?MGdhakZtVlVXWmpFNVROdlNmZGovV2ZuOHU3TW5xNkJ0NlZGWURPMDZqZEkw?=
 =?utf-8?B?VlVGWUh2eTR5S3dCZWJlRW9teVAxejBvMFdLdWdObDdOUEtQRGgxejc3NDZW?=
 =?utf-8?B?enFqMTRlZWZXSHFVUDE1bGNxbzZmZzBubjQzcy84bzExQm1BbWNBZWZNbCsw?=
 =?utf-8?B?d0dwTnk0aytIbm9YUUg1NmgyZWkzbjhCT1RQSUZTUjBUS1FPSFpZMjdWRU04?=
 =?utf-8?B?b09heklNc3hjYW5jbEUrZElhOVV3cFdjT2tvbzJsMGErMGNuclA1eGtYSEFR?=
 =?utf-8?B?TEw5L1VkRWJncGxVK0srMi8wdFk0QXV1QndpaWxkYldWUnlkMTBNRXJaQ0lp?=
 =?utf-8?B?d0pwQzZCb1RPUW44bERselVBdHBIMTdkamhXTjJpcTFpcmVjYlVrQzJvWEVV?=
 =?utf-8?B?dTYwRXQ3VU9kc1NENnl3VkEvOEFhYitCcC9BUmI4a2dTMm5ZTDdaN0k1aTRG?=
 =?utf-8?B?YS9WR214Kzd2a0EzZzJLZStXV0lUdjVKcXhRN2Z4NFlLekU2ZW5iV1NZSkZX?=
 =?utf-8?B?UERpMGQ3Qlc2U0lOM2M1N0tuWEh0ODd3T2w1aG1aanZiL1JzOHNTOWROM1VV?=
 =?utf-8?B?a0EvMGJiTXBzWUtvYktTejlTNkEzbmplZW4zQ1dML1ZkWFNRTlRKRjE0cVBR?=
 =?utf-8?B?VCtLWlBXUUpTSmtLdWtMdjY0QVY5cnFtUU02YzcwNG12aGdURFlYRmx1aEFH?=
 =?utf-8?B?RDJTQXNTN0NNZitYeDUvVW5mMjlJTTV0eFBMaTJmaWdtYUt5dHFjekxqMWw4?=
 =?utf-8?B?WVVsaVVnbW9iQ0F2bVJ4eDJPMnB6a0tiUERka1o4UFcrL0JQSS9EVzRZZ1Fy?=
 =?utf-8?B?SE5UTEdJM2d1WktCaFh1bHFLWkltVXFOUy9FdjlTNVBjS0xPY055V0FMMVk1?=
 =?utf-8?B?eVQyWnBmbDhscHd5Rk0wMzdBU0tENWJzNXU5dHpyMHRGaHl0cmlXRkZCbTdL?=
 =?utf-8?B?T09ZcTNJU0RRVWtVYXdKRDRsaW5pWGNEaGNRMXZFeTN4a1FZak10TzJpSmdJ?=
 =?utf-8?B?VmxRdzl6TEZnYTB3bEFFOXNDUzNYaEZHYWhTYlAvdmhQMkdkU243OWdaZXNV?=
 =?utf-8?B?RnVHdEl6aGJiQjlSV1c0MnpBaDJDT21vWTZHSWRYNmlKd0dINWNEYVB2VUZY?=
 =?utf-8?B?dS9pQWI3RDJOQkZ2eTcxNG1EUG1tN2NucFkvN1Q1TkVIaVBRbWp5ZmtZRnBS?=
 =?utf-8?B?SHQxZmx0c3dkU25laXBoSDlGSnhLQlNsSDVra2k0T0JoUmRzbE82VjdWb3lx?=
 =?utf-8?B?clRhUVBxcGU0VFN2c3V1SUxrcEU4U28zUVl0eHZXZnBQdmFQUnF5NDFUUjNa?=
 =?utf-8?B?b3VXNHRQYlJkT2FsTEhvL1JUSFI0VlZNRkM5OVROWklyOEVSbVJLOFZENDZV?=
 =?utf-8?B?cFh0S0RPYUdiNkovaldDcWRxYWdUU3YvVjkxcGhieUQwbUN4UnVDUzMzVWVM?=
 =?utf-8?B?aW96ME1NQ1BRZHd5RGxvQXo5Y3lxeG1DWld4S3NtWmJqSHBCbnpYWk5PdDJS?=
 =?utf-8?B?NEo0cmRORGx4VWpDbTdzaTVBbURCN0sxcitpN25ERVU3T1R2dDJYRnliQ0Jp?=
 =?utf-8?B?aDlPWjFwQUtQc1Fia1dId2Z5eU0rQUNNWi9aTnEzcEhTa2FhdHEyR2ZTMU5Q?=
 =?utf-8?B?bTFGZGx0bFIrYU9OSHE2STM5Q1ZqQVdWcmwxSWlQeWxpS3RpUlN3THdlNE5M?=
 =?utf-8?B?SkdnUUdkWXkydUhXeUlNbi9nMXhCVnVBczZLclpOTFM3dHQ3VEFRNjUvNjBo?=
 =?utf-8?B?UDlVZ0ZQTVhucWJGTjhaN3JkaEprRFRkczRGbFRGSE5zeHpYQ2Z2N0JldnU4?=
 =?utf-8?Q?1j9bIFBsHrRc6Bn6qZBtPi8Jjc10Bc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SU9VYjJQVWprVi9JTmpSZjVsRVIvcDdVVEZXMlcybVZNelNVcEI0TVdDcG9T?=
 =?utf-8?B?blBRRDZibUdienBqNTBTQ0pqTkI4aW5PMFFDdGlZUy9OekZwa0cyeW9WOSs5?=
 =?utf-8?B?dlU0R2dyZUltUkNRYjZQMDRvZ051RGJWSHl6L2swTXhrQzlmeEttZG5kWTZW?=
 =?utf-8?B?SVJTL3ZlbTVoMTgwYkdMWmU0Uk52cmZsNjNBY0Y5a3Y5WitoVW9jVlJrdzJu?=
 =?utf-8?B?amc1WDF3VVVPSzkrRmoxVFhRaUUwNHdzUTJ3aHByQjI1eEVncUo1RFJjT1Nx?=
 =?utf-8?B?SjVxeXdlYlFaaThKc2V2TGJ6alFsR1JxN1VSMzdMUEtlUVhXamF5L0ltVWZ1?=
 =?utf-8?B?NVJVY3NIWE9VSlhVL2ZaV0JnZFpJRGR3emVHS1VFSkpHRG1lYTZWZTZGd09H?=
 =?utf-8?B?Qno3OUNNZTJQU1Z6c0VYdllvbmVCSndqdGk3S0dwamYrUmlybHhxYkUyWkVk?=
 =?utf-8?B?TlcvZUNlM3BxVkxJeEhybnhoZVU3dzVBUWdrMVVDRDlURkNmUmhEbEpvenpn?=
 =?utf-8?B?a0tVck40SUhWc1N4a1JMSjFrbVRrMWwvZU9zRHpwUUM1eFZmOG9kdHMvQldp?=
 =?utf-8?B?amdFa2N3MCtWWjFDdlhKZmZuaUtoS3NBbm1CbFo4b1J5ZTVUMk5pc2VFVzM5?=
 =?utf-8?B?aG9BOW1MNkdDdDRlRkhjb0x1UDFZSlJBaTVBY0dlclkzWDdGRCtzUCtLSXdu?=
 =?utf-8?B?SUNqdkNBbWg1cnR4bnFMenZRV3dvamEyTDFLRFRlUkNjUTMyUUdTZnRsamNX?=
 =?utf-8?B?WHZnc0ltOGZWN2VFVWVDbnBxc2Z2S2RBUWVYMXNWOEhKaDdxOHNPWlZ3L0d5?=
 =?utf-8?B?VmNEelp3QlBVY3o0R0QrNk1SWWg0blk4TnVqZVBzQWlkNEN2UU9WaGlodlhO?=
 =?utf-8?B?UmlCQ3NMMG1TSVZSblhlNHpibkRCOS95RXhjOEJxSjJtNDVkZGdhSUVtMmZ0?=
 =?utf-8?B?UGV0OUhYVEtMZVFlS0dnalczUzRtNHFiWEVFKzFJNC9wQnNLZW80dy9TMXdk?=
 =?utf-8?B?Y3NxenJucDBQbUZ3d1RFblZOeGxZSXdkNzF1aTRzMHFWMGd1ajF5emxzRzNU?=
 =?utf-8?B?QVQ0WjVvaCtLSUhwbHNvc0lSOU40cnpITEs0cWNzb0wyM3NQMm9HdUdrVkw2?=
 =?utf-8?B?ZXFzVTZhTUZ4bWtVTnhBQTRVZW5TcndYamhZRm44MlJMUTRGYVh0N0hLWVJn?=
 =?utf-8?B?clhTYjdvSEljaXE0aUhTTHBWWmFHTGxMOFhpa2NYR0IvSUNRakNRT1pQdE5z?=
 =?utf-8?B?ZTRYa0hreG5Zb1F6amV1L1BjU0NXWmRJeUU2dE9LWER1YnNsQ1UyVTUyZDda?=
 =?utf-8?B?TnBNNnd4RVhKaEdqWXBiODNkN0VzN21GbTl4WjJsd3JwbmpvNXc0Z1R6Nmp4?=
 =?utf-8?B?WndsUlR2YStKUHFjY0d5VUwrUE9YbmRYWkZ6L3JNcTBkVmorNGVBSXF4djdF?=
 =?utf-8?B?S1BTNkJobUdDekhpU0tBOXNXK29GeHFXYzd2T0lRNWRkV1lwMVB3ZTNyTndm?=
 =?utf-8?B?ZWRuVmxtRzBDTjhreXA0dnVJSTZkdXluUi8rcmhDbmRVZWFQV0ZUOFE2MitO?=
 =?utf-8?B?UXFxK3FEektpMWZUU1BRYTlaektIR2VTaTUyd0l5OStlRTNkNjVhQWVaQkNM?=
 =?utf-8?B?UTFkQ1RmV3VGeERidmNRWTZyL2V6MGNVWWxGcTMyYktoM1Nrd2cvWGIrUVJw?=
 =?utf-8?B?VjZWM0xSZDhpK3JQLzFhR2dVc01QL2szRk45NTZ1Y0VDVWdqVHZMTE4yTDUy?=
 =?utf-8?B?S3c3WGViTlNWSnF3VTdJQlZ6SzRRcUdZcEZUVCtra1orSFh5SXE0YXRra2pa?=
 =?utf-8?B?NVNaT1ZoVDlGSG5QVyt2QVpaYnpFWjhjL1lXNHArZlB0dUFkcVAxbnE4ZHcv?=
 =?utf-8?B?MTNPVHBaU0VqUFcrd3Nvb2JidEx5MXUzNU9WblBHNmZPWC9aU1IranRlTFFC?=
 =?utf-8?B?THIzTVB3NjJHUC9nVHhpV3lnUUVmZFZDbVZQaUVmZGVwbExQZTlSMWFQMmZq?=
 =?utf-8?B?ZGM3Um1mc2JGUXhacUlkeWltRm9Fckw5SEV0UHkvd2dIUitUbk5PSUV6c1gw?=
 =?utf-8?B?UFNEeFNsZFBlVjRwa0tyTzZYZm1BOEwxbG9mQkQwQ1FaR0lvdVg4enY5ejly?=
 =?utf-8?B?aTBCcFp2dWthRis1Mm8xNWlSSSszeFlUcGVlc2ZWNUNkT3lxcFFpWWVsa2Nq?=
 =?utf-8?Q?PI3cFWaR84sZ0NEGmrctLGo=3D?=
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
	02xQBre/BeklLlosXAwq2OEtA+UU/C6vJYK2GoRrgvvcIsSEgVWoP0wd92oT5A9pRy5hOeJDdABmOAWWKxGxXz2UVYTGI6JaNSAB577a1GBS+vaRl0UHthBF8r39JUYPeoX7n3a9tAUogwiy1KK2Tspbr4n/AOM5Vvac5vzlyBtmS7imkuSQmPWk6gtww3q+CRsdDzn70gw90Olgy8d99U+dQ92icMKdbR2ch2zPaPYA24K4VguuBqf7lRCJyM21/MFbypwDd3Uh17nohwna25sNHLDUpFaNMOCYq/x4NHw7OvlXb+/lF4yKMoxPL6TU5L4cSNt4QG8VNyBfgq1A7AUXx1w7B/m9QRNfSSDF1dpIzXhNb7wPSzTmMc8xeJQ4dt7y+Z8AWaFG+j6NfZELtV62t/ttQyi++I8WHMmChkBEbfxU6CRI30vJ+cV6BRwNeUOHEC1SwATIWiKe3GJxWi5wTkL1BVNVAYsEWe0ae6BhzfYmlL+1AyErPi3CUHtlA8orfGUhgz2zceBhei1fhCCA4A8/T5eEv/Jqdv+ksdXJRaK64AeIKdf49AepQ4fize0aOwbxSfJfUxe5Fk6H+9pUIM+JNwakI/DCHdS7GFzZHr8eKv33tnpppt4YDPZU
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2d165-9504-41da-a0e4-08dde09b6e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 10:13:52.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bq1buseE3onN9BvnNz+d8OjBjTUfVShafgN1iMVaTQmgTl96WjqExHmv6XaVnZb9fvVwu4Z/IMJ+i9c2ay7n9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8168
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX2xgYy9xmnhkG KEBty7gb8wDbZk8ofAl8Gm/4MK/R/ZH2DDrNp5EsZVGeSHq5IZfk2FSUbuv8RWCZ/oTJKzJT7Sr i0fZMegSpqBwIkCi80EASy7/tiH6+/dba6VE8nqya2g7RwA9tcK8VRwsR1BPx8pwxjZkK6GKazn
 k5d/ktPgQEe2I365FIlUucq+E+xkBSJ+2075/wD5uNmstpLIZcUaLs0RNkKw3hiWaYG7ZjThw4d rGBnqy05gQa+aTY4jRzeD/F3oGJfKVUsaei4bEAsQozrL1ZV6TGudGi+NneMrBZANLRr3cCiZtW vxJ8++0fjGWR6rgxZ9ZKtCQn9RfKK79JaiWbMNVNWCvAOuJiUGvx2jSLq0Pbo5nD3u99drk6C55
 RhAW7QltKv6MGafZEIzZtFzsr93Wgg==
X-Proofpoint-GUID: Be6E4o12narGDH0h7UShEbNPTL2GLA6y
X-Proofpoint-ORIG-GUID: Be6E4o12narGDH0h7UShEbNPTL2GLA6y
X-Authority-Analysis: v=2.4 cv=X6oL6GTe c=1 sm=1 tr=0 ts=68a6f16a cx=c_pps a=l2mmLeCJiII7mWy1GF0jxw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=ziBiD3pvh6hlvc8l1uUA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: Be6E4o12narGDH0h7UShEbNPTL2GLA6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> But could we just apply your patch only to the dsunit>=3Dchunksize
> case to fulfill your exist use case? I mean we still ignore
> `dsunit` if dsunit!=3Dchunksize and warn out users explicitly (
> `dsunit` doesn't work due to dsunit!=3Dchunksize).

Agree.
I will update patch.


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Thursday, August 21, 2025 18:03
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/21 17:=E2=80=8A36, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom=
 wrote: > Hi, Gao, > >> But if there is some deduplciated chunks in the log=
ical dsunit >> boundary, don't align it at all since there is no real benef=
it. >> Although I'm still not




On 2025/8/21 17:36, Friendy.Su@sony.com wrote:
> Hi, Gao,
>
>> But if there is some deduplciated chunks in the logical dsunit
>> boundary, don't align it at all since there is no real benefit.
>> Although I'm still not sure what's the default behavior of `dsunit`
>> for chunks.
>
> Exactly, if `--chunksize=3D4096 --dsunit=3D512`, any 4K deduplicated will=
 cause PMD map failure.  Can we consider the following countermeasure as de=
fault behavior:
>
> 1. In man page, describe 'chunksize' and 'dsunit' should be collaborated =
to achieve the best performance.

Agreed, we should mention that in the manpage:

>
> 2. At runtime, if chunksize < dsunit,
>    prompt alert message, tell user it is better set chunksize=3Ddsunit. B=
ut still format with user set options.
>    The benefit is user can still set as desired. Current, for the use cas=
es we can imagine, chunksize=3Ddsunit is best. But maybe users have their o=
wn use cases, it is better let users do what they really wanted.

But could we just apply your patch only to the dsunit>=3Dchunksize
case to fulfill your exist use case? I mean we still ignore
`dsunit` if dsunit!=3Dchunksize and warn out users explicitly (
`dsunit` doesn't work due to dsunit!=3Dchunksize).

I really need to think about chunksize !=3D dsunit cases, but
since you don't have such urgent need, let's keep the old `ignore`
behavior for now...

Thanks,
Gao XIang

>
>
> If mkfs.erofs force to align every 2M, even there is only 4K not deduplic=
ated in 2M, the 4K actually still occupies 2M.
> 0, 2M(only 4K data new, others all deduplicated), 4M........
> Space usage efficiency is same as chunksize=3Ddsunit=3D2M.
>
>
> Best Regards
> Friendy
>


