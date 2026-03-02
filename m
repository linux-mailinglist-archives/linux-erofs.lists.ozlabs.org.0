Return-Path: <linux-erofs+bounces-2463-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCslAGivpWleEQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2463-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:40:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B611DC016
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:40:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPjmz3hnQz3blr;
	Tue, 03 Mar 2026 02:40:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772466019;
	cv=pass; b=NtxX6pkAvx1t9PeZ6itBoi99FtqbMZ512khV5MfQAZTRo+fdxnyhjhnLoYpGyJvAUDC8Q8mVgKNB+TqWP+bdg/xXc7FTya4NThfvzQeifcSG3ZiR+oHtwIDb5C+eLx2X5c1YtZ8oDx4AQZZtEf1FYFCuf3IysZ/cR/9ReS8M7ZxH3ASr79xwsAKgfWZblRgAFJkx/94OWoZbrahpHFX1B65HQa6oPPZeS6I4wTtg8Ohp8FDX2ZcC2sJWC3zdFyPC7nqptOnfrfvuRwIuUZ1aUNRqCs8vy1A4mTR8NB/AP9VqwCXcuk3kwZFbTtN04d2Zw6ajSqQfnbx3NYFAU6MMsw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772466019; c=relaxed/relaxed;
	bh=1A/vZQlOAel9AxCxb7nqMYLH1eqzGqZPm14G/p5ixPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHRlfv0oBBSSeLwqPdJXv+hiTVjeocYv4ZgUrbsVvl0AmLuEDyiDTUgOmoXIImX8GEO0Fef5vD3/AVrVCgDX29U/hEiOy7A8ruFYStLrXXd+DJQRP+torVPFPfEguE4toNhr8maII5WfYMR4Ly7Qw4M4kxRp4UFELN+Ad23xKeDAspuPyd6grgpHU5QbZHhfv75O0F/Q+IROciFu8MJQ0P46HBqAHT+xwJqNOZGKom/OoEBZngtWwrjyZhF+AE+caa9JhtGeDGbK4amTBOQc/b8DUeTTzQGOZOL2OfOeSbrEjMznr6L9CH6c0VxA6SwQRxUAFpdzJ5YBgwbegaZa2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hT9xHeEk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hT9xHeEk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPjmy2Rdfz3bkL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 02:40:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4Fis2yNRM12aneOjs5XjM6kfbz8fZ/sHoX/59pKq0UZj2kkiG7rWRIGMa7p6NIuCCH1S9QhYUZ1DIUs+To5tiXubK8w3MZ1eWA7qLq93dwwPmzdOVuYXeKD9hPag+7LwvnHWeQlyoj1BtGwS5wigDh84xfStS0UhdEsded0ECbYoa993fe0Hqel6FtweQonylOLFevBaFMa0oS8hU3GWBKFJNcQ+mKuANJq/nlxgUm05MJyZfZWZEHF6rkys5xrDIkVUbiweO2BCf3Fcn3PCFF2nK2pQJ8hnoq/NIeIgZoex4ej5bv+08QMgUVELsjzuk2hP20FWelEqrHjaMdLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A/vZQlOAel9AxCxb7nqMYLH1eqzGqZPm14G/p5ixPQ=;
 b=xEpZF+41GJIfyZ5vYuwt95bY/37g/bMku1vuArxHsPl9Xa7TlJoD1sznfL/CXBjh9SwctMubGxbY+aPHHW3hAcCyxpoHBbaWEHPGw1s9UmeFPv6RXkHsTwlePYKjrniW943fbjsYv68ZCnhxZJ9QzRBaT7vaKdzOlVhhlENg5SOPzboAp1/QoUhT5azh3L+unPMfu3BvhAwHdjqnzbbAT/HjQelPLiiVWr7qkbyRKRkfWpWlmG8wG/dk1BTgxPACqZcuHyOZjEAAs8jFIYW7SFfQ0W9yovpXiqf5bAn0jr9sEJ2L/LRfgMHSce5m9D1GBzLeh3UQYBNA6ixvep7Lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A/vZQlOAel9AxCxb7nqMYLH1eqzGqZPm14G/p5ixPQ=;
 b=hT9xHeEkD158e6TbRXYobbgToTGWiG/qWxJNchJ712xPev2yirMVraHUZJU+axB9smNKGBQp+9lcocedT8T8gEPaI/2R9e2jeGFKFLZrORjNdS8MPo0P6OpkUoE/lhH/H9t3pmbw0O+sbHvU3oCXp3QgeAm7tNehIhR75BbG/0kTKb8IK7SKEVM388SoamN9yVGLGjq+fn5n5pD1WNSfu3NydIqnQhVH/boxQfUF4d1ZTY5U/8c6yNyDxZ/a8Xp6WugEW36nDPlKYQgHkwfOgkOUHnJrdqAeUKopJQ2b08ex4co5scR3MDq9dpzer5xK+S4HQPq95gQIlRXhr0T2aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 15:39:47 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 15:39:47 +0000
Message-ID: <2ac49ff4-7177-435d-8b0a-837dd8705b4b@nvidia.com>
Date: Mon, 2 Mar 2026 10:39:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: Gao Xiang <hsiangkao@linux.alibaba.com>, lishixian
 <lishixian8@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: qinbinjuan@huawei.com, caihaomin@huawei.com, caihe@huawei.com,
 wayne.ma@huawei.com, zhukeqian1@huawei.com, jingrui@huawei.com,
 zhaoyifan28@huawei.com
References: <20260302130356.769479-1-lishixian8@huawei.com>
 <f9c910ae-a713-4c85-80bf-e79ca6386f83@nvidia.com>
 <f1d6133d-e1e2-44a4-9a58-01a917c6e114@linux.alibaba.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <f1d6133d-e1e2-44a4-9a58-01a917c6e114@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: b0944ca1-aba8-4dc2-b075-08de7871ef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	4c1g/pv5g99DDXFsCnGFpQ5chWeXE4VGBMgWrt/nJ68AwAzazwv86L9Bs9FnTu2c7xN9FRF82sQgY1qDg5rMIv2dYRHR4eC1ewE+HAmyLjvqhFIr4wXfVNXlZ5ysQkfVjzuZUImzW8eGMuaGS0Vy9X4ILM/I2wowJPexASkRYaMWSuSbS+JBZIHfm/JOyyUBZASb4X6dwRp47dXw6uvZdK+sX3DVslrpPyfoluEyclnvyMYPYV+st4wZv+kdP84AkLP+3DPWWAuNIWFxc+B92rqwE1sIuX/4z5hdRy7L2lvsNfXZO4HhhbannwZBA7nEK3UJPuJ634tgBDsDdRZ2j6DXChLNm7GZujlRWTkbjsc2kdK1QOCj7aiGpds882iv2hrDGIuXkZRYbNJR72QkTY1N58mv+VGknVhXIxr3dhel6Bz+Cg1pQB4JBCKhzVPEjykLr3Yv/UD/hWKvnnm9gFMQJYsB8XNZtezhjY9cadKirnSBOeAAVktHe2DpwxX7Z+vDW+d6hmR0cLb5RAi7N6coQdcJCZTwaiEIQbegTv8Fy93fTbRfqfLe8fQyHtIwafrHPngt5DE+wV/4n6WSaYfx3ILTvJvwCq94Al6vFY6AyxekvC3EVGgRUqNzwRzTj9rf7mb+gIGMgwv+teu55p2DKZkE0gwqNL/Htd1u4cjZcwitvXWC3TfY8HCATvMgDzidWMFutSUqQA91g/NLd0HM9RZplSNtJ3Ww/X83Uaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2NYU0pjbDFBRnJXUkhJVDFXUmdsbkU0SHRlMWoxV0NuQ1hnNldQN0cvM2ND?=
 =?utf-8?B?ejhObVdIeVp3RHptaU1MMzRJdkFFclhZK0VjTE04QzhUblRjQXdxWkRNRjIw?=
 =?utf-8?B?dVloRXJGZC9CK2FIMnNpdVVPcTlPUjdZNy8yRzhFeHF6NWd3N1VtNGVTZTFi?=
 =?utf-8?B?c1I1NlV3eUs4MWVYbnZIMkR1eXdWbVhxb0Foc05UOWdLb256Yk52S2JFL1BY?=
 =?utf-8?B?MHVWd3BmQnhkR3czb1dBQjZQR1lhbWxFOTdjSFAzV0lSWjBZQktKYTY2VUxR?=
 =?utf-8?B?czFHNW9HU3gwdUdINHFqT1V2ZTh4Q0lnVVZwRWhyNkNjVmxESThmNlB2OERG?=
 =?utf-8?B?UUhPOXEwU0hRcU1LUTN3bE5PZnYrODFPd2Q3UndlSzg4ZzNrdFB2VDgwT2ZC?=
 =?utf-8?B?QkVhcXYveEpNQ1Fuby8rVGNLb2pKUExHSTVjZ0NXa1NJci9Hay9JeUtkOXZo?=
 =?utf-8?B?SVl0aTdBMi9xRTA1S3BxQTE4Vzk5MXhHUnlWQ1l2aFFSaVJ2d2t5Z2J0dmZP?=
 =?utf-8?B?ZHBKSUh1c2kvVm80NVE0d2RzVmRGRzFucFJWQzU4QjVvbG4vQm53MWhibVBD?=
 =?utf-8?B?S1RVdk1RblpjMElJQndBVDdQYXZ2RVhkQll0cTk3M3R4Uy9zSktoZXF0OFB6?=
 =?utf-8?B?RVUrRlFRUlZRbUJEd3FhUjJWb0pDV0gyWlFjTXNCL2JjaS9wcmhqSDQyVG1q?=
 =?utf-8?B?aGVNS3RJSG5CMHBwMUNFZG1Zb0hib3pmTEgzNjFFTHBoekh3MnpKazR5elhX?=
 =?utf-8?B?SVkxNjFlSW9xY044QmlCVHVmdytZeVYzc21lazQydm8ra3RwNkl0amlHckt5?=
 =?utf-8?B?cVF3K2lpUE9tSTdKS0ltSDBOYW5yaitTZjJwMUJ3eHRGNWE4bm9RMlBxWnlM?=
 =?utf-8?B?eUlNUlJoSzVoUHFQUm5PZzdPQ3ltTHZvTHh4Ym5TK0dQQmxneUp0MFpWWUtR?=
 =?utf-8?B?cUgrUG5mWWpqQTdFcnp2d01PR1VZcDl6dzhQU2tyYm5jVkV1ODBjcVg0SS94?=
 =?utf-8?B?VmtpYzk0Q2s3ZjI2a2Q5NmdKbXBTWFV3OE8ybmJUTDFCb2UvQXQrUXc4c1F0?=
 =?utf-8?B?eXdUNXpxL3RSWnliUTNGRy92eDZyVTRWb0xtR2NVQk9aSEVMNGlBWjV4Wi8z?=
 =?utf-8?B?dGI2M3FpT2lJNFN5V3RZcHU0dTdGQlgvZ0F0NURmVkkxU2g0RmhVM054b3Fr?=
 =?utf-8?B?L2VtYmM1RDhXNFBocThGTG10M20vbkRyc1JCa3RyMUU2TWs0b3g2bUIwM2tT?=
 =?utf-8?B?eGFsb3kyb2tDT3JlQW1zNVIyeWNDZjNIZnI0VkNTdGEvU1VFdGlrUWN3aUFH?=
 =?utf-8?B?ZWNCWDcwTDM3eWxaK0Jmb2FkWTZMNmtjeVg2dGVmZmgrMWw5bTlhQVIwdWxB?=
 =?utf-8?B?SDk3cHFYY3pjSG5nclFoUFovelZrdXhKOUVyTUk5eDZscENKY3l3YzZIVi9B?=
 =?utf-8?B?cXFkbERUS0xpZjRsQm5sWFJmdlhacVZtMGVxdjZFUm9lMEJZL1lPQ2h1b2FY?=
 =?utf-8?B?alY0WkxSMXNVeThmVUV0ZmRiK0t5NkdaQytHWElNSEd4NXJILzhjUmUxb1Z3?=
 =?utf-8?B?NFlhdkRZY3ptYlozVVg5ejhBbm0zRUFVaGxSNEMyZWcyTjBVQ2t1cC82VDNT?=
 =?utf-8?B?dGNheHMyWS9wN05JbWJGcUdyZTNHTHM0ZnN3ZmlPZ3R4ZVhrOUZraDZqdmZ4?=
 =?utf-8?B?WDJVZlZRNnBTZGFGSWw5SWZhZ0NxMkRQSjhJTTZtaFhXVHFMR1huZnUvOVAr?=
 =?utf-8?B?eHRhVmNjQ2VXeW1iNE1jaDBxV1U4bGdGRmJEV01iaFQ4MFE0UVUyUVFIYWpz?=
 =?utf-8?B?T1dnL1haRjRraGhhY2c1ZW05RmNjdHovVW5TQWt0Q1dsMVBXeWtacnVHbVph?=
 =?utf-8?B?cDVIVCtTUlA1ZHNHVm5KTUd3TFNCMk1MYzFobmpybUhtK1liU05oSWIvMVVp?=
 =?utf-8?B?NW8xWVY0RmF5SEwrOVFhS0p3cmh5NjdZRHhKVlN0cXBVblIyNmMwcHF6dE1C?=
 =?utf-8?B?SXpQZzJLNHhQZVBHQ2FtSWV5TFBzMlR1aWRMUmU4OHpsRHN4QURJNEtJSC9h?=
 =?utf-8?B?S1BhL1lKbzJwcjNQRWdianNwSlBlb2xMcHBTeFhZN0I5WFlUUDNkeTh5Mmlm?=
 =?utf-8?B?aHdYNGpvUTRCelRPejd4RVhkcEd3OE1Oa0dneHJkRHRkWDZZQ3lnNG9lTWxi?=
 =?utf-8?B?R3c4NVhXTXk4VmI2d2Uva2gxNmIxQXZIMEo2WEZRZGhmejR5MWlaKy9HdFdB?=
 =?utf-8?B?RGJqZHZVMjdieDlGQWtjMENIMlBiV09yRU1RZVRVbU9FbGs3NkZLVVorM01H?=
 =?utf-8?B?VlI1TkxJVmxTeWFwM1JoNzFtSCtTaS9HSGlQN2dXNGxrNTdBQVZpZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0944ca1-aba8-4dc2-b075-08de7871ef0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:39:47.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzNdIjLFsc5WQ5Qly3gOKeIA0Ysd8gV9qe9QVOlcMGDI4Uir1B7IesowCTnh8Q8pi0mZ8YBpqWBJ1mXu7m+tFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 52B611DC016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2463-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:lishixian8@huawei.com,m:linux-erofs@lists.ozlabs.org,m:qinbinjuan@huawei.com,m:caihaomin@huawei.com,m:caihe@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,inode.sbi:url,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

On 2026-03-02 10:28 a.m., Gao Xiang wrote:
> Hi Lucas,
> 
> On 2026/3/2 23:22, Lucas Karpinski wrote:
>> On 2026-03-02 8:03 a.m., lishixian wrote:
>>> When rebuilding from source EROFS images, erofs_read_xattrs_from_disk()
>>> is called for inodes that have xattr. At that point inode->sbi points to
>>> the source image's sbi, which is opened read-only and never gets
>>> erofs_xattr_init(), so sbi->xamgr is NULL. get_xattritem(sbi) then
>>> dereferences xamgr and crashes with SIGSEGV.
>>>
>>> Fix by using the build target's xamgr when initializing src's sbi.
>>>
>>> Reported-by: Yixiao Chen <489679970@qq.com>
>>> Fixes: https://github.com/erofs/erofs-utils/issues/42
>>> Signed-off-by: lishixian <lishixian8@huawei.com>
>>> Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>> ---
>>>   lib/rebuild.c | 1 +
>>>   mkfs/main.c   | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/lib/rebuild.c b/lib/rebuild.c
>>> index f89a17c..f1e79c1 100644
>>> --- a/lib/rebuild.c
>>> +++ b/lib/rebuild.c
>>> @@ -437,6 +437,7 @@ int erofs_rebuild_load_tree(struct erofs_inode
>>> *root, struct erofs_sb_info *sbi,
>>>           erofs_err("failed to read superblock of %s", fsid);
>>>           return ret;
>>>       }
>>> +    sbi->xamgr = g_sbi.xamgr;
>>>         inode.nid = sbi->root_nid;
>>>       inode.sbi = sbi;
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index b84d1b4..cb0f0cc 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -1011,6 +1011,7 @@ static void erofs_rebuild_cleanup(void)
>>>         list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
>>>           list_del(&src->list);
>>> +        src->xamgr = NULL; /* borrowed from g_sbi, do not free */
>>>           erofs_put_super(src);
>>>           erofs_dev_close(src);
>>>           free(src);
>>
>> I was similarly looking at this issue in my patchset so I can confirm it
>> fixes the seg fault.
>>
>> Tested-by: Lucas Karpinski <lkarpinski@nvidia.com>
> 
> Thanks for this, but as I said to lishixian we shouldn't use
> global g_sbi in the liberofs anymore.
> 
> Could we try to assign sbi->xamgr in the caller instead?
> 
> And
> 
>> in my patchset
> 
> Do you have more urgent fixes? I'm about to release
> erofs-utils 1.9.1 since there are some urgent fixes
> so fixes would be better to be sent out now.
> 
> Also I think we should have a basic testcase to cover
> this, I will try to add one this week.
> 
> Thanks,
> Gao Xiang
> 
Sorry, responded at the same time and didn't get to see your message first.

The rest of my changes are for a new feature implementation, so nothing
urgent in that regard.

