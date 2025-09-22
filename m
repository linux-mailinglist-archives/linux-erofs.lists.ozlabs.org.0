Return-Path: <linux-erofs+bounces-1060-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D65B912D6
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 14:44:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVjTq5lksz2yr6;
	Mon, 22 Sep 2025 22:43:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758545039;
	cv=pass; b=J1tHA5r+MCQyhFVp7YyuxZpvQBQQLHYAB0c1ezYVBxHpsQ9YseehiHumhN0iNdNy+ROhQcUBDVtTKhVOBbzMwy+riw7Aon8qYR3wPnX5GBZd8AKcSDowqCtRNVys7bsxCccMmHoOb1eh4D01/ypgSeowSiQ5qcq3jI9oRgRYunmE/+yvfBCeQ6qfOvw5c8RJhKCIgIuPoypaYOT/viRTpqzj42uYm2wmwTMWuMyFcvjTOMuuCPlXIAF/6Dn3iNQkFtyFmDV5kxxsPqZtX295uh1obVV0xtsfKc8B7cduCLsDEfQzb1oldyoHSaCLuu0TiW2NWpQhewkvNJAm7ZwcRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758545039; c=relaxed/relaxed;
	bh=MwVKsB2/+SiuCdINR5fIf9DHnyzPjPA70V28SKR+iHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=biL/e1z39MJShnC9mOMsG4xAus5mOtbHgGs+syQTukQbTUJi1Y1GaYdXG6cNsU9lEgJCP5OoWcAe2ZjkDoomeZ0BPIcJdr9g5Mk0Y9tZzdISg2BsH01JDKJF4tHBxSsCVVrN4LxwlEn6N/zAjEw7MBQvXqbUfDFWbWrtmOl+2Ci57n1zqMZPyCbiLYVYYmi5rPMKeGowdps/YptIxf6eoldOLqvIYgldauQipLwBUMOK7IlfJEJN5TTZELYNPm0twETsFuU1Pq2B3E7AsZbYkHm0J4pdnZCWoJ1LT81UVeQQuafM2An5WL3G5nejL8E9fZW/HMWprrujxCj5XP8N4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=KmGVX9aW; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=KmGVX9aW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVjTn2q4yz2yr1
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Sep 2025 22:43:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTotPyEqZmWDWHYd0IDecHn3wNLbuTbcHWHfMNP6KeA4YEu0sM5xkPLrt1N8rbML3qev6baEO7dY6qrvgXXGZFL0wD7h6NfL6WoqVln/rhU+egM/xb5tyq78EBZHsEJUyjt60kWUraWSx1MDh7ijfAIh6Ht/74Ye7Ow6zUsyf7CifhjgDwfAb42g1xReuQcyoSaKfvmv1Qf6Jg8HfwTvcLKdxOr/V2wXMfCoDyU8VUemt22ShIFHTK6jvqd3LwMgkHk8hAkeHC5TvAUS38w4s/+u7KB9NerQeIQjziV7BSNBFKn1ZVmCULTWQCClD+HjLSL9QVyLmznOivH9UJfP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwVKsB2/+SiuCdINR5fIf9DHnyzPjPA70V28SKR+iHQ=;
 b=vQe37SbAM1grCKtUEdDbo3uowF1jT2InpPKFRyaZXvLQj5TncJPixFbnU3vCLcDHBgDPHqFD316Si3nUWlLli0O1eOwN9Id3rIJNTcS8qCRqFV48d7SM1LWbn9cXD7phxQUr9ud7j7g5vv7g7SkEmUZZC+SOZK1ilLR90zCBsCUyDfi+vEpeEiyPURg9atVzGxTK0OH+1ED6nyWLZGc8JCYA5xv3J/K4cnbWPVON6wM3qcqCEimzDeYgu5k90vZqG1uGqDwdyUlG0wLl7lRrrtrd2NEySylypNzXnNcAZNXhKc81KSSVnk9UU2meni/7PlxrbsgJa+XetJI0TDge4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwVKsB2/+SiuCdINR5fIf9DHnyzPjPA70V28SKR+iHQ=;
 b=KmGVX9aWQwkKZQuhhGxW1s5v9EcU46iHOjkmjB6MetT0FEqH03H8Rx0Zc+VKzKxuKL4YqLlv/KR1AbHQPwFW+yb9inMfjdSZdUOu+t4zbXnISFSxV3WmVxXJO4DZ/EjYAXeZikbdsb7MtZ0oJuJzUxYraBfaSv/WmwRgltPxr1Q1zSuJ70DSsQOzWIINU8HOxNYaHxZwniD78D0ViglA7xLAiscJUQ9uiRxB8tAETpxL5ZcfPd75+1TPXq8J+AoHjhc1FDCnSvhEK1+RL4Tvprp54yHfeHiUA1ZkVVeBCqE+mUk/DM2a7KpjoJ8TuKrCDtXuRBrGcqT4JJBHWpKi2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com (2603:1096:308::24e)
 by KL1PR06MB7317.apcprd06.prod.outlook.com (2603:1096:820:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 12:43:32 +0000
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2]) by PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2%7]) with mapi id 15.20.9115.018; Mon, 22 Sep 2025
 12:43:31 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] erofs: add direct I/O support for compressed data
Date: Mon, 22 Sep 2025 20:43:04 +0800
Message-Id: <20250922124304.489419-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PS1PPF5540628D6.apcprd06.prod.outlook.com
 (2603:1096:308::24e)
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
X-MS-TrafficTypeDiagnostic: PS1PPF5540628D6:EE_|KL1PR06MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a78801-3f4d-4650-51f8-08ddf9d5a2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCMVaaStfVAZ2kOEKVKGZItuaK4NW2ykLAZCoPtZH1r63jK7ngBpOtlmi3BH?=
 =?us-ascii?Q?Cjv+V8ztbFM/Ck2hSO9F3NVNqz+aA0p2hQJq4XM8fChnCYJjjh8Q2Z/AlGU1?=
 =?us-ascii?Q?WFhPCaT60HFGA54DHRoLDHBRDsJ3boMGu9YDFirbJE/QuX2wu097YATCIKkW?=
 =?us-ascii?Q?TGx9Pw/PyJ05FpZRDSwu1i/pVDULH6kr3HYvbQiIXUDW4HmDA4jSe6eBgHGv?=
 =?us-ascii?Q?/qurNY7W54Zq1tCRkd68psNE9mUMCyln1kW8lHiAc2ci1fPSNzhDikpBDaWc?=
 =?us-ascii?Q?7L1X6Fm6u/bGLcoU8eWA4MDZagZuQ5CNgOOxPBhHRaojADXOsQ1boT+TaQPN?=
 =?us-ascii?Q?VhoJrhOAj3s2u58bcmM0WvjP2tbbb5lGJL039e4ejG9vF575zct1N+XHgVrs?=
 =?us-ascii?Q?zbUnIahFoGqbEBHCZcVZwRW//ykOgHnmsegAVJms+JmtsMsomtL00pXUn1ri?=
 =?us-ascii?Q?JOuwEa4tXkiqtKbKdCBuwIuKXCJf7erg3ZvENtMdXrBQqRVnBUx8xA9H1uOK?=
 =?us-ascii?Q?PF3Xz381y62CHPtu57tJWjcgblI37Yrvre2itS0hhRyF1Qe7xo8fElMJxtIR?=
 =?us-ascii?Q?TTq1xpQGwFD/i2wRi8u95A9Lfyxg/INZKxrjbBUgCZd3b5xBW6L3BjwiCn5J?=
 =?us-ascii?Q?WeiwGSAsJVJT9ZFlQADS8KvmkaGnSCcLFHDGNy7p9hDO5x5s0Ny/FFuxG3iT?=
 =?us-ascii?Q?IMv64i5R4IMxquqqAyIWdQpBhnpj+GUhmtFIK0c567+sGXWPtzCIUm6393R+?=
 =?us-ascii?Q?iuahKv506yvU9gaqSFfg2xHECfACrOkIO9G/tJrx0J+jWjQKSZH1oaQ7Li5o?=
 =?us-ascii?Q?pznCfTj5r1Casd23LiPgX85K4Mlo0cdIN5Q+ww3VquKN/H+dgGsz/rfKE4Zx?=
 =?us-ascii?Q?EAPxVkT9HuhaXXRm4HdgXjwgikKvC9IgJ+DGBd4fscaDvYDHRZexFLEXrTnY?=
 =?us-ascii?Q?tLFfCdjlen7sDIwZqTLYDYptj7fzQ7FDac/2yQEQSE3HOZLGNN6RBtA15lCc?=
 =?us-ascii?Q?fxXbIesxtoGwgUUa2LjmDqdJkeWn11DdM8tr3E7PmYmm54WxXQC2tU/ibF5N?=
 =?us-ascii?Q?dhnTentierOX23cnpM8hvGCFsDWG6lunkzQtTxqJH28wGv0kXXnWdW3dOp/I?=
 =?us-ascii?Q?4mWqpiU8mD8rQGNyyxeI4AlGdzk5jweWERHpASO1WJFzYohY7q4yvXSDZ3O+?=
 =?us-ascii?Q?zlC6zCVj6o+pw2uzAaxr+ru16Qtuq6svTyCCofWPvQ5FsEzpW2Oynx8mU+U5?=
 =?us-ascii?Q?oNpdX/9vhOV7ACconCP9qhC1lsizKemxnWuDw+dLlp7Oki1StniVLW5KMg8Y?=
 =?us-ascii?Q?yh03r2Vv/ANN+zt+A4EjtjB4q2hdbO9S6ya8mA5hdUuhb9JMHohP9attRlRg?=
 =?us-ascii?Q?98GpZ5QB5PefLvM6j1tocfBZR/+oekG/7tkLmOLlRn1dWF4zMzjGm+yXvBvG?=
 =?us-ascii?Q?Hrt+DfKwhYRAY3dvaMn4zPmUCWJERjQc1QYZYwRwvRlIZejrZPZViQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF5540628D6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7C8UPeg1xVwA7a+jZz1PEew+Yr2aU+hXa9ZM/L90wk9OlUOWMSCpTbzZ3P6?=
 =?us-ascii?Q?ndpiObONWMn+kxnY3PEz45htdgu1kKZQGUptRD8AtBu9d7xnDPS/BFMPWtPn?=
 =?us-ascii?Q?OD5l9r2GnNeXqRn/aV4n6dQxmXpyDa5AKdJ7JEFt5g1LnaGa5qUDcJ5stJV+?=
 =?us-ascii?Q?bnLoUJ96EYOqzYnIi2yfULekeP74l/T9HgiDvDdQE31uEujjSRQeMf7vw3F0?=
 =?us-ascii?Q?XqVJxvpBL+tsCgx8K7PiN69u60cGVtIhn9yrGEjVPj5BY5DnZklnTMIXT5PC?=
 =?us-ascii?Q?CjpSA82fuTs1AbvsWzKYMpaVeGoOUEdFaBXrSlBKGH0Q2n7fXsErJkgRRQ3C?=
 =?us-ascii?Q?UO5zTj1xn5PwHqM63SFGcbmfRLCRq95c68mETeJ8ik+YEobGyVRYlwQCec7o?=
 =?us-ascii?Q?uDdKdNXKPOw6fboGVRm0gB+DKqoVVzkXp+I7NZAAqpJHV/bylbr4cG2MhXpl?=
 =?us-ascii?Q?+LQqJhBOasntfrPCH7rExrwy3dUc9eBLKkTH5k9ZyVG1CBjc7zWEo7fTxXUF?=
 =?us-ascii?Q?w9EcL4Ya79/uOBAD1jTDRKNLHW0cZUOqoOf4Uys/xaMRxZ/J8pPjmb3LnDYJ?=
 =?us-ascii?Q?PSS9bAPvRUtcqrsUeWFB4rKeh9zhcUo+CSYNl6LuH3ebBo4wZiBwO3zl+EAJ?=
 =?us-ascii?Q?aHbaL7NPyH+MCW71oR8XorntOkn1W5hZRCpduiE75i+GkdENzQ4GCBLkJIqx?=
 =?us-ascii?Q?8uaNXETnBZuE+2g4Yv+dsy9ZbAH+JfrsWXKuHBjKZL0P18i33y87zRiHCm+r?=
 =?us-ascii?Q?olBZhtPmndxO7z/aG65fdmC/2PB7Vvz8Xy5h8MrhmaFjVNnDFNzB9uLUJ2XY?=
 =?us-ascii?Q?Z2kHOh1FpMNiGNy//GvCCoAbvE0wiRMZ0cfuOUGt9j2wnkBogpJWDp/M9PZe?=
 =?us-ascii?Q?SZdAz9P3d8yylznD9+Xc0lM8xzsvGzmtsCwY2AGSOC9tUHw3YxYXi/mftYGm?=
 =?us-ascii?Q?rKC8bjhlJl8o4Q+bsXcJVR7QBHsNnSm3mO56SqmuWyraxPTSg7G4sxi6hetu?=
 =?us-ascii?Q?wmw4FvXqFTPNIoaYOICiRYIFKsfMQbmzBFVUCDScBxNWZk6M6XIdqv3isOXX?=
 =?us-ascii?Q?zxHnNzAPExS/xEXwyO1mIKD1fo//yWimR+zVSuYmDTkl3TGGAjEXqcJleBon?=
 =?us-ascii?Q?DCXYVlwnLol9JLegIuooNr67VoyWAibKdmv54L2dccfT18bxG7XdeqGHaWDD?=
 =?us-ascii?Q?lg+Tgn3+YhjFS7Imck+ZpAdH739g0BVq41I7VzJ48dL+ixekVQm+KfA//Ufv?=
 =?us-ascii?Q?FDHE1loyQVpy7NDOYwX2lgycwNq4mXZkoT4bOf9jIJVCXEYk7kcrVIo2Yr1M?=
 =?us-ascii?Q?qnAaSS7ofJsE5RUzb1sYTLBLEDC0+rhyrJe3/cP+vlpDUv1SL3OLKU1h0a9m?=
 =?us-ascii?Q?SLNfh40Qu95qpGVJCDJNFk8ChUiuMbIdy5N8D+Nj50equG45AaJxGQMlZHSH?=
 =?us-ascii?Q?qnb6O10YWwbijDK7B/dPg7sK1s80zNjKUVJylWMqwNLhZGXOLaTWoUJuk32f?=
 =?us-ascii?Q?yBbNwV2hnB+EvTek5EP1hgHSDacUvv5LUlvat0HyKCtOw2JWrSl3fVGoXTNY?=
 =?us-ascii?Q?s+E5tIGGzb7sblqN+3+6iYJnzkS5vUYoIFIiG8Gu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a78801-3f4d-4650-51f8-08ddf9d5a2f3
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF5540628D6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 12:43:31.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nfy1CN3jRWw9r8DtTo9/Jdn4Vm/njQ1fB3uvuyte7Kb+Z1nKCTJluirvXsGIoV2K3n2jNSGe0yOHHefXtYFew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7317
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Direct I/O is particularly useful in memory-sensitive scenarios, as it
provides more predictable performance by avoiding unnecessary page cache
overheads. For example, when accessing large files such as AI model files
that are typically read only once, buffered I/O introduces redundant page
cache usage and extra page copies, leading to unstable performance and
increased CPU load due to memory reclaim. While Direct I/O can avoid these.

The table below shows that the performance of direct I/O is up to 54.6%
higher than buffered I/O in the low-memory scenario. The results were
obtained using the fio benchmark with 8 threads, each thread read a 2.5GB
file, on ARM64 Android devices running the 6.6 kernel with an 8-core CPU
and 12GB of memory.

+--------------------------------------------------------------------------+
| fio benchmark       | buffered I/O (MiB/s) | direct I/O (MiB/s) |  diff  |
|---------------------+----------------------+--------------------+--------|
| normal scenario     |        2629.8        |       3648.7       | +38.7% |
|---------------------+----------------------+--------------------+--------|
| low memory scenario |        2350.0        |       3633.9       | +54.6% |
+--------------------------------------------------------------------------+

This patch does not support the following two cases. They will fall back to
buffered I/O:
(1) large folios, which will be supported in a follow-up patch.
(2) folios with private data attached, as the private data is required by
this direct I/O implementation.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/data.c     |  22 ++-
 fs/erofs/fileio.c   |   2 +-
 fs/erofs/inode.c    |   2 +-
 fs/erofs/internal.h |  15 +-
 fs/erofs/zdata.c    | 332 +++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 322 insertions(+), 51 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..3762e7efc94b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -224,20 +224,12 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	return 0;
 }
 
-/*
- * bit 30: I/O error occurred on this folio
- * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
- * bit 0 - 29: remaining parts to complete this folio
- */
-#define EROFS_ONLINEFOLIO_EIO		30
-#define EROFS_ONLINEFOLIO_DIRTY		29
-
-void erofs_onlinefolio_init(struct folio *folio)
+void erofs_onlinefolio_init(struct folio *folio, bool dio)
 {
 	union {
 		atomic_t o;
 		void *v;
-	} u = { .o = ATOMIC_INIT(1) };
+	} u = { .o = ATOMIC_INIT(dio ? BIT(EROFS_ONLINEFOLIO_DIO) + 1 : 1) };
 
 	folio->private = u.v;	/* valid only if file-backed folio is locked */
 }
@@ -247,7 +239,7 @@ void erofs_onlinefolio_split(struct folio *folio)
 	atomic_inc((atomic_t *)&folio->private);
 }
 
-void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
+bool erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
 	int orig, v;
 
@@ -258,12 +250,14 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
-	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
-		return;
+	if (v & (BIT(EROFS_ONLINEFOLIO_DIO) - 1))
+		return false;
 	folio->private = 0;
 	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
 		flush_dcache_folio(folio);
-	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
+	if (!(v & BIT(EROFS_ONLINEFOLIO_DIO)))
+		folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
+	return true;
 }
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..aeecb861faa1 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -98,7 +98,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 	loff_t pos = folio_pos(folio), ofs;
 	int err = 0;
 
-	erofs_onlinefolio_init(folio);
+	erofs_onlinefolio_init(folio, false);
 	while (cur < end) {
 		if (!in_range(pos + cur, map->m_la, map->m_llen)) {
 			map->m_la = pos + cur;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 9a2f59721522..9248143e26df 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -214,7 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
-			inode->i_fop = &generic_ro_fops;
+			inode->i_fop = &z_erofs_file_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
 		break;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9319c66e86c3..f194ae889a73 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -407,6 +407,7 @@ extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
+extern const struct file_operations z_erofs_file_fops;
 
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
@@ -425,9 +426,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
-void erofs_onlinefolio_init(struct folio *folio);
+void erofs_onlinefolio_init(struct folio *folio, bool dio);
 void erofs_onlinefolio_split(struct folio *folio);
-void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
+bool erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
@@ -467,6 +468,16 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 }
 void erofs_release_pages(struct page **pagepool);
 
+/*
+ * bit 30: I/O error occurred on this folio
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
+ * bit 28: FOLIO is read by direct I/O
+ * bit 0 - 27: remaining parts to complete this folio
+ */
+#define EROFS_ONLINEFOLIO_EIO		30
+#define EROFS_ONLINEFOLIO_DIRTY		29
+#define EROFS_ONLINEFOLIO_DIO	        28
+
 #ifdef CONFIG_EROFS_FS_ZIP
 #define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 625b8ae8f67f..e27b17606ad8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -27,6 +27,20 @@ struct name { \
 __Z_EROFS_BVSET(z_erofs_bvset,);
 __Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
 
+#define Z_EROFS_ONSTACK_PAGES		32
+
+struct dio_erofs {
+	bool is_pinned;			/* T if we have pins on the pages */
+	bool should_dirty;		/* if pages should be dirtied */
+	int eio;			/* IO error */
+	atomic_t ref;			/* refcount for AIO completion of pcl */
+	struct task_struct *waiter;	/* waiting task (NULL if none) */
+	struct kiocb *iocb;		/* kiocb */
+	loff_t pos;			/* current file position we are operating on */
+	loff_t size;			/* IO size */
+	struct page *pages[Z_EROFS_ONSTACK_PAGES];  /*  page buffer */
+};
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
@@ -39,6 +53,7 @@ __Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
  */
 struct z_erofs_pcluster {
 	struct mutex lock;
+	struct mutex dio_lock;
 	struct lockref lockref;
 
 	/* A: point to next chained pcluster or TAILs */
@@ -82,6 +97,9 @@ struct z_erofs_pcluster {
 	/* L: whether extra buffer allocations are best-effort */
 	bool besteffort;
 
+	/* L: store direct I/O-related information */
+	struct dio_erofs *dio;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
@@ -112,8 +130,11 @@ static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
 	return fo->mapping == MNGD_MAPPING(sbi);
 }
 
-#define Z_EROFS_ONSTACK_PAGES		32
-
+static inline void z_erofs_dio_size_add(struct dio_erofs *dio, loff_t len)
+{
+	if (dio)
+		dio->size += len;
+}
 /*
  * since pclustersize is variable for big pcluster feature, introduce slab
  * pools implementation for different pcluster sizes.
@@ -506,16 +527,22 @@ struct z_erofs_frontend {
 
 	/* a pointer used to pick up inplace I/O pages */
 	unsigned int icur;
+
+	struct dio_erofs *dio;
 };
 
 #define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
 	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho, \
+	.dio = NULL }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
 {
 	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
 
+	if (fe->dio)
+		return false;
+
 	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
 		return false;
 
@@ -736,6 +763,24 @@ static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
 	return true;
 }
 
+static void z_erofs_pcl_unlock(struct z_erofs_pcluster *pcl, int err)
+{
+	struct dio_erofs *dio = pcl->dio;
+
+	mutex_unlock(&pcl->lock);
+	if (dio) {
+		dio->eio = dio->eio ?: err;
+		if (atomic_dec_and_test(&dio->ref)) {
+			struct task_struct *waiter = dio->waiter;
+
+			WRITE_ONCE(dio->waiter, NULL);
+			wake_up_process(waiter);
+		}
+		pcl->dio = NULL;
+		mutex_unlock(&pcl->dio_lock);
+	}
+}
+
 static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -766,7 +811,13 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
 	 */
+	mutex_init(&pcl->dio_lock);
 	mutex_init(&pcl->lock);
+	if (fe->dio) {
+		DBG_BUGON(!mutex_trylock(&pcl->dio_lock));
+		pcl->dio = fe->dio;
+		atomic_inc(&fe->dio->ref);
+	}
 	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
 	if (!pcl->from_meta) {
@@ -795,7 +846,7 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	return 0;
 
 err_out:
-	mutex_unlock(&pcl->lock);
+	z_erofs_pcl_unlock(pcl, (err == -EEXIST) ? 0 : err);
 	z_erofs_free_pcluster(pcl);
 	return err;
 }
@@ -835,12 +886,23 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		ret = z_erofs_register_pcluster(fe);
 	}
 
+	pcl = fe->pcl;
 	if (ret == -EEXIST) {
-		mutex_lock(&fe->pcl->lock);
+		if (fe->dio) {
+			if (!mutex_is_locked(&pcl->dio_lock) ||
+					(mutex_get_owner(&pcl->dio_lock) !=
+					 (unsigned long)current)) {
+				mutex_lock(&pcl->dio_lock);
+				DBG_BUGON(pcl->dio);
+				pcl->dio = fe->dio;
+				atomic_inc(&fe->dio->ref);
+			}
+		}
+		mutex_lock(&pcl->lock);
 		/* check if this pcluster hasn't been linked into any chain. */
-		if (!cmpxchg(&fe->pcl->next, NULL, fe->head)) {
+		if (!cmpxchg(&pcl->next, NULL, fe->head)) {
 			/* .. so it can be attached to our submission chain */
-			fe->head = fe->pcl;
+			fe->head = pcl;
 			fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 		} else {	/* otherwise, it belongs to an inflight chain */
 			fe->mode = Z_EROFS_PCLUSTER_INFLIGHT;
@@ -849,9 +911,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		return ret;
 	}
 
-	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
-				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
-	if (!fe->pcl->from_meta) {
+	z_erofs_bvec_iter_begin(&fe->biter, &pcl->bvset,
+				Z_EROFS_INLINE_BVECS, pcl->vcnt);
+	if (!pcl->from_meta) {
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
@@ -866,12 +928,12 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 			return ret;
 		}
 		folio_get(page_folio(map->buf.page));
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
-		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
+		WRITE_ONCE(pcl->compressed_bvecs[0].page, map->buf.page);
+		pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
 	/* file-backed inplace I/O pages are traversed in reverse order */
-	fe->icur = z_erofs_pclusterpages(fe->pcl);
+	fe->icur = z_erofs_pclusterpages(pcl);
 	return 0;
 }
 
@@ -1005,19 +1067,52 @@ static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 	return 0;
 }
 
+static bool erofs_is_dio_folio(struct folio *folio)
+{
+	return atomic_read((atomic_t *)&folio->private) &
+		BIT(EROFS_ONLINEFOLIO_DIO);
+}
+
+static bool z_erofs_page_is_invalidated(struct page *page)
+{
+	return !page_folio(page)->mapping &&
+		!z_erofs_is_shortlived_page(page) &&
+		!erofs_is_dio_folio(page_folio(page));
+}
+
+static void z_erofs_onlinefolio_end(struct folio *folio, int err, bool dirty,
+		struct dio_erofs *dio)
+{
+	bool ret, is_dfolio = erofs_is_dio_folio(folio);
+
+	DBG_BUGON(is_dfolio && !dio);
+	ret = erofs_onlinefolio_end(folio, err, dirty);
+	if (!ret || !dio || !is_dfolio)
+		return;
+
+	if (dio->should_dirty && !folio_test_dirty(folio)) {
+		DBG_BUGON(folio_test_locked(folio));
+		folio_lock(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+	}
+	if (dio->is_pinned)
+		unpin_user_folio(folio, 1);
+}
+
 static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			      struct folio *folio, bool ra)
 {
 	struct inode *const inode = f->inode;
 	struct erofs_map_blocks *const map = &f->map;
-	const loff_t offset = folio_pos(folio);
+	const loff_t offset = f->dio ? f->dio->pos : folio_pos(folio);
 	const unsigned int bs = i_blocksize(inode);
 	unsigned int end = folio_size(folio), split = 0, cur, pgs;
 	bool tight, excl;
 	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
-	erofs_onlinefolio_init(folio);
+	erofs_onlinefolio_init(folio, f->dio);
 	do {
 		if (offset + end - 1 < map->m_la ||
 		    offset + end - 1 >= map->m_la + map->m_llen) {
@@ -1036,15 +1131,18 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
+			z_erofs_dio_size_add(f->dio, end - cur);
 			tight = false;
 		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
+			u64 len = min(map->m_llen - fpos, end - cur);
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
-					cur + min(map->m_llen - fpos, end - cur),
+					cur + len,
 					EROFS_I(inode)->z_fragmentoff + fpos);
 			if (err)
 				break;
+			z_erofs_dio_size_add(f->dio, len);
 			tight = false;
 		} else {
 			if (!f->pcl) {
@@ -1094,7 +1192,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	erofs_onlinefolio_end(folio, err, false);
+	z_erofs_onlinefolio_end(folio, err, false, f->dio);
 	return err;
 }
 
@@ -1113,11 +1211,6 @@ static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 	return false;
 }
 
-static bool z_erofs_page_is_invalidated(struct page *page)
-{
-	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
-}
-
 struct z_erofs_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
@@ -1152,6 +1245,16 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
 		page = be->decompressed_pages + (poff >> PAGE_SHIFT);
 		if (!*page) {
 			*page = bvec->page;
+			if (be->pcl->dio &&
+				erofs_is_dio_folio(page_folio(bvec->page))) {
+				unsigned int end, cur;
+
+				end = min_t(unsigned int,
+						be->pcl->length - bvec->offset,
+						bvec->end);
+				cur = bvec->offset < 0 ? -bvec->offset : 0;
+				z_erofs_dio_size_add(be->pcl->dio, end - cur);
+			}
 			return;
 		}
 	} else {
@@ -1197,9 +1300,13 @@ static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
 			memcpy(dst + cur, src + scur, len);
 			kunmap_local(src);
 			cur += len;
+			if (!err && be->pcl->dio &&
+				erofs_is_dio_folio(page_folio(bvi->bvec.page)))
+				z_erofs_dio_size_add(be->pcl->dio, len);
 		}
 		kunmap_local(dst);
-		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
+		z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true,
+				be->pcl->dio);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1251,7 +1358,8 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 
 		if (pcl->from_meta ||
 		    erofs_folio_is_managed(EROFS_SB(be->sb), page_folio(page))) {
-			if (!PageUptodate(page))
+			if (!PageUptodate(page) &&
+					!erofs_is_dio_folio(page_folio(page)))
 				err = -EIO;
 			continue;
 		}
@@ -1357,7 +1465,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			erofs_onlinefolio_end(page_folio(page), err, true);
+			z_erofs_onlinefolio_end(page_folio(page), err, true,
+					pcl->dio);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
@@ -1383,8 +1492,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, NULL);
-	mutex_unlock(&pcl->lock);
-
+	z_erofs_pcl_unlock(pcl, err);
 	if (pcl->from_meta)
 		z_erofs_free_pcluster(pcl);
 	else
@@ -1520,7 +1628,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * File-backed folios for inplace I/Os are all locked steady,
 	 * therefore it is impossible for `mapping` to be NULL.
 	 */
-	if (mapping && mapping != mc) {
+	if ((mapping && mapping != mc) ||
+		(!folio_test_private(folio) && erofs_is_dio_folio(folio))) {
 		if (zbv.offset < 0)
 			bvec->bv_offset = round_up(-zbv.offset, bs);
 		bvec->bv_len = round_up(zbv.end, bs) - bvec->bv_offset;
@@ -1641,16 +1750,17 @@ static void z_erofs_endio(struct bio *bio)
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
 
-		DBG_BUGON(folio_test_uptodate(folio));
+		DBG_BUGON(!erofs_is_dio_folio(folio) &&
+				folio_test_uptodate(folio));
 		DBG_BUGON(z_erofs_page_is_invalidated(&folio->page));
 		if (!erofs_folio_is_managed(EROFS_SB(q->sb), folio))
 			continue;
 
-		if (!err)
+		if (err == BLK_STS_OK)
 			folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	}
-	if (err)
+	if (err != BLK_STS_OK)
 		q->eio = true;
 	z_erofs_decompress_kickoff(q, -1);
 	if (bio->bi_bdev)
@@ -1672,6 +1782,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 	struct bio *bio = NULL;
 	unsigned long pflags;
 	int memstall = 0;
+	struct dio_erofs *dio = f->dio;
 
 	/* No need to read from device for pclusters in the bypass queue. */
 	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
@@ -1748,6 +1859,13 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				else
 					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
 							REQ_OP_READ, GFP_NOIO);
+				if (dio) {
+					bio->bi_write_hint =
+						f->inode->i_write_hint;
+					bio->bi_ioprio = dio->iocb->ki_ioprio;
+					if (dio->is_pinned)
+						bio_set_flag(bio, BIO_PAGE_PINNED);
+				}
 				bio->bi_end_io = z_erofs_endio;
 				bio->bi_iter.bi_sector =
 						(mdev.m_dif->fsoff + cur) >> 9;
@@ -1796,7 +1914,7 @@ static int z_erofs_runqueue(struct z_erofs_frontend *f, unsigned int rapages)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
-	bool force_fg = z_erofs_is_sync_decompress(sbi, rapages);
+	bool force_fg = !!f->dio || z_erofs_is_sync_decompress(sbi, rapages);
 	int err;
 
 	if (f->head == Z_EROFS_PCLUSTER_TAIL)
@@ -1830,6 +1948,8 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 	if (backmost) {
 		if (rac)
 			end = headoffset + readahead_length(rac) - 1;
+		else if (f->dio)
+			end = f->dio->pos - 1;
 		else
 			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
@@ -1843,7 +1963,8 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
 			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
-		}
+		} else if (f->dio)
+			return;
 		end = round_up(end, PAGE_SIZE);
 	} else {
 		end = round_up(map->m_la, PAGE_SIZE);
@@ -1930,4 +2051,149 @@ static void z_erofs_readahead(struct readahead_control *rac)
 const struct address_space_operations z_erofs_aops = {
 	.read_folio = z_erofs_read_folio,
 	.readahead = z_erofs_readahead,
+	.direct_IO = noop_direct_IO,
+};
+
+static ssize_t z_erofs_dio_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	Z_EROFS_DEFINE_FRONTEND(f, inode, iocb->ki_pos);
+	ssize_t err, off0;
+	loff_t offset = iocb->ki_pos;
+	unsigned int i = 0, total_pages, nr_pages = 0;
+	struct folio *head = NULL, *folio;
+	struct dio_erofs dio;
+	struct page **pages;
+	loff_t i_size;
+	struct iov_iter iter_saved = *iter;
+	int tmp_cnt = 0;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	i_size = i_size_read(inode);
+	if (offset >= i_size)
+		return 0;
+
+	memset(&dio, 0, offsetof(struct dio_erofs, pages));
+	atomic_set(&dio.ref, 1);
+	dio.should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
+	dio.iocb = iocb;
+	dio.pos = ALIGN(min(iocb->ki_pos + (loff_t)iov_iter_count(iter),
+				i_size), PAGE_SIZE);
+	dio.is_pinned = iov_iter_extract_will_pin(iter);
+	dio.waiter = current;
+	f.dio = &dio;
+	iter_saved = *iter;
+	inode_dio_begin(inode);
+	pages = dio.pages;
+	total_pages = DIV_ROUND_UP(dio.pos - iocb->ki_pos, PAGE_SIZE);
+	for (; total_pages > 0; total_pages -= nr_pages) {
+		err = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+				min(ARRAY_SIZE(dio.pages), total_pages), 0,
+				&off0);
+		if (err <= 0) {
+			err = -EFAULT;
+			goto fail_dio;
+		}
+		DBG_BUGON(off0);
+		iov_iter_revert(iter, err & ~PAGE_MASK);
+		nr_pages = DIV_ROUND_UP(err, PAGE_SIZE);
+		tmp_cnt += nr_pages;
+		for (i = 0; i < nr_pages; i++) {
+			folio = page_folio(pages[i]);
+			if (folio_test_large(folio) ||
+					folio_test_private(folio)) {
+				err = -EFAULT;
+				goto fail_dio;
+			}
+			folio->private = head;
+			head = folio;
+		}
+	}
+
+	z_erofs_pcluster_readmore(&f, NULL, true);
+	while (head) {
+		folio = head;
+		head = folio_get_private(folio);
+		dio.pos -= folio_size(folio);
+		err = z_erofs_scan_folio(&f, folio, false);
+		if (err && err != -EINTR)
+			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(inode)->nid);
+	}
+	z_erofs_pcluster_end(&f);
+
+	err = z_erofs_runqueue(&f, 0);
+	erofs_put_metabuf(&f.map.buf);
+	erofs_release_pages(&f.pagepool);
+
+	if (!atomic_dec_and_test(&dio.ref)) {
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!READ_ONCE(dio.waiter))
+				break;
+
+			blk_io_schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+	}
+
+	err = err ?: dio.eio;
+	if (likely(!err)) {
+		err = dio.size;
+		if (offset + dio.size > i_size) /* check for short read */
+			err = i_size - offset;
+		iocb->ki_pos += err;
+	}
+	inode_dio_end(inode);
+	return err;
+
+fail_dio:
+	if (dio.is_pinned) {
+		while (head) {
+			folio = head;
+			head = folio_get_private(folio);
+			unpin_user_page(folio_page(folio, 0));
+		}
+		for (; i < nr_pages; i++)
+			unpin_user_page(dio.pages[i]);
+	}
+	*iter = iter_saved;
+	return err;
+}
+
+static bool erofs_should_use_dio(struct inode *inode, struct kiocb *iocb,
+				struct iov_iter *iter)
+{
+
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return false;
+
+	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
+				i_blocksize(inode)))
+		return false;
+
+	return true;
+}
+
+static ssize_t z_erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t ret;
+
+	if (erofs_should_use_dio(file_inode(iocb->ki_filp), iocb, iter)) {
+		ret = z_erofs_dio_read_iter(iocb, iter);
+		if (ret != -EFAULT)
+			return ret;
+	}
+
+	/*  fallback to buffered I/O */
+	return filemap_read(iocb, iter, 0);
+}
+
+const struct file_operations z_erofs_file_fops = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= z_erofs_file_read_iter,
+	.mmap		= generic_file_readonly_mmap,
+	.splice_read	= filemap_splice_read,
 };
-- 
2.34.1


