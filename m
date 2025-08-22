Return-Path: <linux-erofs+bounces-876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21519B31345
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:35:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7ZmV4t9wz3cYb;
	Fri, 22 Aug 2025 19:35:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755855322;
	cv=fail; b=bXvmRJLXg+KT1kawrJJcM6mbBWXegO/FXoKXpSZbsP3+T5oZ2KUc04KTVF0kdK0/b3BvJr3OGL9coW78hb2Km1lMJE55J1kuA2oAArIpWwpL93MUVVMpBO1E70JPRtOsMsqJ9h96dZZAcN9lBXSuSittmbK45Gg3zbEYVjC7EMh5yI/+Jt0F+rcsJkQ330c1FcZmhgglSkN3Gk2nv2GWiZZeNSD9Jd8OwrZag4YT0YTGJ/dILeYGNAMEVfEh8KDI1HfBosrL1eWAHHpeA+6ubOrTQDmuUrZUdgkD+i6+VZgN81PQY1VgNJVejAKi4u90GW3u93MLbdGVI0v9xcce2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755855322; c=relaxed/relaxed;
	bh=hjc0TrIAQH6RPIh5cBrSwWoiElO6z7lv6MsEb3FEd9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PUVTFDkLjpC3qhYfjhDtObnu1uzgFFvCBEHXmO2JRSVl25VfeiZQOKH6jGbR74jrFlxiiBNHtkvajWVpYSBMZZbILYHp126HaYiQVs9h+FhJrwlrM1IV5NL8w7EVxT1u+jJc3XPvjfIvQWjeSOCm6MFaW96QeacXauCPCAUScW6CD9T61G9pwupyBfRgxFt9S7+Rg5bvOUOcmMIo760C+UsFT1wbVxnnIE/V8FT1FrPUOsK7fhv40VzG+mv0I1sXehntdCgGUaTe0sgKpXAPsmEoJqO9yq8djRvuwWFiFRbxOhwGJu2hc6eQgusQZDcaQF0jJg5tt+OOgo0ZwBfduw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=ppunL0J4; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=ppunL0J4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7ZmT3QSyz3cYJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:35:20 +1000 (AEST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6oElW017998;
	Fri, 22 Aug 2025 09:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=hjc0TrI
	AQH6RPIh5cBrSwWoiElO6z7lv6MsEb3FEd9o=; b=ppunL0J4jDKGup+ZNCX1MLO
	9OplYkpvK9fprv0NuodZEY/nK0apTxoAMbZxwMfFQNNTaPYr3JJGOWqMz0nZPzmz
	Nq3MnyhBh+oPB2Jv6o157wkgXfcj7HF/m8IWWvQdEQi+TTy46vmYA4Y1e4sCy1Tn
	ka1gK/V+s6dvItrOs1YJkAsc3zHF6ik+k/LM1ysg+DA94Z4CRwhaL9WE+7EO2cJB
	RETRT+TyD2yTsQHcVl/3ffQ6EOdmHV8D3XMFmdQ3TJP1voK6Xlvi2PkjiX3ZJmeq
	67sY0u8byZtWkM8demE7cjJtRFt8jUxvKvnJSQ+A8yXNMflUtuoZiAkVb98nr5Q=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37ktpyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 09:35:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA02l8rkXraJpR6x18YXi2NQxfGSK0nBgox85EGIYqjKiWPgL4Es9jaVih7HMn8Hi10LWitbjzT44KVM1yJVaI7/pp2l1eG0u2Oz0L1w1y354wzVM3k3bT2a0yZITvy8ePRd2pA8Hl2ayhUblr8VkovgXK9ItuAnxNF5gNyPGwvEJL4gQhTQ508Abj2BxBooHVtzpY+/otPOvK0wyaoYdYnipWJ1VgjnVfwqADeqSoPzVG8UuH7QTJ0piljls3Q28k+epik3I+Ow+CZuL97zDUSFypBr16ejzQBF6IGzqhcyJpfvEH3MNefHVNx2297phj655ncQ2To4IfTbqDcqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNx28K3xQQSGIJfCJLgfcxHwnrrOfpPhWmrEh81Pw/o=;
 b=Yg3jDNjg04IwAp4I6zOekpEWLe0jwBUPax37ASTSK/NvgTEO2fAjdjki9c3QiRGRoydTHl4RWj65Ad2ZcH3dwbJ9oa4Za/VS1bG9z59r/YVCfjbWH0u71+aSW60RIzRPWeStrV/vuGuWlmWebdAs1AdmZR+0CkDYaFU+oEtSrvViKswIIrEbBDmYHhFAwR3LtnK2FrF3vsjWgeuvbvju40cEeE6cUBJzpGNd2M4dBGO/iufH165Tw85/W8X4iFvhGRvsLsNzoYmkWkW234gTa4shU7J31iR1eZIEgoo/jpUO3k9YXRDUfSxCW5U6TLUWwGPmMSmGqye5aad6YY8uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SI2PPF536840650.apcprd04.prod.outlook.com (2603:1096:f:fff6::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 22 Aug
 2025 09:35:01 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:35:01 +0000
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
Thread-Index: AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdaAAAO7YYAAAoaAgAAA/so=
Date: Fri, 22 Aug 2025 09:35:01 +0000
Message-ID:
 <TY0PR04MB61912BD4A4596D2CFD485B5EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
In-Reply-To: <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SI2PPF536840650:EE_
x-ms-office365-filtering-correlation-id: 9057557b-4948-4434-206f-08dde15f2b0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elRlenhoSy9mQU0zZzdRMHVRVHVIbDdMWnBHTDd3S2J5VHM1K0FhdUFORTRU?=
 =?utf-8?B?YmFTSnFRei8zL3JQRGhOcVBqZ21MTXE4OGJIdDZmYzRQNXFDWnF3NWZzVTlq?=
 =?utf-8?B?aVV6Z1lZN1Fhc29ZZ21mWGhOWk5VbjRoR3dhVitYaC9UanhYcG9RNS80SHR6?=
 =?utf-8?B?RDdMUy9WazJNcDlQc01YRHowTVhlbmZvZ3hvQ21lcGllamRUT3BDdFl5cW5S?=
 =?utf-8?B?SkowQTRqb21zUlYxUTBPS0g0UGorSE4yYlA5ZW4za0tuUTRxenFhdEJBZTZX?=
 =?utf-8?B?YVg1T3NYT2dmZEFNMDQ0a1Y5YVYrczhHQlp2OUI4OWtNblNOdEFHZ1Nhd1Fr?=
 =?utf-8?B?ak5NQ2xZVVArS0kvTDkyQU5vd1ZOQ3dDcVRnVkpQa2VvQUdvallrdG1UZUFR?=
 =?utf-8?B?c1o3L2ppblF0YTRTdWhoaEJTaXJnU0EvdmlmMng5OVFUUzU3eGV2VTl4aDYw?=
 =?utf-8?B?MUhHcng1bk91ekh3NmM2cUxETkxGL1Rlb3o2d3Ryc3ZITlYwS0hVRVlVRmZS?=
 =?utf-8?B?VWVqdTFVTjN1bG9adEptbGZXRFJMcldtcSs1TzVFQmxWbHlUcTZnWWFaRm1F?=
 =?utf-8?B?dXVBcTlDR3ZoQWViN3dLeEZiZGVOTXdTYzlzUHFHbkVoanN2RDdQWDRibFV6?=
 =?utf-8?B?YUpnUmpQL2gzcjhIaVNOMXY0N1EzSms4aVAxZE51RU5hbzhpZVFjL1pvcHlZ?=
 =?utf-8?B?eVdJMmJjQWQ3V3BZV0xxbm5XV2ZIempSY1FNeENxc25IL3RIYkRBbjc5LzlB?=
 =?utf-8?B?eEtJOTNYZktKYTdzQ09mUDZORjdrbkVaQ09pUFYxYmpkUzkvNm5TZU9MUldm?=
 =?utf-8?B?WDd4WFg3cjNUdHd6ODJtUmNkWDRraUxXUXY4a2NkeXNubXd4em5CR0Nxclgz?=
 =?utf-8?B?UGcrQ25TVzRUaTloLzRGQzBMQUhWdHh1VEQ5WWpBL2ZqZnZEQjMwM05Cczg2?=
 =?utf-8?B?MTZWRDJWZ0grTDFrV1pPNTB0eW5EOFIyK0xZZS9BZHdGWnFLV2Y1alJHWlUr?=
 =?utf-8?B?U0NwVys3SXRoWkUreVU0ZHVwY3dMUitkSlFXM21ReUJaT0EyL1lsYnhWdzZF?=
 =?utf-8?B?MjBkOWg2anpoeXBIWVk2K3FtckwxNCt3T0hodkFsTUtNT3pXM1pmQWZkTDFT?=
 =?utf-8?B?MURoWXhSdFBKMndabXA5anZ3b2cveVcrVlVFWDFWeUpHVUlHWklxQ0k2N3R5?=
 =?utf-8?B?QktDN25DWnBoN3QxbWY5ZkNwOUJQeVAxbTY3VDdlZ1lhejc4ZTQvTjFRMzVH?=
 =?utf-8?B?VE5MRkxpUmNheHRvbG9hN2Rsc05EaTVwK1lXWVpzbFZrL1RhVlVRdEUxS1Ja?=
 =?utf-8?B?SkdYRnAxTXhXa1JZUWpJdERtVkx6MHRUMGYxcUk0TFRjdDRvSHRQZTVONUFR?=
 =?utf-8?B?RFRUY21vQkp4aWUwN09KVDE1S2VFbXJQbUJPeFNNZGx1Y1lLTFU0eEFqN1Q3?=
 =?utf-8?B?cmlScWZZcnd2NjlRVTQyNGJQNmRNd0gweTNjWEQrZ040dkYvaXY2cy9PTFQz?=
 =?utf-8?B?cGl4STlPTk5GK0dzdjBScElQRHhoZmRycEdQa2R6RXFINWc1MFBIa3NqNzNy?=
 =?utf-8?B?bnl3cStSbVd3cyt1aHNDbUh2SE43aU5kalR2QmV6c1FoOXRmYkZqTTJVSHNx?=
 =?utf-8?B?Ry9FaXk3VDcxWmRsZHEyWUtBSWZmaHBUSXJCNzRYdXcwcWtDODVLZ05QQTVo?=
 =?utf-8?B?Tm9LbjBzOEtKMk1neTZQTG1vNmNOWUNLdHp5YmVidVYxWXk3ZWpySTkzb2pE?=
 =?utf-8?B?dTAxMnVkdW93R1pOWnBZWHNyeUxuRW5laXVtYll6QzREVHJDeVRrODdwSDgx?=
 =?utf-8?B?M21oNkVuVnVnNTYwaUpCNUNVT3JZZGZNYm92c08vdmQ1akw3cG9ZVThDMXZN?=
 =?utf-8?B?K2tNUEFDUzNaRE5jZGt6bUtvQ0JQZW5XL0FRM25Mcmx4ODk2bk5SV2ZvMi9E?=
 =?utf-8?B?YXBDWUYxVnZta1VqeDhBU3hqSzVnUmYwaDBiSkdIREtvWjNITUd0VWpjdzRU?=
 =?utf-8?Q?dDWuuv5BqkvrnRllArwWXG8Zt3Wrzw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3UrUWdqWFpMVExJejdWVndieUtRZTZyZHE1VkV5dnhBTG1rOWM5Tkd2Z0xm?=
 =?utf-8?B?TnJIemdwb1ZFTGJFR0pnODNTL1RyZHpXVnlmM3Y0empoOXVBQ1dyQms4cXVo?=
 =?utf-8?B?S09zd2x4Mkh6UmtCdFpwY1RnbG9Yb3lsbWhkQ0F0TTBURFJyOFNFNWhRbTda?=
 =?utf-8?B?TVdoQnYxbGo2Y0N1TWx0TnJpbU5vRmp2K2NPaUFNcUxUajRuVDNzbmRXT3NV?=
 =?utf-8?B?dlZQeGdBL1hXR0lMdElNUm5FYlNLb2hWbFlESmQzTzltYXJ6ZC8xY3VlTWRw?=
 =?utf-8?B?MWY1bkhLUndPK2xmdHVRTDVCWHJZbnd1Vkd0cnd1NEdPYXdLQ0dzOUVCemJD?=
 =?utf-8?B?a0M3THdvUXVoY3RXWTM5eTNWb0RwVHU5NUc1dDVwdXpNNVpERWJHUWxMSTdu?=
 =?utf-8?B?cUQwK1c3bWpkNUh5TUFyT1ZCeTRlUVBOTlhQT1FuelN0OGVKd1dlcW1vd3VR?=
 =?utf-8?B?MVJwc1d0Z0d1cTJxSUpMQ0x6bmtJMkNxdlYwb1FFT251M2prem1VWS9ubm14?=
 =?utf-8?B?WHM2WTFlcUNUSUgxSWcxQ0ZVVTJYOTBKWVVqT01lb3Q2bWlGaXdtRjdpbUNz?=
 =?utf-8?B?Y0NnYjFmRmp1bW9FVktRTWFLaEt5K0Jqck16TUxXNGRYTFplOUZIQjhyMlZz?=
 =?utf-8?B?cWdidXkzdU1BSitPYjAwaWZ3Ui9DREpvbWFvZmxFblRBRzF0MUpGaDE1ZXA5?=
 =?utf-8?B?RitKTzNlejhMakZIT2JrY0E3QkV5ViszSmRsWjdUU3J0b0pWbW5KendtL1JS?=
 =?utf-8?B?U3NhMUlPQ2wxeXc5TjhkUXJjVGdnVmdwbFdIUE1LZFJFclJiOGV3TldRYUpv?=
 =?utf-8?B?eW13TmJnMlBXQVZtKzlQTTdNODZaQUdVc1hCazVWSWlScC9hL3RXVkM3WWZE?=
 =?utf-8?B?QVluaUoyWXVpK0t1VzZuMENhbUU1OWpmZHZKa1d6Vzc4b0NZNm9PaXpXeHN3?=
 =?utf-8?B?Q2JacERQcm9rcUlDbnpkVU82ajQ3Zy8rNjRWNWU3RW12WWRJZkdEWW02MTlk?=
 =?utf-8?B?Q2JoUG1mMHFydkJmRFBMZ2R2SVd5TTBqSGsySHJWU04yOVlaM0N3TUFaSnVT?=
 =?utf-8?B?WWE0QlZLVFBuMCtJTVZaSG5RNk5tZ3hNMXk3SHBHK2s3bkw0MDhlbDBwVzVa?=
 =?utf-8?B?QVA5c21mdWhFcm13VytNdzZHa2dnTjlHL2RPLzhpd2ttWi9SNGt0N3AxUGtE?=
 =?utf-8?B?SXc1RzlvaFR6OTdEV3l0R2tQRXhvTlJscHRkdm1hYlhVWlpsVjhCNitmTWxk?=
 =?utf-8?B?dWY2NHhLUFpKdUpqcHJMV1Vwc1NXTUJITkNVMXNMaGRhNDQvZ1RORk8zQTBJ?=
 =?utf-8?B?OHlnYUd2bFFHVklEVERYQUszSjN5cUhzY2t4VDZMOEV4TzFhL1poUlZTK3pF?=
 =?utf-8?B?Z3ZRaFhjeG1aUHAwcHVCY2QzMXNuS2Z2R203TUt6ZnE3QjZramJwWkFsWXho?=
 =?utf-8?B?SGVvM1d6VlBoSWdLMWhMYzdwWlR2VjBWUU9kVjdEMi9IZUVaQ3pIRmlKNHlw?=
 =?utf-8?B?bS84ODQyKzFuc1VobEdKZ1VyTzdQdlMyYTZad05abjh6Q3ZLeFRWK2pIaGx6?=
 =?utf-8?B?bGljUDl6RjZQQTFwemVtcU9mOEd5U3dFRjZIUE5mUnZta2thTXBJSFZKNkpv?=
 =?utf-8?B?TGIvWlBkMDgzWmhCSkhINTAwTjEwNmgzM3gvenNBME5oRUN0a1h1ZDNKV2FW?=
 =?utf-8?B?d29uSHI3MXhBR2JHcmNTdUtmNTM0am5OaWo5TXRNd0IzVVhad2Y4ZEhMeWRG?=
 =?utf-8?B?cmRBYTFyb3ZvbHdzY0hMNE1vVGJyZ0w1c0YvL2lTbDNQVkQ0bEpTVmdqcjhQ?=
 =?utf-8?B?bkJ0aDA5eGVhRlE3dnlGdWtDMnNoc0p4czJxTXNhOWhMSXJTR1pvM1B5YS9S?=
 =?utf-8?B?bG0rTWREWmUrY1VwV056SlZmSjFZRmYzLzE4LzlvQ2NDTGxvZWtkRldObXRJ?=
 =?utf-8?B?cW0zRnRhbFRuQlJWWm5FelJWSmJ2eXExaGcwMVhxR0M1TlRPaDQwKzRCZ00x?=
 =?utf-8?B?c3A3bGErUU5zSlRZOUs5VWUySmJXQnFmQ2FpYTJoemVNK0x0akxzQXJySFZ3?=
 =?utf-8?B?U29XQm1VSXFXODVZdUtIaCtGeDNnS1R2aVcxUG1HalhSZnpWSk9BK0dTSXJE?=
 =?utf-8?B?b2l3NW45R2xaemdweUpKT2xpYlI2amtiWThYVWRDZzEwOUEzZHY5Nk9RdG1s?=
 =?utf-8?Q?WR7XPPj9xpt9qf6d8PzMFPw=3D?=
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
	KVa85gMARUUX3RgeaTopRwSS8o8fUYJr3OlWEL2vy+Wdijb06ygX9UdqE/V9mnOe8LVNCrbCIIXrzW1VdH+iA+M5ZwapIQGXQowUwdSFGCiFhODeANCtC9/Nm8jpiT2b9GynfF2ZwYXqqCUAjQszTHXFDW/Sxmli1gRgw3Ga733CJgYbjAzyxH5NZmvBtxhNCPcfe+sHMdaa6D1jp+Qf9q+3lkgu23nRoSdFcAtpEOnDbL0d2SAp+o2nQiaHOUskCKqk1HhOZ74cm7rG5Q6Y499BCumubzNBOuZFQNxumPvfwK/HwFxq5ZcDPyP33CfCQV2YIbbhy7YeUp1n6lPb6uIMFsuJBiCg3M1zsq7BvtGrVDoZ7/l0HvXkIqd+hQd2XT3R159OnwBMBCUtwoSy2YnwBsM43BjkoyDU1CEYHXfdlk/UG/YHnghBF7cVSBdLb8ZRHDPDcTR1ZAuGuqI1nhwm/cBxVA5ZS8Qp+AQNAJ7OAOpGYq/rCVuxIHNOSDIpDrfyjVmTf8bqiATWGrYF+8aUpQ3Thtn7K8ZL9JwDoy2iKWY+lE/7AJcJqDqc4pKEphUQ1ikfTtx5CfNV4/oX7zn84512Xry+A7cSOz81KgNAW37CEvmPdLlXTwPo+wwL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9057557b-4948-4434-206f-08dde15f2b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:35:01.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYVd9iZiGtM7wKe4+mZlXRlIazlEilyYS0nCATqqv5GMaxHBl3p5cNBtFL3oGp8BrgMgev9anq+NvU64X1z/qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PPF536840650
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX7QoyLnjEYfvf av2T1xar4Mp+/I54BNIJjzXKQ01VEdmZblbXR6bMh0hY1LbnysZFXgRyRBIl7piV3CNtbkE6ZeP QSulwLgRtcuWOpvdZpIYjv99KsijAiPAx+SgSFoZPTPT2p42WUyulztsGBadf+s1sAQH2AxQ1iE
 vKz/PAYgg5jornKQdgaofgTEOEQIo5T3SmipBDSPFYHuFhUJTykQWBLIDXGkJ3kkuQKY1TcFUUx oo1cN1UDrS6Ftqun0FivU3XkwXJm5pxktFYKA2TmCSO/hZHzeqtpqK8DMFjTY8sqS/zYhfIk/Pf KpmhkZuR2xR6Df0cjPSyPglbXAFQ9sMAgFTnVjNdItmH7JSdzHaUI/Y/pl9NKnXT8JMvBqQ1rYQ
 Q+QdBzt2y+8InxK00SCACg3z5mAQpw==
X-Proofpoint-GUID: EtmVYxxr5yQBQeBs_f-ve5cfKuLL0Rae
X-Proofpoint-ORIG-GUID: EtmVYxxr5yQBQeBs_f-ve5cfKuLL0Rae
X-Authority-Analysis: v=2.4 cv=X6oL6GTe c=1 sm=1 tr=0 ts=68a839cf cx=c_pps a=hWbQcTDNqXJ3Ka7W5V0sDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=Bj90jaK72LekJOHGxAoA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: EtmVYxxr5yQBQeBs_f-ve5cfKuLL0Rae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

show both 'before' and 'after' is just for debug, not so important. OK, I w=
ill delete 1st one.


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, August 22, 2025 17:25
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/22 17:=E2=80=8A19, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom=
 wrote: >> + off_t off =3D lseek(blobfile, 0, SEEK_CUR); >> + >> + erofs_db=
g("Try to round up 0x%llx to align on %d blocks (dsunit)", >> + off, sbi->b=
mgr->dsunit); >> +




On 2025/8/22 17:19, Friendy.Su@sony.com wrote:
>> +             off_t off =3D lseek(blobfile, 0, SEEK_CUR);
>> +
>> +             erofs_dbg("Try to round up 0x%llx to align on %d blocks (d=
sunit)",
>> +                             off, sbi->bmgr->dsunit);
>> +             off =3D roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi)=
);
>> +             if (lseek(blobfile, off, SEEK_SET) !=3D off) {
>> +                     ret =3D -errno;
>> +                     erofs_err("lseek to blobdev 0x%llx error", off);
>> +                     goto err;
>> +             }
>> +             erofs_dbg("Aligned on 0x%llx", off);
>
> Could we combine these two debugging messages into one?
>
> Here, 'off' is changed after roundup(), we need show both 'before' and 'a=
fter' by one variable 'off',  it is hard to combine.
> Do you have better idea? ^_^

It's just a debugging message, just wonder if
the previous position is important?

If it's really important, you could use another variable
to keep the original one.

Thanks,
Gao Xiang


