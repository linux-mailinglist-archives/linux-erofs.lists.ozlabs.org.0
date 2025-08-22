Return-Path: <linux-erofs+bounces-878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF2B3138B
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:41:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Zvy1sP1z2xd4;
	Fri, 22 Aug 2025 19:41:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755855710;
	cv=fail; b=l95zC6IwdcCAJLGr+PRSjJcZ8Cblqf9652Mmo3CLJ/rHZGya9MEPZnNfXsudqVhBdUKFAoHt5j3pSuRn4BuOMzC+K1YDKR6IGFoTBqnzzSnyBZjXThOCE8IJfMTOiu6DLopBbsqiGs0o49CNDnVVvB3jAEyWSbhyNuSOhwu3P+QdzWnuUCNBFb/HvJWEfAue/T+lFjfOWbvNGvTbssbW73piwVH3WnTHzm76xPAgcL+lr3nylodstGF4syYqBTCd5TS9EqKMKKG2qeNNPkGbTUoMxSfbltJc11s53shnY+FGlrfILWIXUOthk0/tOYFPfXpfPvQBKVDuA/tE5gEQXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755855710; c=relaxed/relaxed;
	bh=48ntmUV7unEpjRBfENncNKvngp+EBn4PLBsYO5zr8kE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=eBLogX6imOqHyAsiNNiyPwE41aYhYXMfmVer3vGbfnnue/IGH6A0NF4SaeopI2sz+DKkKVPa+TrC+GGGJptrlwHi2gEcYGYdg0RkP7Cd0YhMvGx5QlvwAuDtgXO/dCGgedW2+00U4RG6/OyWe6XI7aC8ZNvwAkic758fMzcuIkjbtcnPJ9VSuSfXXgImKXTa0L3muUk9dNtrnd2EN/rXnh2mgvYXsirih6JJClwGJY/YIDHPkMYAsKmy0lCiwjNzaKOwdaMA4ZGQbP4Di1uKVyXldDuMUU7OSoY8PhHBtZErYpZXEKDRNTj+TWErd52AbjYpmj7fUobKe/h/Ln3xGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=W4PcdZ4j; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=W4PcdZ4j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Zvx13pzz2xK1
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:41:47 +1000 (AEST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M2kLZ8016169;
	Fri, 22 Aug 2025 09:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=48ntmUV
	7unEpjRBfENncNKvngp+EBn4PLBsYO5zr8kE=; b=W4PcdZ4jAUUM+5uZoG+TVjc
	wwhbZzLmJwSX7OpsbpAh5jurFTyHI4r2eqvOzCowLaX6BZZW1lIB08OnJcQzgNBt
	P3ovGAV/DxFH9qXKTgaijZkrtaxlAFfJ49uUKv9AzrFPn8Lo0CHk2essKhBlpOJ3
	Lt8a/JXlVe5xxZAUpC3jg4pkLNlfypf1UO8fXB3wWFL7LfU/ZYSz6MZha1GrM9He
	HjhxjKosBoxsfIpFO9jc7aWISGYl5dzDsPBMQfzcMymZn55voQGGr2mUQx5hLmYJ
	d+B8UD8Df93wBLtNNuM8wprxL7ur92pyKnvg68b4yJyHPCnAWzdbh6jhviaEG2A=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37ejgeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 09:41:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSTDXdfZceHL24YX3EF0nbo9TaWLBAl1v5AO8zOHaPy1AeDptIh1BhnZFmlg2TjO56bYf+weZli2YwEJpJ7k8o8B1HgAfM6GHvQAPlpDgYw5N+pbedsjvHbrR615RaPBoC/BAFEagZ6uFzhaLpasO4JOJR2/WzHLQxyN5HpR8sv6J87pvxVOqQIASepDbDFmP5dHEH5/aSxyaWhcbNVB4tMNvd9InNfa4Rwspw/pO9//nGUGeEIrC3Rb5WWAvlRQpn9RoZ9v8xvSerPakpDYMps4y8uyQOU/ZahfMZDHowqqSQaVy0xJTOUYaUxDlGdODPIxaTrQ7dLEL7GSzBmb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMZFGTHyrGnK32d6AlZ5kQUsbn/KFftZ1PByFFCJXtI=;
 b=EQEZJb/ogctZhyZCI/HlOjVs8jluj+vm2BJ1VUIhneixKc1iS4BGYE6S7YpjAzRm8SowmhB4BV0xAleLfA70SfMjRxpXunpr3KAiPSqHgROKTAzEjpQjZNMBJNV5ZhgcFK60NGD3VstvHjp3tCJqzdRFsFS4sOQX/GUlc5iDqaXiWijvXCxYpMr7NPq9oigpofpTLfDfNP+IPqKP8MspqU8UDVHPw2naNk2SabLQoYykdgWOYX+UZzgestoAQKYr3uBVXVzhyfyF6L93SruRygrRteX59a4Jd6AnZuSGjltAdKo8xAPtgsvSFxbX/kyAsKWKSYw4J71f28d8WDYi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TY0PR04MB6267.apcprd04.prod.outlook.com (2603:1096:400:265::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:41:28 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:41:28 +0000
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
Thread-Index:
 AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdaAAAO7YYAAAoaAgAAA/sqAAAJLgIAAAQbE
Date: Fri, 22 Aug 2025 09:41:28 +0000
Message-ID:
 <TY0PR04MB619155A336D9DF4FDD0D4218FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
 <TY0PR04MB61912BD4A4596D2CFD485B5EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <7b82b184-65fd-4135-b9dc-e54c4b3adf95@linux.alibaba.com>
In-Reply-To: <7b82b184-65fd-4135-b9dc-e54c4b3adf95@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TY0PR04MB6267:EE_
x-ms-office365-filtering-correlation-id: ac258758-3567-40f3-a44f-08dde1601156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjVQWkxNOVdxTUxVK1JmYTZxcy84VDNGWlZGb3ZyOEZmbHM1MDJjczBZTklI?=
 =?utf-8?B?aWdXRjRzejBiZ1JpRE94MUh6bXdrTUg1NmtpVHp3WjFOYktKNGZaQTI5MnR3?=
 =?utf-8?B?VFJ2QlRCWStXM2RHcm95Mm9MTDRzUmdCWTRlQ1hDTE5oYlE1R0d3aWZncVlI?=
 =?utf-8?B?cnpQOEplZmp0OEVlK081THhSYUZjQWcvaHVNNDVjclduNDI4WXpRN1VhVzc2?=
 =?utf-8?B?bU8vU0RqZWxTYzJQOEZvekpvSmVRRmRORWxSQWd1SEkwMGJiWHE2cVhvcVVw?=
 =?utf-8?B?NGZYRi90VlhlS2RPekxGdXdkeGZXSDVpUFFtem1RclcyNDBINEtHZE90b21t?=
 =?utf-8?B?VXZ3ZmFhdTBmajBnZW1iSlcrVkwyYkphZVhZbGJKYVJDUjVXWnZ6dUtJQjdy?=
 =?utf-8?B?OG94RE1CNEFNalNzdDlMdVI3VTQ4aExGQjdOem1GR1h5S0Q1WE5LbTNJTFo5?=
 =?utf-8?B?Q1A1cFVKM29KNzBaV1ZQZmF1ZktrN3ZOYmR2aUVVRGREdmpvdnM2anpoT0NZ?=
 =?utf-8?B?b0xVaVh3STNsU1UxaG9wMjFpUzR5OXpBTk1LUldzc3R3aFp4MGdwNUVqTjNP?=
 =?utf-8?B?QVRBT2V5TVdSa0dXOXJtTnJ3ejRKOHNoQVUwc2lxK3ZXbFNEMEFUWlNZVklH?=
 =?utf-8?B?Nm14MW1EN0dhT0V3N0hBdXo3NmRxdDN0SFdtMnJGV3hqMWg4Z3lzMjIzc3pI?=
 =?utf-8?B?ejRLdUxBaWdiZkJTSUdZREdCR2RhSzQ2Q3Q4ZCtQdnhpTXNaY24vSGJKcFFX?=
 =?utf-8?B?R1F1bjhBbFhQZWJRRlpOK1dTN2UrV2h6eFc5UmhYL0JTRkJPY2RyRHgxZVg2?=
 =?utf-8?B?ZXdHVjBFMU5LV1ZidkFFeFo0WHh3TytGTmYwR1FzZTg0dDRSV3ZQUXBHaEJy?=
 =?utf-8?B?N3UwdU5MNzlIN00yQmpwSVFyK0hGZzYzeVZOcHprMjR3cXZBbnRSRmpxcGRo?=
 =?utf-8?B?UHNsYk9EelRzaStzUXR6c1NyS1ZxTGR2QXNob1RVL3daQUYzNkNpRWpGL2V5?=
 =?utf-8?B?RDF4NmNlMktKWk5DWW9Sc3hMWmVkK09GRTI5MVBWTFArZ2V0YmxzV3pJV1VW?=
 =?utf-8?B?WGV2QkJ5c1YwTFlEV09KaVpML2ZHMFRRWHhxUlBLNnNPU3JMTnZiV252TjRZ?=
 =?utf-8?B?Q0NaR1ZKcVBPckJZN1Q5YTdRWFduQTlGMmVIM1ZLWXdGcTIwaTB3Q2ZwS2xO?=
 =?utf-8?B?a05PdFRHUTlVNjc1WlVwOGppdnQxK0N4VlBxd3RrUHZXQm5XUXRGcmsvTUJZ?=
 =?utf-8?B?QjlwcklYb3UvdC9EalJsMXBwY3EyOXFxMjNESnkzZmVUTkNBZHBmdlRHSWxO?=
 =?utf-8?B?NFYrZS90MWNSU1R4Vklwci9BUkJxc3lyWnVHa0pwc1d2VVZFc0RQeGJxTWFa?=
 =?utf-8?B?TjFjSUhBMDN4TzJvcFh5TWhSTStBQk5lWlpZdWdXTGd2S2JFU0NlcmpEMERq?=
 =?utf-8?B?Qy9JRGVwNmVVb2l6NkVTR3lqL0M3dzJBWVd1QjRJMVBpaTkvUWhwRk9KTnJJ?=
 =?utf-8?B?YlJ5dlV1MHkwcVVVVkxBM0x5bEZ4d2gxREJReFJZcGUxbEpzUXJhMlNseUxS?=
 =?utf-8?B?cFRWUWk4TGNlMUFLK0Q1dno5Q1pYUitDclJ4bCtNb3RpemNPbkFEdjlLaHl1?=
 =?utf-8?B?dm5GOUlDdm1kUi9rM0V3QXErR1dnUWtOQmNtMzhhUXRIVlNyR3JWRTNNM1VF?=
 =?utf-8?B?eEI5dFRhUS9FditJYkJ6R1NJakhvbk16emgrZWhaajhzd3J0WCs4MkEyUW0v?=
 =?utf-8?B?dm5Fb3FoZTBqNHNsT01vaml0VjlReEZ4K3dSekV6ckk3MDlrbG9kOWcvWkdy?=
 =?utf-8?B?SHFsNmM2Wk9XbTA2QkE2OVd3QWhJaUFlOUhuaWRzcm9VcDJHbkwwYUhXY2x5?=
 =?utf-8?B?RFdsc1pUWXpVK29pb2FtYUFraitDZkVPYTVTc0piM1pZb2tiaUVTM2d2bjR3?=
 =?utf-8?B?eWlxbm03RVVpTUhnMTBOcVF1OE54ZWFlb3hiZ0phdm1EQUZ6Q0drK0xIb0ZV?=
 =?utf-8?Q?v7nOjbcQeChbH80vTF3B45HF2ESnjg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGZkUUVMNHFIT1A3ZTNpajlXd25FZmVBV1FSOXptcU5VNHdjdnVTQ3J5VE1P?=
 =?utf-8?B?Si9kSG5XSmRzSzVEMHhhU2JENGpyaDRuTEVyT1NPaWl6ZUNTUUs4K001cWNF?=
 =?utf-8?B?LzFVTEowZ0x4RDRyZVFXd2x1RjhQbU5hUWNIbXJLdTEyLzhtZmFtdkpmaThM?=
 =?utf-8?B?ZVBWVVd5YjlzSFd3RVJPZlJZbHAxbG5pa3lOa1BMYlVpQkQxWUdiajVoeDho?=
 =?utf-8?B?T3drbXg4OEIxYU4rd3R2YnJETEhkT0xNZGRIbkUxMVVORWFneDVqY0VxTm9C?=
 =?utf-8?B?NmhheGpQQWFHSk9WRXJHZmpHVXBqWUE2R2JXbm0xMmZ2Ulord21TWjRxZU1R?=
 =?utf-8?B?WitpbE43aUIwTnpNaXJ6ZkNkN04rNjRyUDRPSjlmQ2w3TGY0WERodnFXK1Jn?=
 =?utf-8?B?Y0xiSDFaRDhVVER6NDRlVFZMcElTMnNnM2xEUis0Sklsbjk4NXNRak1NWE9H?=
 =?utf-8?B?WGs2c05pd1FvcTA4NEVkOVZ0enJvQUhmZTQwMFFUMDZhUStkN1ZRR3h4bURo?=
 =?utf-8?B?VENFOXJIN3pod3FtQ1dQVWtVYkpLaFNoSGwyRmpOdnFGcTFrSkpxN1RvYWkw?=
 =?utf-8?B?dEtiRWNJS2ZxZjFGODZoeWIwMUhzMTFrZGhybGo1ZjdjcDNpUUhwQmJBbXNZ?=
 =?utf-8?B?a1N4TFpyWXZlNE93aEpreUtqdGNHNlYyTFVRRmtOSWcxYlE1bHQzOEt2TUNr?=
 =?utf-8?B?ZFdJNHVSN0VJRi8yYXFJR0xGcFNhUXBNQmJDTGFwckw4aG5RYU9sSTNmMWd5?=
 =?utf-8?B?MklwQ1lTaFYrdEpiQTNRZUtzYnZ5VGNTeE9NbXZLNjQ3UUt1OGZNeVN1QWNH?=
 =?utf-8?B?Y3hhUGRsQjkzdU9rNGlwb3kzZ1F5NDRIa21wcmtiZ0gwelVrdnZraDRXS3Ex?=
 =?utf-8?B?TG55Y3pyTHVrbTBHV2pzNnRxYS82eVRLcmRYbE1MMTB0TktxeWxiaWJOZWc1?=
 =?utf-8?B?OHg2UHVhUG1qN3ZWV1ZMTmxTYTlYQU9TUFBkdzFEU0NvcGZKNTF5OUthVG5X?=
 =?utf-8?B?ZG1GVXpzelJWR0QyaUdxL0ovNVZXTmdCMUQyblBCT0VXejhGdTYzRzEySlJ1?=
 =?utf-8?B?b3A3R1ZWMVBiZDg4TENuWGE5azlOZEpLZ3FXdzdvMEp2THF0RzlUS3Zwdml0?=
 =?utf-8?B?WDlhaDVBcGFUQkQ0VjYxNHpsSXErTEVUZGJCUEdUcFIwSjBJNU81RTB5clNv?=
 =?utf-8?B?eXI4amxHQ1U4QTBTZFN4S0o2NHdrOFd5cFNTSkduUysxcHk1WU5USVJ4SlY0?=
 =?utf-8?B?b0lUaXhRbTBMNFJWUVlMTlZOS0oycjZmR1FCWmZpZ0wxeFB5RU5kWmdiQXcx?=
 =?utf-8?B?RnVsc2hQM3RQNzhJZy9jVENXNTl4TEhFVGxRSmNGTU1oNm94UHRtWXI1aFBI?=
 =?utf-8?B?UFpRY0c2dEswQWxnaUZCRkloVWl1NEhWMUJzTHltc2kyczRFSWtSbDBycjU3?=
 =?utf-8?B?YWlod2ZONVlqMVlCRE9Ic2o0SXNpMCtaVjVJMkpqdDhjblZReldvc0lMQW5J?=
 =?utf-8?B?SUpkakYxOWJLWHNpa1ZWNDdERk9GZk5vc2toTzNUZnp1NHFFZlVpYjFBU3Vt?=
 =?utf-8?B?ZU5jV0lLbWdveTRNU241WHBZNmR1eWRXRytwZ25WSno4MWhnOVNKVG1FYUpS?=
 =?utf-8?B?bXBkenYvbHA0OEZteEN0WjN3ZzlRS2RNcFAvL0xKc1ovMWlFL0pKQ0MvYXVJ?=
 =?utf-8?B?TXRHUFBVZVZzQU9Wd2NOaStVTHpYNlNNZ2hyL1QvUTN4cnQvd21PS3N0YjZk?=
 =?utf-8?B?NGhMOEtwbklXbDJhYUxGOE9ONjFtN0ZWYnlHVXF4RTVhN01BdVZ1bVJsc0gy?=
 =?utf-8?B?Q2dSRzFCMGNZZkE4Qys2N3JIN2VmR1c3ZUpLUHovS3FFaWFZN09ERjFwdUNO?=
 =?utf-8?B?cUFoRUw4UFREZmFNS3F2enBUMVZXenA0WVBZQ3MzT0Jhdng3akp6dGVLOUdx?=
 =?utf-8?B?RE1YMWl5MVVJVlJHeXRlZFM3cnpKYXZ5V1ZCT0tJNlRvTmg0WmdkeW5HQy9w?=
 =?utf-8?B?bDZObWpaaUN1UVpEdXYvKzZGTEF1Qm91cmhxdEYwcGpVdU94ZlJoZUkvNUlU?=
 =?utf-8?B?YkpXdnlFZWZxZW1iYWNuUlR3cEMyQzZiaGFPb1NOOFRDVlZIZVd1bTB6eFVz?=
 =?utf-8?B?U3h3UTN4Y2xFc0pXdmcxZE1XVU5MQnhWR2FEQ1M1Ny8vVnZLMEhuZ2VoL0M3?=
 =?utf-8?Q?WElRDFrNe6RLNnvTU5MPXrg=3D?=
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
	ArCmU5RiY8H7rzPPIoFr8V5zyFdwwNoYaZPlC+fd2OeVGeK4gR5fEA4dEjx9b5/EMxt96MCSyi6vNpC4ccvrJLmeFXrc5LhwActF5wgaqO9gufZM0hLiON6oda95C0auLLsGoqiNBF+ea5zFwY2Qw4ELjp2jwTBSrKVKCGWXiFDwVQEE1VC44tVZdJJafWmsG+t9OgEFX59LQeuljbLTul15hcJfLthvy3Yih/39RAzYUKA6kmHKodA/guUPG0QIuBSQoOGhiz2ZAfTQKTebsMo1LhdRRrU25ax6bPRfQix7cuT8eS/r+2zs8/L5U0RRsVdO4Dd0WPQXtNrBJlPMvwKIEyjMJ2OzRH5PZ0fD74vtnUbVaqZMrJg7MkKIuH77Yd1OJGY4FNtUd30Q5ZBLgWq3SaItdoS300g8h9544m355FQ1QZAMcFfFOrgj3x/z57dYGL3dXXYvgbGol2GCz1Uy6untJfl/YMjBhxkL5pfzbKYR2x+aZJlKJUQVlJWuNZR45VAw/fseN4s7RnSvDiy4LGv49kquBX7Ob1Sybmuv70bIJswVE8Qnu6ZdXdNeNK/KV4M8omXQ2yvc84iAjoG4qeaK42QGDNtT0kUpk5/zNYj7o5WjWy2ZjQ+L+R5L
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac258758-3567-40f3-a44f-08dde1601156
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:41:28.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAMApE0ZEIaYLcoVgGig/DE8YWhxMH+sNO099ifgAJvWI+ZgjvhBYsjiUbWxt63eauaYcjxDHhgnmy0jGdLPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6267
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX1ifv5Gw7FToQ fmN5HP7axlUlATiYqYcJvrBjNmqW4MUHSEpXGdrkc89WVA7d9nkeYpuSI769IPRaiu84ioh8aRg JIcAS4+7vzIhWCCZVNbTnmRpnon14rI87meal4qdWLQMlRI936bJRzN0stVSzwmEyxFMKhdLYYm
 dtXamLtGv4mB152tcqhqvCXIpemtT8xNouAK4qDh3wEFEsDmTCuF5+nFI6x7I9O0AMwVzuBcJF7 OPHZyOPA7zSQN8ZDOAXOtHWa483Wi6B7UCAlv5NFAn/m+4zbnoUh+9E/e63xROszvQYe1Hgjw1M Ij8r75tGjRXRyV65hE/T6EPCL/+z1EjMe4XsybTfEM6f6F7K2Dy6BqjkgA4TaXVUbQEDJvY+oxx
 s2RgMZqxfKjpfZpH25G6EAMTckBuAQ==
X-Proofpoint-ORIG-GUID: 6ji6VeiefgUUfaklT4MivGkvzFgm8yAZ
X-Proofpoint-GUID: 6ji6VeiefgUUfaklT4MivGkvzFgm8yAZ
X-Authority-Analysis: v=2.4 cv=CP9znRrD c=1 sm=1 tr=0 ts=68a83b54 cx=c_pps a=HxIMnyElsDSQbyWpFcpfrw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=Bj90jaK72LekJOHGxAoA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: 6ji6VeiefgUUfaklT4MivGkvzFgm8yAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sure, 1st one is deleted, 2nd one should be more completed.


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, August 22, 2025 17:37
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

On 2025/8/22 17:=E2=80=8A35, Friendy.=E2=80=8ASu@=E2=80=8Asony.=E2=80=8Acom=
 wrote: > show both 'before' and 'after' is just for debug, not so importan=
t. OK, I will delete 1st one. `Aligned on 0x%llx` is too short and ambiguou=
s. Even if it's a debugging message, let's fill it




On 2025/8/22 17:35, Friendy.Su@sony.com wrote:
> show both 'before' and 'after' is just for debug, not so important. OK, I=
 will delete 1st one.

`Aligned on 0x%llx` is too short and ambiguous.

Even if it's a debugging message, let's fill it with a
more complete one.

Thanks,
Gao Xiang


