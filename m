Return-Path: <linux-erofs+bounces-848-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F27B2D959
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 11:55:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6MJc6zvrz2yGM;
	Wed, 20 Aug 2025 19:55:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755683728;
	cv=fail; b=aG4OvjYXWLulFLkR2lpmKHBu1zsnykolej9pcRttcnc6fUYUkSdeXsjbj5ZTde2E6GEFs2EsLCml6hjyyeaZMBrkumwI62woKwEvmCgKJY1cWm1KQ8m9asrxvWGL8P/nhmjg0R/dsN0RLy36gMdunogNpJ/nlxdC0Ybvaa9MxcfLYJ02Rq1JW+gi0vguS9qg+KFGQHFJKp5YPCTqrbq2IDjG+htAWpjwXd3CYFveheeN8q7TlbaC6CD1tvsOojftIkErxVqVs/CrJIPI9BdAogbw//6cPPfH7iLXUi7yVJ0LH9UaziC0rnQ87uCHw+54oasVy7ubu1ckqysZ9DEtdA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755683728; c=relaxed/relaxed;
	bh=EQ7R2JxKH7YYmgAiyJCzEas8+r3YV0XujgdznIHQ4es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=btfPuAeyK29GrHB2/UcullV7aPGAgNtrdVkAmPHo4Ed+drHZ0qlcIL9e8QqzhgVuNNkGQdWJnlMZ0koYlrTjCyVmnKJIVoj6MsNUWZwBTeL+3KSaXn1ZVN4SdX6/eDmjp2xDR/cD9Wury6BtrI85mZ0z9lKWTUV4QHb2QK/1GCzg3uScTKFEaX64p8KOG7N+Putov4g6oRHVEitV/TFgMIniPJwUtyu+oEYFVAgnGdwQXOvyd8pfAsgOlRgit5Cp3ByzASy+ADZLYYEtP3+5ClyMtevxUoleUDrjuYPtmcC/k5imnUCcxv6l8tCgrTROfQCE1PBKrBrvEO0mqJdMEQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=O9glFWQO; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=O9glFWQO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1015 seconds by postgrey-1.37 at boromir; Wed, 20 Aug 2025 19:55:27 AEST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6MJb4N0fz2xcC
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 19:55:26 +1000 (AEST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K4A2X5002703;
	Wed, 20 Aug 2025 09:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=EQ7R2Jx
	KH7YYmgAiyJCzEas8+r3YV0XujgdznIHQ4es=; b=O9glFWQOuKOE1CJX9G2yzzs
	D3xPw1BG6VRmz8xKcuKHSGATw37eRu/FAQZCMNK4h9s7K6ecfqN50vlYX9i3R/7H
	wtDEGxUvp8JCmNzaY90jxzyJs9L8T9l5eBlnK/Ec8AZAxaA5Cx7wQlpIcnr/JOtm
	DALYNcJeg7s9VFCLcyCecfYrRkOmZA9wPYy70q9MVzVZWWV/g2sx0YyMupvYaDeD
	SMU26TWgQL6sRgT84ElLvxKOx6si5ZamG6FPJvlM583no1lwKoHkkysKp0g9ZV7C
	zMZHxvOXw9lfk0aVcMkwdGSTGrB3RpI/Xi+OS1QXj9JdzF+oDTzkjTAUh5uiyKg=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013014.outbound.protection.outlook.com [52.101.127.14])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37f0fcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 09:38:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om+5UysmunFraCJtRyfq9ZlWoBePfnPnuR/3Qf2bu7h9VdOahExWWA/CKNl7gxhy+2gScU65E6cyDJQak8LGVSmDZBMhccKAtIbd+oL5BU4jglt8jehwdSlGAJFShE9GQO8NAhatT7qjJ2l+ki8r966ANjWQup/fwyb96w2OxXohgjZMZnrFOpuyU/ZmaSc3EILUz56vBh4rm+6WGnF5EpGNrdOyWAEP0ZRQf1julLi3UqxIbGj06Ivyx0jOB5X469+xAyt8ZnHnpu28etEZ82xPDcR2vRxOR+poskIi4WANp7C/kXO1UeQwAGNllYQ0Ri3G2GSC2tnbaTTK1MF4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kz9xjONDx1oOJUjCkdrxcJ19yO+/KK6lIMRNQdeQDk=;
 b=lIuwCvkWE3DVBYYkh3lF77hG7f577oCU+BIYyuthloQ0ZSnyeAnh9mQ7dvcQfelVtTBqsU+2vl//ViTak9lxgJ/VL0V6SjFRUq7ASEFayTCrxN7MqSwDgMVz6Lgs1uT3xY+PnFuOG13bG/XEwA2EOjmYaTH0pMEDFVaI+kvA08K0fGyzWFbR0Kb21gp62bvebJ4TKEjiA51zLgcwyKaQ+c50LBl1zv2D/F32fwFp3dA067vTNM272WnvayTRWgQOYP1YxqT9wI50IYAZQcGd1McdjW+Cp+tchzcSn957b7L6zBg/xLnE27AeeM63eN+DG8+HPwGK3ZWnoeEmttFdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by PUZPR04MB6182.apcprd04.prod.outlook.com (2603:1096:301:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:38:12 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:38:12 +0000
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
Thread-Index: AQHcEaR09AqiVESPN0KCsjRcUS8Fb7RrKVGAgAAPTIqAAAkdgIAAAwxB
Date: Wed, 20 Aug 2025 09:38:12 +0000
Message-ID:
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
In-Reply-To: <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|PUZPR04MB6182:EE_
x-ms-office365-filtering-correlation-id: 83068ab0-7a29-4020-35ef-08dddfcd47d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU13aklPRGVUUHFiSlVWYkpHYnRtdlB0aUlKaEVSbnZJL3pTdVNyZXh3RWh2?=
 =?utf-8?B?bVNwNEU4L1RLY2YyUXZTZHJQbStMaHFDbjFWVUhIaWpiMXMxbml2eUpKaHVa?=
 =?utf-8?B?d1o2UVQ4VTVRdEJDRnBKbW9DNlBzTmlBcXFXTUZvWGxCVzlxN2xMemc5djVN?=
 =?utf-8?B?Sk9XTWEwb3ZWVFJwT1F3M0Yxd01NWHRna3hpM2NBWWt1S2dLT3E1TFhiejY2?=
 =?utf-8?B?SUl1elRqTWY0L2tqT2FmVW9YQVBsMGNpbWF0NDVpTzREbDZxai9qeTUxMlBu?=
 =?utf-8?B?azQ4bjByWUZrYXNQWklCbzBxMGFaeTRxdGtPVWNWTVJ4ejVvcGlURVU3RExO?=
 =?utf-8?B?N0NYM0hkaHorazVDRUNHaEZ6SVJOS0JVWVF0diszd3ZUNzRabDZxNnl3Tm1F?=
 =?utf-8?B?akVERGdTcWJFZ2M5THlVWDJRZmNJTkppTnB3RUZJd1lzOXlScjRQYkpZTjAy?=
 =?utf-8?B?N3hlOFp0Z205RlJBcC85M2JKQ3ljRUxTdGxiWEVhSGFoR09GL2FsN05XZFhp?=
 =?utf-8?B?TUhVanpLd0lNaEpCeTRjT0sxM2ZQYmZYQXhXeFB3b3lLeTkyVzQ3VTJCTE9I?=
 =?utf-8?B?dlNVYVJMRk5nSTVBMTNUcnJtUkYzOU9RQ0lFUVZsMlhlODNLWGovWm1PV0l1?=
 =?utf-8?B?TktXeDI3dHZscGVRYUtDQWltV3grZS9BYWxmVWV6VFpmaUE3Ulp6WE9VZ0p6?=
 =?utf-8?B?bnhRczlMbkpjREVrM1MyT2hnOUU5M3B2cWlveWxXQVV5WGRHU3lOMlhzTXFn?=
 =?utf-8?B?Z2JzbmZqQzRBWnlma01IZFd1REtyaTVlWFFtMURlVmFiOExRa3hyL2xIcUpJ?=
 =?utf-8?B?Uk9iS0JjUjZiMUhnU3phTVA4WE5ZNFI2R3hXVmNPV1JObUNVUU9NajloWCtk?=
 =?utf-8?B?MWVZK3lnQUJRVVdFeHI3Mzl1M2hBejUySVFYajNTeTZoMzFmWGVoMlBFTzFR?=
 =?utf-8?B?NnNoN3JBdFJxcGg2RmxqUjFPZUdtL0ttSGsvN0tYWE5PaFAyU1FneWVYN3gz?=
 =?utf-8?B?NUdXY2grS1F4STBLQlhobU1JZEEvMzg2eGZiRTFPRmdJR2lBUVVYWTlsbXRI?=
 =?utf-8?B?VzJQb0s5cUNLRk80WCtBOUZHd0RzUm1INHByWTRZZnZwaHM3b1grV2dFNGtv?=
 =?utf-8?B?Y3J0MFpPeE9wZUJTa3pVcDJMcXlMYXdtM2dCbXRZRmZyNmI5Q0swaUhQbEpJ?=
 =?utf-8?B?WC93eDVwdzBKNVNka1hVaXhrK3FNU2M0TlpuYi93M3BFbGVvQmxIWTlGZ3d2?=
 =?utf-8?B?TE81RTd6OXpqVktWa2trVjlOL20veGZoZ3Q5dnUyb3Uvb05qRjMxZWVZMS9L?=
 =?utf-8?B?Qmx2MUpzWUFrbzg4L2VsZjQ2SEVocnVkWU9NOWZKWENzVEkraU9vQXJjVjJF?=
 =?utf-8?B?N0JaaWptazJ2Y1d5ZFVnRlBnWDhxZlFPWlRNVWpXd1hHaEc1emRyMFFMVlps?=
 =?utf-8?B?OWh6ZGxYbEtaVWRBTUtlWjMrS1lmaWlGSDZSQjJPRlhYa0JZemloMFN1Q1Zt?=
 =?utf-8?B?RTBMQWRqWCs4cmxnQmQwbmJ4bkRMVGJBVVNYRjlML3JITUpQbXU0Umo0YjJR?=
 =?utf-8?B?R3lFREJHMnpiSDJVZkFKVjg0RlhFTVdhdlIvQzlqUXFmL0plakY1RVRFT2pE?=
 =?utf-8?B?cHBEWnB2MW9VVm8yYlVlUTlJODNJZTlJb1dGTVJ5V1YyMDl5Tm9peVlVRG9k?=
 =?utf-8?B?OG5EZFVzWFJQVHJqZHFScitoVUMxd3E5ckVpSjFTeUtUZTVnb2ZnbXU1d2sr?=
 =?utf-8?B?NFpqY1A4UFVvUXFKaHNJaDVJUlF4Q0RFVk8vcGJPUFhkOEYvV25NU0xpaUJH?=
 =?utf-8?B?bXNMSmtNd3RpbitDSEVVSndpZlhGa21LblNvVXdKRy9ta2kySUZuWmNCS1NV?=
 =?utf-8?B?Sm9vY0hxRGRyd0RaOVJycDJDdDRRMTNHT3ZTYklwMGZ1U2FDYlVXY1ZGVll5?=
 =?utf-8?B?OHNKZStnYlJJcHJzdElRd2cxeXhLdkpOQzdOUGRxenJmR1hCRGNzdkt3WEFQ?=
 =?utf-8?Q?21j2MVdz5/ZHzSesr+xPOA2WjaNVCY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkhxREwxcEhkT3NQSVVrc2JnRG9KT3UxdnJCUUNhM3dPRG9zWjdGNDVTSmFm?=
 =?utf-8?B?RmdNV1ZQWVU0MmRJdDdmVHFva1h4Mmd3UVZzdllYMmxMWERrTDU2RWFERU0y?=
 =?utf-8?B?dllYWTFIQW1DT1VJeDlIamZHbTlvM0FlTWU4YkxMSElDZ1lVYmpzQ1FzTUZn?=
 =?utf-8?B?UStzbGFsZmhwSk1UVFpXOStESmlINjYvVG1DU3R5czBJV2IxQWV2dm05NkFR?=
 =?utf-8?B?WnFvOXdQZ0xueDRoczRJKzd6Rmg4bTBWZXZjb1hFWm8wRzZULytrbWZ0dGVV?=
 =?utf-8?B?bU10SWt5aWlEdmMzalQ2Qlo4RWNYcnlNd2lTbDE2dVpEN2l1L2JhNHVFRkhu?=
 =?utf-8?B?U3E2MkNoWXZ5T2ZqOEVhSWRjUDZqTUx1REdFWkpBTnl5dlpoakFNdys1OGRj?=
 =?utf-8?B?am5hUUJsamc0SmRzMjNRODRubUNTUzZrZldSUklEUm41UEI0YWJjaE1aMHkx?=
 =?utf-8?B?bjlOcFZ4UlFKaFZCVHprMit4ZlhvMG9qNlRuS3RNQnRSTnNNTFNPaWM4c2Ro?=
 =?utf-8?B?YVpMV2RRSFRVNTJaNjZqT2lsMWZuMFpyVFFGL1AzaTFNeXlLY1FFRDRhUHk3?=
 =?utf-8?B?MHBXM05HT1l0amh5b1ZyWHNwZ0dYR28wM24zQXR4cGxDV0ZqY2FtOUJxRFBH?=
 =?utf-8?B?M1dWR3dad2F3ZzZycmhldmJ2dnhxcUJxdEdrdDBTU2pXWnBVYk4wbW1nYzM3?=
 =?utf-8?B?VFhsNkJ3TnR4NTF6bWFoaFhsY0NrdHlKZkNvZG9WNkJ5Q01yOVRFaW8reWdV?=
 =?utf-8?B?eWZvOGJhODc3QWJ6RmVZeUVSdmswdE9ielFwcVVqNHhjOXB0VTB3TVd4Wi9R?=
 =?utf-8?B?Rk1jVzRXNmZyVkVqK1lmQU5XYnZ5TXpiWkgxYjRHYVpIRzdEbGxrbndReHVi?=
 =?utf-8?B?cnA4UlMyK01KamtKY0ZKRFplWWtyZUo4ZVFvZzBkWG9RRGNoZGFNNmdRd25Q?=
 =?utf-8?B?ZHBrL2ZlVTZ3bnNjdnUydFhiaHZ2N0ZGemFPcVJHTTA3SDJXakZnVlhySTcv?=
 =?utf-8?B?M2FneTZOb1dkN0ZRMERUS0t2RVZVWXNtaUdobFlTK3dxcCtOSnlDRHpqWm9S?=
 =?utf-8?B?bzhkNHJDODVEMUVVMm1Jb2lIUE02eWsvWFYyaFJWNEpqZFd6eC9xTHp3Qi8x?=
 =?utf-8?B?R0t4MS9TeC9jQmNxd2xwSDlQM0V4bHdHSXBYcTVGaVdNcjZoZmV4SmU3TVEw?=
 =?utf-8?B?a01oUVFNRGw2eis2ZUdsb3JnRUZQR2htZkdqdHhLT0xqUTdyLzY3Nk05ZEhU?=
 =?utf-8?B?NUR5dGVZTmY4NTJ2dnAxbG52eWIwVURkdjIyQ0duNmJtaTZoWUc5cVp2ZFVv?=
 =?utf-8?B?ZFozeFJwVENxQzR3Uk1kZyt3U0dmNmdVV1BYdlJvL3JBNWFqZFJFdCtuUXNa?=
 =?utf-8?B?SFVMQS9wZHZGK3QwVmNXSUlWZ3l3emkrZk9GRGpCY21LRDBIekhQK1B4RnFI?=
 =?utf-8?B?R2FJamtSdWNpMHVDa25QZWZwWktPZVVaZFViT0ltTERZdG9xdVlZWDRNSTBE?=
 =?utf-8?B?Mmt5VllJaDlKdDFSSVZML29aT3pjcmIwazYyZ29FK1FRUklTSXVmQzV2SzRt?=
 =?utf-8?B?MmZKUnpUT293cSthVWtPamlLa0JHZGx3Z2p1UDBwWmNCeXhXQVlrVnFDVnBl?=
 =?utf-8?B?VHJ0ZmpqcFFUWStQWmR2VmYwMXFrV3E5REkrMHIycXRocUYzYXRnYjQySSsw?=
 =?utf-8?B?eW02eDZYb201NTlNZGhZUkYwQllQYzMxMUhJT09UN1dMMzIzc0RxVDJHSko2?=
 =?utf-8?B?Yko3Ujk5a05KUkQ0VGdXMjV2dFZDSFpxTmorNmowSFkvWVcxV1ZnY0tRSkNT?=
 =?utf-8?B?ZGRNTEFrZEdwMkRGdlVwdG00QjB2ZUphWUsxZnZtelR4N1B6SHZiU0p0ajR0?=
 =?utf-8?B?YzU0OUFOdjBBdFh5QVFYSzVNclVySlVrMWlSTG1xMnA3b2lmQ015Z2RMYlBH?=
 =?utf-8?B?WjI3VTB0SVlzWm5mOW9SRWUzMk43S1p4TWIvZTJ1aHJtTGN5U1RQdTREOEJk?=
 =?utf-8?B?MUU2WmRPeE1YRFdQOHJFUlo2LzhrcFZ3QWQrRTl3bitqTERvR3d3REZYVVBi?=
 =?utf-8?B?NTJ3RFZhTFVSMk84WFRQRDRlbzFiZ0p3K3RTNW41TWFoV3BOZ2ErM04wZ0JV?=
 =?utf-8?B?SUpkenRReGtoMmVIYmc5Ylk3MlE1Ryt1QjBsL3FWK09LS1N0TTJPQWRkWlBh?=
 =?utf-8?Q?7+cw0ngV7LqQq+ogBG1GdaU=3D?=
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
	vMAk0CNa/fWhOFbsXMPmx1qWkPOhBc+Yl7zjT+KHKnDsjG9EmQ6uwVDrQ8h3+2c/gK5Y9p1BulYNWzMUpxLyB77ICS8j6qzWz3uXzXJx5IJ1/61wSSbo+55YkT5K54cQcJAk68yqgZel/F3eWIHhil7hIHm3RHmwwPfEIu96s9vA1pv/7X0y/OqUmyvf8KeKzJPPCPpm9qfTRGSOvTa9jtgye301IpJ3MqDxBG0OGYfReAc6vdiKlb+19fr9l00ERVS7wjrVzwpO9dL7J/LgS4bX/wKf3rxeo7n3BYVp+pU22MeUtAk/Rcs2fy6oFAPU4k1B6dgOjtHx1bkHehTJpG7UH0o1mwxnW0MqFYiNnh0jXBrqfg2AFSr7NzC/tN+OXQW9W17uBxqLINEJyH94bumgm8tnJcFl/qRUOS0QhfPG+BbrrY8YTxaoDTnN/wwRuta+Jp3DJj5IFZ4D4wKalxLeMm8XHA7Wb/REot5Ydr9m+I+F0WMN0oMwAUn/qemezXSDbtN6tOdZHE0PbfaeAdb0a1n9zek8jSLQv4S0cRpwDc+xLBidf6ZmDW5P3vunOliKMNREdzAzfjvODmz1GRAO1Kf08ji3jMszmMAvd+eGYE4E7m6Z8sZMm/WTFDun
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83068ab0-7a29-4020-35ef-08dddfcd47d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 09:38:12.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZx7lSOu7tPU2PGYQlLez752LnN/KmsP2NG9fcwMya7OGQDeN6rvtK+l0IPzxXfSwveJ/PgYOAC+lkggfjakrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6182
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZpO0697G c=1 sm=1 tr=0 ts=68a5978b cx=c_pps a=9j8+g4wjs1fxtCFcyCGCIw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=A1OA0lEPbZMAvFa-fiEA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: Xu_uDzS3ij-nZtKygFYXAI8Iw9FD62jk
X-Proofpoint-ORIG-GUID: Xu_uDzS3ij-nZtKygFYXAI8Iw9FD62jk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfXwStHv3I3TZXC zSvvpXFqiXQv909PrDxgkLm5XxczWKD2AGmkS24NS1k8hfcs13+tRYqJ6gjhD0yBmnBjDRs/CEE frkdGsiEqDH2JJ8SVblruxF5mbg1bbgWODzQ462WfoyyhU0Aq0H8FGN84HD3mbwHwQ35mbKUwFb
 i9GPRQfVKb2WQrrZZ3xkmYs2vr5iOmojNPTpMJkjUKxlwb6ejn/v3QJieHR5QRCTvTD76aPi+18 VpzPrX9gV42t55w98/bdF5XHZLb8UnbxX7P7gZhZpMAL2ZBfxM984qM8P+ee3X3GZd/j7CH3Wtz Azy0D+oUlMbAx5kdiEwlsHkaFYQSI3CSe7R+VdKS+zn7XHaYAZTSa7bRes5/HzYrTCuSN6+030q
 FZ9ZTkAw51Gq6fF/GuqbNxKfFy+EzA==
X-Sony-Outbound-GUID: Xu_uDzS3ij-nZtKygFYXAI8Iw9FD62jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,

> What's your `--chunksize` ? consider the following:

  chunksize =3D 4096
  dsunit =3D 512 =3D 2M

> and two inodes:

> inode A (8k)    2M, 2M+4k

> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?

> Is it possible? what's the expected behavior of
> this case.

Yes. This is the expected behavior. See runtime below:

1. Created duplicated chunk:
root@localhost:~# dd if=3DA-8k of=3DB-12k seek=3D1 bs=3D4k count=3D1 conv=
=3Dnotrunc

inode A-8k    (A-chunk#1, A-chunk#2)
inode B-12k   (B-chunk#1, B-chunk#2(=3DA-chunk#1), B-chunk#3)

2. mkfs.erofs:
root@localhost:~# ./install/usr/local/bin/mkfs.erofs -d 7 --blobdev /dev/sd=
b1 --dsunit 512 --chunksize 4096 -Enoinline_data /dev/sdb2 dir/
mkfs.erofs 1.8.10-g08df294b
<I> erofs_io: successfully to open /dev/sdb2
	c_version:           [1.8.10-g08df294b]
	c_dbg_lvl:           [       7]
	c_dry_run:           [       0]
<D> erofs: file /root/dir/A-8k added (type 1)
<D> erofs: file /root/dir/B-12k added (type 1)
<D> erofs: Inline tail-end data (60 bytes) to /root/dir
<I> erofs: file / dumped (mode 40755)
<D> erofs: Try to round up 0x0 to align on 512 blocks (dsunit)
<D> erofs: Aligned on 0x0
<D> erofs: Writing chunk (4096 bytes) to 0       <--- A-chunk#1
<D> erofs: Writing chunk (4096 bytes) to 1       <--- A-chunk#2
<I> erofs: file /A-8k dumped (mode 100644)
<D> erofs: Try to round up 0x2000 to align on 512 blocks (dsunit)
<D> erofs: Aligned on 0x200000                       <--- Align on dsunit 2M
<D> erofs: Writing chunk (4096 bytes) to 512   <--- B-chunk#1
<D> erofs: Found duplicated chunk at 0            <--- B-chunk#2 deduplicat=
ed=20
<D> erofs: Writing chunk (4096 bytes) to 513    <--- B-chunk#3
<I> erofs: file /B-12k dumped (mode 100644)
<D> erofs: Assign nid 44 to file /root/dir/A-8k (mode 100644)
<D> erofs: Assign nid 47 to file /root/dir/B-12k (mode 100644)
<I> erofs: superblock checksum 0x1e00ad75 written
------
Filesystem UUID: 8baa7ef7-bd06-4b51-b0da-78202eb3b8fa
Filesystem total blocks: 515 (of 4096-byte blocks)
Filesystem total inodes: 3
Filesystem total metadata blocks: 1
Filesystem total deduplicated bytes (of source files): 4096

3. mount & check:
root@localhost:~# mount -o device=3D/dev/sdb1 /dev/sdb2 /mnt/test
root@localhost:~# diff /mnt/test/A-8k dir/A-8k=20
root@localhost:~# diff /mnt/test/B-12k dir/B-12k=20

Best Regards
Friendy Su
________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Wednesday, August 20, 2025 17:12
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi, On 2025/8/20 17:=E2=80=8A00, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=
=8Acom wrote: > Hi, Gao, > > Thanks for your review ! > >> As for this patc=
h, what if the inode itself is >> chunk-deduplicated, could we apply this i=
f the inode >> only has


Hi,

On 2025/8/20 17:00, Friendy.Su@sony.com wrote:
> Hi, Gao,
>
> Thanks for your review !
>
>> As for this patch, what if the inode itself is
>> chunk-deduplicated, could we apply this if the inode
>> only has one new chunk instead at least for now?
>
> Do you mean inode has 3 chunks, chunk#2 and chunk#3 duplicate chunck#1?
>
> This patch only makes the 1st chunk exactly written to blobdev aligned on=
 dsunit. Deduplicated chunks will not be written to blobdev.
>
> In example above, chunk#1 is written to dsunit aligned block addr, chunk#=
2,#3 are not written. The next file will be written from next dsunit alignm=
ent addr.

What's your `--chunksize` ? consider the following:

  chunksize =3D 4096
  dsunit =3D 512 =3D 2M

and two inodes:

inode A (8k)    2M, 2M+4k

inode B (12k)   4M, 2M, 4M+4k, 4M+8k?

Is it possible? what's the expected behavior of
this case.

Thanks,
Gao Xiang

>
> Best Regards
> Friendy Su


