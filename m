Return-Path: <linux-erofs+bounces-2461-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODNNGnOrpWmpDgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2461-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:23:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9CD1DBBF0
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:23:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPjPV5mRHz3bll;
	Tue, 03 Mar 2026 02:23:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772465006;
	cv=pass; b=jmWLoH2nlUDuRToxCeEndsgdcZgHf3mCzj7h6p1g3q2Md2Fanr6TGJY9m4a6BLTIN91n/1FjJHE2sVRbsTwnnR9UiHn32J8Et7e8HUSW8pX6XdA+6+N9/FU/afCU+Qu/xRBv/1Lq1Zwk7UIK9WDyKKdNNsDcMU701Ag/X3eXf0GdUq+W6znVmMNqVV7l5LjviBb9iv4KOVbJ16r081kLb2pWO2+4N4MDoxtAqcTeHqYX3BpKjjJCH0xemW53JyYWIcHOyx6I5mC93BLz3kEbQrzTNhNkpVfzIZtbqoFPXNsDofkMCHeymJLjY66+xSCSkIQB0HNvoDjpEsC57TgbUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772465006; c=relaxed/relaxed;
	bh=27se4J6fqJkJbTjUV53IAxi/bHUPG7NIrCf6MhWg5UQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SAu1BnOzBq1KNBrQSkKAxsEuQt337HSPTO9AgaBHFYvgZFqHr1gWmSi0kflh86I/efQgodnbHZQ71LqRR5hn0BGbvQp1oMpGZ15TKbHQl/RVxffjYYrcp5hpWrmiSrDcY/ME60JHrrULu45931wvUj0DPWgUSxGjNQwsmdQSjKFLJ4g8/bzDfYNR2cfNsNyHW5HbaVd94fbeqaYGBturdCZY7wYutY/9h1I2ItojQUc12LOmzp37HyjJigh4UwyJyjcrsNUvXzve/V/ErGyKT2cv/ierdXQzvFzEbD6xymaxvKBbK51kbpugwh+JYPCjI2xxpEdfqWTayfFvWDo2cQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MakRN++W; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MakRN++W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPjPT6JkVz3bW7
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 02:23:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9Hnsitw42HZNP9CYXDtx/2ULSwHBi0WPZq1R5nI4j6ZNkB08LZ2gRIU6IbMG8iS8e63zYsTF3st/b1o/aq/Wx9YhIE02MJiJz9dnIgixAQSjhr4QdgCtHvt53gvPAgEEILoDLFmkJd8/MeaLKm+GMfPHzaxmM+To1Y5HN8Fir1CpB5swgdgNgVG/NrUDKTWBdJ2vFB2FRN/5d632hluPHJNtALa1bUAQn0TjUMRx4UjRirxqwqwOHz/sod0NhGC8hfKHTNu6dcteQFj9Klzt/VJSP/ZcBZ9iFQ8RdSsyGcREwRM+GN8k1zXC/AL+k2gqwucUnhLjPmPdIx3LrZRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27se4J6fqJkJbTjUV53IAxi/bHUPG7NIrCf6MhWg5UQ=;
 b=KElig0p+2Qu6X3j9HvtxiB2IL/fDcKzhnaivtEAawLEIjJd79pr1esHC9EScwjybKXUB90/lU7klKMumCE57USEVbk/ztc+pCTxuxtfmXUFtnaGEwr7xLgyqDVDsTVIsfPfAk4RsufP18L+t+dXgeSuFA87L6rlB3X7/Trk6oSFD1iAZZ4u7tKUiyh3oBZDg2PZv9jy56K+Gmi3MK1WgTIoutIy05KNNLVpNVRnicHhvI8p4ZqnTnWID0pHZkQJ/7l3n44oaEIRzgIOTG4uaYAWGaWodpD3c5Gqg6StYiB3I8xZcT9MTEN+bT7oba6xF3vFznLDGfl0hGyGxIai2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27se4J6fqJkJbTjUV53IAxi/bHUPG7NIrCf6MhWg5UQ=;
 b=MakRN++W+W9yTpkpEy/IuxH/g3U5t/ZrxzNy4IXReHljY3AJQNccyD+7hNomG0JckxrcwDkAgotH9Wgjb3+o4DJ4RwWQDBFyRh/uOUwbjusDHCZ8qBgTJE1d9kVwoMpJgatlCk06Xc+wWCtA16lZkuOOhN0fu6pszHHsN2/7cI0HiFEwLob4mj8Rt1ZzyY03TcKA1fcvuPeYffY3tYaRCE7Ro0/DlcCRHa+bMaoP7mcPO4WPUoIuETCTnhT3HQCbrMICEHjHZwttjrcP3lKAIy7Isk6NtjX79BIAEF3BUDys7GmuzbA/piMhVtigF6ZrgIGYjF/XCAIY9P0jhG5pOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 15:22:58 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 15:22:58 +0000
Message-ID: <f9c910ae-a713-4c85-80bf-e79ca6386f83@nvidia.com>
Date: Mon, 2 Mar 2026 10:22:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: lishixian <lishixian8@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, qinbinjuan@huawei.com, caihaomin@huawei.com,
 caihe@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com,
 jingrui@huawei.com, zhaoyifan28@huawei.com
References: <20260302130356.769479-1-lishixian8@huawei.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <20260302130356.769479-1-lishixian8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::11) To DS0PR12MB8502.namprd12.prod.outlook.com
 (2603:10b6:8:15b::16)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 39222238-b862-4643-7f3c-08de786f95c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	4osDrfK8cpmrfnSa16DgYiQmjqE/mxxIYllNXjr46aegVM/cEg765c6Y0NqWmRE5c414UljkAz4zAQwVGjWHH3Wfvf2eQC0T+wTfhxAPhBjyrP1IEWEp5kRXYgVvej+Fd/TR8+3U8vdj/GszcyVpjHraJLFvXx2esFDV/iN1vD0VSrJwCFvO7BJJF++ptFmjDMg+MO2Bug5pqUy+kVJ0DXC/zbhGMJMvIZ6KFvs8Z49T4blgr0++Wv/6/DpvvWwifBJ9oLSf6Z9Nn5PZ9kfrXifEgCQPMeN5rZ++GZUAPlqDdM/WGaxd2utFXsvjG/Cc7TVCnBxIjcorqCr/6ra5XzJRa3BrZfQV8L+knYq3d0OBXqeUlIJFE5EI2hASpadgkxZ0+Z7rFgrD1t8UHG+x73tDoPCt7frd1iuD3EXwQlkX/cYp73HON69dX6PI6ry7upF0z5VcH+mOiqcDE3fpcDWJakoLecfD5JCfyr1lT8PZSyK2KuzWxkEAUrMaUaKSl7rEpsjH03JHm3J/2HGBXdZeG45BS0yylfeoQFiZYHwmVi6uYnTSchA5XBWnRA2fEpV336fc0hsML5SDrX4Le1QA5HX8fVXVuc3HP/gIGIAPhEV8cQGIUmXJ0bPPeHq5Ewi0AyHRTtT3gF3M9NApodCJyljUxEheupw5BjynRUuhL7BRsDKAXUW3JeyhNRMJIIfYpniUPULZ4wAzu0o7koY6T/Ywfa8jq6DIS6VKyM0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjlPd3UzbStsNjR1aUFsdUFrem1RN1Y4bkR1RkJjMitZbWtmQllXWHRYOHdv?=
 =?utf-8?B?UUEvdkY1UEVNZmtjV1NtQTllL2NoMzdma1lqVkdTeEE5U1FPOWp1Y1RhVVBD?=
 =?utf-8?B?bUFwNXg4azBVcW96dGo2TkJ5eTdheU9lNENDM2RxQ3RTUjYyY1BnSktna1ZF?=
 =?utf-8?B?MGl6ZEpvQ3haa2ZRZkJNTUI0MXFIc20yU3lDK3hjTHlwRTVRd0Rtc0g2Zklh?=
 =?utf-8?B?UG1CaTdETmhubXYwbmdrRlRFbWU0TkJ5QkgyM2FwL2I2Q3hESTRzbmxYM1BB?=
 =?utf-8?B?UTdUR3ZGOG92M1FCZGJtWFV3eXpyTHlvUjE3dHZJZjhyZ0wxV25UYWJKZHBs?=
 =?utf-8?B?b211bVJuUGdHMkZjZ0Z2N1AvNWF1b1o5ZDhxQnIzR1NRb0N4bm5lWDlUcGlZ?=
 =?utf-8?B?RktpbCt4SmJXZmFlczhmVWx5TVYyZUlTTmlqelBPRndPZHlnTmtOeXVURnY0?=
 =?utf-8?B?OEpKdnFpZFdONEloQXNsNkljd1l3bUhVZHk3SklDNWY5alVyZHRUNXJON1Rw?=
 =?utf-8?B?NEJIeUxHZEVzdzNNS0ZiYmh6SUFuZU4zRUhoZE12eWg2YXdoTHZNOUFwRVRV?=
 =?utf-8?B?cDdWemhpcFQ3NERFRkhZS0V5VEdndmVON29LQ0JKUnFaVzByZHI0aG90YmtU?=
 =?utf-8?B?dnMwTkFoNlIwYkVhN0xTNlpmaE5rU0VhdzFXL1ljS09SOUIwTVl6eEZtRy9B?=
 =?utf-8?B?ZDAzd29HeFowdlAxb2VWWVFhVkZFT0J1TldZcVNDZEpQWHoydEVIb1pzWjlU?=
 =?utf-8?B?R0NsQ1VoYVJBS3Nnbmk2RXR5eG9wTVNZUWp4RzBXUElwbDJJeVhDUjQ3dXA1?=
 =?utf-8?B?UTBFdllwR0pMM1IwcmtCU0QxVTBGUWlacGgzK1cralVBZC9UbFRqaHVWZmVn?=
 =?utf-8?B?QVB5VE5HdVhFSFlYVmthOExEOFN2dUtpOGp2d2JsaHM0NnhaTGt4M2VONHZo?=
 =?utf-8?B?MmpDQTBjYitCbnVJejYrZGhaSUhaZFNBTmNMMjNndHRhZWh4bkc5Q2NRTVNj?=
 =?utf-8?B?OC9OcnM3NHVFeThtVzE1SjV2Y3had01JSElmQ2V2b0pwOVFMeS9IdG5qWHBB?=
 =?utf-8?B?ckltQWZweFZHcjRuK2tDMWVFTmY1S0N3MWFublNjTzgza1lyakJ5bU0ydG9M?=
 =?utf-8?B?WUF4b2FrYnp5OWVmOFEyOVlxSXNIanlJQlkzRWdpTnQ4d3RRL2d2TzhmLzJF?=
 =?utf-8?B?SHVKMklNYVJMK3VWRlo3SG1yVVdlVEdRYzdzUlFxdHF6R3MxL0hLVEpON29n?=
 =?utf-8?B?ZitUdHV1Y294UnQwMFhva1BTT0RvczlMSmZJcUl5YjRXS29vMVZlOTk2MVFy?=
 =?utf-8?B?VUNVZ0tNR2lPSVl2c1ZRNjlqa0JXOWZEV3ZyN01sb21JQmZnbGpRekpsa0dM?=
 =?utf-8?B?S21Hb1A4elo0V1dyVkk5a0NFT2V1QWFWYkRMdEJNb3R6RG9mZGluQVgvNUVE?=
 =?utf-8?B?T080b1pyT2sxTWJsMkFNdU5aaU92R0JBKy9VQ0pwSGVweGJiUlN3YTFXRlBh?=
 =?utf-8?B?cEhsRUNUZU45RDUwaEFEZkcyL3E2UWVON0JhT1RBS2w1cVpqMXo2VjBGanU4?=
 =?utf-8?B?WnIxc3o5TmtuMkRjR3YxU3ptMC8vR3VUUVBGRVZ0Smw5YktKYlV0eW9CcUwr?=
 =?utf-8?B?WlY1L1hDSlRsOFloY2t4S25EUEEybndnRUFMYmlibXl2eHdUTU1rTWZyYmFV?=
 =?utf-8?B?VGY1OG5wS2xKVFVSTExFMDJ1S3Y1QTFBSThsemRuU0NiV2FxQ3Z5aDdubHpy?=
 =?utf-8?B?bUN4VlpUK28rY0pxcmczMWZTZEExVlNPNm5KTnN3ejdjSUhNT2lZUGhVNFNn?=
 =?utf-8?B?Ti9ndTJ5SmVNUFczY1dxeFRXblZNMlkzSlM3bloyelVYb2JFN3QzQU5pTzJK?=
 =?utf-8?B?WGVyTTA3UGxRMm5UZ1VobkcxU0o1amgycU9JMlB5dmdSK3Z3MFdGM2NEQitX?=
 =?utf-8?B?a3EweFRlNGhmK054YVpuKzNzb3dtcHc0TGN6cFVGdXFiTXQvdGtsWDdwcGtL?=
 =?utf-8?B?N2hxZ25JTS85TkpwejVTY2h5ZCtURmpmelJZY3JuOG0wRTVPaCt0V3RvUGI0?=
 =?utf-8?B?UzUwbHZWK2xTOC9KZFBXRHhKK0RwVGVtR1p6WTl5bUdQY2pTaUlkaERkMDli?=
 =?utf-8?B?SEpuaDMvR1BiNDkwWktQUHVpSnBKNzNOcC94OEpTOXBVY3lSdHFtQVQzSkNa?=
 =?utf-8?B?K3NsVXFCNHhUbG9UVFNlbG9Gc1E0cGNxc1NRSEhWakFiTGRYR3BJY2lPT0lw?=
 =?utf-8?B?WkllMG1Mc0hhUXdnd3ByZTByZE5FdU1EbmlseGpHdVVBSFBla1Z6NWVPTndh?=
 =?utf-8?B?R01ueDdBMWx5bVJmd2d0T3VIRktkNTdEcTZEQUF2TkpLODdqTjNvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39222238-b862-4643-7f3c-08de786f95c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:22:58.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2Z/e9EzpY4n3+fVtem53E54FILQf31oOfYOp4hVOeoz+pyFTeDuWugDd2O7ig01eQ1MnuXygjPcUmASLKeGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7D9CD1DBBF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2461-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lishixian8@huawei.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:qinbinjuan@huawei.com,m:caihaomin@huawei.com,m:caihe@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,qq.com:email,nvidia.com:mid,nvidia.com:email,huawei.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 2026-03-02 8:03 a.m., lishixian wrote:
> When rebuilding from source EROFS images, erofs_read_xattrs_from_disk()
> is called for inodes that have xattr. At that point inode->sbi points to
> the source image's sbi, which is opened read-only and never gets
> erofs_xattr_init(), so sbi->xamgr is NULL. get_xattritem(sbi) then
> dereferences xamgr and crashes with SIGSEGV.
> 
> Fix by using the build target's xamgr when initializing src's sbi.
> 
> Reported-by: Yixiao Chen <489679970@qq.com>
> Fixes: https://github.com/erofs/erofs-utils/issues/42
> Signed-off-by: lishixian <lishixian8@huawei.com>
> Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>  lib/rebuild.c | 1 +
>  mkfs/main.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index f89a17c..f1e79c1 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -437,6 +437,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>  		erofs_err("failed to read superblock of %s", fsid);
>  		return ret;
>  	}
> +	sbi->xamgr = g_sbi.xamgr;
>  
>  	inode.nid = sbi->root_nid;
>  	inode.sbi = sbi;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b84d1b4..cb0f0cc 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1011,6 +1011,7 @@ static void erofs_rebuild_cleanup(void)
>  
>  	list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
>  		list_del(&src->list);
> +		src->xamgr = NULL; /* borrowed from g_sbi, do not free */
>  		erofs_put_super(src);
>  		erofs_dev_close(src);
>  		free(src);

I was similarly looking at this issue in my patchset so I can confirm it
fixes the seg fault.

Tested-by: Lucas Karpinski <lkarpinski@nvidia.com>

