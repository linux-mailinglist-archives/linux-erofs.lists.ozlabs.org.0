Return-Path: <linux-erofs+bounces-2353-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBGYBRfKm2kJ7AMAu9opvQ
	(envelope-from <linux-erofs+bounces-2353-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 04:31:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 337831718F9
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 04:31:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fK5xC2n7Sz3bf3;
	Mon, 23 Feb 2026 14:31:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771817487;
	cv=pass; b=lSyuCJYDSeXX04INocSVCPdzpQ/uUc42byR831vY5vgznQH9nfq2Ggww+l3YchSVoCLRbiHJrsFbfp85K1eYldeFPR3DE8jrLDX/DHU10AS8UXxQsVFnnB9Q1OO3ZQmnvuwVlk8lI2Utn1ZQPXYaUteUr9loa1236jRC0J/Xl0EplWldgXZC6iyOvvwU2vghIWxWqq8HlJJjVHqAf/G/9O3zLPpaV29X+oh94osj0zC1oXfC2CY0UEPaZYX+hHyCMTEROb6ujGqje4Q3Z6wIDmcONgc+Jk27bzLNd9r9cIB/AZUOQNW2MJmPNUPCLiAMNRrWhXh1hbnMOzO3nkXlHw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771817487; c=relaxed/relaxed;
	bh=jjUF0d4QsflH9XKowPzKdRadyVdtlMGRJbn9sUse+Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjbyEAD6nEIIGW8a+DrnVd9VSKLnvlGHtx4HTUbuxlPQYoDX/2HaIiScCOhFnXpcG0tG8MZjuehBCBkoRSrOKD3sO7E66UppjTixGqbdgR4ax5nq9hd53M0Bj2BX2WaVOt6VoqqWIcvMj9vGMuXuHOgg+D9O/avnQU47lGzzzMMSvro34vPyUoPCT97tkd2d3tuS4nEoJfvFcqharJu2FFb1og07/Gl7+MCF4V8vPTAl25iVrJYNZNtVoO1ZLxUX4IFWphmhmMdUDzfEm3wXNN7/sYZJa5dcnOjw7nIMD9/g9Y7+q91XPisbDg9Xtva7QOSIbZWmaADdczOzYeNLpg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tMc4QXQG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tMc4QXQG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fK5xB6WjBz2xlv
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Feb 2026 14:31:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGjHWDQKDRzoOuIS5I0p4T2wi+cF5as6m8hZfx8ELi5wjdq19s4xo2lchaXVZvm0e01xa7+gtw80/fcD3003GXqJ3xkh3UQjmBkGwCPY+E2WgWupzvMqsIbLvxUVfzpnL2cbtMRgMj5MXPBadavwy7hRCftv/zwLjrOLIpH/ybAakaO7lgVh4Y9yC8Mt6wq1A3vxVad7DQTlL8GYsAsodez1n1YuoCJdqat5R0HWPQqAWZTTAbXtYxmiDkR5TkW9Na+0b4ArbgGeDmJ/pJOMjM7omxBWgUwqDORR7B4oc1XVUJljo2StCL+HkokdzI7Ljhm6uU1s5qlJLEOdvefKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjUF0d4QsflH9XKowPzKdRadyVdtlMGRJbn9sUse+Ao=;
 b=dFE4oYmAE8Gf5ZNCKQWoZVKlLLZjo5q0XxOeyzeIntwK/d0nAYGJXwjWzxwcoNKJfnjYyvgdSKeBznmR4xtmGgVDQzyobs0woiPi2mJ8g/QsRAHdTN0XHprKVe9uoQNVVeA5s1O8gz8Z6wKHaSX7s14VWy+ymsNBqwT4vj3JlRTyj1YP0v+mQBSb3U9220MOFI5nKLuoePTbF4KD9uBnEEewnqpmNfG0tagMURtIZT5XCBJS4Xj4/Qr5cSWF65sgx2RbmQ91cgpasUoPTMC5EFgCA1FyfNehTUM2yJQKscfU/DHkNfWCtZYxyGFDFrpFA1mcYXrm/CP1refH+5kAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjUF0d4QsflH9XKowPzKdRadyVdtlMGRJbn9sUse+Ao=;
 b=tMc4QXQGxFTaMZN7/p6NXVnN98n1D6fDzzbNiyns2btAcxU+auaP84FuejeWjp2PyGzDcbNyU49FapeOzVwamfgHrX8yVhtvjtD6hVtZI9Z0NIRPEk+pRSvu5tnCZr9x6bsz5Gkk+RxNS8O6erTS1QmtwyelKVyr637vhaiu289o1marEjNsbYQ/sy5KJx0/t2SIrY6HYtF/riabuwZcVbuBWaDMy9OjTf5jEvxWegFIEVMxYUgy+hlo6esMx9oF9I1pu/fa4AfyRMGfMndwIZXfAQD5mjIOnyT6lcUO0Mj0ohRLFyrCq1mx7lxrNUCDoX99geisCuNSwxmJwyBw6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 03:31:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:31:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v1 07/11] null_blk: zero page->private when freeing pages
Date: Sun, 22 Feb 2026 22:26:37 -0500
Message-ID: <20260223032641.1859381-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c2dd34-18c0-47bd-08e6-08de728bfa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/2D/I8DDlhytMFEJFJJH4BheJLlk1XYVxcWbQeQWEmCI1pCuN11jxyfFHxx?=
 =?us-ascii?Q?y8M9tLU0jHlyBzlZweLWZrg9DB3GjFZdq6pDo4urK4jyC+Z+o/skP2CnN+pC?=
 =?us-ascii?Q?nf0j3P/R0jf1RehJOfrt8JksdRYuTbz1khZl35OYBB1GYnpPf6TexvdN+KP0?=
 =?us-ascii?Q?/ShojhXIM1UwV8Pl8mtDB1esytcMu8ZVXzrOY+rD/qskxNmsfG+6D3Rs9Hyr?=
 =?us-ascii?Q?MsGF+Zayd3VWDnWepquututsIe88ey/jxCquXTXwxRP3D+38m+cp+LhvpeND?=
 =?us-ascii?Q?sAO8v/LK118aa853HPV/ckuoFgN45ts1fAFWu5kaHPWztfUDGvdZEhsqSSsl?=
 =?us-ascii?Q?0TpuFIOXjyzZZLtCEpL9ik7d1CZJGhm6xXwlOWQqok568Coz0ZFK3jJLIzS2?=
 =?us-ascii?Q?lYejuZfTeqPDIUTDl2ev1AOBfLzlP4+5lluEEW4hbetiKA0YP60uh8Mr+QeR?=
 =?us-ascii?Q?XnOvte1x1KR7+cU5HIL+Ro74J3Vs+lKaLPnDeqdnEATcsTwbCzVIP1JMo3NS?=
 =?us-ascii?Q?IPv08tg9bMIzUePjGNVjB2sDICuzj2zM8q3SaFqVqjdSbKidh6ttYlLPb74/?=
 =?us-ascii?Q?irOBAAuWGUChkbcjVC5VKC3+uvFuySf8O53y5CLmerEXade4QlqKvONSocEB?=
 =?us-ascii?Q?u3m9LNVGEpAeGgSGOCl0AI8ujYgfeWW6NK2z7s6y9htUK+Wyi+aKqbzceb9T?=
 =?us-ascii?Q?Lcd5S7vPtosCR4sc/6N5qAfiT9WEty6PG9S58XV4nJXfrieEAjOeKakC743e?=
 =?us-ascii?Q?zGQxjZO90kQfVeTR0Znn6cc9Kb65plAkA4PY4H+YgSYmQBXhLhejS6izbaTI?=
 =?us-ascii?Q?sd5+SV4jlboAiyxNOZOkWvQ68jTh60XaHZEJcKxc67q2iDpo5fvElbenIedY?=
 =?us-ascii?Q?PXACL1EnEyGX8tOvHfxROmANdCDp0i9sCmO6RIXF/Mm+6ZABvsz+2zMcVgKG?=
 =?us-ascii?Q?3CfhKJL8USSiKnxCAxops0Goy8XMklyveYHzVbMQOULPpC7iXUPIgbGyupaU?=
 =?us-ascii?Q?GIZLDqCqWeLG3Xyvse/m5AOi7Cbs/MhwTQG9LtNTYl/i0lD9mekVYMxV5Zut?=
 =?us-ascii?Q?oXMBjKv7MtdFsHpZCu/in1qvS3jgT+xqCVcn8xhfJHG1znx4c7poqS2OGt+H?=
 =?us-ascii?Q?9xvZD+iw5bEi6g8AnZ0GnF4oxpAnBd6WPPyrZlVY1YfiXYd2labqBKUw1Lyx?=
 =?us-ascii?Q?edsm+vOiXjmd3YiSkTK9JqU3nSi0zqoKSY+/aFKZRAVrh/sk6i41gi4ZcK4X?=
 =?us-ascii?Q?QJoldjLWwugjausfWFPsvQADhFECgNePxw4N5o0/WmctVKgnMmNMUjFPCs9y?=
 =?us-ascii?Q?/IrYBy6iqERBd0G49uSBJ7j7QVzcjt0pl7EY27ZswiPNCsR6gejKTGRohj9N?=
 =?us-ascii?Q?xTCcZ8HpqhVi3rD8JHT/TDbHevF3KQZ+iz9li9UabvrtqX0FeI6/z7lfkKb6?=
 =?us-ascii?Q?DjadzwpPMkzPzCVjoodZhA5g5JcAU/9ORWMAje9+EpdghIqvI+LNelzGR5ES?=
 =?us-ascii?Q?jp5jAXjcJ83qd0g8eSW8qQThANJwkHoJEBe10RoPPOzLL96VnxdmZmAxWGr7?=
 =?us-ascii?Q?H++Be/bkeuB/cxOCOJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxInXFkLFxu9I+gSiqXgjcR/96Hc+u+NxNO0DAC+hYTPcJa3t9XsRPhyYIyC?=
 =?us-ascii?Q?VAZILGCL3uEtVLyeloj5Fv8Uu9ojM0MqDXBRkq+hSm1anXAYsSK+IJ9zRMHb?=
 =?us-ascii?Q?ZGE/oEThai4ITT1C5mAWJoGmlNzNIMGhqK169TKiz+W5sz9hfQCMCw6dc6/Y?=
 =?us-ascii?Q?UItYwkHCxsUZJrZC7QEBU/RHR1WWKRIfPaN5fhKBMQt4/Gzgjr/tY0vj4WuL?=
 =?us-ascii?Q?2P3wLSZ5gMSylWF9YbGL65On7by2imPkyXsfkUuaDMQtYld49Ojs3mNnYpMR?=
 =?us-ascii?Q?ktr2Fje4lrkbwh631ctOaG4fEVgfLREcaqu4HbIeJr6NMMXLGpNO/4jV/RO8?=
 =?us-ascii?Q?LQMsESotKISbLHWPV9NIU2E+XknEvPycRUNX3ytZIXl1ew7tfEvBFS+ZesFl?=
 =?us-ascii?Q?Az6Lg1yknOB6k4/HiIexe+RiAcpUA+ypho+zuaCvZjVIgCYsCoT9TrLEfx01?=
 =?us-ascii?Q?KgU88c4K9HIEhvIWCTFMpZ+iAj4EtQuD8s3/YXsyVGj7Bp53YXMj1+Obl5ja?=
 =?us-ascii?Q?459GaHW4T+lz2VXT0+mkF/n9ZqyH/zy9m5RVW8zlDZfQG3CG24lnMDtCz5Q2?=
 =?us-ascii?Q?bdPCHTyCQHBEl0sKkZgsx5NHxaKSPJ1rx7fDarEBw13tYV2eQ1/BhNEGt3+l?=
 =?us-ascii?Q?4GRIRn91o7UpmOBHTX+bBMTGi5S3quAv+/xxx5eTmlyOHONsWfiS7MWFhWsu?=
 =?us-ascii?Q?st5pvzkCbrz01KoXvw/14Hw3ILoBT4ECNGYPa/zH7AOL3b0JFSdSjdZ7KYEL?=
 =?us-ascii?Q?Hi6lC+a8YqE30Expy12KX49AUhFrOn60rJ7SF4JoS/WkG0fRgp+gUOdZvftL?=
 =?us-ascii?Q?Q1MwjvFIVpV3y8u5d4tcNpevogxjwUuMugllN2AjZYN76AvDJLrKysZfrVTK?=
 =?us-ascii?Q?GkCJGYFoac3eOdzT5EJN67H6IAXf4dE0iCknzrU7CdjPJVp/zi+s/wbjmd5X?=
 =?us-ascii?Q?CMQ9znufLKTYugvVHi1jMV7Y4cJQ8iKJ4X30KilmdihDxeL1ekN8RxCuwZ7P?=
 =?us-ascii?Q?wPAJS6aldp8pUo/w/poi8IbFFEfXNAMC8oZ1jNqnmvx/jcIP99duJZhw6jc5?=
 =?us-ascii?Q?gIUERh52epOwLnmIeqDlYVI/35TPHPmeEBfxiSMaUqcNZbYow01ytRAM0YCF?=
 =?us-ascii?Q?4CFJgrF94kN1Y0Z2MADQtqTmNA4W1DkAK4opSuMmbmDqNJOLfTHnSu/TFyG+?=
 =?us-ascii?Q?OsdRmpiM2SwkysHiDD4vRM/sVGgLh5gajF/i3yxqI1m1FdkFObALD5Z2bzBs?=
 =?us-ascii?Q?gpN+dn/nSp0n1mw6pptzFrYRBJMf3G+VvDQ8gPp8De3DZDPAEmb4YJTPoA3j?=
 =?us-ascii?Q?OCY5U8AUR34QyswzgD7n7Negt2m08mwQXI55QRyVykpYez+31WD/UZiH52mT?=
 =?us-ascii?Q?Al3Kl5IyAJnZ8gr6KexWwrRs1tm2s7zH5J1KYwjN2VhyX6u1WAWMMSwI/4pL?=
 =?us-ascii?Q?TnfOPcjKCeh0ECOPDhqpCk0yiPnFrrQtnjrBxYPV8Iixj0WBjw+jKR9Zpt6t?=
 =?us-ascii?Q?BPdXXp3KgU+0R+z3eByxlfuzuflAqW32e+ppD2kwpTKsYhH6kJ6HHcfaN2Nj?=
 =?us-ascii?Q?HGlsB+mCN+d5kguNl4t8gVQpUuzRP9cKEPgiDHq1d2C1HggY1aCMGqu446u9?=
 =?us-ascii?Q?I9Qi81xE+QxZsFvbmXz161eJnJ8DVhlqX8g0PTt+9xk3wNNEE3WVxrZ+WuMq?=
 =?us-ascii?Q?C7d7ulJYArsIuVh3ZXf0aB7YWvHuY0Pupxv75R+8opj/WaJq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c2dd34-18c0-47bd-08e6-08de728bfa96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:31:06.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYiBd15LmjVQPpW6KUV2lLuhDITUw5wbrHufWk1w4w1humNAJZ5MOc7vJjW09YDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2353-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[ziy@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-block@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:ziy@nvidia.com,m:axboe@kernel.dk,m:dlemoal@kernel.org,m:johannes.thumshirn@wdc.com,s:lists@lfdr.de];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,wdc.com:email,nvidia.com:mid,nvidia.com:email,kernel.dk:email]
X-Rspamd-Queue-Id: 337831718F9
X-Rspamd-Action: no action

This prepares for upcoming checks in page freeing path.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 740a8ac42075..86ea2644080f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -886,6 +886,7 @@ static void null_free_page(struct nullb_page *t_page)
 	__set_bit(NULLB_PAGE_FREE, t_page->bitmap);
 	if (test_bit(NULLB_PAGE_LOCK, t_page->bitmap))
 		return;
+	set_page_private(t_page->page, 0);
 	__free_page(t_page->page);
 	kfree(t_page);
 }
-- 
2.51.0


