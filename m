Return-Path: <linux-erofs+bounces-3305-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG1PGneR3mmqFwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3305-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF43FDED9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwDR70ycJz2ytV;
	Wed, 15 Apr 2026 05:11:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776193907;
	cv=pass; b=KpgJ7HItYf1F/6+8wbjDdHZBHZivmA6gV0kepn+ALTzksZkOxrVJT6HTVPzHpEuG4xLeTUUhD+eGjKZPvIOyye/hTo85uFzQPTPcLfh36iHUKW/f0FgWOfW+jFRewF9J5pEXeNKdRAbn/x8A42XjKJs5ID2z4wJSZBYnht/neuO1n1r9ER3SA9b2MRx5V1Iol/4zWHhxe9p2P9QByBV6Ah4L4SKjxsPt1a0Suqwc0iN23s1l9xHRLe6cw6fTT97MRlzDp0b0KUKvSkuuxHRFjsP25kOBpNHScvrkBDvOVkd5B8nyRiz6/Ja4NT3T1tcCTkXHgPTKYZxZOpnYI8TrBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776193907; c=relaxed/relaxed;
	bh=QG4lSgok9IM87DvUqLNWbOO6qsVODAnohim0g8YXRNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnZJSkUkP0fBS//dOnPQrs/vRV4tqqs5JfJ0KK6+zEcdCBU4J3p46y/xX7U5uttIDmCTQToXayREQFotnPII2Ig5+4HMvuSvbglu9aBWc8eBGVfgBvikXoc+VAeHVS9Y5UPXOnjn+1j3j0W1U+8qx+vW7OhcwlJHKswBTk4mBgBrrEfNIdAaayBAZ6LH3wBBl0v9Njtp8JoBgneVvbBfnkkeV0vw+g5scINVLxjmEMvi+ZFoNP2UZuo0JnMawYv2G4m2w1JqtEqmzj34U12LyTFBioD/EUXLRqK66KhBLVkGz/dNLbuPfthu0ndNVRXonIcvPFACl0gGwB0hWkmaxA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VqbRLmVb; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VqbRLmVb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwDR63n5hz2yrT
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 05:11:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Ev9H/l4g56qShIYxLUH7N1MVJQeAOl7pO7wNFnzCaFoHGTM5B6JgmAD+6r/SlqRaJjz+OM1j1j2ucY3luK2lij73ehm/zCilQCzKpq1Vz33AliaPo+TVB5iQSvwAPOMqjKiyZ6I6mhH/LgauKDjec0y/Rdu3koengxzc/dZVcLkQlBbHwZ7RF7Q+yuhTYPSp9XablZhc8qTVl+5YEWoLxEDVe61Kh2tateqUP8Qh2xkYN4l+FwWvvA9TQwPo74NpagkkaDCD3tM7RU1wtRPL63rjrxcitoQ7LFdWLZWRkHMlbij+UBs3oPYid8rwhMNvWpdvKCWv6s8b5OscESow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG4lSgok9IM87DvUqLNWbOO6qsVODAnohim0g8YXRNo=;
 b=YSG2/SoYnYb0fjgpWA8F4fqrEBSUdT7dm27/TpaeQv7kK64yuaQz1wCMUYiyYj0lpNJHgzaLtzgfuaVoEd7JQjbrE1MywTiEDqZR5I3JS8f52svnnH8CbQoJZ8KXYINKQoMLcjqU2q0nUhVbbq7xp4t250EcAiRQi5tFn71jiXw+4xZbdT7Ltev/fzr5heANhBGPom5uOCS6DzFLJDQAPDTEmIj0FBZY1BcGtTeMUepUYMInNlzc5euG0j09Fhit7TX5iC6jPAeXBbdpDV1Z3PPEtVcaZzMBCVPmDkTyaL2Cf+Td24DzQFYqcAX8Oe9aiNMlIUa23DJa7K5cqSrNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG4lSgok9IM87DvUqLNWbOO6qsVODAnohim0g8YXRNo=;
 b=VqbRLmVb51hRWL51u/QFv3XEsZ9v8cgTKHPXibbprDLfiWB2IBiLhXm2EUbnn8s+AXPVTKuRCVfmlfQA+V/soMRpfwJBkMhai2LPE7I4lhc/agaeqxOP42SsC7ypHnLfzD053pstdvQjWVIPIAXADCqGmhk9BlFYmFYMnsdsIKhUH8C39mLrJVLLrjw5uTFHnjcCibi/WLBOAJyMhg5BKeM8zZn8IEqvVf7QiHU2ugA8qsPxmOJvtgH/bcDUFLkb+E8t6RlhWESj1bKXd5ul9Mzpv97nlBDnyWEJuPGCHUun7b6fTQs41K/seIOot19YwWs1CDLt3OlYNpEn49axrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:11:07 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 19:11:07 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v3 3/4] erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
Date: Tue, 14 Apr 2026 15:10:41 -0400
Message-ID: <20260414-merge-fs-v3-3-266bd1367fd2@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0d34f8-c0d2-49a8-8636-08de9a5992b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Bt1Sm7fczpzRjf6wqlp8v4m/OPzQtOEzP+9pqzYV91hJep7HNcVoeYfz6UCI1TF8ahmMityPTyqzMthryZnH31vX75ya7QeJhxfjGUlg8QtPXTYa1dZlT75gtQ3UrB6J0sWtyzAODKmCrlTymrg0vdo1U3k68WSkPUJJkK/eLH63UbnNlc8v39RgLcm/jT30CgiPHfKSW4SecwPIYWofjoE21I1oSY8QAxDcLD+7+X1AmuNoKGBdJcJ0/WgYV57I2KmBVrcS31LGohFjw7NyotZhmJfYGiQrw4xE2ycv1elSo6bgLhCq6KK1bLwsAsPrnxMxwVCmTqOzhI9fDBT9SZX979szMvZ36Bn3BAjTysP0VHOWej0216B9mLRusAP67v6mAyUOexRI+wLKd4JkIAt88SrEIS01wD4jWAQOJYLs1x11j6ovVlStpjnl2UZXzfj4QHm3/X+WwMhUSParbHaiPqgW/xpgtIaXmIcFCCIFpItDEj1+nhxUSWE3uOKIgWiNFlXs8hIppo93lXqwKTOlOKi9N8psNqBIwM9sg55NOGo5Ls3+E+3uRYoA0mkpireTpU9/lSq7RhNEbQN/VFmSgiRdifET6PIXHC1c5Mi4pvl71rkIbXxQDdM5XblIzH4wrx46NEHPfumGk6/9Vj3IGryWFNlq0Iwlqq2PmUPQuzpZk0HBuFir4KrLYq9qJrpQRC3E8POwQmm8bGrEFWyXn7AlCipa/nTmfCInPr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWZxWGRNU1gwVFFSVCtvUExEV041K1FrUmJ1cmI5Vm9qVmpiYVpvMFYzZXR5?=
 =?utf-8?B?M0RldXVYSHFIeTVCaVFKbW0wUy9YMngyZmJaYk9DSU1RTnkzdnE5UFRvbUFq?=
 =?utf-8?B?YWxVdmNLS05CWnFZZUZYcEdqdzdUcjVmZEJOdW5rWUZJSVBzeUt6dGgyUlox?=
 =?utf-8?B?OERLNU05VUgrSTNWTGRNRUIvRnY0UFFWR01EbC8yV3lYV0FHa1NMbkpFVTc1?=
 =?utf-8?B?RDRuUFlFNTV6Uk5rMnJxZ0pFTFhBc0FteFBEQk5lNDJ6R3dOTlZDalE0bjNq?=
 =?utf-8?B?TndrcExhUlRtZWRPQVc0STgycXNXU2VoTHBhMDRuOXF2Tnlpc3g2RUhQQVFV?=
 =?utf-8?B?cWNJLzVjcXlEaVpPMjlQMldjZk1ReDFEdjNrTGEzMTB2Zm41cldFWmUrSU1L?=
 =?utf-8?B?L2R1U1hoV05wWndpR2Q5NlZMZEJZUEFjR3lsN2hKbVBRZHRPVzFBdE9vckd0?=
 =?utf-8?B?T1VLUktaUWRJN0VweWVVMjhmNWtQR0hqSG5yOFhqZk9OMmZ3UmYySjFTQkVU?=
 =?utf-8?B?QVlLZzdhb2RBeDB4NUp3Y0hpOWwyMGkxRjlVQ0dicUFuQkpMd3BuQXNPaWNP?=
 =?utf-8?B?Smh1ZWxQTE1SU1F3bjdRcklFMGw1MEN4ZEt1emFMOEZZRGVkRi9PeEJvbC9a?=
 =?utf-8?B?SlFESmtMcWZuRUZoc3E2RklPeG9VUnp4by94VDJuRXR1REFkeVoyTGN4Szl5?=
 =?utf-8?B?dmh4NVRub3pYa2tSdHN4NkpsMXMrSFQxUUdrakVyMCtPckNudXNHMXN5dHFm?=
 =?utf-8?B?ZzFlL1U1QU0yTFZ0WDZXaG05T0o1Tks1TmdhNFcvSkwyUnEvZlFpSlJqSEM2?=
 =?utf-8?B?cjhvbVozMlkybGplNDF1aHdaRjZWWWVXVTVQb1FPM0dyRFV3MllwYy9GSkRK?=
 =?utf-8?B?TTgyZnB1eWd2TEtlMXplZnZ0RTNUZ2lVVXFBNUdnZTNORHZMT1oxQUhydG9u?=
 =?utf-8?B?cWNNWEl3bnZCSDAzM0NxL2xQaWdaWlVQZm9KdGY2eEJab3Y1U3hlTmhlWnRn?=
 =?utf-8?B?UktDRlZEai94NE1kelk4cHZsRmJ6ZE1yTlRLT3h0VkpaYi9zQ3ZPQlUxOEx2?=
 =?utf-8?B?YXZrQU1PYnd2Y2RtUjUrci9GQmwzZzN2WHFvT3c0dzJXamtuN1NFamowOVNI?=
 =?utf-8?B?TlZVRHduSmdaYWpWNzhJK2ZpMm81bUtCenE4R1VsL2QyYVZhR1oxUkVITTJT?=
 =?utf-8?B?QjVUSWtlbXNaQ3dnZ1ZySTcxUUJrZWpoYU5TWmw0b1dLc3JEY1VHRW9Fb2FN?=
 =?utf-8?B?M2xsdytXcngvbnNZM1VvSUJPYUtmcFdiSUxaS2drYVg2NWYrY09iNUNBNllJ?=
 =?utf-8?B?WEFVTUhGQUpLSVNyelBTQUVyV05MbVJjVGpzeGIrTnBuYjJrbXVObnZLY0Z4?=
 =?utf-8?B?RHUyTTduZmFuVWtpT2ZYamxiTXlYdlhWeGhqQnJEY0NvRzJFSXFhVUJmS05X?=
 =?utf-8?B?ZEF1Y2tuQU1ENnI1Q3Q4YU1GZHllaVVqSllwUWtZUWNTNUpFRko1eW4xQW94?=
 =?utf-8?B?YW5LYWpuK3BTTWNDQmVXNm5ldjB5eGhYc0NyUHNuSGk3NkEwMysyWmlkRGRo?=
 =?utf-8?B?YlRTNW5NVU5BZ3N6SHJwTGNMR1AzWTB3b2d3ZnN3SXlkVk9iQkxzL2sycWFo?=
 =?utf-8?B?S0JRWVhkTEg4clVybDExTEdUVGplSVNiL3BwdmdqMlBNRUhvUDRIcERLVFNo?=
 =?utf-8?B?RVpqVHhFOGdpb3FaNWFzQW55Q3MyOW85L2xKRWNjcUFrTWwybHVjR0JydnFM?=
 =?utf-8?B?NmdVS0I0RzgxNWxRNTM4dkErcGNQbU81R3RBdy9kR1dJWVhsVGF0M0xXZkEy?=
 =?utf-8?B?N0FldFo2VitZQmJza1JoZzJFejFEMGc5MDlZVnBiVndrNzIxcG9mN2lwUzFZ?=
 =?utf-8?B?THc1T2dXWVVxTFNBQmw0R1M3SDcyYlc1cDA0RVlaVW5rQlNHaTBLclJ3MWY5?=
 =?utf-8?B?LzVGZ1dEMmVLRWUxcWorUnp4MkdabWt2a01YekhyazVyVmIvK0xOVG9YU1lG?=
 =?utf-8?B?VVA2dGhybVg5czVhZStGcG5JS2pwYmZtd2dkbTJDMlI2REcxVlJnME5MZXkw?=
 =?utf-8?B?eUdRbjVKeXdKSms5MW91MGQ3YzJwTHBLUHZ0ZE5mNlhzeEcwWnNSQ2EyTWdi?=
 =?utf-8?B?QnRPeldvS3VNblRMemJIUVYxSUszbmZ3RzhhZHpUNmNWUWFlM3FrMWRYT0lW?=
 =?utf-8?B?b2hWUStVbHdIQkNLWHVZa2JKRDVYbjJrVW9vU1dVZ0N6Y2hTVy9qYy9HZFVC?=
 =?utf-8?B?cXRZRDRQZ2tYUmVDdUJ0cU9VT1lzbncxUTZpOHF6dmxXWTlVbUh0WmphdkJ6?=
 =?utf-8?B?bEJ4S2tvRVJHOU5rdVE3V1V0eGZ1T1JtMDFLMmZGZkMrSW1qalBrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0d34f8-c0d2-49a8-8636-08de9a5992b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:11:03.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFoqPqU8HYHaONmqWXSBoiUbp3lObvXA/XsbWckShd9QIpr/sUeOp+3jzVaq5ZDHspI1IVnXFaAi+nxldJvu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3305-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 99FF43FDED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces experimental support for merging multiple source
images in mkfs. Each regular file record the source image path and its byte
offset. During the blob mkfs opens the blob and pulls the payload in via
erofs_io_xcopy.

This does not yet support chunk-based files or compressed images.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 include/erofs/internal.h |  3 +++
 lib/inode.c              | 31 ++++++++++++++++++---
 lib/rebuild.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  7 +++--
 4 files changed, 105 insertions(+), 6 deletions(-)

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
index 2f78d9b8..bd10e267 100644
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
@@ -697,7 +699,10 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 
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
@@ -706,10 +711,15 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
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
 
@@ -1508,6 +1518,12 @@ out:
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
@@ -2014,6 +2030,12 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
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
@@ -2022,7 +2044,8 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 		if (ret < 0)
 			return ret;
 
-		if (inode->sbi->available_compr_algs &&
+		if (inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
+		    inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7ab2b499..3785afd0 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -14,8 +14,10 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "erofs/io.h"
 #include "liberofs_rebuild.h"
 #include "liberofs_uuid.h"
+#include "liberofs_cache.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
 #include <linux/aufs_type.h>
@@ -221,6 +223,71 @@ err:
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
@@ -265,6 +332,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 			err = erofs_rebuild_write_blob_index(dst_sb, inode);
 		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
 			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+		else if (datamode == EROFS_REBUILD_DATA_FULL)
+			err = erofs_rebuild_write_full_data(inode);
 		else
 			err = -EOPNOTSUPP;
 		break;
@@ -553,3 +622,4 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 	};
 	return erofs_iterate_dir(&ctx.ctx, false);
 }
+
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

