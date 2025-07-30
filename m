Return-Path: <linux-erofs+bounces-726-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B8B15B6F
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 11:24:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsRcT0vMkz30Vq;
	Wed, 30 Jul 2025 19:24:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753867465;
	cv=pass; b=Wtn4vwtVZ9qiJ1UvjDElt1m2rU7CaBfzAs/BRbrU62pGu0p/eNUl/dQ7lv31SB+iBHVSEeZvj6P9GmEElo6VVaFJCzQW3bUPxORhxsUa84v6j5ZWoeErKmAqzD2LruLXUI+TYXS91tAdHVxrby75MKKuTiS/BUFzsHjk6vz3f11ZC2w2xdzvrW68t0w7Amj77cPBfe1X8jWmxUtE4qJq8hyCFftcv/q40mQ/qVxPrjXyaEDQB7VVDrBBsTglZOMb5+3eDTvZn9AK7Enyzr37/HWDapJ55Q30JDM/Vjwp03IO/9tF9iDAdyze2cLQvBIuL6tg4sMe6z2vQfdVX7yF8w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753867465; c=relaxed/relaxed;
	bh=l132p9AjRZl4zEZWUr4YK+BInU3sXKPt7quqyaFcbDI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLNvDb6qd48KvBy4RNfAeHA7Da8chCeKrF06juBSIdQxrKpKt/dBtTMHONNNUXnWcp81T02b/RmoNfJtIVM8+O5hknn6UyUhOHOmzfFAJlG+nTIxAu2hqlnXBwT4jdHgBvoeueRcYDnMyaOHHwNtRAEvxKMUjmDW7i8pa2U9M1mIi3mzuo3Hj9GMhqoG4OeeZXp8yC3jshTbjARQnbK97wI1BFDA2R/guWocCa9cVX6F00QJuTWRlutLMizt5Ravt9ca4+pXi9ZfKguTJIhJSnI+P4arq5jCdAMX+RtVsZoUulSUwbT1+4K7dHtkAVT7Q1JjGZx/gSF3XNIAOEWeyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=k0IQ8DM7; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=k0IQ8DM7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsRcR35Wwz30RJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 19:24:21 +1000 (AEST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U4poUA014276;
	Wed, 30 Jul 2025 09:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=l132p9A
	jRZl4zEZWUr4YK+BInU3sXKPt7quqyaFcbDI=; b=k0IQ8DM7noIvWFItjS4v7my
	kO8HutrMf1HNYOEF+BcBdH825ogPrAanpU6k0XYPmRVze0DWhZ2gRvdJqwEBXyF7
	v4/qh8rgMW47e8DN3Ad82K4Ai7PY+wOnXFiEjGhE9O0NravloXXAFPONdz0YBxw1
	cbFcEhlzuZoouv5Jfi4RBHgzPaC1i9iRFA4B/FDTD5mAXsg6votKNJ+jdGbuWL2/
	MelpR4l1CBY9vaTmClhgExKLwd4Xt2Q5f+pJiqWF81UvqEDWCZCbuut8VCEIazCt
	gv9FoP9DqtaTYrcVGXDBY4xUfAFkpU2tXEw4nNFvE9Lk2TGbYd8NMb1DuK8IERw=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013037.outbound.protection.outlook.com [40.107.44.37])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 484mwmkeyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 09:24:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ait3PnQ8hK7nORJW2Jv+4ZBw7ESXuiJNda8heiwWZw+qkHLQCZdnB/ciTBVL3b+Gn0uBGA5gTFVfzUWNLj5ZaZOZh41ynaH0HNKM4CcsQ+AuaMeUq6R50j815L+RiI/0kvhTsA9fL8easHib/jaBbS6hPwix6g/zBFd40y7Lwk2qkBXuTi8mjVcp9hSe2/jlG6sPF677JB0ED8hFRDpGJFiDK4sVOZSW+cmYpVzDLFcZTNY7vc/6w6jtb5wWD+jNswUq34Pa04cy9FPS/yrTcR6lzwzoj6Neezth6ZjbCKx0cfj40eFUFTb69oXbgjIxeCnJm4+vb74MC546PhM1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l132p9AjRZl4zEZWUr4YK+BInU3sXKPt7quqyaFcbDI=;
 b=fURQdf0A2D2Z3qU4ERGBNw5+5pbSOullwstgn1RRq3VjDn/gBj24LOmaGYhRk/IzjC1zWjcwu0aZ5ONfqxUBcYP25mJvHp02KkpRrU+I2DSlrv0vqerBiHrvAIRVQD7Q5sy5PW6Iam8HGoQGMjg8PNSV5qG9ewUQPFn171CPueZMMdPvr3y9pOKX1c8IOcDiCwiwtjOUMEFv4qnF1leGp1+Uij0MV/TNn5aylva/2/udxcUVxDSkw2xyNfe47WApf6tj9sYwrIJnpF2KopdfeGToiutTmf5K7H5+4DOsx2rzeJc1trvsLLmlcTTVzlowXDb5CQrcAMtJoOLMrLFoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6362.apcprd04.prod.outlook.com (2603:1096:820:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:24:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 09:24:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Hongbo Li <lihongbo22@huawei.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: RE: [PATCH v2] erofs: Fallback to normal access if DAX is not
 supported on extra device
Thread-Topic: [PATCH v2] erofs: Fallback to normal access if DAX is not
 supported on extra device
Thread-Index: AQHb/3vPEbkMZMCxS0yr3x6DvqGso7RIbKCAgAH7O3A=
Date: Wed, 30 Jul 2025 09:24:04 +0000
Message-ID:
 <PUZPR04MB6316ED7ACB435DE4C592271B8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250728045409.1678099-2-Yuezhang.Mo@sony.com>
 <469d7d39-dde1-41f8-9d72-1c1a30a2b577@huawei.com>
In-Reply-To: <469d7d39-dde1-41f8-9d72-1c1a30a2b577@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6362:EE_
x-ms-office365-filtering-correlation-id: e9c67d97-327c-473b-dfdf-08ddcf4ad3ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RloyQlBYVmYwd3NiQ1FTbVBxMHdxWkI2VmQyb3lKR3B4OVYyZmhYd3BZZlpK?=
 =?utf-8?B?eisvbXc2WWV4YnRsR3AxRGM2NWYzNExGWGhSVVkvVVNKOTA4NFdJOFlEK2ZX?=
 =?utf-8?B?cmZPWTRYa25rMHJDczBNVWJJTkxXZExKcUNGL3FBQUNHUzA1OVJYVVdyaEp0?=
 =?utf-8?B?aW1EbDV0NUdtUlhaVlpKNzN4UUdWdmVVM2pEMkV4TFlmUjIzYWJzdTA5bmJL?=
 =?utf-8?B?S2N0N21rUGk0NGQydkJ5K2xCWkVKMzRtcytqWEUvWkRVcUYwamJsTHpFcFRr?=
 =?utf-8?B?ZHlZUnpaNFljRlNsOHhsYXlkREdUbFNINjloUDJhWUxIQjArNnlzN2UvR1h4?=
 =?utf-8?B?NVVrZGk0Wng2WWN0U1dReDhHdEZFMnJlR0k4VFd4UHBqN1QyTDFuTkE3Zk5n?=
 =?utf-8?B?c0E3cWM1ZEJiQWdkSHBiRFkwWmthZE9VN01TZ2lqa0ptU1J0ak9VRnIvdWt5?=
 =?utf-8?B?MGtLa0g5SmFETWZ6Y0lLWDRJa2VYM3JpTUxTc0drTFhxeE51WS95VEprWFVZ?=
 =?utf-8?B?WFZZa09pVFFOZmhTSGZONzNlSUVoYUdhTUtDNkRMUDBBckdwTU9uNmMrMFVQ?=
 =?utf-8?B?VHEyZXBLa0x4Q2V6RlhXSmZGVjJuWlFWU1c1R0poY0pXb3o0bzVDVDZ2UDlI?=
 =?utf-8?B?QmRwU2FCcWg4U0cyMlZLeXNvTW8yYndiTXg2di9qTmloeENxK1ROd29VZXQ2?=
 =?utf-8?B?MmFRdmhBazhBZmxsbGU5NHpBNGpqTDU4cnRsa0pFTU5wZ1lQWnFaK2oyR0ZC?=
 =?utf-8?B?QkJiM2NpUXFkTGgvK2ZmSVc3S1NBSUpGQlR1bVgwM0RDMnRvMU1EbVdzTXhQ?=
 =?utf-8?B?NHliQTUySWRiLzc1SDNqVFY5eVZOZGJacmhra1R0SGNpczJrTnVHWWR6NFVi?=
 =?utf-8?B?Q1NUdk5rNWtkZ0dtM0hsSEpiS216QThrQ2RvV3NIVXJqZjVXM3pLTnh1WWZW?=
 =?utf-8?B?L3hVVHFOSGFmNUpWWUIzNk1jMmJpSTlIbTIyKzZxTE4vcDljb0Q3UGhSOXlo?=
 =?utf-8?B?b3YwZEhHK3ZYRHpuR3BBVEJmYytSTllWMVJmcDdzVzNFb0RSV2pCeWtPeGth?=
 =?utf-8?B?WWw2OEpuTVMvb0t2eGhRRGY0NFJkUlhmTlZnSXg5cnc0MjF1YzFKTEFXNHBm?=
 =?utf-8?B?bVRLWUJWQ0dEZEYySk85V09OWXVySkpPZllQakJiZHZuZlRQRGhiVFYwV004?=
 =?utf-8?B?N0tDWE5aa2JKVXVpcVg1R1dSRTJXeEROZHYyTjlvOHNRT3BYcUFzVzVHZWkv?=
 =?utf-8?B?ZVJPSHFEQTdhNVEyQ1dPa3plT254YUJzU1hVOUxoWmRTSnJST0c4Rzl2TGFH?=
 =?utf-8?B?NTJiN3oyZGJTVzdrNnY3c3RxVHFTMDhSMEtzQ1dnc3JwWGJDdmQzc1ZqRzhR?=
 =?utf-8?B?TXlIZWlnZDJLS3U5Mjd2KzlkZTN1aFR0TzhIVGlYcXh6ZVJEd2Y0WU9VQk8x?=
 =?utf-8?B?L0FNak5BVjJRZnlOSWtGaWorZFpDT09oa0I3MUpNNmpBNUd0NjF5dnR2cTVy?=
 =?utf-8?B?QWdQM3RHdERGNUorQndWZzVod0JTQ2RKYkRVYnQ2a1Ixd0E3ZTdOZU1CcDJu?=
 =?utf-8?B?U1BqR0RtU3pNaDgzSlFXN0Fyb2lwODc3ZHZqSjdsMHhaQld3elU4bmxPT0xL?=
 =?utf-8?B?azZEaGlSb0pBZFFNKzdtZ1hIckU2aDI5NnZmcWk3WVgxNjJyQmRiMytMTnRW?=
 =?utf-8?B?cUdwL09HanQ0ZVVqMnM1emd3bnFpVUNUeWhQUjZ4MHFZc0E1UFVXRUJRcmJn?=
 =?utf-8?B?dER6YWdPS2hnNkJRajZ0TGpPam5vZDYwWXdQWUhJMDVRTk55YjFsVDIyejAv?=
 =?utf-8?B?NWc0V1VKY0ROMWVSQktyMEdJVUV4cmFtcmNLWEEzMGJvQWkvMlJqSzR1YnRw?=
 =?utf-8?B?MERKZUxKdHpvNmpyWjVPcklYdHdGREhiZXUvZE5USW5RVnRMK05reEFRZ0FQ?=
 =?utf-8?B?dDlZRFJUbzNoTUZocjVoOHp6U3dtUVpIb3BRaWdHU0loZXJuK3dnTTk2OXdN?=
 =?utf-8?B?S2p6MGlRMXJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0lFdWUwWmYxN3pTdWZwdHg1a285SmdpSUVGTlg4YjZWaTgrb1ZkaGRDZ3NC?=
 =?utf-8?B?VEE1eFQ0WjY3ZklaNlA0ZzAwdktoaDNMeWo3RWhmNmtYN1h3QzdvNTRtS05P?=
 =?utf-8?B?ZCtvZERGcFhYMm5JQlZVMjFMb2tXaG9VR3QzMWUvdVBrR012UXkzck5ldHpW?=
 =?utf-8?B?eTJKY05lSlM4ZUdNT25oemNzYzl3VjZrWU01QWRsV0JVYWRzN1dhMUgza1FM?=
 =?utf-8?B?RFluOUkxOEI2S29nWCtKRElWUXhjcnlHc1BSSzMrUlJWVzRyQW1zMDZWa1NF?=
 =?utf-8?B?eGJCOWVpbnNyR3FQTHNFbVVoSk8vOThkb2VPaC9kTHMzc2c1ZjVNblc5bk4v?=
 =?utf-8?B?TThhWHZzZCthZEJwdGhtcE93djNEV0lPelZnb3NNSFpBYy9XLzYxelhqQ3hV?=
 =?utf-8?B?YWRieEYxRnZseGVzamtnRHVuc0NEQlVLVytXNnpTNmp3Wk5NdkFvdW9DdGRh?=
 =?utf-8?B?Rk04MDhvMHFzVjVMRDFyN1pZZUVlQnprbWROVlpmWHNwdWhwMFhDR0drQUZp?=
 =?utf-8?B?QTJzeXVTRmlDeDRVMkg0cTV6dlo3QUE0RnNpSkNkdkx3Nnp3Y01DNGxCSnZj?=
 =?utf-8?B?NmZjdS84UStTZ1lRS3d1NGxUNXF1YnlrVUYxRlc0V29tUVEzQ255Y1ExSWhP?=
 =?utf-8?B?aCtlNWJyU1VjTVQ5RkU2eWsvSklGUnlLaWZQbzdWK28yYUpWa0M1UEZFdUh5?=
 =?utf-8?B?eFkrTy9IUzhxOEdIemRFWXo2bGVyMElBcStxSUZzd3p6YUtnbXZjajU5Z0RO?=
 =?utf-8?B?czJUK3FIdXZZbFdsUGtZODEyRDd4QnU0VEdUSnJqK0N2MDkzNGxVWDZrcFF4?=
 =?utf-8?B?OXZCUm1XcU04TmZobUdObHliSk9xc0pjTXViTEN4clVOQm1Fa1lWcW1Pd0lq?=
 =?utf-8?B?QTRqb3U1STNSZml1TEhaM3R2S1BDcjVoRDZqOUV0SUk5Y0M0dFcrazg1ZE1p?=
 =?utf-8?B?dzc5M0Jqd2VqVDcyZGRyZVFVbHJFbFpuNW5SbHBJY3J0MHdBRWg1cU5vRUp2?=
 =?utf-8?B?QXJzanFUaVJNbEZjTlQzdElPOXlSRVNTOCt6K05PMy9WeEVKZXRZaVIxOHRk?=
 =?utf-8?B?RDhqYzAwa0Qvb2YwZ2dZSE5nVnhqMVhlMDdqd0hnYlUxYytjU3FmOFFiZDJn?=
 =?utf-8?B?czllRzJNTkJJM05GME5YaGxyK1BDWkJqYmlqNFg1dG5WcjJyOW15dTUyRSsx?=
 =?utf-8?B?OXFhblNyaDhnRy9pMmI1OTIwZGFXZmJBNEcxamF5cGhpUXFORnlkYkxFNE5q?=
 =?utf-8?B?MGt1K1ZHamQ3UGZDSE5aVEI4cElFMnZVQkt6ektuc1FhVGN6ckJsTUZPcita?=
 =?utf-8?B?TnhEN2pheHprZ05QV0M5TkdtWkxOZWlxUTFuRUlSRnN6bmk2L2FtV3pxSHhq?=
 =?utf-8?B?Rm1tOWhDUEJyTXdmQ2JpVnRRVWlhQk5yczYrcEhUQjlBT3dxbWY2aWRmeHY2?=
 =?utf-8?B?Z3A3SnB2aC8veWloLzFhQ3FyaU9vTDliNmZFYVJXVlBFWEdVa294YkJSdzhV?=
 =?utf-8?B?cjZRSTlnNGszbnBzR2JKL084b2liZlI0aU5EekxGSkRCSCt3YmVTMFlIc3lR?=
 =?utf-8?B?Y3IramQrQmhYVHdlWUNuU3lPUVhnVWFFSnQxZDJORDhYZ2lqZllMd0JXd29z?=
 =?utf-8?B?QU01YTZLMVdYTEMxeXVxUm1aa2Y1MHU3Z3ZGVTZSbWxoQzJiZ1BFOHQvVmJ1?=
 =?utf-8?B?YlJ1M1RFWjJXYXRSWW9FRTdVN1ZEcnRyZld1Nkg5MkVxS0crRDNpR3hKNGlE?=
 =?utf-8?B?a2FFQ08ySTlNamRpOUV2UU5rdWx0aGloOTRrbFovWTlPb21kbU1OWUMwUjFT?=
 =?utf-8?B?cnlJNlVuSXNIaklQNTk1NzVtU1gvdnNLejgyWXJGanNVT0Z0UlpydTFteWky?=
 =?utf-8?B?U0ZRc2pKZSt6TlhESE9WbERLV25tVGs3WGJuOWZJbmdnTVo2V1JGd2lZbTJj?=
 =?utf-8?B?aUt6dkZIVkZEMWZUZ0ptQ3BET2cwcVZrN1dJNWNFNGhneVRCbmtWTlVDZ0NU?=
 =?utf-8?B?b3Y1cUlwUjdMbGg2aVh4bUVNemRaL3ZRWk9EVmxxd3E0c1Y1ZDRnUVBpcmxT?=
 =?utf-8?B?cmI2aENleVRpYjIzdEV1VHh2dWNvUnNPbDFROHdLRFdaRXcxMzQzSDk0STlC?=
 =?utf-8?Q?sYAPu5WxHDB4OtAfKNpqHFZMx?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g9Hiy959k1mEvNNqJ/1N64czHQj9ZAsNj0lNKkwdnoHyYhdyxxgsmexdvTyHRB84fMcaim2LuJmJuJGjHDYruZu3ZLN6dGgiEUbv1hpW8sdhJQ5vW5aHcOY0gFtR3WN0PEjfJMpXffDnuwGivZI9iSQhEbd/ZzVj0YNef3Wz+sStHRurthir16DofsRpGc03nyja/BCAhItHAAF2+z99bu77iBJ+h8nyKqkzczTz3p0KBU01SR7MCE+UhYLx45T3Zfz/eSWxtz6SIFdKdxZMK6Oy8PfAsjQLaM+C82lk2Kw/pnRRqloImHNSR9NE66QHvrETCelq2B/GnzLGonveD2egeFi1eLmLch4cGvlsc93k3LKK3HBYDnTVltR0VXReu4CggzZ6XuvgN003p2xruxnLaxSO+PTo7Zmrnp/GgUQZxG7MhdJ/rbKOX+G+PeeIEYC6vbOgC9e9/Ev1Efex6kBtRVPhsbMVVBfnNE/BF/tQev6B0HKmozKS4SNSUSzHmi8RVTKQvH/i67POAJuuk3Zwk1cUTwU7MH9ZD8A7rgolgWMIA6pJ5KF9fRwj9GlkQFIIImNRD6igoy1bgUd2AC2gnptjs1TX6b0bN6SyNqjrd2cD6o02IrrHJmmjEvyZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c67d97-327c-473b-dfdf-08ddcf4ad3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 09:24:04.4359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvZvGtXkIAi0sbRrQeGAx34wxb+nQ89KGYvSS7o4LxBEnO7OS1MB7zlje2afiyNsoC9avkCQaH84PzWQvcn09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6362
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2NiBTYWx0ZWRfXy7GiVyWAnyla XM/d2VyIXxIAB89BAd8MqNVGHsMq0Uj1TopR8Khi+DWfz8bs0ETg/1JnbSVES73inmhDPp/6Z9X V9EWI+2cswCv1uItNhHH/PCRTt27v5SFhpy16T5iQoe9GZ8SmSNJ7M3nOJmqjcSXsjmXKt+s7dj
 zg5qN6BCFAo6JKOrqW3khx3xsmyfj9iJOlmPFg7ql37nnfTmZMfRH7RYi4iKVfxV9n/pIDHcpVP FnHCTVJcTE1yr/Qlldv5D8M5taGscAMxu3tJHGLTBA9nzX1klb1h59A8puQ1gLCdO9EsSP1ztvb u4irvLs1zUWF+zaweEH1LT387ih7Ak585KojHwf1cuFzx5qjiMAa9p0uFXgr3LYRE6Do58OMZKY
 JgfBPAH/NQAWByMUELTh/8D3hK1F/1TNkT/aKBHmuE/5YmE2DdR4Rx+hzla8MI52Bvs6o5AG
X-Authority-Analysis: v=2.4 cv=Ad+xH2XG c=1 sm=1 tr=0 ts=6889e4ba cx=c_pps a=TvWKr+dq7NVsMjkVYwLKQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=S6-UgkKw-BCApZe8iMEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EPI6LSY1O9nYD3-bXJZxUNwoQLeCvSEe
X-Proofpoint-ORIG-GUID: EPI6LSY1O9nYD3-bXJZxUNwoQLeCvSEe
X-Sony-Outbound-GUID: EPI6LSY1O9nYD3-bXJZxUNwoQLeCvSEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

T24gMjAyNS83LzI5IDExOjA3LCBIb25nYm8gTGkgd3JvdGU6DQo+IE9uIDIwMjUvNy8yOCAxMjo1
NCwgWXVlemhhbmcgTW8gd3JvdGU6DQo+ID4gSWYgdXNpbmcgbXVsdGlwbGUgZGV2aWNlcywgd2Ug
c2hvdWxkIGNoZWNrIGlmIHRoZSBleHRyYSBkZXZpY2Ugc3VwcG9ydA0KPiA+IERBWCBpbnN0ZWFk
IG9mIGNoZWNraW5nIHRoZSBwcmltYXJ5IGRldmljZSB3aGVuIGRlY2lkaW5nIGlmIHRvIHVzZSBE
QVgNCj4gPiB0byBhY2Nlc3MgYSBmaWxlLg0KPiA+DQo+ID4gSWYgYW4gZXh0cmEgZGV2aWNlIGRv
ZXMgbm90IHN1cHBvcnQgREFYIHdlIHNob3VsZCBmYWxsYmFjayB0byBub3JtYWwNCj4gPiBhY2Nl
c3Mgb3RoZXJ3aXNlIHRoZSBkYXRhIG9uIHRoYXQgZGV2aWNlIHdpbGwgYmUgaW5hY2Nlc3NpYmxl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnku
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmllbmR5IFN1IDxmcmllbmR5LnN1QHNvbnkuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBKYWNreSBDYW8gPGphY2t5LmNhb0Bzb255LmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGZzL2Vyb2ZzL3N1cGVyLmMgfCAyNCArKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9mcy9lcm9mcy9zdXBlci5jIGIvZnMvZXJvZnMvc3VwZXIuYw0K
PiA+IGluZGV4IGUxMDIwYWE2MDc3MS4uYjA4MDE2YmY5ZDFlIDEwMDY0NA0KPiA+IC0tLSBhL2Zz
L2Vyb2ZzL3N1cGVyLmMNCj4gPiArKysgYi9mcy9lcm9mcy9zdXBlci5jDQo+ID4gQEAgLTE3NCw2
ICsxNzQsMTEgQEAgc3RhdGljIGludCBlcm9mc19pbml0X2RldmljZShzdHJ1Y3QgZXJvZnNfYnVm
ICpidWYsIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ID4gICAgICAgICAgICAgaWYgKCFlcm9m
c19pc19maWxlaW9fbW9kZShzYmkpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBkaWYtPmRh
eF9kZXYgPSBmc19kYXhfZ2V0X2J5X2JkZXYoZmlsZV9iZGV2KGZpbGUpLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZkaWYtPmRheF9wYXJ0X29mZiwgTlVMTCwgTlVM
TCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBpZiAoIWRpZi0+ZGF4X2RldiAmJiB0ZXN0X29w
dCgmc2JpLT5vcHQsIERBWF9BTFdBWVMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVyb2ZzX2luZm8oc2IsICJEQVggdW5zdXBwb3J0ZWQgYnkgJXMuIFR1cm5pbmcgb2ZmIERB
WC4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpZi0+cGF0
aCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFyX29wdCgmc2JpLT5vcHQs
IERBWF9BTFdBWVMpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAg
IH0gZWxzZSBpZiAoIVNfSVNSRUcoZmlsZV9pbm9kZShmaWxlKS0+aV9tb2RlKSkgew0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgZnB1dChmaWxlKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+IEBAIC0yMTAsOCArMjE1LDEzIEBAIHN0YXRpYyBpbnQgZXJvZnNf
c2Nhbl9kZXZpY2VzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIG9uZGlza19leHRyYWRldnMsIHNiaS0+ZGV2cy0+ZXh0cmFfZGV2aWNlcyk7DQo+ID4g
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgIH0NCj4gPiAtICAgaWYgKCFvbmRp
c2tfZXh0cmFkZXZzKQ0KPiA+ICsgICBpZiAoIW9uZGlza19leHRyYWRldnMpIHsNCj4gPiArICAg
ICAgICAgICBpZiAodGVzdF9vcHQoJnNiaS0+b3B0LCBEQVhfQUxXQVlTKSAmJiAhc2JpLT5kaWYw
LmRheF9kZXYpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgIGVyb2ZzX2luZm8oc2IsICJEQVgg
dW5zdXBwb3J0ZWQgYnkgYmxvY2sgZGV2aWNlLiBUdXJuaW5nIG9mZiBEQVguIik7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICBjbGVhcl9vcHQoJnNiaS0+b3B0LCBEQVhfQUxXQVlTKTsNCj4gPiAr
ICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAgIH0NCj4gPg0K
PiA+ICAgICBpZiAoIXNiaS0+ZGV2cy0+ZXh0cmFfZGV2aWNlcyAmJiAhZXJvZnNfaXNfZnNjYWNo
ZV9tb2RlKHNiKSkNCj4gPiAgICAgICAgICAgICBzYmktPmRldnMtPmZsYXRkZXYgPSB0cnVlOw0K
PiA+IEBAIC0zMzgsNyArMzQ4LDYgQEAgc3RhdGljIGludCBlcm9mc19yZWFkX3N1cGVyYmxvY2so
c3RydWN0IHN1cGVyX2Jsb2NrICpzYikNCj4gPiAgICAgaWYgKHJldCA8IDApDQo+ID4gICAgICAg
ICAgICAgZ290byBvdXQ7DQo+ID4NCj4gPiAtICAgLyogaGFuZGxlIG11bHRpcGxlIGRldmljZXMg
Ki8NCj4gPiAgICAgcmV0ID0gZXJvZnNfc2Nhbl9kZXZpY2VzKHNiLCBkc2IpOw0KPiA+DQo+ID4g
ICAgIGlmIChlcm9mc19zYl9oYXNfNDhiaXQoc2JpKSkNCj4gPiBAQCAtNjcxLDE0ICs2ODAsOSBA
QCBzdGF0aWMgaW50IGVyb2ZzX2ZjX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwg
c3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGlu
dmFsZmMoZmMsICJjYW5ub3QgdXNlIGZzb2Zmc2V0IGluIGZzY2FjaGUgbW9kZSIpOw0KPiA+ICAg
ICB9DQo+ID4NCj4gPiAtICAgaWYgKHRlc3Rfb3B0KCZzYmktPm9wdCwgREFYX0FMV0FZUykpIHsN
Cj4gPiAtICAgICAgICAgICBpZiAoIXNiaS0+ZGlmMC5kYXhfZGV2KSB7DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICBlcnJvcmZjKGZjLCAiREFYIHVuc3VwcG9ydGVkIGJ5IGJsb2NrIGRldmljZS4g
VHVybmluZyBvZmYgREFYLiIpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgY2xlYXJfb3B0KCZz
YmktPm9wdCwgREFYX0FMV0FZUyk7DQo+ID4gLSAgICAgICAgICAgfSBlbHNlIGlmIChzYmktPmJs
a3N6Yml0cyAhPSBQQUdFX1NISUZUKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICBlcnJvcmZj
KGZjLCAidW5zdXBwb3J0ZWQgYmxvY2tzaXplIGZvciBEQVgiKTsNCj4gPiAtICAgICAgICAgICAg
ICAgICAgIGNsZWFyX29wdCgmc2JpLT5vcHQsIERBWF9BTFdBWVMpOw0KPiA+IC0gICAgICAgICAg
IH0NCj4gPiArICAgaWYgKHRlc3Rfb3B0KCZzYmktPm9wdCwgREFYX0FMV0FZUykgJiYgc2JpLT5i
bGtzemJpdHMgIT0gUEFHRV9TSElGVCkgew0KPiA+ICsgICAgICAgICAgIGVycm9yZmMoZmMsICJ1
bnN1cHBvcnRlZCBibG9ja3NpemUgZm9yIERBWCIpOw0KPg0KPiBIb3cgYWJvdXQgdXNpbmcgdGhl
IGluZm8gbG9nPyBDYW4gd2UgY29uc2lkZXIgdXNpbmcgaW5mb2ZjIGluIHRoaXMgY2FzZT8NCj4N
Cg0KVGhpcyBpcyBub3QgYSBjYXNlIG9mIGVycm9yLCBJIGFsc28gdGhpbmsgdXNpbmcgdGhlIGlu
Zm8gbG9nIGlzIGJldHRlci4NCg0KSW4gZXJvZnNfaW5pdF9kZXZpY2UoKSBhbmQgZXJvZnNfc2Nh
bl9kZXZpY2VzKCksIHVzZSBlcm9mc19pbmZvKCkgdG8gb3V0cHV0IHRoZQ0KbG9ncyBvZiB0dXJu
aW5nIG9mZiBEQVguIEhvdyBhYm91dCB1c2luZyBlcm9mc19pbmZvKCkgdW5pZm9ybWx5Pw0K

