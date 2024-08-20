Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73996958244
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 11:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724146290;
	bh=9wNSX0oU1JdP24ynDz1PI1lYylExTGWzWfgAlLpGd3g=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OgQo9gcv6SsfOz5Ce1INbmAazcX1V5Mzk47Pququtrsn1v5JAfw6FmxQ2/DaKRsjW
	 Va6o7POOZabbaBxaC/4aid85BWzMFSVo1pntwk6t0CULjXk3UU/aHnUt99MzbSdaqU
	 UjWGbceP5XrHXt2tmSNtc+o6nVU2V1GYFfF4vwOdRs96LFyrXUMKopAEV6DVuElh7E
	 kHTHpToYT/B1eR7+ZxXpOYC1mHbZX1X2aqCOidkqObT2+jAf+mz9QzH2roob2UbgsQ
	 m+5fO0yEbZvTKC3Q5aAddLG6lNk4YQ0DP2h/gVlAJ2mcefIsct6Zfh+5lTcFJBsKv1
	 g4mpkpXd56Y6A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp43Q31Ymz2yF0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 19:31:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f400:feab::612" arc.chain=microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HzeCyCUm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::612; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::612])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp43P1TDxz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 19:31:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdMxOzwdChfbf4RIFlcRV1HqnpA5QM9DH0erLajaZtXdYHluOW7sabF9nTjemrI0kjV/OtECx42yygeid9S0z1NO3zW2h5zviMPmU2615U6tBHOP99z1wUCy5KFaVCAIXyHc7B7UrxLXrt/KR9MOgvyX9E/TURCX9Dns6p0zyOe6kGhoqr0S4TED+BCsZsAGhAg/EQO0jt+5SVyfYuroIrtvJpmi5moGjqKB6eh+y45dWCiXSc6cE73azkreQUS6wCLTBGmmCUE0MkwdBccQIAhsRd5+nXRwgaK80NiACFhLu8R6dAcEtDgP2DjWtG734+Loqgt8QfN8Mp8nV74ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wNSX0oU1JdP24ynDz1PI1lYylExTGWzWfgAlLpGd3g=;
 b=fmt9QxVRTbV9/UoqL0CG7qI4zRQooBE9Q9C1CIIbYcaICOOnvIx4TPf72hsHlYoFBKuANssuSWSjbdGWk3Rb+cBi1JL+TVYuYVJl2dBhODXv/PKdTSG99OUPhzFiQbEw2J/JYsxaMXLCd60Lj6LJvrPbvFVrkBl7C1wqiPoCR4NyJJrdlusrpWTlJAlcpAMJgtE2sBBLUd3hm8FjHIT7W6V9aSgcEl4Nq80Qwa43kuB8c4Fp0W9Yx2Hh0qpKuWezSsJ+3H+uzDNJV9mip0ixXKzmpCgjh6yZ3XFDEewFtmBMU7utX7ijBNI4KrcCEAY8ZaM1k7fhsiXm4lbkq2mDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wNSX0oU1JdP24ynDz1PI1lYylExTGWzWfgAlLpGd3g=;
 b=HzeCyCUmUcZU99Zorvi9+RZyQiwh/XdQTCYmS6Fg9tepScrAesRpM4AfsSK+Ya4tayUf14gFrB6SQ/FWksnUmSeBOlIOyGs6+FWJvfK2Bb+Dem40VAxFygzjlctcSRvSiI/j+NrOKahTa/JUr0DVOAlyW7aSv0VWhuKDajzmOA4QhR72r9B5FNRRI1636VEEYNid+fzIZ1vY3M3Wo/BWjhOr3RrGyZsclbSlzjl4hV3835WIWC7qwT4EVRDvdp8qA4LCxvaJicezFbCSdgLqQ8YjF8UXQ3S/RF8iNdtF8F4sn/vdySGoe3QDaGv0uKeHHp3wvKE32Nj7TO+dqIUeLQ==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by JH0PR06MB6477.apcprd06.prod.outlook.com (2603:1096:990:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 20 Aug
 2024 09:31:09 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:31:08 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
Thread-Topic: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
Thread-Index: AQHa8tz08HbfeeaA0U6v+SOJ6gjPXLIv4BIAgAAAe4CAAAEYAA==
Date: Tue, 20 Aug 2024 09:31:08 +0000
Message-ID: <b7daa5d2-438b-4c8e-afce-968e3d20f95f@vivo.com>
References: <000000000000f7b96e062018c6e3@google.com>
 <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
 <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
 <c2a0cb7c-3858-4872-9d11-f620df03d476@linux.alibaba.com>
In-Reply-To: <c2a0cb7c-3858-4872-9d11-f620df03d476@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|JH0PR06MB6477:EE_
x-ms-office365-filtering-correlation-id: 1db9e4a7-b81b-41ae-164d-08dcc0fad2b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:  =?utf-8?B?L09Fakt1KytZS2ZhbEZuWWVlem44VXNXVHZna0lkVkdpR1MyM3lpN1d2a09v?=
 =?utf-8?B?dW5FT2tHUDNjM1ljQlpXbkt4dXlSVUFxQklCWXdhSHFsVCtvL0lHcmtvWjhV?=
 =?utf-8?B?QXp6dHhoMUFQbG9jNk5QSzVCRHFHV01NdTdRc1c3Y0pwYVR0RnpVb0tzUHZm?=
 =?utf-8?B?WENIODEvQkc1Q0c0TUZkcmFHQmI3eXlnd1VoZ1R3cVl2N1lYL3dOVlVObHM1?=
 =?utf-8?B?eVNjK1VYaldOK3R4c3JHV0FnYzdQWi9sbVpsclhXdmh6ejY4UnRsRzZsWTRG?=
 =?utf-8?B?QlFJcmJ0SGRlTmpnRGxrUWl5bjJpU1FNdlM2U052cHFqQjZKb1pyTDhhcHRq?=
 =?utf-8?B?SUQrNnZnOFVMMzlqc3JZenFRV2NuWnJ0YVdkMEh2MEtSaXRjdUJ4SWJKWGdQ?=
 =?utf-8?B?TURJR01nYUJ3MFpEMjZrcVpKK25ob2craVd5WGVTdkw1emNXdm5ldUk2amEx?=
 =?utf-8?B?dUtQRjlUSHpqZnNaTWE4Q0U0U2Vqdk9UVThoVHA5U0tUb0N6dGNpRitncnZM?=
 =?utf-8?B?NXVJS0dhTlVrS2ZmS0VTcml6VlZLVHdjRmJWckZ3MTU5UncvWG9RMkl2Nmlj?=
 =?utf-8?B?V0ZqaHpaTzhJWiswTHlSUVBRNEZzcmtLTXJvblZOWFN6eFRwdjJGYWZwaWYz?=
 =?utf-8?B?djZOTlFJQzE1WnJUYTA1QVVVeDBwVUVWZk5zTEo5dXpKL09XdTdZb2VNa3Jl?=
 =?utf-8?B?c0c0ZHhzdXNKUzFPd0NMaWd2bHNrNzFvblNORnJoWHJvWnN5L1kvZU5Ld3ZJ?=
 =?utf-8?B?UFRYRllYL0I5OVNMeHplSmhjWUVDckNHcWgyaG1USGU1cFljaFlrRUtTbDVZ?=
 =?utf-8?B?S24rMStVS2pzZVNwR1NZZzQ1Z3JVWDJWOUlvU1hmVUlETzROTldXOXd6K2RV?=
 =?utf-8?B?N3dwTWFtS3ZNdTY0OE8yTWcwUGtwZWVUdlFyeU1YZ0hONGdjYmltZHpVcE9F?=
 =?utf-8?B?a1FDV3FVL2ZSSEs1VWtiNGNuRFlnbG41VWx0NnFSeXB3MDVJVHZtWHZNcWRz?=
 =?utf-8?B?N1FRMlpib1ZqOGVtdVcvL2V5SVBPUVcweVAxdWRXQUprR0FVUlV3ZEdlNlZV?=
 =?utf-8?B?SSs3b2F2dDlTSmJiV1RpZHhialAvamdMbEQ2MGVzS3ROS2laSC9lelE1Y0pL?=
 =?utf-8?B?R3M4RmpiUjh5YXMxbmhxVFNIelhuRnpSVXFmRk9wdHhXMGhacXNuMHRYRWxS?=
 =?utf-8?B?MDAzYWpndzJJd0oweGRaWi95UktudlFFd05pS1FBSjBvaWlCVVhETTl1ZlZB?=
 =?utf-8?B?RC8wbnViMTdzeFd5R2EzWWpHYzE0RHBGZG0rdVRGaWk0eUdGbXd6RVBYcERW?=
 =?utf-8?B?M0w5ZS9VQmFBdTc0QnZZc0JmcDRLM25ZSUM0c2lrR1RsQU11cWx1cnJ6bmxJ?=
 =?utf-8?B?K1Y2Wi9DK1RkdEdLcE9NTStOTlBMQVI4cHVDS1hPTkhxMmFTZmxEbGNkWFlD?=
 =?utf-8?B?a012eVd1bFBjcmRHRUhNZVBRb1krbW9ROXA4aTlOTkNDK0JpOWlsbm5abkJ6?=
 =?utf-8?B?L1dmVGgvd2dVbjZmbU5lZjRLUVozeEg4VTdSTkJhRnorZ1lYNVNFbkZ4bkQw?=
 =?utf-8?B?NUdyM3ZDSFNOUmJRSGVWdU1pZHpKQStWN0dNcFgxVmxNcldOdzhnUUJscjN0?=
 =?utf-8?B?SjVYMlpRMUhsNjdGalNkRGFWL0JkWmpKRU1KZ09BOE55NDFuYnNZMGIrVS8w?=
 =?utf-8?B?QWNXUzhpVDB1aWJNaVh6YTFqeENWeG5mWUlGU3hSV1lENHZ6TWExbExDRWFK?=
 =?utf-8?B?UzB2TVBKeUFxSlE5QzEvN2E0SllMM29GelJRRlhRblRyOS9iWE5QY1dyN0FZ?=
 =?utf-8?B?TU9vRkdWTGx1L1dtTndadWVvUVhZQ2U2S25kdFBPditwMHIwLzA3OXdnc2dD?=
 =?utf-8?B?R0dVNVFDR0J5b1Q2WkJCMVFSY3dBcVRpaE01WlU1aDcvYUE9PQ==?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TWU5U0xwaUFPVmFqaVdBaUNLZTFWa0NsR1dLeUJLREN3STIzcnRnb1FrbWpt?=
 =?utf-8?B?KzFVYkZwblJOb0gySG1tdVQvQlJsaVdjRm5oVTV2d2VoRnR0T1RGVEYzWFpl?=
 =?utf-8?B?blZ0dFVNaG9BNWxPUzdqQndoUUVEQkx5ZXpGNmpCWkdiLytQU2FIQVVCbTFK?=
 =?utf-8?B?WTlLTTYyNWlnZmZWVGhkV2ZNSGVlWTd2YVpJYy9icU5UM1RiMStxM05OeTZS?=
 =?utf-8?B?MlVEa0J1K2N6aWlHZW02VWlDLzdSSDl3UVpxNEdTdE1lUUVQU2pCT2RCWFc4?=
 =?utf-8?B?UWx1SHE1amN0dFIrN201aEZzRXkrV0RaZmNEL3JETFdCYzhWZit1V1BmL1ZG?=
 =?utf-8?B?bjFEcXhCWmtIeEI0NHpQZkxuc1dNRnFOSjhNNkNwQXduMlRZeWNtMlhRcWli?=
 =?utf-8?B?WE8rRzVta0pTemtTV05RWTViSXdON2gzZTYyRWhGelBQQUZPbU5Vc2tTTlhH?=
 =?utf-8?B?MXhITHdHdy8zWVMrZlpDbkxrTU1zbTZKUlVTMzFyT3pxYUUyWE54NlNOUEVt?=
 =?utf-8?B?ZEVuUW1LMER5aEtsM08vTzFRY24xN1Q1akJIa0s4QnR3MlJFNjBiSDNGZHRZ?=
 =?utf-8?B?Y0hTUFNUcVppSkRGQ2hoeGt2OW56dzFkcXRKU1RxWXZ4Vlpnc0M3R0xlcmp2?=
 =?utf-8?B?eGhsN1hoOGJuM3ZDWEEwWjRSa25KWHpNREJzczd2QUxwVmhYMEN3N3NTTC9I?=
 =?utf-8?B?Z2I1OHpWL3V6OWFtL0k5dW1kWHFsYkFDbGdqZmdZZVpXQVRkNXJtZnljL2RI?=
 =?utf-8?B?dDZhcmVDdWh2TUFEanozelFpZEFlZVI5NFB4ZXpDdXIwUXdwbXl5R1plc3Ey?=
 =?utf-8?B?SW1YREJNVzhNdzE3K1o1bml5dzJNTUo3UEZ6alQvekxCNDFyRlUzN055bWYv?=
 =?utf-8?B?Mnp4WnhZRFBmZEovZlRhT1czaTc1TmVjWUJEc2h0RUxIUVRoOEJXenoxaDJp?=
 =?utf-8?B?WEkxQ0R2Ylg5cDE2QkxPNkVCd3FmUjZvZmRSQTdNZGtBcldZZmJXbjVZTFpn?=
 =?utf-8?B?QU1MSnpqRVUrWS81QWN1YVpibE05TWgxNG9jU0FXeVA2ZEZGR20xREZpcFd2?=
 =?utf-8?B?L3Q1UUlDTU05NlZnTGRhcml2ZnhDNnZOb2JDY1IvMkUvaURhSk5vUE1KSVpO?=
 =?utf-8?B?TkFyRG0vQUJKcEdod0xwMTIyRU9CcWlaN3Jac1RHYU1tK3pzeS9kd0FKbnRx?=
 =?utf-8?B?TzZJelBlYUxPaEpRNVo1ZmFaVU92Zi92Mm16SnNJdHdUSlZCMUJaTnR1SDJH?=
 =?utf-8?B?VWNFSm5hTkRGRFE0ZExjR1lOMU9yTVdGS0xRT01pRXU4Qjc2STJ3Qkszc0ZH?=
 =?utf-8?B?b2c1WEFSUnQrWWF1L2UxdG5kaWszTUh1QWFKU08zT25ITHljcGdsYXBPdStr?=
 =?utf-8?B?c1lyb0RCQS9VT0dZWTEyakJsZlVMQmZBUjJpNXhFdk9rMTA2aFNQSTZaZW53?=
 =?utf-8?B?MTZ2bmhCWnAxNHFtYmNYMks2VWhTV0dHTWhUZ292NFFJUWVZWDdMYm9BbllC?=
 =?utf-8?B?a3lyaXJrSGpvMko0R1dUczlkWTdXZGNBMWE0MjYyS1NuNXkzdWw2QmxXQkg1?=
 =?utf-8?B?WjE0V1Vub2FzVWwrNTdnRHNtK3BiWDNYTk52VVBHWmlVc3pjbzRFa3NCWFI1?=
 =?utf-8?B?VVpFaWZWSkdSTy9LQm9zUHBET0xxVkoydnZwMDJoSGZrOUl0MmtXa09ibkFS?=
 =?utf-8?B?OVdSU3M3eXEwT1ZNRi92Mkg2cXlEL1pMVzRUMVk2a0Y1UCs1cjlWRWJ4V2U3?=
 =?utf-8?B?bzgwbkRXZ2h3cjN5ODJPWHovNkRUOGVIdEM1UHlLZjZFeXZLN3o2dFdLVHlw?=
 =?utf-8?B?akFKUWlYSEtTY1A2MEV2WHVXb3ozeDl5Z3cyQTRSR3g2dEpHR3dkRWRBSXNT?=
 =?utf-8?B?bFByTWkwdzF6ODFmUGJvU3I5QUt3VXBMbm1DMmo4aWVFRmZHRUx4aWhRNCtG?=
 =?utf-8?B?WUQ5bHVyZHhtT0c3SGxEdi9TT3pDci9mbDYwZnhVMWdrTFdjRlBraTVVb0Zl?=
 =?utf-8?B?RWpYTk5paWtCbHdzd2h6SURtTG1Ja1l0VXNBcVd6TTVPT2VtMm81YVU1Q3Zi?=
 =?utf-8?B?RFMxY0drNU02VTlMWVlSWFFQeFZEaTdQY0tLc3dEclZ5VTRwZFVyOXZkNnB6?=
 =?utf-8?Q?wNEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D77DBEBE60C2A44A69A898C7ADBBB40@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db9e4a7-b81b-41ae-164d-08dcc0fad2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:31:08.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIP7ixKM9s8Gy5xojQo5WTqpUGNEfspaZ9U9yZbThlww4gwLCVXM7k+P9hADhKZxmxl4fi2TgCigMCI/389UVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6477
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

5ZyoIDIwMjQvOC8yMCAxNzoyNywgR2FvIFhpYW5nIOWGmemBkzoNCj4gSGkgQ2h1bmhhaSwNCj4N
Cj4gT24gMjAyNC84LzIwIDE3OjI1LCBDaHVuaGFpIEd1byB3cm90ZToNCj4+IOWcqCAyMDI0Lzgv
MjAgMTY6NDIsIEdhbyBYaWFuZyDlhpnpgZM6DQo+Pj4gSWYgel9lcm9mc19nYnVmX2dyb3dzaXpl
KCkgcGFydGlhbGx5IGZhaWxzIG9uIGEgZ2xvYmFsIGJ1ZmZlciBkdWUgdG8NCj4+PiBtZW1vcnkg
YWxsb2NhdGlvbiBmYWlsdXJlIG9yIGZhdWx0IGluamVjdGlvbiAoYXMgcmVwb3J0ZWQgYnkgc3l6
Ym90IA0KPj4+IFsxXSksDQo+Pj4gbmV3IHBhZ2VzIG5lZWQgdG8gYmUgZnJlZWQgYnkgY29tcGFy
aW5nIHRvIHRoZSBleGlzdGluZyBwYWdlcyB0byBhdm9pZA0KPj4+IG1lbW9yeSBsZWFrcy4NCj4+
Pg0KPj4+IEhvd2V2ZXIsIHRoZSBvbGQgZ2J1Zi0+cGFnZXNbXSBhcnJheSBtYXkgbm90IGJlIGxh
cmdlIGVub3VnaCwgd2hpY2ggY2FuDQo+Pj4gbGVhZCB0byBudWxsLXB0ci1kZXJlZiBvciBvdXQt
b2YtYm91bmQgYWNjZXNzLg0KPj4+DQo+Pj4gRml4IHRoaXMgYnkgY2hlY2tpbmcgYWdhaW5zdCBn
YnVmLT5ucnBhZ2VzIGluIGFkdmFuY2UuDQo+Pj4NCj4+PiBGaXhlczogZDZkYjQ3ZTU3MWRjICgi
ZXJvZnM6IGRvIG5vdCB1c2UgcGFnZXBvb2wgaW4gDQo+Pj4gel9lcm9mc19nYnVmX2dyb3dzaXpl
KCkiKQ0KPj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA2LjEwKw0KPj4+IENjOiBD
aHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2aXZvLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBHYW8g
WGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCj4+Pg0KPj4gUmV2aWV3ZWQtYnk6
IENodW5oYWkgR3VvIDxndW9jaHVuaGFpQHZpdm8uY29tPg0KPg0KPiBJJ3ZlIHNlbnQgYSBwYXRj
aCB0byBhZGQgbGlua3MgYW5kIHJlcG9ydGVkLWJ5Lg0KPg0KPiBJIGFzc3VtZSBJIGNhbiBhZGQg
eW91ciByZXZpZXdlZC1ieSB0byB0aGF0IHZlcnNpb24gdG9vPw0KDQpZZXMuIFRoYXQgaXMgcmln
aHQuDQoNClRoYW5rcywNCg0KPg0KPiBUaGFua3MsDQo+IEdhbyBYaWFuZw0KPg0KPj4NCj4+IFRo
YW5rcywNCj4+DQo+PiBDaHVuaGFpIEd1bw0KPj4NCg0K
