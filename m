Return-Path: <linux-erofs+bounces-3302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPk7DG6R3mmqFwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A078F3FDEAE
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 21:11:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwDQx6K64z2yYY;
	Wed, 15 Apr 2026 05:11:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776193897;
	cv=pass; b=NG9U+gifURTItGg0a5rlEE9ns5qJTa5qy0HQOaQVwFzVyncywj8L8+RjZ2ood7rwdGeSnHe0bvEp5MhQGS9je8YbvF5UaS6e/2MNf6d5gNaB7aiIxydKz9YGwKX7c060XvS1+ugCY1Ih6I/XX99o5+q9Agh9LHqK4W4eUyYYu9BgWFmriVwAFQ9a8Gn7jRdKo9pYHSDyFhxChHGicOrReCGINnG6z0tRWtYTr3/wkIMcUxous/XcQk+d8maOertSYA0UsQVl9xmGf/vZop2Hz32KhyJO8M0Z26qWOztlC4/PRLCYubriD2kGo6HKGOQYXweLhjA2+pktMQ7N2pApkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776193897; c=relaxed/relaxed;
	bh=VaJCVIBIXQ6hzSQcoUn7Xzd1Zc84+Jak3td28msvVH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a8bOtl8droN4APbwMxAAOcKPmj2sOPKMlUoAahgA39r+r12eS8AUlhJmG6Ekk1Xf5DncCZNkE6+BTdDiMpkmJwiuLVkcjUvyAMgvDGMRtxre1fzCkWT7zy/iRl48+VhEg50ULeI5xZQSJxf1ZPGH+XFfgVVVoyvq8XhM7XZShoVp37JZeRa+njlMh9gMb45+qfi5q5gBuo1zVivYXRaYe17FjPVcaR3up97hmt0Z6HYCBUP60aZTtviRc0O12MoQkmdD1bX20kCDgLudLlRAAqVtyxlqh4UlZvWWVXrsFAkxu/509E4a6qDCgYJDJL2kiFie4Z9AAfFQHmQjpuJNEQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UzUD62eF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UzUD62eF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwDQx0NF4z2xlh
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 05:11:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmnjOqcvwZ1vI6tJHp/id0JNWa1ZkVRyPv3xiSWG9Rs61DPVTEFIFZXYDm6wgSCubPGWpnaODPku02AQpoyuzIy4ImYUuRp7PSzvihsx25JPip6b1s3MTC/OCPEtFC7ixvwUnpycoLV5cQTfLJtz08wcc5bwXWO4JzPHNaGf7uDx6g4HaMYzDbwQnzKgvhwCmDO3B3BvtipQ6yf94BehJXX4YfSelZKKZCqb+4mZSBub+tpl0yXyl1OcbRMGx4tDkV5udBMLD9OiLeqjEBoHfaPdpug+vQkw87XhCHu+VtIDpNq7+6KuczhERQ3ItpzSKvajbS3v7iqo/nnaMM/B1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaJCVIBIXQ6hzSQcoUn7Xzd1Zc84+Jak3td28msvVH8=;
 b=EmeI9+iqDlWpyDH8zV5Goq+OPPRDP+bxpnUZx8o3RAWUtNKPoZAmn7TWScdtZuYIIFh2nv9Lzdc8h9ewdJ1QaByVWKQnmKLnHJdalgwWftuUilurgNfYcVXkO6RgzBR55KF76DjEn5rEdH8A5kG2fscJm4TqR0bKezqTEk0L0b+LTzci8WUAxbzEEXi2NmB+3FOOGR4CiYjk/7vtLfncYFXONaYkx3FyR+6Le8vSwjB2wpA7nTZUoTc5kOcWu/ypMHsibbvz5Oi6tArsWUza2w1Zuwhag+Is2IUb6GknTKJR/LW79/pgXHshrds7jeDN0xHMOru2nblA4q4SZNeS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaJCVIBIXQ6hzSQcoUn7Xzd1Zc84+Jak3td28msvVH8=;
 b=UzUD62eFa51zGE8XtL+z2WhfjA2a3r11pUY+y67s177RcplfejkwA9wJFVPIAaivJ/GN79y1kwxCOAjf8drWtf5moU4gFBgko7OD+wbmEwblo2wYog2fNfBxxd/ndCEGkTKZ3kQXQ5WGXiGdc5hYf6SowjtoLnVkX5gvsQeATHc44JaPpNQC4HgD5OFToyfNAkwSDibvmi4V54YvWU3t/hwkbx0VOFTMLpiQ4uxQqrI94T/lsMfnxuSO6NQ5ZzqxKyhl5B7C0aD0Vm/EctA+KDd3/lXx0bg69B+yrK+YotSyKibIAXHyQ+m74oklFIcMGCJPSeKMYN/WC3efbENSlA==
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
Subject: [PATCH v3 1/4] erofs-utils: lib: remove redundant if check
Date: Tue, 14 Apr 2026 15:10:39 -0400
Message-ID: <20260414-merge-fs-v3-1-266bd1367fd2@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13572348-8b51-463e-9147-08de9a5991d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2DDKC+G/VnTF1qRhZQnFXuezuCifQhZewrrrxxzIXYUf7sPsCEpOlEr0yvbl2F+iAWDoqMYeGJjBFxnRMT1Y0G91mGZGSTZ99j0LsQ8pVcGG1UlRsUq/4rKbUxNm2pToTDIJEwqavnnvTWHxEIxndztd7TO2ACBwJK5xOUtwz2+91suoCaz4MePNluHjLFLvz+o5GE0k8DA/HpQ2AexTfSqfwd5lXQgT65mMeBfV1/QKnxa1EcC3/j3qsVZtcy5thRHuKUmxr5xzYmJNoF+d6CNiKykjSZAb0FrAHP3WCdvRpDqJ6qvyb0KwKgxtuYDzrrrGxaCbaEryvbOOp50xuLWt1fIj4UGXlUf9MC2IvdJdKw6DJ3rBxD/W5VBoHq+a1rfBY9byew1i4z73MZ6gkVrAOSVVAFVyxftbnMpaW9PPy97YIuc+KNVy4xxPKlZwlpgOGDfuCMD0JsdVgk9XtHRs9IdPfcbEQwouisE03YiB9hVwFU+lDLSOVLFfo5QvwdMEBZSvH1kef0U26fn+DjPoN1E23OzcVPYwLRYri5L0ca5MvcWZfNHCWE+deAQvupHzdXZ35E5bTzL3dzkk0cfEKQei8zQ222waZ9JBzZ8fTCW+qZJtod+afgIRdUThVLau1Th2Accj6ogUwvdWpb5S5X3DzNv3WIDXXSRGHFxvX2H2qt6XpUI+8EgHzEgEFyDPAKCW3kR72K6F3pMwPEwbIO6MnOM1kyUMhdrSyc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXUvLzRoMjRMOVpkejZqelk2RlpiRWtXbUJ1YzFMTnAxdXVUMVVXT09kYWtQ?=
 =?utf-8?B?d3FLbkxWZGt1V2FLbUI1V0hmUGl5bDBldFljWHNkcUl1UjRJYnJCVzIxVldk?=
 =?utf-8?B?TUxkbFRYaXVqczRTZDAwMG9rNUdURElVbG9HZHpqeGZpYmxyeVd2N051eE1V?=
 =?utf-8?B?UDhvV2lWQlZBZzNaY3JWeWx0cEE2aExhRmcrSlh3S2tCbTBzR28yUmk1eWhF?=
 =?utf-8?B?dzRUNU1Qakx6RG9vMW93eld2WnBJanFKL3pEdGU1eEI3MkI5OElLRnJ4a3dv?=
 =?utf-8?B?OVNsRVhIWk9yRDNrV0xyRWVZZ2tmd2dXT0lEcW1kQ2NGcWErWXlPWlZ6ZU1O?=
 =?utf-8?B?eko5SDZhMkdnaWdIeUdkYlVrNG9maEZQaWtzOTVlR0k0M1pzRXo1NURhcCtX?=
 =?utf-8?B?bFVNSE1HL3Q4U0xXUnkxUUFEc3M1dFBEc3podEhXc1EvUzZ6SGZCTFA3c2pu?=
 =?utf-8?B?eTdlQ0lTTWJoMVZ6WlQrYWIxNTVEcWFEbVZQVVlUN0NCbEFrMjVNM3F5TnBY?=
 =?utf-8?B?ZHp5d3dJOGJaT05KTkdTQkg1VlJzRmtzRVJaWEIxZlp5MHU0UExERXpkeUdy?=
 =?utf-8?B?TkhvUTBheld6NEFYMkdKaWZDUlM0YkFFLzhRakpMSG5KWUhXVFF4MG95c2Ri?=
 =?utf-8?B?NXAwc2hiTTYvQ0NkVFlqcWRERS9GL0NaM2hZN0QrZUNhVmFjRDdhLzkxUjUx?=
 =?utf-8?B?cU9PNWVDcElCaW9TMWR3RFpyTHdCYzU3NG0xWDE1UVQ0Vks1Rk9XcEUxOWwv?=
 =?utf-8?B?S2NqKzFtSUUyZWtaRm9OWCt6SzJRZnpJd3lQdktXdnNXUUJqVFgzTmdBVFZI?=
 =?utf-8?B?QjhrUHpTYTdQTzAwRWRFMkswVTJyNCtWU0Y1U3VIeXYzSy9kMEFBWGZqNWZX?=
 =?utf-8?B?NWxDbENvYm5CanoxSldLWElyOGQ5MmRmcmxIdWI1NXkrajBJc2tmZ2dnK0h0?=
 =?utf-8?B?MW1aRmJZamVYVmtRaldEY2h1STRINVZESERrNWJkMkVheURLbGhySnduYzU2?=
 =?utf-8?B?bEJqODVHQUxoTXlUckJDaDhGWER5dUFVbDArRTl6MzhSMWVXalFidkpVRVlH?=
 =?utf-8?B?NUJrUXNac3RFeVk5b3NtWlVaRElVcGZERVpLejJCSVlNdVVrL3lUbCsvRTRx?=
 =?utf-8?B?d3VMVWZPRVNvZXpzUndwSllmRWMwYys0VTRKZmQ3K0RkWDZtMzB4QW9vWDd6?=
 =?utf-8?B?ZVZRR1k0VjJpMDZzbElwMFJTNFR2NURtcHBMM2RhNG1nSTVvV1JjTktjYjhG?=
 =?utf-8?B?YlVTaDFnTlBZSE1jSC9ueDgyR0FPakZzZ3VPai9acWpmVTFPWTdNVGtpRFQx?=
 =?utf-8?B?Q0tZakMrRU5MbFM3bkc0WmtoZEgzanA5Nk1pKzlyMlRTR0haY1VlMlRHVVQx?=
 =?utf-8?B?NUMvdWV0SU1KeW94eldXdHRzb3UyVE5Uc3VsWEVvSDY2QU96QTRhWkQrSUxJ?=
 =?utf-8?B?VCtHN2hFaHVYQ2hWWjRzZVJjaCtuU3VodmdHeGd2akx2NS9XbEdDa0JVbDJz?=
 =?utf-8?B?dlpYTCt2d3JnYWFGU2RtNUV6WkRKQVRBZ2dwRStEOVdTTTF2NlhyN0VmVmRK?=
 =?utf-8?B?SU5XRXhldldtVWYwVWVsK0RDQktDZnJEZGVkaG11S292WnhNdUxYamhLZU5k?=
 =?utf-8?B?WS9XczJVYVpzV0ZDSDF0cGs2QVRyZXQ4c1ZqejJ6d1N3N1pGZGN1YWorR1lx?=
 =?utf-8?B?bXVNUFJBMk9sby9CdExzTGJCR3RTaVd3Y2o5d0xWVUFwUWFIeUJaUHl4RzVN?=
 =?utf-8?B?RWZaSVRLWCtlQ1hwNW5YWlU5US91Y0pvb3oyeDM5Yld1NFdJOHVtMnlzNk1W?=
 =?utf-8?B?QTJWNVRRaEIxMjV0OGsrcCtpamIrdlhiS3pZZ09kcnlUbEl2QktVQ0VJZnJ5?=
 =?utf-8?B?SWV1Z3B3bnRWR3BYSlJ6TlhZaS9teXEvbFpVMDBQQXRiNHYwTk1UbnNzb3BL?=
 =?utf-8?B?RWxSS3U0MDRmcFJ4ZGVIcS9mYUMzUVhuWVFsK2FhZHpWZWlUeWovRGtoSDdT?=
 =?utf-8?B?SlFnL3E0MUVpQkkwUm9OQ3BZclRqanBCSnVySzRkbFcvVzdQRG9LK1QwOHhs?=
 =?utf-8?B?UW80TEIzNkorUDBYbnVacENxK0cwQ0UyMkNibGVpY21PVzNlY2ZVNjc2Qzl2?=
 =?utf-8?B?ZjdZY2t5TnhJWXErK2ZqWDJHdWpNcTYwNnV4RytqcWkvVEd3ZWdNVmE2b0JG?=
 =?utf-8?B?aWQyb3NCSGZVaG94VStBRlJEUmpJSUFiakYzZlB3MVlvN1EzbndHV0NzY1dI?=
 =?utf-8?B?UzBxUW5mVzgrbTYwbERpTjVVZ0I1M0RtVE1EbklGcFgwQzRVZ29DcUZjelZr?=
 =?utf-8?B?TVhPbUZQekUyRXk2ZzJVb3gxUmlmTnpObko5QTI0Qkt2OXJDU2UzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13572348-8b51-463e-9147-08de9a5991d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:11:02.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM2BmhJu/i/wEyDmq70sJXRjIXuaFgDfkwLII1fzAwotB5cU5wUZJFzLUeHgKVGp2jrKDDUTcc1ruWvrCDFNHw==
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
	TAGGED_FROM(0.00)[bounces-3302-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A078F3FDEAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the if check since erofs_set_inode_fingerprint is already protected
by the same if statement.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index c932981a..2f78d9b8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2018,11 +2018,9 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 			goto out;
 		}
 
-		if (S_ISREG(inode->i_mode) && inode->i_size) {
-			ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
-			if (ret < 0)
-				return ret;
-		}
+		ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
+		if (ret < 0)
+			return ret;
 
 		if (inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {

-- 
Git-155)

