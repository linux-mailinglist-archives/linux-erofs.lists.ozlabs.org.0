Return-Path: <linux-erofs+bounces-1352-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBCC3AA1D
	for <lists+linux-erofs@lfdr.de>; Thu, 06 Nov 2025 12:40:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2KxZ2mwVz3069;
	Thu,  6 Nov 2025 22:40:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762429218;
	cv=pass; b=RqQcnlW+pty3AYJQom8lpNGQ5suRGFmaIaukjYYo2t640iI+qcETy7BPRaQPZb2p/e/Kw0X4rPWb7OEmPK5ausWAj+0Wpzdy6qQIMKcUp4Omk8/UigFzBcA2G/bW6qmwHKWf2gcZvXR8yCFwLzrGCyldWmVMMIVdCVd759nnHythjJfNAueuKfuU4uufS7A4dwiwPLo+OD4wQwoV80Vd4wGJve5D6Syu6MPbKf9uzLCnbDlkZAgHgK7KR3spojrXMzFudmzILvuaPUGP11G+OdFYUvdtuliSplx6Ubb10f5Ss5HXX8nxe7cs1E/X1/v/9unh8b8lwi0qUtjGQUwfSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762429218; c=relaxed/relaxed;
	bh=h03n0oNyo/NDBvuy5eWq8eJrhOSmVdN5eUXU5fGZc/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1MustyKeZ+7UnZTsz+oiOSk13Kja+xfizXupPTzm9cLQdm24VUnNr6czDsOANcaER94efBZcu1T05P3snHvP8prgLS/vPjFr3mr2HQJag6PDUqLxEBmnio8NQCBZd5r0zfK1Aao42+NqiqD2rOd8tUUNhow1p7MZhrNd3ewwG6doBOCEjOA6Ijf6IyLJFPgx0gdYymTVtIa/Ou6V1u1w4UIH4lyWc+OpqAr74erjDWeckJ1lpmcAqREBXTx9nD+/Jp+4GHxQrMd8OyhWY5GXc1hCAQPzOGcJbUaEMYy5KEcUmgVK/OvT3SwgFCibPH4k7DnGLN1t7hC5YZAfJZ3eA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=q5OVXc6s; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=q5OVXc6s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2KxX0CnWz2ySP
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Nov 2025 22:40:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSZ49k6valTN+F0suXr+OPQbtipamORsbV3h4Wd7LvRnPU6nCDCUcJkL6UMhRjRiSKNsaqQEElwLZadGxzr0O0fDiYZ/B/Xmc2Z5134ZAE/BAFAc8WfB/rsYDrJMbygcgY3EhTKTpCwqb1J3bLwPmLsUOw+/UMxH3EnJ2RYeIiNrPisXZ2+g/4Xciidq7J0T8KLz5+9GY2TJBz6M8uMUr1e0Pj3L0jkaiXrBTYZh7oMApbZ/LAfUqVdkknyALvH0Lmagd1AVzasoQGXmxYZWaZFV5AYb/Ez36P4d1T0Wqjlvf2x4mEAZcHWuOdi0vhiH9rAI5IQ1siDVs3ZNprr1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h03n0oNyo/NDBvuy5eWq8eJrhOSmVdN5eUXU5fGZc/A=;
 b=VKOoiC3NJYZ+eA/1bAjpGLRVUAfERbt5havnA8QSA2qQOviRU/UiT9J5W4ayLkS/syZSC1SQE274Qv/oWnkjldDleRh+uUTFKTDb7wKdbXGRryh8CetPOTaygzd4N6W6tLEhoGH7zlHDp5zFUNkqp0VKLDY6UJHybT+bMhvbwsG0ElXtyDgqlJdd57lkCMeGu6hBaiOcic0doeRrZVPnObDtSt4hcHl33rbuFYBCOEGHpuscbjQs0d5hA1QgXr4ieE04jAsoxFoAaci0jR+unqRiRM60a/cawAIScajG/lYuHBlmOgjM16CviKpr0wyDdfsARKHDThB/hfDmtYUHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h03n0oNyo/NDBvuy5eWq8eJrhOSmVdN5eUXU5fGZc/A=;
 b=q5OVXc6stKexpbkUl24Pc1ZXyoZoBobyq9/OZJ9v3DMvnom8QFh/Mkv6YUniTw1kerjEVnXV1uLJrmXbJ4uCjiR4mAOzbO5VQrN54Pa79ABnJqoEs8ESsJEHfNvBgZqAhjLyL1zIeYJJLyOjaANB2JWemiMLb40iN9NsvUFJuYBhWK2zGSDdZjHcy8fmPws0BdN1VktnHHV1Fd3FqxWd3Ne7sZEEC21L0QcHBBx3zRtMq6okL0vIN3QKu8Mqzxi/Y8SRPkkiYSS7rs+ZlQt8VgnRMNMsYub6v5wmZrejWr4qkiiLsuTj3Kxd7Icmqr4ytg6cH/Q2uKipi/U4Q/NkNQ==
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 by TYZPR06MB5483.apcprd06.prod.outlook.com (2603:1096:400:288::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 11:39:51 +0000
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c]) by TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c%7]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 11:39:50 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: avoid infinite loop due to incomplete
 zstd-compressed data
Thread-Topic: [PATCH] erofs: avoid infinite loop due to incomplete
 zstd-compressed data
Thread-Index: AQHcSinwi6Zrn6f4h0uC4GL6SdSbUrTlj8oA
Date: Thu, 6 Nov 2025 11:39:50 +0000
Message-ID: <838c74fe-8070-4bcd-a1a0-f1f9d46ef4d0@vivo.com>
References: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPF33E28B4E6:EE_|TYZPR06MB5483:EE_
x-ms-office365-filtering-correlation-id: d7191445-bc1d-4d16-b585-08de1d29323c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUFwcFpibHI2Q0Y4TVdTdU9OSkFZeWo1Y0ZLQjJhTzg1c3NHc2U2ZnZvUlVY?=
 =?utf-8?B?L2dZTXFoaUFsM0RqYmdpRGFKek1BQnRRMWVZRHptaXFrVTBuazJTcWx1U2x0?=
 =?utf-8?B?RUhjZHRHcVp4cGlPMWQvbFNhalFhdGM4WnU5WHZCS2ljeTdHMHNWajA0K3ky?=
 =?utf-8?B?ZXJSNk9GR3Y0ZGpIeERqYlBoNDZKTDNEMXd1SG80VndBWDRRQmd1K3BqUE9N?=
 =?utf-8?B?R1ZyR1IrU003QnZpUGNlc00rdGtNclptcnVWUWhCS3h0SHFZZFpQcWltQzFm?=
 =?utf-8?B?QUtqQkRqNmZ6OXpVbGlWVHNqbTl1UmxRK1FteEpKb2FMdmtXMFlpVnY2bk1X?=
 =?utf-8?B?S3g0T1RrN3VFZjZaRnltY1lRYnl2MzJKMnpJN3RIQTdWUTNMaTNrd0hWZW9J?=
 =?utf-8?B?aTdPSG5iUGFiV0tPdWpSWDlvV2haeWRZS3BEUnJCNTg0MVFqOXQwbUNab0h2?=
 =?utf-8?B?QlBFSGhGTEFRZk9nektBeVltdzdFektvSmhDM2tXSVFQNE5OM1Z1ZlM1cS9Y?=
 =?utf-8?B?bC9XVWVvVDdiTm5RdHdVUmpOUWFQWDAyR1FkK3RibXhsUVlVSVlxS0lwOHBS?=
 =?utf-8?B?RUxkSEdaR2RoUEE1M0pJM1RiSjZ4c3VGMEpYYllYcDNzTWxIeE1hWHNENk41?=
 =?utf-8?B?SmxQQy9OTjEyNktaWm5mbkhxR1oxV0NBR2NYRy9JVW9qRk12Q2tDSVZtQWd0?=
 =?utf-8?B?SVUzZ0d6cXE3L3JTcDVCYUIrc01VckJiUGhPTEVkczJhMktRamdMVzcwNmQ2?=
 =?utf-8?B?NmF0aDlrejl4L2dIR3E3QWtvdTllRk1MVE9mWmtYMkJ3dXMxSXNJeWxHb0RR?=
 =?utf-8?B?UGI4SklxcTVrV2VOKzd5cE5weUF1Z1FWM3htaWZRdUdiRGJrb2lqZkVRSUgv?=
 =?utf-8?B?OEU4TFlBYlYyTWIwMTN1aU1QSGFkRkZTZTJpSXJQemNLYVdaQ2wwOElIV041?=
 =?utf-8?B?V2pnSkZaM3A3MmFZRStLY3g2emdXd2FtV0NEamNkVXdLcG9zS3FYd1U4YWhL?=
 =?utf-8?B?bFpsMU1CODRVRTM3dkh0R0Eyb1ppRUZWbTM3dGQrZGs4UUpselpBNFF3bE14?=
 =?utf-8?B?TnFsK0FqTnRKaER3SVhxaVZrTVBsQVJ1WWtqa0pZRCtnRmdQajZQMzNkOU1K?=
 =?utf-8?B?b1QwMklRSDJibnRKcHhRcTJjVFBnaitLRW9uTmhqWEp2Qld2bzRDNDNVVm9O?=
 =?utf-8?B?cCs1dTRjTHBBQ29VZ1oyRjllbEFYc1YrY1JyZ0ZZd1hrSmlGVmJmemY2bWlv?=
 =?utf-8?B?VGNKTkNQWWNYeVhXRVFLcTJUSHhvVEt6NEVmRStPSUdMY2MxcFg4UjRHYzRM?=
 =?utf-8?B?dFQ3bkF4OTRzRTdXNHRUSFRSWFE1UGFFWG42VjFHREdoRk9EWkF2dTNFM2xJ?=
 =?utf-8?B?cFdNM2l4NGNTQUZNbVBZUGhiZGhTZzR5WnlZSCtrMm1aMkplVi9ab3dybDha?=
 =?utf-8?B?VldqL25ELzlab3l2d1ZvYTMzaG5kdFNMVTlWa2pSTnRXUlBwdU15dkQ5cUNM?=
 =?utf-8?B?Wk5TcFpaYng3VFQ1MHFFaUF5ZjYxVGhCWXpUbEdsRjNkb3NUOTljQ001dTNs?=
 =?utf-8?B?YnZiaUc1NVZWUXQ4S2p1QjBZWDRHR2VQRHdMaHNDZDAyYWU0dEplNmxDN3R3?=
 =?utf-8?B?RUpWYm1qamlJMFFNRzB6eENWTXRGeERmb09DaWdOQ0tTcXpoa0lpRk5BeGR0?=
 =?utf-8?B?OURUQmtieEVKMDZWSTlDRWpwQWJGMFh5dHEwVFZZQTdKV01wbUZsbEpiRFYx?=
 =?utf-8?B?V0o4c1NPb0thZ1dVMHlTaUxhUjBNeXlNUWdCdXFxV2NzbDlWRWN0MG5wRzRn?=
 =?utf-8?B?WUFDK2xqTWVjNGVUTmFNZm1YVjBoQkN1ZTRJQXYyeDdjNFRtVmxoeWloN0xy?=
 =?utf-8?B?MWxUUmlicnNpZXJXNGZ3U0xsS2V3VjYzWmFGZk5ZTCtWaVRwSUFWUW11RkxD?=
 =?utf-8?B?N1cvanJzMzJjYXRiNFI0aHJmUFBVMVpmSmgyc1lpSmNZcWRsVi9IMTJtbkhM?=
 =?utf-8?B?MkpoMjMwdmlrTGJNNUlwOWd0TVZsQ0wzQW1TVHFiVVNjU3VQK0gzVDZyVlhU?=
 =?utf-8?Q?Z4ywCG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPF33E28B4E6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXR4dTRSOWkwVlJWQWRlYng4NzZFQzRPd2FsS0diWU02SHY5cTdZbDFwZXRV?=
 =?utf-8?B?S3BtNXBrUCtCdWhoVUFPTXR1WHErQUowR092NEJXbjNJMGZaTWZ4ZUd1UGI2?=
 =?utf-8?B?YlJvTFNGd3AzUTFvVGlkMVJ2QU5IU2taV1JwUWR0ZkdnMW12NjA3WkpIY0Nm?=
 =?utf-8?B?clkzQjRXU1B5RUJKOEZhWU52cmJ0eHA4MnBjTktucldpLzFNSjFUWGdpcVEy?=
 =?utf-8?B?MFJaM0NFT3hvajFzcGxzRDBhRVQyTHVSL3R4cGxoZGd6Z1VDaFRnck5jUDll?=
 =?utf-8?B?WGpzeThucVh6bE1wSWU2TDYyMURoQTIrcno4Z1J1SVZ2MmlmbHVyMnhtZ0JI?=
 =?utf-8?B?NHdzMHRGMDNxN0R3RUppMWJUTy9tUWIvQW8ydzBoazJGSGhlVHFqRElFVmJ6?=
 =?utf-8?B?b0NCT0dUSjFFSG05Qm5VelhnOEVpczB4ektXczVlZTI3NGw0TlF6RHVxM3A5?=
 =?utf-8?B?NU1xTHkrSVBqUlBCQzlLRTk4VlRMUEEzQ0RvUkxYbU42b2FZU3dPWmpPNCts?=
 =?utf-8?B?d04zd0pVQTgxRE9pZ3Z3VjVUQkRvbVBtTHd4QlR6SVpUMWVlMU03U0hicU9j?=
 =?utf-8?B?NXRsU2c1alNCWXBkcW45b0tBRVBML0h1TCtDaHp0NFh5dGszd3FDc3JPR3JO?=
 =?utf-8?B?bnRxL1BvSU9tMXM5UkJNWUxDS3YyYTZrKzdnWVZwa09OMnV6U2Z5d0l1VGJS?=
 =?utf-8?B?cWtqTHlXT3p6T0gwZ3NEcy9UQWJZUlFkWHcvMnpqNzgwcDBXc1NaeHJzN3dl?=
 =?utf-8?B?SU5aT21kYnVvRXA5SGdBalhpOFZLR1F3V1Z2aUd6NlBRell2dExSUkZVSi84?=
 =?utf-8?B?TDlnNTYxTGtaUUJZdHFic0pNbUpFUHJUbnJTajVQMnlLY0VudkNIakRkY2J3?=
 =?utf-8?B?M0xsbmxISks3SXppQlBLejNSd0tKT2k1QWEwdGkxaHVJMGtqT3B4eTdRdFZv?=
 =?utf-8?B?UDVtTVlkN0FQN2FPeStBYm9NUFVnTEptUWFaS0F6QnBEMXp2ZlVwUkZZdURO?=
 =?utf-8?B?cWxVaHIwbGdBWnJwS2VSNE5vc2xVakI1TThGS3czMXRQZWh4bkhYOExFVzIx?=
 =?utf-8?B?THl6STVOdm9Nc1NqQitCaldmTjhyYVNTSFpna2lvTDI2eVhndC9vL2F0OXFZ?=
 =?utf-8?B?L2NlRXNUdWgwcHJRdUhFOFhBWGgyc1hnbmpzTGpIM00vZmM5Z1lOb2ZGZWhl?=
 =?utf-8?B?MEFtcW96MGtKajJhUjdxMkMrbjhRbS95dmRCRjhJS2w0NWlqRC83cm1aVSsw?=
 =?utf-8?B?WHNUZlo0TzFSc01FMi9JM1Nkd0J1Z3pSaG1WUTJETE1KQU12V0dJd1ZLVzZS?=
 =?utf-8?B?SmRSZ3lSTmVabjFPVE44dWlYQi9FOWNFN3VPWC9yZUlSNVRWdi84cndnZGkr?=
 =?utf-8?B?RDlWd24xcFRaZDg3ZVhJUUVIRUdjTEhiVld2UVlUb2RiMHN6bHVDUVpQZjVj?=
 =?utf-8?B?Vjd4cWpnbWhENDU5UVk2dThGV2laa1JhbjBZUXdZOWNORjYvQWtjRk95YkFl?=
 =?utf-8?B?UmhkVjl3SXZRSzBBbDN2LzRDc0hEaytjSFkrdk5tVEtiZllWMncxRjRWeTNS?=
 =?utf-8?B?eVozVjZUbTAzMS9MUmlBTWFFcmdQSzAwZ3oxM05vOWJvSlFKSldWMlFuU2RV?=
 =?utf-8?B?YXVNZmZ2aTZPRHZ0bmppT2VlT1V6d0haQTFWdzFSMVN4OXpuZjBvRG9Na1VO?=
 =?utf-8?B?NlNRZVQ4SnJJS1VEU2JJSFRDZHFqRmpZdHB0TlVUdWlabFJwRGk1emhJaUN6?=
 =?utf-8?B?M1hiTnNOdXAvdHZXaFFkT1Mxdjk1dmpHazkzejREVGdraGM3a3Z6RkEzWURW?=
 =?utf-8?B?UkFTeHBNM3NrcjFjTC9zMVF3SWJIazZNM29SSVFSRHFXc3ZUZitleGZUNDIx?=
 =?utf-8?B?K2p3T3JvOGNKdURoYnZCZmVkTE92cTJIZ2pBZXhwM0hSK1cxaE95MllNSnNN?=
 =?utf-8?B?ZkVvUzB3dXJlbStpN3huc24wMFRGRHRHMVFDaEhLanRHcWVDKy9ObFB1ZDNl?=
 =?utf-8?B?c0dVc1dMcW56b2FsdU9rYzVHb3V0RXU5cndSdUVBaGRHQ0I5aXFQUWMxNDNU?=
 =?utf-8?B?UUl2WEh0dGZrcmR5bEQyczY5eXY0TzlPVkNVY3p2SGp6ZWpualY5SXlQbjl4?=
 =?utf-8?Q?M+gk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1275ABEF1960C942AAFAF8451BF557FA@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-AuthSource: TY1PPF33E28B4E6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7191445-bc1d-4d16-b585-08de1d29323c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 11:39:50.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaEo4KFQ+st2MbEaKjAFp6xvvtbBBRSDkHvhzMYYNI3+NjOMmzAovQJP/Ncap7RX0gKCIRwBhwQDVPglV9wcgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5483
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

5ZyoIDEwLzMxLzIwMjUgMTo0NyBQTSwgR2FvIFhpYW5nIOWGmemBkzoNCj4gQ3VycmVudGx5LCB0
aGUgZGVjb21wcmVzc2lvbiBsb2dpYyBpbmNvcnJlY3RseSBzcGlucyBpZiBjb21wcmVzc2VkDQo+
IGRhdGEgaXMgdHJ1bmNhdGVkIGluIGNyYWZ0ZWQgKGRlbGliZXJhdGVseSBjb3JydXB0ZWQpIGlt
YWdlcy4NCj4NCj4gRml4ZXM6IDdjMzVkZTRkZjEwNSAoImVyb2ZzOiBac3RhbmRhcmQgY29tcHJl
c3Npb24gc3VwcG9ydCIpDQo+IFJlcG9ydGVkLWJ5OiBSb2JlcnQgTW9ycmlzIDxydG1AY3NhaWwu
bWl0LmVkdT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzUwOTU4LjE3NjE2
MDU0MTNAbG9jYWxob3N0DQo+IFNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8aHNpYW5na2FvQGxp
bnV4LmFsaWJhYmEuY29tPg0KDQoNClJldmlld2VkLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhh
aUB2aXZvLmNvbT4NCg0KVGhhbmtzLA0KDQo=

