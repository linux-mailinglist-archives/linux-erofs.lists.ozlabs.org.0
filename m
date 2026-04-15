Return-Path: <linux-erofs+bounces-3313-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAeFMg6c32kEWwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3313-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D740524A
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwjgW5294z2yvv;
	Thu, 16 Apr 2026 00:09:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776262151;
	cv=pass; b=Ie5bnFcG/eubh5tLlPp8WO/kAYpzg10hEjhyiGj2mL48Jgqb3JQcl3nof5HOSFHyuDSgBUb+ypgY5lyuEd/3ST6TXshE7U6Wgp+H4SLS7ZqHoAsALr34DKnX1NvzvE7B2bg1q9BEMHtitTqRw8V+VeqdyhUUyQrMPrMFMEWnCOQctk/OBN31w+/TuRfo0+bxWVLVk7fVB+hhnEon+Ywzk7eBJhA7igfkQ4mLXDZuqeJ0S01a7dEh9RWK14gagqvS9YsDtPU2MyJvOI87f7ePtuXTwX9W0znWzcLXfAfrmJwBWPStubLCHsNnYxiPew6o4nQmGEwrmQHRiz+KCApSHg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776262151; c=relaxed/relaxed;
	bh=Hvq/5tYWYfhtKl4UfXd6bEHYwMMk5bloThTlgmI9Ls0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTRSX4PtIDQR+6yi9KRzIkNGLzMck78DE7bEScIk5ENYeIjPiSaT5zZ85rReyvEGIzKok+WgwtdXO4uVukJhONcYIgxZ+Nb3Q/BxkVPH/RuW3eJ0dyNPc6SlJCYf+eg7h4+rou62bfADMK/xmvLJv7WrT45xsraC/9ACZuuuL0KIwfEMjbrwe/BLjMCSEM8327m0IznHst020OfHU54gi6jg/AhurJmBavMR3ov3tIj4GMYOWdnOUrDXZB8k18F0TSy8NBtYITLyuEH4eAfxYuU+JSStPGKQOXQzRMrRnYlWy/K0oiFGjm+F2ZhULjU46qOhdhUbC+4Bv/RRDfY8nA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B/ROcg1z; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B/ROcg1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwjgV3gl8z2yw7
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Apr 2026 00:09:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjqTuww0J8Qj78+maPk02F8eOkgfC+VWcusooVZt0g7tpq5xS9k6yjjy0eYkGvQOfBg4duuRVoo63bxos+Ylgbc4BQzjyF9OKI8hvWZfi3oVURGoWfj1wuqXQ0B53uqgUdaC8kfo6YxxYNSC3Kuq8vlIWN26lzRw7LacbQgiWiF2xhf+hiphUJL0VbmSRO9pfkvwMGS70i6y7CJ3933dV6PoP0Zh3FHc3UyBqE7R/PWDj8Vsu2sIjJ/Z/ZeA8nnfeKv1I4QQogbvqosaz8sXGAqA6jYlnp4sIoUiz9U7QADEYuAcn5gZYZ8yPiEXIrad5rw6vMv2ItiMdvV+9zrtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvq/5tYWYfhtKl4UfXd6bEHYwMMk5bloThTlgmI9Ls0=;
 b=rKfnA7zIkuvgDhkmVIrPxGTnFvGi3nIvoaUVfvvuojY2KeychSPre2rvFWJXK7seKSZ3pLrGQZGbjd0Reev4fuuq8fGFuq2aYyYSKrt1f/LgIJjTj3cscyaOtcPDILd5yvKcQRdG2jhDllnuUNbcxEk7XxFgB5emvOk+h/xouY0ycO636Knkci8GobhBt3Iw31bWcCxW6RTjOpc4yz9jgf9TzGpmcddY0VOT4ulehNF7J+5puHL0BEIoHRysSqUGQbEJbdKMX6+CIZJkCC0IR2arsd+EIGO3UH59KaF/RiR6WD+zYsm8+uOhGHnFNDHPyMc+H00N+yLZQCvBoQK7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvq/5tYWYfhtKl4UfXd6bEHYwMMk5bloThTlgmI9Ls0=;
 b=B/ROcg1zqYXJNLRuhzFWTOH4FoDZ33e2hrtciIJcbR/8CtmhMvC3owptZEEJrG5weSv6PGwqQ34abawvGLBTmhT+izlmRrUI4K/VzHoSzdBxlcy48uiac2NZK205aELbIqdkoMfNZgTq3axHS963Bw+SEuN+FH3jTPPGCvKAoAVdBeJbb1tPXkH0QNnSYBlCbtlOskZullZnqeFhDLTpP5/NX/4J92x9eDLYs4aKXGX2DUDicvFo+8VED3KH4PIL+MrCQpMTLwKtt9qsLtLZcFv6uEaS4Xj5U9aDNnmtf35hi6N001fId8Oooqw4a+7Yr/MIBvmzyKn3vPJMZINrnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 14:08:42 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 14:08:40 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v4 1/2] erofs-utils: mkfs: add rebuild FULLDATA for combined EROFS images
Date: Wed, 15 Apr 2026 10:08:09 -0400
Message-ID: <20260415-merge-fs-v4-1-4c6860a62255@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415-merge-fs-v4-0-4c6860a62255@nvidia.com>
References: <20260415-merge-fs-v4-0-4c6860a62255@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ba51df-b2bb-47d6-d5b0-08de9af87eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JQk7U8YXPKDunfeHxwbeNOWyOxkCFDQq54773576n0uIapWKMZD9PbbPnRO1B0ALAgUE2jz5t6P9+mK/elA5mn4ooRMdO+/yU/s9DlPx/Q+Yp7bpQarURi3SvYxzVpUWT0Jh8ID0n+lTotdbvR9sT1hGh+Cb/peXpPYdubQZLm4n/0W/ZiSYw/WcUsxJa2SWoWrzDadMC/UcRlzMSvpksL1fNkADouLpt1e0kRtdcukD6/TbY79jSvrl1FShVJqwaBSw0A6Nb1bRIKplg57RAYv2lDGW27GuhAB4clt0doNdUir4mokNUUVFh/eybtFAuJkD+mX9nSMEwc7OUSWXtHpIvhmNZ1QnlV9iRfqT8aVwZP9qQ0wQMMImOPL6OXSPBbckgUn4nbc5nQ6xhVlwL23POD98VXz7qvyZIfMoDnd4KQSzcH1wbfMuHh5G+vFEhPWJDtk2EQBvJ7CTw10vB8512Xbs0ujaFuhj/9XQNK97flvX7mcWvW6AwwRbVSYNFg5Hqx97YVAoRIuu3YMcUVpi/yDyJRBQdVVr88GjDGZkghBvJfP37C8D+dDjQ/T2uvUWM8bE23txriowqhaA/e9PD5WFr6FYES3O96JHWPL5paE1B17TtXY+qldhgiKGQjdwQgflKeWM1Yg5N6lBwez4bnVHqKlLWHmx0ax8ngHnW0eTx8+2AW0WDb1vDfApt4RjUa/2FwaJiuKksg2EcjL12+O6LZCuJ7q+9J8dvyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dBSFA2WEF2NjlhbFFHOVU1OUY1N3Jad2xjYUQ3RFdhOVY1S1QzS3BNSHBU?=
 =?utf-8?B?RElVbmNYZE13MWhtTDNaTUlMSjl3dVhkUC8yazExZlNHMzY1cGJLazlCelBn?=
 =?utf-8?B?RGR4ZzBYcWNud1NsNkdUTlNDYTk4N3hMRlRWbkVCWTRRbzV0OHB1OWJ4NUNS?=
 =?utf-8?B?emk1VU41aVFuVHB4aFVFTE1STkU2eHV0Y1JTNmJ5UHRDUFJxWXlBVzFEYy81?=
 =?utf-8?B?VFZycXJXdmJZMjBDTGpHb05ubGQxVGZQOVdtWERjMVprdzVpMTFrNkU4Uk5U?=
 =?utf-8?B?aDB1NXE4SnlyQmtXRDQ1dWhtcDNsdlFQUkhsa3pzK2lJWlNWV3ZoTnRJaHlW?=
 =?utf-8?B?TjhCc3Q1Sng3QWo5M1VLQld4WlNCMTNvU2w0UlhNN3FFNFFGNkVib20wWFZx?=
 =?utf-8?B?dEhhQ3l3WStXTTYxMFNNYUNhSlhzUWNoekhrcTRjTUdzNERjc2NxeEhtK05R?=
 =?utf-8?B?ditzNWVmeit6am5IZXQzQ2V4YVM1VSsvVUt0LzlYQXFlQkRtZkFicGlobTlk?=
 =?utf-8?B?M281SWRhK216bXBsT0x6bjNadlAzL2R1a2JVWjFhdEt3SE5MTEpBTE5MVVVF?=
 =?utf-8?B?ZW5IWUdueGxFMmNzZTIzc05mUHhFcmUzTVRGUFpuKzBzalV0blFtRlZZclNJ?=
 =?utf-8?B?UUdtNzlBb2c5UUNZbG5VeTdZcERPV3hTeTd6elFuU3BWbkk0YnpQQnRWaWZM?=
 =?utf-8?B?ZHQrYkdPcWtWeUJnc1lHcmRid1BKbitlYU1VTWh4YnhWMklPelRBRi9hUlhR?=
 =?utf-8?B?RlRtd1BFV2tCNmNWY2luTk10SEsxUERJRXRzTEl6N1d6MnoxSEtPOHBIRUx3?=
 =?utf-8?B?VTk5UjR5ZGdBMlJCVFp0Vk9JV0Q3WForNWhzNloxNjNtVEQ1SGRmN3F4bml1?=
 =?utf-8?B?UTV3SXFhdzBnRy9VZmIxUTdVOXFCMTE5SENva1VCQ2pyNHAxY3UzRWUyUmxW?=
 =?utf-8?B?aG9leFlsSlpTSStWN29tT2R0akM1Ly9ZWFRwNDZsOU9oaDZIZG1TTnBOc2dw?=
 =?utf-8?B?djlzU3FGTVVPckk3eFg5QWZiK0R1cll0T0o4a0dhMC9pNUI0UGxmTkxSYXBH?=
 =?utf-8?B?d0szdWFXRytUdUxOMmp6OG1Vc2RZQ3UrbTJIdHE3NmZza1dTaXpaZ2czb2Mw?=
 =?utf-8?B?Y01lODdEYmcvZUM3OEt2bmQyUWFRTWwwL1VvcGVsNkFVZ3V5TTk2YmphLzRT?=
 =?utf-8?B?a3kySmRTQ2FHSDRlbk80SnJCMkFoYnFZSTcwSXMvbXRpTXgvVVprRWpOblNR?=
 =?utf-8?B?NW03cGozbWxPRnU0a0RsR2ErY3gvMks3YTlGNEYyQndPYTNMUnIya3hXK0Rz?=
 =?utf-8?B?SXRYSWpnbWVaSDVuQWd3S3N2T0Z1Ymg5T2ZsUFE2cEtMU1Bpd1IxSGZ3cWJO?=
 =?utf-8?B?NzhvQ0hJaElEN3JqV0JBT3duM1Q5NUlvcU4rRStCZGVPODJiL2NIc3pMU2dp?=
 =?utf-8?B?WmtoNGI4TURESVdyVEUxeGY3UVVkendiTmtaRlROQ0VVSC8rTXpQd2tLb2JU?=
 =?utf-8?B?ZWN2NFUrU1lWS05OYjNtSTR6bVRJa1dpQUs0dGxpS3pPVVZ3QzFKdmNHbHNW?=
 =?utf-8?B?THVSV3BaYzRDaFZ2dE9DQUpTVURkK3J5YncrVkVUMkJudW1hZ0lQVmdlc204?=
 =?utf-8?B?VVgvbWc1aXVuS1htUGJpWE9QMDNHaklFMy8zOTBtbGFkeDRlTTVsOTZMM3lu?=
 =?utf-8?B?cm50UVMyZkFuM0hiZitWeVpOY1hwVFFWZ1V1alMzVzE1S2o1bG5HQ0Y3UndR?=
 =?utf-8?B?c0Q4clM3dWtyZWJsUHJuTkpJQ21GNGNpQVB6VFlMcktINlBOb2tMYTN1cFll?=
 =?utf-8?B?TnU1MEZZSWlnS3ZNajlHR1pTeVhkSS9NdTluNGhLTk8wTVdoQzZyM3BZb2hT?=
 =?utf-8?B?RmVhNUNFUHlSNzFoUHI2Tk1HVXordi9WOXh3RlM0Qlo3VjdYREdzdGVmVnVF?=
 =?utf-8?B?WmFEM2sxeHZ1TnFuamhXa0ZDZWxsakpWTk84NndjemNkZlA4eTB4M2MybWVZ?=
 =?utf-8?B?TDl6MjhNb0ZOSldzbHFSYVZNS0hEcXNNUzdROG9zVisrUXJWcjhIMGNCMzQ0?=
 =?utf-8?B?ODlVc3dNT3c0aWVoSDY3L0JKb1pWM1ZLcGdLc2lPK250WFFoQ1k0YzJ2Rnhk?=
 =?utf-8?B?ektKaVZ4MVhqQis1amo1L2VsSWVKUFNTQmtPcVpDM1dqWXJDMnBVZk9IS0pD?=
 =?utf-8?B?czNyUkFkRE8xQVhyaXR3TUhVS3JEeCtPMmFHSFNhLzJYWTBPRnZQaGJocmdW?=
 =?utf-8?B?TlFFTlZBS3EzVW8zRWFUdjlRM2tNMS9WSml2TE5NcDZwdWs0eFFSYkhmRDkr?=
 =?utf-8?B?REpULzhNZmZSa2xSL0dUMElxTWRPUjM2TVpudG9vM2hwSTBGQjFPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ba51df-b2bb-47d6-d5b0-08de9af87eba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 14:08:40.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFRJuEXezQlP9Rlly7X9SMM4EyYGQQfaC3EdFzBf0sSHn8+WDSYfMsXUcgXixCdizmKRgocAi6H2d5nNtt6bdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3313-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9D9D740524A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add experimental support for merging multiple source images in mkfs. Each
regular file record the source image path and its byte offset. During the
blob mkfs opens the blob and pulls the payload in via erofs_io_xcopy.

This does not yet support chunk-based files or compressed images.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 include/erofs/internal.h |  3 +++
 lib/inode.c              | 38 ++++++++++++++++++++++-----
 lib/rebuild.c            | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  7 +++--
 4 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index c780228c..450e2647 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -208,6 +208,7 @@ struct erofs_diskbuf;
 #define EROFS_INODE_DATA_SOURCE_LOCALPATH	1
 #define EROFS_INODE_DATA_SOURCE_DISKBUF		2
 #define EROFS_INODE_DATA_SOURCE_RESVSP		3
+#define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB	4
 
 #define EROFS_I_BLKADDR_DEV_ID_BIT		48
 
@@ -253,6 +254,8 @@ struct erofs_inode {
 		char *i_link;
 		struct erofs_diskbuf *i_diskbuf;
 	};
+	char *rebuild_blobpath;
+	erofs_off_t rebuild_src_dataoff;
 	unsigned char datalayout;
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
diff --git a/lib/inode.c b/lib/inode.c
index 2f78d9b8..95fd93b9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -158,6 +158,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 		erofs_diskbuf_close(inode->i_diskbuf);
 		free(inode->i_diskbuf);
+	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
+		free(inode->rebuild_blobpath);
 	} else {
 		free(inode->i_link);
 	}
@@ -679,8 +681,11 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 		} while (remaining);
 	}
 
-	/* read the tail-end data */
-	if (inode->idata_size) {
+	/*
+	 * Read the tail-end data if inode->idata is NULL; if the tail data
+	 * has been prepared then nothing more needs to be done here.
+	 */
+	if (inode->idata_size && !inode->idata) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
 			return -ENOMEM;
@@ -697,7 +702,10 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 
 int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	if (cfg.c_chunkbits) {
+	struct erofs_vfile vf = { .fd = fd };
+
+	if (cfg.c_chunkbits &&
+	    inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
 		inode->u.chunkbits = cfg.c_chunkbits;
 		/* chunk indexes when explicitly specified */
 		inode->u.chunkformat = 0;
@@ -706,10 +714,15 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
+	if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
+		if (erofs_io_lseek(&vf, fpos, SEEK_SET) != (off_t)fpos)
+			return -EIO;
+		return erofs_write_unencoded_data(inode, &vf, fpos, true, false);
+	}
+
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	/* fallback to all data uncompressed */
-	return erofs_write_unencoded_data(inode,
-			&(struct erofs_vfile){ .fd = fd }, fpos,
+	return erofs_write_unencoded_data(inode, &vf, fpos,
 			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF, false);
 }
 
@@ -1508,6 +1521,12 @@ out:
 		free(inode->i_diskbuf);
 		inode->i_diskbuf = NULL;
 		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
+		free(inode->rebuild_blobpath);
+		inode->rebuild_blobpath = NULL;
+		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+		DBG_BUGON(ctx->fd < 0);
+		close(ctx->fd);
 	} else {
 		DBG_BUGON(ctx->fd < 0);
 		close(ctx->fd);
@@ -2014,6 +2033,12 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 			if (ctx.fd < 0)
 				return -errno;
 			break;
+		case EROFS_INODE_DATA_SOURCE_REBUILD_BLOB:
+			ctx.fd = open(inode->rebuild_blobpath, O_RDONLY | O_BINARY);
+			if (ctx.fd < 0)
+				return -errno;
+			ctx.fpos = inode->rebuild_src_dataoff;
+			break;
 		default:
 			goto out;
 		}
@@ -2022,7 +2047,8 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 		if (ret < 0)
 			return ret;
 
-		if (inode->sbi->available_compr_algs &&
+		if (inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
+		    inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7ab2b499..74bbeda3 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -14,6 +14,7 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "erofs/io.h"
 #include "liberofs_rebuild.h"
 #include "liberofs_uuid.h"
 
@@ -221,6 +222,71 @@ err:
 	return ret;
 }
 
+static int erofs_rebuild_write_full_data(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *src_sbi = inode->sbi;
+	int err = 0;
+
+	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
+		if (inode->u.i_blkaddr == EROFS_NULL_ADDR) {
+			if (inode->i_size)
+				return -EFSCORRUPTED;
+			return 0;
+		}
+		inode->rebuild_blobpath = strdup(src_sbi->devname);
+		if (!inode->rebuild_blobpath)
+			return -ENOMEM;
+		inode->rebuild_src_dataoff =
+			erofs_pos(src_sbi, erofs_inode_dev_baddr(inode));
+		inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
+		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
+		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
+
+		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR) {
+			inode->rebuild_blobpath = strdup(src_sbi->devname);
+			if (!inode->rebuild_blobpath)
+				return -ENOMEM;
+			inode->rebuild_src_dataoff =
+				erofs_pos(src_sbi,
+					  erofs_inode_dev_baddr(inode));
+			inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+		}
+
+		inode->idata_size = inline_size;
+		if (inline_size > 0) {
+			struct erofs_vfile vf;
+			erofs_off_t tail_offset = erofs_pos(src_sbi, nblocks);
+
+			inode->idata = malloc(inline_size);
+			if (!inode->idata)
+				return -ENOMEM;
+			err = erofs_iopen(&vf, inode);
+			if (err) {
+				free(inode->idata);
+				inode->idata = NULL;
+				return err;
+			}
+			err = erofs_pread(&vf, inode->idata, inline_size,
+					  tail_offset);
+			if (err) {
+				free(inode->idata);
+				inode->idata = NULL;
+				return err;
+			}
+		}
+	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		erofs_err("chunk-based files not yet supported: %s",
+			  inode->i_srcpath);
+		err = -EOPNOTSUPP;
+	} else if (is_inode_layout_compression(inode)) {
+		erofs_err("compressed files not yet supported: %s",
+			  inode->i_srcpath);
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
 static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 				      struct erofs_inode *inode,
 				      enum erofs_rebuild_datamode datamode)
@@ -265,6 +331,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 			err = erofs_rebuild_write_blob_index(dst_sb, inode);
 		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
 			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+		else if (datamode == EROFS_REBUILD_DATA_FULL)
+			err = erofs_rebuild_write_full_data(inode);
 		else
 			err = -EOPNOTSUPP;
 		break;
diff --git a/mkfs/main.c b/mkfs/main.c
index 6867478b..d75c97b2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1756,7 +1756,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		extra_devices += src->extra_devices;
 	}
 
-	if (datamode != EROFS_REBUILD_DATA_BLOB_INDEX)
+	if (datamode == EROFS_REBUILD_DATA_RESVSP)
 		return 0;
 
 	/* Each blob has either no extra device or only one device for TarFS */
@@ -1766,6 +1766,9 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		return -EOPNOTSUPP;
 	}
 
+	if (datamode == EROFS_REBUILD_DATA_FULL)
+		return 0;
+
 	ret = erofs_mkfs_init_devices(&g_sbi, rebuild_src_count);
 	if (ret)
 		return ret;
@@ -1788,7 +1791,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
-			erofs_uuid_unparse_as_tag(src->uuid, (char *)g_sbi.devs[idx].tag);
+			erofs_uuid_unparse_as_tag(src->uuid, (char *)devs[idx].tag);
 	}
 	return 0;
 }

-- 
Git-155)

