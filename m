Return-Path: <linux-erofs+bounces-3304-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CmhAHWR3mmqFwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3304-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 675203FDED2
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwDR62TM2z2yd7;
	Wed, 15 Apr 2026 05:11:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776193906;
	cv=pass; b=oR/4HqX3i0KVjw4gFJViN/QtLjUhpQuDVjn7DgoWPW0j1fiVoMqGUI8XouYYfQISYrw4CZpZyAL+72nzS9PmH8Vqvfm9mDpd9RRnNHp6dpf7r6Ex4twzHrTJFKImUSHbOZHaTOTx8+HEjCA31FtM5U/9xiW/kPcMnwGQve+YIyrR/fE7YNOMul9vCwYuQcZmlXmyyI2OydUKXeB1a2wiFKQf0OSDFShb1BpGNzwA/L/D16n9dy789OwcmzMY4wW/q+yj0PTEiT0LDlMVQAcky84B7bH8JSIOpuju16cMMY2505XbDcsf8lwbS/ub6eOpWRHhx30b+C1iuBy1a00+Lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776193906; c=relaxed/relaxed;
	bh=xkEinsdHOEsMyqg56kRyrADnd35xEJI4euiDGWNAYTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QV8Wsgtx82GA3sqBe8dmPRHhhWnmrjBabe6cecJpC+Dd7CLMXrRBXDGeyGD5ogf1exdSZs7wxo91WeJzwGmtpTEusXrRsiOnTTG3uB4Ay1YIetdWbR9dwWN8CpowGtZwYkLNxgl7qUkzHJUjVsUfFd1kh169a7/23iXrPIP85KCNUqhW54kCEpEdRbwN8nX2p3odPnIa6OKFdsBPV3QuScYPEyD+6F5XNLz5F5I16D2zibiwXp7x8jZ0pCIqNy6hmMC3HFtwl6CmqxY46LAb6Ewxt3ElBkUh4obfk1p3UBzgd7D2/JXSrH3DeGFBhhSKtAwP+/1+CK21ssVqI4H/uQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=in7rKXGd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=in7rKXGd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwDR55gJ4z2yrT
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 05:11:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grwetyPPVLu55Uh+TjfSD5Z7n1KQ65jlHQiaxAFfpzCoD0y9kl+FrGvek9y6kK5l8/1pADjBm4lvwluzKKwSuTwXkGqPVpyYVV4wydFSO984RsGlo3Q99IAk70zSmwSs1lQ7rtlL3ScOSSUWehr7Eu+2yV/O/1ebMsg/6JLK7t44HBxxkpDZkWCqTImSCGJp0W/wJOhnRnpvnZh7qwl6uHCnlhGIryPyo6YSnsIms3LDgRVou9N2USy+LpZPRi2kIH8b6cu8JzOEzXfc24uO8cGqVfnml6331rnvGoy+DQZpitMMd3a9quplD+omgzQUgFHhtecckLXZ6xS5w9iScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkEinsdHOEsMyqg56kRyrADnd35xEJI4euiDGWNAYTo=;
 b=TQX+1t0zgYrOB9LsBX5eEmkMY7Rv7N+Y5RU3UnCB6EyJWbP0X3IimiTwZPU9nZEIpBTQ0qafuegXu7rRoxT7pxFLo4LqoT+fCb+TRAVuJCFmcziFu74FhueHsH+TOaQTZbYPAQX+a/iaz6pb39/B0tMM2Pp+O/5hJnzRZzkIynlYEMiYYAZswilZH6FMJzf3wH6eIdi2BkpHfCQa2xBfnJ9V2OG7FUQHDGIOOgGI5Jb7+U+xR2HQcjtlQeGf/Y/KtpEr+44TjTU8nsmykKQCG4D9pLYzmrkouEGSnZR710dT9YLs93h96+dYlCAYMlSJlp2Ei7mxTdR4MUobbhHkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkEinsdHOEsMyqg56kRyrADnd35xEJI4euiDGWNAYTo=;
 b=in7rKXGdG/EpWd6VoM1Wfbv2OyNc+vSvXEJ5Tt2YYCF4Vkurk3MuSL4tq12dDNJ9gGqHEe1c1DDJOebh86hj94wk8oIqrmwElg2MyRm/T04xO2W5PcALBaW+0pSDGZcn0isXHnJCFmQCFk+vGBLk8kKhLrYcyjCVN9oYCQ1uq/FYd0xNTbE9LO5i/JOX0DimqYgahh/eKwjD3L+UXlkn9GCRN844NaDqYm1qBrN8cBrpw20kbhvtEzuR5WP2Ns6eSzNDsrcP73m4LYCQ0SP6sAP4m7HGbwDyvydO4JZeIkvZVrBzgn3wtHlbeY7K7n5KRnmISn+XJWcUAfNuNlT5Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:11:07 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 19:11:07 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v3 4/4] erofs-utils: manpages: update to reflect fulldata support
Date: Tue, 14 Apr 2026 15:10:42 -0400
Message-ID: <20260414-merge-fs-v3-4-266bd1367fd2@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: c443441e-1f0f-4451-51e1-08de9a59933a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qgOuuM8iUS4Q4W4CrbZIlaicO5j8HKcgHttJThROEnSIdySonC+DIC+1CwAY42TjPyI+AFj9+49VrbHvRsOGZu4sFKS8cYBSwBFefoiOY1CGIHS70iPjgG95P/A0bMBVT4LjTLOAdV7B2O5sa5FWEW28Wuq8YBdioNU2Yck47cIffllcjddmSgW22n1ojI0n6/eC4FNb3VtNZ9gSL2jgU7JD0zoDITJvT5A2q+IlNuB4DmJlSCk9LH0fsoLvfL6xwP1tuC1R7l4nEbjkeThWVoYNNk850UeInCR5haGPUWnGt3zI4/ZhJsig08ViOPufFmHsOLwm8G6Xhx5mDp7r7XY8B8y8iOzEk6kcGVYLqXXJph2cXJudspB2nTci/PCx7pbfdfYzEuz6GfIDn3WxNgLJrX/WItnQK4HfHpmO/6VKiB0aBYYKNd+eYR8oK/rQ+/j8nZHanCran+rJu9H7iNkn/LgIGYN8eOpfEPZTvgX5KdaYhZuFj/ZIzdUh/BBRWntEKk0OsG7okZgvirRYQumZ/3pibWpkmDf6liTO8DiuP5rUCvqgsyjfdzN3HtJT1nJ+VNFAXnRaxpq7Sm2XyordIb1xn+ykyOPZubvB3axsIVjwk8AJOVkiBH7DYc7lGKXjcSJlT9tYn/k2GbNJnoOKHbaJoaVHx04G8qM0CX0+ZYO2o8mzHcacSDXyW9+MAkzcZcoNoTgfvzbr+iYFKpUfG/dP0kNRfc3EYfEVrwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGh3bXdBVDdnR2pMUzZPNkovR0xOWThNY2lSdG1zTitCemU5bWVoZlJaOW1P?=
 =?utf-8?B?aThSOEJsSnZLdkc2em5LbFdxeGN5MFFIS1NYcGFiekhtWDQ2Ti9yZWNNQmZv?=
 =?utf-8?B?SGhQK1BZbSt6Q1JiWG00WnI4UW9MQlNoZXAvck1EUGYyOWNCWm1lSzBjTEF0?=
 =?utf-8?B?VkI2K2pLNDdBOGVLTnF5S1hVUnlBNFFpSDFKNnNVbFlVa1pRTWZESFUwSENT?=
 =?utf-8?B?bldNK0NTZ3NraTVRMjB5SGY1dEVLZlk3UXZoVnBHOVQ3NEl5d0dUMDhORThC?=
 =?utf-8?B?cWFGNUEwcEFSRGVTRjUwa2twYVlrVkhVanlHcWovbjVCZ0VEa0M0VmkvVUox?=
 =?utf-8?B?ZDN6cFp1RnBCcW42NVE0ZHNuS21EeXU4VG13NzJHd2FFTmZhSUduWlBGMHdZ?=
 =?utf-8?B?RkttTkk2enVEU0ttVWJXclpBVTJnT2hJU1RlY25FZnB5SnJRZlhCa3FUWWk3?=
 =?utf-8?B?U1BKYzMrbEZ6K0NLY3ZuWVFhaHp4bmNtRTEzTzV1OXRxMXFhTTVBU2VNTmdB?=
 =?utf-8?B?NmYrNUhjaW4yKy94cGtTb3RWTU1QdWVCNlVlenhMaUVySXl0Q0VHdnpLWlhF?=
 =?utf-8?B?UGhFUHpPRjMwbmhqN0RlaE4zeWpSNlVDZ2V2RFEvRDVvdFJOL05qRzBCbUhO?=
 =?utf-8?B?amlRZVNiT1NkUXdjR0dOZ0Mvd082c0d6MklCNXFjNlJ0bDBGc2FVVVRXUWNh?=
 =?utf-8?B?YmttSG5sZXZpVExHQ0paMGVORXhnYytsZnhtV2Vhd3Q3ZHZaenJDZ21TQ1ZZ?=
 =?utf-8?B?Q2pXbWlrdEo4SXZkN05pUmJ2NTBHOXJja2gybEMxdG0rUUtrUVlqbjlFZmVp?=
 =?utf-8?B?WWRwVHdzRFFYSkwxcXdldmx5UmROMmJSU1IyaU55aWRkNU1HSi80ZmJmZ2Zv?=
 =?utf-8?B?TUlad1hTYVlGMFBuNXZUdkFPNzJobStZV2VKNHJrYXo4TTZJRGZlR0VGRnRh?=
 =?utf-8?B?QTRiclRWbHJRdXVNVjdjcTZtK284TXJzc2dhY0ROSzRRZlk5ejRHWk9nblpG?=
 =?utf-8?B?aFU2OGlHT3hTblhmaFFKMVRmenl6aW9ndGs2ZTFCc21JdlZBWmRBMm5BcmJk?=
 =?utf-8?B?OWJZb1Q3VlBzL2ZlT1dwKzRia2IzNHVrNTdGL2ZLOWxQMXAxR09KTG5uQm9j?=
 =?utf-8?B?TVJOeEx4N1p6TVVFeXR4aVRMQlJrL2h5N1MrYmVBb0dEdnJkZU9YS2hqbGxj?=
 =?utf-8?B?QWtIRC9QVkt5R0JGWjFaWklrMGFmeVdiUjJMS0tXMlRBSlZNRmpXNmxLbzcr?=
 =?utf-8?B?L2grWDkzNUdjRlRsb1BBa3M1U3IwOVVaS0tNSG9TaDVHSXpIT0I5cys4VHUz?=
 =?utf-8?B?WlY0czNscER2eUpBbmpHWGx0T2ZJbyt0OVo3endlbktuV0hQL25Db1FONE45?=
 =?utf-8?B?VC9vY25pcXFrdmNVc1lNT2s5THh2eWpaeTN6RzMvbHhFRWJPNUhFL2hRVjZp?=
 =?utf-8?B?Wk5kbWwxSmRLdnJjNm9DSjFDelg3VEMzUmNxeFk0QTdOS21iRVV5TjFyM2ZG?=
 =?utf-8?B?M3lOWWFjQjh4aWw2Q1JPQTY0WkhJNXBkc2VROUROSmdGYnV3bUJEWHVFdUVh?=
 =?utf-8?B?ZHB6dkIyc0ZtZ2IzTzNTbnpIK2t6bC9rMGVwT25KWkZDN1MwSlNQNFVSOTRZ?=
 =?utf-8?B?cUVuRWN0RDI3THlrWTR1eFJub3pRbTNEUUQzLytiZE5KaDgwSTZLdkEweksz?=
 =?utf-8?B?SmlmNXNnK1RHRlVRTFZMTnFWWUNDcU5Ub0poYkl3c2hWSGFzaTFVMHMyUVZL?=
 =?utf-8?B?Q0JPWkVPcDNyZHA5Z01CUXR1c29lWW1EOFVVSzFHa3Y4TFpuTUdyZnlEd0VI?=
 =?utf-8?B?NWsvWlE5bUNwMjM2SFNmdWV2TnM4VEY1aFE5Tk9FcS96VjBEbUJDWW1DaUxt?=
 =?utf-8?B?TjVCOER4Z0NMemFZaWplOUtwRHRvU1RPMW5XRExUb0ZaOEFOQ1FDbi82TXBm?=
 =?utf-8?B?K05nblI1dHl0VDdtcm0wdlcwaWI0djlyL01nNVJtaU9TQVNFNTVuSmJDY0RD?=
 =?utf-8?B?SWE0Vmd1UzRuMU5HYXJ5aWJva3ZTOEpoazZRay9NQzRWdkwzL0k5U0xEN2VQ?=
 =?utf-8?B?NVNwZVR2bFJLWGl0K3hpVmVCY0Y4a1BlU0pSZ0g0dElJaDhxOWwyYnFoTncw?=
 =?utf-8?B?c0t5TGR3RXhFL09UaTZvQ25UM0hrYkhTSHgzbmNZQUpaK1h1Zm5wOXZKNHJi?=
 =?utf-8?B?MlNwQnRoMnUySmpNbHdtZlNKN2JzZFVHZlAzbWRSTzRySkthTndoK2lMOFg2?=
 =?utf-8?B?MGU1TnZLbjZRempqVi9iUHo5VGcrakVLUXZRRC9PVjhxdVBoRG9hbmxVWkhk?=
 =?utf-8?B?NWtPLzBsYkZXTit5b2FNWThsaWxoM2o2ZDByVDJuYnhkbjlsWXpyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c443441e-1f0f-4451-51e1-08de9a59933a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:11:04.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es5/Xn9dPXAJGwQmGFeCPoF9ytJpdzTmYnfBu3qGwQ4stN1pw5hriu+/fyWCd9yCqEbUaZGwLYWXMnTh1wiXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
	TAGGED_FROM(0.00)[bounces-3304-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 675203FDED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Specify that data (fulldata) mode is now supporting alongside rsvp when
using --clean={data|rsvp}.

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

