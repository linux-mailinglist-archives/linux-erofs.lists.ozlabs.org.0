Return-Path: <linux-erofs+bounces-2311-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OCADSEdjmmg/gAAu9opvQ
	(envelope-from <linux-erofs+bounces-2311-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 19:34:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 481501304B6
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 19:34:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBkTm5yf6z2yFm;
	Fri, 13 Feb 2026 05:34:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770921244;
	cv=pass; b=dD74NHp69JwYY59NXXmCTR3tBrTyMgzsNSa4OCNXHAubRRL2iZEPJkaSoN4OizQpGtxGqwtJPsCNT7F2Ah+wcWW9yCRkFtFrnQ/odpddj47BZ4YsjrzyU7+0qn2ExHKzIgR8O448b5qQhfQ/9eMPVA87+mFIdIURpHN631J06Z6dKdYDWRtbqy1b8nRFvfaNppjPPP3GHF0Vjo0T0rWFiZ2iAxIv/edJ4NysnRqDPOWYpkQ5GVwSufFX37ftZLL298vGiwyHWPxNI01lwOWgTxS4hT4xu7ojXtIAPyVAOBw7rPqVbjtMIXgY4bX+ZQ4Vz+6a/7jD3F04B3VOKwcVLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770921244; c=relaxed/relaxed;
	bh=k9sd+UaXtdt8ogKcpdjpOwJf3tCPh0br6cDMGukoljA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lD+GDT5QpcZJiY2neYliCXM6uwFiScq/qaikRnTO0TFatXMHqmpuVxSyHcSr/69YCxFU4o0fC6Myq8dR33WDBTIz+8Twqv7XVpFnSiOdkCcsEBPAbaMawAeympprQUk76oOj7m6Rz/WfsCl0r29puIus8o8h/Mo5OLxFTHa1wdXls3OoWXSbZfzneGNo34L233UPalMHa02BNA+9VO8NVlUXius+7Uv21nKBfEKYKKV93d+EV2OHiuu+Dl9bc5zaE0VJ8BFEFm/TCrRSH4qc1gN98IIpTcsKBhc86jFPlTLziWm8wXLml2ShIBb8iKGv0IrttCdCGNpAJXeaD3fchw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ctM8wjK0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ctM8wjK0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBkTk28Pzz2xHX
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 05:34:01 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdcpvEnT1OGrCBDlwGnMJmBHdWvObqPXN0QY0Y4VkDe1ZSSs2jYVLgkuAs7E3Tv+vwRUE1HovoySojpIMmcJikkPWFGT1yuXwtIRB6XTMy2NJbEdOjNarlkRDls94c2z16T2Xa3pTEHlvWaN5IgjjlgyUHGgSk8l+76n6X/+mT2M6Y0QEJzF50PXa1HofTbDAhp4jQs21YxOsffv0+isfI5VCLSXpzNWajLBm1oT9yhowiXQjlsWpNOXxkGWrO4AQsALEJz3ccv8STKnZmaI9EWV2bfXRjBQU/IwTZuH3SNFZ1E/BOpDZGGDflF8LRsolLngcXnOyezeluxfHOeR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9sd+UaXtdt8ogKcpdjpOwJf3tCPh0br6cDMGukoljA=;
 b=cEHK7dmCx+XtdtygNctaGrrBo/yUPe/DIm1q6Ag26e2yyvFqqr2ne6NOTnGFpkEFCAlWEa4oEKRJDv/rcmcNA/C8iyhCtzLjcy6sNfB7F0aOJ6fsO4ql79o9WzORZhnpVSkBrruEuN+NoMykE05TjUxqutT1UgmxXhd08gJv2sVwxJ0bJeIIUXvVcNV5/YRo3JHINB6P2YWmf4tqwXQzRVKegBb7uOobJsw7yfkmQIGRjyRcNi4wC39IwnUvRPRyC0quC8xAHnU1qp5ZDa0jrvqaj8V6VTo0mppK7Nt4/r/rRyXsxBDtmuYNsEwSas+jY1YvOAkcwzoyv/3ieJneeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9sd+UaXtdt8ogKcpdjpOwJf3tCPh0br6cDMGukoljA=;
 b=ctM8wjK0iUc3C4XLsSSLtcs7qRIJ9dWs62FeCOlxORoXfjF2ojaqznsMfuCe+RISNyRQ1udF4OaPePcymqCZWcwwu+d+KpcGSoJ528ijhEaOhkb19rY/diQTeL6yTSPYDGXMbq/xAuG9ddpkkas9Oq/M9Ht0dfDz5BnNKOf7PV8j3mlxsj7dvOBpNggvfoJtUrYRLpQopCJCOtkGd7KzQGpWNXJ398gxnovbAnomK7BOtO7/2aOfrBhz4mXA1b7gmd3cWrq6VYPmBXFO1zJ9S4SZEiPY2KIDtdAZ2ETytRuKUkGSMjHxvMqh+YT2CPpqVK6bKxBFjYRMeREvd+qsyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 18:33:34 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 18:33:34 +0000
Date: Thu, 12 Feb 2026 10:33:32 -0800
From: Jonathan Calmels <jcalmels@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Jonathan Calmels <jcalmels@nvidia.com>
Subject: [PATCH v2] erofs-utils: lib: relax erofs_write_device_table() device
 table check
Message-ID: <20260212183236.135058-1-jcalmels@nvidia.com>
X-Mailer: git-send-email 2.53.0
References: <20260212001302.72193-2-jcalmels@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212001302.72193-2-jcalmels@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To CH2PR12MB4969.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a7bb4-e987-4faf-313f-08de6a653a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhMa2F6Y24vdG9DK2hFQUMxRzJhQ1lLNDE0Snh0OWExVlZ0YzhaSHRoYTNN?=
 =?utf-8?B?bHZhTmEreUNmb1RBbDFySm4xZUlTQjFKL2JqU3ErQ2h2TG1nVHgwcmhGT0Rj?=
 =?utf-8?B?ZFA3WXNXTm1ueEU2SVlocTFWMnpuS1N0c2hTeVRKV0NNWFdXTjBNb3h2VUhF?=
 =?utf-8?B?MUM0ZFNvRWRFSmtsWCtsS3hYWEo3U1ErWmlDaEJzOTZGOTNQQVl1cEEzQkhs?=
 =?utf-8?B?azIxaW1nQ2FlNFJPTFVMZGRkQnhXak5JR1hGbzhLNjU2Q2h6cmpqK3d4Wkk4?=
 =?utf-8?B?REtZT3JFbG1LYkpDZTRzeWFTSU9UV0dsL2QwRzV0K1ZwanZ3Z1JoTDJQbDNL?=
 =?utf-8?B?K2VNQ2lvZnpodDVGMFZsYk92cXNnUDBQczhRTFN2dVhROVUxbzBJSEJmRlVP?=
 =?utf-8?B?UDFZVW5TWWE3NHBUNWpVSGtnc1l0K0dOSjZQNjNMZkptNGpNcEtnQ0dNS1oy?=
 =?utf-8?B?VW5NamN4a3N6ZFQ3eFBNb1NOMVVLMkE2Q2xxbjg1VlNPRVJxNytNY29qN2hz?=
 =?utf-8?B?VE5vZitlWUJTVFBaekpXWmFoSHRCQ3ROL0NxbkI0amdQWmt2V2pzaVFsTEFo?=
 =?utf-8?B?SHkzeHZCQ2llNnNRSjhveVlSb3kvRWZBNHlBY05yOERjMFgyZ0hTaFhwYmN5?=
 =?utf-8?B?S1ZCK0NEYVlWZkdPRGxLdVAzUzhtSzBGVDlPOG5yZVZRUEhWUE5EYkxPOC9s?=
 =?utf-8?B?L21YbGRuSVByMFJrYVQ2cWVyZXgxZ3Rxdzd5UnBkU3hTaUZOQjhoOUp1NU1n?=
 =?utf-8?B?K05iTFVxSFlxUjRsOCtXZlpZd2diV3F1RzB1RDV6MTE4OW9FNFArcmczZzhk?=
 =?utf-8?B?VkpUUUh6cXhpUDN2M3NhZnlXbGgybWNpeVJzOU53WTdaYTYya1pEREdCdUtv?=
 =?utf-8?B?cVFXUFFuczlIVFpsVTBvSHhzdkNLNG5odDhrNVNKK0JzaWdVclR0YkJsQkRE?=
 =?utf-8?B?V0xFeDZZbEgwK1RJdGNhKzRTRHVud2NjTm9TdHFkaGovTDRBTUppVHBOMDM2?=
 =?utf-8?B?dzN4YUtqb0U0cVVKWERENEdjNXBWNDgvUVo5eUhNcU1ab3N5M0ZScjJ3OXNm?=
 =?utf-8?B?VUJWU2FZVDY1R3lDQ1U4blFpQUxBRXQyM1d1NWUyYm9TdFlZM29LQlhzUUV1?=
 =?utf-8?B?Z1BnNkg5REpCNUZQM2NSRy8rRFYxZ3JuTVhYY0licm42Yk5ZZ3dTT0hZNkgv?=
 =?utf-8?B?ZnV1ckZ1aTZyZDRnOTFEWGNUL2xVZjZuQUJqSjVBUHNvQjFTZ0l4UzlTcERS?=
 =?utf-8?B?djBJSGFnaXNuUTJSdHB5U1plQnNaWkE4MzdRZGhFMTJJOWRZUjcrTVVsbU1I?=
 =?utf-8?B?cjJiZG53aHdlQklRc0g3TzErazEveVdZbnZncXBvUyswMTMxUXFpQ0tWaTJr?=
 =?utf-8?B?ZUNpSEVGdDkxZE01N29JS0NXeGJLNjc5K2tMWExKbkhneUYwL1lkNGMxZXdP?=
 =?utf-8?B?NmxjdlRMcTZPZDFua29NeDZLdnRzZHl3TVZ3VXltQVd2Q0d6WExRaU1adllt?=
 =?utf-8?B?aGZBRldoZ3AwM0hmOXlyUXQ0MXp2SG1MVDNXT094cWlyWDVIYm1RaFZxc2pt?=
 =?utf-8?B?T2lOR1BnMHloQnVRYS80R0tRZ1NEdWd5SU5wbnkxSXZnNG5acHk4Q1dmczFl?=
 =?utf-8?B?SkxGVXJNRjl0MVg1Qm0yMzJRMWlCcy9Da3dKblZ4bnRKeXh6SzhaYnJkVzZB?=
 =?utf-8?B?UWZ1ME9NVWdHOEpEQ2dLalljUE91WDVnczhmV1JzSldrTGJSc1dUWVVZVXlw?=
 =?utf-8?B?cTdBU3BqdmpPR1gvNXh2MEVORmhBMFlicE9SYk9lakF1KytZTTNRUFlJVWx3?=
 =?utf-8?B?ZjQxVUp0R291ZEMwbEdrNE9RVkhUTmNFeWxZWGUvdTRMZk0reG9GRlBSYmxx?=
 =?utf-8?B?MkprVmUwMHFTcHF3dGxzQzFTQktYdW1Hc0I0Mml2MG9vU1ZvNVYwbUZNdmp1?=
 =?utf-8?B?QXhJejBTNUxnNTVIRUI3cGhTSXpnd2lTc1VaSFF2WkRFRzk5ZDE5RGc1bzNO?=
 =?utf-8?B?UlBmVm5vbEFlSDVSQ0VjcWFDcmlNOFFZQ3VtclNjb2JqQnA4a2JxQ3drV1ll?=
 =?utf-8?B?alNpWXpxZjZjQ0dOZG04UFpmS0ZoS2hsbk5sUStnczZ0ME54NWJPZEd5SE82?=
 =?utf-8?Q?r6pg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDQzZCtOdEhOZ2grZDhEbEtMMC9ETjdVRDJQNW1iN2ZMcnZ3eHdvMmpHdTA1?=
 =?utf-8?B?eFRFZThBMTVvUTNOdHlHeU1ZTGVXbys3UDRsNllyNmlmYkxmY2hlNGRnN2VG?=
 =?utf-8?B?UmtTOHh1VWE2eitTZllvaW5Pb2Q3b2V3Y0wvTW1PVWtFQjh5d2VTVEJmdGx4?=
 =?utf-8?B?RFBlR2xndlJnOVFWcjhqS2Q3enI2eEVQRDZJN2VYYThqcTVFYTM4eDRrSEhy?=
 =?utf-8?B?Q2pEWGZGblFWNDdUV3ZRMnQxeTd1WWRIczRxaDBLb2VQZkpVNHg5NXVMNlRG?=
 =?utf-8?B?M0diYjRVa2l4Q254ZWxQSTFqTnpLaEFaSnJ3b0E5TUhUbFpmWVdpZXdSZ09N?=
 =?utf-8?B?WlR4ZkJEeldxS0ltYVVvQnFBYkU5S0wwek9lZXVMKzVFdDlFS2dXZitoMTE2?=
 =?utf-8?B?ZXh5enZhOWtPMkZsam1xUFlhRVJ2ZUpla2FJZ04rMENGczZsL0hsbmk2SDN1?=
 =?utf-8?B?ZDBLcS82QUtQdlVrektmMVNSTy96M0gwTU9nNzhWZjdzSWZhYUFDK3RLYkhz?=
 =?utf-8?B?OURnU2JoVy9rNWluVlhKWW1iUC8zbE5RalU1RS9Dd3FHREtGTTlFZ1B3UEN4?=
 =?utf-8?B?K2Y4THZCSW9xLzJEQ1IzaUFYdkQ0QmVkcXpOWGZUaU5RYXRLSXVBZms2V3Vs?=
 =?utf-8?B?M1RISGNZV0psSURPWWNyMnZONzF3TjJDc0MrUjRRUnUzZU14ZFFFNXlOK1dB?=
 =?utf-8?B?UjhBaDBSZ2t0bDF0VEdrV0VQZ0s0aHRTb3AxUHRoLzJCbUYrdVlDekhFK0ZT?=
 =?utf-8?B?QkFUUThQcmxYNnNOcmszcE9EU25lL1QweUxYc2dSR3gzQ0UxMHhDUU5lU1hJ?=
 =?utf-8?B?RWduUDZ0Y1BSd3RPck0wdGxYY2NKYVdCOVdrdU5IQTc3K1RBeks4Y2hEWFV3?=
 =?utf-8?B?K29qVmM3bTJOM1ZMakgveWE4QmZNNm0ybE1rQVJqdGUyTy9yY3g5KzVLVWky?=
 =?utf-8?B?WlNXVnRtcmJ3eld5OHUrMDREbXcxUyt2aVRBMkpsclY0eXhRQXRraEZsWjJx?=
 =?utf-8?B?Szh4K3llVVBhbm5HQ3hxN1J1bFVaOS8wQ0x5SVhCL0NFbFZKRXlhUVBKUDlq?=
 =?utf-8?B?eG1FKytvYkwvN05aZzlRN0RldU0vSEpvT2JhQlRrVk5CWWs5WGFNbzVTL2ln?=
 =?utf-8?B?K0ZWUmlwOEFoQmN4dmtUSWtteEdNMHZmUktiZzN0OGNLNGdSZ3dpeDJjbVUv?=
 =?utf-8?B?RXBMeHI0WHdkWHFuOUoweWpuQnNwalhCYjU5Y01vTW9UWmtaNU80UzYzc2h4?=
 =?utf-8?B?SGExckV6YzBJUGZadWpWZWgrUi8vaDZpOUhRNGZ6U05Qdk5hd3ZaM0s0WXZo?=
 =?utf-8?B?ZTZkdlk2Y0RWQVRsOUFKcHJrbFFyT3pINko1ZStyVkg3OXNQL1gra2lHUTI5?=
 =?utf-8?B?UHNTVzZxbjdORWxaV0xLVDh6VWhoZDNLQlBXL2IxWFV4SFlCOFpvZGdBby9H?=
 =?utf-8?B?OXdSdm5nWlhPeXlvNUdteU45bFVycmF2d2poSlY0WFFXUm00QzhvNHNIcTdP?=
 =?utf-8?B?UnliTzVkNVRWeXh0TVRqaDUvM1BkclA4MEZnekRKY0FlZHVIc2VYd1BvaFN3?=
 =?utf-8?B?Sk95UTJ6V3h2RzlmV1dKVmJseEJWU2tLckY4d0RzU0RFYkRKNDlGNEYrSVd3?=
 =?utf-8?B?SXZaTkRQTlh2Y0dhanlSMVpNUktLU0g4UHZtQ1RVUHFvbUpBenNLM2xQNTJv?=
 =?utf-8?B?UEpxd1dJQWhFdkFNSk1BVmlpYU1ncUhudnNoZXh0YnpLVWxwakh3WUJsTDdZ?=
 =?utf-8?B?YUdjK0JXaGlrTXZ0bEhveVo2SzVwSWRLSm5IY1p2Qm1pNldiNHk3OVhHa2l2?=
 =?utf-8?B?R1dBMXBYb0Z0alhpSTVMUHNNR29qbzdlUjB0Y203L2FJc2NNblQvMGM0dWkx?=
 =?utf-8?B?aVR0Q2pQUnhXZVdBRWhrYWF4OS9jUHp3T05iUE9ia2RJR3BDWjRFSmVzWHRM?=
 =?utf-8?B?WG5iM0cva3N0eXlGUHJuWmRKRXBHMTFheEdxVkY2dmhYRkN3YlMxUWxJcFFM?=
 =?utf-8?B?bkM0cHhWSElKWXNTYm1MOGVtWHpHN0FHazhuSCtSbWxoRDlGS1VaUUZhU3JY?=
 =?utf-8?B?ZFNCS0FEMjVNVVVEZjU0MncvckNRWVRJOXRBWk16N25ZWCtKbG5VdkVpTGlM?=
 =?utf-8?B?cVdRWkpBTEMyd3NiSnExdmpaQXJnTVc2YWdWS3BPTDFUamxaL29VVU9pZDU5?=
 =?utf-8?B?OTdhYU1ER241bkRvdUdwb1M2Q2lJakN3Rk9QM3Yzak1JNGd2N2lZZWxWNnFR?=
 =?utf-8?B?S3ljelB1bDNybk4wZGUwSGZlS3FZSzFWV1BpckRzV3BWTU5lRHV2OVFGRFg3?=
 =?utf-8?B?VXhKaURjYXg0R29BV2Fwa0djQWszYjZIc0ZNVDVLME04OUhFUGxldz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a7bb4-e987-4faf-313f-08de6a653a7a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:33:34.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYrnnHGVLWrnUfWf9Odm7+EWAMq7QpNDAGtbSsYHj3OGrWgOE5ElzqSXj0S/4rrMPlh5cMHtibbHOO2EitTcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TAGGED_FROM(0.00)[bounces-2311-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Queue-Id: 481501304B6
X-Rspamd-Action: no action

Avoid returning an error in erofs_write_device_table()
if a new device slot table hasn't been allocated.
Rationale is to allow erofs_importer_flush_all() to succeed when
dealing with images with pre-existing device slots.

This effectively allows the following:

mkfs.erofs -Enoinline_data a.erofs a/
mkfs.erofs -Enoinline_data b.erofs b/
mkfs.erofs merged.erofs a.erofs b.erofs
mkfs.erofs --incremental=data merged.erofs c/

Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>
---
 lib/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/super.c b/lib/super.c
index a203f96..d38396f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -392,7 +392,7 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
 	if (!sbi->extra_devices)
 		goto out;
 	if (!bh)
-		return -EINVAL;
+		goto out;
 
 	pos = erofs_btell(bh, false);
 	if (pos == EROFS_NULL_ADDR) {
-- 
2.53.0


