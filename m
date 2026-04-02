Return-Path: <linux-erofs+bounces-3173-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNRHNo4NzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3173-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:32:46 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305B38482C
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:32:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmX8q0C81z2ySk;
	Thu, 02 Apr 2026 17:32:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775111562;
	cv=pass; b=ax6QVVXN6pI5+UvbjoxBWmyD/hfcFrR1MkIQcRlSGr4B3gQ2PWHJjhBLk9ppR//w3On+q/17SxPU+qrO3E8J6Zbxs04qUb9WTQAQRfsZTCxQd0RlSSaPpkpXoph4XoShPSJ6/NM3aNxQnVyXROY3URrj63FAunum3Ofbx+Rnt0HO435UIolKJc7hMmmX1XSsVRvcXovOFL//7mcozI9ASZD60bpMYskUZO3yWvxfg99yNHwADC7UckQuI51Dh534tGTus/to4ftTqkkXNlKZuL83dNLu5yBAhET1tc7yDSgAFxiQP3lVrWw7nDgG750e7H3MbZAlvYw+JQDpLx6xeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775111562; c=relaxed/relaxed;
	bh=OI9LbZ8wz7cC1GryL68VF/UYfdQQOjqNVMoi/39Pn4I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yp18uOEGBgnh3HLvW8Wt4MOc6ps2MfUhD8VkQfBAmDjseUcdr+AxeUcsceJMMuNVtGs9N2Ww3gQ1jHaXGqWcA2j73ajYtdqbQzSRNPqHd+oAqoOT41uMUpHXexdEPx2RwZjBvEme7IgS27dTE+phtXLnevlGfeHi23EDzcs+olVDKxkOU42ATxvSexHhjmcT1XnoYO8mZUzr0uMo+2j1TXowkxq+wO29Qyf4iAfBqoBo0MtYyRQWvFwiBOx/+TDIC6bkOo9Hi8rgEiPt13Gq3rcYGcbBYDSKhKbQELcT967bQfliUu9D5qGQ1O7jwCMSdqFrNWyOPosqCyBZnLl+ow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HCZm1QPA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HCZm1QPA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmX8l6pghz2xln
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:32:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAkxv6poiJqLfd/5mUXw+Ju38hLg0FnoTVGfUfD/YD+9CMmAMNbPZfEIoxazyGHjbSGeqP5thuVW3EX0qYdhiB/cOcDEAIY6YIFv30DNlibkvhCzXHpAYK+8ChyvHADzWs2hOE6AB0/LGbNm92pFdGUVaRYE1xGKUmlv1Pr1tBwbszuKkW8O4ic0IuxLdcUZFcn+tScS+sa6RFH6xPsF88oEhgrxxfXVjCz2OKsLJ79GnueT/kqo9KInqLf0mquAb0nilAEX352yqyyQv8biuej80NSrb5zW1cP63lEpaI/bgShaA1Bmtm4nA9ZPX9tXzyZdcpPxxSv0OnfcXj8uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI9LbZ8wz7cC1GryL68VF/UYfdQQOjqNVMoi/39Pn4I=;
 b=uMt0JOBCu1Ag9b7wjP3LlSzsi6mvtZvR31O9w1/TkPvHV6r5uw3kCwq6yFKTcr9o+dUpXjY12pOIVkGW+3+OI1qYY17n7WQZBUbrtgBlyUZt/aeEqEfyol/LNKjGX/60FrcuA571iKrF73kmHJi2r2FD5VuqNZzqNFAdfbyXn5+lztGP2Rgm78Hrejk8ODCz4oyZfwbgV9d9wVbe7p7Th9eHDGOufrRRR/AbrKawzr9XmaNJpBZKQTDhRSX2+qV4mkofmQorFEqxLAYcytxTGQLo/xP2yzz5d8nBZYIZJyEHMNjCGB2xGSbGZnf9ww6GTH6FXvL2NuZzN7tydBXg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI9LbZ8wz7cC1GryL68VF/UYfdQQOjqNVMoi/39Pn4I=;
 b=HCZm1QPA6jPOfESdrOIZU7rRi9ju+zycpnw37kke+0DvfrJ0izut+FnFKpmJrGnpgWND+HH82keGX8BXkgGpify+c3VhiRcNdWcLnFx84E5VEbc/URVoP/3eoFVXaZ4Q+cTuuPAr+z1V0ExoPE5KLRrjd6hD3kBTh0qZHNqVHNBdzh2rXhcefwCi5txym2uHJQqMehVhcpFZJQ59i2pzDfgDi2h9bAiXXxzAk2ZcAAdMUxIYtUU91g2X531nWQ7WGr5XmGRDlXfgAQdSojmoYbYrDnkh0EAUObhZDzk6WVpKlfvsFM5ZGjTtqqirB3dZ5doMmHrVKJtYctmVGI28Lg==
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com (2603:1096:101:2ee::17)
 by SEYPR06MB8288.apcprd06.prod.outlook.com (2603:1096:101:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 06:32:16 +0000
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93]) by SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:32:16 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] erofs-utils: lib: switch to GPL-2.0+ OR MIT dual
 license
Thread-Topic: [PATCH 1/2] erofs-utils: lib: switch to GPL-2.0+ OR MIT dual
 license
Thread-Index: AQHcwmdKTPjZGgMAK06MV4q87bBPQbXLUBQA
Date: Thu, 2 Apr 2026 06:32:16 +0000
Message-ID: <051a8d9b-f635-4167-8a9c-6a9efd56226b@vivo.com>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8257:EE_|SEYPR06MB8288:EE_
x-ms-office365-filtering-correlation-id: d685a763-aad1-4247-22b1-08de90819563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 FVYt1j3ueDrqCF6Qksj1cBvOFYpQFplxM7oPMay8w+r4oZ+YmraC7JMIRB/XVi9BznT+VNQskU0k7wdFI2bV285ajZTvP0MrVUMQzHsGTqXsbUADLJs8LgjKUfAQXp1FV7m95K4dr0twMyi0aXWS+o5rHMgb+qyp4AGdO/Z3MEDr4mTS2nrDtnhqL6rJKOQOs02Lz8NCXdPoHxe9ceof5pYD9U3aioGej9TIJcNjNMsGbDaBo7nkuz3mNK00j0nLmE7qG5gjLZbdlvZVKj6KWrjI9sebZYVrgBfYcEhxS3ktnxDGBRhPg0fqbCEpDXrIkZaTpiIUC1VUwOw3mTsiiLtQCwgqNkE2tv1bBSuQFSIUqWSHNTayuMYbtaPGTJbE+0p/wTFGY1xiX9cu82dTveMO4h3gQhh3dwTz/aGbLuxMT2zCi1mYTeaH1BJF89ZNV0yyKwJGe0LCJw6zNm3NGOOZt+IXRCDcZgWsApjkR+QhMAhb8GW73fKDltg+LLJKrGQtZlfiThiNNwUFRSDG8vvXgFo05cBQSn9TA2tTUb1Ezmk3Z7xHI0IUrpmUDOmY9NCHqmJhSUlbRhIHcIaaKiQfOVhDFUEYg6z9oG3906KpMSS3fDyFB03Qsymv1fbNz7MNiB5ejAIvxTorsPI73UgtQaDXK6P/EP53fvWTLYcScbe63gYpLzTib/e6lhnOayebQPPU4MsUNGpFefpSo+/HqfBYq4ECqUE3al9biF3Go0WLEl6bESiz9g/VYAyrNF7KbbXgMHrRyQ/5NtrvnifTwXvM/PdLwIPRLxKIzDs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB8257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDFOK2s1VGtCQmRpUm9MZEJIckE3T3Z1bFhWUFV3N3MvaHFPcEpKL3Z2MnR6?=
 =?utf-8?B?bkt4Rm4wVVNQY0lPMFVubk90Yk8yTGxnQlU2dVRzWEtIcWNOZExiTThKWUVB?=
 =?utf-8?B?MXh2d2FJS2tFNmNBY1dLNThwV0dLMk5lT2dMZTE4N3E4NEhnREZZN0JyUXBO?=
 =?utf-8?B?K2ppU3dEQnV6OXpKcFBBM2pJaEpFaTBPbWVPR1grODFTMGVFb2k1ejNKTDYx?=
 =?utf-8?B?MERya3JyWmlaSzN6TlBreFN4ZUVnS215cTRHcUFVNmlrSlErWmE2ZDFYMHlO?=
 =?utf-8?B?MDhlQTlyOGxRVjVmRnU1MEZjSUNxNXUzdXlVWDNCbkFnNit6dG9HZmoyQXlD?=
 =?utf-8?B?UllqUVo5bFBiOXhlVDJHZU9IYlRjdFl2U2Z0NFQ2V0Q2QkRzcEN2SkFPSVNi?=
 =?utf-8?B?MzNTc1FZbnVkUk5waWZ3QXNnakE1R1RNNXUrNzkwNitJajhET2FnWmxNSTBM?=
 =?utf-8?B?RTIwNVkxMm5Od3JRSHJxNm95d050VkYxa3FCWXdvdDRZamhjYzYvZEUvK2tj?=
 =?utf-8?B?bXVxejZ2am94Tk9KejNTZEVkU1R2amx4SDJleitUSWhrOEZNSjh1cVRtaEQ1?=
 =?utf-8?B?Qm0rNGdZWFBvKys1cFBzdEhFMU14TE1HNkY1ZTFZQ3RsMk1aY1ErZGlxL1BZ?=
 =?utf-8?B?VTdKZDBwOEU0bHpJVnRwdWFzQm54cVc2TVdQM1V3RzhHREdGd25GWmNkajdW?=
 =?utf-8?B?VGYxNExQSHltcm9XSzFobkYvR0xCNlpVMVBmSk9uM2Y5eFo0QzRZWHBsZUdr?=
 =?utf-8?B?Z0FhS3R1YnRtR29sb3MzNUYzVm5XS0lXR0orbEZtYy9JTW5MVUpTeVVTcjBi?=
 =?utf-8?B?Y1pDdnptQlRDZGhMa21PSTEySWVFWDRYWTBFQnRNSllXc1BkVXNUT2c3c2hk?=
 =?utf-8?B?QmRPNVZZRGpWcDdSNHJ6YXcxTkZWSENTOTVBZWdFcm01OXY3MG41NGFvTERV?=
 =?utf-8?B?SUpQVVVwR2VQKzhzY1U4OGZYSFZlYVZnekFuem0xaTlScEhQNXM2NlJRem04?=
 =?utf-8?B?RzZCSmQzYi82VXZoYUhOWHZ4TUF3T1hFQTMxcWlBSWJsWm5TakRsckMrSGJp?=
 =?utf-8?B?VEF1aEVkdmVtNk1EM1hubHhIZys5Vi84UTBjQ1BZTXBqVHRhVE9lbExVbFVW?=
 =?utf-8?B?ZjI0cHpnaVgrNXlIMjUwQ2dmd25ERCtuSE5VTjlOcjVjSFJ5dm9aSi9pSHha?=
 =?utf-8?B?MnpMN2FoUmJXdHRCd3M3cW5iakVxVS9wVU9QZzhMREs1dkpoNkZGblhobzJy?=
 =?utf-8?B?dVRJa3JTOG41Yng0dnkwUTJGeGRYdGMxTEl6c1I0OEp3YVVvb1k3VzEzV1Ru?=
 =?utf-8?B?MUtNMitTeWdOQ3N6QnFrYWUrT095MS8xZVJmTWZjajl3cTRZZEhlQ3IzMDJJ?=
 =?utf-8?B?RlJlWnVTSU1Fa0x0eUJjWDdBQ1VXNkFqb1p3NCsvRlhOZ2lqemZGblJIK2Z1?=
 =?utf-8?B?cXVXcDZRaGY3YlhNVjRZdlBpYlYxZmQxV2RqQkVydWRyUE9HMzV4U1NiT0xC?=
 =?utf-8?B?TkxnUGJ4eWFBN0NnS1pIQXZ1REpZbkJUdkRmSFdkQjhtZU1FbWpFbDVXZXJE?=
 =?utf-8?B?Tkk4Zk5WTE4rTzV5S2dteUxSTkhrREJpdGl2akswMUt4bWM2NEVobmJtK2ha?=
 =?utf-8?B?dlRvZDNjZHY3YUV4WFZkMTNMWlZ1OHlSYVhmZWp2eHh5aDhxc3RSMml1MkF0?=
 =?utf-8?B?UmVCRGFQVFBvYTZldDJmVVd6ajMweVBkaDd0U1NsS0MrL3JzekplMGtSR291?=
 =?utf-8?B?Yk9MdjhwOFlwcW02eXhHVU5zaWFseFBDMVFBMEFLV2ZGbmxmTGFOSXExdG5Z?=
 =?utf-8?B?SXZVa3dTSWk3UGtMM3l6UThTS3diQzJ3a0NPUEw2T1ZtWSt2SFVUcXVvUTQv?=
 =?utf-8?B?U2hGL0YvL0x2T1RJSTlOM1RMS00yL245Rlp5cmh2eThzWVRvVHJqZUUvRHpj?=
 =?utf-8?B?b2paTXVMTk01L2FyUmVSUGc0RVRJL2ROWnkvUGxTR0Rhb1Y3TU4zSS94WHJE?=
 =?utf-8?B?bTdaK0ZOQUpJZWJwbGRjVEpEaGgrZDF2Z1l4SzRtcUhlMjdya0s5bWZTMVNr?=
 =?utf-8?B?cG96ODJMbk9HcmRkNHZ5d0JzaTFGdVFaMG1qamNIb3k4ZUZDOEJnaTNJbWJC?=
 =?utf-8?B?M2RXeGY2WWZ0U1A3VVNMYmtMQVdJREdHL1VtejVTdk5zUUtiQVBEa1ZaNllh?=
 =?utf-8?B?V0pwSEtUR2YwaStJK3RlaS9ZZHJYMXAzMUlidGJ1dkREU0p5WVZxOSt4bXQz?=
 =?utf-8?B?NzlyaFZkSFd6Sy8wVnU1RGxXVTBkNXYvTjFXeTlNVnNDOENKMlloSlRkOG00?=
 =?utf-8?Q?rir/On3o3EUhyaNnNy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1013834A5D1E664E8767F8C27552917F@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8257.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d685a763-aad1-4247-22b1-08de90819563
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:32:16.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skXTbOCi71f2RDQZSfDcV2VAiPLOHgBO2BjceA3OoVJPNueaIaE1rlbXSLu+wOPXJiJixOLlzUBxB2jFTDlbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8288
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3173-lists,linux-erofs=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0305B38482C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gNC8yLzIwMjYgMjowOSBQTSwgR2FvIFhpYW5nIHdyb3RlOg0KPiBBcGFjaGUgMi4wIGlzIHN0
aWxsIHRvbyBzdHJpY3QgZm9yIHNvbWUgM3JkLXBhcnR5IGludGVncmF0aW9uLg0KPg0KPiBMZXQn
cyBzd2l0Y2ggdG8gR1BMLTIuMCsgT1IgTUlUIGR1YWwgbGljZW5zZSBzaW5jZSB3ZSdyZSBhYnNv
bHV0ZWx5DQo+IG5vdCB3b3JraW5nIG9uIHNlY3JldCByb2NrZXQgc2NpZW5jZSwgc28gbGljZW5z
ZXMgc2hvdWxkIG5vdCBiZSBhDQo+IGJvdHRsZW5lY2sgdG8gaW5ub3ZhdGlvbiBpbiB0aGUgQ2xv
dWQgTmF0aXZlIGFuZCBBSSBlcmEuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8aHNp
YW5na2FvQGxpbnV4LmFsaWJhYmEuY29tPg0KPg0KDQpSZXZpZXdlZC1ieTogQ2h1bmhhaSBHdW8g
PGd1b2NodW5oYWlAdml2by5jb20+DQoNCg0KVGhhbmtzLA0KDQo=

