Return-Path: <linux-erofs+bounces-2354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGtnDxjKm2kJ7AMAu9opvQ
	(envelope-from <linux-erofs+bounces-2354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 04:31:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6F171906
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 04:31:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fK5xD0ScGz3bfG;
	Mon, 23 Feb 2026 14:31:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771817488;
	cv=pass; b=UwVDBzzKpUnj/M3UrqpC8vxkcYTyUD5Jc5q/Q8SQ/f1tTXZ6XUPrptyGZfcqfHxPBTI6bSedN2MJlqeQVqZCeUOfKiruN8WziZXBBj5PeeWR1GvD7PNtSeC4Y38jCSSxX6dNjfoImMm/n44gNbo3fYTgl4h64W3KI3s9JDHOHc96LlUeER9qi7s7fWHJpUo7VfiDFXwzClchofk3kIHCJ/rTCxE5Hgh8oqcylPg8bz1xMGRU/LN9VAy8qSFUNmERBIEl+wsZmt1jr1hoK69GMZJz6qi9ndDz99shrk6JVkNAtXNP+mELUP4vv9u9HSn2/5iY/RvDuI45+Fct7Wy0hw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771817488; c=relaxed/relaxed;
	bh=BYPM2tLyINGZe792Zbs2m07SyfLqAzBEOj373lRBzlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROO7Deawy+xBlVEA3mxtBlmX9CjxC43P1C+MJn79UxAvFAfEFpiNdNALWO34ZeFWsNBmgO3Eutu13BZ6Ah6vkTUOarsSAZVIbcOjNmfay3eH/Stl4ebomjUVRfR7Hb8LQ45TEHSxF4bBn79RXu5QydXB3QFtWgBlKjHt2euswnVbzn2DnXSXceBnZ3baHU/JzNZmyrg6PQQUsUMAucJmraP3eAEBQrOLAnBJ1+tDHITTlO6ku1pEPt3lnw7y8PgyXcekfM+wXH7lYQM0HgB7u/zvYvvls5E7yjP+4JIdJ85n+14hH+MqCz/A1aBk9bh32Km7EtyIoCWBq2ZaAUEq4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANA83VYv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANA83VYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fK5xC4RFYz2xlv
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Feb 2026 14:31:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO+Vmj9a35GNxume3IkKY9SkvSpC+Iij2HeK3cmY6b/csNpD2yY44W4DLqYNMq8HWch8Wt6xynw8woJkDxhgw3TbF3sEUNW37jINKuuLoW7CuKKvdxrpanSAjrN3FgBixT/vA4l0zaG4kyhcM6Z1sFQP+k+K8nzMbjU3ZjYikQ/KzBApXJnRh8PeoxDgtP29Md5c+Xs9WjEiz+aTRyaX7U01nwVtIUCM3qiYNbFpCI/Jrk1vwBB6gOhOjOEdr3n/CAGAcu2UaICPLZ5zO3kn0A/5+Ykz9ucYhH1EamsMrNOQQRKzCEXP0PJEFt1EaFqzJLKkVKuFxQXyXfvvtDJPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYPM2tLyINGZe792Zbs2m07SyfLqAzBEOj373lRBzlU=;
 b=W7Z9XO3EVdBYVYs9JlTGHwAyeHGOCyvCoudzhoruVPpEorytJoo+Zt6pozHL8++9qYL6vyNukgTLozo75JhWqb/WZj0VZP13dt9OXUGrZxj4ivmMVF/gkYvb7z7JPG61OqUdsVxIHyyrANk/Czef7JNwLpdm0q6LEeC+V339fN7aFA7JIkEVQ4re5bcfFQ4k6ockskwqvr0Kta3txBkpsTGU0l8YRIo6z0zw22fKXl1eAXB2fBlg9+mlErkRZlBavw5R1aK5xIUP6Za58ZkbfruDrrWHx9sbRodMRbmmLWqYNmWhyOT3jl1McNykCw+4pCaIyz8l7YVNVMwnQ4f4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYPM2tLyINGZe792Zbs2m07SyfLqAzBEOj373lRBzlU=;
 b=ANA83VYvMzhzDEpHXY/Z5M1/OXiXOInplfS/xy8dk87205BRpgOZavw6YHl5PtquJ5d4UysmwFMbXf6WMmwlMiVhw6teo2QZCSA0+lwK5juZ/hTsCK280IJztm6V/Nm86UfKHrg52G1JDLua3bB9Yqr+vXTJ7pIBfFi4fLmdQseulKx3F8IePOyBK/OXAzxyBihxalq/rwKpKSVA5wjgo4iGKWHK0oX0SWLVBLXyKAGn0+6VIXDkxtq4reAdcyPItd7EIix9SQ/Zuf2X7nXvyoq0hIfehApXhhh2KCVODPnTtPcahxoOCZWxQz0VPGCltekRJQIZzxC5eHysXYOVEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 03:31:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:31:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Subject: [PATCH v1 08/11] percpu: zero page->private when freeing pages
Date: Sun, 22 Feb 2026 22:26:38 -0500
Message-ID: <20260223032641.1859381-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0139.namprd02.prod.outlook.com
 (2603:10b6:208:35::44) To DS7PR12MB9473.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 09aaba9c-b79a-4e15-2051-08de728bfb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/Cq0rwX8HsRSpZ5iqKYu643LYk71dtHkWArLA8XreTleNzVnkfQKMzIuj7l?=
 =?us-ascii?Q?0bomxg7ukTUIQ8IMymBym8OlPbIOVJSL1ev3l5P/gMg63BGIIf2IDEggoVMm?=
 =?us-ascii?Q?9IALdGxgTCMVoDoU8mzOiCHBSiiNgQibMRIHSgkOQIYbiLLFOFMjPGFBYcb7?=
 =?us-ascii?Q?dYCmzv5tMCMew3jIeH7WdLw385/w3t9ff4XSRhAYfJhPKKt++msw78UTGrxa?=
 =?us-ascii?Q?oMbJQkFRIVStvsk7ObZUwMOs5RplRV0l2tdFbCqLiZbC1t5D/98YtAlvmtHs?=
 =?us-ascii?Q?iH+0EQxw+98Z9e7U0BUac/44O0Te+u2tPl8OJvMtTHig6fdUqBMVcxEn6Y5h?=
 =?us-ascii?Q?6P1LLeL9SBOJsi60CzLP3ZhtVPq583TuVcedSGq1ElvdRxb96/h/VSd9D0wO?=
 =?us-ascii?Q?RDSt1wLOmdRuZRInhS661dzBdmnYeCHak0PcbjdEJrUClnrxpBBZELkWY79s?=
 =?us-ascii?Q?KIBmdoehnmMIaC0Ly8r6a0PD6EdcgnDDzFJ2WrEEI3ZVc/igx6B1LEheX9TX?=
 =?us-ascii?Q?2WvQJYDw66jmD+F3ypoi66gzwtZbUCYvF91NQWGqB2fG/b69E6Isk8PONFSZ?=
 =?us-ascii?Q?R3Wtx5LDyABG3BYZMapnJr1d6/jYeixjKZ3wmdBxUlfJtsOCASNhQsRY0gfM?=
 =?us-ascii?Q?cP2ak58I/Mohi1vnzhGg14iv+ZBn/yUrlGN/J4s3EB3pzYmwUTqFVY/LGCp6?=
 =?us-ascii?Q?TSwkfbi9SfTZ16OyZmTWjU9sanNAet+ScztzoOq0wJfm7jg0n5oz+rOFCL0p?=
 =?us-ascii?Q?gcRVI8lQ7csEJjFuvHcBFFGK6edzTGsbeTkNTwg0BusYASN5lwxaye1qTI3u?=
 =?us-ascii?Q?9Zxmlh9bo2hjyz9YWLQIGKm62cUgtC17/GMfXvg67BDbo+8wRxIIu4z+CiOw?=
 =?us-ascii?Q?BnNAUWg1QIEIB5UheK4K1P5C6ekPSJad7wVPEoiWdo8v6BzbMSRm9VQJWRQh?=
 =?us-ascii?Q?0924P4TKgTfRwpTD64rgEFuhoN4Cm7SFDS42DfvNyFlWth5A7HUo11LTAYp3?=
 =?us-ascii?Q?pbmYth3UcoF5qeCRjXYTcU3Cz4z/MOxaKWnYVj81TxGm5fKSWZHbsZG5SZ2f?=
 =?us-ascii?Q?mH/zYkaigN0URnFiJSg4K6AHC8Xu6UF8lhMJIsflGtKWdGlqB3WGHz65YnJN?=
 =?us-ascii?Q?Vr0ZN5hFFmqlvheBWfnpk3Nq/FBk/AguWED9vcRywFA225noywou1tEVtMwT?=
 =?us-ascii?Q?6S1xcUlY65iCnv8M1nBX7GEP+C6Fbdmz4TR32JaQgyyKpmFlpgBXy2DJG2Ng?=
 =?us-ascii?Q?63p8J4gVKnQPikmnOhrnNH7aLKRCTcR8e1eK9CtEvZbbht5h+gjw6VUcnP4t?=
 =?us-ascii?Q?6G3ULcwMIFDHCme2o1hIHYez1dCwtEOSe27iHg5AXt0uRCqQXq0AJTqQfewx?=
 =?us-ascii?Q?SIqzs/FiQmDFy70GMcetWHXySzgUkz5ZkR3bXdaJgonEdT01ROD3mkonrT1b?=
 =?us-ascii?Q?fRAdIuTtRxOZvYRdILuoprjindSZ9e8tFucYhBYKxx62Y0jKEMCeyWOxU/wA?=
 =?us-ascii?Q?K1gTbZqA12/dJjR7Z3fbb7MSU7MHGZB2uOTyQrouadiq5G+y+RBnIRGEWkTN?=
 =?us-ascii?Q?hDpsykpn/5uPqdC+7rs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pOuoTKzM/hWhYyCq8sR0Eeqn3iDiEfokYdOKjqW/UhWKchTtiDxs91942Op?=
 =?us-ascii?Q?HonltLTeBxg3YAO+fcW+SRv4uvX2Djao49MwSX+Yi7kC7QskBz156fGbNzNX?=
 =?us-ascii?Q?kKb6vyfJ31xr1Pwx/9LBYoRM348RxkD27/TdT4mO48mxJNJw3AJAa6As8guA?=
 =?us-ascii?Q?ifzH1Vp/hfTcurS2Jx8Kb7AACdWM5dlJZ9FTHZYBhyKXC8p0gQExdNJcxXh9?=
 =?us-ascii?Q?qGH6B/9i9M58tpfvRk04biBF2MIVpjfFXNEoBaVQOFBV/jG54sjEPyjnRxvf?=
 =?us-ascii?Q?c8WiJ3+wmcf7QkYGq5lUsX6hTd7ZS0kc1QPX7L+uKP7kXkvDqOp+eZtityIj?=
 =?us-ascii?Q?9yOzXl4zlRx6pBiBarOFuoZED/YV80J5mnb0R9Y/JP1cvB5bYEnwRL226y3O?=
 =?us-ascii?Q?s9PPzHvUapPRXRi3x+eresdG2oHCFICYb1BplVJpPdpdpS+PusaJdA366l9K?=
 =?us-ascii?Q?cOnTsjn9jFDRAyCjuvU07OcYhbqRK4KHd1jcwD0mJRVUkiyHRlyBFRltNp12?=
 =?us-ascii?Q?qNRdz5LAbJ2r1DsD0DdLqinkRsoqhB6MDmL+5SkeSHJgrcHNb+Io0rDJPukg?=
 =?us-ascii?Q?zjtKI6qS4R3JuZuA9tzYoBZesOb3uXRNnmOrutqyvd5ZmW65SGdXP5sh7d3W?=
 =?us-ascii?Q?9mS++/y18594w9/15KdXtIiM1caSK9pDe0MU35zpK7is7Ii2DpJIWufYwoxQ?=
 =?us-ascii?Q?oCxKycKFskbU0e9IeFQgMLjMRGXUL1Nol/ilV+N8IFHNRq5n4mgjAni4Z6GA?=
 =?us-ascii?Q?L/3PUioNm4LrCWXXPwOwzL1V5l1S6u17a0msNmKPYEQEvU8NXgKG9XBSx9hZ?=
 =?us-ascii?Q?/4ZUXLNn4cy0zntU6shSNurEWzs69kwFj9AU4ce83mFydzP7gZE5XO64ax7E?=
 =?us-ascii?Q?iv7/b8zqTTc0LnBTiI4uqvNmPjBCt4WRm4YFwpXASvCZXhNqMiMLpZiNQ7EH?=
 =?us-ascii?Q?YtX4ZVnMdMGF0x+NjPrdTXvn/lYxgognWHfBoEdcUPY7X3gb//320j/Ul6Sk?=
 =?us-ascii?Q?BbS4LMSae22/nIQdvjI4X//ns63UmYwTNxuu53hEraZSvBa+YqvLd8yA5LH3?=
 =?us-ascii?Q?LKIIvFBOzQF987JxJNW10j7iYXnuZkdHpJjxng7lCg4UoJk1Qp4zc1OU4JGf?=
 =?us-ascii?Q?UfPdQlyiGsqRf1BgLT+hckmfjCGfTMA8IaVJxJ0ig+6wMpjeGaAbcADHelqH?=
 =?us-ascii?Q?aAceHNqk8svA0AQ/Iiw1jSoMWWbrrE/3m1DwzpfXrazL2FV7DyoxymDQjgFf?=
 =?us-ascii?Q?4RXiYza/7XIiK0tcQF+BgJM6yN/5VlFWvkO+NaGnDXo/xfc5Qup3ER2RThCG?=
 =?us-ascii?Q?lupr9Qy7ohHpxKbzOLledVf+Fx4zZPyeZrENuttHllXbuz8JyfgoJ5pBR0Rv?=
 =?us-ascii?Q?WhBL7+4PGaV//4Rs3PSqMlyvyNGj6TaEGPz8YJ5HHNak2nx8WC9qRgczGwkr?=
 =?us-ascii?Q?+2n0lBul2bPSYBBK8F7gIc7XziZfLiNo05tXcQDT6TGtx4Ze6EjpzWXSKPbZ?=
 =?us-ascii?Q?CldB5bReMz63LqyrrRZKXzNzczm3BTjIP+8khD53/pS+lghMrcpbyPpgSqix?=
 =?us-ascii?Q?TbcBlgamfLEXhIlmK1mECPtylrQ7miKeS6/RYv6H4s5UVEHMQW/SnxOcSSqr?=
 =?us-ascii?Q?X08yL2f0q65MUl/0iTrXa+oqdTO77W0w7C/t94iXD3lyezboRwMliS8VJyZN?=
 =?us-ascii?Q?QRsK2HK/y0cnemY+xDhwG0UUX6HHo/1w+oXGUB2PPFcHl47N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aaba9c-b79a-4e15-2051-08de728bfb54
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:31:07.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KmmalAKiS+qWaHsd6D/Lh7pTKRqUTkTxc+uTtbVdKv5FyyVO9obo+ko6EhsFjTc
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2354-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[ziy@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-block@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:ziy@nvidia.com,m:dennis@kernel.org,m:tj@kernel.org,m:cl@gentwo.org,s:lists@lfdr.de];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,gentwo.org:email,kvack.org:email]
X-Rspamd-Queue-Id: 9BF6F171906
X-Rspamd-Action: no action

This prepares for upcoming checks in page freeing path.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: linux-mm@kvack.org
---
 mm/percpu-vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 4f5937090590..edc8f4448a8e 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -61,8 +61,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
 		for (i = page_start; i < page_end; i++) {
 			struct page *page = pages[pcpu_page_idx(cpu, i)];
 
-			if (page)
+			if (page) {
+				set_page_private(page, 0);
 				__free_page(page);
+			}
 		}
 	}
 }
-- 
2.51.0


