Return-Path: <linux-erofs+bounces-3240-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIhwDmCS12k2PwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3240-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 13:49:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F317F3C9DD2
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 13:49:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frysP5L9pz2ygf;
	Thu, 09 Apr 2026 21:49:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40e::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775735385;
	cv=pass; b=nNjOcXFDWyhlZSh8+eSLiCC08wTbnE5W9/aHPMpfNHoS8mTApRHSJoQ+eXhL8fZzKG2Vv5uH9OK4hW51uQKl/xpLkHikpPycjtugcAKLIQ3etJEyydbtNOi8Ywr36WWIPq5Z2A1VbY1c/2pJ4lFPOf/hyZRWsOp/4RMd6m0mwQnBEEYQ/hOGQu/wXTAt09HgF8RLvwqBq/oA/AhDqLR0wvTrDXNmOLPpG0Yd/LXUqMQtJA5ITz3WfwMY3E/7tfUCi0qbjKuh9zgLI2BzZNqU653YZv2Z5jHXickDRWZaDm7EjEz2+sYvGKxz6pvd7YL4IQIkkiOu8a18b95bTpjpxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775735385; c=relaxed/relaxed;
	bh=FF4Tjh3VTtQ7MufSpUucBUmE+xL/T3PYfH9uD4lvjmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDp40Udab0pG9Hx8U0taUdggrMLMDMOg1LhYkXVXeOMu20SLcvdbQtsZmTTtsjxZslKJ35+mzlkC2wGwqxNcqlGO+Ya0eFnrRXQdIhZi6LXLJ6bwl5iSLmoq3J6B0sdQzqy47ESGrMfBAAjut3N2ioRxq3OurXyP2aVXA3UxRuIgZuoFZHlIy45bhZYtOwQEv6pCnJe/LOA4ztYFVPmNWVlFy2s3RJLSggYybHLXKbC+VMV2Ukm0NVuzhwZWI1TSRqvbw30wa880NJFRf0siGNI2xYnVQ02LLZC/NU5oSFDXGm2Q9G5REG6yF5EfVGMguVDh/r0HE6nU2EkFG9hsLA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HftFO2wt; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40e::; helo=meupr01cu001.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HftFO2wt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40e::; helo=meupr01cu001.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40e::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frysN6DRkz2xS3
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 21:49:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/Qo6w11ijRyCOoWGJrutCiou206ZwBBJrL9S9izzbVqXkD+ToJDbRGfjCpaci8Pp9HcMc4zt6P3wh1o05K2zyE+R72RsGsfVRO3wEiJChszbhEdEw405U+U6ycTgcbR7YFcQNFAmOL7NCECXXe0H0LtoYNURUgxbue8sf9mE8q5WMzZz/KRR9umqRcAtfib012fMakfdAr80BB+iiJeUBdAtUuG0KDfm7SXMGX/ZNylU+HUUEmjq4z2d3RC3VYHkOZAgowPwmXBe3fIxzFza07brce/Qq6VyN8EwbJqMJ8CXIqkZA0/zGog/fFmSwbPA/OWEqHRBh0d64OsyavkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF4Tjh3VTtQ7MufSpUucBUmE+xL/T3PYfH9uD4lvjmw=;
 b=cFoeN6WdFis/J+0hKJB8avRbGkndwZVUQQwvjHwVMjdNtxLsSIr7YTOfpmDuQ1I2VWbZOj1xg4jsYvxnOY02lcQfjZU1yy8T6TzddZBkYLRF45ie6DicFiS4GwGCeZACxiagt1W7W5djSVYVfNsdyTGrqqasoQzOvQnYLYg+j/TlNuaUabYd4Oy+gSD7EM/4Ig8MvjT0I/WfXw2Blum09bm481okcEReY+Dj7njszkkrCPFKnpr+bQaqCqNURApxYnRQ+/ALrODAlJZe8Orffw3kKkoIJK2TtzbvmOWm5+UFHRETdyE6MTafZsgbdFyT3vITraXtcU/ydKPnDDupFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF4Tjh3VTtQ7MufSpUucBUmE+xL/T3PYfH9uD4lvjmw=;
 b=HftFO2wtv8u6aMPT4hhIi75Pqimr537KgrguTESEx2cT+lktvKWaYrpxRyktL6AFZbmsFTwqxDwBJqsRnjGQioKeBef9kyx3RcIc/PdeTgUJa4g1XHq1gl5NbVGFR633njP1ueNtblO3/Wm/E0o9TPFcwbhpZIyTvUvfw6M7CcqVX5CQ+epXODs6Evm4EBEOZkg2peQupaCLhQ/LegRp3Az+cvu76fWIELRMHMMYwJItDkRjQ/ZsGFxd8RXG9OWKgQ37Ba2pOVKMKHkoP9qVP8PUDyWw3fp+JgAkvApaIvrUlA7JngBGMZy0aauhEjDMZKVuKEkJLhI/t3CDsh5l2g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY5PR01MB10701.ausprd01.prod.outlook.com (2603:10c6:10:325::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 11:49:18 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 11:49:18 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo
	<guochunhai@vivo.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Topic: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Index: AQHcx+59WJTQzAOqcU+DqK3g7FYXK7XWVQWAgAA1IoCAAAUUAIAADqQA
Date: Thu, 9 Apr 2026 11:49:18 +0000
Message-ID: <1922A494-0E56-4E11-9D3E-3604BCBE33AD@outlook.com>
References:
 <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
 <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
 <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
In-Reply-To: <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY5PR01MB10701:EE_
x-ms-office365-filtering-correlation-id: b16c0438-d20c-40e6-c039-08de962e0850
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15080799012|8062599012|8060799015|22091999003|51005399006|12121999013|19110799012|24121999003|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1UYifuPmsOLf1YZMRCu1drfP2OA+Zy8/4URoKDLZNmZONx4TRoAxtwrO0wwu?=
 =?us-ascii?Q?YTif29O9q3M4ORhHtJz6BTLoRK2S9SQHXPV6xljy2oK654XOjPxetvH+F9gd?=
 =?us-ascii?Q?n5XyB/0r9pG0Xgp189WUWUqaJiyM+64cxpvCP7mQ7I/kBebxmXPxCDQpIMvF?=
 =?us-ascii?Q?+hoLoI4tqMNuJ0iKMVu/j9FC7YC7hLwpi3H9nmQuPASlZDofAMwqlhrcCKfd?=
 =?us-ascii?Q?iWZG1dhY/Ki61UEIuGtdLFdJW9cZB1lco6MsxjisMgeBMUtupDWYNTuBeLtI?=
 =?us-ascii?Q?RBXldAoaiTf0pdwBZ639qzIDeZAFA23GsKQEu335N8Lq843yYZTaGilyrYIy?=
 =?us-ascii?Q?SuCVr0YRIyOm3rDxPYombW/Xb9EGEu/mJh4tjrABJlzEEXuAo72CWjc2KON8?=
 =?us-ascii?Q?XfcMTbkhHRfOIjkHCFmiERTEvDqHsU5itlU/9+x388kzNXOxmMAkoCpsxoRN?=
 =?us-ascii?Q?17rENRO7u0qZUeuPfSRis1cXUq6LiLTXNgQzpsyZ9OyXfmy0ipCWC2NcEs+o?=
 =?us-ascii?Q?RBnUiInWbAI6rV155U34fK3nuPVl38zP33LxAfOAdiIjnWt26l/6Cbxykcut?=
 =?us-ascii?Q?qFArgz7+z4oPK5t39LT55Xr2O38ygf/dDvCIHFz4Xb1LJh3gQSEu3jLA100R?=
 =?us-ascii?Q?3S2fH1Ct3mVEZ128FE/sOoLZLb0HprNc0+MDGHDqpXrUvCVnYckXNLb0QgOX?=
 =?us-ascii?Q?w62uBTLNEM8hC1yaus4+zd69aHWEc/5qIdG2TFR+PvWXjc7keZSWwvxEsJs7?=
 =?us-ascii?Q?5y2/6uiBLk6YnAORlcY6O6qtHrQdrMNonwHsR5X2DDm2a/c4LFr/olcTnXxR?=
 =?us-ascii?Q?Z8MU7dy/9qSAGWv1Hg1K0Lbgd0uiGymPIieDjliWJGFFX36vNHWyvYdoQ3j4?=
 =?us-ascii?Q?Jz2VS+mFJXSiZKKmjkrx6HQ6VIuxYZR3GiRe5RWTMs06waxksTMdQwTsCNS7?=
 =?us-ascii?Q?XKPqePNL6eetonbdUOdvPL0pLarq4qgbDGSA2B7Gcwbgqnz0gcXBQL/QbbW9?=
 =?us-ascii?Q?G5f/tnbI7ndxPXK9cvNlTjHAgF0YtFnrY92tP/mUZKc9YoY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g1O33TwF4eJSjs5WWcrW05KJpOM0tFr81eYLNBK+PhlBmvZ6PNilW1k+iAn1?=
 =?us-ascii?Q?pIKeXT//ATY+u077Z+0BivY0flbKOsLlS1cK892+hBk2K1GlmUPUoFL3IlpW?=
 =?us-ascii?Q?BrcC0PZK/ka8WkDamnw4wZSgCDt7nuOj3ZXkmc/cZ0s0E1+gt+xQyOL8k7uw?=
 =?us-ascii?Q?Q3/gBxwe6M7zDy0XAY+l1DyBVOJtAlyWAsyl6asjRgfa9tgVbwV7dmTKhBsc?=
 =?us-ascii?Q?RBF27EbVqzfmC1mdy7TZaZsY1xBE5ZArLZPWETsyic6cioBsWKRzfzDJlLxp?=
 =?us-ascii?Q?M41Gtiyz74anJDPqnrdtsRYYkFNp0kI/m7jV+kh96zP5Z4FWErbGAOy9GV62?=
 =?us-ascii?Q?PBhE8QYEmt82sDTW8GCtd5tisI/CoNH+WcQZOoYslMECsRAz800jCDlKHgfe?=
 =?us-ascii?Q?6EhPmREuYB+Iwa4biVgbyMdKC9fe8DAS+I0C6po5XoxCuVJFa/dlBdVwgzJ+?=
 =?us-ascii?Q?jc+OBiUjp+Yxo+7dbPomPh9XKTWY17eosZYJtLLAILnmSiRdEIl92qO8iv8T?=
 =?us-ascii?Q?S/3XVqvFrT6pfd2IosUzZTU4rg5gIRYNUlQVOuS6u+8LOjk5NRcGxFrYWNd2?=
 =?us-ascii?Q?CosnZeFHR+p3QsbivCtc9/ZjM7395jz1UQhfOpdraqx9Jryt0o6vddNOh7fS?=
 =?us-ascii?Q?5FUyv6YvpNQEU6NkPHTghnVLTEl/yZvZeHp8UB7Cdu4M/0C2ejQKzLUxEkOK?=
 =?us-ascii?Q?iw+OwjjL0oPsMMa8fxKRowi1q3Fwgkx1ob3gxxpD1VjlzQiVNlpyN2ON6UDn?=
 =?us-ascii?Q?p90BKu7sDO/OB7f/KjqmmCnNWjSqS0whAmIFjkMc0T1I8kj41Ns2WEp+S69t?=
 =?us-ascii?Q?zRjRLFMtf1U7ZVb5LkehrNRtitcM0ZX1Uxy6CtDxQ9Y+7eV5/N6pwsd0iXBV?=
 =?us-ascii?Q?VIQoz3reJT3EmlprKvZO13JnYmhqRhJGxvrIoxUGP9QFZHoA7roA8E+GP6eD?=
 =?us-ascii?Q?PKdO56gLIaL5v+4D5go8YyPhGQtQ/u0aDbYuPSka/4BgMW6RnRazfk11wQrd?=
 =?us-ascii?Q?pphRRyY4RNUpy+LCOFZ2UCyOiHZn1hxudEuFxhUzGgReg1A5zwXD63VUjpLD?=
 =?us-ascii?Q?yqdPz+AW45IhJ/x+kde3UVfLgYFa86URegiDC3KvQTZOCF2xTBWpfBFKfyWY?=
 =?us-ascii?Q?AgQqxuRsDAbLl+OubNnmUn2NlA/3DW85Up/HDzOirYvm/OP8G4bG4q5YOspw?=
 =?us-ascii?Q?SLOjWTDZ+c5Nnl4TicXz3D8isl5mH1KsUYaS9IiVwuGH68vNF6FlBFC6KX2e?=
 =?us-ascii?Q?0d3Jq5Ow/Q3kVYMDVZpJ4qTKSUajpF5RgRJFSwn5Tc3GBBsGXCI99Ef27baX?=
 =?us-ascii?Q?Q0NPerVWBJMLN6yjzr0TI3gRv6CtsrTaMyMr9IPa1Mz0vapcMyPpCbZ+0rwD?=
 =?us-ascii?Q?RNbNUpRS66UPhI7P2dYxFgrtVQy7GhXEDkZ9oZtzr3hPh7lsLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE67D951B7ED21459DA316FCC8E8FCE9@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b16c0438-d20c-40e6-c039-08de962e0850
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 11:49:18.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5PR01MB10701
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3240-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: F317F3C9DD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 06:56:42PM +0800, Gao Xiang wrote:
> Can you share your initial crafted image binary
> with `gzip -9 | base64` encoding here?

$ gzip -9 < /tmp/erofs-test/test.erofs | base64
H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+gdil=
S
Jo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9iPNtbjha=
n
04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz2DF/21+20T/=
l
dgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1wywAAAAAAAADwu14=
A
TsEYtgBQAAA=3D

In QEMU:
$ mount -t erofs -o cache_strategy=3Ddisabled test.erofs /mnt
$ dd if=3D/mnt/data of=3D/dev/null bs=3D4096 count=3D1

> I think the proper place to fix this is in
> z_erofs_map_sanity_check().
=20
I will resend with the check in
z_erofs_map_sanity_check() instead if the reproducer is acceptable.

Thanks,
Junrui Luo


