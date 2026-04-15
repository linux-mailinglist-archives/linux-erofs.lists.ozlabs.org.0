Return-Path: <linux-erofs+bounces-3311-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NqzDgyc32kEWwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3311-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3540523C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwjgT2Y56z2yvh;
	Thu, 16 Apr 2026 00:09:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776262149;
	cv=pass; b=OhkRAxS2hcYaPOxJRXdOVPPmzXMl4aNq6n7JbpUGjA8AAisj92/BnPJ7QzqQq4qsvDPax9i86L3nABaLxXURB+581AmPt0t9BkWIl/xZ29L4jY6eO+cfsgRaQMJURvYGtGIIvz2GVyTXHFMu9z0QVxoODP8/rcLnpyngCbVlrZ0M7vwzOyuBhCUgQGqD5WWV5fLGS8SnaALsEJv31q6yHoNe4pePVqn8sxbPXYKJWAfzm4s6sLJUvey7VZj4I3RMkgrx1nb8qFzDT+zIcS2hzJQ3h4NV7T5/06ufuXWtXZYEsSxMxBQSuq5jBzJxELdxFQO3YXBIrTHZIDO+NNHu+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776262149; c=relaxed/relaxed;
	bh=c5u4C1Iw4mjRjuT6gt9fkzwX9zSpMbPlQoAEX+xfOak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXvZuFaj2bWwbGqaPuqLs3AUKkgdfdX2Oh7jjXRPwDh1rus3rzaD8dEHF5wEF86fC2RzG/sRz47MyPXo/YEHlhxpNAFdfxEMuWXxlSpLE5MQFSi2daQVeqwvV0+AqeVX1HcEZR7a1iPYothwULSVuGsoXKk2ScrTFetQIDr50SVzgfHSFLz8Qcjk5k8mCX80qwk4cKATmMCHCnghOgSblMtja4uf9bTGVely3H0DHurPOOaze8JHGLR4XNyYhbClSxil0sKDoZPuAaGR907h3W5A9/X70Yn0T9Otp0xifcHCJSrrWPX8HNPqgvI94qI8+l8IIWMvlEEhScOGxAAYDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mcq5WFKl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mcq5WFKl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwjgS2Zdyz2yvY
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Apr 2026 00:09:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exarvrQ833cnarFQ+D6uKNUyVcJgNGJ/r9jisj35NR3ztKBJ9k481WdWWVdF6wqwZbBJEAmxXJn/D2Wnfi5Xo7awHJ9QGgHwtEEf6Wmcgonf0iMlR7wyGzZy+AzKkakBYorowF3DIE9lutIexPoU62HLEN81rh9RjcuqU002CghsKpPtCCtLsGRs0G5rKJXhbcxgy7jqhG8ZI3PzJ0FuJG9Tx4TlnodpAR5ueJTC0/PUH6yQ9yxzqB8u2/hqUDMl3xRydTR7U2Ny2NMTEuJ4Zxwmm5WMTLTu3WRdmXI4GP0uM2ycFzI4zKD+dI7yHwO/Kd2/Z/L1IMe5i9UEAliAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5u4C1Iw4mjRjuT6gt9fkzwX9zSpMbPlQoAEX+xfOak=;
 b=C/goZP3A26LhxPFsRkmWKAJWHDNECXohG62hzgKJXJX32VGa7MWcp7q9E065yxDhLIjtVvO+52j6HbWFZC9dHdXdm+CWT6wC3hfYZdaJgRBj96dc24c4/mHJQ3ewd8c4Wj59fROfRLzSqzw3g6/n/tljyXSP7q1tfCxeWjtc6vywupRyGcKJ1oOadryVq14eLypg4kSZfPnhdkM6rMzu+17fQu7XHe2AnxZ4dM6EOip2LpjTB/qZrzOrzGNA4/dXMlpLfbh6DeavIFojGYavyYFEZ3hdHMwVf5g8hjPVwesrT/Zc7WEJekr37TvpO6HhdeJW8sSh7PbFJs9xwA8nbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5u4C1Iw4mjRjuT6gt9fkzwX9zSpMbPlQoAEX+xfOak=;
 b=mcq5WFKl6thEWaRCpqHlhDa8xoDsqI9c0wpvNkLUGyGnEGtd7mAiCvdM6u4LM/+66CIfBXJ2G6CphRxQvyAbjwxfQjSOR9TfqH29/hY2hWRWQrzFGzBbmNybkI/3xFZsfJj9wdEbrzwnk1EZuB+X/lWRT+1JiMlF2RG3SVX1VXF7733UVwZhcJyGSFl6UtoMjRytibI4fMVJZPcE0unVlKJwJ0+8i95lJ96H03X7N9WDfpLEH0peP7ZSNFeNXSQSknrRwdQlMPLPjrabkGOKJw5w3ATabcwSOQJqjvvFabDfJT8PTEs87GjE8XETw976xpQgrdek6+hURPvEoewHIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 14:08:43 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 14:08:42 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v4 2/2] erofs-utils: manpage: update to reflect fulldata support
Date: Wed, 15 Apr 2026 10:08:10 -0400
Message-ID: <20260415-merge-fs-v4-2-4c6860a62255@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415-merge-fs-v4-0-4c6860a62255@nvidia.com>
References: <20260415-merge-fs-v4-0-4c6860a62255@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eadeaec-4b37-4083-f924-08de9af87f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nbsbWwbTImyonxRUI9xg7eX77VUNafhb01G1YxvKP/uuLrYyBrxf5t5Zs7+wl12xNUa71apoF3zVn/oPVjNDMVbd43CyEaHJF6WZrIVLzk20wO91IG2kN72/cmUAsvKEW3+CYW/vrVq+DAp2A3mf0cUR3ntPNEO8rOsK5d4DaU9xdeh8ZGPE0wVzB1zrLOwutebBdAkt2mk6fEKaF0+HvpX950pAgeVugcfhxGk3yBE0yj9Wn4/CzFymFxVHOUwX5usLp3cW//EjGl40K/rpSz/SJvc/JkLXWrzucA7JsBXr3QGGVDBcEuyCFQtI8u7ru17CkpirVhGlFaJ2/JKCCqMSyPHdArs0SBiFKZF+em6aZb1BVw63DoRSkTK6YRra28G0YwQ9DBsVPIUjCGdsib1bEXxdcrxDYe406d1dVu+OOZHl/syhCS332Yj7Bu8rEusqyWECmkEdklN+e/w3N3fsHy5Vy8XT2cBEvv+FU6ElJGhocyEYoms5JD9twDKTZRmqQBhm7Yj9MI4sCd1OP6QXVF33g61SJpLG4xSakHjkymGK5CFTwSbbjhM77rjgaoeOhXxs/rfAHZQ9IiOifhxeRx+pucqo4uNNU/zSNv/gRcNy/ioYZL1Vs9FP7NaUUs8bRGXBqedxNP0peTwQbT30vjRHXsnqXKBhvWs4prRSFGo8yuo6X3N0kL4wgfnXC/1z5T+BhikXjdtiWgbn6k7PqkHftOsIr0gIULFPNnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZ3Q3BPR1VtZER1ZzAyUTQ0UERjLzZySWpUSjVtazF1bDJ2b0R5OUxjNXVZ?=
 =?utf-8?B?K0dHQjlTKzdaSzQ4UHdOQk80VEJMU0RqeDByVXZVcGlSdHB1b0JlZXYreGE1?=
 =?utf-8?B?ZnFjNU45ZWpVaFJyU3VDamxBMjl4U2taMnhHRkRSM0E5YmZhbXJNZlZJV05a?=
 =?utf-8?B?Z2dkd3krQllBTVAxUzQ2YTNIdHRNaEJlSWtXQkdwa2taS3F5N21seHFyek4v?=
 =?utf-8?B?RndoMjBXbVlCTHMzV2U1dXQyVFMwRUN2UkpmL1lBaHJVRGs2SXBKR0ZVRCs0?=
 =?utf-8?B?bjJ0YXJmNXZpZFZXMlhTUUloeGdCNVAvTW5lUUxCdG9NMGtMTmNzc2UzMWty?=
 =?utf-8?B?VnFVdnh2Sm9JOEl2UTdNM1NmUlROaVpjN3BVZmhDUUFpQ2ZTOFB3WDZkNVM3?=
 =?utf-8?B?a2RrVFl3bXkrZnRVQmhVYlJlRVBCaVJaK0hwL3ZQSnFkQWxSUU5vNlM1NUZq?=
 =?utf-8?B?SnRNblc5QUh3dW1PditOL2pPWjRZVU5nNy9BSUNqbnRmRUhxSnRtSEh1QzN1?=
 =?utf-8?B?anVwa21PdzZzYVRyNSsrbTNuNkw4RHdacDdFZ2hUZEdaWTBqbSt1S0pvVk5Q?=
 =?utf-8?B?WlJ1TkpoUGV2OTRUelRzQUJWQ1hrSUpUU1dhK2JpMzExTjdqZXQ5QWJyWjE3?=
 =?utf-8?B?VlpESW5Mclo1OEpsM1VMVFZnRmxveUExKzZHREZSdWRCWjRjUnVhaEl1cUhh?=
 =?utf-8?B?QXFrMExGTlRuK0x4RXZKTHF0RWRxYnoraXlZb3ZZZ0JGWGJVempyTXArbHkr?=
 =?utf-8?B?UkJiVmRBdzdRQkwzYjFnb0dKYzlPNHNmZUltRjFpT1J3WGJ6cEVuVSsvbEhC?=
 =?utf-8?B?TjRWR2RpbjNkdlJFTHc2bnF5R3RuTXZPVEp4a2xlZFFEcFVVTkZ4TXhkMk5a?=
 =?utf-8?B?alg5MkJoTGw1RFkwby9RTUc0aXlSd0FhbkYrdzdRUnlSWjNuQVRJajFIZ1NZ?=
 =?utf-8?B?Nmp4RmZjZkRRRVZvRFByQ3ZxaDExQWR6cXUvd1p0dGF0QWM4R3N6UmtmSkpW?=
 =?utf-8?B?bHczSG83Wnl1Z2xJY0R2VnpCMHkzcjBHcUprcDJzQW51VGt3K2RJY1JUdG5u?=
 =?utf-8?B?d3p4TFY5OEhhZjZlb1UrK2ZkVG5jcDdTdE1JM3VTaHVOOGFaN0ViV2xmUDJO?=
 =?utf-8?B?ZkkrS0N3N01tRDliMlVFbFFsVENpS0wxcnh0Z3ZqYU04UDZNSDVpaVNQY0p5?=
 =?utf-8?B?eUNVUVczUUcxNGMxMjUxZ3d4eUh5Vi9xRTFla0R6d1NlR2JMN3ZLbzJhSG8w?=
 =?utf-8?B?N1JqLzFkZ2Q0N2lrTTJmY1R5MWYrU2xhZGx1cnFIaFJjbUNhOEYxUlRYc1RE?=
 =?utf-8?B?YUZYWGp0cmJERzVoRzNudWJmVk16OGRQcXhtQ0IxR1RkR3BnTkg4dUlUQnYv?=
 =?utf-8?B?VjVZNmNSalA4MVJXcFZ6T0Z4ZWpKQnJpbjVTMlBQRzMrT2hBSXBhYVZMS3JU?=
 =?utf-8?B?ZjFITnFsYVQreWROVnJIWjNjcm5weGJIUktHL2EzR0ExVjRjQzJMQnBNUVN6?=
 =?utf-8?B?SnhiOXdhZGkwSHl5WUozMm1mc0hVN0tyZEZNVXc5eEg1TWN6ZmJEYTlYRGRI?=
 =?utf-8?B?V3JYbGpsaGx5T1U4RU1Ic0pWd1JFaU5iaTlleEdLbjdDbVhKU2wrN3VpS21j?=
 =?utf-8?B?dmdmQURycndoWDZ2cm14Vzl2Q2hQMFVHbVNCNEtYNGhMbXVQMHBjVG1mMnJh?=
 =?utf-8?B?aE9ReHZoZmkvZXZHOHlRUGZkbi8vZVZha0N0Rm1IN2Y1Ly9hLzljZlA3SmNR?=
 =?utf-8?B?OUttTjJFTUtuMzBPL25Rc0djQUFQQ3BBaXpVVGQ3Y0NKMjgwamszR2drVFdj?=
 =?utf-8?B?REZnTkRMQ0ZneVB5VG9NYzNjNFpaUks3RHozdk1GQThUblJFT25od09YUktr?=
 =?utf-8?B?ZndPZ0tLSFYxS2YxM2QxMmxHVXRrMjZJOHJvNjVKWktCSnFyMWV0M01EWmhy?=
 =?utf-8?B?RmlibDk4Q2lsOUxVSCsxeTZtWm5PNC8wSjR0ZGx4ZkxzRENUYzJRS0gwM2VP?=
 =?utf-8?B?VFEwRlJCQk1zMk9FVGh4VE5QUlVwRTJsQ2FLN25KWUk5UHE5SkJ0OWYvdlhw?=
 =?utf-8?B?aUlMOEpyVW85bEtyZUVBdG42Znl0SVZpU3BjS0FQTGlaZE1wNWFzUkNrZHRr?=
 =?utf-8?B?RFhKVGQ1aTF6RldyYVFQaytPOEZnTHh1RDNTNzdzaUgwRVpvRTZvN050VGJJ?=
 =?utf-8?B?VUhtZEtWNlUwdWJ6S3NiejRBRjNiNmhPeXRPbFNhY0Yra3hwTnN3RlNYeDVY?=
 =?utf-8?B?aE9Uanl2M2ZybVNEc2FmQXNpWisxUzdPQ21zRVVKMnljZjZGVnlIdEZEcXdJ?=
 =?utf-8?B?ODNVSDVNRGZkcWN4MVhGOTNCelhTdmg2ZXgyMTczUnhmUXJlZUhudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eadeaec-4b37-4083-f924-08de9af87f2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 14:08:41.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYb4luUWdLR89DtbCYHO8khHkjoGaHD5OZwzt0JGGYuhdSErWA8na5SXSjcM94VVMbKe8ayUNhqGs8SrBKsSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3311-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: CDA3540523C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Specify that data (fulldata) mode are now supported alongside rvsp when
using --clean={data|rvsp}.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 man/mkfs.erofs.1 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index a102e65e..65ec8079 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -229,7 +229,7 @@ Only \fBdata\fR is supported. \fBrvsp\fR and \fB0\fR will be ignored.
 Note that \fBrvsp\fR takes precedence over \fB--tar=i\fR or \fB--tar=headerball\fR.
 .TP
 .I Rebuild mode
-Only \fBrvsp\fR is supported.
+\fBdata\fR and \fBrvsp\fR are supported.
 .TP
 .I S3 source (\fB\-\-s3\fR)
 \fBdata\fR and \fB0\fR are supported.
@@ -521,6 +521,11 @@ source images, which act as external blob devices. This creates a compact
 metadata layer suitable for layered filesystem scenarios, similar to container
 image layers.
 .TP
+.I data mode
+\fB\-\-clean=data\fR: Import complete file data from all source images into
+the destination image, producing a fully self-contained EROFS image that does
+not depend on external blob devices.
+.TP
 .I rvsp mode
 \fB\-\-clean=rvsp\fR or \fB\-\-incremental=rvsp\fR: Reserve space for file
 data without copying actual content, useful for creating sparse images.

-- 
Git-155)

