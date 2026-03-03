Return-Path: <linux-erofs+bounces-2476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF7NAApFpmlyNQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:18:50 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E71E7F08
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:18:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPzxd71zCz2xpk;
	Tue, 03 Mar 2026 13:18:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772504325;
	cv=pass; b=cR21/a28M5rjt9bkvtvgmKTtAS00l4Ises5JS/DWt/ezlxycJAg4H5yhZeBgM9SNNM339tLGOZxeD6QxGDwgbasFPTJataXLPZiK2/aBj1DdPGpnemUkkuksuyvIIFCmoesIikKBI7es8SsQE0aj7Pa95KSVM8Jgbi5xjTeNbCwZg4t669Z5joERmSQ9JuIHbukd5Mt39/8+HF/z9kF8Y+di2i0O0ts9IEaXl/JQQCu6ES7AtYWcJR4qtoI7wyHTs1053n0dnoTv2S1ytazgTWZ62veP3v13pxJRoe7+kp4L3ygJKLaHHH1JrygWQbb7b4YqeqPH8YybPHzfkxHqIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772504325; c=relaxed/relaxed;
	bh=fltaoTfzJeTLgcSQtCyiHmEaAzzTGWTdXC7k2X5h6KA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MF3zzyxKcO/AKFbByH8rhq6XiQYV9KwNG0mqpBDuIizvcJzHZ9pU4SM1Jj+kK8/MGkMu4zL2m8RqhUBIH//QnEJCsfad6uddVGYFWY6XpuRF94x0jrgmxgXBvOWLVehJgy1EE486bpz3sZNwuMSFdlDezOoYxoqmMTqYaLAAxc2vIsXDfhgmnd6m1Dar212+vaZIKY6rOQHQqGzxTmVwXkm//zOcZBVK1QA0BnZ5E8FlRy0oNKA+u+KTdGcNKM4LHscpB9NLhP7+ymK7CL7qFVs7zhFn3a4C6IGjbq9rEKb4x2B6vVbVP8MEWFmKmycwRT/8b6WUA+QexPaju8OiiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; dkim=pass (2048-bit key; unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=uykjIYuy; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jiucheng.xu@amlogic.com; receiver=lists.ozlabs.org) smtp.mailfrom=amlogic.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=uykjIYuy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amlogic.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jiucheng.xu@amlogic.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPzxd14ypz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 13:18:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdT0vv8sfnTz6Q7CluceJeuAxY3+WkVy4/TBYZiaL/QQO0VsWk+bd7XtrkcfUUbZtJkQJRM+nyvsjUzRCwlRMUtBtp12RiANYmkkyaX/3KJe1vAsftjRPKhV3Zv63KfTJ+lRfKdq8I24qifD/9fc9CiSSktoq44Sr9nzNbhTNRQQSD32IEJNdxKNrVFBXyrzA72xYAylEqbKtfT3sCoErx6jRNxk5U07A4+i9RhsQ9j4HgzDePsSW3Vgep7f6SDL0TB+zMto8lZRskoABIOHvlDL7lEXVbztwtj5k9sDhScCCmY9D7YIeyCTJNWhtcmwVSjAoUy+M2yN7z5btyIGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fltaoTfzJeTLgcSQtCyiHmEaAzzTGWTdXC7k2X5h6KA=;
 b=YxacpZdOlexluAPdmL9cel2vjH8sH8jRMs/AvPVAdswhptKPfH2khcOSow4lty7i2MKUAv25kvEuh0D3b+ZFvyiJGNjYOXueXoVe/LZm6dxggt768l3ENbd2UPPJ6HfMvIWxKHuwjJAEMghQHTItu8Bn7EjsSjx0hR2NxqAoLaGsqvQ6doTRsQ+n6US9LouZGAPp26944EwVjum/yygZxHKhl4GRGHDdqM37gJtwGjkasvwbXGzROeGX66qQ30f2Kv7pE34xiZa3PpAySSc+yitdwNGMWn2D3n/uy+cPD1o+W1r83452+CsfKMqk+uO/7RDJ6qaGdZL+zxYm5LwtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fltaoTfzJeTLgcSQtCyiHmEaAzzTGWTdXC7k2X5h6KA=;
 b=uykjIYuymMmsatUoA8h9rwqB8XJN88DwcWupn9q4GnsVGEGN+ZnxNIPyWZUUH/A+vYkRzkFWAvNA1BZpIbrctnmaMcdf5Aw/DelDcaC49vOPJc0fSPLK3F6ruaVHfmHYBwDtmPQ9I7SUK5CW4zErVFOm6Y+KdtSM7rVtT+6tfgZj+qc2QvWYvZftbk6Z3xCDpRdoiQ1KafeOKqi37xn/qAt0qNFd5WTBzxhoDWNZzEpL7rbn6FxfpkA2kQx1s228lZd5O7Y546E/Gb3H4C9zOD1bCMRpyzVozT3nHWVu7Hn2ouKSA2EoQWE9WkIkrPsKj3qmDoBMu/dEBcWkm3llzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by PUZPR03MB7157.apcprd03.prod.outlook.com (2603:1096:301:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 02:18:21 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 02:18:21 +0000
Message-ID: <8dfb1ce8-037a-4e8c-a27b-9c493e461301@amlogic.com>
Date: Tue, 3 Mar 2026 10:17:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
 <b2ad3f3f-105e-4171-b735-84051906cfb5@amlogic.com>
 <6e5aa87c-f3bb-4ae9-8700-27f7f1a9d7b2@linux.alibaba.com>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <6e5aa87c-f3bb-4ae9-8700-27f7f1a9d7b2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
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
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|PUZPR03MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab79f66-2eb6-4f6f-6853-08de78cb2404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	+wW+UMZDiRoTHuFN9nkcDrlc2oXlaXBu6kGtkr8PSUQsa6zYp2FdT631jI1532e7zGn8f8rumCNj1Gd82Qs6xtAu9mryxyHI3E8xzN11B+nQAocca2PuABwr6vrEPJCHWTDfGPLlW9mVE7iFxsdqnuHBlpv0ROLLaVz8Scb8kKgy7+Egr6/hcNcmqQxdiQsXgN476EZ5TH6axCTJ00iQAqGTI9gqTSBLN2fHkOLl4nhW1/1OOuYKv64xDraVVxIixeaHz/MeBzfTUbwk9v7C/4fLiUsEiWg9IHpsre0lj+fAa6qG5gWKRjBgtGgFS0gDxwREPKMNwrqepYDLXHzXLju7Wu+cJPQfbn3V1NOnS20HYFLxxk2Pb+xQfsC8/SxS+Uoeng2Os6LRjLY3qHVV3Ys7Wu+q3twmSXh09cNe7+q5fsQZm0rKPI+q6lQB3PFG4x6uNqFVwxbiAwDPK9TEeNsZDn79dHvD1YEL31dLDZCtRUJYQhy0EPhavpXlN+NnDORyuegSEw+wqZ7RrAhJA/5vXp2Mw+bQODNp8HeqPq+gLmpeGHB5H/yeDRSTAa86YWAGHlIuB9q+AIlgZzKx/EsGsGinxgYmnDWIUMK96Em080/iTvAG3jVP/1hmDHAZh2p4s5DqgijDmF0G1UVST3kcW5EDvPiILp9eWPzG4AxCKeJN+kBPwg0iEilRch/5jVe0iYBII2SQIFAnlSM7a5VzCltykLTZG0jpJciViPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1V1VitvZjByeWFaNjBiY1NuS1BYbW8vYUV1Q2I0ZlZoZWVRQnBXU2hUZnQ2?=
 =?utf-8?B?VHRXQUR4VDZnY3YxS21aYWVvSVd4UVFOczJLNXdFTlBNZzRhWGFaays5ekRS?=
 =?utf-8?B?aDZNdkVlMVNkRFV0WmZDODJIODRMN21IWExvWDRhNlc4ejZVVWZ6S0ZvaDRS?=
 =?utf-8?B?bTlVRitkWUlPcXNESk00QlFrVUIrbjB0azlpa1ppRlNBNXlDWi9kd3V5aG5B?=
 =?utf-8?B?a2MydmREbnM5REM3c0ZSbWg1Sit6ZmlXWmJXVnRMb0VhS0VvVDBCMWFoS0ha?=
 =?utf-8?B?TFRjbG55VlpVMENPbVN2c2dYVzd2U0s0TVJyUnR2WUVJK1plYkVGclVuMjJQ?=
 =?utf-8?B?b3hkSWhMUytLQUZmYzZvSnFpVFpjVkR5Y2JhNDNLbXBmTTlnSUx0ZnhDQmxK?=
 =?utf-8?B?NEY2aUxSYkxKejNmcm8zcUxwWGk3UmRienBjam9McUxYMkxTb0xQV3ZZVTJ5?=
 =?utf-8?B?M0g5ZFRvVlF2T3pwTVZXM2p0bXNKb2trYjhkS3UvSmI3c3VPY0JXamN0aFBk?=
 =?utf-8?B?KzUzWm9jUTE2Q0xRSzl1YTNKL29neHNxbU5zZndDeVBSaGZ6Ris5aGxXbUoy?=
 =?utf-8?B?ejVlbktQSXIyM3JNTmhlZFJ2SlZWL1I4U0UzY3lHVTF6dkE1YS81cDRIRTg5?=
 =?utf-8?B?ZHRZalpNRWExckJMYzUyQmNmWllkc1FNalRiTm1qa0JkK3ZxY1kzMGU3MkVD?=
 =?utf-8?B?dndXTFBRTnBodks0ZnJuLzBSY2RRNXVHbjJoWThzbk54bkpzdWFCWlc4Z3NH?=
 =?utf-8?B?MWc3QTc4c2MwaU1zaTdhYlN5aTlwMnRSMUxrYkI2QlVKdHdsUUlIU0JHeklp?=
 =?utf-8?B?NGJZb0djRE1teWp6UE93NHNlQ2xuVWRVaUMvUzNDVHlMNFlGdEFMdHkzeEtW?=
 =?utf-8?B?OERIdjlMbGdzblBwc05tVEtNMnM2aU5nV0t6V3BFQ3lLUm1pdFg4YS9NR2oy?=
 =?utf-8?B?bEdzNnFsdCt0cmN1UHFjYzlBc2ttTUEwNGE1SkZ0MHRLQUVnMU81K3B1Rkxp?=
 =?utf-8?B?bm0rUktZNm0rNEFCakZURktUTlliSFFJdnVJdHJNc2E4eVVrdnBtV2czeXBt?=
 =?utf-8?B?U0NBZ2l3RFVOZzBhRlNZSFVvS3RvTytiMkdvSFZFZGJ2RTVadEVwTHFKSmFz?=
 =?utf-8?B?WStscGZLbHJqL0p2YUxvNDhWbDJrRzVLM0tIVmhIS1BibjlFV0hmMEsrY3Zo?=
 =?utf-8?B?bFZvSFgrOEVIR3lkWkx0bHZyOEpjRjlaUyttelBWdlM2OHQ5eFBWSHFOQzNx?=
 =?utf-8?B?ci84UUxZcEJmbUpNY2xrZHdsdll6bUJIQUJ6K2M4N2JnbmtXbUZrVDhIMGpu?=
 =?utf-8?B?QzdON3V6VkVaTnVscmtVbkNzYXI1bUZYbmxCcnI3ZnFLU1ZxL2lWajdNbXBj?=
 =?utf-8?B?UFpYeVFmdlQ1UmV3cWpXQUpYbm5yZWhsdVNUbTNqU1FYT0tUWHlkMzdtalFT?=
 =?utf-8?B?aUtra3NFS3UrZEF4R3ZvMXN0UnRUellnM2dqNnEwazUrekFldE82V3VEdVp5?=
 =?utf-8?B?cWxvK2pDMXJ6ZVp5UDFCbEdaMVREQTNFUlFoc21TblFCdWk5d3BmRSt4eC9x?=
 =?utf-8?B?enloWVBhVDhNbC9melArUjFDZTFpV3ppU2lra2NkdmE0U2YyTHZqZnJCMWky?=
 =?utf-8?B?eUhvdHVTQVk5dUhrckRmM1Z3aUsyaU5hVFpoTEpWK3FYVVRpRzcyYUdrRk01?=
 =?utf-8?B?VVordkhEa3h5RGFzVzZ4b1VKMldHWk5qbFNjcjRBYWMyaG9XOHpsNXNBOXMz?=
 =?utf-8?B?dzFxMlN4UFBDZzlON3REV1VGc1kvRXZ6amI0bXVnV3UwMEgyRGU3NzQzWWJI?=
 =?utf-8?B?U2NtNzgra0ZHSkk5MGJXTTRjcVhNRTdUb3h3QnZ0Ky84YmZmRU83Z2FsbzNN?=
 =?utf-8?B?TmFCZTFMek9ya3lUQnAvVTFpRVRrUkdMSEl4WXE4ZWszNFpWRnZydGlUQVV2?=
 =?utf-8?B?VDF4SnREZHljRVJDOVNDaC9BNElSRU92c3R1YTJWcXN6dFU3QTR4Z3h1UFp3?=
 =?utf-8?B?V3prdCtWekJKUThTOEhyNHFScHhjUkxoT3hYYkNYenNDYVpTS2o4VldGTUdN?=
 =?utf-8?B?U3lPWUNPU3JnZmZ0SEZFSE9WNGFXR1ZteC81NUlaeFBLUXhuRUNxUTk0Tjc0?=
 =?utf-8?B?MFgvRmlMaDNOSHZDb2owVHNQaGRZNlNycnAxdDl5dEVVZVZnQWRSZjMwQjhX?=
 =?utf-8?B?VFNHUUp3QnZxY1FZZGNmMzU5Z21YZFo3RldsTWczU0VQcmZWeXE5blNSL1hE?=
 =?utf-8?B?L2lTVHdxSUpFSTJ5UWtEVkJMdXN2alZnMTJISTR5Zm1wKzRJbkJUQlI3SzBK?=
 =?utf-8?B?Zlh4eXhPNlZURTh1cFI2RVErblJ5Smd2YkovUXd3SlJUSDZnZHQvQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab79f66-2eb6-4f6f-6853-08de78cb2404
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:18:21.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmtDpqaT3w2JeV4qP6s8tIdcgJAoCTOj/Wn4Jhkh3EApY2oCK8C6cdLIGhNby+MfToby3pLE4xwPyxn8t+2kUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7157
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 031E71E7F08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2476-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:hch@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiucheng.xu@amlogic.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiucheng.xu@amlogic.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,alibaba.com:email,amlogic.com:dkim,amlogic.com:mid]
X-Rspamd-Action: no action



On 3/3/2026 10:11 AM, Gao Xiang wrote:
> [Some people who received this message don't often get email from 
> hsiangkao@linux.alibaba.com. Learn why this is important at https:// 
> aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On 2026/3/3 10:03, Jiucheng Xu wrote:
>>
>>
> 
> ...
> 
>>>
>>>> that need to use GFP_NOIO.
>>>
>>> Yes, it should make vm_map_ram() in the end_io path use
>>> GFP_NOIO instead.
>>>
>>> Jiucheng, could you add memalloc_noio_{save,restore}() to
>>> wrap up this path?
>>
>> Thanks for Christoph's and Xiang's comments, I will try it. Thanks!
> 
> Just one more note: just wrap up z_erofs_decompressqueue_work() in
> z_erofs_decompress_kickoff() with memalloc_noio_{save,restore}() is
> enough.
> 
>   ...
>   memalloc_noio_save()
>   z_erofs_decompressqueue_work()
>   memalloc_noio_restore()
Got it, thanks for the details!



