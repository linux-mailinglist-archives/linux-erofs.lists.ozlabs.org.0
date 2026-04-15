Return-Path: <linux-erofs+bounces-3310-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H/EGDGT32kiWQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3310-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 15:31:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA9404CC9
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 15:31:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwhqy0BzVz2xTh;
	Wed, 15 Apr 2026 23:31:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776259885;
	cv=pass; b=DhUll7LU8VDwyhjFoSRKObOWPs+GS+TvGMBZe2XiFE5A2Y477z6wes2thMJUOuiHrAB1LIXvI3LILe6JUCY3OVxjsC+lbR08yfVyp9TPhu1PdxBQA3SMsZQE2DePjChHEqt3hjEjl8JlTWbmtSwUVJeGkB8m86J6hi3p/1m/6WR8A18kh3D1VX3Kl8XrfL6t0DvtyJFZXuH4/lLG/KBwDB/cCsAKAW4Jk0yX6HzDvi2cAWU4i66YfKcs3T87TvvrHjVnl2xa4QEAI+0ruiDwdM0o2Ap1BfWU2f8Ih3Hy30OayDjoQSwLHKTHv8O6v8NPlXkBnfytmYjrPTe4sOtZNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776259885; c=relaxed/relaxed;
	bh=3Sz0LUPAnrk8tdgtyupZbc8+HSIaFYh2i4juwY4GAAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xhiq9gaWeHnzGTjKp/d2H9fijP+GQPX4JABnPq93PSuArZUmsmZfowO/iv48v5Qoat+eQ8PkTYd9bhPR4F5feRUHsiwFC0j6BIozr8Bp7XXDjnXWoXwYxu2bYZvRRzKpFDa8ym/osh1d7WVoPbiMKfYWgVZjeUwg02cozkGifqUCrXft8GMECzvOszwAwx4Dt/O1sWhl26A/BgYS6PA9N/i7+09IuFBbwXJQfZ0+q9Bx2PZ+1VbF6uFCNygbv9gFSJwYCtZekK1P9ahz/nRn89qqkeZT+2WfD+cqZCMTXiSRnzNSwgp5K9ACZ3p2KRq1qQpQoIpG7F5reO1/3HNGgA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GWyyo647; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GWyyo647;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwhqv5l8zz2yvG
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 23:31:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXPOrTAamr96eBLpVKBjmjyg7BXwtD5KmlHJYDAuwwK3Jy6O3veHyojSjMaWoVcl72mElfRuDg6mn2HgKDlQE6rwXGz5w7zu5w1Ajx5h8nFw9yq45rlvOHRUuRTOxzx6xhoJUXJGb5QDRCUgbHQ8r9Je8QcQpLXWTUZhFZ8MxS/E1NrPrI6dJ0/fAgFI9SErE7OPYZJl2hNuS/lGMs4QCYH8FhuOWbkv8uXdeFMV6V1ZewI+djoPEv+QXea0skKNoYQ0LFbYtcQmQPAlmQYxdIWrde8zFFOEDZ61HmFXZ0sR+InxXin/4KFWOTEKbXp8Bxw6+Slu2A8vACRkLmSGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sz0LUPAnrk8tdgtyupZbc8+HSIaFYh2i4juwY4GAAA=;
 b=qB7Xacl5kqsbKcQi3/nnSOiBl1eZDAB1whgyW9G1jd5yEgcxGWR4iPE/wZgYtai/ko629YzCDq6UosJZdW02oGQTfQE8uF+aec9GU+Yo+MHGzz44iW6l1R9l5kePaQ303o3yiOjxDSizV14rV8BPMAZop1ex2sQ+9jOxWlD6NANfucufL7DyS3Flg/oELBbAdX1E8CE7i+iRF9gPHF9jE2XmIb/4pBScBtuir1nte8DK6aNdZyALOwU/A1GwCcTvwiFnPQ1vmaXIrr2q2qK8utTkjCPHCJES7Awl2v7OLGJy1WvDvnRuTGEOr+02tj14Hpz/VUyuGm7eU2iQjmKY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sz0LUPAnrk8tdgtyupZbc8+HSIaFYh2i4juwY4GAAA=;
 b=GWyyo647het/PTz3oPeEAyJgjcN5J4NNuGFb1JyCpZcZ7ZbCZ9shMavL7KvM2OYZ8PfRJmrUq2iTu9s3WW1Wi8dUOXi2pvpHypQgqkp5N7SLWK0Y3Pi1hRa5EbtJkXrZfUNwmSM4gIld7leMnVkBpare6uV7NZ+XOIYTIWq0Mk/jRlLS/sCZK2g66a9SHWWG/FYPQTSwiCKqlbR1mgE6nWCEzJudNq9dgUJ+EAttxUAhlqKJEcMS15lnjIVMJsWdA1lOZ4izXybyn1PSxwc0jHR64DKE1eJiNyV3bO2Aw+TNx/PoJkRMyuCVwpXrp0q6STRskaiFgtEZ9oVrJ30Xwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 13:30:53 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 13:30:53 +0000
Message-ID: <1199c33b-9015-4ac9-ac2a-198f7235f8ff@nvidia.com>
Date: Wed, 15 Apr 2026 09:30:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] erofs-utils: mfks: add rebuild FULLDATA for
 combined EROFS images
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
 <20260414-merge-fs-v3-3-266bd1367fd2@nvidia.com>
 <3d420aa9-b123-4ba8-be3c-0b395dabb070@huawei.com>
 <cc8eda08-ba1d-4c0c-b4df-16ebc65dcbea@linux.alibaba.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <cc8eda08-ba1d-4c0c-b4df-16ebc65dcbea@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6bab26-1a0e-4041-0b49-08de9af3377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gnaV4GT6Cv/FJ1Fm3uaRYYdFA8LFZpRwAF3n5BfuVDhdK4uyt4njfif3YB/R+O2AfTXy+deQ4ufwvRHPq3Zlqb+o6rJNM7Tab16dPVDn0OXTr8laxvBekG9aVTcTtQ7YLWrZD7e64StXEkknpNlXeMsUWzhBaJZFX4WooMlkHxfRa7oFNtKgh/Jq28mP2SHT4Y+ywPr5oJ5R0So/h5W2APVIQIGKG7o5quDHm1+UfLwBMK7t/d1d+pwWYeYUngxpsoZKz+MUbiB9AIKO8q3O11iGIsHuPUJJkUip/rUyNeJhP2nyMVDHKorQLcibtIXaigeJrqeoT7DRT947To9JN6gxHNmXzVz0j1eTK8jYRXLyFRiuSzsE0wo1z7xUOeNZBRy3QPHuDnXgW3J6yaGIrAirlgmW5gQWMlEJX3N5nKDb9xjvGQ4dclB37c47bTfcqe4KnGTvLPzuYkDhl0U/0ntD7qmz56kB3Awq72c+V3OE5nSQUWleSlJiPwuHTH2d0x/CyaYM7/fz7pnYv0eCCweAVMnl0iHHB8fNqfN463AdcnMe1AGdXQybR4TNL34Af3Sj5D8i/VMGTYvee0bcVtuDpjb5vScr3+IQAX00nxvB/wG4ZMVBoPZdBu0T8NL9B8wDHykaprSEau4mMJowDCnCy2exO0z40iEHnXZiMquxQtv0yOy1Tr7rfvylNkdlFczXk+exn7IPsswLP6k/TbmINlxtYPJJeebaLoqBzVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1R4cjlZZ29wRmdEWFlnSjZQNEJYeXFpUzU2RFc0WGZHR1FoaDFHZHRSYVJE?=
 =?utf-8?B?ayt1SEhXZ1pCR2hRQ1ZDbmFyWk96aXhpZFpKTjM2R2t1c3U5MHJRWEFRY3Yr?=
 =?utf-8?B?Wlh6NklBNXNxN0p0akM0T21FR0V5U0JvTVYyTVQ0TkZEQ3pKTlE1RjJyTGs5?=
 =?utf-8?B?bWVvYWVCR1lodWVmWjQ0OHJUQlh5bUdqaG4rMnZQWWVnOGRSWkI3aFV4QTBw?=
 =?utf-8?B?M0drNHpTcDRaaCsvSTZJbjJWQkZMcHVnbkk0ZXJudFRGbVVWOGhlT1VHbzli?=
 =?utf-8?B?WlA0U1N4bTFsUVM4OFBBTzE4S1MrWUJVTEMxMDQxZmFoWEFLenJCRDFtZG9l?=
 =?utf-8?B?REhXL1NNMzV1WXNqVnFOTjRnZmI3QnlQL1Z6bk80SWtJNE5QNjBxNGtEN0t0?=
 =?utf-8?B?UFhYa29kMjNKTVFKL2QzUGQrWWJhbXZXdklYeDlZQzZzOWkvWUJkVUJubnlO?=
 =?utf-8?B?RmxqV3oxWWR1dTdrZGRlQlVsTEg3U2dEcXNFRFRqdnMrMTNmaUIyWThyQ3VD?=
 =?utf-8?B?QlNZWGV5ci91cGYwdm9jWU5YV3IxU0RUZm5MUFZzaklWOTU5TnVvaHV5SHYw?=
 =?utf-8?B?YkFKT2xMelltdkcxSEwrQ3l3a3RuV2IxczlpOHRnbjIvL2FwUkZncEZ0b0VX?=
 =?utf-8?B?ZmVYWFEyY2NwbVVFcjdhZ3F5b1Q5aEUvVTYyaFFEM2dlS2JrNmpjVWdrb1hq?=
 =?utf-8?B?NU8rOHRMM0VxazYvWUl5ajBnd2ovL0NUQTBrQ3VZdVlYUnpYK1ZnUnBPak1T?=
 =?utf-8?B?ZWprZEpGSUxhMGVmR1FKRW5tVk5uc1RnVkhPRUxNOElsbkJkMGl5N283azRB?=
 =?utf-8?B?WTVPZ29na2VJZFV1L005b2RUMFdDTUpzNlBHQUZ3WmY1YnNYRklhNGltR0pj?=
 =?utf-8?B?Z1llV2Z4eTlNcjlJWHpGbXl1MzhNVVZVWG5nQjhZQ3JSdW5iOHZLdnorSTJx?=
 =?utf-8?B?T2RBQ2RDN09uSHpwOWdSV3ppNm10L21WMUZHQ2F0WEo4WnF6ZXJWQlUwQUdK?=
 =?utf-8?B?emlrOUpKUjM4RWpXQjE0TysyUWEydm9hYVVUR1hrYWFxcTRHSGRxZTlwVXlV?=
 =?utf-8?B?V2hxcmw2MWpkWUx4c3lsay8vME9yeW8zVlV4ZVg4ZEoyUWV0ODcwOS9jUG4r?=
 =?utf-8?B?MDkycXhTQ2d0Mm5LUlV6WlBOVy9vWDh0SGVpc290ZWYrdmcxKzk1WEMzREFW?=
 =?utf-8?B?UG95RysvSnlQZHd5Vk9VSVJGZjJQNmJpVk9qV0w5akxzVjRZd2hmc0p6azBR?=
 =?utf-8?B?dXAxS0lQcGRCc28xM1EyQVliUEg2QXVHRzNsN1ZNT2FmenFKYU9GNlRSd0tX?=
 =?utf-8?B?RkFFSE9oY3N2UmFNVTdWd1JvRlZEK1VtT1Z5RnBkR3Vrb2MzdUd4VG80K3Fn?=
 =?utf-8?B?aDFyTmdxZUtkSmMyNGxuVmNLUXpNOW5RODBQdytiZDQ1dUt0dHdaaUdiTzFw?=
 =?utf-8?B?Mmd6NmlsOTYxbi8zdUh2c3Y1NWRUYjE3M3g0b2ZGR2psTXJ4eG1DZEVuZVM4?=
 =?utf-8?B?NFBwM2xkamxDWS9FT1JDNU8yN1ViZFduS0FadERuNzZOMGU2SCt6cXNkSU9o?=
 =?utf-8?B?NGFlbXpJQkFqR0RuWVpKZ2ZoRTRrd2hTTm01OTBSU0tDM2tQSEprdzRZRDZw?=
 =?utf-8?B?QUNYVlJ3cFVNcGxkVVd2MmorTUtWaFNkWG1oNE9rY2tRY1BKazY3NHMza1pQ?=
 =?utf-8?B?NFhLNkJCS0tmcUUzRWNKTnNycGdMTW5OcHZBcGZzcWlHaWxiMHBwNEdWTytx?=
 =?utf-8?B?bGIvc1hOUi8zd245TWI5ZWdza2lnRXgyemg3TzdXNHRFckZzcERhSlU3NWVS?=
 =?utf-8?B?ZUcxdU5ENnZ2ek1QeGVFMUlMZE5RN0NRSllueHRNVGhlZmJHSTd0Zzh6cGNL?=
 =?utf-8?B?R1VQMTM1VHovQ3RhYlc0Z0J1S3Y4eElTcG93am10QWF6QWduY1MrbFptRDRu?=
 =?utf-8?B?NmNCeGh0eVBBUmdzYU1EVUx1WVZ3dWIrYm42SW14WHVMZjRuT2xUbjE4Rjhq?=
 =?utf-8?B?Y0wwWlBObktYSzUwREdBU3VWclNheCt2MFhaYmJ1cTQyeTNjb21QMUZnMnpL?=
 =?utf-8?B?U3NndVc1R1Y5UUVFT2p2YUVuaTY0b2J6YTNzaG11dEtDUVNSMFFCT2xYRFVK?=
 =?utf-8?B?M2xxZFNqeWNoY09MZ0sxSW9XTXpmRW5ZdmllalNaVjRXRUhXM0R3am5PQ3Ey?=
 =?utf-8?B?MWpPU2pQTm1mRDBUZE5zM2laZGFUWVFUUGN4dklMSms3dnRiWC9yN01LVkFN?=
 =?utf-8?B?akVhMTFvbHZtUXdUTnRtd3AvQ1hITmw4WVFyNEoxelJ1bGNLb0FvbklFZC9h?=
 =?utf-8?B?azJnVGxJNDY5cGFLQWdxb2Y3RzFJdTljSXZySDR1dk5La1JWZEFVQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6bab26-1a0e-4041-0b49-08de9af3377d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:30:53.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMB7QnGiRgNQYBVnrFfNax25ddn0O9QCXNLEkeqLWAoPftqkHbDw454Kq6AZmAIElebnTjzGwHPt6/VadGJ2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3310-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 81FA9404CC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-15 3:47 a.m., Gao Xiang wrote:
> 
> 
> On 2026/4/15 11:35, zhaoyifan (H) wrote:
>> This patch incorrectly handles inline inode:
>>
>> Reproduce in erofs-utils directory:
>>      mkfs/mkfs.erofs 1.erofs man/
>>      mkfs/mkfs.erofs 2.erofs docs/
>>      mkfs/mkfs.erofs --clean=data merged.erofs 1.erofs 2.erofs
>>
>> Then PERFORMANCE.md in merged.erofs contains incorrect data after
>> offset 0x2000.
>>
>> Fixed with following diff:
>>
>> diff --git a/lib/inode.c b/lib/inode.c
>>    index bd10e26..36dce56 100644
>>    --- a/lib/inode.c
>>    +++ b/lib/inode.c
>>    @@ -683,6 +683,13 @@ static int erofs_write_unencoded_data(struct
>> erofs_inode *inode,
>>
>>          /* read the tail-end data */
>>          if (inode->idata_size) {
>>    +             /*
>>    +              * If inode->idata is already present, the caller has
>> prepared
>>    +              * the tail data and nothing more needs to be done here.
>>    +              */
>>    +             if (inode->idata)
>>    +                     return 0;
> 
> Yes, it should be fixed as:
>     /*
>      * Read the tail-end data if inode->idata is NULL; if the tail data
>      * has been prepared then nothing more needs to be done here.
>      */
>     if (inode->idata_size && !inode->idata) {
>     }
> 
> ...
> 
>>> +#include "liberofs_cache.h"
>> Unnecessary include `liberofs_cache.h`
> 
> That would be nice to be addressed too.
> 
> 
> I've applied [PATCH 1 and 2], could you send v4 to address this?
> 
> Thanks,
> Gao Xiang

Thanks for the catch Zhao and ACK will add the changes.

