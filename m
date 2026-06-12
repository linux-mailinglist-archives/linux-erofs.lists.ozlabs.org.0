Return-Path: <linux-erofs+bounces-3583-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GlonNTi+K2q3EAQAu9opvQ
	(envelope-from <linux-erofs+bounces-3583-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 10:07:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4D677A40
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 10:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DXJUMm7i;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3583-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3583-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcBv40DvWz2ykX;
	Fri, 12 Jun 2026 18:07:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781251631;
	cv=pass; b=XcJ5YGRY1luRe5d+9kOXOT3oUUQEsAn+MhXlCcPChyQp+1NMB9YHHB1449xXQhPq5yM3IYjx8ZoHn4epwPA8zlcHt/fXIWgFy4La0s/Ue9fUpDC2c4mzD3zvuOZajIW8pT8r4DT2gwOVZtPUr7ynpBb1fmCQop63bLrTB1oVVCkzYuaz9p9uGPXvEEamS5pdKhHRlrJopZhDp6QiC6lxb2mEeLWvAed4C4SdjYA65xP4LCpkZA4lzYUgsRZvP4E/xJJXShbL4iH4r6nV5nkw81U1mrwkmiaigqsqpNoYtqqISZEma4XBwhRQ0wNJUY6VjGmSuD1Pn3xvD/o0C0buWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781251631; c=relaxed/relaxed;
	bh=zrRakkQpjAoO4buYplC89z2JvtyYdH6BUB8tBrgXTWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=La27pMKpR+gzhmTyKyeCT7UkAQKXtGUjTuVOA+fglXFaP7jWnr2OMYoCWJLz/nGntoIEhlVw8f+L/MZwG99zkW3QgL11YFUkUdOd4O1yRZ9Q3iflvwIUQiC+s3+8Yc85SHLMd0l3KaxuGyczizpIl72ni2jj2tX1r71ENwEsya0N1OMBsIYIaRzi7EIccPasHFwn5TEO1mh5zj4fUenZ38JqsckwpfhZdK88dRu9Id/pJjBK3q5YSjCvX8fPUMq+jH+4KHTT7DQSZFEogOToMN7+9Xb6v4dHZENGNUa9XKk6EkEVIseRNgP+3zC3QdD/VY9N61499s9IQamHJTfH3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DXJUMm7i; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcBv252CJz2ySC
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 18:07:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkKKZzcp+2TQuvi12vttQEV5b1jd/TJmAj+0KxeTri9Fz+kzt9apnQsQe5lrzZWhmGKlAqG7RgnDjiLHjtBixTeUqEX/kjUmUdTjfb3v1cczMucsWScO2o9ASjQYFCEPoetubIBrJRnyuZpGRf+RHIH+InPaDkCI68A5tXp1qfokiOr2BQvCg31qMKWxFjQqh/l78j4CSaLLHIItN4oWXIe6mGpVUOZ/UxLmSkQW7rWh2JQbM+ixWtQa9dGYiCAAE/HWcADIK3l1X1h+qaWB47N6e88Dr20/+p5icTEYYhdXTLKdMX1ptzkWUf20RKYV2vDP04PzIeThct0yVSUwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrRakkQpjAoO4buYplC89z2JvtyYdH6BUB8tBrgXTWc=;
 b=mZaZoKMENYj09vTE77BvZ/P1V+423d3t+hK2SKuNbTYZFpPiYTOMrYoTDIjkyM2LZkR95zWoxrohbZGMoDJQ495SgiFQ12C60n5Om4QL/9vtyn1AGzTtaoBSi8zoT0UR0gslsMjDH/8iA6LvqU7Qvo3E8U7+qW+JN5Nuh1IzovRQrC/OQLSkzUmWJJTN+pYQpFUYZDUPPQ9MBmjC4V1DKNr/GzzCnOyGSqlAx0jR+n4qHfhbVib+BRdifTRvfqtjPObzdGuK0zY0q4e0/s821IF3a8QrUCGAM4FlmuKXTdQreiqk9nafh5PEcAoybnkzKhg0+yGNolovWz7fdVaBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrRakkQpjAoO4buYplC89z2JvtyYdH6BUB8tBrgXTWc=;
 b=DXJUMm7i7yZZZ+p3FdYo/5fuTOCI8dCCMZ72GL9m7DCLyFWYaZxIWNZWBYjFp+k4ey+X3VH/aYfuAKB/bEbD4mwA1ylEkXTqvRH809GiGOVB12oxUzIH8ljOtHCGjTYKgFogSxdaWo3c7rIl5ALnI3s/1THkOe60vO99dHKHALbjEnZPkyJMXu4Jn0D66fH3UYhtf2/we4IU4aNtpJ6/IaR+B7cvqVjz9oEnijVQ4tcLQgnOBcYgNIC15u+GHvpq8nt5Iv9wTzunF0fGnERpD6nfu+TgDgV/24HyeahXeGLttFS1HrUc/F2jXbQRVoyRIeexXV5OI2VCXbGya/Jz7Q==
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 08:06:46 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%6]) with mapi id 15.21.0092.011; Fri, 12 Jun 2026
 08:06:46 +0000
Date: Fri, 12 Jun 2026 01:06:43 -0700
From: Jonathan Calmels <jcalmels@nvidia.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH] erofs-utils: lib: separate plain and compressed
 filesystems formally
Message-ID: <aiu9zFNhYaXn_xtk@nvidia.com>
References: <20260611235404.1620899-1-jcalmels@nvidia.com>
 <20260612022001.2665293-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612022001.2665293-1-hsiangkao@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To CH2PR12MB4969.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: c8208834-25de-4a4a-5e95-08dec8598bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iHTqxrWLsKTj9WeUVKOR/bV4j5algra66NziuOyD9DJOPA4Pms2fUTbO86u+QrhATeEPOBiZzi2poRukANTvx2ms34b6eDvlJBAQsIOx27cjP5ajues/WECNVpnE/Io7Ofp8MCtabDi9DB8+Mqnv2KJyAnnZ07p/C3UxDmMou4lsoegFVwQl1IrGA5HMS8qCf1XkS5surbT1UC/XaVOxPVecwBkv/bohGCZfmvDb/UX/Y995JJU9rTj665+ehdxct681c0mLS7bbkQVvw1jCeTZVLx9FBlSKsCEQDh1rrB1khXyzd3UtZZr6RiIBWHRbTvVmNn9mfhY/EpBxEex0tHPBdIAgAwX2xYVatIka/3cpN/CeGbuDvIs65WTqGsBhbrqkEbKgjGps/I1IujIuD5uvn2w35Ob+vLpggDHNM/ldtO4gCk8vnnE81VrIE7wAtf/HOrHM2oLSN8NamcrqYnPzVgT2ZBdCd0RIKkYHCoVEfF/6PuucXknLSPMfhXalPzO19M9pXXbol09/AOOpZcuSsGCQOtyIMphl4LOfD+hNo4Stsx90D8FbKQ4aiK3iThdah/uPxl7j3EcPDk1EWCNZbarpcPi3PDZtVgON+eS6vriEGVqKmoBBPEcE3fKmRrfNahZBOLbSr53TM+HoD5eq5D1Asf1VEoAH7MRmcroxemmaLoFbxzU1yOfiJ0Xk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFodEc5bUpaS3JqQlJDSno0a0k1YlNMc20vV1VqMjBBaUZhR3cveFZFczdm?=
 =?utf-8?B?bWxaUkdZYW5TNXFMRjd6YTJmS1hucWdZRGFLbVBGMC8vUGgwTWdYYVNxSVQy?=
 =?utf-8?B?cWVFanZnVlB6enNWb1ZCcDllQTdRRE0wTVI0L21uUEpWWlpkSzFYc1FZNzRn?=
 =?utf-8?B?R1JKRHB1MXZudGM4WUd3RGJxTENGSWFwdENHMTV3MHBXQk1IR0VpQk1XZmZo?=
 =?utf-8?B?cWR0SFgvTnlBL0ZiM2RJRjFUZGhLdFh2S0ZKQ3IxeWdWcndyM3F1WDdMTlls?=
 =?utf-8?B?YUhDVnQwd1BnTGtqNXgxd0tpT2dyVkJpWkNhek5IYmdVOVdwTjZYdUtYNmIw?=
 =?utf-8?B?TE85Y2FjenpYR1FiSGJPSDNhMXB5VzVRNDVDUXdZa0dqcWpFU2FlTHpIVG52?=
 =?utf-8?B?L3VkR2k4REhrcWFrNnc0TmRKMHlRTGt3aHFSblRuR3JBWEpYK1Z1cDRIVUdx?=
 =?utf-8?B?TzhOZzhONEtENitmWSt5RSs5a1h5d2ZjRkk1QnNCUVJaeEY4Z3Y1THQzdTlt?=
 =?utf-8?B?ZEJFS2VkYUEwOW95dmVQZ3VSV0hPbXdzU2s0RnJUbkt6N1BjazNpWWxHWXZs?=
 =?utf-8?B?aVcyU3UvcEJMc1lnbzV4d0Nyb1l1ZGVZekE3Znd6NVA0QW94VWJOY3ZyVE5m?=
 =?utf-8?B?bUpkakx3b3J4cEd2NVNwUjVuQnQ4bjRTRmJTdHplcDI2SytwelZVaFV2Zk8w?=
 =?utf-8?B?WHNBNHhQQ1kzWjhqN241UlBMT3E0U29aKzRkc29GM0ZWQ0JzWXg5aUZIM2hY?=
 =?utf-8?B?UkcwUjBQN1RaQnFvblFjNXc2MlhXL3BYM3FTOTVlNktLVERqdXdVMFVlb29q?=
 =?utf-8?B?bWowSlhsWVVhSWppTjRQREtVWEw1Z3NsejNDL1dMdE1rRWRZTDAzQ2VEMStt?=
 =?utf-8?B?V2xlem9YYmlIYlVQKzlkVE40VTBCMVpvWXpxSHBtbkhYUFdTcTBaK3hUWVVI?=
 =?utf-8?B?MllnVytnMDl4eFlmbHJaSW1JTU5xV01kanZPZndyUDI4eWl5SklFY0tQNFRY?=
 =?utf-8?B?THFQeU5rdFlCcXlhbUxoWUdLa3cyTm1ncUNvTHJPb0RDL2NIeVM1QU5rbGFi?=
 =?utf-8?B?cWptT0NMdys5REhIbG0zbHZET3F6OVpzSFBYc1kvNDg2amRMMms5bElHemdj?=
 =?utf-8?B?YnZYbGxBT3pHZDlWd3JUOHpEMys2dEVaZWhHazd3d3piYkNKUmFBbnJRNzRa?=
 =?utf-8?B?ekhSeG5KVUVsTGx4Um84N0d1MFpIYTNkOFZDK1lBMnBXcUE0WTNTbllsL2NN?=
 =?utf-8?B?dFdpREdwTHNTdGlLS0pFQ0R5QjJLNVh3eGtzN2liQ0J2d2FGQy84Y2E2dXBw?=
 =?utf-8?B?TTR0YjM5Q00yVWJ2dWltdkRGdHd1ckhsaDltMzVPL3grSE9hNTkrSXdQTERQ?=
 =?utf-8?B?bUpKa2xUWUU3WlFwakZPUTk2WVRzVmJyWHpVWXR4UVdpdzliK3l6VXQwUFJM?=
 =?utf-8?B?cWZLd0hYSjhnNExSZFlEeElJa29yNFMvUHFXZzlMREZZNzMyRXZ3YnVaU2JD?=
 =?utf-8?B?OFdsZXRFblA1SEwzNit5SC9ocEk4UU5yKzlqc0k0YUVhclRDa0crbzMwUGRy?=
 =?utf-8?B?NDdxMDBwMms0NlZvNEo1MGNHSm1mMER4SmtPOGcyRWtrU2V0TTEwVWZ4Q3hH?=
 =?utf-8?B?OFBkemI3RVVyeGpLU2NsbUxFM3BtempEZEViSExwQ05Ld2Q4M1ZmUGNnK24w?=
 =?utf-8?B?aTUrUjNKblA2eDE3N0dnRFZxMzk4SlR0bGtkbXA1Q1IvNTRPTlJuMkhTNS9U?=
 =?utf-8?B?dFpDeHFzbll6MmFkb1c1bTNBVFFib3FZRCt4L3Y2SDN2QXNLYjRPWk16a2RO?=
 =?utf-8?B?L0U5ZDVNMUlMK0E1YmJWdy9mQ04yaFRtajdpdDBXRXllVnk2Vkt0RDBMQTFt?=
 =?utf-8?B?R1BIVnVacnE2UGJBZklwNGwrZHB0dklLLzVGakY3bllMa2pNM0JuRGhPNUlt?=
 =?utf-8?B?eG03MCs1NGRlaVJ2RFFra0hUYklPcGJORm96S3NER1JMNnhySEg3b0FRbU5B?=
 =?utf-8?B?SGRidEdGTmV6ejBCM0Y2bDVETmd5M09EYmlmZE9QbE5oaE1SZHJxMEUwOUlR?=
 =?utf-8?B?WFBSaDlnSkNINjFaZGNzb2xVMzYvK0UvTWYzakk0bG9MUVZLUTRDRW12Z1k0?=
 =?utf-8?B?K0hNcTFtWTVtbHVpdTRZUkcwTnd1TEh3aVBqcjFaRUVpM09yNmk1cnVnYUli?=
 =?utf-8?B?ZzhrR0ZtWE1pa2tqU2sxUFJReHNGMm9zelNmbUwzTzJkSnlkMU4wdjM2TXNY?=
 =?utf-8?B?WjhVbFM5MDNRQUx0cVlpTVdmQlZlbTUxOTlEY1JiWis0UGY0MzhqTGFSMTFO?=
 =?utf-8?B?VWp0bFFBUmViQlMvbkI4K2VKVGpIaTVKMVkxaHBBNlFSVmk2bGNKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8208834-25de-4a4a-5e95-08dec8598bbc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:06:46.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbdq8fgjNOegejaBnAPjzKblWgeQHHjNqnJzFK+0k0paRUbOiwQ0DdO8AktFTcBeDAO064CbTLaeojmDYFlHBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3583-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[nvidia.com:query timed out,lists.ozlabs.org:query timed out,Nvidia.com:query timed out,alibaba.com:query timed out];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER_FORWARDING(0.00)[];
	RBL_SEM_FAIL(0.00)[112.213.38.117:query timed out];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[lists.ozlabs.org:query timed out,nvidia.com:query timed out,Nvidia.com:query timed out,alibaba.com:query timed out];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26B4D677A40

On Fri, Jun 12, 2026 at 10:20:01AM +0800, Gao Xiang wrote:
> External email: Use caution opening links or attachments
> 
> 
> Source kernel commit: 7cef3c8341940febf75db6c25199cd83fb74d52f
> 
> !lz4_0padding is simply an ancient layout which is mainly used for
> Linux kernels < 5.3 (prior to the initial EROFS formal version) and
> generated with the option `-Elegacy-compress` by mkfs.erofs between
> 1.0 and 1.8.x.
> 
> So recently Linux 7.0+ kernels simply use lz4_0padding as another
> indicator of whether it's an (LZ4) compressed filesystem.  Follow
> the new behavior for erofs-utils too to fix an incremental data
> build issue [1].
> 
> Reported-by: Jonathan Calmels <jcalmels@nvidia.com>
> [1] https://lore.kernel.org/r/20260611235404.1620899-1-jcalmels@nvidia.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Jonathan,
> 
> Could you confirm if this issue works for you?
> 
> Thanks,
> Gao Xiang
> 

Yes this approach works too, thanks!

>  lib/decompress.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/decompress.c b/lib/decompress.c
> index d23135e0cd43..e6d14f4cbd94 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -466,17 +466,12 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
>         char *dest = rq->out;
>         char *src = rq->in;
>         char *buff = NULL;
> -       bool support_0padding = false;
>         unsigned int inputmargin = 0;
>         struct erofs_sb_info *sbi = rq->sbi;
> 
> -       if (erofs_sb_has_lz4_0padding(sbi)) {
> -               support_0padding = true;
> -
> -               inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
> -               if (inputmargin >= rq->inputsize)
> -                       return -EFSCORRUPTED;
> -       }
> +       inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
> +       if (inputmargin >= rq->inputsize)
> +               return -EFSCORRUPTED;
> 
>         if (rq->decodedskip) {
>                 buff = malloc(rq->decodedlength);
> @@ -485,7 +480,7 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
>                 dest = buff;
>         }
> 
> -       if (rq->partial_decoding || !support_0padding)
> +       if (rq->partial_decoding)
>                 ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
>                                 rq->inputsize - inputmargin,
>                                 rq->decodedlength, rq->decodedlength);
> @@ -589,7 +584,10 @@ static int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
>                         sbi->lz4.max_pclusterblks = 1;  /* reserved case */
>         } else {
>                 distance = le16_to_cpu(dsb->u1.lz4_max_distance);
> +               if (!distance && !erofs_sb_has_lz4_0padding(sbi))
> +                       return 0;
>                 sbi->lz4.max_pclusterblks = 1;
> +               sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
>         }
>         sbi->lz4.max_distance = distance;
>         return 0;
> @@ -601,10 +599,8 @@ int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
>         erofs_off_t offset;
>         int size, ret = 0;
> 
> -       if (!erofs_sb_has_compr_cfgs(sbi)) {
> -               sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
> +       if (!erofs_sb_has_compr_cfgs(sbi))
>                 return z_erofs_load_lz4_config(sbi, dsb, NULL, 0);
> -       }
> 
>         sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
>         if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> --
> 2.43.5
> 

