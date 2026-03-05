Return-Path: <linux-erofs+bounces-2525-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOHrMAvmqWnuHQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2525-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 21:22:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4432181C6
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 21:22:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRgv55mphz3bhG;
	Fri, 06 Mar 2026 07:22:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772742145;
	cv=pass; b=oGRZf7y5HBxFz7uDt+6AxU6fad7CqI4dMNCn345B1vC48IJeILoH2VrySB4D0OBZXsOkRVI9wc3980kUPEDyYBgEYaIuOA84BWNaREd5sisfRHSZJRAMXHLX8y/tlF7ONw2ijZ14mG/Maz5FCN3Cm2Fb/rXZ8gxdAzmARqfFe2k9SRf2ziqLVVjwpsDFGF6W6QdEdqxeI4QX38eWu85wGklaFlPVMtcKu1X+KhJGZt7Xy8fMXjLoiBmMmytCyeyMWVF0I5iAxd+LzHiiCPdT1PJZWrpwpSd/XvIqWjyOd9Rd+TzjUCROZFB51GWiD0GqOV1GR2ABAVBPyveYJJbzuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772742145; c=relaxed/relaxed;
	bh=hmjbAhoJd4SNyJJyZ+rAAKVKeQz3DWGkWh+ybmU1988=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ff616OhHE9FRqv5XfaHHt0mbNIWyx6neuFAfBYCqKqIx5jrMOlmKPMPQDK+EjzYdRfHWD9uqctFz1sufuMy4901yr6utmFk2d3Prv/YPcxETg0QFRhE0/2haggAcyjcOEPykz7jAuvxGZhubxbRTX9V+yuZ3l/I4+sk4z+khzjh0x0KOV9nMOl8Y9hTo/LS1E1PHcuE9fIMLT1EHXFz0MlS9t9xvRIusB/S689781qfHw6Bu8uI7ZAOG9iYs/Fc01+UiS/ftrawyktUz+42zFIUsRay9jkr66i+Db7Zg9rfxOxCLcOZbn+GNAFUyI573+IW+WCTh8k+y9F6zW7dhOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GYKD//P3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GYKD//P3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRgv3584Jz30BR
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 07:22:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccptXS0up54bHqZs3P2yonfibrfsbpQIqZCKO+Tyt80p96aHVIB9z4EDSnbRvFwBUByXhrZa0vBGGBAkVlMwGYrVSVoZvYW1eJEv+NzXoxXu2+Ep1B1h5NH5pfRnovW0MezqTj/E/iWK6/VMYTYnXi+MBcwI6GyMUfoe6DpHcQy1aXFlClIGgTEi7Bc8uVvkrC4XtDY53qzqCWO3gLiJiU91avPZZQi2uKFn0CxpBAEVum591aIvZ9d9VmBX3PEDOZAnC+6NZ9Pej9eXMCbLYlXEjpzTLE1H9d/GAQ7beY+keVrQdIqWqo/Gi0uKzxo/EbVMsz7fgKgFnXTruKpcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmjbAhoJd4SNyJJyZ+rAAKVKeQz3DWGkWh+ybmU1988=;
 b=zMy5727Smolae2+QgBDmWTlZDev5NrBa0VSKCX310lVWFy12MmtpDXSWTCXA6H10fAPBCfpIWTtPJhFsUvMOxGiDADoSrHEqgZQtDoRoMWbppLmYOTLTR4tK8lWS4Hw9yiuv+7ZGLR1AAQya8ipt4t4a7AFnXndtlhr8toSS3Q0DfwLLHZITTFNy2d2o4dbOP3VXE5PfEtjWGa6lvffG24VZBvVye7eIthOtI5ckbSI4AckgjxBHLr6vV7iaJ6ywlxkQ3aBnU8p2R3iVbQ4fWopZAd7hP6HCD6dgm1bw1PwcyfYi0ZcCW5RLT4YKvTmquzULxls9ejE1uPmEelIQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmjbAhoJd4SNyJJyZ+rAAKVKeQz3DWGkWh+ybmU1988=;
 b=GYKD//P3ekPrMxZc9rc4V06NbfmB9qNHfEmNNEC/Xp7hts3VCjIXjq3qn71M+mByK0Abm9qr8G19AalZFZ3bewaZszxhL0oF+XsDmeIyuZ1/hTf4WFa6IRGiQD6GJRWR0SaHDi7aWJM8/ToVEY469pHsBA+TeM8uR3uR8ijTxqbipPzfh+0ovQWjKsjv+Qpk+sPrwpffserdlgW9/vH+lr3R3LHliWcpZyYSzYc7bl6JACmuEn1544ZwqppFN5V6eMZ7wlq9NZ8dMxvVkFaKYgZ9V66lrQ1pXqruR4rONmORcXu3A4uVUeW5paqEP7aq+JHZZbytH3NCnRy8HKisHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 20:21:54 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 20:21:54 +0000
Message-ID: <2e2ae86a-d858-48d1-8016-6fb5c3503317@nvidia.com>
Date: Thu, 5 Mar 2026 15:21:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] erofs-utils: mfks: add rebuild FULLDATA for combined
 EROFS images
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
 <20260302-merge-fs-v1-4-a7254423447c@nvidia.com>
 <9df761dd-7ec1-4471-8a2b-2949e043e9fb@huawei.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <9df761dd-7ec1-4471-8a2b-2949e043e9fb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:806:27::22) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdba1c8-eeb7-4ec9-092e-08de7af4d776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	3E2wFRr8rj3HMUZzPDiyK9IGHFH7C3AqXtmYBuK6dd3phGq2r/u98Cm3r2PW77SmVA2Gqm/EUid/PYRPl9SnVYZkEiVurBeugSUheA//VEpdNOhpoPd5yzm0i4NfBJJj418u1QVQqEXnZs3Ye9scfR3n3+JtWRKE1O2FQwJn33vwOG55U3vy8kz9HB3a5OxrOJGUtsXkpOkAZogfkGDFKsezmgGMSH5CNnSmup2S7SWoNeqMESrUcXoL7PmhD+2VjSPkm97Q3iukoTdB8WAXwpSpK0o6g5hHDehUYAKBwYP2EXtEMH0Ajop8nlCagx8Y8YF1o+TJoO1Kb26d3YBcHrxa9iooEYnsh/hqczkUUegvG76u/IzpDmD6fHdjLtj3OxzTO0ELHC4HQLxiMilcR/PK52MkVcEe4vgdI4qOr1Lk/KyXsfn7K++3URpPR4xC8HuUtOdlHRhXrqEAuG3gkZuMZ51/UEfOLBKsrIH+P9pG7ZjofxFUaqCXt4Wviqpv1V21SKsRnXhQzJaym4/bU/xfJwkvcmRCwWBSKTJXRh9fY091DZ72zOmVCo46RVRX0EwweD8NZR9MjPtxbKUg8GodYlLXLeuKlSfP/bEp0xV3KTLQL49/x6liwODJbm21ghLy6hFJ7e9EORAFXZt9ol4SxDrNk7x7zg0PIJDwIUuxy7H05Mz0C8b5Yr1vUbK3n3ivu6Uwy/i2FkJzuNwv23PXrXhZ+FrbUwZDMGlCnAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJzMjRTUEN5RTVINVR3cDErZm4yU3A5NzVoTWJWQ24zUW02ckw3QXZKVWxw?=
 =?utf-8?B?T0p5Wkh5UmcvOHcyWXFmUHp0Uk81SG5MdHRkQXNHcm8vejFFR2x0L0pJZVds?=
 =?utf-8?B?K1BieDR4SDJ3K3JjdzlEZFM3OVh0c2pMYzRqeGUrMHdaTWw0V1Z0YWtaTHBr?=
 =?utf-8?B?ZG1WVjJKUlN5UTlsNjBxMWZQV2lDQ0pSZFJ2eXdnL2pXNWdURmhYaTRVSkJn?=
 =?utf-8?B?eVlNaHVXbFVWQjNZRnptam5pRS91Z3grR1J4MXZxbVR0QmsxQSs4MmRiMHk3?=
 =?utf-8?B?YzBOU1BweUtyeENLQ0J2MUtIMCtSNURidEZDcyttOXRWL3ZYd2dXc3lCcFNQ?=
 =?utf-8?B?dVBhVlpDODVHWkpqUDVwQy8wMzE3OFYybjJNcGdNK3JFY29GcGdIMEZLRUdW?=
 =?utf-8?B?RlBuNkhCZVhYejNZODRjbFB4amlLdEFDMkNDVWpjNkppbW43SElZUTZoV0ZD?=
 =?utf-8?B?RmkxSEgwd0xFSW8wajUwRGhYWWJMcmtvKzVidVZIWDFQVGhTYUZsQy9rUTFj?=
 =?utf-8?B?OGE5eTNqdVhidnNHcjZqcm5jZG5DdUdZT21Sa2xBMVduTk5aRWE2S0N1dVgv?=
 =?utf-8?B?RVNZR1pQNUdmWFJMZGhzME1Fa0g4Zyt1K3FCV2t1SHFpN1dTaDNUem5ici82?=
 =?utf-8?B?MGVnRy9NWU8reEpMWkhuU296amx4TGtRUzFNTUo5b05kYi9uenl3eVZDc2xM?=
 =?utf-8?B?aTRKTUtqb1hscDEvUnl5MndObkR0S0dlTzY2aXFIZHlreG1LbjRzbkNTOWh3?=
 =?utf-8?B?dnZhVy8xTXFiS00wSXk2NHJXajhhSzJrcXpFZElDRE1nT1M0SDR0dk1iNG5v?=
 =?utf-8?B?U01SalM5NERzYVFsQ0JJcU1IZVozeVo4d2FZait2VjFIeEpUamYwdFQrbW8y?=
 =?utf-8?B?b0VjeitvdXBYbkxGRS9tTVNLOVBPNFFvVzJFR01KWVZFWUVsNmFHTHU3S0Ri?=
 =?utf-8?B?YVpMM1lhb3lET1BvTXc3bUo0ZEpXYTRBNThqTXNVWldFU3R4azdlZVRYaG5k?=
 =?utf-8?B?TnM3bkRpcDhvTHBtM3o2eit1cDRWOHRNZFBMYjl5M3NNdFR3SGJ1ZmFyV1hm?=
 =?utf-8?B?R3A0Wm1FVXd5VWFVSkkyRXppeE11VzVVZW9Ia3dIc1U4SHFzOVVGN2tCUHRa?=
 =?utf-8?B?NXBURncxMVBXZXJZL0NSdGRZd0I5dU1CTVZKYWxTLzdtdDM1SE1kc2RwNWpw?=
 =?utf-8?B?K0Zwd292R2hyMkw3aGZMeWEyc3g2MEFGL0lOWk5ML1AzVDVRRDZLcEpOMy9z?=
 =?utf-8?B?dzJmSU0zRjZoNUNFWm1rNGI3MmErMTMwekVvMkhvR01nQWVlMHlJNVRWZWd1?=
 =?utf-8?B?eFd2QnFMSzd4di9hdm5KRTJ3RHJWQjVVNVBGVzFSSDZlSVJRNkRyT1c0cks0?=
 =?utf-8?B?aDMvS01Zd0orN3dZakVDUFlTZmNOYXgzVlNVZEhIYllaN0kwTEErSVNlYnQ0?=
 =?utf-8?B?bE1WdG81NXF3SWNlblJ3YzdyTmtjSThPdzRDbmk1UXlZTjBoUDBydGJXcFl1?=
 =?utf-8?B?dDIrZ2o2WUw5SVAzaWJCZnl1TndVNHk0Wld5OFFqKzQxVUYvN2Z4dEpicU9B?=
 =?utf-8?B?WFRPQnIzMlQ1RjZYWTRVTUNaRlpKTmJBakc3S3hONllIQmpQWENDKzlmeGRL?=
 =?utf-8?B?VDVmUWIvb09jZUZFUHljcWNDYnJiUUwyUFUveWdvUUhMVDIrcXNJWFprV0RD?=
 =?utf-8?B?YUFhL3d2bmIxOUFuVVh4QmlVM2YyOHRWa3hiRWdTamtvVDluTzhXVXg0ZytU?=
 =?utf-8?B?ZWl2WldHQXRzcHVyYldmdjRKeXBVZlFrOUh4N01DeWdQTEFNaUY2b2lJUDJQ?=
 =?utf-8?B?aURFd0RxNFNVR1h0QXptZTY2NnVEekVPcEN6TjhDNm9rV1RSR3BzNGFUWTZB?=
 =?utf-8?B?S2FDY2Q0VmJ1MG9ibGJnM0lDVnF6VFFkRmlzYmh4Y1Jad3VpUy84V3h0UGYv?=
 =?utf-8?B?YWRaZmpPbWlpS0tNQTdsOWMxNXZKUTlzOVFnUklSYU5nMVI4eVZXSCtwNUFh?=
 =?utf-8?B?ZWlidFNmd25wdFhiSlhWa2xFTmlQbEppaDhkWlRtNlNWNzNrOU5oUVFZa0Z5?=
 =?utf-8?B?WHltL3VSV1A2dGxvcnFTbWQyYWFMblR4dllSTVJtZXFydjQzK2oxSWYzUDJ3?=
 =?utf-8?B?NXJJbUZyOUYwenNweDJzLzVjekJZem9NL1ZIak5uMjVMZThUaWswbGRrSWMx?=
 =?utf-8?B?TnpkY3lmQlhNQ2dtSHMxQ2JuYjNXTzVLWFVOTUZKQXNpb0JyRVJidmFXTVlo?=
 =?utf-8?B?TlRvcTVFUFN0RVFBWXo4aVVKaGVCQzRvRXVzejdXRjdyb2RGdkY4ckZMRVo1?=
 =?utf-8?B?YmNUcWwrTFdBTjFQMjlmcDdiU20wOU0xKzI5MS9uYmJRNlZFclRrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdba1c8-eeb7-4ec9-092e-08de7af4d776
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 20:21:54.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wxDyyG783D/rtcaJVA+qaB8Ihoarzo6FzzsKrsVA4klBuMU358kv7e44aKgL/cZ2mttbtBUElZfM6ECIWBTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 8E4432181C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2525-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 2026-03-04 9:34 p.m., zhaoyifan (H) wrote:
> 
> Hi Karpinski,
> 
> 
> Thanks for your patches and it works well in my simple test.
> 
> 
> I really think this function has some similar logic with
> erofs_rebuild_load_trees,
> 
> could we integrate it with the existing logic?
> 
> 
> Thanks,
> 
> Yifan
> 
ACK. I'll update in v2.
Regards,
Lucas Karpinski

