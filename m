Return-Path: <linux-erofs+bounces-873-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EBB31288
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:06:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Z6z36cSz3cYk;
	Fri, 22 Aug 2025 19:06:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.183.30.70
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755853579;
	cv=fail; b=CnnONfeBAvb2+5YsTKt4rtd/soFMxrP7xgf3J/9dzeVVcb8uAYd92fXR7QUOAp+cvaofHWw2o9uOj5U4Iy4DUm0SU1+3W2rbWncNvs4ZMVfpr/SbYHdd1b9IA/8AmiO+vBJcDE5zlxxiWD7+1U7WozrgbXVN0oJQz7CDS7XW/ur4pa9Er1Sfwo9DnqmUg4A23OKI9kEeIgb+hBtJSHd4BdM6UHfWsl/L80he+h0snqFbPe0WA7GfTXlYNO6XICvVHJAGkKiGh9wPlJqnq5/lJH/8rvGRSysKx6YVZ593or3DozFUkOWZxM9KDa5B36+8Qmp20CdK+nsLHkCvskHK9w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755853579; c=relaxed/relaxed;
	bh=hNY5CSrTomSqim6NYlwpf6uzdahP1fVynAglHK/tJ40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BDNV/+iW4SK7mekZaMxwfVIe1uIMJ11O+CT9tr53eknUb28SL1Z/Vo3naPgFWO/HBSKfE4Fg17r1hIn4xwMcqw7exY9TG8LClrFtNlIKmyqVjMqNLMY2YK7wYHVlsIY2bZ6dUNaeuy+JOfiCgs7I+nRAterxKJf59EuMP8RdqrqMiw7jJzrBla4lQayZlGLQMzuSYD4e4ylpNAaIUH0AE59e/3jUVFGKGhQmiQBRBPxsu0oDfYjIZi+hI9mjdXFnvl7bXFOYsqAIy3c3+C1zg594dDYbbhT3vVlVon4GEjgoM48COkP0VjHqlFtfVs0z6GaslWAjR0z8UspJPcAA7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=g8M7Vt1I; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=g8M7Vt1I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Z6y0dY3z30PF
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:06:16 +1000 (AEST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6gdWD020185;
	Fri, 22 Aug 2025 09:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=hNY5CSr
	TomSqim6NYlwpf6uzdahP1fVynAglHK/tJ40=; b=g8M7Vt1Ip8lGO6a86KzGLNz
	AgwwsdhaWmFjB+qQe9bHj1zu8kKGreU+NzHXZehzrC2L7AO8Om7vUAk4irXU1Gv1
	IfyfgB2QSdDUOQ64SRhmGStDrczvLbRq2nmwpEkMPBqttVqHnQQlsK2GHizwiofB
	TmQRMPc5FLe881O8qNXyrHkKU4RiF4ywbvUBufrZ1LEzJX6TUDJ5EocvjCjmLfXi
	7coOZqJifcRSvIFKSqzXqlhjekQ6cW4Z3RizJc5gj2TC7/gFVbxKXx+Th1fBBdAg
	Yd0dtRrlyLOoJsQ3gXn92cDKUJIcBGW4f619hNAvFdcvwN/4vBkuVwF7SjpitVA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48n37h2fb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 09:06:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzsqg9i4sgxeKyWgRZ3WINsALXq3GXU0A6wMT6hJtFZiwIFGoohN6HMLwaOAnmp+bj7APWefyRLcBNkWx9YYblrLiNPbwLmhZ2yt8R0el8IGnStToyhIutKwsw6PFs3dCCCBWiR42UQI/Wp0wBQY5fRqz9DDUKZTGdlrChNbkIkmv1rlN95vJ566FFJX+lpEpz7GUnQ5cpt4dirE0wq/5Y5riSbBBdYBnqcR9jGZKc2ghFcw8ojhkT7lD3+EQG4CBFLEFt9/2oqpYCD4D4xIHm14LTY5P53Cwu5q69kSjOiG6F9qKg5jXC1UecMCtA23GjiK0gN67ijq58/O7APC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOAkjdf6qzJCx1WLnWdN8Z1uzEIOHq6JXA8eXQ9UWzE=;
 b=VobbIdXBFviIOdrIWbcrDwlWiN90YZFfVHLFFX6QdamPnDTZm5cnqb0JoMTzkwMrzQkIwKUGsbtV828ZqHMmii2IMDx1jHTDKmLwIyRtOtecGIX+4tZqbREh9D8OQ3u96eIq4icCSbgYoE5ekA0NiZXnnSZgN+5aTyIg0EQ/vMS4dVtEX3ZPPmsEoX+VO4BvWqRCY4R4XHmORQGE2np3xBIfyOhBrh6+EpwfcXo03CqeWP3gnDkniVhdqaSlv/Fz7Ox52qrJrD/NS7T82M0fQuYcS6u5w1Ax3rkPIkg+BXuJHYRswWVy8UXXS8PAOiKrfmYbjQQKNxSmcouq46ISVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEYPR04MB6653.apcprd04.prod.outlook.com (2603:1096:101:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:05:56 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:05:55 +0000
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
Thread-Index: AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRuXoSAgAACFdY=
Date: Fri, 22 Aug 2025 09:05:55 +0000
Message-ID:
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
In-Reply-To: <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEYPR04MB6653:EE_
x-ms-office365-filtering-correlation-id: 4a977041-1576-4d69-52e8-08dde15b1a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEs3Z3BaUnFncjRObUhoRVVzbGNYUE9JeU5iNEVWZENjSWtWYXZnNkc3UFdY?=
 =?utf-8?B?NENGNjV4K0dydW1TSTdQanR4RURsMzNtUGswUGw2Y2pORUVWeDNWNGNLRzBr?=
 =?utf-8?B?dVo5MFNOZWFPRFIzK3Njak5hcmtyZnppdU9WZFdldDFDYUZJRENIRy9Yb0oz?=
 =?utf-8?B?WlhCNnYxTG8vMDFDeHY0alhhS1NCWU1vT0xzWnM5bGxLS1piVFVXMXhoREV5?=
 =?utf-8?B?ZGpLdlErWWpVLzRPN0hQY3hTQkZzQUpPL0RyVDNhaXJCdHNlSDdYYlRQTlNt?=
 =?utf-8?B?eHhhcFRsUHZTMDBNREw4Zk5ZbUJwNDRzSlpzN1BNZkN3ekhiRnN0WEY1cDlp?=
 =?utf-8?B?T0Z3b0xYZmUzVUI2Tm9CZEVpVmpaZFluV1NaSkkzZVJIdXdqTGRDV3Y5VmRk?=
 =?utf-8?B?VVkvdjV5bUlrOUlxcmdiZXV3UkF4MjdZV2tsSFZKMDBYbVBCL2JoWUl3WWx3?=
 =?utf-8?B?OG1KVUd6Z2llKzBGU25yclIrVFNxWlRtOVdYQVIzWnFLK0VZcHVMTUt4bnpQ?=
 =?utf-8?B?WmhFL09OSmFwVjdoVWpXLzVTc3lRVFNJUyt1Z1NNbWZadm1CMHBLcnRIVlow?=
 =?utf-8?B?SFpIYnYvUG10VXA1SGUvQ0ZXT3JqUUxUZnlQS054cjkyWC9oejdlM1lsbTRu?=
 =?utf-8?B?RWVUYzJQbmdpTEFQaG1Iakl2N3dzcDNVZ1FQSU9MS1B5U09mM3pZc2VVdWZz?=
 =?utf-8?B?Wjl4UkN2ZlgxQzdCa0ZaRSt4Z2toem0zcGRUV3RnR1lLUlVRS0c1eVZPMzdw?=
 =?utf-8?B?WVBzREhGaGdYeVZOemVPZVhhejZxcWFZK1lzRUZXVjNSQ25Eb1hEZlJ0UGJt?=
 =?utf-8?B?RkFyYzFMNG9PS2Y1MC8rNTMzem1LUmErb21DenZDc1RSelkvaHgvbmhjNUJY?=
 =?utf-8?B?ZDZPaW4vMFJiMUMwQXVvOHZnUFpPVHF0N2lNRWM4dm1jT21yUktrTDBDS3pj?=
 =?utf-8?B?Y1UwR081dWhqM1ZjRGpCQW51dXdGRWxJQVVxL3pHSzFHQzBSNTE5WFpKUE5U?=
 =?utf-8?B?ZExrUGgyYnozMHNlejJUdUN0QVZ5c0ZOc3BDNysyTmIyR1JyRHptQ0VaRHJU?=
 =?utf-8?B?RlVUK0xETVlQd1FBeDQxWlhsYjlqS2dUNFZjY2NMTzdZS3JHNlRVU01NSDNi?=
 =?utf-8?B?b3g3RmNJZERqZ2IvL2JDWEllb1VaWFAvOWpLaWliTG4xNjRNelBlbUhwYUdK?=
 =?utf-8?B?dFhpeHVwNnBMN3VqVnRieXhIS1MrUTY3bEJkWWh3Z3U1alU1QVkwVWdzUE5u?=
 =?utf-8?B?UW9HQ0JRWC8xam9hK2R2RzRyNTNRMlI3TmFSYkx0UWJKTmNhMmxzZEZVQ21y?=
 =?utf-8?B?ZjN2K2dCc1V3TldsYVZoMTdGMHJtdXNQTG05WnZIZkg2djQxRDA4OW9PZ1Nn?=
 =?utf-8?B?RVZUQ2ZBYVFsYlpYU2JQUzZIa01qQ2tFUEtBbWxWeWpYNG42anhLOTRIVUsr?=
 =?utf-8?B?bndoMm1HKzhLaU5KV2RZWUJPN1h0NDQ5UFZvTU1sOGpUd0VOREVsNUVwZ2tz?=
 =?utf-8?B?ZlQwSXBxc3d6NFNQNjJwK05CVExqSGI2MkhkanVYOC91TURzTHVhUDM3OUFI?=
 =?utf-8?B?bUowQW9BQnpyVWdpSHRvdUhmNm94d1FFRWwrcDl0VDArcXJDaG1qazhMVlda?=
 =?utf-8?B?UFZSOXNMZExUc0hWb01GRTc2ajVPaFlFNm9pV0NsNDVJS3FPZWlFOUlZUkRk?=
 =?utf-8?B?SGIvRVFHSVlsTStZUSsxMXAxVUNrdGxGYytMcTFXeUZ0cktxMFJ0ZEFQUGNi?=
 =?utf-8?B?aDJydTVrMjZnbmpsaFdMbUIwTDJuSHVWZS9PS0syN3RiaExHd2JBQ2hqMmZ4?=
 =?utf-8?B?eUFKN1FIdFJMN0djZTlRczRzSUkrRmpGUHZrbzBvR3ZFbmh6NFZNOXR4YXJ5?=
 =?utf-8?B?Nk5ERERjbkxvK2dIQXdVbk82djRGQ0hXdzlWcHI5blRBaGRwdkE0UmgzTit3?=
 =?utf-8?B?SWlOQUNPRkkrKzd0WGF6ekFtZDIrRkE0T2R3MzdmOG1VREVaNi9RMEVITE41?=
 =?utf-8?Q?MkMjyRRW3mdPddI5ZegCqdHeGhLm5A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3AvbzdGSU1HRnRNZWhPQWZzREFMdGw0M3NRYUNxRFZGWkRXVFlHUUxWeEZ1?=
 =?utf-8?B?em1hSmI1aXByTXJvRHh3Y0JlQ3d1VXNGb3ZwUDJnRUpxZzNYOWJsTVZJMDJE?=
 =?utf-8?B?cUFIUDM2NmU1ZUV2R0VGOXhNVHhPdVBjeXVUT3ljNnpkdGdjRzNhdmtvS3Rs?=
 =?utf-8?B?SnJJeUZQY0xQa255Qm55L2EzWEpSbEU3WFZqcFhPaFB5YjRDUHF6WWdDSkty?=
 =?utf-8?B?RGpQV0lyZFVhTlFKS2FDdm1WWkhnTGhqQjg1SUM2UHByczkzWmpxY2xwU0F4?=
 =?utf-8?B?U21IWnZLQkhUUU9MTTE5d05OMjUwU3BwVWJkRHYwd3lKQ1JTRFZINW5CUmVj?=
 =?utf-8?B?eE9mTDJWVWgyT0cxazlxNXZTT0xSQXYzOGlCeG9JdDNMSm02VVB5ZWpHQjRX?=
 =?utf-8?B?Ti8zL3hUVU4yMElOK0piUmpZK2FLanFvM25lalZyb0xwZlpFQnNycjY2YS9I?=
 =?utf-8?B?Tkl1amNmK0dFalhYVGQ4S0tzV2VRdWhsbUlpOTBycGhPOGs2SEVYdDRUekhQ?=
 =?utf-8?B?R0RSRHZHRlJlUzBBQS9hc2t3TUMwOHYrb3VzYVJrdlJlbWtKUHB6dm0wMERo?=
 =?utf-8?B?WDFvRGFLampmMFJLY1hKV0UyejNiMy9LM3BORStGT0h3c0R1UDhXNDBoSmV5?=
 =?utf-8?B?eXRpazB0L0tVdzUwQzVqOENYb2VvU1AvRmEzMjRLSnpSYVZaY3lGZVJ1d01J?=
 =?utf-8?B?RW00ZTJRVUFpdnRZYmhvNFVPSmhWbko1eHJRbWdmRW5HU3BtZmpJQWhzaHBL?=
 =?utf-8?B?czd4R3ZncFRobEoxb1dCNGlNTmVrdS9ScjV0NkZGV2xvQUN5amhIVTB4ODk5?=
 =?utf-8?B?R09OckgwZXNyYWIxR2dTL3MzVHk5UTNGQmpCSWhHOU0wVXB4ZmdRTXN2a1FI?=
 =?utf-8?B?eUhNL0pTOHBxRmhXYmJqNEMrZ1dXNHBNMUpOQzN0VTU3a3ZWVTF2MWtQVnVC?=
 =?utf-8?B?OVl3d1YrYlg1MmtZeHd6QVJXamZPQ2t3cE85RnR0RmcwR2VNZmJqQ3BLMjRM?=
 =?utf-8?B?a0ZKZVdkOFhZcVpiS0dyOGlhMlIwQm1VcXlSVjQ5RUFUNGdQZnJaSU9qTGZn?=
 =?utf-8?B?S3VvUXFnLzdqQXhwMzFWUXNFSHFTRG0rSmM5TkVFK2d2U1BiR3dNcHJ0VHBS?=
 =?utf-8?B?M3ZXalFZWmFUUzlFUmVNMjl4WnJ3bFAvb2pISjlYK0xJeXY1akxZNVk1SVla?=
 =?utf-8?B?YVkweGQ1dkVjZ1hEVUlOUlhkUGZzcWF0M0pRRldTd2tRQVQwWVJRTEEvdEhz?=
 =?utf-8?B?SmNkeVN5YVNqSjVxOGY4VXUremFUL0RoUFIxM3grTFhGTFZCSzNEL1Nma1lu?=
 =?utf-8?B?UjF2YlVsTlN6TjNnREthaEI4LzdNMlF2eUVEOGVSb2I3MEVZVmNiSjFmakM1?=
 =?utf-8?B?YUV5czNqMFJ6bStGT3NKK0VNUjgwL09OKzdtQ1hsWUtxaUZsNEU3ZjNueHQ2?=
 =?utf-8?B?Tm1MSlc2VTFXYW1BbXNDTUhLUFRGMUQ3R0E2VVdIaDhOUWF0U0hySXZYeEtI?=
 =?utf-8?B?YmRqUExueHNWbmxscVNGSE5kNkN3WUN2WElNeE9aM0hPQ25qdmNMcXArR2N2?=
 =?utf-8?B?a2srdDVYZkRkV1pYcjVZTjAzc0lnZG03TEsvMkhNbWQ2TUxVTlNCanh4V252?=
 =?utf-8?B?bGhWeEJLNTZRQVM0VWdPVTdqZWlISmdJRFE5U2RhWTdrZ0l5cko5eFllZC9X?=
 =?utf-8?B?a3pNNkNDOWNONUVxblpad2RoWUdnbjhTbFRMcHlUQW9Ub3ZRSjU3MFQxVjVy?=
 =?utf-8?B?dnBmK3cwSkxiR2RSNWpna05tRlE3Ly9IVGlmeFRuWFJJWThFSzZYNGpNSUVK?=
 =?utf-8?B?UEw5cnhjalpxd0VvR3I5S0JPeUFmOWlQUzRsemlVdTdGY2J2REVaRWpNSUpH?=
 =?utf-8?B?YTF0QWZBazVHZVFRZHJHN1NnTERzVkROeFNYUHBtRURmRmRhbkwvSEd5ZkNk?=
 =?utf-8?B?TXpYVE1YOFQ5N0lIQzI1UW91MWZTSXpOdDFoTjRIYnN5TUM2bURSbk5YZFlk?=
 =?utf-8?B?MUI2M0tlRFh2WDJuQWZ6ek5YdlEvR1ZnWDJ2TnVrSkVyamtsMGZWTDQxeFhw?=
 =?utf-8?B?VXhQYlNXUXBvM0xFZHFxUmNzMFJrWmFhNlhDVW1yYjFOOHI0TkIzdlNaTFFL?=
 =?utf-8?B?Q0wzdVFlNnRvanludEI3QWZTcmVtQU9DTWo1YlhVUzFLdzRwbk9lb01CS3Qr?=
 =?utf-8?Q?3DG6rsVQMe7IHSK+S2JcVJw=3D?=
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
	40Bh426LkKLRkAkwy2GqnLDfcKSuqONe8eDHXvJVH5Y/VE4XtfUNnvMzl7HOdaedbK5jFzp093vrHqHh1o3AJ2JJlby4GnMNW9mTp8koO0IND0ZErntTgVT7fRpZHokkXTijKS+hsmJToVxnEYVIyD5CuBdNk1WJ17tS++5yfBi+9B/KMKqMe9FOq2Ql/z2DNtBL0L0c0WERFkSvUySEaGA1EvxoXxHuU9ZU8FWNTZnYI+clmNm0RfF03mKV1NjU6DgLvMX9i3JX/jUy/MjI8nv2P1tO8+bIr2/KmxcvjM7eDGdiRPG1kqWKm4aJ1O8cYdUhiVJKX3jREHOTlGs1A1pd+KBLyXjuUmXgfIjQ6YDhKb5L2lKYOdbr0UaFepJbgc8dHS2FDoyve1e6p9ilB2qd2YRo836ehOudjfDrIKbXn5u176Ca1KGwOwp+e0HvKdxa/dvzQzg0uV6s8V7idbAely6fwOO3dCGL3zJa0VtlWGrxXqgMLihXS6ppNlFQW75YYOlJMdMvtjDOgDIUepA1KFivyDwKT/AUgt5qQUZ7hYsmkur7WXOmMrj3slpCUr7VJWcCbT2xlYjbkIxMEnaMZlFwVbZYdnov95z1QgVQwW7HFbJXauOoXikwtdtb
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a977041-1576-4d69-52e8-08dde15b1a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:05:55.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+gub2t6hO48gMfswAAmtjRdgQNiBN6EWLaMRgp1sBnMdTwwNZVt6cG9CQgRK/z2p/ceGs8x4qgYtXQ3LIzm2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6653
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CZNRJLrl c=1 sm=1 tr=0 ts=68a832fe cx=c_pps a=Qj2SXdm9e47dEnvLI+3zSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=61dmBc3scJhz3e39i-wA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: uFADKlyPxkVEa3nIm7IMin_Bp8VwWTdv
X-Proofpoint-ORIG-GUID: uFADKlyPxkVEa3nIm7IMin_Bp8VwWTdv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMSBTYWx0ZWRfX5MSJQEbvz0Qs 0gyL1PNQ1fi3vwCV9Zgs8rS3ptj70fXm2tleERmqavC4JT3k36HgV3bMmX9VARIySSBmpSCfKJx zypNHRKB2lqHwpT3rMkwiize1eeUpNT3CsX/jqMR2Egl94vGonI14N5c2sKElV2P1yRxo7UeSSL
 RnCjLy6NmYjcwkYhRT++ylTMj9B42kv6SNftLd2suWABgcdoTaxRlLNNebKSwuWXfe+lkUJJHe0 lsdFX4EsXyRHkKeBLL27rKYkWci22JCg2qEEMLgfq09t6mTN6SthiIYfHEamtJ4rWIwddl7Yf5O eIzSs6tFXkDDWCIJVrdZGhbogbSgnd6qadDt5J5iDkurWVUAH4cKuaG3PbGYoSJPF8ogyqNiNo6
 QfIpLrN3ehtsrDqYyALCDmewdfNESQ==
X-Sony-Outbound-GUID: uFADKlyPxkVEa3nIm7IMin_Bp8VwWTdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,

> It should be

>        if (sbi->bmgr->dsunit >=3D 1u << (cfg.c_chunkbits - g_sbi.blkszbit=
s)) {

>        }

In main.c, dsunit is set to 0 if warns.

+       if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blk=
szbits) < dsunit) {
+               erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
+                               1u << cfg.c_chunkbits, dsunit);
+               dsunit =3D 0;
+       }

so here sbi->bmgr->dsunit is 0.=20



________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Friday, August 22, 2025 16:55
To: Su, Friendy; linux-erofs@lists.ozlabs.org
Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi Friendy, On 2025/8/22 16:=E2=80=8A42, Friendy Su wrote: > Set proper 'ds=
unit' to let file body align on huge page on blobdev, > > where 'dsunit' * =
'blocksize' =3D huge page size (2M). > > When do mmap() a file mounted with=
 dax=3Dalways,


Hi Friendy,

On 2025/8/22 16:42, Friendy Su wrote:
> Set proper 'dsunit' to let file body align on huge page on blobdev,
>
> where 'dsunit' * 'blocksize' =3D huge page size (2M).
>
> When do mmap() a file mounted with dax=3Dalways, aligning on huge page
> makes kernel map huge page(2M) per page fault exception, compared with
> mapping normal page(4K) per page fault.
>
> This greatly improves mmap() performance by reducing times of page
> fault being triggered.
>
> Considering deduplication, 'chunksize' should not be smaller than
> 'dsunit', then after dedupliation, still align on dsunit.
>
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   lib/blobchunk.c  | 15 +++++++++++++++
>   man/mkfs.erofs.1 | 15 +++++++++++++++
>   mkfs/main.c      | 13 +++++++++++++
>   3 files changed, 43 insertions(+)
>
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index bbc69cf..e47afb5 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode=
 *inode, int fd,
>       minextblks =3D BLK_ROUND_UP(sbi, inode->i_size);
>       interval_start =3D 0;
>
> +     /* Align file on 'dsunit' */
> +     if (sbi->bmgr->dsunit > 1) {

It should be

        if (sbi->bmgr->dsunit >=3D 1u << (cfg.c_chunkbits - g_sbi.blkszbits=
)) {

        }

?


> +             off_t off =3D lseek(blobfile, 0, SEEK_CUR);
> +
> +             erofs_dbg("Try to round up 0x%llx to align on %d blocks (ds=
unit)",
> +                             off, sbi->bmgr->dsunit);
> +             off =3D roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
> +             if (lseek(blobfile, off, SEEK_SET) !=3D off) {
> +                     ret =3D -errno;
> +                     erofs_err("lseek to blobdev 0x%llx error", off);
> +                     goto err;
> +             }
> +             erofs_dbg("Aligned on 0x%llx", off);

Could we combine these two debugging messages into one?

> +     }
> +
>       for (pos =3D 0; pos < inode->i_size; pos +=3D len) {
>   #ifdef SEEK_DATA
>               off_t offset =3D lseek(fd, pos + startoff, SEEK_DATA);
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 63f7a2f..9075522 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -168,6 +168,21 @@ the output filesystem, with no leading /.
>   .TP
>   .BI "\-\-dsunit=3D" #
>   Align all data block addresses to multiples of #.
> +
> +If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be i=
gnored
> +if it is bigger than \fBchunksize\fR.
> +
> +This is for keeping alignment after deduplication.
> +If \fBdsunit\fR is bigger, it contains several chunks,
> +
> +E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=
=3D4096
> +
> +Once 1 chunk is deduplicated, the chunks thereafter will not be aligned =
any
> +longer. In order to achieve the best performance, recommend to set \fBds=
unit\fR
> +same as \fBchunksize\fR.
> +
> +E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=
=3D$((4096*512))
> +
>   .TP
>   .BI "\-\-exclude-path=3D" path
>   Ignore file that matches the exact literal path.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 30804d1..fcb2b89 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1098,6 +1098,19 @@ static int mkfs_parse_options_cfg(int argc, char *=
argv[])
>               return -EINVAL;
>       }
>
> +     /*
> +      * once align data on dsunit, in order to keep alignment after dedu=
plication
> +      * chunksize should be equal to or bigger than dsunit.
> +      * if chunksize is smaller than dsunit, e.g. chunksize=3D4k, dsunit=
=3D2M,
> +      * once a chunk is deduplicated, all data thereafter will be unalig=
ned.
> +      * so ignore dsunit under such case.
> +      */
> +     if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blk=
szbits) < dsunit) {
> +             erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
> +                             1u << cfg.c_chunkbits, dsunit);

One tab is not 8 spaces here? it seems indent misalignment.

Thanks,
Gao Xiang


