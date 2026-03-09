Return-Path: <linux-erofs+bounces-2547-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPxYCrr3rmnZKgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2547-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A023CDA5
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV2lp1mNQz3cB0;
	Tue, 10 Mar 2026 03:39:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773074358;
	cv=pass; b=fGaYAsPSZHaA83UIhPcyvjNQHkLhULfW9dWDtmeNCnWfchzP13Phl6WbcGyq848lR5OXIdSIAvWrWLxKHBrfi7CbJ51hYo61bwxDDEfhkQEELCht79JJpbAZrbcSbN0BfMUKDtgmzfFzWiZEz+KIAcWYGahnXs7SZ0jawZyp2bG5FGhjd2DQtpD05qgBO3sYZKyxVdvxfKBAUfimC3JOrlAboZZP1ygW4caNO3qGLIOVDYj+GNGI9YxfNW4xXheJSb20n6IwDVHhuaKkECN+F6U6ulWzhazhMOC8IGrdUVXTcdEi+sNZD8wYCXrdsENlv98HlsnlXoCcfzNHp+O8SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773074358; c=relaxed/relaxed;
	bh=r58aaBJgzAYNNG7I3WmH0Efrji2VvBxd+qtXJDK7OCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiI+oaXULmWV/gGKC0I8h2Pu071/xyA4FydoUVj2u466AhtFC2sgu6Sz3WHX7B2smUAnNx/LEMt78mLlM0s6wKzAsbn8hDbcpoSuUA6odawDemF7045D+vlMxZvykDIPnfIylR6vJT3l1MhJJ39I2WjhbRP103GQkRmEbWb3mdd1SW557yfRix9GchF6WwFRh7WJUFQ3bhIRSbAxj0mC4XFdimgaalV4zjTMYRowmPN6uOwH3zK09qg3jjcKl2f4a/NBblpnhK8eP+/VjQ4pvU6OhU6LGcRvLYBDcQjxBsxk5xGkBe7Q+pIPs4g0TwyIoqvYSOZjCH9modnqn1ekYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=av8kkjTK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=av8kkjTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2ln41Djz3c9l
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 03:39:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEdFYFy71VD59GKStIlOic/xsFFIfJf2GCFnRg5335E7e4oPrDEJ/nsRpeGeojMseHLrcDLIKwiyAvkNAMPq9sMMJjCpfT5ElUnMz+HxEeCJ9OV2Bx5hgyq0oVhJ+PYOyC9FWNFlbtsFFLPjbURE0HrtoNHiD7yeVzRlrNlK/HOoDe6f0dge+RA1bFIr0GAe5V5VMP1NMD9EtSh9SZJfoS8TAhJav9WNxzDxrz356gOHadqlweEurOkz4PkUIexEplvxuaZ7AwfHPTZRyxpEyDcgXK820j4rmtUinT5to3MHDShFBU0vBge37/8XxopGJFevT4YWbqWTILQpP92Atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r58aaBJgzAYNNG7I3WmH0Efrji2VvBxd+qtXJDK7OCQ=;
 b=Bnep4QX9nc7XBhVjj2Ck3X0+BRTy+0mWDIlU3J1+O3yWvCUzskadHD98iCs15fKYCqcGHh1KJ+8NHQ2vX274gDQz91Qq/qAbNvIaOEWuQO818kTwcpPlMone9iaIsWHCEf33dPgwk5plRHcc234DAaZCw6ZkLZIoRwIQTlQ/gl1cSGJ3CTmnhJ+XP++otafdoOtlcJdorx2w5WkOa3WnvVrs53IuaqaZ/Yz4RipiIoCyrBt5d9LOA8b/7TmCFH3nkCrCTn8HjkcatwU4tv/A85v7a2TIhcbU46UF4zywdNVvp8yiQuRI7pwhsFdhWd5/+FZE6iU+ddtxfNsXPQgHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r58aaBJgzAYNNG7I3WmH0Efrji2VvBxd+qtXJDK7OCQ=;
 b=av8kkjTKf4O1RmL+hZLZ2ZZ4f2mqLtvGcth4mna045dCI9J4rhIuEoVszhrFQfinTfftadwrHFkqsnlqovMGo8zj5rJvFyqXgeZramu8TS3uznRfkQjQAIBjyOnmbbPVgFLh+TKivzlGF0x0H5y+vUM3fhsUhW3AfGzZNSCg1zkenrZWoOtVO32/Qt6hbZ0hONKEV6YValTlerX03D/F/w8SuV2u/MgdFweWLa1zGNuEmhPSaUio2xEtRLsUXR5n6uSK8+/BptZBTMyKqWxDkP0jrKP1Xlk5bCZUeJDsoG/z0pWeAZW8ojEBlHL1oAboUiKwNEq7j3ZNp8hxKCJB0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:53 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 16:38:53 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 2/5] erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
Date: Mon,  9 Mar 2026 12:38:18 -0400
Message-ID: <20260309-merge-fs-v2-2-2dd0ef53db4d@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
References: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ac4593-534c-4754-558f-08de7dfa54b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Viz5gSLLwadVNzkw2A/UQUM5R3AKRtyAfHVtEfjVHVL7YHplgjZMcjiMlWK7yDEoUnvhxNgfQENT/oJQiDiNc7cGZhDe+M2Ztcd/wtYBCiqCerp8Qu738oj4FhpX8G1V7NIJiKWpB5RZN+qhpcF0yl/DJDqEK6W4WlBmsyQBP+/hpB5bn4F8/uBOoYhPK55IZws1vcp1Ceo7wfyYqDRix2SicaBgWrarFwYSQ87eO542nSL36YdU7RT+xyVIpUJaJPMZ8yVsmo68RLF7Rc8d05Pcp+FO6ANMfXUK5VtpOZ7RfJJzYwnO8Olij6ICOcrwwBFibCdwdpeX0h5J+/fSjLVG5tKJH0zau6oJLWGxre/Oy0Ga8OZsdM1Fy5Bbf3BJpIKnrA3OKmYpGWKgmJQrq2+LGXlstge+AxOCFZyY8BzseIAVqGmdYvm6oaRcL/mMw1soOGyqvA9WC6MjuCFUJIpsn6AEPP4ngcQXliBr1Rx/V10aS8sk9SViZFMLzgo3cYh+VoqW28ijFodp69i+cll5sEgUbFS/7dQlql7TH5dLrHNXn7QxCyVgXk3Z/Llh6JPCff2HIEpzQtOuwD3kUI4okCmNOeclbIr0E4q6/4ETRxc+aI4kdmrCYkwmnyH8GZnjs23OxDB02MjQjzLVf655ym1Z2EFzwonJMVFy0uEVN67s8SVMCTOAwbAh6rEwBfsR5YadL3h/9311OpZ8g1k92AlBOPFxA0u5+X+Wc3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ZuNlVWbDQ5UUl5dnEvdG5sdCt5cGJLUkRkbDQ0dDdZdXIrdEluWVNVYldy?=
 =?utf-8?B?akpKNllPTmQ5TFVDcmtHTWFFLzh2VmRDZ1dXcUg4aWhBRjBZeFJmaGZPVW9R?=
 =?utf-8?B?UzJaeHN3c0xka2hzZDJGaUJmeVBIbVFWcHBxK2M2eGxSSnlmUnlRdzR3ZlZk?=
 =?utf-8?B?bWt2Ui81bmgwWlNVZ3RkTlE4anB3djRjbnFFRW9GSjN2SXRHUk8vTElmcVB0?=
 =?utf-8?B?TGl0Vkwrb0ZsVXJnUklBLzFWeTRHL2tZeHRUTDJRNzFpOXg4Q3hGK1VlSnZr?=
 =?utf-8?B?aSttU0IrRHZ1YldqSGlxcnNJcmtRY1hHNjByTGJUMnBWdUVJemE2NURjNFhJ?=
 =?utf-8?B?dXVjMmtSdWY4b3lsTlArRjJkN0RpSVRSNEcvTmpldjVjTzA0MjVwZmp3VlZk?=
 =?utf-8?B?YmJRUkdEbFZuTFQ3L0pSUFllMFUzZnl0MnpqNjRRUy8xU1FIeFhKdEJZOUoz?=
 =?utf-8?B?Nmp4dk92Y2NWLzhXdkt4VVdQdkdRL3c3RTFIby9HaFh3SklKMmNaZmFyQ2tm?=
 =?utf-8?B?RE52N2t5bm42bVUyN1hlQWg5azBlUUJqNlJETkxBKzQxSDFjd0plRGdmanBK?=
 =?utf-8?B?anZyek42TWFKMTU1ZEg1RFc4TzlZOUM0cGJIby9qVG1uQzBIS3lFYXhSSlpp?=
 =?utf-8?B?dlU1MFRoWGF3QnBDL0MwMmQ4UjFJTmxTbE92MFdDVTNVKzE1d2NwWFc3dFhB?=
 =?utf-8?B?Y05XMFpaWDYwamQ5WndadUNNM3hxRmYrKytOK0dRbFB2UVRtQ2tNa0oxZ3Vw?=
 =?utf-8?B?Ky93QjAxRVRMRTFUcytmZW9BT0ZGdTJ5WXB3dGZ0TWtNWHl1bzJQRWNzWGRh?=
 =?utf-8?B?R04remVicndFU2V6OUYyS1Q2MjRqS0kvSzM3RXdpTXBpUWsyMUFaQkNnSm0v?=
 =?utf-8?B?WnRsdnc1aCsrQkZoYnRqMjFsbE8rL2ZPNE9PNW9hdUJDSWtMUm5rdTVSd0s0?=
 =?utf-8?B?eUd5alExNThPRFhEZlRTdXdUR2orN1YyTHRQSi93bkNTNTdWWW5CS29aT1ov?=
 =?utf-8?B?RHg0T0xWS2VOUUxKRCs1aitRM09sQStXN1VReFZ4bXNMMk5tTjJKUWRKVGFY?=
 =?utf-8?B?UHlMYzhsT0syWGxwdUxQY2J4RzVNblNDajBLTzhrc2JXcGtLcTl4K2dNd2Uy?=
 =?utf-8?B?NVMvWUF6dlBLQmRyeTZyak94ck14bUNtK1k3dytSVlNlU2ZYRC9DcWxlckN5?=
 =?utf-8?B?Mk9TdUdFMW8vT0FjcUZxMi9hQWYvSE1hMjM4N1pLbDFKOXhUMFZ1MHU3NkN6?=
 =?utf-8?B?SUdqejhSWGVIL2twM25EbkRnLzlvaUIwdWdVQ2dSa2IvaFRFYjhpUjJwakF3?=
 =?utf-8?B?NEU5S3VTNHRXMEtLRVVPRnZBTzlPMG9IR3FwWUl2MWpycmt0alRGVDh4NTR1?=
 =?utf-8?B?Yk1ZUWFhTVYzOFo3QlZlWGV6MlM1cDhNYWpoOHMyTlUrZXhFR2xvR2dXMC93?=
 =?utf-8?B?cU1SVHpIQ3gvMEg2c2ZXSVIwQTJKdDRsOTFyNTY0WjVBd2lwOVd4b1pPUSs2?=
 =?utf-8?B?a0ZSSDN0Q2ZqUTBNWkhqbStxK2ZWUXY4dC9wM0lMTXVUZTE1TzBLM09HWDdo?=
 =?utf-8?B?TGZpYzE0NkRqVW5nVFlhWE1NMEdwODcxdUU2OU0wL1VZbWNHWDFNWmRydEd1?=
 =?utf-8?B?U2JBUnlDZUgzVHBVb1lrVE1TL21uRUUxcGQ1VnZ6ZElXQ0RFejlhTi92ZEE5?=
 =?utf-8?B?SW11TTRmQSsvTmJWZm5TdEtHTjdCRlpXOHpBZnluK3BnODlFS1VCSFB2aE9z?=
 =?utf-8?B?UFBJS2VIRVF6djNZb0Ribm4wVWo5cThENVBYNVIvWXFyeGJobmJvY2NwRXgv?=
 =?utf-8?B?bStCZUsyMkNJaXZiR0x4NEgzcVhVWFB0UzFxNmZwQVIzcVlra3ZUT2ZrVkNW?=
 =?utf-8?B?UzNsVDV1NnRRa08wYXI2dGd4bzQ3SmdoNFJCRHIrWWl1ZGV4VDVWakVEbXMv?=
 =?utf-8?B?OTk0b1BCSFpSTDFhQld3WnliMy84eXQ1QlhiOE9qN0NWVC94N1dBNUtIL3ZE?=
 =?utf-8?B?SWwzeHFRZmROcW5Qd1JRanRlZ0wrcDhRUWdTR28wZ1prTEZMeFdSVWpxbnU5?=
 =?utf-8?B?T01tOUpkM3JsOU15TW1oVk5GYnFFZU5MUVVKV2NTUjdwNHRzbSsxeUlJTEFH?=
 =?utf-8?B?allSUUlTS0NBa3VXN0FnVUFObDVoZWs4N3lXNEw3cGxadTh1UEp2NVVpWkJ6?=
 =?utf-8?B?UW85NW9MZzhtdVRXUGZlNUtlbTZ1TkhCRGZ1d0pZUzZHZXRsVFVBTFdZYW5O?=
 =?utf-8?B?SFlMaEw0TnhVVEgza0lOQTlVSFdPcFprdm5Zcy9vbnhiOEVKdkluY3VreXdi?=
 =?utf-8?B?bXhlemZsMDF3VVhPUjVYR01uWml4TUE2K1grS1JudFNBa1FPMkczQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ac4593-534c-4754-558f-08de7dfa54b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:45.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnKvewVcX5yrw4dyXoAHF6lln7Nc4tRd/Sqe6eaGfIlFSrzzmBXt2JQ0FPgHq4tnnYb2tZiu9M00VI8SYFr1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 2E3A023CDA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2547-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

Add helper function for converting uuid to tag. This will also be used in
rebuild FULLDATA mode.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/liberofs_uuid.h |  1 +
 lib/uuid_unparse.c  | 16 +++++++++++++++-
 mkfs/main.c         | 11 +----------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
index 63b358a..c35762a 100644
--- a/lib/liberofs_uuid.h
+++ b/lib/liberofs_uuid.h
@@ -4,6 +4,7 @@
 
 void erofs_uuid_generate(unsigned char *out);
 void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
+void erofs_uuid_unparse_as_tag(const unsigned char *buf, char *out);
 int erofs_uuid_parse(const char *in, unsigned char *uu);
 
 #endif
diff --git a/lib/uuid_unparse.c b/lib/uuid_unparse.c
index 3255c4b..18e87d1 100644
--- a/lib/uuid_unparse.c
+++ b/lib/uuid_unparse.c
@@ -8,7 +8,8 @@
 #include "erofs/config.h"
 #include "liberofs_uuid.h"
 
-void erofs_uuid_unparse_lower(const unsigned char *buf, char *out) {
+void erofs_uuid_unparse_lower(const unsigned char *buf, char *out)
+{
 	sprintf(out, "%04x%04x-%04x-%04x-%04x-%04x%04x%04x",
 			(buf[0] << 8) | buf[1],
 			(buf[2] << 8) | buf[3],
@@ -19,3 +20,16 @@ void erofs_uuid_unparse_lower(const unsigned char *buf, char *out) {
 			(buf[12] << 8) | buf[13],
 			(buf[14] << 8) | buf[15]);
 }
+
+void erofs_uuid_unparse_as_tag(const unsigned char *buf, char *out)
+{
+	sprintf(out, "%04x%04x%04x%04x%04x%04x%04x%04x",
+			(buf[0] << 8) | buf[1],
+			(buf[2] << 8) | buf[3],
+			(buf[4] << 8) | buf[5],
+			(buf[6] << 8) | buf[7],
+			(buf[8] << 8) | buf[9],
+			(buf[10] << 8) | buf[11],
+			(buf[12] << 8) | buf[13],
+			(buf[14] << 8) | buf[15]);
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index c2c0a1d..48da20f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1782,16 +1782,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
-			sprintf((char *)g_sbi.devs[idx].tag,
-				"%04x%04x%04x%04x%04x%04x%04x%04x",
-				(src->uuid[0] << 8) | src->uuid[1],
-				(src->uuid[2] << 8) | src->uuid[3],
-				(src->uuid[4] << 8) | src->uuid[5],
-				(src->uuid[6] << 8) | src->uuid[7],
-				(src->uuid[8] << 8) | src->uuid[9],
-				(src->uuid[10] << 8) | src->uuid[11],
-				(src->uuid[12] << 8) | src->uuid[13],
-				(src->uuid[14] << 8) | src->uuid[15]);
+			erofs_uuid_unparse_as_tag(src->uuid, (char *)g_sbi.devs[idx].tag);
 	}
 	return 0;
 }

-- 
Git-155)

