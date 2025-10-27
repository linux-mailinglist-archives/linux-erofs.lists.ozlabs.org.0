Return-Path: <linux-erofs+bounces-1288-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3EC0BB7C
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 03:53:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cvykf5Xtcz2yyx;
	Mon, 27 Oct 2025 13:53:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761533626;
	cv=pass; b=YFiF7/lLEG4UW9sSG5UsIu75a0MYyUcMM2XMEHfReCuKQAnrkGjF2Bfge3I9DibjZwsK6oc5T8+wWo+cds17jLfzIUVVmN5urZmva5mLXLfxHjhZIJvH2PQTMdMlWfdGfxd2N1jL3WtY2vW8t5zRb+3TzB/Og+GcCn4TZvVtyUfgHbAfPSlD+nMgwRgEfgvC+4Luo32KYpznFgmsQ3BfjTzfMCaRFU+epFbY3vc9u2whP5dOgSLYJWWL3DO8LLzehZNM1dGKWK0fOmhFYMysRXXjReJW1KX8wElkM9twq33F1DXhVYxMVcW04dXSTUH6xgsayKWoBFNoR1l6Apt9lg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761533626; c=relaxed/relaxed;
	bh=MAigSYP/7V/vwZso128EJah6PEk3Pqg2U6kD1317gnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iZX5tpgV2oo6SS2Rw+wOUv/iNEiVQKbNquABN7F74Hkoda7K4tj8fo0MPJUbUVTZNZ95pHc9fYOzvq48zVdSoRWZjeUr83YDsRUx67XBvog0NzniUio6TMeSZbjkwr8A02wDFQ6q24Ots04dmKeYEX/e2RyFIPIAAnxBZS3+Y7DrM08DSnndSWOHs5490Ph9vREz4pMurFLD+ZgLRO1PGu1kpdGU7GsomYLSMdRmF7kLbyJm1Fw3KB5jaLDgK3tyic5kj0T+8EKt5IQlG3JsL3ZdIyrzM/afdezbQgMj7GYyj0X2eWl+zeG6DGp87wqigLj978HmrkGlDdZ9X3H3Tg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=cRKI0+el; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=cRKI0+el;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cvykc58cGz2yrl
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 13:53:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAR1hVUPDmB7cGzQLSrsX86m1Vnd6jka4+HYVTUavJPzFHyYuIyAZ8eUN6aAXj0URo7a58nS5Q2+c2Nry+a0YtJcbBw0O71o4GzwGKU3J7mQABuInUH5jpFJjGsjn8hP2zMZBo/JMpSsM+tiRh1P3odNgUwg7Fv59KqlHQUIPNWF+As01i8D18dMB+/AhHUj/SzyxzdClvjadwsFQyCxTdsTLKE+hJafV+aQDXbZ9gg7a0jDHw2cbQ+qtWdoLvZW3L7mkJYkDKDeoUiTzG2Lx73NYm1hpFhKCN0INaAKsVAwa2hjoe+LGNucWjiy2iVlzBTsJHFc5JBVkGmkdoXapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAigSYP/7V/vwZso128EJah6PEk3Pqg2U6kD1317gnE=;
 b=ar5LcGnyM9aFASFF1cVcRCZ8+a4pXQQiQkhqWqLlXajLB7ibXlJNL8wO0JIba922SraAPjniQyK5qiM5fpoIkFbKqPN4Slh0daE4njWEEdIfzB6PgbGHvYFslk9rUeKCbSNnNdjCqEN2EwrMJuUQ9B7fpFWOzLUI+zYbKfow//CpBqRMnDOqhoVjvz7LazQyeThj8Iou7xam9fhEg+hcnYXRhK+47+kuRUKiDsJxiCFk6SL1Q7IklgSt7Lw1qooc5akflBgZJd/Tmke3FOQIjV8P+CqFYOkhOx0lvbUNr6tx/Hx5MqKY4titV1HePk8xb07D2A02fTyyFaj9Ur/MdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAigSYP/7V/vwZso128EJah6PEk3Pqg2U6kD1317gnE=;
 b=cRKI0+elxQedthfp8Tx3ZzfcJGtPpYlSscxiWaiCbHqxRmdzK8P91EpUf8etDrF+g104qnEFEdx7VdY/9VxvOJ84MsFmJSnlqBCqk4Aw/974S16pgv1n8MD1jMEgRNIuaDdgG+94Eu56XiFihZnFi90kZaFB9lW8rpovl+wSICyzk0Sb2jfH7aoA2hEXbEvNUei3m6GRhc5ICU4ddcWoJKImdswcRyAO9oF9xqGiq3d92g0Al4RIc5ClV421qvY1tpzM7dCVG+YBBaBcdjSlpDP61U77hJwTMv9zV/L/PsdiIYQQTsTlTFNzuEjCgj3OSxuHHNkqA8wF/w1YrseNNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 by TYUPR06MB6028.apcprd06.prod.outlook.com (2603:1096:400:35f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 02:53:19 +0000
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c]) by TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::5425:6b05:78fe:259c%7]) with mapi id 15.20.9253.011; Mon, 27 Oct 2025
 02:53:19 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Date: Mon, 27 Oct 2025 10:52:06 +0800
Message-Id: <20251027025206.56082-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 (2603:1096:408::90e)
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
X-MS-TrafficTypeDiagnostic: TY1PPF33E28B4E6:EE_|TYUPR06MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab192b7-5239-4c66-0e19-08de1503fbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0uOgac+TmwPJZ5VMRniX0RuU4dIbJ3cTnyny8WpKkycBaU2y6tN/0hwAwMZ8?=
 =?us-ascii?Q?pyi/sOQSgwirlaCa3gIJOcKiGsYbuivrNovJbs5AYYCMqmRAdcHbmqOsuJ70?=
 =?us-ascii?Q?pPQrESwM/5C8X6DbQqhWaM4CQyemfrs6p5SujsP8ld5gk0JO3FqEx0IAbvrZ?=
 =?us-ascii?Q?Qp4JSqjO0RIq3CYEq8626voNSem2ulqnCYD14keDrSrVMRY7FAHqhv6uoAPZ?=
 =?us-ascii?Q?pHMxwGNBdsXWTCCJilk3ne5I2k7J/+IjW/5pv8SU+ZnEVd2cP2dmAEMt/TSK?=
 =?us-ascii?Q?dAv2dDDdxHveC2dWvMCJGZwCKnkat7rEpvVm0GgWq1FOHXHDpcQCn3ZvL5ut?=
 =?us-ascii?Q?u/2IPGT6njtqXed1Ljdx0QRvU4iRnddXANNLdU3kKWR8CAp7CnKzzXlg2VUk?=
 =?us-ascii?Q?vHj9sjgtfi3BnG4kq3auJWUVGXaGSBUh1GEjRgq20aqjJp6TubetxrrGH0XA?=
 =?us-ascii?Q?EPBJRL7+E1Dooo9bpezGHEThxJtrQ8UCR+pf4qKGp0DnIh8ZLiCdsm9stD7V?=
 =?us-ascii?Q?loBYFkMURg16efKU/gJ2XlKylDcAvzTqXkeahycz2sZ7wzowE2J8iHK/t7lu?=
 =?us-ascii?Q?8q42Lu3ST8i46ls5Dda5pr45PEVJgw0fzCvK7bFkmF6DnLA/UHVGtWe+sZSN?=
 =?us-ascii?Q?5n/O2fF15+O3XHSYn69HMS0JnZAe5Z+bO3Jd8y/jTmGjed466r31rs89hLRi?=
 =?us-ascii?Q?znz91/ru0/VCv/OkbvSrBlbqCYxhaOoJOf+EF1d/ZWeG5QmU4WLfWhQJyw6g?=
 =?us-ascii?Q?G9FpvLIlEN/wM1pYSoie7o5/JFelznmLyHohUKhpGT2qHHcylk+tnPtxx6hg?=
 =?us-ascii?Q?QZ8mZpynHYiSaqAyGjGJKDO/YNfwTn+WhDHeD3UtP9aGwXwx6Czbj0dCWimR?=
 =?us-ascii?Q?+L0Oya5AFDHrsGIEaJS9h5hriv78HR3Zt5b11CD821ymsid3umNPd2BNbQ+/?=
 =?us-ascii?Q?rdDjZM1W/6QNKokK8qbfu8J6bfKcbxrl6KqdMsfLovl4pUU67s3azgNoLlmK?=
 =?us-ascii?Q?CF/y8l5uv3KoFSI5b/zl2fzLO9KxbuPunqLKdSTJoCnzHuhf6yehuSpnO6Z7?=
 =?us-ascii?Q?qF/gBp2eN04MlbkwWtK3jm7ia4R8paFV3yZjgj1+xLzltBCmUKeDmQ6KoRmS?=
 =?us-ascii?Q?xhtYue6lZU13N9qUHpXzxoitgFKzpj72z5BLK/nntAFjTrawt/t3KfZkkKJ8?=
 =?us-ascii?Q?XG1h0rygtil8OqzXPocolJimfsketpK4jH834PkyO5LzOd8xxExkG5bhRqof?=
 =?us-ascii?Q?/SK8eOAvFpvsbeBjSEmpz6VNKnbdqJbh3Gi9Y5+3tq6ElTy0KQhovyjRhtlG?=
 =?us-ascii?Q?sPOzSszsCuCmewCjGwgQVGF4J3laeWmEKsspNRhpJDqcmYX64yQGBvNEDlD+?=
 =?us-ascii?Q?DG0Lcf4GDfy0AdgbZCHGPZVR5CkJ4qTqFHa7P5/P1SeHB5QntC+87Ua8EO/P?=
 =?us-ascii?Q?omdXuRB1kT+8Bqfe0/hjyW3/RXAbVp5M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPF33E28B4E6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsM051teG/lAeMnuOPE+6USqwb/Vxgysj6Wbnd6XXcQzTxNcoo1XDDWVXtcT?=
 =?us-ascii?Q?aP15yauZKKYfP8JCHV6vzPfZa86BM8ZxvCY+W6B+3Yxkl7KAkv+VgYEIoL6e?=
 =?us-ascii?Q?yffoRIO21c/Dp9Twf60s1BgMcwqkNjibDBXvlCpSFSSPxiuDrRg5lfBotY8P?=
 =?us-ascii?Q?vEz0c8RQZJEDPbicLgYQ4mFZcrO+oBP1US2sNoMyCjcEFqlvjW+qVHqwqHI4?=
 =?us-ascii?Q?CK6vaSjNtCYdLbJG197XxfYn4SxV1lstTyDIxTimMszd/ozuHnRwYpeL8Pov?=
 =?us-ascii?Q?jXWK9MRHicHzYugbC8ZxFYKTojgPD1xr7KeFao9q8PCtxBv7+siPN+oy/vy8?=
 =?us-ascii?Q?mIXjHcm8vxllnlZ3ebZi/hJ7soA6j8FFSKAKP2OodfTsBjHQvgnMzwcTDPG+?=
 =?us-ascii?Q?/Z2wvBuC+cLXyIdCE40pY2D2hwdqSu4DY9QYqI4+Z7vvjEIX0ripfLeRKDFC?=
 =?us-ascii?Q?PkTx3CFYsoV8p1qiPAVBKDz1nrdzDfgWWwNQUpA8AFoBHPpGBCrw98OdIXZx?=
 =?us-ascii?Q?P2VQv13OTlBxsWg/G2DHhURL6MwhL8l2lggarwpoNbMzTD5XB5jTpzWQqD+o?=
 =?us-ascii?Q?RC/wFJLix3TBHAMNVKSzFGHhjbQ0YnxrbqTNSsOzMvMQKjh81onQEybi3tyu?=
 =?us-ascii?Q?BR4mvDdj4QHGMMtcMUqYRHY1xkVS42Sai8UlCloO6DLBihM8uRoSqwoVxGFb?=
 =?us-ascii?Q?wbQOuMSonAteDW1u9MYuAf5xYU9QTuPh28+DoBkMMwo1Bvualy8s+6wQFLAh?=
 =?us-ascii?Q?v2L3LtoCQpTAru/vYMIMxTtb1V8jSmH2IbcCYkuAYMUNCYKtOaYAFLgAT7YC?=
 =?us-ascii?Q?ZvlsXqiPAohgTTsSm2/wD85SHCYbnq69dvP+ubb11pBLZ0ktV2DWU66ECMwJ?=
 =?us-ascii?Q?X4GJTDgPEzG4AYl5Luw30lPxqtVczNqo5ouUlBJqb60k6VcXH2CchSheNwx8?=
 =?us-ascii?Q?XaBFc6DYB3PVM98W4uJIyavSdODLg3wgHK3Iir1F+A8y6sXxW0+Liz5XsEkL?=
 =?us-ascii?Q?oJJfdI93xVAt+0FY5X5CGO6HoqxPsIb3py3kwtFmaLPz5U2+zygK8K0TrpCw?=
 =?us-ascii?Q?qxvOwtfcyHFKoTkDGFjxpUVP1nvmz5OsTbkmhjc/Ay9jlnVbN9s1NDi/cuWH?=
 =?us-ascii?Q?Sf9AfHOW9MLv/5oHwHUPOMGeZOYPOxyKOQcG21znCVN9v948WBBeMpkdn9fs?=
 =?us-ascii?Q?K/nK7GZxuCCtmmiNG6j3zzfVJTasdmtbY9LdRSDEM4zX5cNDJ7AXXjDME0B6?=
 =?us-ascii?Q?++mwj20yzwFS/VRiNtpnhPPd2QwdomPG8SWpd/7P6e337MnSNwJRPNWXyNw9?=
 =?us-ascii?Q?3ekoPIGd3tfZ4YcOOG5YpDtrIBnz3sXvkDf/vuvOvkeY89ttCIPBN/OPbrkG?=
 =?us-ascii?Q?Tf+L7fi0gD1s/Uo4jk7ZKOkjOy3l5pMzeDzztC30pgFoMMV5LxtjI3mONbf/?=
 =?us-ascii?Q?IcS5fJmFmOiocXqtssZOpB7kR/C316S8/AcyHGn3LeK62tWqawSvNyxGQEJy?=
 =?us-ascii?Q?2ikdE2zZ4LHz5QaxtFT+BEFKo+SeIzUiRzMkKPjPSFLy0vPgvXW2F/R/dwYk?=
 =?us-ascii?Q?lX75p0i94jSy6qswyaGJXsIGQ+zB+l3n2y3ASiBf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab192b7-5239-4c66-0e19-08de1503fbfc
X-MS-Exchange-CrossTenant-AuthSource: TY1PPF33E28B4E6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:53:19.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3+Qh1iQImieKOjsewDp4oK31ThuIIZ06NIm3LqiPgC7Kgv4Oel4vZ0dt3BLK8GMhivgU++dAwBML671u1VN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6028
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In the past two years, I have focused on EROFS and contributed features
including the reserved buffer pool, configurable global buffer pool, and
the ongoing direct I/O support for compressed data.

I would like to continue contributing to EROFS and help with code
reviews. Please CC me on EROFS-related changes.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..f482c7631dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9201,6 +9201,7 @@ R:	Yue Hu <zbestahu@gmail.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 R:	Sandeep Dhavale <dhavale@google.com>
 R:	Hongbo Li <lihongbo22@huawei.com>
+R:	Chunhai Guo <guochunhai@vivo.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 W:	https://erofs.docs.kernel.org
-- 
2.34.1


