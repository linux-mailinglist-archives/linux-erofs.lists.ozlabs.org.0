Return-Path: <linux-erofs+bounces-3246-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfeIlm512l0SAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3246-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:36:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1D3CC159
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:36:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs2YK6g4Yz2yfS;
	Fri, 10 Apr 2026 00:36:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775745365;
	cv=pass; b=OM6O1FsF0Fh1GDdLvFFV3W9UwS3qF+N9m2N+NU3ro6FgZPWzjF/0ovSRdFRE5bpeWsL5Ld2AI/4C3SzOgHsqFLV0WhcAPYd/YvdKtP8YrMepi/B9y/0SZg17Sl/x7U75lpAe4a2oiyR6qAhmXSHjTFOg5yfAKGhqiM+e55sy9jPFVW6TanPbid+v0DeJYkbzpS9UQZgLYeZ88kKEYQDISr3Xd7EFALWf3x0sob/f8U3X9Nyk7okE5neClyOyzquRvXQTm9K5bdcavWbjWmGMoVnjcHyZfk1GND7LW1MLJ/tSduipUPtLs39vHDi7/HszVJCddjRD4UTBbRuaX9tBhw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775745365; c=relaxed/relaxed;
	bh=s6VKg82eGZwW7YdI2dW4jsgO/IZhFBPTBb7i49DoRuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=chhgKOJd2B0NobW7qCVweuqz+ij4WtpibNLlAp6Z37Kw1QYMRfSxfKQivADmyAlugqLheUmYVdTE2s8Aswy3+ZQV7fUCm8jgosWkiu918dRse3Q+TA15t+ShVg9qzPuKO505utz6wwmyh/jQgf3ThY6UiHNNKi9XmycnUqC3V3uJ908prz6NZZb27H2xxGG985Ksm5Wr/RDVzAiyIeEi7wJWqOsswRKf8DpxPvfZ6ZEiNNcegrRA11S68cL5hw58pyEoXcIQY4OZ+ELkYjZ85oHbr+i4mVHM+OO9Vu4Pw7wWaWjVq5Pq4C4UTsg2BsOXEPAa4dQ6ReucZIqDiCf0tQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a55wSAzW; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a55wSAzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs2YG3Kplz2yS9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 00:36:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkMcMsReimNMra7YdqLJ9F61wm8hykO/NudvHvDfdRtkSyt0nikcHgdtd0Pd5zqW+pWlhWup/2/XuvmT7eHGcC3o4uAA4l4ru5h9m1qX5VPvI30xkfgetE+D8MksSMdsLD8bseJ06jyNJDfsP9qGCSQT70lxesrTZH67PKUsWD/rQNaPMhviay1awWu8Xk1YbU8nnro4rq6Hphy3lW/tMmWX6ZLhjqG2kWiacKgkWnOW19axkYfeEMHTZgCKZF6L9yGudCfcYZ+lEpytVsalh2CcH8WeF7Us3qKN323hcSMDVm/mA8E0DfS333PwCGR1qSqaa8jHalcSmvU/+tEpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6VKg82eGZwW7YdI2dW4jsgO/IZhFBPTBb7i49DoRuY=;
 b=byVhmx1a+oiibuokXWV8dwHC9mLMhijNphKlL/pIE/WMqmDYOGbhzZ3YGfKAZOvaO9nwAtARzrPx6g/UPO045+hFqj0XGoDApR4B6LsDDB/6E+NOsa4X5/t+Yzkm0P9v/aA8p6bpLXC722MXGbmd66k3G5wDhaPaT1kUtpr5LlCrssjEzzoDQenWZTg2OqB7mvvSO/TadhhjZtjiphq9YmQVnLA8se07CY1/HY19G71s7Ut0zstdSiCrzGyx4wgP2Lm8273i716vvZgNsB7qizj46gAhUnr1Uxlc/eQf3dYyfQRDQX01Tx6UWB86TWxUO8rIa0mqyjTpbZZrCJVqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6VKg82eGZwW7YdI2dW4jsgO/IZhFBPTBb7i49DoRuY=;
 b=a55wSAzWnM0+5naB12hm8Xxcn4+cg7cW6puR05t8JWkFJkbLZ/WWp1BqS2AzbXsGIPlcbjtFxMUlRcfJzZLuoPn7r7N+aDipr6+onTi7htLYHhl7RPLGCg7F6QZ3Z6k6CIpFxUjqQ+hymMw9V1LUJkyENQHHxRGc1q6S2UitxW8XYLnCnWHKrzM5NSICvGQ2/v4XcqZvUmvkCjz1j6IDGXMyc8cb1XW7Al8lyPBOcSCBrmC1z1Vwm6+GEYuQY3aRw4CsUi/+N1BJBjNw28/amV5jEB3ZYds2o2w5jerImti+YT4jhFrWcH5/4cVY/qwYGbR6RQ7loDpE4wen5oktKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:35:33 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:35:33 +0000
Message-ID: <8cf20051-dfa5-4ed3-a52d-6556734830c0@nvidia.com>
Date: Thu, 9 Apr 2026 10:35:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix erofs_sys_lsetxattr() returning positive
 errno
To: Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260407092141.11697-1-zhanxusheng@xiaomi.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <20260407092141.11697-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6bcbce-599e-4062-5a61-08de964541c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d3ggF0JESG0VMhaYQ3GcRlXK6I8gRCcKJZQMXoTL/vArMiSPFvKQfJy/CHYAzkvMl+tBeMAdq8X2HfugrjjHapYaf7fcWP5tXDlvjd1jxA/7K/8kbZLOPWD8JbV2l+m5fVbnvzxkY/Wk/2WiddmnLlFL9OjoxnZkwWIKAHR2AQGqbctm8T1AMTbM6NljLFGPnjFzFc6WQk2MW/rDMbq1DLzStlyfz3xkJYOhUzGE4L4k+EGjmueOr1IOI5rP6asvk6gnvtPhOV3k2cPwJCh6Y5fdJRl+m10plbidDEXVX9K2W+Fxc/jRK34Xs0Hj5rjrfICExE/8IhMSvy+vxSlaOG+ENVtPB/5sZT8lUMkIGTJntqydQT63c/NXYszI6aMNu6GpCfB2B+DqqC8cgJDzZm+3IoaBxohZqPFLi54DKGhM6D/BU/cO7rJcemMVPJp4oZt1+cYblCCowKjBKgP7TPtpkUoWW4I/qdODV99mjDdiW4poY8J1A+adWzOAxP8QiNA04+aZh2yyNR0T4MGxJqj4/dPBNYXtIsLQoybO7ZcMKgO5yuyhnYSZR0UUhzu/puTLT+tMdrmHcyh3ldg8qpS//tc53lpxdp/br2TKNskM5PQrw+QPmnyXd73Vv0iB+yGVgkYGtwBAzpipBkwP4siAIeSpSBJcs1kHZu6o5d7uewUwdYCaw8S0wq0S133B1xHMFTlUafoMdblGNC4WQvAxONewXgqbZhmtyL9lVxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhGK2ZOTlRLMmhra0pmYVYveGZxamFlT2dPZ2tBRkRLOGJCS1Z1Y0JmN3FV?=
 =?utf-8?B?VEMzeWloNFQ5a0dGUkFRbkhCaW4zbVY1dWxacTBOaDVmRHFHSU9kU2c1Sy9X?=
 =?utf-8?B?TDRpcjJJT0d3NHYwejRrcFBmQSttYitiOFJLMTdyR1dFM3I0aGxtSXhTOURS?=
 =?utf-8?B?ckM3L0JUYTZMNTRIaXptQlFhWTJaY2YrWHVFcTJtQytzRTdxMEFHcVVzbUMw?=
 =?utf-8?B?VzhIbXIxU1haaEpqNENiakZ1NFY3aWVHNG9seW4zVzRqSDhUMTk1QlpYMUFa?=
 =?utf-8?B?c21CcFhFRzZEejFJL01Wc2N4ck5jSE4xUDBIOWxDckJZRGdEbkEyMDJpMDFD?=
 =?utf-8?B?Sjk0R082MGZSU2JSTEI1S0xWQ0lPMVN6dW1Cc3Z5ZkpzM1Rpb0RNb1dodFAx?=
 =?utf-8?B?RW11a1F0Ui9vb0xLU0VpTXY2eHpXcVJRaHlnNjZFVVFObEp2c1dSMXZTVG56?=
 =?utf-8?B?aVp3T2RyWVRicWRMeGg5RkNYRjlyWWROVVB3dFFzZDlGRTdNZ0k3L2RHSlNM?=
 =?utf-8?B?RVJKR3huUzJQMDk4TzREdldINml1VUpha1Nlb0M1Um5pc3NndnluU2RIblF6?=
 =?utf-8?B?WWlnWitSdzJxeC8rSkY5Q2xFZTlWNXFWMlU5REJ3OElOWmJGcTVKWjdzd1l0?=
 =?utf-8?B?Rm1RQVRTMEQzYU40YTlKQmlodHhTdTEwVWgyaytGZndqMnZQbVpzYmk3ZDBs?=
 =?utf-8?B?bzFkeDNyQVh0bHhIekhCazk4OVU4RFBHWnhmT2lGdjRxSG5HSXcyZFdRR3Mr?=
 =?utf-8?B?OWVEWk1DZ2JrRDU3SHVUU1MzT0kwamJxekxWcytoeXhvcUVkNHZkSnRGK0kx?=
 =?utf-8?B?ekdSb2l0Wnd4WVB6N3BST0pUK1R2ZmN6UFhkR2dtTVNyeVMrd0tJaTJCK0Ix?=
 =?utf-8?B?a2FOSDl0ZldjRHhUL0lVWVZGT04rQTNmZHpCQy9ndWM4Mi8vWU92S1FoTGtm?=
 =?utf-8?B?Q3BzcFdETTd5cDlteVNqU2N0UUk2VStBcWIvY2h6RVVKZGRmZSs1OVl0RDd2?=
 =?utf-8?B?M3hwNndNSVpSQS9TaVN3SnFRQkROV2lZNXo2YWkyaFg2enc0Zms4TkJQQTlP?=
 =?utf-8?B?Mkt0VGlzUERlaDQ2NWovdWNsSTdmczBBZ1NLZDU4MElZczM0V290amwySUZy?=
 =?utf-8?B?MjU2Qi9kV2M1MUVaN2RadldOaGlXYmc3Mm9VN2pSTkc0NFlLSWx6VHdrT3RR?=
 =?utf-8?B?S2t2bCt3aDRyY2lrSHMwWjNBQUZoTDMzMXo1SDRicTM5UXM0dUxHL0Z1UGRp?=
 =?utf-8?B?L2QycmxDbnBDMWVLY2U3Z2loWEdTK1oxK3FJSUVXMFRXbUw5YzRaa2xiZm9y?=
 =?utf-8?B?TFRWUDJCb2dZUysyajFVRE1wZWlHcFh6Mkd6NitvYW42d0cxS0hmbHBSL3dm?=
 =?utf-8?B?NlN0N29mQ0pFWW4rbi9aMnVtSDlLRlN3VVBUNkI4azVjVnpaR29rNlh3eW9x?=
 =?utf-8?B?QTR4Qm1hSWQ1Q0hCZG9qd205dHI1QURPcEpKRmJXUWlXN3RsamJMNHhpVkIx?=
 =?utf-8?B?cWhEUkpuSlh4U3JjUFV5N0o0Wk1aNG5OZThEamhPdHNHdXlLTkZRSTByU1Nx?=
 =?utf-8?B?UEkwaERGNUNJanFyVHVEWDcvRWlvb1NYYlduUHN6TVBuK1JjdEFUczN5NnBv?=
 =?utf-8?B?TGwrQ29EM0FoY01JTFFFUFJ4MkMrOGRXWGVNZ3VwTTVKU0FLaEF2UHdCTzBJ?=
 =?utf-8?B?VzQrbUdDSllvSy9YNUl6M0dZbUVFZnVTVUhyaDdjcWxQbytLb0F2QXNweitu?=
 =?utf-8?B?Zm0vVlJrdDFFa3RNRGpMZ3krOXJrRHRwRWRXaXJ0Y0FyTDVyNkhlSnpKVFQ5?=
 =?utf-8?B?YzRKdHFaSklLYXc5UnZBWHBMQ0k0NVRDL0ZnQ2JDTGZPMTRhY094UUhwZVU4?=
 =?utf-8?B?NDQ5N2hEdVI3ei93WUc1OG1ZTUxXcFVWZ2xlU2FMZmpubU5QS1dZM2E3ZWxo?=
 =?utf-8?B?YnpHZHp2emJqWHEyQm90ZDZ1Z2luRjlKYWlZYlFnZ3VTSWVhcWVlQ2JDb0o2?=
 =?utf-8?B?QVhSbDhMRStWTmcrK1NkM2lqbDN5UTcxdW0xbXBHYlVqN21mOG5hLzJPVDNZ?=
 =?utf-8?B?VDFsRUNBbWtxRkJpYUhGSmFheGlTbm51UXg5MURlN3VWUmE3YXFtdGpiWXQv?=
 =?utf-8?B?dFRUSDNDM3MwT1RFTWZNVGVoMGRFL3Q5d3Z2bGRyc2s0RnN5MmVYWUF1bjA1?=
 =?utf-8?B?TXhBazlOUzFvYTJmdyszTkpvelBBckR6VURGUGpKT2V4dDc0M3ByWWpWeEVK?=
 =?utf-8?B?bHNmOFpMOXdibmxyUmdLME4velhzKzMxalVVb0pSdlZhOEowZ2tQdVV1OGdL?=
 =?utf-8?B?WU1LZkRNWUkvWDAra0V5cFlmTERVRmczV09EdGpOSEgzSlFEQ3AxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6bcbce-599e-4062-5a61-08de964541c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:35:33.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHNBOQ+2bhTSXYCnQsJod8l+3Iw0ucNruOh5wh4MAZerTxQ8JB8SqQsFtFMB2DZPOJqVWG/aOf1r1ff0ykMCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3246-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,xiaomi.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: ABC1D3CC159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-07 5:21 a.m., Zhan Xusheng wrote:
> erofs_sys_lsetxattr() returns bare `errno` (a positive value) on
> failure, unlike its sibling erofs_sys_lgetxattr() which correctly
> returns `-errno`.
> 
> Fix by returning -errno, consistent with erofs_sys_lgetxattr().
> 
> Fixes: e0d85fc5a282 ("erofs-utils: lib: introduce erofs_sys_lsetxattr()")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  lib/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 565070a..af1b9ca 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -123,7 +123,7 @@ ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
>  	errno = ENODATA;
>  #endif
>  	if (ret < 0)
> -		return errno;
> +		return -errno;
>  	return ret;
>  }
>  
For consistency with erofs_sys_lgetxattr():
-		return errno;
+		ret = -errno;

Regards,
Lucas

