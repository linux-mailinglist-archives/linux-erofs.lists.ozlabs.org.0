Return-Path: <linux-erofs+bounces-3312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vhapEAyc32lTWwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4140523D
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 16:09:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwjgV2cPHz2yvY;
	Thu, 16 Apr 2026 00:09:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776262150;
	cv=pass; b=l1skODgYOgJ+7lZB5PZ360ISRQ5G0yVlji0pJbEo0uYqwgHfoaxNh4g+hnlMyokWAUtqVoied+8H5dr33G4FQ9qQvEb0E5a7MbHtwC63mOd96PGSzF4JJJUmfTXddyxqBHHg6nZnOMxFgtxuXwcGUdQ7BDTYTF0yJIWdGMTP+FPlkcoTq7JGLuHvha88dz8Q2oX8CP01JuooEJG8ypClv+GF2KrQuKTDe31YOoTHqN3RgPl0MAtBNMJ+8Mp69CfSRumRxypkvrVho9aPhn9wXzNtnAYjayIeopbEOQFB8dTAaDykNF48fHAidOaGAJK+N36AuehPOXk5pLKZjUbh0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776262150; c=relaxed/relaxed;
	bh=kx2TYbaxJOisUmytoxmkBi69RON3GLC0gqeokSwSdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fUJNYqIKXEe7doPC/S1r/7hnqYWSX7PeNAz0E64LM/ua0zM3FsGOACQclkWH2HtLuUi4b3NzqvqgYikyAveS2vVKS2X1/W/tRsY2GXQOYuI6eDwYb738mVH6PGQDhP5WwOCmdrXynVXxjD1uDrbU5fYZQ3x0p4iW6gRgDoqUEhB6KCWeA5FmLx66AYW3vdhQ7SGWAFjMAdK0Pvcyuqk2yOSwRmnNrmrXHzmNxr6VB8zf/oGd6Xu9ehJ7b/o1/3A3NNQDIlSr1v4EINAvvJb11Yh++N8/EI1NB4llv+MQ9TNlj9K0MJ3Ro8d+lORjuqBdXuhL5OwqbNkVB+d2lETy+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RIpKxBv0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RIpKxBv0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwjgT3h7qz2yvv
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Apr 2026 00:09:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rippnff93nAaj74Ayirh9rehXKCLilcp7fV/k/FnlRAFIMlP28Kg2HGvundHGf97g3EkyJZQoJH/82WNB3jJcerwsgEhIK4Si3CAh42r+I5t3KLAp0lQ80hmPoeA1QPn3CQS8oOFPiC6UyX9CP/lldFqbDgUz3tOm8m0dZ45Q5Nr+fqH+kmuzXSGav8QOVyr9WDOiWblg03sGARUNm2r4yk8o/06TK+s9q7WYr9xhUydzVnunZ9nzp03ZnDGqHoIcsyfMUNiUh4xIgastvSOv++38YnKb5yFOxU60M0FXvfk8HdqQJKtarjbYVc2IqgOd/QOtSS4qLTbIT+N/nyRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx2TYbaxJOisUmytoxmkBi69RON3GLC0gqeokSwSdX4=;
 b=Atpp3xraxNSi0DkXyYCNNuKM8QFxLCbjnmJ+clenBeeamWjvDDbFFd+vebENgPvOT7MIlSPrIhtL6NV12KljvGARXDUNkuKGRncNJ0pbMagob9XDtMAJ8festvwvLcUdUbvHPlahfUeUFtlL83ZzoSjbq5VmhOP3gMJIGDHY8gujawNwRZiorQPLzze2IsfhXHAv9hBHIv3iDlbZoBpb9XhNkcllnYEhTSp4D5Z+PzuWnPXiAMmTCsLHwZArc9dKPaIH3z5HnEC0tEJafa47zvxgnf0XAYpkUme9AzlZRDk7vyoRsrY8MVv7uisLYdEfq15Ak183531OflXQBAj/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx2TYbaxJOisUmytoxmkBi69RON3GLC0gqeokSwSdX4=;
 b=RIpKxBv06F58fL5qFxBMbEBItjn7vi71IAt0/4tB/d9eOgvI+TCWkoBxOvJaAlP53FLUDYhzGLriF8BB4hK1ap5k951cH9ao7CP1fLi7htCC+dSwh1s9nUoKrMDixITQXIOUiBCTiUEPf/lgAlW+rqo1pH7fUEjKAp9iZOv5w6BpEwu1pOK058RE/p/tDLziZLUsa447NNxqpyC9D0TRn/kyWXWKeVjqL8mnSkZeSxcPjkj8wSfbquhququ+yENGLVN3yqZfyOlEEwJHeil7e5MxFXQcgyjtcS1X2ekJVd6nQDgXr/dAKw9TKjSQjCJRbm1D7ovDnjE/kE/WuJfFOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 14:08:39 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 14:08:39 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v4 0/2] erofs-utils: implement the FULLDATA rebuild mode
Date: Wed, 15 Apr 2026 10:08:08 -0400
Message-ID: <20260415-merge-fs-v4-0-4c6860a62255@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-merge-fs-e6231a3a3a1c
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
X-MS-Office365-Filtering-Correlation-Id: 4c24b196-a873-43a0-66cf-08de9af87e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BdxyEXjzKWPG2A2ckV1ynm7iC7DyI8NfP5skCslcDvBngwNRfNBLBr/az4mBasjO4AAyU+5qUwp6aKCmILJ++CnXPqAJ74I4iQjwIGW4iFf0s80p8J1DxlB9OjP5M7+nInnBJ6KLkuAAIOmx1KCxhhaAefm+pF0BWAfIqLOBDGTwNC+LYIeY94ESv8dePbAOhW9D2UZuVLOwMV+dFrzdmpA6ZQVlbkmErrQc3JyjBmc6xY9/5myBsz2DE1DsgRXks+HvN/SgQYq6uXzpq78GePpGjJO+67w+epWAeuqpsClt8XJn/5EONgSb9Nb/yzQQdtcS7JnBJzmip4Z2TDx2skYd1/I8KSosG5rh6BdEouH6Y5mXd0hy35AyJHqqLI/U5eqv51sMpaLvKiKep9RKAgNwOz0tswk3HOM3OTUqye+yNZm1M/R2hY6QsG2TT7FztY0BtY5UbOz6cOUhsuJBhBQBK04w4LMxZv6TFYoLjKDwdaW+3scOTfUEBmIT5XtGtZlq0Efh3N+8iIv5Q/lSHqMvTrL5wkidpk++wv0DhVSZvxdTNGhZTtnPUvg/dUR5XCeJQ4dRTlfOkvx0RvW68G6QRez5NryOulMPAxzrh9jmPcHi/KCHo0jqmnQmneTRNyZ3NM02E6I9oh35lxvpvl9+4Wqh4N8Vp4DxEKIVrE4v1awt5jTIS0DObkQGBp67oa+yViVD3ov34wBBTkfHwfc6GsLMxAXvx7nDFHTh6Ig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1dYTGIzWi92eWd0U3VWa2Y5NkduM28zOFhDaWtac2ZCMXpac1AyMnBmcnlR?=
 =?utf-8?B?dTZYSmNVMHBjZWRrVjhTOGFibDdRRk1kNm1oZXpETDhKSmVRU3BpZzVCZEkr?=
 =?utf-8?B?U3hZbVE0dnEvRklCaldvWlIwdnpydFphRWVPeFdrdVFwd1Z1SlU3OVJRZWNZ?=
 =?utf-8?B?UEd2c2NvTk1BcTB1NW1GNTNndEtSZVc5KzJtbGRnQkl1amt0WlBYZkVCRjdR?=
 =?utf-8?B?UHJ6V2xpeGIxZTJhWjlIRjU1NHMyc2IwUGQrQWs1Y1hlOWR6RTZnR0RPSWFm?=
 =?utf-8?B?cU5tc0NxdGpXMnYzR0FjWlA2TnZIREFUc1BMR21YRFBEZTVBT0NJdmMwYlhJ?=
 =?utf-8?B?Y2s3azBqRGhFd0cvUVhPUEorUlFHUVZ4S1J0cFpaOTdlM0FKU2FpaUJ2clUv?=
 =?utf-8?B?bnVNOWgvRmJUdEhsUUFpeFgxekVGS1pIVXBXVHhLanQ5OW01a2UwblBlSGhv?=
 =?utf-8?B?MXRBM0pSUWFzR3p5TTRkUy9FQzBzR2VrZUI2V1I0aHNDOFFra3MxaGJGZks2?=
 =?utf-8?B?SXY0UEExQ3dCRENGdGR5V1FCSll6aitHZ1N1bWlrUnhqWDZtUWo2cWliYW03?=
 =?utf-8?B?OEtuWGVEaUNCYzl1OSs5ejF0RXFTM0d3Y0NtcGR1MHErbUNVRjNGMFJlbFQr?=
 =?utf-8?B?bmMxdklBUkcrUHN6bUZvUHphQWcyTWNYYUo4eVgvZ0tjRzk4MTJzUmRkRytt?=
 =?utf-8?B?alJYNDlRbkpmc3k1RDlyNE0ydDdZZlRMaVNHOXc2Y1paNmxpVWJtT2ZNbmVn?=
 =?utf-8?B?azJnNU45cFRHRXZnRWNQUERiOXY1TTFjaUxObXVxT3ozSis0MkxTSk9SaWkw?=
 =?utf-8?B?Y2t3VjlCc3pydVlBSFE0MHlTUmd0NkpyODM3Rm5oc1RHZUtEL3lMMGdWcnA2?=
 =?utf-8?B?b21TT3NsYUhObzlJRnVoZTZHa2t5MUZGWVdhOVF1Qkw5Q1czMFQyYzVTdUNZ?=
 =?utf-8?B?NWd0dExLL3kyQzQ4cGhyTVBsZ1ZDZXF3Y0t4V3h1ak1pL2gvRmNjdTBTTHJt?=
 =?utf-8?B?UEpNb1hXZ3Z4NVNRek1BcnlUWTJIa0xlRzlFTk4wRW9Ld0NkOW12dWdPdUVm?=
 =?utf-8?B?QWYzYWE3MmtlUnpjekpLUFhWSzRHQUE2NTlKRUx0RWVLRUliRmJ6Vm5MMkZJ?=
 =?utf-8?B?MWFSRmtMcDFaSUpZRnkwNHRHQW1mT0h4VEVQN0Rtc3hXMmtxdkx4N3BHY0U0?=
 =?utf-8?B?emdrQlR1dDd2dndOR2ZicmZkY2NMV1Y1U0RKdi95T2liejcrdm45V0dGN1Vk?=
 =?utf-8?B?ZUY3aEFjOHZUcWE2OUlLMWlQcFovTERDOVo1ckZQc0t3SXpSMXBtSW5PdXRN?=
 =?utf-8?B?MCtSTlQ2dkVkM2pyL1hNcUd5T0RXK0xHcUxETUp6WmcrUGZMRk41SjRkTVk5?=
 =?utf-8?B?eUFmOGhtdE9RTkxpMkNjRVhSM3dZZmZxcEo1Lzd1MGJLRFlHS0xCYkJ0VFhU?=
 =?utf-8?B?bU5lTlZ4N3ltcnpXVGxBQ0g2b1ZFUGxYeUZXb0pLSGd6c0JOQ0lvVHg2MTF6?=
 =?utf-8?B?TnR5QlpQZm9nYk92ZW1Zc3AzSld4UjJjL0JvczlBOE42M2hkak5EYjBpSTFG?=
 =?utf-8?B?ZHY2eVJ1QjRvRnIrNStCRC9XZ0NFN040bVdlVmNCeGxwWnRBWFU1V1hFZUEx?=
 =?utf-8?B?WGxlYzZNQ1EzUi9adjAyTDhEQTFjR2NsRmtPZ01yZGU2TkpUcERnWVkxMjdB?=
 =?utf-8?B?V0ViY2FVTzVyZmpqb0UxS1hrVEFJVldNS1JhQlkxRTYyV0hybUNIcnZSTGli?=
 =?utf-8?B?VWRTUk5qNGI2dlpqNzVNWVBEZWg3OFpNNkUwdVhoK3Z6Vkl5YUMycXdtU2JH?=
 =?utf-8?B?a3g4MGlXeWd1TVJPWmorcDhXSWpzdVozWlBrVXhXZkxCTitMTVR5T29xUXhG?=
 =?utf-8?B?dTk0akJaODFHUFREdXVtVFFCUU5MUUxJVFdicHVKMERGSStyTXhhQnJzN3lv?=
 =?utf-8?B?VjN4VEpjY1VIMW5yUTVzVm5qVENHZGZkZk8zdVVlb1h6Q1dWRUQvbnZESlNy?=
 =?utf-8?B?bWVCejR5NHJsZ1cvclltNzBja09KM2FSU0hRanB5b3cvd2R0b2RVM1E3NEhu?=
 =?utf-8?B?akFVVlEwQk5NclVGSWRsQ1kvSTE4NkErV2hGMzJyaitQYU5UZ2tPeHptU0JG?=
 =?utf-8?B?Y2c3bUw1ZldsVEtneVJwQlFsUkhlWm1IOGFDbEx2VU9CaVc0VUVHVmI4eE5w?=
 =?utf-8?B?RGtTc3gvOXl3bmQvQzFCa2JyVUpOcjNtb0ZJNVgxR2RXdlhhNVhNYmN0RWEv?=
 =?utf-8?B?Y1dDS1NBbzEvdXErNWNZblpZaitqQkcrSVJydGQranFKRG80TStxSGtHeXB6?=
 =?utf-8?B?bDFFNkF1WnpuS3FSWTBsWkJUUkZHaUR0bVVQSDFhWkp5Q0dOa3JGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c24b196-a873-43a0-66cf-08de9af87e46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 14:08:39.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNwkzIbb5LWnNPNGPIFF7TF10cSZ7HeZ5TEcrzzxOHLALMYFDjw/UasRIx34dwmKjXUrMGeSNeE7HG7w82U+Fw==
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
	TAGGED_FROM(0.00)[bounces-3312-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CDC4140523D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, erofs-utils supports backing blobs for multi-image setups.  This
implements the FULLDATA import which allows for the merging of multiple
source images into a single self-contained erofs image.

To optimize the rebuild process, erofs_io_xcopy() is used to leverage the
copy_file_range(2) if available. This bypasses userspace buffering and
enables kernel side data transfers.
 
Verification: Built same image with default rebuild and rebuild with
FULLDATA. Then ran F-i-f/tdiff comparing the two.

changes in v4:
- fixed inline inodes.
- removed unneeded header.
- spelling mistakes & spurious new line.

changes in v3:
- adhere to uniaddress semantics.
- take advantage of existing infrastructure which allows us to drop a
  significant amount of complexity + code.

changes in v2:
- reworked erofs_rebuild_load_trees_full into
  erofs_mkfs_rebuild_load_trees.
- removed --merge option (use --clean=data instead).
- updated man.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
Lucas Karpinski (2):
      erofs-utils: mkfs: add rebuild FULLDATA for combined EROFS images
      erofs-utils: manpage: update to reflect fulldata support

 include/erofs/internal.h |  3 +++
 lib/inode.c              | 38 ++++++++++++++++++++++-----
 lib/rebuild.c            | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 man/mkfs.erofs.1         |  7 ++++-
 mkfs/main.c              |  7 +++--
 5 files changed, 114 insertions(+), 9 deletions(-)
---
base-commit: fa1aa7d3c22a3ee26956cea24156735f96ee8f9c
change-id: 20260220-merge-fs-e6231a3a3a1c

Best regards,
-- 
Lucas Karpinski <lkarpinski@nvidia.com>

