Return-Path: <linux-erofs+bounces-2471-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDnjLfLspWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2471-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 198481DF145
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqby0b2jz3bnv;
	Tue, 03 Mar 2026 07:02:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481774;
	cv=pass; b=HxzvvQ4YG+2+vTL4MzHlaHAmyJCq/l2F19HZ0bOIMOqc3piTrP+yjczYU2qFG0NPbusAzW/1b8Y218sRPEACmTq7EwmoNe9vr2T6k5ekpRdKFzubVYYGutW2AIA8hvot5HKknnPF9X+YVhCCoaZDDcYfrc/QB+B9yeXpEnhPFxkk/I7o9mGW9ocLilTlfu8/gb7IPVWTS7+p8CH66k1BrGXLUXmjsE8j11muIdtxogJ/Ldw3wyQmn87Gxoxjq6hxLNrqfsr68CGQtSPb1dulePo4L8GU0ZtzZ+LjpzRvlrBpB9NZsIfcLmMrJMjRsozd6HJZ0ApOBXlRawY9AYzxRA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481774; c=relaxed/relaxed;
	bh=TfMZzOoz/TmKSCMMh7lJAYsuj7KekotZAf+aOYRnJaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsiFbyRrmAXNZT9HbbagGwHIPHqVeD/tJdnOw6AJ7QXv8VoB4Ol6Ut0dnD1eUs4dPjzKeg2n/asuudwiLnkxBGJWTexyHrHrczpnqxMFWYzEk3tSWiOYOkC92/elyUxoE9l/w1Z7aRFlr/Y55Mv47568Tu7QGZvv6TT1BLVKMiY+SkK8KoDwg2oLSytYieW5/V5iGRn+ILsL4vNnEhLhBwv4k/OaCxVBpq0tNs3XX2iqBQ6FNrvJEEN0cDLOo26L1UJ6YzoLhgMOncC7DoXzUTN9jBaOF+g609lEAnkCpxTQVBhW68nw+8ih6q38w3WFuSZGCGofToD2ubBLOyrXqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F1Xj5aMu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F1Xj5aMu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqbx3HKBz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJztYXcHmo1S01aDhRYfe2ZFYRG3MaRFXnuAFGDUCdCxbYEQk2JmiLG0JzDFmnXdWBKR9AC/Ok97BWEtvrSzSjBVlvb3P1pDxTn+pS8brN5+IBy9GXA0LZcugYYKf/T0unZvQsHQmM8d5wJolfSIW1HBFpsciMd2KIoFx0OvAlJtVVv0OGinN05uIWLa+wfX4Jtr2InmnRLTnFIExgEu/3S/qeDfpE7DKuo8okMCxX2zPOLjAeT1m29+jf1xvsINk7zaHCuP0tkDgTR0Y3qoNSEOt0qklGIwODPvyNKJDsSmrXQyxY066OQmdBdBXz3RvKqJGkljKsgCtEJkButG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfMZzOoz/TmKSCMMh7lJAYsuj7KekotZAf+aOYRnJaQ=;
 b=ydNoKp1Ic3Gpa1B7U87qAlS5I2cJN3W0e2PwE3iETb1rnWSA2x+YI1koEKtcBHSgy6hnCqEVwfaaRaB79cZf/IkpxLs7FEjfN2oGaK62yn/HjeHvFGr/SrDASnuKB3yciHlJ0qveE+Xp/6UitbAuVGII12Ore2W5SjoVvRFdEz6oKe9r5xY4IH3UjC6p/PpsmW9Mr8OLlceg+RGrRHCWeEE7XNX1C8/QyFj0xvcCBEdiLosFg3LaRMfhw1/bHRS+vd7pAjBw4apUDr/OekkI5c/L9lkWUODwMco1djTuRbkIiyat3fF9RMxkBvHl+EzZFLmqeurA/lFRDWREocvy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfMZzOoz/TmKSCMMh7lJAYsuj7KekotZAf+aOYRnJaQ=;
 b=F1Xj5aMu+Ren0Ogr7FUsGx5/aubeW9+Go8iU5q8Mb2inRAzUz4rgrUp31rX1VgzHRr5QhecGX7gPkRcIFK1RmuZjVy0XzN9BvrwOGEdo9QabVUZ0z2Y8oSXkvQtQ6L/mUNNa18KDFaneL6zXMFNqJVOR/YLhJhexWkGqpZPuIz0CzEu3V0X9XPt82j9vtIeiX+DCg+Hl/DQ0a8GvzZHkDSNHEUj8BEhr8Fbpwkgjd446T1MBNwHsXW7dAQXHvFdGXUntFu9pCkzP88lhx6E/eErhQ2M9dMtnoYpGXSaqZm8sD9nYWuiBccJ0ek3mreEvZN8ktXt2gMwSRMGu2sKEfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:02:37 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:36 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 4/5] erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
Date: Mon,  2 Mar 2026 15:01:53 -0500
Message-ID: <20260302-merge-fs-v1-4-a7254423447c@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: aacd5b0c-23d2-43f4-b585-08de7896a671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	eSsnpl/GUkEOJSS8TgtQyE9qlths69OD+nqNPV5ANHC+dEA3dZdkNbzNpUoXIZFVg8gvD1vlmLiEgPsdiqJhlrg7zNapRgKy3+oPBvcWIisdbk+bHfcAkUP/xD33OCvETMKtetqk6pU3pfcq23IVhnf+hxx2Hzs83SR+S5xQkePINWNVPwphCZT3HykN0zi4XGJcbhR51fI3DVpmXaQvy42to4sla7EbF6vlD09OrZSWwJWFlyFXqpVmTgDI8iKER9HJeKtmrAjKVofQLPRM2g4qojwrSBwQ2GVBLNMtkPCh8jMs0yIXy2nbP6VVKkXps3dJpN6zBQO6qCZFO689mwpEwrFnc9+yrPd10MpC8P5FxqWPsT7i/yxBuh4B3mKx0DUXDmOK6pIo3edOCv8JG7gz8UvYs6jfyWYxnSAuoWgJ0TG25Pk8XnZkcRhmakNDW8RyjJeELCKhriw12ig7323n+Efch0yBYOHKZi49pap8kSdw6myHDKkFreZeIS3KE4i41ly5CZg0sf2j9hM6UqX9NZlZ4gJdEvSZhKC/RJadeHsufNZqh6njV0Bu26ew8feXUe9CTwFtKAemtNcznPwmp/aC848ZKQZbl19t4qZXZ7qyqX7yePrRMpsUy8TMtlW66qzqgwEJ1BwSe8zlirMcX2eb0E1KVuqwaxBJQ5FyKVR6kQuDTSsbwVds95JZFAUjnqxRTOhGDOe1+o/fD3/kUsyt3uDx5/UzSmUQ+OA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXBOcDB6YWRzV0U2azlKdHhtako4RkJ0Sys3YkJkaEYxZzYrUUlxZWR4cXR1?=
 =?utf-8?B?YUYrdndETDBadWZjZTBxa1NSa2Jwd2lKMUIxcHA0cU1aaGVmQU5EYTNnancr?=
 =?utf-8?B?dVdlSkRyM2NqdElYU1pYUVpBUzZQTjN2SmRBNjFIRVdrZEIzcll5UHRvdTM2?=
 =?utf-8?B?N1Q1NlNpVEdVVUVTWk0rdzV2UUIvOWNTcnRBR0FxRENTOWZYSERObUluM1pv?=
 =?utf-8?B?NkNIaitJRVdsZjM2T1g2QkxCaGpyR0E5dTJRaE04WWFaaGVBNHp1a1hYY3ZH?=
 =?utf-8?B?NThsTTM0T1dJZEtzMWtoTVUxdGZhZlM0VFc2REw3a3RJVE00eFpjeHpRRTdo?=
 =?utf-8?B?MzZRUE5TZ0xTUmdGOVhvUkd3SUxtV3ZIQTI1MXVSV0p3NklIZUZKR0xYYXQ4?=
 =?utf-8?B?WUlVSmVHU3YyanNPeGp3WStvYlpmVURCVWRaT2JWSHZ2cVhITDdUVmVrVUgz?=
 =?utf-8?B?dC8zNUlHeEhVUml2bmJzeW1SVG0yYkFTOXFKOEIrT0JJZk1yVEJnS1RMMGZi?=
 =?utf-8?B?eSsyU3pKdUpRT0E1Q3B1MjNLZkp4SFlpSDk0M1hUS1BWR1o5a0tYZ2tlYVh0?=
 =?utf-8?B?RGJsV2xXRDhZMVpFRGhjQkZVRk4yVWt0d2hXc2dURGtUamt0TXNMWDNtVlJq?=
 =?utf-8?B?VmhiV1FOSlhJZm9jVGpTWU50Qy9kdFg0YTVXTzV1YlhEMHVLYzVIalViZkxG?=
 =?utf-8?B?SytxODVjT2VDbVlhcUtRZW5zNlRQeVc0OWI4Y2N1cXhSUVBya1BVUnlWYWFC?=
 =?utf-8?B?cXlvUzl6R2pLUDJQTlBEQldCMDRZUGNIMzBtVWxzTUVFSGtLckNRV3lvUzRq?=
 =?utf-8?B?d0NUWkZrNXV3WXlpQnp0a3FRdVRhaGtQaisyRG9EeHgzOStLT0xXS25YZVF0?=
 =?utf-8?B?T3Z5TlN4c3cxVkc5WWdsV2tySW44QmlkWFFwYmV0ejMxYmRRUjVhUVN3bjF5?=
 =?utf-8?B?Mmgrc1RWTG5GL0ZaV3ordUZGMFZ0eWd2dGtnTktZdW1wTWZiTHpJOW5ZcWJU?=
 =?utf-8?B?U3FIYlRRN0ZveTlKcGRFVExTejRLQVhFc1pSbzJuMDhyYzRaQmVzTXFVUGh3?=
 =?utf-8?B?ekVubE1LNnV0ZU5uVnlSQnRxOGJVa0orTDRFUHJaTXI4Q2xMbzIxbWhobTZK?=
 =?utf-8?B?akhUdnp2di9obGZGQzhhUFhyZDJaKzlJSjVmZDZJbmRmVmlVVTFUUDljUHVp?=
 =?utf-8?B?MUlPTm04WHNadGQva1ZjMUtOZWRjS2JyR2tuaGhaaXRuZEpnMXh0VjBKK1Z1?=
 =?utf-8?B?dktMZDYvUzNtVlJPTHNGdUdKY0wyaENJQWtWdXlwOU0wS1BLaGRKajRCU0Zz?=
 =?utf-8?B?U3NLaERZZ3lObCtLUEtjaEd5K0ZxWXg4czR2R0pXb1ZaNEVrc3JsMXpSM1lP?=
 =?utf-8?B?Q3ZSeTd0S2ZCNGg2ZVFTdVY1eDN0d1E0T3pjL3BzRU9nSDBtc1VUVURRaTFF?=
 =?utf-8?B?NkZlVmoyYjB1UkU5anVkMlI0MXhYTFQzbjdFWlZDRy83N2lZTjFzMFlwT1JK?=
 =?utf-8?B?bnVuUnRUOFZFeE5UOUxNQjVjck92dlFwRFBTdEJVSm1BMEdzOUlPYkxoOHB3?=
 =?utf-8?B?dVlDdlNBei9CNzRmbHZrRU5FdGdzVVFFVHBqVVhWbytONGtRTEowVVhubzZB?=
 =?utf-8?B?cUk1bm9CMjZxbEsvamtNZVcyb1JpRTdsNXdrWG1JQ0xhZTB3SmFoNVRJaUlZ?=
 =?utf-8?B?dkN1NkJwbmVGbWkrUXhkUnVvMTVYcVRmMTFDWmQxRDlDMWd4bDB4MXk0bm1j?=
 =?utf-8?B?YmNqcVRVa2tJMEl0TzdhY3NkNXlUZnRFWjQrN3JBK3pDbnJuTklWNlE5amMy?=
 =?utf-8?B?WWY5M3JseTJEQVFQdGRhL1EzTjlMdnFaQTVwNDdYdjNHb0FSbDRrQmJDTTJt?=
 =?utf-8?B?YnFHQnlWc3ZTZERDdUNtbEhmSWdKcG1xVTYzaEljb21RZjhpWjlJZUgvc1JL?=
 =?utf-8?B?MTl1YUtWRjY3QnNvbXlrMnJjVG9ZYkl4d1VkdzRxN2hGMWFheThuOURqamNh?=
 =?utf-8?B?NnRUaHhpUCsrV01hS3FNVUFyL3pDMWJybVBabkNOZE9zK1hmTmIyM29vQVB1?=
 =?utf-8?B?R2s0bzl2Njk1cCtJTlc1bWJubVNQTU9HdU1RY1RaaXZSM0VMVmE4WGE0VjFO?=
 =?utf-8?B?aUgxc2F3U3ZvUURVUzBaekNCOFNUQTQyZzVSRTF4NTlGb2hhdVg5bnI3WXg2?=
 =?utf-8?B?OEdHbVdSM0NON0MwM2UzMDRpQ0JTV2Vpb0JVY2FXOUNKZjhHam9oaVl6ZXJM?=
 =?utf-8?B?aXhaYnhncytmYnV0NWdRQ2NBM1VZNk90NDdDZXlnOU1QQXRRYkVmU2NKd3FL?=
 =?utf-8?B?SHh2SHgzUGJ0bHRkOVlFWmMrZVhmM21oSGZPYzVVb3kxekRVY0tjQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacd5b0c-23d2-43f4-b585-08de7896a671
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:36.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLl8MvyQH+0usWtAJTZ2YkDr0bGI8/XwbHA11FBPq/EyPOzhYlWxhD8GKdSUeUYV5J75cr7iGEjaI3svBqtVXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 198481DF145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2471-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

This patch introduces experimental support for merging multiple source
images in mkfs. Each source image uses its stored UUID as the device table
tag. The raw block data from each source is copied using
erofs_copy_file_range.

This does not yet support chunk-based files at this time or compressed
images.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/cache.c            |   6 ++
 lib/liberofs_cache.h   |   1 +
 lib/liberofs_rebuild.h |   5 ++
 lib/rebuild.c          | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
 mkfs/main.c            |   6 +-
 5 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 4c7c386..49742bc 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -544,6 +544,12 @@ erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr)
 	return bmgr->metablkcnt;
 }
 
+void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr)
+{
+	if (blkaddr > bmgr->tail_blkaddr)
+		bmgr->tail_blkaddr = blkaddr;
+}
+
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr)
 {
 	DBG_BUGON(__erofs_bflush(bmgr, NULL, true));
diff --git a/lib/liberofs_cache.h b/lib/liberofs_cache.h
index baac609..55e8f25 100644
--- a/lib/liberofs_cache.h
+++ b/lib/liberofs_cache.h
@@ -138,6 +138,7 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 		 struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
+void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr);
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr);
 
 #ifdef __cplusplus
diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index d8c4c8a..32d9e2f 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -17,6 +17,11 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode,
 			    erofs_blk_t uniaddr_offset);
 
+int erofs_rebuild_load_trees_full(struct erofs_inode *root,
+				  struct erofs_sb_info *sbi,
+				  struct list_head *src_list,
+				  unsigned int src_count);
+
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 			       unsigned int *i_nlink);
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7e62bc9..16ef0cf 100644
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
@@ -221,9 +223,60 @@ err:
 	return ret;
 }
 
+static int erofs_rebuild_write_full_data(struct erofs_inode *inode,
+					 erofs_blk_t uniaddr_offset)
+{
+	struct erofs_sb_info *src_sbi = inode->sbi;
+	int err = 0;
+
+	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
+		if (inode->u.i_blkaddr != EROFS_NULL_ADDR)
+			inode->u.i_blkaddr += uniaddr_offset;
+	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
+		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
+		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
+
+		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR)
+			inode->u.i_blkaddr += uniaddr_offset;
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
-				      enum erofs_rebuild_datamode datamode)
+				      enum erofs_rebuild_datamode datamode,
+				      erofs_blk_t uniaddr_offset)
 {
 	int err = 0;
 
@@ -265,6 +318,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 			err = erofs_rebuild_write_blob_index(dst_sb, inode);
 		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
 			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+		else if (datamode == EROFS_REBUILD_DATA_FULL)
+			err = erofs_rebuild_write_full_data(inode, uniaddr_offset);
 		else
 			err = -EOPNOTSUPP;
 		break;
@@ -387,7 +442,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			inode->i_nlink = 1;
 
 			ret = erofs_rebuild_update_inode(&g_sbi, inode,
-							 rctx->datamode);
+							 rctx->datamode,
+							 rctx->uniaddr_offset);
 			if (ret) {
 				erofs_iput(inode);
 				goto out;
@@ -425,6 +481,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 {
 	struct erofs_inode inode = {};
 	struct erofs_rebuild_dir_context ctx;
+	struct erofs_inode *mergedir;
 	char uuid_str[37];
 	char *fsid = sbi->devname;
 	int ret;
@@ -447,16 +504,19 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		erofs_err("failed to read root inode of %s", fsid);
 		return ret;
 	}
+
+	mergedir = root;
 	inode.i_srcpath = strdup("/");
 
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &inode,
 		.ctx.cb = erofs_rebuild_dirent_iter,
-		.mergedir = root,
+		.mergedir = mergedir,
 		.datamode = mode,
 		.uniaddr_offset = uniaddr_offset,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
+
 	free(inode.i_srcpath);
 	return ret;
 }
@@ -556,3 +616,106 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 	};
 	return erofs_iterate_dir(&ctx.ctx, false);
 }
+
+static int erofs_rebuild_copy_src_blocks(struct erofs_sb_info *sbi,
+					 struct list_head *src_list)
+{
+	struct erofs_device_info *devs = sbi->devs;
+	struct erofs_sb_info *src;
+	erofs_blk_t current_addr = sbi->primarydevice_blocks;
+	int idx = 0;
+
+	list_for_each_entry(src, src_list, list) {
+		erofs_blk_t src_blocks = devs[idx].blocks;
+		u64 src_off = 0, dst_off;
+		u64 len;
+		int src_fd, dst_fd;
+
+		devs[idx].uniaddr = current_addr;
+
+		erofs_info("Copying %s: %u blocks at unified address %u",
+			   src->devname, src_blocks, current_addr);
+
+		src_fd = src->bdev.fd;
+		dst_fd = sbi->bdev.fd;
+
+		if (src_fd < 0 || dst_fd < 0) {
+			erofs_err("failed to get file descriptors");
+			return -EINVAL;
+		}
+
+		dst_off = erofs_pos(sbi, current_addr);
+		len = erofs_pos(src, src_blocks);
+
+		while (len > 0) {
+			ssize_t copied = erofs_copy_file_range(
+				src_fd, &src_off, dst_fd, &dst_off, len);
+			if (copied < 0) {
+				erofs_err("failed to copy data from %s: %s",
+					  src->devname, erofs_strerror(-copied));
+				return copied;
+			}
+			if (copied == 0)
+				break;
+			len -= copied;
+		}
+
+		current_addr += src_blocks;
+		idx++;
+	}
+	sbi->primarydevice_blocks = current_addr;
+	return 0;
+}
+
+int erofs_rebuild_load_trees_full(struct erofs_inode *root,
+				  struct erofs_sb_info *sbi,
+				  struct list_head *src_list,
+				  unsigned int src_count)
+{
+	struct erofs_device_info *devs;
+	struct erofs_sb_info *src;
+	int ret, idx = 0;
+
+	ret = erofs_mkfs_init_devices(sbi, src_count);
+	if (ret) {
+		erofs_err("failed to initialize devices: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+	devs = sbi->devs;
+
+	/* Read source superblocks and populate device table */
+	list_for_each_entry(src, src_list, list) {
+		ret = erofs_read_superblock(src);
+		if (ret) {
+			erofs_err("failed to read superblock of %s: %s",
+				  src->devname, erofs_strerror(ret));
+			return ret;
+		}
+		devs[idx].blocks = src->primarydevice_blocks;
+		erofs_uuid_unparse_as_tag(src->uuid, (char *)devs[idx].tag);
+		idx++;
+	}
+
+	/* Copy source data blocks */
+	ret = erofs_rebuild_copy_src_blocks(sbi, src_list);
+	if (ret)
+		return ret;
+
+	/* Advance buffer manager past copied data */
+	erofs_bset_tail(sbi->bmgr, sbi->primarydevice_blocks);
+
+	/* Load filesystem trees with unified block addresses */
+	idx = 0;
+	list_for_each_entry(src, src_list, list) {
+		ret = erofs_rebuild_load_tree(root, src,
+					      EROFS_REBUILD_DATA_FULL,
+					      devs[idx].uniaddr);
+		if (ret) {
+			erofs_err("failed to load %s", src->devname);
+			return ret;
+		}
+		idx++;
+	}
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index a8f9a5e..124a024 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -15,9 +15,11 @@
 #include <getopt.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
+#include "erofs/io.h"
 #include "erofs/importer.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
+#include "erofs/dir.h"
 #include "erofs/tar.h"
 #include "erofs/dedupe.h"
 #include "erofs/xattr.h"
@@ -1726,7 +1728,9 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		break;
 	case EROFS_MKFS_DATA_IMPORT_FULLDATA:
 		datamode = EROFS_REBUILD_DATA_FULL;
-		break;
+		return erofs_rebuild_load_trees_full(root, &g_sbi,
+						     &rebuild_src_list,
+						     rebuild_src_count);
 	case EROFS_MKFS_DATA_IMPORT_RVSP:
 		datamode = EROFS_REBUILD_DATA_RESVSP;
 		break;

-- 
Git-155)

