Return-Path: <linux-erofs+bounces-2834-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLHmAR+2umlWawIAu9opvQ
	(envelope-from <linux-erofs+bounces-2834-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 15:26:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A92BD115
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 15:26:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWNW3q4Vz2yjV;
	Thu, 19 Mar 2026 01:26:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773843995;
	cv=pass; b=lyFvFriIJUI8OSQiXkTKAkKhYsMWlZCKcNhpWHCMFG6sAZ7QGvK2T2ThgzhbYOviP4ejk7nHbsvnTgXuMw0ww1fUaVhm97To8dSH2HTpnVHDEOpZGn0MQOGBlnoGo2JgsUIAP6MIGl7M+ChX1S6ts9vH5jEptKnRZk+nZfxACE0AA0IVTDqX3H8WevXFZTBwHu47zuV9M05UtC1RsPv8lAUeecoaTx1ermNF+Zol4GnCl3pDH4A0l4ZQhi8kcdVXOqB0uZLvAatNC+e3qUUWJbZip45hBTeFFYXqrqIQhFssc2oom8nN71+uBhmrG198vE2g2oEKqXRkIj/PxrlMVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773843995; c=relaxed/relaxed;
	bh=E4X7B95YNjPxmo5YiMHVd8uhje/JLs6/6NU+A9IPfNo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibFnjQ77aLQpxPaCUeahK+RsWuekBylv0YxdwytdAWmWT+i9VovOlu+eGW4lGHLlE/s9KMAYyCKO7UJ32CgetXWEM9Vl2YopuJvDlhPP3VyB7HaFkVfMllSspaOAbD1+jLuyDcDi20ouYC7ruXdljc03GWs4CSn0uk7oyJicTZlUGSbnSNppjXL4oZVmBBRYjexf/QBW9iKqa6UldfL9y0TvZBXNy6B2awnWxc7LwpwTriOr72XjgWJY+k6ZW0d7iHPT8ZuLaKvIaNpbTHPXA9YIQtVUCsuWI27TccQ6iTBiT+ahkqQtU61H52/xvMI4G0pp0HmI1Oote5FEuChVPQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QU+lpGDM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QU+lpGDM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWNV44bDz2ygd
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 01:26:34 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4UjSf419FP6k6VbblKyCYLjC4j4fzNYGczz1J9l1xmN9MRFZ0V1kQh4N61U8CZVqCiWY233cpGjraP/lbaZLIeLdGPcg6op8vx6ZgSnf9S0AJkDMcA2rrdu46zsKRh+95ZxZM+xcnycFMeMDJ5Tz50Sk+GlmvjFEauUHy1/pYXNZtZx8u8FSzFSz23HPJY5lDfNugcWTh9U/YgtNeCRwKg4dFgq8lx9eU2pOBStd7MzbmfLUotxiEkTPwA4uH6bgs5/z/XQA3eztQiGJDS5ej7fw6UYD18fdGEHkLPniNz+6uRm/7+vJR7gl2kzDUlU8OL7XOyyYV620k6CRtUtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4X7B95YNjPxmo5YiMHVd8uhje/JLs6/6NU+A9IPfNo=;
 b=Ut1xnEizCsfj3j8WW72Dz5CC95PCPdJQhb/DK1qAPDfYtl4+GaUNE9p2UrYHVPpyh6JDthCc6ljb13uhm45bvhO2QzAay7QhKxAoe5EvwtVd66bkIRWGNFWC1tbKjNdDedYway+x22Ddtg0RUimLlYziqLcLe88rfHS2hzLrFqen/BcdHtukMsoA1rbnF1Sd6lR0+iM/ksqAGhaXfxMaE1VXqoDalD5pnQLgKiNQdXbvDz5E2h+IEwJDFdXlOQgqz+aFacrAIrEyIuIbajy6lHSkZv8WPNZusNppoc+VSweuE5/q6w4KQtK4wQ2t7YJxmXqop0aZC0P6MEXK0dGjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4X7B95YNjPxmo5YiMHVd8uhje/JLs6/6NU+A9IPfNo=;
 b=QU+lpGDMFbafZSgxQtG/LlJl/jDxxMHqPbU/6jLBv6PNRO7dXWi4bTH2/+KnymXjOvlRMsd3tNwRNOiAly7nbx3KXSAwiOAtKnmmRiu8JSFF3a/PD3cv8+G4V4Me0o2L3f2lkpkCmsrYSv+eWwwVBCPWnKXWIoJMvzoQlndjoDSg4pNsCtTFfaWVlPEt/3pvlmJkpsfvuwsWi/YRu87m3FLJsGWlQqRW2iOwiCO/GTtbcQhW1WXKAu5sOcNYdJucGu1xIG78nJy5UD6mHhx9bv32fvMlvvw4niF5+QwxR1cUQddNTIL2QwyTMVxkTlIJf0x0KFvR+3zEkCy4Bl0Mgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:26:11 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 14:26:10 +0000
Message-ID: <6f2045fe-9ed2-462f-8a95-54575e75311e@nvidia.com>
Date: Wed, 18 Mar 2026 10:26:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix potential NULL pointer
 dereference in docker_config.c
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: lasyaprathipati@gmail.com, linux-erofs@lists.ozlabs.org,
 gaoxiang25@kernel.org
References: <20260316085300.19229-1-lasyaprathipati@gmail.com>
 <1b7a6e1c-e1f2-48cb-a947-7f5c7f949cea@nvidia.com>
Content-Language: en-CA
In-Reply-To: <1b7a6e1c-e1f2-48cb-a947-7f5c7f949cea@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:806:6e::6) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d8f033-9f8e-4aad-a026-08de84fa4d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	zkv+/MUZl5WtGREW4re/qCcRLzwYxr8Kl4BseUPH11vxAToL1WGIOK/7Zk6gnrhM9ts22xCy3TkySIrZVVs3N61wEelzqvOBuABVFp9Yt/dKsTiRkNiLNdaBCDdKLYqg3ascUiQclQ581+wakwFYoTTastdBUfZR/+vvqY84Y0/khUOKy5/76joEqDmG2Y2bqN8iDaRZvuLwFn/MsqApEFRmqnzlx7gw8RTtYzaFJ3n1w0Cn4U/ARx17KjBqFIF1wc1k0uIGjUztMZXqeC0cxaKZ73m/UwZ65eYnAtveA2MtDAp0URaNapMLypg8NA7URLVgGQnfvLcz9tSpDIdZicdCqAnWoEaKF02Hf3f09uPHEmHihXGMTxwa7BapFFdRmAsakvO7Akb87GJ2B2DBVjnxi3z9ptiOJexFJhOYKdyiTNFqvL4JLRvUoRnsJoeUN0XBBxdBa7FWcwr3GoBzmn6jIIfyTbxpfQGK06mD2h9rqtFiuBVDJabeq8jkTJbr8XDu3GRHueHRs55wXhEOPdumO17B2h67cnuUty1D1waUhIsVf66VTaqVw/ZS2Tef+SXAmxpVxG1IVpHEyHTj5XCsY974miHmBvVY0XKYOZJ21MWhPiUzQhHfKcuAPdu9IWotW81x6Sj1oBuNjqk7R+z44srJYMtrT1ODv1PVkkd9xY1njC6nd2RuuHW9IgIUrShs/Hs3xRohRyir3OlmwfiVS70/JdfEe/N3DaSbrmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZiY1BCZFpZYzNtNzB4aExmVmxxTEZBVG41cFh6R1BZWDZZcGlSTHk2RHJz?=
 =?utf-8?B?SjVhNlh3Vzk3bFJxc2w5dmRBdHZqR2M2Y1VORW03SGcrZXlpVXd0SUpLdHRX?=
 =?utf-8?B?WEZUTjh4TzMwRUdHVTlwZGJXMTYvVlRRN0xvSUNZZVhQYWEvNzAwVnpZdmFn?=
 =?utf-8?B?M0pNTHl0LzhlMDNsUFN3TUp0akZsNWJaY2dqOFVlamRTWUZ4YUc1Qzh6M0Rl?=
 =?utf-8?B?Y05BekYreU5kbDRCenlRemNqb2ZyV0tkSXpxR211K3FVcTZHb0JOYnpONUlC?=
 =?utf-8?B?eEd6UVhCWXZKUnVFbmFNNGJVd29yV0lWU3dpbmgrTTJpS1J6MWMwdjYxNmpU?=
 =?utf-8?B?aWNRQ3l5SHJ4MnFsNXNXdTArNW5Cc2ZKY3RHdWIvTVRWQnhpODlDMWFXQmho?=
 =?utf-8?B?Y0RDNWp3alpwL0N5cUhPdGZ0MWRWNW94dTUzd2J5RFJUZGtoTXRkK0ZSVFN0?=
 =?utf-8?B?S0UvblFCV1VyUXNYa2U0ZGFZRHp3RHJyZkZuRWV0SnFMN2dzTDAyM0EyV2M4?=
 =?utf-8?B?cWt1SXdGeW5GL2RIQjVZYWJRaG41THoxUkh2SkdrUU9QV3Uxd1ExaEd6c2dP?=
 =?utf-8?B?NitkcUEza2lMMVpPaUlqbXFJTlkrVkRLVkYzaUtYVkxwcHdEQ3ZGUm9xNS8w?=
 =?utf-8?B?bklGWFd1SzhRSDhyZGNPYi95QWdYV3krWHoyeXk4ckJGbHRlcHJhcW9DOUp1?=
 =?utf-8?B?RngrZndTbkl3NHZtM3VibkZYVTU3VjVyR2JDZ3M5TmMzR1BZY2s2SERqS05K?=
 =?utf-8?B?cUdnWTY5bys2Nm5hUXR3UDNya3hSVHlEelpOL3J3cm9iUC9PWHhlUFlHOEpB?=
 =?utf-8?B?Z0ozbnkvR2c4cElQRCt4emovUnFxZXU4WXNkN0V5SFpUZGxVRmxLcm4zV0Fx?=
 =?utf-8?B?YUc3NmtSNnRXSE1vdVFjcFNxWlBYajhmd1g4NU0zaGdna2ZaaWdJdVBSNVlK?=
 =?utf-8?B?UGFVaisrZVhlV0ZmbXFYT3I3M2NtRjJEdDUzOVlkd1JVOTlBc2N1dFlkS0pn?=
 =?utf-8?B?RW9TbXFYT2lvTVhRc0dieldiSTRhQ04yNGFYWlJwOS9kU0pDenRjdUlPUjhq?=
 =?utf-8?B?NW9iQXNKeDhTeTIxUHRCSUNOSmU5d2x6T21SWDYxb0wzYmlieG5tZlF0eFVQ?=
 =?utf-8?B?V2pxUTZ3UGhoNFBjc2doZzFidUJEVGR2SU1kaWhQZllUREl4RnlhZGlvNDc5?=
 =?utf-8?B?a0o0bmhIZnlKZXpyWnl3Q2pRUk85ZDhOUlgzRkR2dWRBcytxV2dkMkxVWWVN?=
 =?utf-8?B?K0o5by8xeVBvenM4a2luK1E4bXlMQUtCT3Z1ZVlKMXRUa3VMVE5lWm5Hd3VC?=
 =?utf-8?B?My9ucE90OFhiWkthb1lteVl1dm1UeDdzZXRONWp0c3J5Mk9PZGJJTEVKVmtC?=
 =?utf-8?B?T0VLVzkzSUYwbUVHckQwQjRldkhROUprbmNtRzE4cUpEZ09YSy9sVzR3SHdW?=
 =?utf-8?B?M1VBR2d4OUMrbzBZdnc2dHV6aGkxRWVFQys0bWtFNFJvc1BRbTc5U2dyek5Y?=
 =?utf-8?B?aFNGTm5WTW0wYUd0ZnlNMDhCc0hFT0Nwd1Z1SnVUNVlOSk5wRldrNnZENTNp?=
 =?utf-8?B?SDQ2YkFGb1Brc1MyOGgwZDdvVnBGL093SE1xRWJkeStJKzhEemZQQnhBL0xy?=
 =?utf-8?B?R3YwenFIU2hpVXh1MUxuVzVzY2FkczY0Vm5IK01NS29QM1MrOGg0aFR5YjVx?=
 =?utf-8?B?aXRNVytVTHdwbzM1bEJadyszYkxpMWlzNWlZbm9kWjFLOXA4dDBVYUsyaXR1?=
 =?utf-8?B?N08ydzIrdGJxNVVEcW15T2g4N1ljS2xvMGE0bUkvMFA1QkpidUZaazh1MkNj?=
 =?utf-8?B?RVFuSEZvcm50bnhVTXpnY0pKZXI0L2NYWXdBSXdKMWdnbDE4NlB2M1RBaUlT?=
 =?utf-8?B?b0JDOE1CbmVyMDB3a3VwOGpzSUx0OWg2SnlnNjMrV2NkRS9uVW1jSlRRbm5a?=
 =?utf-8?B?T1NDSDlSeFFlS29qZjJWaXFIc2k5cWh6Rm84SzEwejM4Z0xBcHJZNGpJM25K?=
 =?utf-8?B?MUl1S01pTnkvZnBoajFoTGRaR0pVL2RlaWN3T2s0a2JxN3NLMk5sUWZUQ1FS?=
 =?utf-8?B?YUplU3l1Tm40NllkbXFsUS8xSjFBR2swcFA1VTllZnZPWmY0R0pwYWIyd2Rp?=
 =?utf-8?B?SDJpL3lIaExDc1E4bCtJU2NGRGttUFBPd2V3dFdCWll3dGt6RjNRZDNXK0tC?=
 =?utf-8?B?MG5vNlBrNVVRRTFtQVBxODAyelQvVXpzOWQ3QUFMZS9zZDQ4UnpZK0ZWK1Fj?=
 =?utf-8?B?aXIwMHROZDNLQkRFYkswRkNzT3paQXJsdXRuLzhFY0JxVkZVb1dFUFhHRkZK?=
 =?utf-8?B?MlZ5aXZkTFhnTy8xQnNpbDJZNGVJdWFkSEtxWmg4azdaZ2ZMQ2NyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d8f033-9f8e-4aad-a026-08de84fa4d30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:26:10.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1VayZTXcqi+Ex1+03voCKP7KP6KKno1P/KF6I3TXPpJbK2oEU9LZoxRmo/Giel54wzld1juMY50QbrLxXwOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
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
	TAGGED_FROM(0.00)[bounces-2834-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lasyaprathipati@gmail.com,m:linux-erofs@lists.ozlabs.org,m:gaoxiang25@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org,kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 164A92BD115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-18 10:06 a.m., Lucas Karpinski wrote:
> On 2026-03-16 4:53 a.m., lasyaprathipati@gmail.com wrote:
>> From: Sri Lasya <lasyaprathipati@gmail.com>
>>
>> ---
>>  lib/remotes/docker_config.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
>> index b346ee8..6401c1b 100644
>> --- a/lib/remotes/docker_config.c
>> +++ b/lib/remotes/docker_config.c
>> @@ -202,8 +202,10 @@ int erofs_docker_config_lookup(const char *registry,
>>  		}
>>  
>>  		entry = json_object_iter_peek_value(&it);
>> -                if (!entry)
>> +                if (!entry) {
>> +			json_object_iter_next(&it);
>>  			continue;
>> +		}
>>  		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
>>  			b64 = json_object_get_string(auth_field);
>>  			if (b64 && *b64) {
> There's still a tab issue as Gao mentioned in v1. This looks like a diff
> from your v1 to your v2 patch. Similarly, you also dropped your
> Signed-Off and are now using a From.
> 
> Lastly, you submitted another patch just yesterday that includes this
> change in addition to other changes. It is very difficult to follow what
> you're doing.

One correction, no tab issue anymore.

