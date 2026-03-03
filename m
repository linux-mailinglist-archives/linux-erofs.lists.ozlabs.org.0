Return-Path: <linux-erofs+bounces-2480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BY2LBZNZpmnMOQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 04:46:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE41E8896
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 04:46:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ1tj3kb9z2xpk;
	Tue, 03 Mar 2026 14:46:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772509581;
	cv=pass; b=h22eE6G7xJxcNAvMqiv0oSg/DEdBga9i6vjC8JYJvV00paB5v1K2CxzGAuL5wjKU8aJlYqpgSsw+zwRqyfTgZFCwjUGvo0xS7wuZmovBiDXb4sANxk3duWnyNcLXlEqN6NTXjikm6vSstho/EsyoXw1qS1w0ZgLlGDU01w11NcUoEhThsNKQ5P9L1Nz/S6kIrmouyhQccP73u3UhkH0eQVjzvADGc3+keAyCkAy1zX08qkQ8VbS0Esnr0BRiT2mV6QxVjPtdcGkL091OLR8nw1FzNs4Pq/0YjAsgOyDbl2qxfRBTiuzJGIbBT1iqIie+sfHmdK6GisT/8UksxvrOdw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772509581; c=relaxed/relaxed;
	bh=xCiq87A7R/HIAlI6kr85YZUXHkTw5FgU63YA0/evt+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9I835l5Ikozz9EOS6RnxOUa5n2/D/uctKhGm9d6pYWyRIjkt1BWyaSMWP3dUMCddGTeuZx6yRrG1OWXNVrOrJ3KT3QBp2ZpS9OV8UI0z89N/+RIppa3i7hLnh4er7u/Bh1EX1q/gRy/taoTWPQzJA2kP67SW1/SQkl/d0fGadWNqk92jzrjNqNWidUveolBT2C4LG9fZ3NnEzLVU+TRoi5QsolxWxReYNtVRxlL/S5p5QEgym4eVjMQZjjgtY7VoEBZhe4+uxnUwMS+x71KSgtA+HBIiWtXrw4S23PCIsLGAVFLxx/W9V45IIMKtNl64ssmg7o9q6F7ZKsDu0RbHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gvk1Rqjv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gvk1Rqjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ1tg4RGrz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 14:46:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN7kmNIuheVEHeTJ8Bhg4VcXAsx+74NPlNmHFNNSaFpdz2TK3d+Q4sxXXH0hToabBHpm1N/sw38Rs4T2G9HkmJc8Sk5MpU5J4kzSlAhD5UwHIRIRH4lNICts69gDfpyxK/WVw/npHm1re1b1pfrJMCsMavbwb1cxLCbVuN9ySsDcPBONriBlJgRkYI1hIuhoEinCvCJurTnR5oBWr5xTOA3i1UZUosBtFXyY47irmQsMYvjcSaBFwyxRcZCvpwFVWULBcedkHZQ9jzGjZlUMduFWBwcL+Ung8jHfUdWaAMNfXznBwgByfgU1ZJmZIdow/NO7562hcWmmsWNv3HTlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCiq87A7R/HIAlI6kr85YZUXHkTw5FgU63YA0/evt+A=;
 b=jsO9Wf1om2rDI5MLuxgNzMEtrUMqd2xclXDPnUwN6UIWaNubbpV6H4ZWpqB6bELwLpNtCD4ksZKohHQsNpCBMN4SII7sL8V3yRtHCbyj++/CirCDfti3VXxkgtWWzoEUAb0bH8bvZuJdw0Byer4VY3A6j66ahKfffSb/Ns8H02PiqU6n6qAXpeJ6US9449MAS+zzXmtM0O83QWlc2H3M1E/WvDWUGQBLkeCKeO7wppc03bL+/EEQnomAKfEywICvraSBqVkhyVQKAudn3qBXXNQMffE6NSCuxt960JzOWWefALTExpx+j98sQNPPbLta+k6LRjFv6EhP+cucmuEv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCiq87A7R/HIAlI6kr85YZUXHkTw5FgU63YA0/evt+A=;
 b=gvk1RqjvHjYTeJo5369QYzFcecCtPQKtmMHrr6Lmu5CkKeRFFoqZW+fiOrv30nvHkcM3pgkpbgQNROhh2Eqk8eLpw1kJkxHhQwtjV2XlSqwismQxx4/N9xguT43vMg8CTTJOBT3hYLaRnFDHyuJOrd4wpashGXeJV8ojiwXFxerdmvGEc5gEI7tlMMIhElAUP4H3IosLEY0Zfe6Ch1nYmRSMac23uz6qfbp+sWTrGV3y/2jsBl4dlDSqtvX05K2qbaTdLsY1Q0yy4Jlx0dIfjE/eHTnCgiilRaIz7teshVhjshztD8kuIov4ysIrUDjtiL45g/1nm80gEeyRSQHpyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 03:45:55 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 03:45:54 +0000
Message-ID: <c4d3b1fa-5044-4243-a339-e15c32d5e085@nvidia.com>
Date: Mon, 2 Mar 2026 22:45:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhaoyifan28@huawei.com,
 lishixian <lishixian8@huawei.com>
References: <20260302130356.769479-1-lishixian8@huawei.com>
 <20260303023911.792454-1-lishixian8@huawei.com>
 <9fb745b7-6944-4773-843e-099ee598557d@linux.alibaba.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <9fb745b7-6944-4773-843e-099ee598557d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea48bff-4415-40e2-09a7-08de78d75f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	rZi7CcAu/XkvQt0BHpPjUIrygtdjnoh92ai9xlsORewVtFBhAL96nBvfWFIQ7o/MNZTUlLAZ7M4Czv4vaUEq7D/Qt5sO6zte8goJYz5qOBtU83nLkLS/9RDuf4PQDcInm101ZMKu6OPQL4r+L3WyoSzVkBp5XuKZmWDKJaOU0OYqac3uPa5SDUwLrclYw5X7xuGef5968WRQAatt9PKVCzyNgHZjkq8DPAtkhVuPYWybBfpnIm+icZc280uHx8aAJ6iUT+dfSAgkRB/+snBsCIFXeNeeV3Y3BVemMVg0w3w9sx01sc36oyWIV/mW7SjvWoy8MBEhPNvsGcczAtwid9YHvdlSTC507rmeRQsZkkqNRFjmWgkah7FB/Tq0CQK+UUoLgGMilIDeeLif27yD5gAc915VvUCxlzdmsHu2/lLe5K5fRemXzBfcUI1AfMtEzWa9zODbDXFJFwyCgP8WNux9ai1e0pqpFTi0GmoO1gPDNbzn3FBRD+D7zbWB0CO1TL9ZxbiNMBtJNjkva2kRygG54jV9A2hQ1oA3OEMOUmuhjUYqkXwShB2o6C7YILjxj+xPaGjVyYXgJaL5eU9FT7QRyvlmJhy+VDccBBevr9zgqJXOaPcbk+jUl29mlFZXhS2Xnbux+W+cdMjMMrVTgWXqlo5zvT9RLQkuQ8RcuY73JGzTz3L5HHdvy98L8DoysDu1MyQa4Y5bvt6IpDVGyN3KWALiZ6e+YS/bYlUB0Bo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFOVDZMeGZ2WFFTN2ppZkp1VFdrZlc3NDcyOWlBc2llazBLZWYyR2FBcjlT?=
 =?utf-8?B?Uml2YVlqdFc3UFoxQWMySTlBZXBLN1J1LzVpeVhoRmJUaDJTUGtwdDIwbDZu?=
 =?utf-8?B?VkN2WkNYUGtPVUd4dVVTK2JZNXpBcExwL0IxVGllR0NWVG91VDJUNVcrYUlI?=
 =?utf-8?B?T3VSNXNrb3VEUzJvbDk5SUdWbkszL0NqMngrTVJMQmZUYnpGSjZ4TlBpTCtv?=
 =?utf-8?B?a2oyQUl4YkYvOSsybFkwZEdrRG5qTkF5clVQNkFvTG5sUkVZY3REcHh6eGt2?=
 =?utf-8?B?SWJ6Zk1hczZBcFlyZHVJc1RHWVFkdUlXSkdBcUI5cE96c2VjN3ZEMG5leHU0?=
 =?utf-8?B?TXNRNCtkMUt4eVNoRGZvbldVTitTaXlNbzRWWmdCaDhzUmdRdUtTNmovczE5?=
 =?utf-8?B?ZFBiK2NXZ2dON0p5VG1qQ3FaNTRDU1lVQUxwQ1ZoclA1OVZycWZBUnR1VmR0?=
 =?utf-8?B?Y3VpMWhvWU9VVTBEanB6TzlzTGlHZ1hGdmlsR3l1LzR5TUtlSTU3WHZFcjY4?=
 =?utf-8?B?Wk9rQ2VYSW8rOFZiQWhMekJDekxSL2JTWTJidHI2dllSMVBFU2dkWmRuOU42?=
 =?utf-8?B?ZG0xVk50TVNxcDQyZWJreUR3aTZNL1hhSnpwaVBwNjhIZnlHK0xIeWNWMWwz?=
 =?utf-8?B?bWVqelBJdk92azJQZEg4ejFDY1FQSXFtRkRTSURpVkUyZzNRd2NRYWVqUktt?=
 =?utf-8?B?VVppNVNWTWhTWXlFV29DY2pyL3hLMXd6MTBBd3lLRXBSdis5VHZCZ2pOUTFa?=
 =?utf-8?B?QkdOdjA4U29jRFZLSGVtOHduL2p6UDc2VmNlN0szaU8wN3c3RVBTY2szY016?=
 =?utf-8?B?QXRmdzI3bkwzWjhuOGc4WklvVTJ5ZjIvMkhNM0psWk5zWVBKTzJ6VGpISUlU?=
 =?utf-8?B?NzhobEFjZ1Y1L1k0Y1ZLZGd5ZWkwc28vVWdnRW94alZHVGo5c1ZIS2czK3Q0?=
 =?utf-8?B?MTRmWUo0ZVg4cFM2Nktjc2FDUDFFMTVHYnV5THY2dEc4MGRJWVFoTERwaEFv?=
 =?utf-8?B?dXRlZlR3VnNabCtMa0dWUjFUOVN0ajlJZTFWN2ZUNHNRMW5IL1A5aldTZWtv?=
 =?utf-8?B?bzZZNDdRb25OUk5PMU9kYlhCT0M5TEx0djRVemVqblM3MnZoTUp0TWRPZ25J?=
 =?utf-8?B?dkUzY2FaYWZKNHpYWFM0N3JHcHY5MW9TN1p5ZEJEeDd4ZXUyTnFZZlAzdGpS?=
 =?utf-8?B?T1NlaHRQbVhaUW8ySjFLd2RLZDVnaCttMjlSdm5uMnhUWXJkcjdmYUR5RmJj?=
 =?utf-8?B?QVBjdGdRT3RaK2NBNHB4RWZ0WXU4QUtnVDEyZ3ROYjAvSi9kdzFSZTlJMVkr?=
 =?utf-8?B?SDI4WkZ5STM5RjdQcHUrS3lPeHZFRUdoSGRiTWtPaE95dUU4UmR6aHlmUjFK?=
 =?utf-8?B?UVZTS3RWdjlkRTc5T1BwcVhnSTFYSnUxT3g3TU1HR204Ti9NL0dJaVpPd2Zi?=
 =?utf-8?B?am41bVBTNWZPelBIMUczT09EWnZJRzhGZi9jY2I5VittTXR6RUo0SVgvRVQ3?=
 =?utf-8?B?QjlqS3ZXZU9HYmU2Y3QvN0ZDcWVlQ1BUbFpCbTBFUitqWnJsdTZjbW1QY0pX?=
 =?utf-8?B?RnpocHhvNzdkNzVTNGpGRGlaaThnTjdzSS82S0JuOHl0ancveEFaVjRVQ2NF?=
 =?utf-8?B?THNSclVlbCtqOXlvYUdNZjhYQXpidHR0dWdIS3VWRjBNelRxbE8ySlhDU0Ri?=
 =?utf-8?B?SitpQjRYdDRaZ252Z2JQVXVKUmNGMXBSbGFsZTFCc3hwaUhqU0VVcUptN2RC?=
 =?utf-8?B?cHovTG1yU0pnQXgyQ1BNazRQU2UrMzNhYkplRDRvNi9pdTRVTnpyZDRkTnRS?=
 =?utf-8?B?N1JldnVqV3JxRmI5dGdCY0Z3WDF4Z2RVZ2JZM1FWbFdITGJHUDJRM1JZNk5X?=
 =?utf-8?B?TTMwZGoyNHV5N1EyTnAzbDR3ZFlzRm1wOHpReFJ4ak5ac1dUY1JMMVVrdlgw?=
 =?utf-8?B?SEpUK0RUamFGdjk4eC9yODN1b3dhcUgzL3AxV0pLMWYwVXdZbjlQS3VIbm1z?=
 =?utf-8?B?SkFwdkNlZkdYQUpBcDVsblpwbjhSWjN6a1JyWFpja3ZyU290TXR6cldRbDAr?=
 =?utf-8?B?TTQzcm9vRk5sOWpGZUk5QWkvbmdSV3pLa2ljZ2U0Qk9oSTBGMU01MC8rbUQ1?=
 =?utf-8?B?VjhVWGM3Vzh3cUYvZ0xRVlFtU090MFhSWmFGUnp0RElTQTFkZEFCRXJKQlpV?=
 =?utf-8?B?RDdpMkNUditGVUV0L0czZ2pURzVRVkl4QVVyYUFYQ2ZFbjZMcFgwTDVyclEx?=
 =?utf-8?B?YysrdWxIZDFCSXByalcybzdabElFenU1bFp2TjI0cmYxek1EV1NycnoyeEJu?=
 =?utf-8?B?bVcrWFhqUmEzTEZ0ZmhUa01lR1lzQ2VXc1U3V08vZ0d5ckZmMzZnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea48bff-4415-40e2-09a7-08de78d75f4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:45:54.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGakd9rdEOTGNq2L8n9s2+h6P+5KKa9QZ6skkrSynP55ZWUMBlMx7USJ3hVdxWiy6uPxVJ2QswSQ/jt4T5+aAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: EDCE41E8896
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,m:lishixian8@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2480-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

> Hi Lucus,
> 
> Can you confirm it that fixes your issue too?
> I will merge this for the bandaid solution, but after erofs-utils 1.9.1
> is released, rebuild and xattr codebase need to be fixed instead.
> 
> Thanks,
> Gao Xiang
Yes, confirmed that it does fix my issue as well.

Regards,
Lucas

