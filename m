Return-Path: <linux-erofs+bounces-3325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK5LGDqT4mkt7gAAu9opvQ
	(envelope-from <linux-erofs+bounces-3325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 22:08:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28941E72D
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 22:08:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fy5Xw5K9fz2xpt;
	Sat, 18 Apr 2026 06:08:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776456496;
	cv=pass; b=IUfvBk1iVCoasszFOyl3++ZHYrdkrY6PRJy0OWG9ZTK67/Et7d5vqjfChLpFIsZSphDGP1RaGbjoA84nAehPRhSSCXlOJY43A9Piin66cmVDA6S1zH/gj3AiNpXzI1nUY4rhpws0nspJd9zb38mKi0yvQkmIjM+68iuHTt6qoJl7P7vvl67gwyhRQzwpDKb5hWT78obyCa4JcCw68qUux9xTpg186Man+PUFIIJL2ebYS6Pjmisu5gnOFBJm0/6BIyTozaQ7QcHfsmR+uD46shFtfEdmHlww1U1oldrGFwNS/ccuI/j66TUGBpinQ2ig5+m3Jr+MS2BG1AlGtir4PQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776456496; c=relaxed/relaxed;
	bh=UK5UYsiItciD7+Ue1ohOJHT8AuMkPqF7LArarrxiolM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TmcS7Uh7ev4wwdipO7kN/0OaYai/TcIDlqnrVw82+406HxfqnS00/Vh2AaIzg86NkQg/E0Ad2KKhx+Kvoh1eRGOET6oJWc2vkljLVgwSMJ+Z10kR2BfjBRyT9m0+1OEEq+rdQpRQsEgzgsEmQTheUbhvoMKoF5zT3JbIDrfR3s2q8NbKt2ZPtbS+a83yYXgOhl+vHR1fXLiOTD2X3sU0iEkddKNeDQLqdOfrLQLUrI8orSYCyyyAiYn8R0dyIl45YpjDekDo3vje6xAlIt/xZ4o6nowuDPYFhl3p+C0glj+nDOWTQRW7C/uMeq7ORsY0NhbnwFu+m/ArlX1ZRyUCZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3XnQ0pk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3XnQ0pk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fy5Xt11F7z2xc8
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Apr 2026 06:08:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8x8etTlk6nfs5KT2r87EZNFLe7wFJfXR5MEjNLd3K+SurFl0zn3xfQ91dBOjHSJExotNomR/MkX2Rd4zBK2yjOJpI0wbMzplEcVxF8fNNZmslpq9qGDto5lYcCUOWj57l5EVvMFFRONi0rH7kOoMSctkaZeSqCQamEqdtRnH4yNeGZ2yTWLLedxK2hQmQ1ZhQbgy85l0XEbKaUxehKOUgfDK8TIrZT6fAAYFnXecQUmeZ2T64jfx5+0Iv6ZVc6Lj+im2xYbzHDfXSWckng1Q3OMwvBqBx3nOndF0kTh6V2FjEy4f3uJDlNeBOeMm5TP4GLNoBXiBlzOTSg4nf68fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK5UYsiItciD7+Ue1ohOJHT8AuMkPqF7LArarrxiolM=;
 b=XvKJWWnd0YfKU03Du0EMOjG3y//GXjEar5HRkM/v/cHCxGgmrewr5A1yFLm8SzA64cIPOnYy/FF9PSdhJeFC2EJSOgjx+ThEkQGFNMzpJOMYR4w11fHtC2obQpii1bWn2taRnGhZIZqRSbaCutVAwwxmqBoZ0sCBr5iQLbziI3GK0We8m4u0O75krUGfh2s4WLJG6EAe2byC5lilGMf45RmbbNJZfu52t2NCu4Jjltb1nLyC3PbxuIeXtKLqUKsPSxb6xAj5CGkf00EddPlSGYV0fvqQitFiUCPBgvMUO/2HJMGyrXb/3LxL4nY60VrDqDkHFolrphd8RvB0GRtKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK5UYsiItciD7+Ue1ohOJHT8AuMkPqF7LArarrxiolM=;
 b=S3XnQ0pkD4UGfl4CROw7u2iYAJYzAa6al9Fw7VqXxhXEECzELdDNgg3l5I0F+EuoT45dUfvHLhqW9wkcJClaDDogtb2sDxAFYQWJ/veuBlEumbfi252XxbOyjWwwuPyJDIzqC0G24UFGlFfD/bjURNT6H1kOlrb2PHBiP0WEnBXygO69J5MGZMZARx70p5PLqIdN+dpbP/clXuxyjmZBuwMBOB+f2ZrnslDlu2NV5KSJ8Fznd5REBNvQUFwIM2Dlp4llsWBH+M4vy5Te6giMAw8/C3yl59hNXRQiF6Yy8MGh8VPlO3EQL2jGjMcVFkmK4cgcNxOKpxRAKZ8z2O0HmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:07:47 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:07:47 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH experimental-tests] erofs-utils: tests: add test for rebuild fulldata
Date: Fri, 17 Apr 2026 16:06:43 -0400
Message-ID: <20260417-b4-fulldata-test-v1-1-234654bdb930@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260417-b4-fulldata-test-b8e15272bc59
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::10) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 830309f4-aa43-4db2-0805-08de9cbcfe4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/aGMgvQFJVTNMbBCGGDi2bhDugpurRJPRVkUPz1qwRs1gFGbOf4MfBVML8icl6SOiyB5+b6OmBJWRuOPZ7TX5B1QQypjXxx454+AC0VB9tqh9LBeYc8yfEC1lXlvAEpD478I6OHVoAh9icf7WPYZFeEkAR8G2G51Cs2q8OEM6pukUY1HtbsCnAdhHHFQS8MtpK1yVaL/0rHFsQahFdv/3oLIrO98YvCSvmyr2NdQDV+pByN70Zr8GFluIw+egipogsPwSQXsbsMPQhh6Ez0mSwbupBLt5eztg4E3p7qczL8BIsV+JQPctnC+CNqwJd1seulotU73V0uRPFsDFy/Fyq/w/fzhTmAIX1PUD5dvuI8kZhbbrRFFRumW3H1/utZPFHOebFVJv0BKy4+MQK7I4+EYIZ6gUXyan1PgxAnCNg56a1EP5Cn9uTxGLRhnjIuJJxln/c8U36za6KcQ5RDs01jEjr0BaN2RISJWw5zye9qR20llZNEj5E/yksm6Ql9Usbj+YiCwPU/Civ/EQ16iXu6LKZ1fojjPBXQE+3/d8/4p5z4L4clSr6CKsk06zZ4hn78EPJ5wNBLXRJMESBSi2xH0/cCnvshpD1LZo/5Fq67vGXx42iotErTy+joE84k92fVLW+SSGpZWKjbof1D4Ivcw1xQCdPe9yLgXyGxtrYCl9DHg1TRAoVaGa+DVhrzTPNDnHe0IMW1QVVBb5N2lSJg12NIrO8TJbXQGjoNHs+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDN6SXJGcGFvUjlhdXdOR0owNHJnMnUyUnREVk14RXVmNHYvNDE2YmR6S0hT?=
 =?utf-8?B?ZytSVVpoVDJUREFVY0hiSGFoOGJSUGw4SFJNcGJIWEJ0aGNPV0RpcjlrZUhH?=
 =?utf-8?B?eElIUVRkc3hoZHhYZEVhN0VDaG40cnJJeEk1L3dnWVB3d1c1Z2doa2VpWTha?=
 =?utf-8?B?N1BxY3N2eUVGRVZ0SThDa1kvNEF0aW9aUXFSL0w0WmY0ckJVN1labDVrdDhG?=
 =?utf-8?B?WkxBTDMvSHkzZ0xLZkZxU2k1R1RqM0pxSk5mT3liTDhqYWJ5NmtoSHhGOUpO?=
 =?utf-8?B?ZnFNL1VCV2ZaRU1pQXF1cm9QanRNZmZ0cHRrTDlBbWNmd2NjNGtEMHpUcm13?=
 =?utf-8?B?RW1qOFZtbCtnOUx1NU13ZEZKejhOYVVRRjFrRktDL0ttSnpKWDVsYXJXYldR?=
 =?utf-8?B?S0E1NVdDeEVMZGJ5K3BrMmNLM0p4MnVqQzdnNElpSmdCaDlHUCtieDcyVXRN?=
 =?utf-8?B?WGZmeHphZFdQdHUzVFlUT052RmFRTWNZYkJxVVdLalJxV1owVkd6bm1vUjZ3?=
 =?utf-8?B?blBwKzl1dDE3Q1dJRWEvUndHUExMemhRRHJSeWlzTWJ3ZlJTTlBDaTRuZ2gv?=
 =?utf-8?B?WW14cW92TDVPbWJZSDMwdFVpME9RMVBOVkZPamdiYkZqdkY4OWcrQTI0ckVD?=
 =?utf-8?B?V3BFMzBLdVRsd0IwVmducUU5WFBYdlhheGdoZlpFaHhzaGlTV05TVnhsOUs5?=
 =?utf-8?B?MHlSczE1ZWwvb0xuenlhbWt0bzBTRENTelJ2M1JYYXExRm1hSGpGSElkQ1Bp?=
 =?utf-8?B?aDlxeE9JSStqdVg2ejVKWlBoRG9WQXRhYlA3am93ZjJFNjdYbHJwS3N6a2Zm?=
 =?utf-8?B?SEszdWV3Zis3MlNPZXJiQjdEbG0xdmE0OEMwMFllRXJLdUhTQmlWd2VGRWJy?=
 =?utf-8?B?aWlhN3U5dFRpQTBldWtzRk04WTZITTJ5S3RYcTd4cHVqeUErZ0kwS0YvZHF2?=
 =?utf-8?B?VG5veDFxK2pyQmJUajZrNFo2WGljclB4NGxxaEM3TVdkK1JqQXFtWWptc3Rx?=
 =?utf-8?B?WWRVM3pUTTlOcFZHWFVwUWlPMjRmOTlOaXhCTVJ2THI5MHlteUsxUGZweWs0?=
 =?utf-8?B?RUJkODlRZ01hcS8wZXVxMVNOZnVMbkV4eEluV0owMGpUN3RrbGRJY3V5dlMr?=
 =?utf-8?B?UlNCRllNaytzZFFPSU1LWXRUdE1OaytMZWt5ZFNBak5STm9QV1hTek54RXpL?=
 =?utf-8?B?aDVrdXJqWXBQUXV4SFd1UkZ1T3hIQkxVaWtEM3JOUmlobkU2UkZxbkcrOGhU?=
 =?utf-8?B?eDRmMUxzTjIzL1JQZHhub0NoaVQ2blhsdW1hY0Z6SElJWE14ZGZUbktqaFlk?=
 =?utf-8?B?bWJObWp5NDJxbS9kcWdxRTFyS2Z1U2pseTVhZ0U3V0ZwL2VUZ2FMZ0dDeEF1?=
 =?utf-8?B?UHQzWENjZUppUSsvL1VjQ3hRUVhEaldEb1VkYjJRQm03Y0VZbDBDN2FsWEll?=
 =?utf-8?B?WDBIMkdHdmpEQys3enBGckFWMWNWb2NBRmVHZE1HUkpVWUZzRVR6K2RwRXNQ?=
 =?utf-8?B?ZzFxWXF1V0RqcHlBak1pS3dCU1hQUHFGRC82TFZ2dmZrU0lqZmNvK3BSTmlk?=
 =?utf-8?B?WUJRaE52eEhIeE1CS285cjhFY2k0d1h3bk5vcXVWYVgwRFJ1TFdXUkJybElP?=
 =?utf-8?B?Ni90VUZ0eTdCV21oVWxDQzdTRWdJaEFQVlJ0L2xMUGhYamFGSGtaN21nVFVq?=
 =?utf-8?B?NnY1UXZxRGdmb0piVmRnWVFLakZxUHN5M20xQTIrUy9raEluMHZiQ3phQ1Fx?=
 =?utf-8?B?NzBzeW9NMFNtQk1EVkIrdnJPdXczd3A0ZHhTaHdkN2kwT000OGxlckRtcm1D?=
 =?utf-8?B?NjNJR2hmalhFbW1LZGJVRG5LY1pkY040bmppbXNUbmZwTjdjb2UzT0hiUVRG?=
 =?utf-8?B?Sk1yTmk4cFlzdmk4cWtBN1o0OHJMTThrZDdHL1VhOUt2MGhCVjhxMkVhL1U3?=
 =?utf-8?B?Z0VtaVNhOWY1cHdna0dPYkRiOXpmeXpLU1krSmR1L1hqVmxJNUova0swSE9u?=
 =?utf-8?B?bWQ1S1dwSnY2UHZrM1VZeW9HUVNsQkVPMDg4ekxqb1hkb0Z5Nk1vVkw1U1JQ?=
 =?utf-8?B?SUtXWTVORWhTc3FOaGU4SWpmTmp4T2d5RVdQV3RCYVBxelZBVDZtam54U0RI?=
 =?utf-8?B?WXdFOWtWNjBlbE5zTmwwaUhXOHNOTDZtTFdaV1BNOUZjaUsrbzNBcFhmZGQ0?=
 =?utf-8?B?WjYrR1BHRGJMRDVMTTNlSHY0QjJNQzA4RDczMVB6RnA0YWJOK2NyYU9uMWNZ?=
 =?utf-8?B?cFErQUtkcWVpZ0hRRm9sSFFjVjFwRmg3WCtSRmp5U2t1UllhbjVQaUcwVDdt?=
 =?utf-8?B?bDh4dkpIYUIzTXZNSmxJVUF3TzlUamVwWlFPQVdRNDczd0ZWeUozUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830309f4-aa43-4db2-0805-08de9cbcfe4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:07:46.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lYlZiEUIVNiJ99drEyfdgfgg/BvDkYonIK5ydVyNdg48PWtLyNxdE7L8JruOIupy6C+2MKLjF7bTOTyuKw10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3325-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9B28941E72D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for building a self-contained image out of two other
erofs images.

1. Create img1 & img2 with various file types and sizes.
2. Rebuild a new self-contained image of img1 & img2.
3. Delete img1 & img2 to prove that this isn't use the blob based rebuild
   path.
4. Mount the new self-contained image and compare the checksum to the
   original folders.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 tests/Makefile.am   |  3 ++
 tests/erofs/030     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/030.out |  2 ++
 3 files changed, 93 insertions(+)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index d8ac0678..125aa8f6 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -126,6 +126,9 @@ TESTS += erofs/028
 # 029 - test FUSE daemon and kernel error handling on corrupted inodes
 TESTS += erofs/029
 
+# 030 - verify multi-source fulldata rebuild
+TESTS += erofs/030
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/030 b/tests/erofs/030
new file mode 100755
index 00000000..8111be10
--- /dev/null
+++ b/tests/erofs/030
@@ -0,0 +1,88 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# verify multi-source fulldata rebuild merges multiple EROFS images into
+# a single self-contained image
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+_require_erofs
+_require_fssum
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+src1dir="$tmp/$seq.src1"
+src2dir="$tmp/$seq.src2"
+combdir="$tmp/$seq.combined"
+img1="$tmp/$seq.img1"
+img2="$tmp/$seq.img2"
+
+rm -rf $src1dir $src2dir $combdir
+rm -f $img1 $img2
+
+# Two source trees that share a top-level `common/` directory so the
+# rebuild must merge directories, with otherwise disjoint contents.
+mkdir -p $src1dir/tree1 $src1dir/common/only1
+printf "image 1 small file\n" > $src1dir/tree1/small
+printf "image 1 common\n" > $src1dir/common/only1/a.txt
+yes "image 1 payload" | head -c 65536 > $src1dir/tree1/big1
+ln $src1dir/tree1/small $src1dir/tree1/hardlink
+ln -s small $src1dir/tree1/symlink
+
+mkdir -p $src2dir/tree2 $src2dir/common/only2
+printf "image 2 file\n"   > $src2dir/tree2/file2.txt
+printf "image 2 common\n" > $src2dir/common/only2/b.txt
+yes "image 2 payload" | head -c 32768 > $src2dir/tree2/big2
+
+# combined reference tree
+mkdir -p $combdir
+cp -a $src1dir/. $combdir/
+cp -a $src2dir/. $combdir/
+
+# build two source EROFS images
+$MKFS_EROFS_PROG $img1 $src1dir >> $seqres.full 2>&1 || _fail "failed to create $img1"
+$MKFS_EROFS_PROG $img2 $src2dir >> $seqres.full 2>&1 || _fail "failed to create $img2"
+
+# multi-source fulldata rebuild
+$MKFS_EROFS_PROG --clean=data $SCRATCH_DEV $img1 $img2 >> $seqres.full 2>&1 || \
+	_fail "failed to rebuild merged image with --clean=data"
+$FSCK_EROFS_PROG --extract $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	_fail "merged image failed integrity check"
+
+# remove both source images: the merged image must be self-contained
+rm -f $img1 $img2
+
+FSSUM_OPTS="-MAC"
+[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+
+_scratch_mount 2>>$seqres.full
+sum1=`$FSSUM_PROG $FSSUM_OPTS $combdir`
+sum2=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
+echo "combined source checksum: $sum1" >>$seqres.full
+echo "merged image checksum: $sum2" >>$seqres.full
+_scratch_unmount
+
+[ "x$sum1" = "x$sum2" ] || _fail "multi-source fulldata rebuild mismatch"
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/030.out b/tests/erofs/030.out
new file mode 100644
index 00000000..06a1c8fe
--- /dev/null
+++ b/tests/erofs/030.out
@@ -0,0 +1,2 @@
+QA output created by 030
+Silence is golden

---
base-commit: feadb09fcfa1b05ca930cfce871d0e56f6bd3a95
change-id: 20260417-b4-fulldata-test-b8e15272bc59

Best regards,
-- 
Lucas Karpinski <lkarpinski@nvidia.com>

