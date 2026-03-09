Return-Path: <linux-erofs+bounces-2549-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CC8Mr/3rmnZKgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2549-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9023CDC2
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV2lq50n9z3cB5;
	Tue, 10 Mar 2026 03:39:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773074359;
	cv=pass; b=LHS8ElJiib4rM3dUiAHmj8q+DKlS+jDpbgWurZUT4R1y+Qw1YOkU9oNs5aQbFZ3q9vuHnkcltfZIlkWRt95T5n/Gw4lAk8wJuDIMwgNoSUvCifVFh6aEzRiGbrGwcDRsbQIlm9TKXEfCOTqWfqeRebxRlDsTYDGI38DqDSapsd/l6/SDC0qeLWCl9XRP2S/TluJqQVvcdEWdeCnp2uibow8e2xndm61WhN9CF3+dbN9T+zXkqupsmauR30t4WQL+dt8v9nAKcY/gtN5DrQtWtIEcxrUlzFOz2R5CxxO+J9RUccznicGSSJ+5AM8yJrVwIKTyj1ZLxhqZu3jdxb3/1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773074359; c=relaxed/relaxed;
	bh=3CUK9GHmT2j9UGJGcPx8gg3OZTvuegYLjpGM39jzq00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/4f0k4adLlj1rG0x+eTo/tnHsyGhpcxvCzwRarGr+6bu+Bk7YcqPcX6we3fGfL2nUGK9By9fPAcc0JtbZkndrL/t5cXLHOIwhSVUT80p191H4Nq9obKgjG12xL4+f7pYJ6fjXYAz4y22xwQ763kSRcZhnCa6D5v42GDb9XgAVmaRnApYb9QPSOF2sXobpI/6ApGTAZoPeYMmhSxDDDQqJaGX9LSUp9F/A7sIWQUcS1YhxzIGrQNQ5ySjx9qqKgD0Ofe+HiDPM9u7Ilx9iYEpPueGN/w8xEcYntZ7SRKQGtiwmMozsPItDyMsRXeEUlHCBJP+0l+6X6dfhrWrRjIqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N4gJZhzN; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N4gJZhzN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2lq1fHKz3c9l
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 03:39:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6maD5kVUfigb6+zOU7KGnR6JGAdV+BJDWbOX3SNkGyFmcwsElCXnTM08PLW8BLXJ/QD9Cs9Cgjfu7qbn3erBoWBE3xKPtFGEndTmgVDzvqafVWHmGCP1pn82TcibT3vVF2ycgFHIyCyCEJqmF8lFjREi9zxKSkh/PTCrjYPTnPk/LSiONM715wxvTBknV1WXOPxxxLpaBQVpuz8yARu1mQtd6dfb4EWzdyYdbrJ11j0abNnqqaDbg9RxCFp5QAX++Ae0+mlNHAbUbOf8Y2JjCcVWnZyJ+5NMLNBfPx99vYVF3yUMN6J/Ryj0hdgUxOtNKYqj9R1ejpmS0U+kYQktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CUK9GHmT2j9UGJGcPx8gg3OZTvuegYLjpGM39jzq00=;
 b=xqihVs57HmIsvMsRcQHCiRknPdReqdW7JGocTlhNB2zqxdID5+MI1dvLNzVsl1ECsd+t7Tv2FEf+/tEYyyVu5CNPQ6OLhr7Bjp0FgKKpefB32EMpejAK7IY//8Q/dtq05BhUGovzbaZQAbgBTqj8v4VAXQK/NEdg16POGG0c9Y2bRGsScQ3BAngx7m0CLYaKMtHrgLszuH/fKdpTn4mcCtn7yTEZnAp8ZAw3optlf11dXCifBjkCqtimj/ArpdbQn8jcG7Ibhl8O0F7Y4xBCgBTtXJv4/lXWSa4P75CqhmXpgRwqyTXpbXVP8I3YbQnfU3E9PuOnSleZdBxT6ZzJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CUK9GHmT2j9UGJGcPx8gg3OZTvuegYLjpGM39jzq00=;
 b=N4gJZhzNJLtjSy1Ag8V1cYN7JqlUPJ3NRioa3NlZHUrsfBbPcxWKFQQk7w5JB0OOWu/qDo8ubWZqxWjWaRKKFOoVNfGM6bdy/kXksPatGBeJgAqCNr/nSZt6RrVTvjvkjv0gciistUz7oCsLYSb+N3Ka8Znl+A6MpZGCJTpONkxHHZcsd5nwzYiQxdLqhEHkH/T+wJYLT/eGtDVczAltE32zoRBz/OUWF/mbX6pEgFyCSLcJaPVPScZ9/f7GFfp6XsJgm5mMHS/8M0mBHYzNYkc2ArklhENiKjZWWMvJOWhPGgfBGrYDEnrxx8mr1sfldkoU7rXMn52AZRKteKxQng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:56 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 16:38:56 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 5/5] erofs-utils: manpages: update to reflect fulldata support
Date: Mon,  9 Mar 2026 12:38:21 -0400
Message-ID: <20260309-merge-fs-v2-5-2dd0ef53db4d@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
References: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f35703e-20ec-4e80-0552-08de7dfa56aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	es32Kmqtbu3bNfN+ITDWa7VqyvJ5H4thtcLifPAdtYoGrJUSVsms3jlW51Bgg1LCnEmK1iRxh6m+lPXH0JDxQgX0qCercH+nPV9pQ2yip66Vt5gzCCK4xwyxWu10i7VJlQcbSEZuzxG2cUXNtLtT/va/G1J7zKMeNqA31mD46JizferjuST5e1K/GXLoW3x9N1Y479FwW54O3OJaaCPoe+hafohsphJ8xDld8jLNzxONf7VqquOpwwUUJCP6wI0pUgraLudEFrJgT2cQxA7NHNiLKZizA4V0Ez5wvhS1hv+Q5XeUBtHaarBDntwSP3rqkDp1jR8XU20uUd0h/ivJ9lyx0BazpDUlnfq1MjNq6Qc4yaXcH0peji1D/jlLdtjsdmPx+fsT0CfHmBe+ReA93hRq8pSnDbdj1CQojfWTA9ELGg1ava/LaYLLEJeKontkiIYXvG4WgVA73oDkFSbAIgsrbM8AEfVgEAxSuMC6YOQ9Y1p+mYIxAVxqJ8I5yaziNlxC7uFBP+bzXUnxs/hV1TsS4fGEuIwwKFyYk4pPgjoAjXQeo8Ph/dUb+Z1mqIecyqJDxizKFZvNN5notBAyWHGaUTf10g6iPrBU2lV4g46Ls1XrT8tXTbNuf0NmIEHmpUKr9bGqrriSZyEDpUTzUQ3dbJDPHBKjga8pB4ac5zar6VMadii2ylM8YFNzNKYzoZsYmvzYKIVkuCo15g4vbmsRZlov78fBq0QAMquCf8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25zQkYxR3NIQnhFQ25BZFRUK0hCV0lxNWFXM1dINmV3Tytsa20xV3o4MTlq?=
 =?utf-8?B?OVMvVE1ObTU2Q2JINGtjS0lXWjU5RHpLeU40cHp1a290TW1PSlQrKzlzVWpl?=
 =?utf-8?B?ZlBPT0V4NUtNNk9xWEZtTEVoYlZYemMvd2YxS0U1S2kzSjlmUkpXR1hjRGpJ?=
 =?utf-8?B?ZzF0WWgyS1lCcXAxdzc0Nmd0a2lIRTB4bVpzM1RoeU9KK1RYUFhFVVFQTW1o?=
 =?utf-8?B?ZTZCbllNa2haaWMvRUlmUno1Q0F4TFovaGFSZzdSVEZzT0NzQmJDSmF4d1o3?=
 =?utf-8?B?UFNvTXIxU2VVYUR6NTVvdm1xbUdPOXVVVlJGNGhaVEJrSDgxaUZIeG9rNzkw?=
 =?utf-8?B?Vi9CTzVnZHZHMXR4VWR3KzBtdU15dTd3aVF0VFc2Tk1kNExZQi9rOG5LQy9H?=
 =?utf-8?B?RTY1RGFMUzZ0MHk0U3FtQUY3NUZBcnk1SDcrOHFsb0ZDUkNBS0hwYWJ2UGJr?=
 =?utf-8?B?djdVNktPR1pyb2hCZGJCSXNQZVZJL2VPaThGTVIvMGxDNm5UdDF3cUFSaFQ2?=
 =?utf-8?B?TFMvY0d2bC9Cbk1PVEtQNGxuYi9EUnMxdTVlZkRNUllycXphSFMzQUJnYWg0?=
 =?utf-8?B?MGdPVjhLQW1WWUgrTE9BNCtNSnVHUFhsdy9EWmp3TExrQjU3bEJRRnRnZFdm?=
 =?utf-8?B?bmpwQnJOclRBNzZMN0R6L0t1blNSbEhsZXE0czVIUmN6dDBtSDA4ekk3ck9v?=
 =?utf-8?B?K1hQNzdWWlN4Q1U5NmppcTRTQWt5c3FkWTdPYk9IM3crREpONEdDV3c5SERl?=
 =?utf-8?B?TEplTmwrSmNhbzJDWk1qZWVBRzhjR0Voa3JMUE9zOXlaOStmMmh6OVVQTWVM?=
 =?utf-8?B?T01hUFYzb2luTi9hUEkrSDM0ZjcwZnNLU24zSWFOWUJoOE9nOE9GT2pYalVT?=
 =?utf-8?B?eHVsQTNnTld1ZkFQVFNiVmtycXIvT1dOZUo0NFZEOHlJbFZZWjNkNEI5YzIy?=
 =?utf-8?B?RzFOc3QxTmVuQzJYU2pVZUhnSW03MFkweEVqbmE5WDc2YWtLQkRuTGhCbXRu?=
 =?utf-8?B?c0M3R0dseTl3RGJKRnFrbmg2UVRSU3NWdmVmVnd0eU9pSCtXL3ROV3laaHFB?=
 =?utf-8?B?VEd2dlM1enNmMjdyNDBYWmdWVEZrSnhnTGV3QWkrWmYzdDFPbGxvWVNad1Q2?=
 =?utf-8?B?QmNjcW5LZVJsSWplK2JLVlhCTFlPeXNPc2E0MVhlc1dyOVExR3dJdW1JNEJq?=
 =?utf-8?B?elloYUxTWHgveVI0c2xqM0w1ZndyVUI4S3lQWG5SWjQrd05lK1ZHb3hzOU1v?=
 =?utf-8?B?NjNhNVNQaWMrbG5RdzZFS0dpcUdvbHZFSVE5VzBxMzBPaXAwWDlSSmNZbUlN?=
 =?utf-8?B?emN5aGtPTnUza2V6dkNaWkpVa1pRQ25vVkNidHNibS9KZjVkM2RVT2JncHhx?=
 =?utf-8?B?alJRVmdrd2NOdTkwaVFSamt5QVVXUzFyRVJ0TmtIQkQyUnFFMFhYRm1HN3lG?=
 =?utf-8?B?a1RneVBha09JZ0RYb0wzelU3RERhVUNqV3BOT1FNT0ZyQzhNYjBIQit2eW5J?=
 =?utf-8?B?bktJTEZyYnhWZW9LaS91NGY4cDEwSnlRVFAwSzdER0gzNlBMM0FvQVFHbFJF?=
 =?utf-8?B?Rkk3VFo5RWE4ZHcyc2ZGckpLTTZKMnRxUzdWQXlNTFdwd3VtYnRIYnJRR0ZE?=
 =?utf-8?B?RnZNNHg5bTVsek1Vc293dXY2c3lKS1V5T0R5SjUxekNwWTg5QmlxdTdGQnJy?=
 =?utf-8?B?WVFoOHZWSWlDQ3FwT3BSVFFkRHRKdGo5WDVMT1lzYWZZdXIvUlFWdlFvRmtX?=
 =?utf-8?B?ZnVvQVQ5OWVyVHFLSEN5TUJnVndCY3VDK3lSeTUyelRXYWtaRDdJdXJzbDJr?=
 =?utf-8?B?bWtBMU4wK2xhR3ZzNW9jMkhiWThUQXpnVVJCMyttNll5N3ZneWNSYmlSS3oz?=
 =?utf-8?B?a1ljUFFFTURLWFN3VTN1TWtLcThiMDFjMjE4WU9XaXpxS09lSkRwM3h6TkhI?=
 =?utf-8?B?RXFlVE5CWVVDQ0VCZHVyMjRKTEZFZW1YWU9zVGp4Q05BUlhXOWorcGlyUi9F?=
 =?utf-8?B?ZnRWTnQ2dkdzRFRUV0RLZ21mRUJicVpNZ0ZkMlNncEJubUFBbjNDdXBYM1JN?=
 =?utf-8?B?N1hXclI2NFFuT29wTFo0ZzIrMmJiTXEvRkFObXNNMjNPY0tSQjE3MllUUzBG?=
 =?utf-8?B?ZjNsaEJNanlXNDRQd0NTWjY0L1BTNlNLOCt6enQ1aXVHWFZQUkljMUN6VzRa?=
 =?utf-8?B?eU1aS2JGYzdxbHJCUnhtSTQzUGQ2QUlqNmtBZEhtZStaRitCamtWd0tmdzRX?=
 =?utf-8?B?VktNZlBEVlBqd2tTMitVdVZlTDdFUGdRci9DdFByN2NYd3Z6T1RwOE85MGQ0?=
 =?utf-8?B?UjVOVjNRVGZiaDVpdEx5Z3N4ZlRPOU1YYjZzRERmbUpWY1VtbHQyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f35703e-20ec-4e80-0552-08de7dfa56aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:48.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: docvYJT0WQMFIbPJhK8rP+7iNrsZnhts7/t/JrKw/BvZXcjGxtLVgl2zqo+ZrCuNVpeQyR7sU5Ebx4QZP1PwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 2EE9023CDC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2549-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

Specify that data (fulldata) mode is now supporting alongside rsvp when
using --clean={data|rsvp}.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 man/mkfs.erofs.1 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index a102e65..65ec807 100644
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

