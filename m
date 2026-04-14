Return-Path: <linux-erofs+bounces-3301-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKgJBW6R3mmqFwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3301-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D003FDEA6
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwDQw6QwTz2xm3;
	Wed, 15 Apr 2026 05:11:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776193896;
	cv=pass; b=OVIgxUC4psJqNDHzUWiosDZ3/yMEjNUrkqn8jHqpzKePQOp4K6pa5mTc1wh83sg948+2dvV//BLN9BOUxgRH3iIVUq9Ope47oog3bfus43rYOMx9PYtpZ8eHhnSwOxWmWsRPvu9PHLzSmv/HtjQseg8JHNZo0gG/6efeNLWFwAmYhxWVtbILLGxT+1dhf3AVxmViTr9GPRuSTJ1dK8vt+yOWzG3UmfIcPl/SDEA8q7nI3a0pSWsnprvnPOZxEas1fsomiyx5ckwf3XQe2Ej3KG5iH8VqDciVK7jPoFAL6KzCwlcS1c68yAO7RVwmfOdEAh46Z2cu7VCSU22JVKFvkA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776193896; c=relaxed/relaxed;
	bh=XXYu9RfcCEta7BeYsbrbUxL5zTPKX2Nd+HxMmrQfKXU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Om4Gb1TNPvQerKKyaetvxsZhyqPUppgaxGXP/zAOiV2tABKWdVimbN0wCwPMLUoEqxt8NEEuCSxfUlbm/RQOz9MNzeu+T+zlMqU9PasDBVVYlRe54UNKTICS5ehU3M07vdJhHRqLLOAeepIoRDe1/YxgSmxhWP0OgQHjZWpAtn12anGC/NWYEckSOoHB9Ls8Xq3Y5Li8LQQRRJGaI3NWbgGz1maPw+KVP2GffUWV+uWuvyadW9Fqp6LpB5aBgkt8xCVZU2iW6Ptdwa24b/8Gb0ntfLxht575l34EAEPU3XuIw+g5GvzlyQChT+2PvfMQcPOk7RjDwB+nAAlOdmCJbg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Eb0K2q//; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Eb0K2q//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwDQt5glxz2xlh
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 05:11:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcKZCH+cGka4ilDS+vvHiBnoSZi70qZXiWYki1UQpB/QeIm8OdT7n3UlqHV9JK1qacReUEpJdXcdpRbUpsxhCbIqzoeCb4NIOqr5WvDsStQpyxDTEcJMDRJSrmtANOaP4dtsv8lelwCoJfW6int2fgW58NZSmozWCe5qjRrgNa48+kRJzqbtcpxC8oSF47lo8dnw9kh0OwgwWC2PdVMLEa1R/2j46zw/MeAhIiBo6HHxAG9J9Vq03Gt0pE0UT4IAVoS0RXP5d9xocCfSYbGYGrSuDkEzar7ZAJxlwHmNzrb/9q7rKGTdXon83/tY4b6yWWfBuMDNdHJ6oWcG9DFIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXYu9RfcCEta7BeYsbrbUxL5zTPKX2Nd+HxMmrQfKXU=;
 b=ZE9UNcUR++qFswG4f9VX+MbPSCtlUXl16sUMa/LIASfAHWsqH2Ar47FOru8uLR9e9jZnNaoOYiz6oQHEDKFNHRQBD8/XYAFtcg9jOgdyAhvMdUlsxjaukqZJrKy2y0ir9D/huLmdNUu1b3eUDHAFkPAevc4OnjlwiyUTsmD/5RktOenLHWbq/OvAXi2Pn0RVc5laE55gW37AG4jzMR+kDN0EDFV6Vrne7gZ7f0j/9rGpQoGaRMHuh+Ef5YsbX/h8L7N5lCjwW0EkoTJoGJpQ7++w/p2eFVaX9OoColykKs+xhZwWKbwpOX2EXGEkR06t0v44PM9Eg24F4wVJnn4RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXYu9RfcCEta7BeYsbrbUxL5zTPKX2Nd+HxMmrQfKXU=;
 b=Eb0K2q//AM8q1hLYT9l5xZFmiUNRly85EZdbn0q4jWQkZM74DSJmCu1yJgWoOR+XE4ky+CVO8BGSTD1PkHtWC24lFCwn4iw18tF7Qm1rS/lmkFUYU7fZ0O1R0p+7lIr28hJm++75EFFD8FGn2WW+2Qv8oFc8cAMElZHssvz3WxaNl0/gZ49/cDQXY1+YY8xgYqNRT9LrM+Gv1u1Hy1fS0QuRz7TUveIcHyGFYfkP7HnXR/s9tN75KyLdElSvB1nvBiW76xxhMTW0GX8iVirddmU34qvb18bmhxZL04Qtsu3vp7VRPRPit3iz9+ohPdl8Ip+H9xX44YPfdE7ImtEjvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:11:01 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 19:11:01 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v3 0/4] erofs-utils: implement the FULLDATA rebuild mode
Date: Tue, 14 Apr 2026 15:10:38 -0400
Message-ID: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-merge-fs-e6231a3a3a1c
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
X-MS-Office365-Filtering-Correlation-Id: f536c1d6-2b41-4ea4-06fd-08de9a59916a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QkS4fkESyudf0dwGquFO6xEBO4uwr+XCJLSJmJttCSKUoEDMsaQ8R8lVAxllrN5ArybbKcdHkiLzEGa+tz9j5YFQ4fGHdflGJe33ZWtIAyrRzsqRZL2DrwkYVNXSZm/6yIGlwhZ/4g4eLW23F455lmhI2XZpmE1mhc6gl0s68r4wHjmaNvabsD+GmmHH7jtkRURotwHwz6HTKVfsYtxir6xnYeueNH2MdO4m26Rrti+GAirLesAvn6KtM6XX9EyvJi0LTGgV04XoAzfcJH5IoJtYmES+SOn8HnrHkdnJV3nlpU5DDBhUcmSZmozy2eVdDuYQdOn3wWUrg5NlulVcdQuA88H/zvBZkU3SYLwVyt5DsVPFfZI7rrJL6XOyJZ3XUHXk70L22OhRnlCAqnXKaUCg9Be1zO8tfOKei8fuLFQZgwgU9op+CvcEYgs4Q3EvY/n9lGlmwxk8kKAIpjoIroT6jOKfaypU5ij2yxIHAo/qXZa4/ILpLOkz4loB38BJbxwqrBYUEhxCCzKbf6WHzKmJBwbWW5dWaRfK2FfuW47BwfRkcUjsbUoJu/2AjEdLh8hbpu5y2RSsQH6ALaaN68Z2CqHnohC3DPbqwieIsHkjo2fZxjSowQgetlmhXwWdI/c5yOz5rb1lBWN5oUCoAdRBJgQoBgMD3VPKh1VB8Nj9hjkd0Bo+xjhAyXu1nP4uJr3lyeeOhiZ4S/GnkA2kCZdundePzuSSk+Mk2yqNDaU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3VYZXE4RUdENTBTaWY3emMySVJYR2NtejRLY1d1bWFwcjJ0R25uVi9rRm1F?=
 =?utf-8?B?OGV4M1NDZUdsZ2JhZ3l6aWI3OEt6c2NrcXZsUG9TSndDWUUrUGM5REFpTHc0?=
 =?utf-8?B?UkV2RjdQSkViV1lUejdtZFNkaStJS2lWcVYyUjJ4Z2tBTVFVYy9kOU1BZWpN?=
 =?utf-8?B?ekdPZDFFSytkcnIyMFJkMGZMSTBRZE1qeHZiYUl4RGpqWDB6RHgyNm1scVRG?=
 =?utf-8?B?Nk94cGNmZVFQZXF1WER5THByZnpxZjlNdVdxanZnSURweGZSNk5JbmhHSGNQ?=
 =?utf-8?B?RVRuZkl6SEtVT21BSDkrU1NiSnZFdDF3L2ZPSjZQTTl2a2tnc20rUm9rQitU?=
 =?utf-8?B?V29wWnl2UHJtdjhQbTZqZzBkUGEzR09KMXpObWZTQ2R2bTFOQXdSeEpXemRY?=
 =?utf-8?B?UUJYbi9nS1JINzBENWoyK1RqNnBFMzdNbDFkNkpDN1ZCL1pBZ3g1Q1NTWUFE?=
 =?utf-8?B?RTVyeDVkR0R1U0VkYVNPTDdOWHhmVVBESEY5aWZXVnJ4Zk5xWkdiTndydk1S?=
 =?utf-8?B?L0kyRWFhZG5FeVBLT0JVUUN6SVRuYWhkTmFlZVVndmM5bWZaWkg5eUR2ZTgz?=
 =?utf-8?B?dWJ4a0tjcytGaVNuQnBYb2pjZzVkcWFyWTZGVDl1MFphaEZIN0hCWXdKU0Fh?=
 =?utf-8?B?SEUxUXpiZXZyVkk3YlA0ZXdaR1N4aTVTZjBHdG80NHdYZE1QLzhZYmxJZ3hP?=
 =?utf-8?B?NGE2THpXcGo2cXdCMGVoVzRmUTBCZ0UzY21qblB2Um4xWDJNdEhnRUNENkNi?=
 =?utf-8?B?blQrRzNUQzVJZFk1Tm84VGNqQmxobUdjQW5HcnJrWTlMMGxneWx1WFNyaE1D?=
 =?utf-8?B?L0xjWUpZWC8wL2FYM3F0b3ZZalV4RitPamIrY1Q2MHFSay9Td0VvUTdjenB6?=
 =?utf-8?B?OWlTK29odGxVUFgrMXFKNzg0bzBzbnpTemdhM3hEeUt5TlYza3ZJYTl4S05C?=
 =?utf-8?B?b2tlblVBRzNoSitsTkU4a3lrdHhoTUdoSTllTjhqcFRWdC9XeTFJOFpJZHU5?=
 =?utf-8?B?QmsydTYwSkxrb2oxejhBSTZrZGhDL05NMkRrRTY2ajlCZkNzcUVBS2ZNNTRn?=
 =?utf-8?B?cTUvYjN5WHNHaHhoYko1WmRoMVdRMXZGMGdhekRwdmljdGZoR0lVYW5uM09E?=
 =?utf-8?B?eGJvQzlFa0Z4V2kxUzMwbG5FV0NNYXMxTjZEdFlqSGxOdDFlWjNNbnM0bjFu?=
 =?utf-8?B?YjVZZy80aDdWT0xaSXJlbXd6VXNCbXRoY2dxcFhVQXlZYnBiRGpBekJUS1dq?=
 =?utf-8?B?WnFZQ1ZFWHRLU1c0UmlieEZNN1VNNTE5MDZ2ZEFRZWR6WTBuTnQxTzVHNkxp?=
 =?utf-8?B?WHAwQmRyR09ZcEpvODFoMDcxT3Rnb08vaTM4SmwydzRSY3FzdW1yVnFVV2N2?=
 =?utf-8?B?R25ZL3FKUktLY1hONkNWVVJxY3dQVUFmc21zbTJxQkYwa1k3d2N0VWNWTTV3?=
 =?utf-8?B?WWlKV1lHQjN0ZU9ucEZoUTVJVS8yU0pYU0NOTlcvUlptc2VQY1hWYk90Yjlj?=
 =?utf-8?B?bjVybklOU3lJRE54Q09pWVZuT0ZlbFZRek1lMGdpRWMzbUZZWmQ5TTFQemUv?=
 =?utf-8?B?cnBsdlRNRkxxbm90a1VUdEc5RG5PamVyd3RoTE1GbkhPZ2hUUEZYSnp1eHR6?=
 =?utf-8?B?OVlUei9aMU10bUlhUWhGbHVSWjJCNzlqaDRPSlA0M2lZZ3ZYd3dPKzlTa05W?=
 =?utf-8?B?Zmo5dHU1RDR3cWxROU1iTGNVK0JSMmpVMlJ1VDZsQ29aS043Rm9aajYwRTVB?=
 =?utf-8?B?Sk9sT1dnTExUK0ZrMG1MZGVISDNWaHp2L2E2bis1MnBxTnMxY1pGeGFXdDlR?=
 =?utf-8?B?UHg5TUZFQVVGQjFFNThXZCs2V3NNUmdQall1bGZaeXhOT2hLOEpnR3hZQnAx?=
 =?utf-8?B?KzV6ZTY3ODRITDNKOW9LSnhSMlgzMWpaNkVlZlN5S095TDhpTFJPQmg5aktt?=
 =?utf-8?B?bi83L1RhVndRYWxqbjlQd0xzYVBkNWo0MzZxR2RuV1VubEJaUk94Ri8xcFZM?=
 =?utf-8?B?R3JXeDF5MWZVc2dDbk9HSWtIalp3ZGFyd0wyQk43aTFGcmFpQnZTbjFJcWZM?=
 =?utf-8?B?OTVmOFB0dktDSGxYaGdac28wbHJRSHpuVCtqNkNZOVRQUWFaOXFhQWJ6ZVJE?=
 =?utf-8?B?dXF4SnR0YVVzbDB3M1ZkUmg4QnBpTUZwZC9PQzRCMVF3dFBUNzJaOE90MnNi?=
 =?utf-8?B?eUFLanZMeEU3eitLeXA4RHBkdWFiUXA0RHF6eUpubzZFclJVRklvdzlSeDFJ?=
 =?utf-8?B?a0NKWUdKbEJnUFhmdlI1Z3ZBZFBvbDBSc2NRakF3ZkJWV0tZUDJZeG1neCtQ?=
 =?utf-8?B?cnpmd3FzbVR3VE4rZnovOWJ3ckRtY2szWVUvY0tvQUtHdVBYa0VaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f536c1d6-2b41-4ea4-06fd-08de9a59916a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:11:01.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjasGO4inQEHVqidaOZzuIWfC4ieBaDKYZ+TDGBKZi4IWhQnnnX/eZc2AZ9FpXnbxaU6fjTg9IHbE86JXuGwWQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3301-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 19D003FDEA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, erofs-utils supports backing blobs for multi-image setups.  This
implements the FULLDATA import which allows for the merging of multiple
source images into a single self-contained erofs image.

To optimize the rebuild process, erofs_io_xcopy() is used to leverage the
copy_file_range(2) if available. This bypasses userspace buffering and
enables kernel side data transfers.
 
Verification: Built same image with default rebuild and rebuild with
FULLDATA. Then ran F-i-f/tdiff comparing the two.

changes in v3:
- adhere to uniaddress semantics.
- take advantage of existing infrastructure which allows us to drop a
  significant amount of complexity + code.

changes in v2:
- reworked erofs_rebuild_load_trees_full into
  erofs_mkfs_rebuild_load_trees.
- removed --merge option (use --clean=data instead).
- updated man.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
Lucas Karpinski (4):
      erofs-utils: lib: remove redundant if check
      erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
      erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
      erofs-utils: manpages: update to reflect fulldata support

 include/erofs/internal.h |  3 +++
 lib/inode.c              | 39 ++++++++++++++++++++-------
 lib/liberofs_uuid.h      |  1 +
 lib/rebuild.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid_unparse.c       | 16 ++++++++++-
 man/mkfs.erofs.1         |  7 ++++-
 mkfs/main.c              | 16 ++++-------
 7 files changed, 130 insertions(+), 22 deletions(-)
---
base-commit: 58c3351d5b4b0fc5e4a05d2200c1cf9f85902899
change-id: 20260220-merge-fs-e6231a3a3a1c

Best regards,
-- 
Lucas Karpinski <lkarpinski@nvidia.com>

