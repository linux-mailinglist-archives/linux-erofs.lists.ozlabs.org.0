Return-Path: <linux-erofs+bounces-2302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C6YB1YbjWmkzAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 01:14:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31A12873F
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 01:14:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBG4c4XTQz2xm3;
	Thu, 12 Feb 2026 11:14:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770855248;
	cv=pass; b=eF/zsfq/HaGbQcRe4+o6uqyb65tLkT7LqVQKXOX6wj9QR/Y/IGik9O9e5zSwJjjH6ep2QspVQ5vR4XQQOi2MhSE/1rHXT1uTsy2gg6eHaG1IUaCIwmQ6Q3X30C7zxobTjvLnIb54FaY4JvHOFuIzGX/5T3a6ZvZaDVIcVplXGsnopC1j8ejoMQRy0JWhyNq+nb4P7sBny/K5TrZRmnAt6Q7pZT+bFvw/2+FDUTbS5bP6KAmpu1J2WtRrT6razPgYUIrHl/IaD4sHArsEV0KSn1Wxhap1Vh7PcTe/suyCgBFhjeCb3LE+IryCKuw/vRzg+WWMFmBgMCGWxVdpxDLcLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770855248; c=relaxed/relaxed;
	bh=6m3a16GgSVbcKr5tVYvfwmoZOky9uLqlb7TKLrmkPYY=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UHysSHbMu5ldT5JjdlqK/lcUNuErJYLsYrZZd8BMJll0cAYHNH2IxEvbi/YWRSUqPGOtDogZdfsa5MX5HhbVoU4OSjFOoqxmhjOyOQcjyU6UnzvbUXnzt5FF2Ct8rJR246FYF44A34tOi425UQfyqnuAk0dT/NA63vsBtPTR4sd4d8CAjm+uuuJvwrYJ/G5CW5uCm7LDOq/m6VZMYQSfgPD1YiXG8s3zeiNYix71r2hxp2srhhD5/BlIY239DCkfxNDaQyeH6MTVQnTPs/WAcjKeBnJGQ+XsdbiLXuTHtODjC3kU542JJlJvTLK6vL5AsSo7pO9cV40o9GCi+G9W9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFD0wrR0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFD0wrR0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBG4b0Hf7z2xHX
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 11:14:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAUubALysI/WEN3m9ff7ocQZpCdot7xTg6yquzBZGN+/zWO3gVRDShqZ1hKpbB3V1+Mde9thjDz84ed05jF76N7StTQXmWhrpufgwZzg0K9FjYCsiQcABksKVgWhjhm+fXOBnnUU9wneixwLUM2SrmCNgkCOeCZNd+6GvFKdEWFosaplaIan+fZS5fR725cV+7M94IVFPZK+qHXW83f5tGg8/Nvs0OxXIlK1M8d/2pondczHzVuSmqXdrTidAZzCSQaw3M2ILQ8qy0m7Su4RXoSOmMgq8TXsInI5Sifeo9htZypmEdBa8zUkxGcg9vJ8UVsXTeQbjSBso1XzTX8yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m3a16GgSVbcKr5tVYvfwmoZOky9uLqlb7TKLrmkPYY=;
 b=R2TwcRJDwpk3qYX7qXGiauNsqYBjn9gn1zMf6vZfdvP4JCOp5E43AieNhXGjUv3BBv5uny+NI80NWswvywiH4oDHNR1Nk41D2igghD2bSIg44tIm8bprE71ns+pjtdyQ5z6lHViGaqyvLrJd3vxV2GGJCjIcXe3k+kRQo61dbUdnWeCkHWSpLWZ7CtCTBcomYHPx/Ik7rMMA18toxd59+qEUgkXaBb64MyOSazACBDl/8z4x4tZsq7QdDXAPDweKmT0dCIBRp1NYNWXT2vYsaauIKVa2lqJLRC1ch4iflQC5JSDgrsG1QzGV8pEw3WORnykMj3292Tt1ZO9Ff87wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m3a16GgSVbcKr5tVYvfwmoZOky9uLqlb7TKLrmkPYY=;
 b=FFD0wrR078Lpkn9nWxBLq3RbY2xvdvJV/kY9OXT8IthIbIqJnKvgwFwPpuoG8B+4adSzuzbzOlMGl7E3ekHxa2WAI03OdIgWpO+Bf+zTq93dM3ik8UiTz4tDe7hhMSP4qygqab+hfdpZbg4R98y24ilyxUfWkeQk4AbexUZWjXM+hsUpvr6gfQ4UPc/b37rnpBaANo6mRmSo4GSEnzSCb7uGYd22OxUDJmZoaW7sSRh/eGbBn+wbdW2dowZ3Th0J06j+7SQN21njK8/zz30jBw95acV5FjVKiRugdFrkWXwXcTnFwk553n//KEheV5xg0C+AECGQ5GB9lw0KDpqopg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 00:13:38 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%3]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 00:13:37 +0000
Date: Wed, 11 Feb 2026 16:13:35 -0800
From: Jonathan Calmels <jcalmels@nvidia.com>
To: linux-erofs@lists.ozlabs.org, xiang@kernel.org, jcalmels@nvidia.com
Cc: Gao Xiang <xiang@kernel.org>, Jonathan Calmels <jcalmels@nvidia.com>
Subject: [PATCH] erofs-utils: lib: relax erofs_write_device_table() device
 table check
Message-ID: <20260212001302.72193-2-jcalmels@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To CH2PR12MB4969.namprd12.prod.outlook.com
 (2603:10b6:610:68::8)
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: c05eda8f-6d21-495c-dac2-08de69cb918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNLOFpaa1V6SXNHUGxOdkdSZmQ4K05wa2JQcjNkVVV5alp5b2ovOFVQbElM?=
 =?utf-8?B?a2hHcU1mTlE0dkZQUExOUExIOCtLczM5dDBhZlZVc2ZsQm50ZVgrQU94dFpa?=
 =?utf-8?B?a3I5cDJLaUlkamJIRWFwSXBMMW1Zejd1V0pLOGRjUEJnbjRYNUJUS2p6ZzFL?=
 =?utf-8?B?dFVNWmpYb0kxZ05QMDdEWFB4WDIvTUZuNnZLNkdtRFRiTk51SGFSY2Q4eHBJ?=
 =?utf-8?B?MnVtOWUxUzM2ZWFBQThyamVHaHYvTVJneW5hZnFXa0tGdzR1anEraFArNG1u?=
 =?utf-8?B?RjU3cEZHM1JmY1V3MFJueHdVczhiYzJHMldta0trZGlHRFl2Y1Nqd1lnSnJl?=
 =?utf-8?B?aFNQV05JWkRkRmdYN1phVjlCblNOUkxIMlNISjNkOWk0WHltdEw5cGF6T0RB?=
 =?utf-8?B?U3c5aHFjejlwMkxEdElDbWF6RjBBTTQwRGg4WnlDWW1mL2NOUU5KMXM1bkJj?=
 =?utf-8?B?TGI4ZnFOMkwwTmM5WWpuVldOeHh4cHZsK2JsRUlESlIyV3NNdldWWjNRam50?=
 =?utf-8?B?MzhBcVZOWU52NW43TGltZHN6cTJ1bjNRblNqNDlRa1FGZ2xkSkdmQ21qbkw0?=
 =?utf-8?B?eEY4SWNkZlBaZnArTzVKTU5QaHJNaWFpZ2k0bjFmMnVhY1pSOXJHQVUwRjlu?=
 =?utf-8?B?MmFpQVdwRGE1ZkFpUE5sRklQb1MzNXk4RzJOLzhhQUZnRHJlbGZXTmJwWjc4?=
 =?utf-8?B?S1NkZ29MMUt0STQwbVFiOTJkdlIyQ21FSXFNUTFuWmxpYkNaaTZ5VTk5OVg1?=
 =?utf-8?B?UURXYjdhNzZZRHc4ZXdEMlY3ZWtQaWxMQkgyUGhaMTVUczBWT2tiTDVHRHox?=
 =?utf-8?B?VTRMUXY1cmowa0oybnF4anNHeEQxS3huVFdJMUtoSWI5R3BLVkx4VVRadnZy?=
 =?utf-8?B?dTdBWlJveXhLTVpZYXYzdWZXKzhqZGMwcWpHSWJJOVB3K1I4bGJtVFI4bkZ3?=
 =?utf-8?B?Z0lwNWxQSFVFVVllek1PMFlKNGNTQmp1VGo3eWtzdlJhNCtZa1ptdHlsTWxI?=
 =?utf-8?B?emh2bVExblhqNVF4U08wQ2k0M01ZVDlISlhnRzlNYjFIZXU0STN4STVvbnhY?=
 =?utf-8?B?ZjBra2l2WkpibW9qYy9IZDF5WkxkS21CY1ZGcnh1TzlFTHhOUkIzcXp4WDhB?=
 =?utf-8?B?QjIvdzRGMzV2WUxxQUNEMHJWenNxODdWTFVjeGpYTmMxU2I3ZjcxdllpaVNL?=
 =?utf-8?B?QVIwbmQwM1ZLekt3cU12YlVOSlppdHRMc0I5aUVENHhDcnlLYUJlY0JFWHFu?=
 =?utf-8?B?Q2w5N01UVldLeXJRSVVlTEg5VHQ4SVAyUUNxeEx1MmdwbjRiVkZSNkpLQkU3?=
 =?utf-8?B?SEw0TGQyekt4dExwRW9IdlQyMTZrZzZwWG5ZcFgveE1ydnhZb2RaV3hsb0tX?=
 =?utf-8?B?YWkrNEJ5NXR4ZEpHTTJuNkYxallXaXVBb0Z5MHViTC91RFJQTHYxckozN1pQ?=
 =?utf-8?B?OGdHS2ErNHlydm9NUHhLSzhJVWxwWjQ5c1dKSWM2RGh4aXY5MDcwM1ptNHlP?=
 =?utf-8?B?bGUyazNPWWVaZXJ0bmcweDdHajh6L1cxb2Z1VFhoTVI5Y1pXRWhHK1h3SHhh?=
 =?utf-8?B?YzlzZGZRSjhBZHFaWW5Oam9oTG8vQWVCRlV0YlNxQ2FtYTR3N3p5Z3Jsak8r?=
 =?utf-8?B?SGJSQTJETkVQaW1MNlhlRjljL2hSV2hLT3ptWHRKYzVmdnB2azFTWmpnOFBm?=
 =?utf-8?B?ZkNNbnN5ZWs2Y2dpQ2ZMa2M1elduQ0M0QktYSnpqb2VkUDcxOFBPUHNMcy81?=
 =?utf-8?B?WGdjT3d1ZFU4dHUxb3h0TGd1czdZdUwxYUU2WkIzWSsyN0JPVWE5UkpGZjA2?=
 =?utf-8?B?VW96MGJKSnovOTdaaWxLZm1mQ003VllDSmVaTGVSMUdBUmtIeVRsSjBNdDRk?=
 =?utf-8?B?WWkxT3kvL3A5ZmZ4Q0hENHkraStBb1cyZTN4ZklOR0g1UXRLUTRkZlI4dEtL?=
 =?utf-8?B?RzBKekpIMERSV2s3TGZpT1ZiZEg4U1dFRWlPUUZrdUJHaUdxRnphWDYwSG9U?=
 =?utf-8?B?RmxUUFMxdUF4aktYWkFFQUUzUlM5TjVmQXJSZnp3alM1ZlIxMUNuY0pxZkNn?=
 =?utf-8?B?OG9hZXZObXJTNVA1d2RnNTdIbmJId0hlY0VFSXc3MDlzZDdSOGxySE8vdnh5?=
 =?utf-8?Q?eQ5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZhVTBkaDdQZCtpWmw0bWg3WEkzVjAyTkF1VEt2OHBJcVljVnZmTThtcjRx?=
 =?utf-8?B?SHdzRHVOVk8zeGluNnNaRXVFWUwyZHhoRFIxRFJGSVVDYlJmdVlDdXUyUnFQ?=
 =?utf-8?B?V0doOWFGUmdRVXI2eDNEaWVsZTg2TmtRTkhLTlZaYXpBeDZaclJqY3FIUnla?=
 =?utf-8?B?R1lIMW9JNGVKRlZQTXAydkZTZkcrR2dueVRRZXljS1RSZVM3NnRtTm90eFNr?=
 =?utf-8?B?eTN0RGp4WGQyV3Q4dGthWFlFZ3BHVFlOa0JMSnh0WW9tUVhkR0xxT3lPa0V6?=
 =?utf-8?B?NW1Oc2cvbFFPK1FxekRIOU5XN2FpeW5yNDI5WmgxaWNJSzlYV2ZxangvWUI0?=
 =?utf-8?B?OVVUYUsrKzBmREFpOXhtcUFpcGxvYXRUUE5pU0EvL3g2RFgyUlYwUVJEbEM2?=
 =?utf-8?B?cS9MVWN1V0JzWlgxS3piZHYzUlJWaGhRMnk2UFU0MG5kdXY1WitnOTl4L1lj?=
 =?utf-8?B?UU5TQk5oQUxERVA5NngyUVFaM2c2V3ZyRmpISWp4dmJLTnNYLzQwRzFDSjJn?=
 =?utf-8?B?SlgwSFAwRUtnUEk4UjhrQ09ZVnBVN3gxaXdhaGpkYmVUV0tGa1BrNDFybWoy?=
 =?utf-8?B?SVZGRmJRUDJlOVZvTmZiVGk1eTRCMGJ5SnJtQkVIa0l6OGxwc3pmVXNGb3BO?=
 =?utf-8?B?ME5xZzdIZjJOK0wzU0hCYkVaWlFUcDN1K2RTZ0RwK29tOHNkNklRRjVTWG1C?=
 =?utf-8?B?Nk5naUdibmZBTXZtZTNFbTQ4RFZ5Y0pzaFVFTW5JeFJ2dGdJWkhNbG1EcnFk?=
 =?utf-8?B?U2NnYStwS05SMmFrRk12dGMrcC95ckZCRVhCNWhXMFZITk1WcjYrREFRelRT?=
 =?utf-8?B?WGRleWtuRUpXZk1kWFltM2pvRGhaRUhoWVphUmRhZ1R6eGtEaXRvb2JaS3Vr?=
 =?utf-8?B?Vi82WWUrU1VmYnBKMlk0OUNaclBVaWZHZDFHajJXNTJPZFEzclhPN3cxUTVD?=
 =?utf-8?B?OVFEY2RuU3Q1ekRFbnFtdTdaYWt1MGplcUUyanZzV1pXV2ZzYk85VEkvSTlz?=
 =?utf-8?B?YTUzSWY4RFNDUHluRDNRWFRUcDFjUyt5SjFnUFB5T3duTGZ4V1dnR0JLbVZm?=
 =?utf-8?B?azRDSWd5bUkwd1l5MTdHMm1RaUEyNUZMZGlFK3ZOYjhJanFWOFFXSkZ3S0d2?=
 =?utf-8?B?aWxvSHBodzBHZms2TnBpdVpsbFJud0N3L3hPZ3ZuVDZnbmhoMHVPSUN3WE5W?=
 =?utf-8?B?MHk4RUpGZWpybTlDeGsvS29uMFYvcEFmcFp1N3NxL2NhV1UycFVSNExLR1RD?=
 =?utf-8?B?M2JPeWl4bFZiRU5pTzVuTEZBSHlaNjR6RnRNUis5dWJWT1kwd1JDMi9iRW9l?=
 =?utf-8?B?VDRMRWltWXZWc0NWTjkwNmQ1Z1lQbzgxTjJlUUFmSmtVSUhNUDhYTVRLZWlU?=
 =?utf-8?B?MkttQnNJV25IQmlUcW56TithaktqNG9Od3ZaWklRQzdSWHpjaGJscmdvSy9t?=
 =?utf-8?B?a2JGSXBQTzg4ZWs5dGM0ZXlOTWRLbXNLVXdrVExWUHh5a2ZsRHM3V1BJaklu?=
 =?utf-8?B?cXJZTDRSUmU4cHlLTGxhNDhqMFE4dURvdnJDMzlVa2QwUm8rSmFwOWl3N3Ji?=
 =?utf-8?B?N2h0VzhxdDZ0dkFGY1hTcjdnZ0NRcHg4dmdiZnIySFIrcDNjakdLMjczOGRJ?=
 =?utf-8?B?dFUzNjNMc1YyWjdOTlBjMXlxaEpvdE5JangzR0pMVXBXU3NEUDBEWllVbWpY?=
 =?utf-8?B?QUs0bW1mUEEzbXRZVzRkZW5tcG5XZ3hyZ0tSR2gyMnV1T0hZMXhibWUvVHFJ?=
 =?utf-8?B?cVJ0ckNKaXFURFhwaE1DaHpSSnJhY2ROY090aTIrR0JLdytqM0l3S3VWNDdP?=
 =?utf-8?B?OU9seXJRMWpyQ2Q1MkFjS0F5UnZqYlVaaTZtaUptbWRjV2N6VmkyeGxEelZJ?=
 =?utf-8?B?cTRwRW5UbVF6MzBGeStZbG82azcrTGoxdW5YWEpCY3VLdEhqcnYydENjV29y?=
 =?utf-8?B?Z01RNWdsK1RRTVhCRkRIa2tIK2docFhlajk5STl2WTJ0K0ZRTUdWK2lacHI2?=
 =?utf-8?B?dXRrUmJUQnNnM0xvOUFyN0RTNnU0ZUdhNWh5MHFIbHJlRVczTkhMWnBYR2NL?=
 =?utf-8?B?ZnpzK0llYnlxcWxocTc1dEh0S1VEaU9IWDBCU1ZYZ0Iwbkc2WWYyTWR0Rkl2?=
 =?utf-8?B?WGFCSStwLy9PVC9hRFBxSUFueHFEOW9wTlNLRzRjTklNSHp1QXBvNFFyMEFq?=
 =?utf-8?B?cGNKbjVxd1ZtSlByY1pQcHFxU3ArclR0LzI1R2pENWhpOC9FUHFrQUhNS0RT?=
 =?utf-8?B?ZjdMWCsrVHF0WVd0Uk9IdHJFVFZsMlczNzZHc0NLSHBDcU9CMmFGVHZSakRK?=
 =?utf-8?B?WTBNdjBkUEpOK1BwcUxTWUxaWlpyL3AzdmIwUG5aVFdJMElUeEpEUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05eda8f-6d21-495c-dac2-08de69cb918f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 00:13:37.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktrFWwV07rmAP3Et/slM9a5+8joq9PJ1pMHtxY9462ntFv+vZv0GTHpMiPU8u/nSDw+tu1Mk3fXTZRz+KgW3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2302-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Queue-Id: CE31A12873F
X-Rspamd-Action: no action

Avoid returning an error in erofs_write_device_table()
if a new device slot table hasn't been allocated.
Rationale is to allow erofs_importer_flush_all() to succeed when
dealing with images with pre-existing device slots.

Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>
---
 lib/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/super.c b/lib/super.c
index a203f96..d38396f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -392,7 +392,7 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
 	if (!sbi->extra_devices)
 		goto out;
 	if (!bh)
-		return -EINVAL;
+		goto out;
 
 	pos = erofs_btell(bh, false);
 	if (pos == EROFS_NULL_ADDR) {
-- 
2.53.0


