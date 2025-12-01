Return-Path: <linux-erofs+bounces-1465-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6BC95FDC
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 08:20:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKb0H3p27z2yv4;
	Mon, 01 Dec 2025 18:20:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764573631;
	cv=pass; b=gdqDIPRk3XQR9OwIZP9Ys4SCtp5wa/I8en/MPAE9LJ+KUhcgxvm4UaVLiVZb3eYQv5y53qNqShnj0LdVVTVWdng3kExCIkIh5uNtVAg49A+uNKcGIYueUxOoyJiL17lkYWsPd5XtH060haZJYODuumxDgFTOF8j2/pGyC4mkr5KLNx9n386R0pjDsD/SY99gOwfvm0uNLnJ0+2kqU/8TPCszi4HBmmrj34j0YO9lUmc5BHmKHgK5DIyzFs/QFCOmGAxUnu1qKsNCoiyCFPvShpjOIV1sW4BVbZYEqOWvv/eFTUdUUCBJMtfkbeg9/JrcBsg6nr/dpRjnfv9mLLihWg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764573631; c=relaxed/relaxed;
	bh=U6RzUXoRTDxv6unUuQMVld/4Qrwg1SturDe/krg9EPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAyBY6wPAZOiR7czXUanhfwr0kqGT8j7wJp05++3Xnf7AUiCir+VnEFTijPVZY8SzOkkETx+rddjzMCd1/kkD8rs1JJhcySPSndsSmbahnPo9k8tivOpQ23rfImW5VQvnpfjSV8IDSTqax4Xv3bo0sNSLLGT/KM4CHd00XtPtbruiDdLxv2DY/v0WD6tBgEhnJr5bnc2DyYTopVKAK8w+108ZPj88QI1RZYbzY4mPmeLAXJ8WFKmPnB49yx+2nlyKsfmdHSDdhOfy2dWc1C68pgNB9l2SCFknLRavtBj2yxlC2attlHHlDExrvXgM5sU8Svhd467ORWHRlPfdh7c2A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=GdkjQuKJ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=GdkjQuKJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKb0F1pMsz2yN2
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 18:20:28 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hkb9SU7SCUhIkVBB0gHTa8bfWewGaNa5Jk+8qShj44aEExq1HnScL94tvCmzzp2B0FFFge7aEoz1OrCSL2yROpt6Ra4N898cRR8iItVQn7+N/o7GrYAGm23g6zH8P7YuRRqUaL6LWumzWDl3hmw3IxBeGlSkM1Bn5HVx15KlRKx96WsqoZ9pasQXHmr9VwsiSVCa+WEDiyImpnAWtA96E5I0r643EsZSeHS01JwmojOgxUO1jid92dyEtZJ0YGCkZJWcGtZsdqLB/pagYWbKj19pR3gf9H2U6dvR6eoeaaHKUeJBEpgHuHHW/CFsSt5UyndyozXsimgNXXIuzlGi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6RzUXoRTDxv6unUuQMVld/4Qrwg1SturDe/krg9EPM=;
 b=J/N5BONy9bRYVcjCshscnA2537ZJiZec/iIs9xqp6qg3w2tcRxBtJwq3QOv1yenT9z9sgBdW7ohCqrzEKmZ2yydxjsRdVkLS+BnnSWhHU9kp7BaAuysuTg1/mbPcVTSw8+XGbXHmOY8OVG+sRQnyLccPFyGhPglzBFAZ6JgZNdj6NfvzaEQeDwmhbBx2w8c52+p9VUpdYxtszxs4S9/d2GwTs01RtTp7YN6mRF/eWw5xNIBZSxvsm+keKE2lj/J0EqWcoUGhfrpDN0uJXS9Jg8gSit0UoDor8XwV6gzAc5EJmF9LjqZ8NMMysYZxcI8F5iy1FKMHmuE01YHgxeOiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6RzUXoRTDxv6unUuQMVld/4Qrwg1SturDe/krg9EPM=;
 b=GdkjQuKJ8/BJqX42CPN4+xrtWa0J9/TVhotiHXuOfUtdSXf4smkd2BmJO/CS4xgN+QcD+LZn5gyEO1RjhwEo/sYLuuzVV+kQ9+nzvc2AbJjH2g8iGJkI1IatepeY+pG7BagvVay54TPU5YE3WgMI9xwAL5I7ocEewPDHMMovQx1T1JmskHKVgYvApyhYMF1S5xR3dCMS6Guia/v5rbT5O5ZxdcqSK+JMMAorHwj/zx9IWqFcdXO7t67fenLlu7w9nRQKXxz8S6SLRLdXhbRzIKyN9uG69CYEj64r51hEB26iuo3YDQ18LV3DuC9YVgHxG1yVlDp7/HFgqk90i7uozQ==
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 by KL1PR06MB7331.apcprd06.prod.outlook.com (2603:1096:820:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:20:02 +0000
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c]) by TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c%7]) with mapi id 15.20.9366.009; Mon, 1 Dec 2025
 07:20:02 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
Thread-Topic: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
Thread-Index: AQHcYmuajyvKAWa220K8zG2pLNG5JLUMYPkA
Date: Mon, 1 Dec 2025 07:20:02 +0000
Message-ID: <c6e1af60-196b-4533-81a6-7ef06c4d05ee@vivo.com>
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPF33E28B4E6:EE_|KL1PR06MB7331:EE_
x-ms-office365-filtering-correlation-id: c6f18c6f-574e-4475-bf24-08de30aa0b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWlKSkUwYWRLb1FkU2UyaDlPaHkydGZCVG9lUTJVZHF0aW5SYVUyaTF3QVJv?=
 =?utf-8?B?OUYrYWkvak41YjhHTzhWT1BNS2RtcDF3eDZHR0dKbXQrUUYvcStTSnEzak5E?=
 =?utf-8?B?ZTV2TWR2S1lQN2hxWG5tNXRpUzFZMFcyRDhQbGI1MWZPbFQzcEdybjBOUmFu?=
 =?utf-8?B?MzdUajhrMU8zNml2bzlXeSs2T2JZRnE0U05vRG9DZDI1aVNHZkk0YTVmcFVr?=
 =?utf-8?B?ODVGclppK2N6SjFlMnhRUTZhbHJOMTNtc1BKUlVRUkhJWlVnOXhRRUFkYTRw?=
 =?utf-8?B?STBYb0lxUWVVN3A5SWwrV094MXZ6Tnl6N1VVRkx4VlZKcXdKV0htUnFzZDdP?=
 =?utf-8?B?NXhWeTJzSGVXRkl4S0JMbGVUczR3QjBqRUNjT2tPa2ZLSmVMNEFGT1RsMkQ4?=
 =?utf-8?B?U3puYlM2cTFIMFNCbUlneVpnMkhPbXNEU2J2VmdBODA5dVpTNkY1QXZ2U1k0?=
 =?utf-8?B?QllJYVh6eDN2OThiNmcvZjY3bDh0b1FMOURvNHQ5dnZRc3hrZzFocVFiSm5T?=
 =?utf-8?B?OTk3bFcyMVBVSEthdmNETzlQaTBBVi9ESEVmSHpZclF0RThqdDV4UzNhdC9m?=
 =?utf-8?B?eEZjd1V6K1krdUJUYm45eU9kRlppdFVpVGRGc0x5Y3A0VkdMVUxGeENNMnFN?=
 =?utf-8?B?RGJoSWRtNGZzaC9wODhSK0xaOW9HODBxM09mMjgyUmJYZ3h4dS9XWkhTOWtQ?=
 =?utf-8?B?aGV5NjBpUitWaDExOUhhcjNMcGJPS2Q5czFZYzFBYnhGck5sNHAvaFZnQ0xz?=
 =?utf-8?B?WmpOMjhjMGhOb3VocjNOYnRnQ015Y1JpcjdINEpHeTVUVXkzQVB0SDlJWlox?=
 =?utf-8?B?RnhmVUFneXAraGJEUS84eEVVQUhGcWEzYTQvVjdORm5CY0xxRktvWjdoZ2lO?=
 =?utf-8?B?RG02REJlSWpGaTlTclMxUHNwU3I5czBzb0FmVTJsZ3NjczJOaXJJNHhNaHJH?=
 =?utf-8?B?UEdCeW0xRW1OS2JUbzVpcWNWMThOYzg3YWhmUVk4U012THRxY28rSmVZRFZD?=
 =?utf-8?B?OUcyaSswZmM5N25Ub0lNZVZDc3I2LzdBK2JFYXJ5QTFwL3lSYzVCSEtURkV0?=
 =?utf-8?B?UFNzcmhEU3NFRk9VbjJCRlVqQ1BCVjQ2cGZNTndCbzIzNjRrQlhxRGk4bWM2?=
 =?utf-8?B?WTdpRHEyaTNadmtEVmpIdEdvVW16NGZtRnppNUtNSnRySEp0UHNoZS9RRDNj?=
 =?utf-8?B?TXY3NkxHTHRhYmRPdUgrSUJUdlFsSFhaamtTMXpPQ2NENUVGa3BjYS95OXN1?=
 =?utf-8?B?RmdjYUR4aEwxc29WTkw3VytIWitMM1BEM2xKQlExSk9SaVROMlNWcWhNMmRO?=
 =?utf-8?B?a3hmK0VwMXJKRk9sMHl5WFRBbEZvZlNMS3p6U0dzZTY4NndmZXVSNHNiNytV?=
 =?utf-8?B?OUhTelVzSjlKQVljQ2RGQVUrQk9ubElVNUttYUxUL1NZTHZHYjErcWI1Y2tx?=
 =?utf-8?B?L3hmWmNlSnd6VTNZejc5NDN1VDEvUnFTakgxL3lVQysrZHFwWUtWSFQyd093?=
 =?utf-8?B?VDFRWXRneGVqS1MwelVJL1lJby9nSVhYWDlKdmlHeHREeFVZU004aVBNcEtZ?=
 =?utf-8?B?RDM4RGVtRjFFNHQzS2NqcUhuQWdhZTVmb3VhWmsrc3ZSY0l1SHllSS9LL0F1?=
 =?utf-8?B?QklUWktKV3RaNHQrSTNobzBEVVIyZVhHTmRwRkFPcldmazJZSDFQOEIvYlpi?=
 =?utf-8?B?Z2ZJY0RhbmJhc00xVGtHRENzb1JYTnBseCtkNXlYR0dQcS9sU25ocEZnY3dQ?=
 =?utf-8?B?bitGRjJ1R2RoVU0zQ3BGTXVaWWFVZGpvenUzRmJvT3hteTF3V3N3MkphZkox?=
 =?utf-8?B?VVE2ZUdQOXZzU2VsbXdPRU5nYjRqV2NaYlV4U0ZqZ0JsVnBreFNyWjV3T1lF?=
 =?utf-8?B?ak1uRHNnN0dzMjF6ejBOd1BBMnBsQ1pXZlkvejJyY2FzdVBsV29LaG1tNjFE?=
 =?utf-8?B?VWJpejM2SldSYzFEUll0d2lnOE1wSjZhdHEvc3VOOWpXR1BGdkpTWWZOdzhx?=
 =?utf-8?B?S1RHTUNRbDVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPF33E28B4E6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2R3WFVBYnY3Y0pFcFdTU3h4Sm42YWpIeDF0NGtJWHJuR291ZGNPdnFrNWg3?=
 =?utf-8?B?aEd0RnJKd2pqazV3ci80Y0xDUWFmdllHdXEzZXdjTnZWQVdla2pJMjUyRnYy?=
 =?utf-8?B?ZGJucUEzOW5zdTBER2xhMEl3SnF4SFQ0MHFhYzQ3cld5WklyTGN1d1JxUWhG?=
 =?utf-8?B?Q1RNOFRrMnczNlJrQWM1cmFoYlhOMzdldEJaQXcxMlh5dld3ekt4VlpqWUxQ?=
 =?utf-8?B?TDgwU1JNVlZVSE84VHZrNHZmbE5uaExtaEptOGVmakRlNElKUjA4UkdWV1JT?=
 =?utf-8?B?bkpvZjdCbm8yd3VZSTdRZXhTTmQxTkRIcWMvVStHZ0tWbzJ1QUdlTVNONlA3?=
 =?utf-8?B?WlcvTE9md0JXR1JYTjBBYUI4KzhrbTFWbTdLekd6TlVaUWgxNUdaSllxZ2Fh?=
 =?utf-8?B?V3Jjd21ZYlFzOEFXanJPZmdOTmFaOWdNd2hPMTFqeTJRMi9adTd5Q3N6UDFl?=
 =?utf-8?B?cFBsZE1JMzBzUlVDODJUQmRZWjdheHkyLzFsSGhqeFVJNlRIVk1JWTNNbVUr?=
 =?utf-8?B?R2ZScmR6WnA0UGYyY2I0OElxcDdaQmxkc1hhazJjcnhidmxWdkc3ZitheUJW?=
 =?utf-8?B?anZqSzVybFluaytiU2gxcGFZRnZuWGhZYlpyK0UwbTlaMHhicE1WWVU4MHhu?=
 =?utf-8?B?Tmp4WU43bmYvYXF2bEc3bFE2aVAvczc3YjVhYytxZFR4bkdwV28rUE8rRFV2?=
 =?utf-8?B?TDJ5RUpQK28zS1VBcDBkYTFyVzNWTnhQLys5S1dTakgvMlZXdFR0L1JzM1lB?=
 =?utf-8?B?WUErR0t0ZmZkSXcxbjJ5OWwzUTBSTXhVNVdWSU95ajlYeVM4MkNGQ0FDbjlR?=
 =?utf-8?B?aVo1eVJkcnFPclpEWmZnVWFmQ2FmYkVNV1IwRlRmRTA2NzNHY1E5Y1pjcE5Z?=
 =?utf-8?B?cUJTVFZhYjN1OWxScHFtS0x0czAzcUJ0TGlFVEgwZVhSVTZpZzg5K29oSk1B?=
 =?utf-8?B?YzBZRnNVZWYrUVNFeDg2RGF3cUk5M1MwMGVxNTZxUXc2MDd1QW1hWGxSdExt?=
 =?utf-8?B?eHRQaGpGbmNXdGR6MjByWEJtOEVxUVVPUDlMWlQ5QldtREZiZ3JIQ2hYVW00?=
 =?utf-8?B?dEZ1R0VOZEVOU0JHR2tuTjJLNWNxUloyQjhKeWlSVTVibTQzYVVxTVNsa2Fk?=
 =?utf-8?B?cnlYVGF2K0dCa09aYi84TGdDVHNiUWxnVFYvR0Y2UTJ3dG5oUzdqYVZQT1RO?=
 =?utf-8?B?YklXaXQwa3VQeW5DTTRLNFVXbmpOMDhtanVWV290ejJMWXY4dkIrcCtLdkg5?=
 =?utf-8?B?NlFFSENDOExLTFpNdUxQbkZKVkk1Q1BTQVBNT2FGWG9MeXMyelBHOVkzQUJn?=
 =?utf-8?B?RjlYY29XcWtXUlRmUjdwc2FBbmhmWHE2dTl2TGkrR0t5eGhIcEN3ZExucm91?=
 =?utf-8?B?WHU5T1RwMEM2aGhVc1BCT3IyNEhUV2Z0OE5YYXF6UXZXdDRXWFJlb3o1a3Uy?=
 =?utf-8?B?TUdncDVIWENSR0tmSThLWVh5TTBoWWpuUm1rbjREc0RDbkpSMXV6b0JtRVBj?=
 =?utf-8?B?aHZIdjg0MHY4ZHBRcUVDWTcwc2xvRTZCMlFLM1dVMFhZRmEvNWFQSkovS0Zn?=
 =?utf-8?B?ZWk1NHVwL005OFpncnc4RFcvVk1DS2VhV3RKQS9Id1Y2eU5yVE44KzE1S2k5?=
 =?utf-8?B?QXZhc0lYWjZ0eWhINmFJcUhDM1JMMExSWHpmS3NNby9OMGlJOFRldTVERUNN?=
 =?utf-8?B?c2xheGFLeTNQS09yNkxtb1ZOMWxjb0FsQklYMXMzM3F4V0FZRmZhUHNQVitu?=
 =?utf-8?B?TjdnK0poRDAyWkJUcml4R1FMeC82S1ZNY1BBWmdEVkM1MEcwbFhaRUR1Y1FQ?=
 =?utf-8?B?RTZiSHo4ekZwR01NVXVpTjk0TXp4eVY1ZW0rY1d4a0toK0gvaFhkTFV2NGl6?=
 =?utf-8?B?b0hWU3FoU0tIdkFRT2lQbWVLQ0xWL09oTnlhelRGQndmbmFtV1loMERxZEJU?=
 =?utf-8?B?bnR4ZEloY1FFVTIvMjdiTEdYN0UrbzNEbVl0TmREcEM5WVJYTHNJSGltZyt5?=
 =?utf-8?B?c3JyNVp4TGxvamlsMENyeFVOQUxsYURkMy9WNmR4WFJSRnNUelNzTEpaZ2Iv?=
 =?utf-8?B?Q2UvM1NaM0U3S0hFY1J4eGtZV21acy9HR3dsLzlIQkpEZHBZNW44Rno0NG13?=
 =?utf-8?Q?4Cmo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C352416BC1E446B7F68FE1A3F5733D@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PPF33E28B4E6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f18c6f-574e-4475-bf24-08de30aa0b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 07:20:02.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjjvxpzKtIkLFdMT48u3zPsU7xFv0PMF/giJe8dYf+N0GLPJUg+dLrELIGnbhlq4h/KGYYHeTsJ36oLsqeuPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7331
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

5ZyoIDEyLzEvMjAyNSAxMDozOCBBTSwgR2FvIFhpYW5nIOWGmemBkzoNCj4gU3dpdGNoIHRvIHRo
ZSBwZXJtaXNzaXZlIE1JVCBsaWNlbnNlIHRvIG1ha2UgdGhlIEVST0ZTIG9uLWRpc2sgZm9ybWF0
DQo+IG1vcmUgaW50ZXJvcGVyYWJsZSBhY3Jvc3MgdmFyaW91cyB1c2UgY2FzZXMuDQo+DQo+IEl0
IHdhcyBwcmV2aW91c2x5IHJlY29tbWVuZGVkIGJ5IHRoZSBDb21wb3NlZnMgZm9sa3MsIGZvciBl
eGFtcGxlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vY29tcG9zZWZzL2NvbXBvc2Vmcy9wdWxsLzIx
NiNkaXNjdXNzaW9uX3IxMzU2NDA5NTAxDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8
aHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29tPg0KDQpBY2tlZC1ieTogQ2h1bmhhaSBHdW8gPGd1
b2NodW5oYWlAdml2by5jb20+DQoNClRoYW5rcywNCg==

