Return-Path: <linux-erofs+bounces-2309-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ42NU4HjmkT+wAAu9opvQ
	(envelope-from <linux-erofs+bounces-2309-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 18:01:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8BA12FC0C
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 18:00:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBhQ735B5z2yFm;
	Fri, 13 Feb 2026 04:00:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770915647;
	cv=pass; b=J9s7g2qXnDwmstP64Q08HocFEps3u7mor8O+uyJd3rjYG78wws4HjAisbc3Elkv2KYeSZeboSLd/gjsr6kUiRRIKlGEC3FR0CtGf3AlCknULSVK/votgrPv9EBJai4SUMZ6ECxVIkh/GjK34FRyBXsDGR0lywY+1fTc6U75s08uqjQLVRUHt5MjDYlVp3blaDcKp8hS5EbJVhCLPZ+96bNoJiHXUep50wXHfjswWBQ/Tw/dkj1r/XrIpj1XwErLFboX5jXBL4wfqNyHvb0gSjGH2PWDu71PdLG6RUfVLon86/6vRd7KzT+dcvXeGI5zZy+F1mcvXLu1NEe57QhLTDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770915647; c=relaxed/relaxed;
	bh=DpS4MGgpPsea9pamEitsltuQ9b9e6z1FlbaFEsBJTQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBpdUB1HZqnY71C6gFYVdxJJ11PTX2OYR37dx7UPjXGwWbdxK6QYgWSiSLm9oZ4D0Yh6yCTIOF6iigTKVrw2+1yE2haRRtTqyydXcJucS2Iu0ktqjzlOzbsvun3IQ4wt9juvRZZYBucYt4WnfD9hs0wft5zwZITEGnhB5w38nk9HhXfCWxi2dd3WpJjJk10HyK6LzZUuW9lDgoeNXi2Naen+za/0Q8RaiKNsaYoJcEL0xWgpe6xv9tFEIhQAsF/KljmYrxvhF0IBMJgH1yekaiciZ8M1B+WRiIKZ8YZO3OVogQbvjzhGN3K0o3o1zX+daZBcQmerVytygfRhEjbWRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iPvmq4Bg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iPvmq4Bg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBhQ64z0Tz2xHX
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 04:00:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6n13/ApCdhHt0vZGDDg2AIHP5+k+SEU4gOSsPjbHSM6aa5JBaVAUdNL+QNPpPt1CyRbfrnKrDblFHers7O+S9mzLsRHpzEnxjHo19i2lfBupw4W+uPoFXKc0r8oAW/0yWpWYz3iKnjrx+BQDU6M7CUAU6D48RCBxKvHAFW6vRcUm7xs588zRq67pBjQLZZzD5YRq8gY4dX2dcCQtkjDKSlrj4JvJifCV31EQG+S5QIQXKVEit66/4m7ByzaGdGzY9kRGVgX8cv5JxxLB8OHE1R9P5E1JCe7k70OERPrkqpij3cgww9u6xHFd1tn5veOpKtlj4uWHnkBSiwhWqLJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpS4MGgpPsea9pamEitsltuQ9b9e6z1FlbaFEsBJTQQ=;
 b=BfRsizu/01jXHAApPO8M0TG/D49V1KhHs2MNPT4CpIloZt/wxH5ssPy6U1xmRCnhhx1c8Vpa+31Ctm+6XhILMBwJ0qLIe+yYzsER+rF+uzaae5aR522gdoD9Kr3gxAu93EK168rGjegb8dQPNw8OoMOL4SZaJXLBYfxhHJ8Zg0tQrQAzyeljOg3O5JqI1goM64+DtPvH6NE0Z8bHU1dm+mSqB+fURSmJkczXoWDyGmMs2aCCXYE+hiS7Gqg6mY3MJIzrcwmBizLQumJaEPCYU0xg7GcNUTlJttmRpPQql8wl6/+ifaqjt288e0jMjpPx9CB5VEHc3WISh5zdmegqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpS4MGgpPsea9pamEitsltuQ9b9e6z1FlbaFEsBJTQQ=;
 b=iPvmq4BgBQ4IUMOSWmw7DocPhVW7vSo3AiMUGfJeMYpYVlxsQr/32bjVnCpoyQV6s7bluBVaWxjvJN0w7zau9tiqAEIObIugmJ0lGYvecVsfBCeXkqzVKGV4XMVCu6o5nL3udGRYo5vVrmnQb/yTIDzqOBrqtGotwqlkMtjPlmMmjaGt47EL0HYjveKDN+ftgb2hOB3umJM8M64V3mSPGdsLsqNFYUyqIOY8ZK3s6EIV8gNWmV+LRIeBKcExoDF7cHfcJldmQNUwSOwy8EvknCJ79XfcOUm/bhU3hLdT9RjkkuqvpeOcItGw82W2JNvQBqt3Q5cjCkxnL0VDFZ9w+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:00:21 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:00:21 +0000
Date: Thu, 12 Feb 2026 09:00:18 -0800
From: Jonathan Calmels <jcalmels@nvidia.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Subject: Re: [PATCH] erofs-utils: lib: relax erofs_write_device_table()
 device table check
Message-ID: <aY4EXe96VKXsCb8R@nvidia.com>
References: <20260212001302.72193-2-jcalmels@nvidia.com>
 <a4712179-0675-464d-8991-301e260f15bb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4712179-0675-464d-8991-301e260f15bb@linux.alibaba.com>
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To CH2PR12MB4969.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: ff526ab7-1c47-4d00-e3ce-08de6a5834d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci9mQktJMjcrQkE0VG93MTlXQWVDeHA5OTI5bmxndVFSSTBLeHorSDdjSTZO?=
 =?utf-8?B?L0d5SnVZbXFHeUZLMkQ2elBna0wzSy96L2NBdUdsMVNJN1JFeSsyWlFZSCtn?=
 =?utf-8?B?TE0ra0VDaGxKc2drWVEwd0RJb1Rpb241SVJ6SEZFU3JucjEyU0E4T2NXdHhr?=
 =?utf-8?B?OXRla0xDTGwra0dLTVd0czhsK3dDTzJSejhaS3Ezb1NlaXB1VDR2SWJBZzBp?=
 =?utf-8?B?blA5TXM0OVFoei9hcXhzRk9mbFZHWFJDUnpiZ1pJT2tGWU95K0lrUzNIaGxL?=
 =?utf-8?B?M3JGSVBLT1gwcTdJMW44aHV2MTN3Ly9XR0pCMUE3REpmU2hyMWxRaXdKdkoy?=
 =?utf-8?B?aHNsNFk0andEVjhZOThweVNnbnlRZ0hxbXNEMm5KODlSUGc3QWZFYTd2aUx4?=
 =?utf-8?B?TisybEFUVDJIRnIvWHZQVXMxbHdMVEZHK0FkWDd0cysyOVlHd3VlL0Z5NzNE?=
 =?utf-8?B?RkdqRGlDRCswdW1jQ1VZZmVwN1lCa3RnaGVOZFhnTGdQSzdsTzlmSjlwVW94?=
 =?utf-8?B?STRoUnJSM3ZwT0QycGZrRWRoSVdUT0hoOWJ1ZkV3QkFWOWVYSWV6Qy90eDFz?=
 =?utf-8?B?djJIVmFNLzBka1o0UVFzT3krQ1ZNaU1HN2VMZTJDbzlWbG9xc0FDbDJhdHVu?=
 =?utf-8?B?Um50YW05QUgyejVLeHhZdTMxQTM3SU0vQTRTRnVvdU9uQzRMemZRZ0hoc3Zv?=
 =?utf-8?B?YmJkZU9iR3FSOWJ3Mm5rTUpyQUtQbVg2L2FGTFkxeUlBTVZXeHFDWXVmUFFs?=
 =?utf-8?B?cnRvS1d2TmRlWHNFMFhteU1QMkJ2WUpxcTJPeE5TcXowTTRxUHNpYTMyb2J0?=
 =?utf-8?B?Q0tQTW1XaDVtekE3MmNlcDc3U2kyZXkvd3FOSmErbnJ6dzI1YWJlcHV4VUxO?=
 =?utf-8?B?L0p0SGRWN2xROHVEaENZLzQ3TVZEQmtEVkNYcHpCTW5ndkk3UTJXQ0xFb0Y5?=
 =?utf-8?B?QzA3cnNpV3NtRWNkbjlpQ08zckJ3b1NuNlRNU1Y4b3RnYVJPR1ovZWFKalFY?=
 =?utf-8?B?eU9qbVc4TzJCQTFIOHhQZmxqSW13dnJudHZDbjRSN0ZWQ2crbk4zNEZobGZq?=
 =?utf-8?B?aTJiWndYQW04TytkRm5nYUszODNOMFZXNVpvOUJ0RGZadE9IQWZVd2Y2Rzll?=
 =?utf-8?B?bks0KzdEcEhQemlnSjRKZk5PQ1FqK1ZEVjJpczJxSzRMb1VxSWc5UU5oS3ZJ?=
 =?utf-8?B?d2k0aWpiMGZwZ3hOWnFwYy8xU2U0cWxNSXBIMEpLb1JNcE9nbUZHL0FvNGVJ?=
 =?utf-8?B?ek1peVd6OXlMK0xWQ1ZPOCtLTCsrdHV2Z3I3NTdnNzh6OVBPcWtUdXcvOUNT?=
 =?utf-8?B?SS9FMmVRMkJOTC93UzJ0SXhQTXc0ZytKSjJKZE1GOExQRHJhOHlidTBneEhp?=
 =?utf-8?B?eHRQNmRkS2NoUGRWZlhiS1lKbmNrYmNHemw2ejY2RHZ3bEFVOHFWcDNoMmgy?=
 =?utf-8?B?dExXQ3Uza0g4RjU2OVNGcmV4eXdmQjdUV0VvbklEaU93V1Nic3BSSWptUktJ?=
 =?utf-8?B?T1p3U01yK01ybUFWSmRwMHFNNHhqcHBhWkxQajdDamlLU1VHM2RFK09Mb0lE?=
 =?utf-8?B?S3ZGRjlVVkh6Slcya05hUW8wRGFQRnJRWW03dG1HT1B0aXRValBaSlpuT3RW?=
 =?utf-8?B?MjNXRkFRZDZoMDdrU2Q4WGFqamt5UEdZYzZzYzF6YUhNeldGbGJrNmcrdStH?=
 =?utf-8?B?eGREcHpNUDRBbEFNaWFwZjZyOStZQzc2aVhnWmNhWXg0bisrbGJpUEtTM1pr?=
 =?utf-8?B?Y2ZPOGZnRUpBelcrc05xS2FXaUR0bnVSZm5haUkrQ2JGcDJQalhDdGN3WHhU?=
 =?utf-8?B?ZUx0aGluemxVWUVvTU5iV3hpTjR0NUplQm1QdWREWlhkV204TVNDTkU2ZHpJ?=
 =?utf-8?B?cmNNNCt5U0VSQmdpUnQyMENiUkRCMHFsRE44MWFieUpta2tJUWdqSHRod2pD?=
 =?utf-8?B?anhESnM5YitHSWw2ZmhKUGM5MURnSGFGTDVBNGFURzRtV2JQekNZclREU3Y1?=
 =?utf-8?B?dU1tUjVXbU9qTXZNaVpBSG0wdXZRWDFSU3BpRkQrMVJza0JKMEcxU2V1NEZj?=
 =?utf-8?B?S3N0TnZHMW5IMjV0SnE5Mzl6S0hBYlprUktRUHM1am9QVm11QzNWcUNNbFRG?=
 =?utf-8?Q?hsOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K052WFpTMlRlYk1ENmpVdXhXVzk2R2hlQmoyaEJXekJZazE2ZlRRT3Nva3Ez?=
 =?utf-8?B?YU9TOGorK01Td0NRMk1CVnNzc1ZzRzJoS09OVkFlNENhWW0xdFJqa2QzVEJF?=
 =?utf-8?B?N3hZTVhZb1ZLUGNoQW1QNVU4VFIrdTIzSkZnOHkxS1pISmFsbG11elpVOThI?=
 =?utf-8?B?MFBxZUJ4WldMNUo1bEZzZmh0ZldRRnk0OWxtNnZROVFYRjBNVmpFR1g1Z283?=
 =?utf-8?B?Nzl2MGFyWWxRNjAwRkluWGs0OHZ6V0ZJL21yZmJLWUxoVXRZbkNiakYyaVBu?=
 =?utf-8?B?RnBrVGpUSStxSnIrUzRVYUhLdzhxSnMxNitGOXRMUTZnb2xmTEc4eGdaOVNl?=
 =?utf-8?B?L2RmOGZobWQvbnZXbE95NW9SSnF5ak5ZM24zbmF5dHMvOUs2WmhhTDZvQWJO?=
 =?utf-8?B?UXdVTWV2Vno3cDh4NGFVQThTeE9RWVM2U0VSNUp6OGpCMVpvWWd2dXVNTW9i?=
 =?utf-8?B?UWd2RkJabFErMC9lWDNrSzdVbE1UNVFnOFp0ZzdWaDhmQTlTYTlRdlh4M2U4?=
 =?utf-8?B?TnN5WmlZcHlBNFYyMDlQb3l0NnRHZHJVMlBYSkVSUS8zNXJZR0VKU2EzWmt1?=
 =?utf-8?B?TVRVUEYzaFYrRDBlYytLSm5OcWRkNXVlOFg0c2YxYzM3R3hxK0crTU94bExm?=
 =?utf-8?B?ek10Z2pDYXpOcEVCRlk1NUlOaThQeDVNc05mMk5PNVA2RnNrODVqK1F5YTVD?=
 =?utf-8?B?Q0VkU3pZUnkrQnZJVUFyUTViUEE3b3pBSXB4dTcrbW1UNlNQNjdKb1E2U1d4?=
 =?utf-8?B?OXRMMk8rUTdZbXhvSU5NU2RDbVhLeVJLS044ZlQvYWFyVkozcEJ5V2VYeTJE?=
 =?utf-8?B?NEFOMEcrejJvYXVLV3FGNitjVmFDbG1CMWdCS1JMTWpKUmlTZ3pSTTZualA2?=
 =?utf-8?B?UE9UaVEvZU1lcU5ETG8rMXZ0b1ZCRGx4aVEwS0xiTmI1c1c1VUZHQ1FMbXVx?=
 =?utf-8?B?L3gySHc3TlE3UTBMUTR4UlA3V2dnWXRsUG9DQ1kwNk92MkV6eW1kcXhxR2Rt?=
 =?utf-8?B?WlozQUw4cU16ekd3UFp2Tkd1UW5oa3ZLUnRMSCtaWlRDOStIS2pRc1JDTUJE?=
 =?utf-8?B?eDZiSDZVU2crM1kwdGlHbDFPWlBOY2s1V253clROREk4U1hwVHFTZ2VmdVBS?=
 =?utf-8?B?T1lSU1FrdWl6cEgvYXFNODBLUVhKWk56OFNDTWszTDl6dmcyM3BMbjZxUnBW?=
 =?utf-8?B?dkZXZ1JHMEVaeVkvY1VzM2xMMGh3QTZxV3NsdGRYUXhEOU5MSkYycTVab0pF?=
 =?utf-8?B?QkRRSExVNlZnVEpleGp4YmxFTU84bWtOTzk3VDVvSDd5WjVNZFMzWEpKaHBu?=
 =?utf-8?B?K3ErMEJ3ejlDS2NncFdPWm1ZcmlOVks5V3ZscFMvdU9XZVhrM1A0UmVNRXhD?=
 =?utf-8?B?alVVTEhwK3VLWHZCTU5hUXRNeUNqOHlVbGZPZ3ZBUE1Kd2VYQ0d6bllZNkZ0?=
 =?utf-8?B?NURMeHJpMElaZjJBSUJIOWxDS3hyMEltaDF3WW1rQ0QvQVpYNG1KSXJZMmRL?=
 =?utf-8?B?R3FQN0k5WGVNNU5JZTU3TUkxMFF5SVM1bFpuK3JYd3J1VEYyakNrU2s3NDEr?=
 =?utf-8?B?WnJPWXhQRXl6U3JDQlliSUhka1NQVmc3RHV3OWpMbXpmeXlxbUtTZnF0WmVV?=
 =?utf-8?B?STdXY2RUUkp1anRFcDlJQmVmOG9tc0xwUXJIN0pxTFVzcXNSUEE2ay95eGpL?=
 =?utf-8?B?NjdiKys2UzJhL3NtTHRxb2pjQk93d0hDS2Y0MmtwN1U5NGdia3ZjdS9GNGRZ?=
 =?utf-8?B?eFRQdklqZDhrTG1BcHNWMWRTQmg2UTQrbWhrYlI3T3krZGl6MCtUUlQyblpS?=
 =?utf-8?B?Tm9VbWlNR3N1MThuOCtmWnI0UjFJTWJ0bDl3TlZtdi9pQ0dzZmNJL1d5clZQ?=
 =?utf-8?B?Y1FUdlJSd0p3eDVxam4zY2xTZDJYaFZaM3RaaGxPamVZb2pWSjE2c1llSDZZ?=
 =?utf-8?B?bzM1ajlGQVNXRFVkUExBMGdrTysxSWR1dzZSOENxaHZsS1RoamM0TkRiNkVj?=
 =?utf-8?B?bXFzaXdWdWI5NEMraE9UVTk1L1pERHpwV0tuZ1o4ZDhnNFRZcjlySG1IWk1T?=
 =?utf-8?B?TUN1c1BESGZoSnJRYzgrbHovbllnME5TenpXUkhDajdZZUJ5OVhRdHR2OTNx?=
 =?utf-8?B?WXdZbHhMS3JNTnZtYlZrTkdkSE1ZcjRBZUVQMEFSaC9uVkh4NjRENVlQYnE4?=
 =?utf-8?B?eEVYVUEvUkMzaE1vVndjMDVjVndaSlZ2U1VNTHdBVG91eXRKVlRsdGxTdjlp?=
 =?utf-8?B?MytNa3BSVjJabWs2SERmNFVYU3lPVHpaellxa1Nkam5FZzBmNUt6WEpzTnQr?=
 =?utf-8?B?czl5WUNYaFgybisyT211VXIwa3pSbDhyU0tDVTJnb056NUJlalE2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff526ab7-1c47-4d00-e3ce-08de6a5834d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:00:21.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g67budS3gyN3dHmCgxDOgZjiVBGBGGtNtod8GpX9eqPd0ahGdfMi2TZbFtRvxVntp+V9UBaLFF1gr4xqzlfibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2309-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[117.38.213.112.asn.rspamd.com:query timed out];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jcalmels.nvidia.com:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0E8BA12FC0C
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 05:13:31PM +0800, Gao Xiang wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Jonathan,
> 
> On 2026/2/12 08:13, Jonathan Calmels wrote:
> > Avoid returning an error in erofs_write_device_table()
> > if a new device slot table hasn't been allocated.
> > Rationale is to allow erofs_importer_flush_all() to succeed when
> > dealing with images with pre-existing device slots.
> > 
> > Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>
> 
> Thanks for the patch, could you elaborate how to use this?
> 
> A detailed command line usage would be better.
> 
> (Also honestly I will try to release erofs-utils 1.9 in
>  a few days for the upcoming ubuntu LTS, so I have to
>  finish erofs fsmerge feature for compression layout
>  after the version is released...)
> 
> Thanks,
> Gao Xiang

I'm relying on the library not the CLI, I think the equivalent would be:

mkfs.erofs -Efragments,noinline_data,ztailpacking a.erofs a/
mkfs.erofs -Efragments,noinline_data,ztailpacking b.erofs b/
mkfs.erofs merged.erofs a.erofs b.erofs
mkfs.erofs --incremental=data merged.erofs c/

It does seem to work as expected after the patch, but let me know if I
missed anything.

Thanks

> > ---
> >   lib/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/super.c b/lib/super.c
> > index a203f96..d38396f 100644
> > --- a/lib/super.c
> > +++ b/lib/super.c
> > @@ -392,7 +392,7 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
> >       if (!sbi->extra_devices)
> >               goto out;
> >       if (!bh)
> > -             return -EINVAL;
> > +             goto out;
> > 
> >       pos = erofs_btell(bh, false);
> >       if (pos == EROFS_NULL_ADDR) {
> 

