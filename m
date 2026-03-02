Return-Path: <linux-erofs+bounces-2468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNAXBu/spWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 185411DF135
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqbv3DY3z3bnm;
	Tue, 03 Mar 2026 07:02:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481771;
	cv=pass; b=UNliPDFwmjiDE1wpFyvnLyV/tx56WGus8agk0BznpMLCTwnPJ3HqHdY/tsDkxEfvSjSJ/LgtfNxTc0gRquHqABEwb585vnh5jlKjzsRPEvGSRJb3NPSr28RTDsAO4TeE5/yUG/2YnImtux7AB5Ify7tAF2YiEuMw7iPGNn0Ru6gm0eF4GHkl+Mx7QCw3zo5IHq1O8CedEOSEq00gePquf1pgJDttHXFugX16RmanFxBWp32xttgQwyyyCrNAx5+V/ggYfJe6xh88IOXqtRCs9beTgbPfuTQJELRUGa4G48oDsnAw5QuNu18+ryQVaE6O8hV+I2WO/GISGltB3sc/vQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481771; c=relaxed/relaxed;
	bh=AwIl8OU1Hs6hSQIdrDER4mSanSXiW7CishbAqn9bM7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDfXeMH1mWKNAh+ES4evBgMTU1xcscCNJaIG6LlhgNMGQPuK6+R9hQVBP8ew7AuEDJZzrtqaeoLvRbtDdr3pNLERwC227oD3JSZXqkw06egyk7qL61FQmDRZ7eF2k7RwyszmSHJXUgmWQNrFkDPrTGqjfHRQykGGCO4KJ4PSr82I/XZbVu6sE6FH2lJ3vSpJo1Xrz04ZX9rPK4EYF0fIMveqCHHDR3Nc0HZGZukh7P/sRuv8dvNtPEHRXPq3wxmXVf0Fk84gSGVX2wjB4X4j4bl5H89HAGggAIcDxx3zQ29ZvmzgIkmXbGzJmy4uY0WvTMHN4C5r11XrdAS7RafVjg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oc2XXFvW; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oc2XXFvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqbt5yvrz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTePrFnsZgzlw5hJw5WSxKdGVSp0ycUHKqAJb+QtrxDGWALPspbELP0+seWFI1Tjqhhqy+Do47VGm+QJQaJCAjnwKOA+YoXniIVQd5r4FjCt5KCKZGcdkqEryJW65f4FH1wNQ4eBDDQE0SjjpqOvWF8TzYVoHIwdF8ZIWIKHDijQBc73hLu6CNMzID9UB7Z08TesDGPnqGWJtahYP+UAYO5xkfcBE3L/hJfjH7Ne+usAedvEJ4RRgKlSZf8Ck4YKWXNSR1T/tiHYuSQwBP1VPiJbk0BfMTXcwAEEe61NjxQChVsFB/pXOmwKqNqjnVmh0RE/tGq7JTqb19Yga5O0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwIl8OU1Hs6hSQIdrDER4mSanSXiW7CishbAqn9bM7U=;
 b=DrUw9exmZW236dpmnYQMyc2cNplZ+8nhB4oWaikPmDz/Rarq6grqk1XDqEck6kVbnxF/8n3Ce6orqqjGifve88azZnh6ZHog2x6chgQEUP6/GRAPrIAFZl5OEVo4WOQTfm/kIOfDAYQsk12yTcGzfWTfraB3bqgqgO0OyKLDNbeqPHfTBX2/GaB/ZdxMIoihWGaPkuq0LKZZ7y718wvomHCJ5jZUIX49KYhsGpkQAnayvjXpkVUbI4oxWNgp2WoDslOqlLb40bsEyCZnBnuhuzFhHsDDx/ug7TBcXJCMuagJQdKv/0Tj2xnxF5F1UM5A7efGa4x7m7TvD1Hr8GRcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwIl8OU1Hs6hSQIdrDER4mSanSXiW7CishbAqn9bM7U=;
 b=oc2XXFvWe0p+ZdQ52RrTN6cdMCBH/YLZkHzMOnnQ+8HxfGxjr9NSdfwqvZ1HcSFMaO8kIj1/VqlC51K9GrPOOIB67vr3IO+vHFuQPWSA9qoddaHq2qDTGjF05slCmZhiZzaM0q4ZK3qU48oYrJwf9U35T4jk7VjR681Ab3LC0df1bm1c1i3pTOFIzcnCW7jG00uE93jKzn8mM/5CILfZrNbPG4vZOXywIGyKEQ0APFynAEkZfRmga5psspAYqMgGroowLAujKyaElS/o/FaXLxG6wVqKvHJWfczhu2tewY0bD15PPL7ogGH3j0bD6hhTb/c3wtU8za8PxXghIpuRBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:02:27 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:27 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 1/5] erofs-utils: lib: pass uniaddr_offset to erofs_rebuild_load_tree
Date: Mon,  2 Mar 2026 15:01:50 -0500
Message-ID: <20260302-merge-fs-v1-1-a7254423447c@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 849578f3-be14-4224-756f-08de7896a063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	hgnXw/J+crP3DR7fSp5T8/wY0y4cCPBcaJv/IGEysHM8LlZu4yEbrnSVuaUMc6pEkpzy+XC8mBJQ/t8cJ0KnasTYUj7y98EmKeObCFNxlBRNF7sMIpCOJWPLJa1GtqFx1B8aSEsuPADg2f1CMJGGuxdDhNw3uq/qZjmoM1KBRlMJsEDqSAJ25xPk75kHFkflo5bkS4Btw1MIpiFXR9Pc3VmCgOw/rFopj/b6DlxUncizaU0XmF2CGQSlV2Qiik1ANkK//SqlW+j18SN+eEm4+7U+SZOaLPltFV0s7L8asRsXs/6LgL1odZAv+q1aIz6dMj5OJiT1kRjk9lzGVGsgNmAmAquj/1odHnTb5VsgFr8Y1CsYoYRMTQFkvCAXhOTnCm1X0prbiLqrrRdx62/nE9734B9HErT2qaf6MiY4+O8ECFzXZaefejlMsLbnPhkiBSrkkZ2ylZglzmCIQK7kC/XTZG0DKG0YOqFN41kRoMOT4wjHuFxdqGmi7D9Nx8OthBbXZh96YTHC2BwtuGxPWvfKhpA0w67cG6eQuZ6aVvSD+lursfYzvTTNL+Zm0lhLk6/+nMM6oaxr8RpUfUQK9vjixDpuLhRc8tGxRq9HeIgF39ijzXFTKrcIniFxRAxuCFdHVZX0RqgEoi/SqrOesPp7nq0c4kVwW7go3R6BFj0Wow9+92alOkrgU+GncVhAyzl9/LLyXMAobdvHlZxnEsiman9MHiEthzudFC+rxS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czEzMnQzdzFadUw3MVVpSmpuSnZ2R3ZOUnc3Wkh1em1lU3pEUEVRb05mQTdj?=
 =?utf-8?B?bm5kUWQyM3lWSW14cTMxNWllYVc5cnh2ZFMzUUg1bVZnSkc5VnN5UktJdkpH?=
 =?utf-8?B?TlV6Z1dxbVVjcU1Qd1QyZmxtM1pxNER6dmRUUm4vRGhuL0lkTDZidmdCZ3dz?=
 =?utf-8?B?RWZ3K0dHcUp2WnRxTkUzWEY5UFFuQVJITkozM2dWbmdDMHpUMTZEdjdaUHc5?=
 =?utf-8?B?anBJbVRMU2NVUnNETVNSS1UxRlFNMXF5NUJudlhjaEdIZGhKSkxWTFRCczlk?=
 =?utf-8?B?VjE5ZnlHaVR3L1lncEVacWp2aFVFSXk2dGxUTjdyc1dkVXhGT3c5MlYrQWQz?=
 =?utf-8?B?aklKT3VCWXRjcU1Ua0plQzVzNzRJcTNyVDZJQWdzT09lMk1RR0VwclZqSkNX?=
 =?utf-8?B?aXh5ejJXcWFpZ3pvVDY1a3Fjb3REQnVmdkJVTFdpOVFsMUtJNmNTd2UwVEVB?=
 =?utf-8?B?dVh0TktrWnJYTVZENFl1RkgwNUo2c3JBTFJ5WGQwUDBRb0hHQnllS1JHSktG?=
 =?utf-8?B?ckpxbytzS2ZFNFJUZ0xYSG1KMFlTaXZ5dkZ0anYwczVMOXZlWlRkR0dSV3Fi?=
 =?utf-8?B?YS82Z2ZLMXVNanUzT1J2VEk2SXEzZ2kvL0d5VldQeVhTaWpNdkZ0MVJ1Q1Fl?=
 =?utf-8?B?d1FqL1ZVKzhZeXVqck9pejc2SzAxWVdzOVFCYTBXcTBxR0hzeDY0Z3JFVURE?=
 =?utf-8?B?VklTUWd2dzFHZDBmRWFFd2s2a1pmNzRLblFlbXhtcVRQR1BZRDd1MGpzMkFu?=
 =?utf-8?B?NVRhRW01cUowTlRhOUxMQnZOS2VLVWdsWEhBQm5VYUp3akQ0MGtDRXloT3Y2?=
 =?utf-8?B?VUhTeHRtVEZvaUlIY0xHb29CR3htTDhid2NHTDFmQXdSQjBNYm02UG94Z1ZL?=
 =?utf-8?B?VUtXZzZpY0ZSNjQvSlFuV2duVHlPNHIvRUtwUzJuNTNRYm5pWDRmQzhpdkt6?=
 =?utf-8?B?YVEvOVJJdDZMc3Q5OVlDQmdjREIrV3JuNklEMm54TzAyM2lYUEZaa20yaW5y?=
 =?utf-8?B?bGQ4Qm1URGd4b1QzT3MwUFJBUmR2TXYvb3d1dnBpc01EZ0ovZ2h3dVZuMXdm?=
 =?utf-8?B?QU56bi9tSmFtSGlTQTVab21HTzltdlRvMHB5OGFiTWdSbGQ3NUQ2UkROQTUv?=
 =?utf-8?B?TXRTWWR1d0FERm91eWgxREtJSXhHNWU1YVRmeGZ1L2FHVm5xTVl1czRQdkxs?=
 =?utf-8?B?bjNRdlNDakRqS2FEdnJoQ2E0cnppbjkxR0xYOHp3RHlEWVRuaEtwb1p4S1gr?=
 =?utf-8?B?V0RGbjBTUTFsbHRRODFsZmNDLzJHbUs2Tzd6V016L1RvS0FNM3FFNi9ybGxC?=
 =?utf-8?B?UEl0cTdpWmZqZDk5V1hqZ3ZTZmdhdTJzVUlDUjBJbDl0OTJXQldia0REZEFL?=
 =?utf-8?B?ZCtkVUc5V21ZV1FqL2J1bzR5YnkyMGt1WTBpN21lT1o0WVV0Z2NTNytTNWpy?=
 =?utf-8?B?cTF1eUdtYldsNFgxVDdIMzFCSmRENU1naG4yZHRQZ2djeUU1SStTTWxjSkY5?=
 =?utf-8?B?NElqL3I1OTVTNHdZS0RNc09uY3NSYUFYb3N3S2x5ZHR1M2d3ZE56Z3dhdWE2?=
 =?utf-8?B?NWNtRGhrbHZkVE5pNGNpeVNYUXdmVXorUEJxWldFeFZIL0lEaHl2dzBtSFZH?=
 =?utf-8?B?aDk0R2V1QVhoUnhnNENFTGhNQTE4VjE5QXBCSks0MVlnR3VZUmkxRkZycVYy?=
 =?utf-8?B?Wnl0eW9mRHhUZWFTcS95ZGcrMXBSUStCcEdzdVRqYmRVTjBCSkdISzFzYUtY?=
 =?utf-8?B?MWIyT0toSHljdk5WRmVoVmh1emF1a0V3elh4WFZ5ZWp6NTF0ZzludEt6UUk2?=
 =?utf-8?B?YzNlWHNZM3FLUnRGVTBmeVRmVjVFV3RVSjNMWk1YVU1uK1RyWkVqd3lwV2xR?=
 =?utf-8?B?S2RIaGJuMVB5ZWxvRkl2UEM3UzdzSkNwMkVTR2MwZy9vVnZobGU4b0RNckZo?=
 =?utf-8?B?elYrWkVtVkJyOVNLeEJUTUg4Y1c5MVI2K1lyNzV6dnlnajc5cjNpU043ckJJ?=
 =?utf-8?B?TjFOdUcwMVAvZGs1enpxV0JlYzNJU21sQlNnR0dwbUxpRVNxd0FZbGNBVW9s?=
 =?utf-8?B?aDMzQVAycU1kbGYzc3l4dVJqS3cxNm5YQjBXQ01pQ3Bac3IxcXF3K0ljQXV5?=
 =?utf-8?B?MHJrUnpEL3lDNkV5NEUwUjZRNzRXOWN2OFppbHFXakVUMjl6SjgzNW5LU3F6?=
 =?utf-8?B?T3pueFZHc2pwbUx0LzMxNWtzM25VYXA4elR4SCtUQzJDSFM3eDVVWUwwaXFv?=
 =?utf-8?B?MnhkNUxseVBYRXF4WmVQK0k5ZWFWZ3RnRDBFYTY0VERkNkFjWktSTDBzKzlj?=
 =?utf-8?B?TEtkRUtpMm1Ma3RleGU3RUc4Sk5EYTZtVDlqOUJUbHFEMVNKcCszUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849578f3-be14-4224-756f-08de7896a063
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:26.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHbFVW+JYo4A5+rUEFYS46lymhkDIlJ6cww2+4+FkvN+Dv9jZ2ofiAKqmQ6ibMQBcCAcQ9nmrInD8k1HrJ07Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 185411DF135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2468-lists,linux-erofs=lfdr.de];
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

uniaddr_offset will be needed for rebuild fulldata mode. Add a parameter
to erofs_rebuild_load_tree and include it in the erofs_rebuild_dir_context
struct as well.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/liberofs_rebuild.h | 3 ++-
 lib/rebuild.c          | 5 ++++-
 mkfs/main.c            | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index 69802fb..d8c4c8a 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -14,7 +14,8 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head);
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
-			    enum erofs_rebuild_datamode mode);
+			    enum erofs_rebuild_datamode mode,
+			    erofs_blk_t uniaddr_offset);
 
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 			       unsigned int *i_nlink);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index f89a17c..7e62bc9 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -286,6 +286,7 @@ struct erofs_rebuild_dir_context {
 			unsigned int *i_nlink;
 		};
 	};
+	erofs_blk_t uniaddr_offset;	/* unified addressing offset for FULL mode */
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
@@ -419,7 +420,8 @@ out:
 }
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
-			    enum erofs_rebuild_datamode mode)
+			     enum erofs_rebuild_datamode mode,
+			     erofs_blk_t uniaddr_offset)
 {
 	struct erofs_inode inode = {};
 	struct erofs_rebuild_dir_context ctx;
@@ -452,6 +454,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		.ctx.cb = erofs_rebuild_dirent_iter,
 		.mergedir = root,
 		.datamode = mode,
+		.uniaddr_offset = uniaddr_offset,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
 	free(inode.i_srcpath);
diff --git a/mkfs/main.c b/mkfs/main.c
index aaf5358..471bce2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1735,7 +1735,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	}
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
-		ret = erofs_rebuild_load_tree(root, src, datamode);
+		ret = erofs_rebuild_load_tree(root, src, datamode, 0);
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);
 			return ret;

-- 
Git-155)

