Return-Path: <linux-erofs+bounces-3250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAApCcrk12ndUQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:41:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA03CE3EA
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:41:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs6gB3VZgz2yT0;
	Fri, 10 Apr 2026 03:41:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775756486;
	cv=pass; b=N/3+pdzyLryGQNgdyrcTxT6ZrDqSJR9xiNb48w5WmhicpP3vCmBoMVPld06EJLD3jXbUi+mju/xmrJdHC02b2/x2/KlQsLZfTOhyz3LN7PmgRKHDSSEI8uykyXOxGoNx2Vlv8tlnFSA3KLS7WlHVMSECpHDsWtj5COGxe0Fl0EHW2UpqGTpFVJNi7pKbrufLLr0z3CfjhwVs+dh6wMXWEImhSeVrM40fLF3MW2ptqXE0T+3JCGJrZlcWGIAAK8/hReYwZRD3nXF+9Tz8jv6AVuaDovUhsLwBVoVLTMFOoxFDPnaLvsTat5pZ7y7I7Oe/QPadbC5+lsl3h9v8JIMYvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775756486; c=relaxed/relaxed;
	bh=B0k1SAhkh79tan067iDA/VlPOZxf7coxUoj00QVkRRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifQAumAurYN5pYehOx36YPADSuU4AM3x4RT97boqGbjQEoSfmMskmHzo8lZVde8itJIsIvOERXHaeGe3pjUMXJK1M+5zjOtZx9sOSAy9kuEFIEr8shY9SUGSB6B3ZK5bd2RZ9gj89G8GDLUmsckekE14XzjyokyxTO78wle1niaBzrE7e6BGPcr9jbg1nsYTeCLCXZFjxiyktkpQZqqCayw2w4tsZtHJpFYQ3Lcy5DnYe8JFlD5TMTZYx0RQFVAstlN0sx04IoczQimZ33K4gnCbLD4LgFOCiS4vBZfGUcVRiwuOUw1SagEs5B34pWh0TEUOqkpUWWpre3qNyY9yNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lUOaOME+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lUOaOME+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs6g83Jbqz2xpn
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 03:41:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC0UKt3dDRmqYuzpZRbh3E5PFn6XH4yvTaPwHS2CHgj9ZSUA/5EQKuzjEdD5cV+3m5TeksqTsANIgYyhLvgM0A20MFbI/bQwOEtjyNJCZpdrHs6tJdcFmJ45IAsA1Qx1elvhkohTN2Onjo6cKpByMU8IC3/nUCyNN0760yucL+ogCB1EDZ4d9vOwb7h2LHq/WSX8hdLQKOdy8CUwhAgtQxCOFiib4kjXAha4aRnxSjZZRsA+QweqCHKpKvBqTR1z9jiXX9P8B5r1FG6qejdRzqxpoUyKsIy26IvHoL1li1GRjlodie61bqzxZXfOv3KTK7JqR/h8SMotYpfYE6GWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0k1SAhkh79tan067iDA/VlPOZxf7coxUoj00QVkRRg=;
 b=CHNHcwTTD56xkumh7nl4dJLocDPVkYfshwVsbD9ZtXdpmxidMH8xsPv1uTC9Po2aPhy0QN3mRwU9V9vsrajUqfdzjz2NBQ4oCpG1kD3SQbaLCsH6NLzgDqC4PN3nlTap4G3N/zuMD/nDFerjWUuSNfqqp1jSKQQqbgvqWBBrDJmgLQwE0ajoIotbJE/um//ST5QBeTWY9tGSnC1b28JxdwHFcOJLZtaM3d7dD/SDpCCZRwnnhyZUktPVE5nvA9vCftjB8f4sgf2q2+xgyNBiN1yajMtQJEVLLUzgA2bSFyaZXXAWqVz541JAxDGkkFhB+HZ7Y8wWF+9Gi6d0mayhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0k1SAhkh79tan067iDA/VlPOZxf7coxUoj00QVkRRg=;
 b=lUOaOME+4Rz36QyhO5Fz4rZkPmsSOSsG7cMBVfvIL+Vvlc60Y3UJvbqns2LKpuPPTJU4qAO1LxJLky5iXa4LOjeQkZSJeLTciqgGt7T/iTn4jS3WDnGgFJ/gGgQWfmaow5JycaaT5bV7QSql2VIG4mZAi5ghFMmPnf0DrsIa+J/jaVfq0lCdh/Hle/n3BQhu2PluDhd2iwu/hRXuNZ5vpRmg9tuSWNaQuRJS092YKGU12rLdBlvZkcOii05l2dKxMXcmznPYTe5ORBcXlOnpftZ63PXmB0IZLd4PQJKth5/c83Jjkf9oxlF/79BtJ6EYMxbXT3kfw8AG+8VtU54iDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 17:40:53 +0000
Received: from CH0PR12MB8507.namprd12.prod.outlook.com
 ([fe80::dcfa:6986:72e2:eebf]) by CH0PR12MB8507.namprd12.prod.outlook.com
 ([fe80::dcfa:6986:72e2:eebf%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 17:40:53 +0000
Message-ID: <20f5e8cc-f90c-4b42-9716-bfbefc5b1b28@nvidia.com>
Date: Thu, 9 Apr 2026 13:40:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix erofs_sys_lsetxattr() returning positive
 errno
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260407092141.11697-1-zhanxusheng@xiaomi.com>
 <8cf20051-dfa5-4ed3-a52d-6556734830c0@nvidia.com>
 <6e6c5928-6ec3-4735-85ce-64460004eafa@linux.alibaba.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <6e6c5928-6ec3-4735-85ce-64460004eafa@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27)
 To CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
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
X-MS-TrafficTypeDiagnostic: CH0PR12MB8507:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9aa9fc-6c29-4be4-1c43-08de965f25b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	S/Q9RlfBOLFu7u+36nIsRijGc7/EGHqAlC8cEeLXBZ6ACuMOtmlmWofRdOIYQ0X38GPWpUfZ5nuYP+h4vwRX1f95xkoJDwEppfGO0kvV3rT265hhGca7U3aaQJAXy9Jt7bXOCXx6JlTl8Ycji9r+dvdvEZGRumLMfVaZriDdpLUHspoIeWGiOhif32Lgq7zpe3jMBMmF3oePV47Ntj7lHSsi2lI3sa1v1g7B6BBQS4oWEg9QwmC1pFvbkoPXJhNw4mXVqGHuxLybL4kf/3fsbB9D9dfRkcemggWArW+RJv01GskJ0D6cAMURRt+u9noqJlKRLWsh4jEFgyC/wlGPNgCHdYcsdMWsyF51Y7cQrDPIsJ0kzK6WOegqTFzVj8jJh59vsZXEcLRnhYoE2+N9pQemDOSTnCS6fRpNFfKNJflzAAhw6RwOQmwjJhj+JhL1SWRzyv/gtBMaXM9PncB8Ckto50jOaw2daSoQqYNWgvvmUcsdnwOfrxHrbPlvO27rNiZEkA/Z4R4m2O9eBTQ/JKK0GJ8mHNRqxpEy7v1qPBWuXcHCsAd1FdH1+CZi6HJpxrHqOCU45x2nxJRYbpwzj5g2fe83SiESHl6R6DQGIBsefyWiFNkwnRFvpTw4Bj+h+eJWA/TKT5PJFWjvElgK9s7Jf/0FUqPvj08nxZpWs0GSzyO725juqlZGCa5M6Cd2Z4rjPNCEpIlUtrnAEAp4TLnQN2I4G9+0I4IZ4Iw27eI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8507.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy94czZ3dnJtdGhSNVJzQXBKa0VHM3M5V0VLb21ESlp0VWNxanFwelBGVEVJ?=
 =?utf-8?B?UzR2NTB2YUhhTG9DTFppVTdGNTQyalhNSVdmSGticXArRnVuZ2tVSHI2Ty9S?=
 =?utf-8?B?ejEvMVlsT3F3ZEZINHJIaWg3VTVKZUVRUU5meFJCNlRWZ21QOGMvU3dDMGd1?=
 =?utf-8?B?NzN0Uyt6c0FYRm0xd2hwK1NXMDFvWHB2VEI4M2ljbExJK0UySCt6QytBdW9T?=
 =?utf-8?B?M2d0d005U0NqNlAva1hlcHdiUFp4YVQ3RkEydGdBdkJBeTlKNDBiV0cwMFRK?=
 =?utf-8?B?TFJocURYMXhRZkxZUzNUeldJZ3JNTDFuRzRVdWdpeVNIemFVVzkvanRXbEFD?=
 =?utf-8?B?V3psU1N2T2pseklyblBMYnNEa2VXSHhQT1Noejk5OE1MY2trYUtBS1NueDc5?=
 =?utf-8?B?Yy9OdTd0L3UrRi9jUHhHeE1MbWxjZ2dBNkZTbXB0c1NPMTlPaXB4d0szTXJ4?=
 =?utf-8?B?MS9IU2VTSXRTY1Y4QWhMS0U1bmlvWEc5OGszaEYybG1McmlxdHl1enAyY3ZM?=
 =?utf-8?B?VkRnSXdlNnRaVzJBR21MRXFEMEphc3NacHZIc3R2cVU4L1lhRjdPTmJ5N09S?=
 =?utf-8?B?RjdTMWl0NGRDUkxoK2JUanpkdXJYbHdiOFFiZ1NnZVNsVThNWXRWMVcwVEM2?=
 =?utf-8?B?aUpSYXZQV0dtSStHVG51YlRmRlBaN2w1Z2hnT0JFbHpEaFkyRHFRMWdPNE5p?=
 =?utf-8?B?Qy95YXFtUTA1Um9qZkJINldQMWtML0hoMzAvbjlnYnp3dy9HUFJSVXYzdHR2?=
 =?utf-8?B?WTROWVRKc0NlMDhKdC93U3h3eE9LM1k3ekVlOWt6Z1MwRXRzbTJwd2ZsRTln?=
 =?utf-8?B?Y0dFMjFsNHVpUDFFSmw2MTNETWUyRjlZcHBjRFE1K2xwODZ3Z0Jxdmora05h?=
 =?utf-8?B?cnhTamNrYXlPYlo5NWZtamJ2Qnlzc2w3OHgrSlhISllDYzBqWXN2UjBmZVov?=
 =?utf-8?B?ck00U1pYSTJDNUpjdEJzTHUvYitjSDI3SGFHYVoxMmxHYlBHbXFQR3ZWd1Vs?=
 =?utf-8?B?SWY0RTY4Q004cDdqYU0wekZLcktOd3R3RmhzTUpRdDUvU0pSci81dG9XZUpV?=
 =?utf-8?B?LzhLaXNyQXA2SUNtWXN1QnJab0hCS29tS3h2bnJSVStEM0FjRHd5UjVBOVcx?=
 =?utf-8?B?aGd5Sk4wRGhIWmFGN2NnVVUzRUFaVkp6cm9STSs5NWRacGliMnZaUkQ1Qmpq?=
 =?utf-8?B?em9DTGdZOGVHQmZUcWZubEZPWm5UZHpXYU1IN2g0dGRncUQwSXpTOEIvTlZF?=
 =?utf-8?B?TlVUTkdkMTVONTdlWnVtNHNoQ1JvUmtBY0VTeFZ4SDFmbGc4WGxIOXhWbXVK?=
 =?utf-8?B?eXdmcmFRckF3N0ZsNmNLQ1BzZ2xrUkdGOFRCUUJ1YzdTZDlVTkk0U3FQN1dG?=
 =?utf-8?B?YzZacUVadmxHY3dmcVh4Yk1JeUs4TzlZWmVBazh3TFBHbkJvZndrVkZqWmo1?=
 =?utf-8?B?VytYUEtoTG9HNE8zNzBJaC9lT3FncGR0dWgydVc4dDNlY0YzL3hLZ3hYRDVu?=
 =?utf-8?B?dTI3RVFQbnF4YTEwY3Y0TFVpQzdqVkxDMHR0dGdjNVFjTHF6VU9YKzdodFVm?=
 =?utf-8?B?L0JwT3ZEaDJmYXFXTW8xNTFqVnBibnU2cEJjRGI1TS9GNVpPbXhRMzFOcFI5?=
 =?utf-8?B?VVdmcE43cTBoRzBxOGVibVExaHphS0xzc0grd2o3TVc2WmF2WmxDSENNUGhi?=
 =?utf-8?B?VnhpdFEvQThkNmFUSk84NzgvRGIvNTdMRXRkeXlFM09LS1hFRmlkZ3FIaEZo?=
 =?utf-8?B?S083MVNrS1htY2IvRzh0Q2lnVmIyRGtuZ3h5R2pNalBMK1h3QlNWWlFLd3JQ?=
 =?utf-8?B?Y09zMXdCdTdBbGVKdDNwWmxDZnFaRmN6RW16a0d0L0ZJZi96aDFYdjJjQ3V5?=
 =?utf-8?B?Y0dLeUgySGtCcHM1aWFwSXRpb2lVcEllcUVhNjhTVVNCVENvSUhMNzY3VHB5?=
 =?utf-8?B?RVkyeStvajI4MmVEMkJDdGU5QTVRdmNIbUsvcTdzQnNCR1R3L3JicDRqaEN0?=
 =?utf-8?B?Sk9vOE1jUEZ0NG9UM0VTUmdXV1dmb2g3dlFEOFBzRlJvRE1RTmIyZ2dnZ2VY?=
 =?utf-8?B?a2pES2owbTh2TUd4K3Zla3FqZEtqRTNobUVCdDkweHR4NXlDRVNOUXJ4MUZI?=
 =?utf-8?B?L09rbm1Pa1JSekhaSmJ1WmRPQjlrdzJCL1JiR1dhSXlJaDRxYkJGSWxRWTdm?=
 =?utf-8?B?ZFRSSTk1d2FFSmRkUWgxY1lFOExxZUZhV3NDRmhFVzJQRTJyNXNPZ1pnQnhF?=
 =?utf-8?B?dkJ6L3BmL3VaTE1mR1NBVyttTWR4UWpVdllJUUNuTzkyUWhpMTdoUTFNdnpm?=
 =?utf-8?B?elgzbGlHNS84L3BSMW1GSFB3WWZndFpMWjB6MjBTdHdIamJlTWdaUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9aa9fc-6c29-4be4-1c43-08de965f25b0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8507.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:40:53.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyAzq+gE8KjYciw/poYn9tbYSJc0h5mr8a5ACJQOBhRjRkKe3dqVvYuK6VOCdZQNCmfZ3rECwejU+5KSD76iPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3250-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.alibaba.com,gmail.com];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 40AA03CE3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-09 10:45 a.m., Gao Xiang wrote:
> Hi Lucus,  
>> For consistency with erofs_sys_lgetxattr():
>> -        return errno;
>> +        ret = -errno;
> 
> Thanks for the suggestion, but it has been applied
> to -dev branch, so I have to leave it as-is (I tend
> to avoid rebasing -dev).
> 
> Thanks,
> Gao Xiang
> 
>>
>> Regards,
>> Lucas
> 
No worries, was just a small nit.

