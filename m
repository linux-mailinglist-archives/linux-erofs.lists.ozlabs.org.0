Return-Path: <linux-erofs+bounces-3303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNm8B3GR3mmqFwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 684463FDECA
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwDQy6fzMz2xlh;
	Wed, 15 Apr 2026 05:11:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776193898;
	cv=pass; b=nGqT/UuTbvssIecnukqb/1rWe/RbsGhnMv1vTjEK7SZNwhUHcUGeSStiY/BAirfbVSCQwcA+grHrWlngg3yk5k98xmr7UOn/dSFXJq2eHnvL5HvymhtM09MzZWbZczCSh1QPgt5lnD4Kshb6vGXbuIhHOSRgXqFoqQy4kobgMI/bgBXG6OgIz7fNOcO88JK2TMKQDeAeNtFoqtOERgP0DSxng5IPtmLMCzkYbjABHU2uMZMcYxDkVh5tiCvPvkAgS4xq9rI8Lbl6lmrcdRq4s0gtH2kTV1grLAxurpBjqkYlkaA1Ema6WVv41dTEbsZiqgTiMaDDgWBUwdHN+hQoEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776193898; c=relaxed/relaxed;
	bh=JCFoJnF7l8imCl63XgBJgh99MNbo2zNMElWH+RC9OFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTkdAS1gx6rxwcl67DL4WTHMwgeJKJtYzEKhidmMbwIuFtGXN7/PR1GJQb9I6PqrZxbxf3yyDwre+jNU2v3gu1dn2DEec8QB6MI4UEnZeZH3NNtfET2tmTj5tnOWaVQy+MTqOYNt015GG8RfUhRKCxXSZrgaRbVBkXlWq3/zGeqQDuS+cWkDY2JTSN51PtshoHC718dZ0UE8+sXVpnMKvxdiELyLb1pVtkSRJ78duCLq23FiROBsNBNsvXcQvy7vGS1ytW5smrdyU3E35uTubBbPaDK1jtkf64I4SUqcMDq8fb6jY8+O/NE03LfA490hDU+Kg50lgma9X74ABfryLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LiH1IHTu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LiH1IHTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwDQy0LXLz2ydn
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 05:11:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiyBDnl4i0zOoRTY0bM2P/9gf6saixqi92Amw8TpXSn8PNu8swL/oKayMfHtJNfBTUha7QfGy02IAW7vi7PA/JSb0W3c5Dd3cvzbxmmKnmpjp3kAef1eld3lzitIuwjbfAkfTPlFRfV6LN+9R7d2PLb3FhO6YHw+nbytXQJACMgP0tKqQI6pumJ74ZXpk2pIqS0FwAkEK22HfXUTlPWdM7RTI757rzioEVkGPKvHfqHrAOMX63XIFHYybyUOKE2+y44MMbeX/WQNb64QVNPsR3Viu9uhoGkDNguNcqwcSofg6vSJ4xut0RDbQKf6eQ+00se8l1yHS8XX9jeYek04TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCFoJnF7l8imCl63XgBJgh99MNbo2zNMElWH+RC9OFI=;
 b=AJ6bleuecdRmaiw5ia/LkdamMvIPE5LY2boRNhHwpTcpKSVLv84zV/jd4cQOmKpOYaFF8RwNjn5rBEpo/oiXUHSsXIxA9XsWim7jMpYN/5E+m1vo45yhFllduzM/6DmpIUVp0Bg3P0xjKoU69z3Yoa4IppwBzSbEownVIGHFkKXLDbxffA0SGoexkhGCD2145mvHQLQTs2b4jaf8XiqAz6oImoznPdSPDZrBPZ3ENmBZvND0zAAjO56ceBfzLuI+8LgJ0My3sJwrqjNi+tt8GJOBo02enxKr5dbgsVoRGPNSYgQ7H1527ju2iNM1GvovgHg7aUfvinGlJT5JMInByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCFoJnF7l8imCl63XgBJgh99MNbo2zNMElWH+RC9OFI=;
 b=LiH1IHTuCeY8WXXwLddusBBcLSnSfg8qePoYKEyUyjJyTPxVd7AacetBZa8YtjsgKTtrlaK8D4R2uHyw8dMzmxWuFhainRGUM00j3DyFrDd+0M0bVIby3g/HR0OctH4NqCuSAC+N5a1o+U3mBaXzPX3aUnqyFRiLHShU1Zq3XW3/6wRrK4/7aPfivL0ebVv9Ru3K/xFCkvmR4+Uzdfuzf0faFKpYU9aSKVmyomus5sbefGIEYu9clnB6TQPoOHxpGpH+KABzCRqa88rQsSrDnxrSOG5sY+DZRMva/B9o9MuuqmIuOpSfyn6oHZgwqLSl6Pr7c6oC0FLoCxi4Mrtnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:11:06 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 19:11:06 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v3 2/4] erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
Date: Tue, 14 Apr 2026 15:10:40 -0400
Message-ID: <20260414-merge-fs-v3-2-266bd1367fd2@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cf2ddaf-2fda-4c9e-180d-08de9a599245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oVwwgu17r2ycwA+W9Ey8dM3bp21woq0X0UzjPLx9JLMI9ne+K326BV6Iw7oJWNTV1IVVvPIuYSiN+6PwTwZKWmxR+6HN7FJeiG/32fdnWm7bIG+o3jyRd5D1R3pLeYr0U2UCy3vrM8QupW8N37xkPk2m9dL3CGEpVuq25bDiXb1j8rFiTOcdEA5MgvxIkOddC1ZGDLY2qStV25/flnmbRpR+uEaVSLq8Vpg4DsEiOUBqOP8j2hljLnUn7j0SvAY3wwUkEjvdpziGrEltZkeXat5/85lSwRPmmQtSo09XfMgRXerFQhjlqwalKB5sOFvmQbrGlnn9JEEM+sU3gBWD2190XUV/ngxhS2QqvOTBYD+074LQfqagygQpJKmg9isurmfqbwPbSWoGBnjNhAJ9tw2XzHj9zvkZgS2yG8h/MeXSFL9OUpGs+5gYUNz2/eBAHdSvcJ3RA407o0oa2pszMrYJUZa2/WFn6Y/2B03ymshs5itDD9If3/98XREN+BAxa8R70vCoYTLxbpcIhxkbT8++FFW+s5rFrUPpCx+fIHi1FJ+56ZjkuNUPztu/7IJ0229jSTV5vA2WBU6+sDoMnQbln2V83dq5JiMOrRPLu05Ct/kLzTmICtmdJXuLFHG9WDLiJt6loEbbpVCdUwKpHPVsShBBunszlmR17tWIbn7JmdJpwqhEiti/DfFTV3e2onG35U7nsSZHzhyorgXV1WkSej4YIpZaBanZRV/BWn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3pDYVRRcWtCelBRK0JzUjBLMG9XblkrSFRqdENKV3FMVW5EWW80Ty85bVZz?=
 =?utf-8?B?QXNoZUpwbGtaVWx1bysyNThDRi9NWlU2M1pzU0xJYjZMMHQzVHVwTkRlREdF?=
 =?utf-8?B?dmFpNW9LSjByNzI5RWc2d1NJRE9FRnZjWHIvZzllcnNHQTlldUFteE1DT29C?=
 =?utf-8?B?cVcvaC9tUnhFcTNuSDM4K1lXYStVTlZiZFBrRUIzR2l5WThJTDh2cTVVbEd0?=
 =?utf-8?B?NXliUUdvOEZVTC9SaDhkRndMaHRiTElqd3hqcFMzZFVOZEwyRFhxN3REWmZo?=
 =?utf-8?B?SzRzeWkyb1c5d1NZMzVwQmp0dkxtVHBVYUI4WmNNTW54RHowZ0lpMVVTNm9X?=
 =?utf-8?B?U1pNdjdTeEZ4NzRnRHdpVTZSYmVMVHFMdSs3WHRtQkVMc0ZxRmI0RFhDWkxm?=
 =?utf-8?B?STFQeVAvbGRFVG9ZaE0xZHVzZE5KWEdtRWQ4N1NQOU02QTJxU0wrY0ZvcmNt?=
 =?utf-8?B?YVgrd3EwM1RFYmZSQzhaeGc1TmcyMXViVmVvcmEwaHNyeVlyYUVxUGh0Zlho?=
 =?utf-8?B?RVo1ZVRITXQ3SThUa21DeURnZGd5WFNobnRja3BPelRiUjdjblptUFNwS3py?=
 =?utf-8?B?TjFYVngyYUxzL3IvTTNuSE5rQk5xdEtKMkU4YWhUbEhUK0x3UmhZdzlUR2hh?=
 =?utf-8?B?MkozVXJxbjdNUXlPSWtXY3h1MERvNFV5NEhoS2dWK21vSkgwbzF0YlA4c0VC?=
 =?utf-8?B?Mk5wakUxYUU2d0ZGS0JkdDFtM0UzcE5kbVBteHNPV3FmOFpXdGV6SDZFWk1G?=
 =?utf-8?B?cG0xWHkxY2Z6SjdZL0pIOU1BTEs3T0I1RnoxTVdlKzFuYi9meVFQOTFWT2tU?=
 =?utf-8?B?OE94ZTMybE5ieE9xWUdSN3JoaisxTnhub0lxeVEwcGxpTk9sRzBKS2NML3VI?=
 =?utf-8?B?R1BpT2kvV1E5dG5LL0pNbGpiUFN6V1ZQOUtPY1ArM0oxZERkQ2ZVeHJGWWFx?=
 =?utf-8?B?Uk5DUVJWak9QaHJucUdxZXVsc1FZTEJrZG80ZnNndFZEYTBJN1RwSE8vTHF2?=
 =?utf-8?B?T1lTbS9ZQWNNNitjOHl6Q0JzLzg2TG0zZVMwSHlUSVpHQ0V3ekRsQ3pwbm9p?=
 =?utf-8?B?Q0Nscmxzb05EWWpubkh5WXhCbW9YWUZJTmJhV2sySWVwejBMeG1MUXpVZG54?=
 =?utf-8?B?NWVLYkt6aUZwSWI0cFBOTkN2RVdVNVpyTlR3WUZuODJheTZWaTUyREpnTUNJ?=
 =?utf-8?B?bGdDTHE2ejROdlVockF5VWtPNUhqNHphSjFOSWNTQ2tvVHNYei9jeFR1MDBt?=
 =?utf-8?B?TWdQRkM4WWJnSTZSQ2R0cTBuQjBpZlBHQlJSU0twVzNyczRocUJoNEZhb1JS?=
 =?utf-8?B?OHR0dFozNUNKdVlRdVpjS2xWdm96ZlFjTUN0YkxINnFVRG9ZaGVLWlRrcUMz?=
 =?utf-8?B?U0F0b3NIZE5pT0FrVjVzRFZSY3RjV2ZWelBtMXJpMk1Ea1BTLzVjL2RiQXRT?=
 =?utf-8?B?T2duTm9ZbUF2ekVrZGh1QldUU1FWYWFQK3Jsd2krdE5vNXZHQjMzdmQzRzJ3?=
 =?utf-8?B?dWRCb0FEZ01aQVdvU0wvMmRvOXhuZ1Q5SXpjcDRmTUg4QTlOK2xCQXZUVEdv?=
 =?utf-8?B?TW9rdVlEelR1N2hiaStrallWdmsyN3RHd1YveGp6Uk10Z3R2ZHBuWUMzTTVs?=
 =?utf-8?B?SnFNVlRUOE1Pbjl5VUl2RFBQd0U1L05mZ3JZQVJrZStuRFp4bG5VdDZPU3Nl?=
 =?utf-8?B?S2I3ckVxTStPb1pHa1BONGZhWmh1UXJNTEU4N1NuMUFEWmRIa3g5Y0xnNkQ4?=
 =?utf-8?B?dEFrMjQxTnpaRFB5cTRSNmNCbFlQNWh0b2VyTUw0RVdoUk16TCtKaTVQQXhn?=
 =?utf-8?B?R2dHK3dXOWlmdTAvVjFpemZPZWZZcDh2UDBkZ0o2SVJES28rbWFralpOVDUr?=
 =?utf-8?B?dnlBMnRNaXl1cHlYUU4valhKQVltdGd2U3I4RjJ6NERjU1hCU3lCaWVVd096?=
 =?utf-8?B?aEFmZ2RhK3ZLenpINFlTU0pManA2Z25xOUk1VDZWbWlKdThkN2tEWGw0cnV1?=
 =?utf-8?B?RzhlUVpIWS92WjN6dnBWY2RQZjJqU2h5cTNZZC96bmh3WGdFUFRYbllmOWwy?=
 =?utf-8?B?VVo1eEUxeWdFZ1BsVm1nU2poZXhSdlY5a1VZTHgxbWtJNFNJZjFwVmRSVlFh?=
 =?utf-8?B?NUpyNlAvQk1TSmlENk8zcURIT085L0c4Vm5zNVV5Y2pucm10empWWENmZXI0?=
 =?utf-8?B?QkRuUTQwZ0U1N3hVL2hybnQyUFU5eExDc0puWnNvazZQcmdUTVVuNkdjNGlv?=
 =?utf-8?B?cGx6TVlWM09meVVJMFk1WkJQVmFqTm5CVkZxeVBMTy9kWmVwbU83eVZkU0hS?=
 =?utf-8?B?MWJRSEdiWVFzanl3TENYbFU1ZFJnQW5iblVVKzdyZG15R25ib1NSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf2ddaf-2fda-4c9e-180d-08de9a599245
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:11:03.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIduJs5WgqTsGCt8ahDhDkVhndepqXE2U2QK7hEY4becOkBEaepnVwKWJlHeiHJ2Qi1623BEiccKwtOlt8bsrA==
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
	TAGGED_FROM(0.00)[bounces-3303-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 684463FDECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helper function for converting uuid to tag.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/liberofs_uuid.h |  1 +
 lib/uuid_unparse.c  | 16 +++++++++++++++-
 mkfs/main.c         | 11 +----------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
index e8bb1be9..1a2a067a 100644
--- a/lib/liberofs_uuid.h
+++ b/lib/liberofs_uuid.h
@@ -4,6 +4,7 @@
 
 void erofs_uuid_generate(unsigned char *out);
 void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
+void erofs_uuid_unparse_as_tag(const unsigned char *buf, char *out);
 int erofs_uuid_parse(const char *in, unsigned char *uu);
 
 #endif
diff --git a/lib/uuid_unparse.c b/lib/uuid_unparse.c
index 890acda8..53e5f936 100644
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
index 5006f76f..6867478b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1788,16 +1788,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
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

