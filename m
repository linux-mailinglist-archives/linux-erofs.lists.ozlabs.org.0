Return-Path: <linux-erofs+bounces-1285-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBFC047E8
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Oct 2025 08:30:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctChX5grWz301K;
	Fri, 24 Oct 2025 17:30:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761287452;
	cv=fail; b=h4uxLiM5eXVjnuXjA2aMy6GcycysNKS1Yql1j8ytx66P9lTVkj7RQa2fFdugjLiuxJgOkQ2FvpUz+4HocZEjVaDerZuGlcYGl4RoK3QGS9XF1X5TSJOb01tlmn9g4maXR99HgIoimM7CHDaucb9cfZ/c9qG8LY5ukhoy7HhoyBIXA8mwvVkelEJtkmvI24evKPhFvqpEAbE5KlSpt2BCVTwXc77PhQO4oxgJW++NKTqfDsUiojaaozr9xrItbgMUkKkZKbFiFwei5F4sxiuAtfXrqYlqiHXYjzluaEyBYF2/XOkhkQwJARVmNebcFpzn0EsR2SK68OQLH52u1KtGOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761287452; c=relaxed/relaxed;
	bh=l7xhir+GEalOt2mRVsews3VX8jrW58FBjYIDee8ZG80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MhC5Xf6k6x6GiZCG3Nv0W68EwMHxxxbUtzUT/ISCF1uktRfWmM/LzoUrdDieztfryk4ZNwC7Wi0+TY2gUwPIsRfmlUcySc2uyTjdu2slOTOwv/doTBBx434bORaJ+32ST1DrqN9BUhnmCDZ8b71X+Lsn1iZ0nmTo6Hs8uNmvep0aw2hyKkl3svmPE9WtZtbTIyAu88gB4ZnaeogYMvhc4p9A31HuPxhetXlXOSBNNJQncnbvBj3NTc12GV6fsEjdLrBAsf88NhTOzAeGIkCIMhc+itzwt+/pXY1+7A2WiTC2M8Yz/2mLFMCpj4n1APtgwCXPO3xQ0MG7byz5awTeFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=N3YMCF6V; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=N3YMCF6V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 669 seconds by postgrey-1.37 at boromir; Fri, 24 Oct 2025 17:30:51 AEDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctChW3xk8z2yjm
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Oct 2025 17:30:49 +1100 (AEDT)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3LJ0e004450;
	Fri, 24 Oct 2025 06:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=l7xhir+
	GEalOt2mRVsews3VX8jrW58FBjYIDee8ZG80=; b=N3YMCF6VBOiMNqn6p3OGQ0B
	qSXwUBydR1Qw8SHipwZZY4ddDQdpJBJbSO+jhDfMj9/1ryFQjU5g3lRMwpeNbxHd
	2M6Nl6FkuekGjQ/HafKWUILnUq1Vy4s8Ix1PqSkHz6A5H0LJxV0GVM49oORssyh2
	WtuYg2vQAIvcVfsFOrVdwNnIlu6HvImW3glHII9dBsXTmH0eWfGDx32qo/TE5i1z
	4KSM56qN32oc3otsTRS+rOrr8OfS1EoWU85qXdYRSN+d1Bzm4UWdheU8N3GzFWC3
	lQXT69g8I4y61g4RTPI+mN5pBRBjJrngdrTQaYAygOovTKvwBZ2af5lItNTykUg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012051.outbound.protection.outlook.com [52.101.126.51])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49v0smewnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 06:19:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZJ718tYUt8twJltlsaJjZjWauv7/6uws+v9xHw1nXadISa9bFvzJxBywTOqxZ6pRpww9Ca6R33Q+qYdd8Ump7aHaW4/YOwOOfKYC8Omp76JazEnQa3LgN1Z+UwVSxV3bCqMwmUwJJpLYsqU32CLaEskEoVAP1XpA48HwNK9ftoPYR7MBZXkwzMqRJr0iog0G9o1L/qCp2YZGXUv0lpv0UdbjAbK1Q4DbhLdvMZD41lUg4XQCsh9QjBylw1ZehpT9hc31wB5kvtGxaPaXRiJ6G3Y0D6yHwCqowNAbJU1+ZxeOtT9ivo4riHtwnbw7s0nMUVUNnnpUuuoj7sMPRBTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i40h4feyca50VfYM7FZmRXHtcvB2wFXh3cuwLZJDn0=;
 b=KNXtEGRQnTdOmSsP4DiTzICd/Jub1FkOEHlFeqy0GzikQ3Xhuv6gpxGSLxv+Pyn+c8kK0ya14OyDZjy4zft7N2qlvD9U+/G2OlsJBnY/qeBr9K54grVVcIw89Y/ys8+muYQyM9d///kkgu0z69n/Q6niYa4bk5w1nqZy1j8J4wR5X93KoNq1Vts9UcdtGBDsamuFMIxjb81Hf09qP52VLzg/HZYsRY90cRfwZlwiC5bOnrYSLViiHlVhndLNe/fxR2tFGEmrmMYnrj1WA03TQzQsy9XwrsQJgtKziIKKHdYQ9h+Ol1qNYjjjEpl5UaM/fMt7o1KFWxC7nvSVZZhWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEZPR04MB7408.apcprd04.prod.outlook.com (2603:1096:101:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:23 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:23 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs-utils: mkfs: Add 'no-deduplication' option
Thread-Topic: [PATCH v1] erofs-utils: mkfs: Add 'no-deduplication' option
Thread-Index: AQHcQ/O1jxBYQY7n5EiFddCuEDlHhrTQxnIAgAAN0ZQ=
Date: Fri, 24 Oct 2025 06:19:23 +0000
Message-ID:
 <TY0PR04MB619177DBD987B5F35612C71FFDF1A@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20251023080142.991914-1-friendy.su@sony.com>
 <05bc66ff-1afd-4ff5-9e3a-330138d330b3@linux.alibaba.com>
In-Reply-To: <05bc66ff-1afd-4ff5-9e3a-330138d330b3@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEZPR04MB7408:EE_
x-ms-office365-filtering-correlation-id: 6575fb63-ceed-4e47-6425-08de12c5465b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Um9mVUVNbjUwc2Rvejk1SS85dnlvVkdpREdWalYxeXZMRkRxcmlGdWZZRW1W?=
 =?utf-8?B?Ry9NVnVHYXlwa0dETzY0WkJlWmkrL0pEeWw1aUFuV3pTSTVSVGZKc3F4Q3Fu?=
 =?utf-8?B?UlJ1MFFwVnVJSUs0Rm5PaXlPZnAxc0VXUURFSW1oQnRWR2NUSENaV3BNWHRI?=
 =?utf-8?B?YnBoSGpGUzJxTGJvcVc0aWVLT3YzMWQyYlpBNDZEUFIxQk50MHJWaUJRYlBi?=
 =?utf-8?B?TUFFRTM5bnd0ZFVwSlRaWmc5OFRadm1nQXFLclQrdjhNcGxkWXU2QVlPaU5V?=
 =?utf-8?B?eGJSRzNRUUZpZEhvcEVFN0paaVRvOXdmckJ6SmFjQkJZcXJXbGY2ZVdlM20r?=
 =?utf-8?B?bUVENUgzOW1vVmhnclBiK2ZuLzNMbXRIRXNMa3dJaWVRa2YySlNKN1VtRXYz?=
 =?utf-8?B?eFNjM2xFWFVrUWRCL052TlM1R1JFUkFXNlA0Mmh6c0lCZkFybGw2dTh2SjhK?=
 =?utf-8?B?OHU3YzVTZWN0OWIyaE9Ma0FseGxkWHhPb0FITWV0ZkoxZUIveUVFN2QrZXJH?=
 =?utf-8?B?TUNzclBmVDRwSE9CYWh5MmcyZldLUk9NMm9CbkpWTFhvZkd6N1VRcVgxUzBx?=
 =?utf-8?B?T1pwcjR3L0R5MGxrb3hjOTBiOWtlUm1aM29uNmluNFF1bUFkTWw1L2lMQmdz?=
 =?utf-8?B?bVN4OHNzV0FkRXROcm9TaldudW80VHZaMTNQS0ppMllNQkQxS1p0RWo3T21r?=
 =?utf-8?B?OXFPQ3M4dUxNaDh5cVNLNnIzYzBLYWczZFVVSTF5VEN1UCtUMXlGSEgvbmRr?=
 =?utf-8?B?bXhUSDZhLzRnS2J6Qit1S1RTRytwSTB2YzV2Smo5bWhobkl2U2VmZFhiNWZG?=
 =?utf-8?B?N3lEaU9qbDNsMHAwekRrYk14Qk03NmpTN1E1MmRuQm0zbGREUytzbzJ0Q1d6?=
 =?utf-8?B?VnpmclZYcmZscklpZGJXaDVKMHNaTXVpQVJlUVVhT01CMnBXcDBkQWljNDE3?=
 =?utf-8?B?ZzRWd2pqTFZNMEEyTHJja0dBK0tRVVNHdDJob2NaeEdmZDlMSlppVWxDMk1T?=
 =?utf-8?B?S3BNSjVmTjhqdVBwRExDSzF3WVpzajNNRHZCNzc4ZTBDQkFNT1hOblpWT3Bj?=
 =?utf-8?B?cUhyWmtxU3M3YWJPeDdvQkRHU01QZy84UjlXakRTMUpuK01NYm1NVzNGc05Y?=
 =?utf-8?B?NHRtTTc2YUxkMHkxWHV6RTFabEZWVGhGbk51YkR0L29Bdm9aNHFYUDZLaThB?=
 =?utf-8?B?UVdxVHhJazlSMU5TNXVTQ3hhZGlXb3JXWHNRV1ZiOEdrWFdNSHpTRHY2MGJk?=
 =?utf-8?B?TDQ5WVY3OU90Tis3TE9KQitaZzF2ZEVJOTlSNmVvalN4d1FKb1NMMEdtdlBJ?=
 =?utf-8?B?YlNoNjdzbHdFaVJkaXo5L0ZoOHkyRTRDbnhEczlNWGJXdEovcW1VMDJuc2pz?=
 =?utf-8?B?Q0I3dHAvbGFmc3NCVVk0MkdOSXhDN0RGdlF1Qm5jdE92akN0KzBaSmtrZTE0?=
 =?utf-8?B?OGdPS3V4djJZcVR6SCsxVjFPUFBzUXo5aUlkS0pjN0RQY1NkdjI5dTZtaThs?=
 =?utf-8?B?emJZaU5xZzg0Tnd5bU5TZ0x3Ny9CNUdpVzZZdUNOcS9HNVJIeUFrU2RvRmJ0?=
 =?utf-8?B?K0NpRHV1eE9CK0JJYUZrQ3lkR0FvS0x5UFFTbFlHMVVFdG55akd2aHFnM09a?=
 =?utf-8?B?VVVYcC9Qd0lQaTI5ejJjQ3VoY2NIUG5WcXhSYTZVL2g5dHJDNU1QbjJrdHpz?=
 =?utf-8?B?SE0vemgvb2I1dnZTbUt6YkpWM0hTdjk1K2RmeGhtOUtVeHhWUXNkaWhwS045?=
 =?utf-8?B?TC9kdCtIZFpkYUxudkZSWUJMSEt3YlA0ZXpiU3ptOEwrUG94VFd6K1crRUUy?=
 =?utf-8?B?MEhtdVQ1ZHlVUTBOcXVseHZiRDR4emN3aWFpVlNVVmpPTzlBYVNsQjVMdGQr?=
 =?utf-8?B?ZHZlRFJldnNIT2Y3Y0g4Ymh3ZGZKV3pldDZCQ0RHM3kwZkhiSGwvTjRPNmtm?=
 =?utf-8?B?MVVRR1podGRvTTdKQkdBcXE2YldrV2QyK1NCT0o2eXRCWkVzMnRDbXNSTU90?=
 =?utf-8?B?Rmdoc205c2hTVTRLeGYzZGF4Q2U4Q0ZhdEhqaURYQUwrUmYyTVYxODFKTHI2?=
 =?utf-8?Q?FQzD7q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXhZUUxELzVqYzlicWN2aHkzM1JySE5ucmU3YWhKQm5BYzAxQWQxREpXV3BU?=
 =?utf-8?B?S2pRRS80NWMxbGRqa2NERnRIV2VkbEFieXRIVk5BaE51cWVRVEptZk44aEdT?=
 =?utf-8?B?aERqMjFBYm4yaTU4bWFpeWhDU2JOWmJnMWhKQ0VZSjNOMlV1eWIrMHdwSGJJ?=
 =?utf-8?B?MFV3N2d0aXd3SDEwMmdSM0VReml5NnpjUVhWeWJsalZGanlwL0NiZlFIM0hP?=
 =?utf-8?B?bWliWHByeWlkaGN3azJqaEtjdU1KeXJ1UlJQMmY5bC83Wko5aFFoOGE4SVo0?=
 =?utf-8?B?dU41RXBwZWNTTE5peGI3VjlOTnY3UmNmV2E2a2Mzd1JlS2s1VEQwc25nd1lN?=
 =?utf-8?B?UTNEOFRZQ3p3U3Y5OEhlR3JiZlZOYW4zUEFHUDFBQlJKM0VodnVHUTZoeE9q?=
 =?utf-8?B?c3FyeUEyS2laU2FoU1ZDczNkLzhxMTJVeFNLem9JWG1EdWFFczFHbHBya1NX?=
 =?utf-8?B?UXNEVFFsbkZaaDJKZm04ejQwTjJ1VWpLOFM0QXpwTDhkcmxEaHBaRHJVTkNq?=
 =?utf-8?B?MU8zaTdTZHU3ZkF6cVRsYjdDMlRCWDdaQ0NBdTVtdERSQXVCeUorL2xzbkE2?=
 =?utf-8?B?Yk9QcEtnUUpJSE9HRCtYYmRMQldTMEVlL1JSd0twUlRPVjh4MlZYNnVPYnBh?=
 =?utf-8?B?Z05OS0JUeHJQNHVqZUhFYkxYQWlMV1dqYWcrVGovbmIyeG5TbGV3UmordjI0?=
 =?utf-8?B?a0N5Tk9RcUtEZjZjMzVTdFIrenBxWVhpOXlTYVUvaktCcVFGOGhlNkJNVVZR?=
 =?utf-8?B?V0F0VkxDRE83Z2hPSUlwa21jTW45OUl4QnovMC9GbVlvYlBaNXp3b0hZbVI2?=
 =?utf-8?B?d3M2VE1FZ09FUW50bCtZY2hHc2xyMXBWREVXTUxyVkRCQllLZGpHMzl3bVJl?=
 =?utf-8?B?MkVUYXRIUVd3ZnhVWGhvbG9uVk9Sdkt1bFloMFFZTEx2eGZTd01JM3ZsNkNS?=
 =?utf-8?B?L2xXVHVkalloVEthZ0pxU2YvVFljWHBURU5vWkh0TWZEemJ4NkxZSThlbjF5?=
 =?utf-8?B?cGRpM0FqMXNpZ0ZULzJDbytncXM0eEp1V2dOT2dtYTJJUk1ReHprMkM2U3Nz?=
 =?utf-8?B?eEhWdEEvWVkxN09xVGZqTW9WQnVPei9wL2haYVYzbjF6cE5XVEhDVDJ0VzhN?=
 =?utf-8?B?SnRUYWpwcGFrV0F3bE1FWTRRTGx4R0tmVUpDdGRlRW9XcGFLR3VNOWFQYzUw?=
 =?utf-8?B?a2ZjL2lSVmFMaHd1eGRDaGp0aGZLV1FscElOd3lHa3JTaEJFOXlUYnJVd0Zy?=
 =?utf-8?B?YUdLQ2JoYWRoQXM0Q3plVldPeDAwY1ZhTWVYeVJ1SmxNeEN4TGIzZ2RuL3hp?=
 =?utf-8?B?WXJ3Z2VBUHZ5ZlVLbSs4TUkrc05BUFdEVnpRMldWNWNFOFhYczRwUzRxOGZi?=
 =?utf-8?B?L3pDaEQrK0svU3BFNTBCRXRwU1ArVS9KUG9RQnRPM0NhN0tJVlJtOEdaUkVF?=
 =?utf-8?B?UXp0ZVB0aHRZOW9NcmJ3ZW51dFdMQjhGc2xIQnQ5UkFFbDEreW9xTmdIMnhs?=
 =?utf-8?B?NVJ3aGJnUVFhY05MNVByTDhBZUJXVEQ0S0p1SHM2dEFMTlM3N2FPM0NHUmtt?=
 =?utf-8?B?bWJuSVdnL0xZNnB3RWR0STlxMVZTcUNwYkZ5SkMrK3lRZStLM25YMWtCWkZh?=
 =?utf-8?B?N1N4czV1VEkvbm92eTVzZE0yc1k4c0VHYjNRZUZwOElBbG1EUWRic0J2YlZk?=
 =?utf-8?B?ZHRRZDRxelBrSWduUEkxNlRpYnA3dVYvdDgvNEk4N3A5ZitvMmdRdmlIUkww?=
 =?utf-8?B?OTBPckN6Q3Axcjg4K3hTZHhCR0pja3c4MjNBTVlLK0F1ZkhqMzlzQy91Tldt?=
 =?utf-8?B?Z3pxTHM1ODRYWXpqbDB6S1NYeVFINzAwOW8wTGZQMWRubXB3N04rVk5xaXoy?=
 =?utf-8?B?U2c0VHMzVGJqeTdvYkpubmM0SHMyNkFkb0M0N3hZVGNSYWJlNGczTlV3VW9C?=
 =?utf-8?B?TlMwTEs1a1BNeFRXQjBQZEN0MzdaRFJRQUFFLytaaGVEeDcvNVd2NFc3K0tp?=
 =?utf-8?B?MEVzekFlQm1FU2NxV3MwcUszelFDYTlXSS9NTG0vK3VvRDhlT3VKZHZnQTVs?=
 =?utf-8?B?d0xkcTlESG8wb3ZpMHd1cFRPSUZoZ3prbDE1cE8vRjZMQ0dkUGt4bU5haG5K?=
 =?utf-8?B?M2NJdGNvMFZ4aEFDT3ZSdVc0WTJ6d2hLTFZySzRqVWxSL2xRQTgxMTV4RTFx?=
 =?utf-8?B?NGc9PQ==?=
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
	nUT3T4lKrrrRRHO0tiJQzi0eppfkO071rIk2ROp1lAErUr0xQHtcMWrMvx5kKYOyzEtUUgWVKykK5rZqCtJEiKLGodo6ILlIHleURMV7k3FVdNyQepVmMjl/eQ5VzC0253UOuadlhFqbzsyEepEC+1L3VZcmJO1s4uoDiWicvH65pf/lVW7/owHqG5MLbW82CVvHfpBBS+guCTVn7maDGM43zeBZ65BC/4/JhjrMtdV5O8HW5DsxYL3lhiAd1pMuAVl4lIpa73yf+SoY6QGaWEsbmtDK2YeZ894rhflXKdYTeAjLAwFTxoQXS2T+agzuQrbJZeTw1VhxW4nv9jlr/5RNkHJ0wsh/3ReMRtS8xfzXAK/T6MKDW9L6BeC81yav5fbM7Tp4pVMDj8LAKvY2wsuoXViqBdsqkosB8wuu7Gn4HD26fpjDCod6+j+grov7RtwPD7s2K4QcRlJgYos9QpUrjvVtipySoYhNl7cm2LKN/yemIYSboTHQ8JxvwPAykwA0bm06yZwbKVX6WAw7JYfIbnlD6/y5USQ6tOopHpz3LIqEyjeAMyhvzlioV2fNpMhZgj/s2MtXIRUflVkRKjB8KS/rt9BpXI80MYoEZGRWJrSdf/4U4gQXc/zaY0F4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6575fb63-ceed-4e47-6425-08de12c5465b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:19:23.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/ydTrnvVySKaCzuaGjiiUJ/uaJO8M/z7Uiy4gZ/Yt8rGHsQKe6ZH16WtmEYZ6DzzUgga4MyoUQtU7473qLIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7408
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 93oVPOfbehhf8HKB78vMhzdzEToHpTE0
X-Authority-Analysis: v=2.4 cv=OaWVzxTY c=1 sm=1 tr=0 ts=68fb1a74 cx=c_pps a=fvupKMjMIRS11LYFemBAgQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=Bj90jaK72LekJOHGxAoA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwNCBTYWx0ZWRfX876hrBcgeTzC ivkAyoaHgg7QGAtuwv4NHUg4mXcpGq12FNGPN7Ny1aqwKmwNqjEAMlaPu8+9kT4yhONVpPlpYIn 8yNNOyyE5OllUHZU5xr3TXg//2Ds2M7LbWqvbhbaVdfErYRU31tAJoGLo22W87xIOpWbqKEgrYg
 kb56Q8ddD1/RuIlIrfD/WmQyhOurZxDMLELUPzl38F3iTxHi2f0a7qFoNRZAF1THtObAdKrCjmy OZH69/qW6A615sonrSAVZOHs2tvuRq/Z6/tXgr7260F/cKFESepntyFgxuD1Pn4f2gMWsWUQdCY KG1qUye9tqWl8bZaKeDKdpHnFLqT3kD7czHlQf+ajOWsWlH/3lNz6RSgS34LnYUA0GdyVCykZD5
 CZIOEzq6b3GqTEqPxGQUxne3l6zGQA==
X-Proofpoint-ORIG-GUID: 93oVPOfbehhf8HKB78vMhzdzEToHpTE0
X-Sony-Outbound-GUID: 93oVPOfbehhf8HKB78vMhzdzEToHpTE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sounds feasible, I will modify.


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, October 24, 2025 13:29
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v1] erofs-utils: mkfs: Add 'no-deduplication' option

Hi Friendy, On 2025/10/23 16:=E2=80=8A01, Friendy Su wrote: > Add an option=
 to disable dedupliation at format. > This option is mandatory if mount ero=
fs with DAX. Is it possbile to introduce `E^dedupe` for this? I mean, chang=
e the defualt bahavior


Hi Friendy,

On 2025/10/23 16:01, Friendy Su wrote:
> Add an option to disable dedupliation at format.
> This option is mandatory if mount erofs with DAX.

Is it possbile to introduce `E^dedupe` for this?

I mean, change the defualt bahavior into DEDUPE_AUTO
(or DEDUPE_UNSPECIFIED) rather than DEDUPE_OFF.

If `--chunk-size` is specified, DEDUPE_AUTO will be
DEDUPE_ON, but `-E^dedupe` can disable it.

If `--chunk-size` is non-specified, DEDUPE_AUTO will
be DEDUPE_OFF instead.

see TIMESTAMP_UNSPECIFIED for an example,

Thanks,
Gao Xiang


