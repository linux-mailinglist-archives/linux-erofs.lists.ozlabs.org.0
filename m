Return-Path: <linux-erofs+bounces-1086-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB0B9618C
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 15:55:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWM285shBz2ymg;
	Tue, 23 Sep 2025 23:55:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758635744;
	cv=pass; b=FJi8CZj7QMYjMpBiGZxhzp+h4I3b9JamM09WhRz7MFD+OrhCGGSKaNvw8YxeRwBaB/gzIdcDbCZ6KwXIUAIZblaAmxOzoCwAJpruZL8+lFZYhAlzL1x9yRNwT9VetuXbzPTySJWtQWvuxdgzqacF1/p+1xhm3k0C21bVV2UGAez/LQ6xI3NlgijCNBav5iu21P+zuCTTyFkplK7r8yBczzwMOhSngp04mFJcdZnhFSyWK2VVQkmL1XYg1OzCUQ9meaf8060/J9Qc6Zg06tNOw6VcYaaSfhUvavTncpZNtyP369KCuwdbsgu4wbnoNTylk5hrxGjwHfLkB5BCzpXoBg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758635744; c=relaxed/relaxed;
	bh=AkvvTcWdeplUYVEnWV7M+R36lPmcK7OnxoywPv20OhI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dXw0xwVsZUyY/IPH63TqKjjbH+G8TPWAjWHWUpUfyjXp+Md9o/6/PTeYy0McLeQN/a+xk6cU93t8b8sUjpizd42SuwTX3NLL0fbFdZxB3I86dR0ZRLcXs5ADb8wE554GUL4Am8qnXvLi/bJVlcgadJOq11ZvkVYrADE06Uxjl0lGEYaGmrYf6d2a4iFf+9zbmu0rE8+2tATyy82xcTQgx5awK3Cm+WvorGNarh+y6ODrUh/C5Zs9qJoaokx5u+6jQgByh8Lhsy++iTuTUQQxZSdgaNYboWHt22FwRpcDPBad6n898O3INWxytWNBMQWIh2Q6M8Xp5zgQmy6ZzL69zA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Yl2sLH/a; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Yl2sLH/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWM261qGfz2xck
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 23:55:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxmi5gIie2xSOA7baWba1kApxPXLpJzwGhVt2GPFNkhXeXYUr1KRpjR5kbYNvI7Y2WnrfiVkHHuw1b/qjfvYTwQkM9aExfsbBJzYosxpifQGSalHa+cpFZMmmbGZLVQp8MViL7ELGkJAYotAhtzqWAOwRU3TwbvppQ+dp6pbn6Z/9E4eC7ThXT7av1AugxeSqBNmK7U2Ora3fCbo9INW8o9cYKRZXBHmzSOTDOypuyTuXa+tfLJCG5Sms4dxD1QX+JZYko3DtJFti7FrIsRHb7qfJLenDQcmu3paHt0gDloH9rz6dtcxZ7r2winDeYubNWwUDQ4abC/4Hci6CTm5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkvvTcWdeplUYVEnWV7M+R36lPmcK7OnxoywPv20OhI=;
 b=yrI9pGVx/70ckVTeB2V54r20I7tbWdKv6hCfWkCqLfQ2RtpL+bPYP/R/YIK1NB3/ngFfYC6uzM1lua4FEi1bi8ElF9EP3+Un7Gvl3h59EiF7Z6AF29rBKwFrn/kihQtSyVR+v78QZiDDhFEaRPMwumSTnU88zrT6VRoLung57dXpvH/15WcPeQfxLBpFBsn6aiGc74kTok3CZGVJPWrv4Ld2lrZxdlCcdiIweJLW3MqZI9cZmu4INdGBu7PWGMOw4lFSbOHDTGCDAZtu8v1PFIwFqGifXESsmh5nqvf92RX+ODAsNqejYmuX8YsXYNeCsGAmdmnc9+Bc4f4w9gbpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkvvTcWdeplUYVEnWV7M+R36lPmcK7OnxoywPv20OhI=;
 b=Yl2sLH/aTQRQcosFdVDT7l1BA9K8oITGkf/0CCggwuaDymQFYyqthrC1F3GcIyBPKAZFe2iEwD91GUCFuluatd3E82H1PXs8E18qHoFlHSppTt2eS6bx7qMNwckpv7YUxH/ak4swfUptO/r3aguw4xC5XoMKnl1OfqxK2p5YSpRq545bPfA3QDP8eUQL/Q64J6M2dUulbJnCm1vAgLTzn7npQG/49E/JfBBf89vph8uj4o5ho5Uo6qJFlqL5cLpueND/mFNEMBxWQ7ALYU7zwLHrXSrSLRCLECmAtusLz67/80xm2PUm+e9LdJ01+F1zfBiJZqC0OufWkeFH0JRAKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE1PPF1EB5504E5.apcprd06.prod.outlook.com
 (2603:1096:108:1::40d) by SEZPR06MB5786.apcprd06.prod.outlook.com
 (2603:1096:101:ac::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 23 Sep
 2025 13:55:17 +0000
Received: from SE1PPF1EB5504E5.apcprd06.prod.outlook.com
 ([fe80::65d2:75b:baf:a4a4]) by SE1PPF1EB5504E5.apcprd06.prod.outlook.com
 ([fe80::65d2:75b:baf:a4a4%8]) with mapi id 15.20.9115.018; Tue, 23 Sep 2025
 13:55:16 +0000
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
Subject: [PATCH v2] erofs: add direct I/O support for compressed data
Date: Tue, 23 Sep 2025 21:54:21 +0800
Message-Id: <20250923135421.460215-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To SE1PPF1EB5504E5.apcprd06.prod.outlook.com
 (2603:1096:108:1::40d)
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
X-MS-TrafficTypeDiagnostic: SE1PPF1EB5504E5:EE_|SEZPR06MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 1461effe-3259-4ca5-c091-08ddfaa8d37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJUzNBNOwHWjGH2AO0gp+WTEnRq5B2L0az1E/4X4Pkl8yhe8IBtjP+bBcwe0?=
 =?us-ascii?Q?DQ5C08pOKpgisRrBo6E0CKEvqCOAEQc2YnWyr5ZCaVW3I8m6tRBEYaxmqQ1F?=
 =?us-ascii?Q?HgOmCtuePcaZRFlvvlr5pMPE2bZZVdl3VBEWmaFPwDoHoES9lrjQfDJ5U5Yb?=
 =?us-ascii?Q?GvMMfq1K5O6IObEpBWi7xRFkjLyidssx/7z2xV1fOIy2fthbPkP0HKWlTa3m?=
 =?us-ascii?Q?WgVbW+mVCCZ1ulnWmp/7uvn3PD91GlRHhQ/MG7cSK4sMvspiFSN6/tGZpo8Z?=
 =?us-ascii?Q?eLtpqAbbATHYzc9lBNKyVKUkmIfDepX9X1edBFvb7DY4Z1zc7iwGJFyOSwae?=
 =?us-ascii?Q?VbIyRBMDMqnmlaQmQBMc7mJwnN66kfXYFsjg7wJS1VTphJcSfuEl2VmI/yBX?=
 =?us-ascii?Q?ZW1ll1QoJQWQVLxqZMY0pFOrgouM2EfXc6C6W8sVX9XGGwp1KVK2bQa/e39A?=
 =?us-ascii?Q?AFQbb5Bp0ExwYZkkDFNPGLFVnZsGnwY6Seo2zQGpFoP7+oDWGWQKGORLBRlb?=
 =?us-ascii?Q?tt2GUn1muQDRQfEK7Fwy9O6UVs37Mt5/JxWNj46Sw7E8Rst9NRrRR9wWIjlT?=
 =?us-ascii?Q?S8ScNkraDjd19FMt5GO2uhcky9bS50LD5Ce6pEFBAj130agZ5Vg//CGLPd2L?=
 =?us-ascii?Q?9nvkHFkEuYmPeZ1JqxkhCryybAU+gsaHLrU8/4QDxcDEoHD3L0raGY7ftNz+?=
 =?us-ascii?Q?NJztRhqwfOFStENCuMvbycr6seMx2mn695zXUdkDcicc2XFLFJmmsULBUZQb?=
 =?us-ascii?Q?4N4AYIaf4UFc7VzwPWA63OmBMurlrdienSEdDGH5A3k3jeCmqyzHgeDDyy74?=
 =?us-ascii?Q?5M20dKVEhSYedgXPXmjpVHfdgztF6/iwmFD2hXzH1cYqZVqoSqBudN8/NMQh?=
 =?us-ascii?Q?bgvOYA1kvppu2GfsPhva5ahroZJ8cLFl2Q0ZaPDqbkqbYNJfFubNl4guZlTT?=
 =?us-ascii?Q?zR/UJSHOfF6x6URSGSr3NyeJu2fx3BKvnL85qs1K9aiPcPqJaC/x7GcvTRHe?=
 =?us-ascii?Q?A0/HW9SftIRNn9RtnhQ7ixMCqwf0CWs5ZechOA2oDCTyYz86UCq4hORbPScr?=
 =?us-ascii?Q?+g6Rcs+cOYo5x3uKSeC9WNEKk5Hu0t6xOnLSwLJMo3DBvA9rBkKlpyaDY3bH?=
 =?us-ascii?Q?hkighKm7Ajob50Ou0ZvLj3EJgE4qYfXzDdGFqvrcTOemAqfI4HjDQE8XvyI2?=
 =?us-ascii?Q?PJYwkw6R3sVSBDdeLd1n4eFWqmFcbC21mB7jSHRI4zfG/M67VPAAni1tsK6Q?=
 =?us-ascii?Q?qPZTpjBN8czZWWDM93kxGCPzsnxlXhF3OZBB2z/COpKIMEu/sVQDbPyUSWuh?=
 =?us-ascii?Q?NrZ28iqRdH5Ua/Ghtui3KftbxGWzlZxR7hF/+uTT/4eci1UkEQkapwvOyNTK?=
 =?us-ascii?Q?AXm4sRaJGxLDpiDrYvcQ62/MTkKDA2gqFZTF24P62AeMEIAJBVyHAJLAft6j?=
 =?us-ascii?Q?Xe2DKw0XtVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1PPF1EB5504E5.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZUgYeTcYI2F4BBdvYa0bMgaUNWoqNQYOVGwMozfjZkPnrWy5NgOazQBYgM4?=
 =?us-ascii?Q?Vcnzxe1Gboe2xuUd4oX1+wdYlws71NHZv5bqt5zjcPXx/qhARGN5FQmti8gl?=
 =?us-ascii?Q?pQxobVrvYQyriaB+PzAclAeofh6Go3DyqhzxtPV//IaTCz39wjbRsQ9pDbIf?=
 =?us-ascii?Q?Ejr8vJIvog0lI8BIp6D7+5DOS7Zmm31u84xtypGbaFHhCgPdQXhWk0FSXLOA?=
 =?us-ascii?Q?t5xdkWvcYgN0e+/kf/7O2bxjLd7G5GdtnKRbEHSmQMAOJh7kv1Pv3Yvb4kf9?=
 =?us-ascii?Q?1YinJdqOlkn4AFUDJ4ADr3AFzbGZbdQbPRDOmR85HpmQH7TPw1hvnxSI4fjx?=
 =?us-ascii?Q?xmzHlcdnlGkzAn+pUmj1Xg8FScVtV/JaNIR0eJk2rijDgjOdoW5dBIz0cf+D?=
 =?us-ascii?Q?WIMn2DuePfz+iObYsM72Wn/rUJl+v4dz7hmsB3/eYeMb+64GQ/RvID7mkBYJ?=
 =?us-ascii?Q?i1W/sWdCQ/N4CEIrnxwx/I2W6tdrk5Q3S5wLR/h8qfVe6wK+XrzwJM3ns98i?=
 =?us-ascii?Q?ahH2efdoLCHeOwyJqbsjq7Aldqo0uZO46X4Gnct3JGaOpWuwu2QFMMMaa4gI?=
 =?us-ascii?Q?9hAvCbFLsd7AnWkgzV9p309ZYjnSF6UJBSTOjflYfqHGi6Igv4t9slp6LKiL?=
 =?us-ascii?Q?42zGvwP8C6oj/KsJZueeBakF8mm18Q8z8J/Z7SJGjWCNax9TA95V1nPErc7X?=
 =?us-ascii?Q?73hB70HDV2fQS4/J7FDaCh7MijGgmVxYWZTGqEHpl5BrZXC+NGjst8J/tCr4?=
 =?us-ascii?Q?yCsdBsWyGjjcXw4s6+824I5/3j28pHM95aDfQMekW0gFyTP/bRdwYAYBnMN3?=
 =?us-ascii?Q?daXSpdMu0sZNo/tpmWiEhBYC62ZveYZmsaqIDgQv7Wl6GbUY/U9V14AQv4mM?=
 =?us-ascii?Q?LGgXEKqC5gTwQcMxnSsAigI7JZO5N8kkypScmthuaZJ4NId95WgNUQszZz1Z?=
 =?us-ascii?Q?LgMUh6VzLnJ2E8SjtpGh3Rq4jWIfyTLhKs7mgLk+y7c9/3DXj6bvFwQOGcOR?=
 =?us-ascii?Q?ayzEmTqbkMqXP7eGVHFGbGALX/L+HPIRg/Cf1hDlxpdsZOuoC0tgyZiRE5G5?=
 =?us-ascii?Q?QhM99WkktVAX8tBaET1LzekTJdruOUw/i/srU4NIliBtcspMlUiRbXUCyLIT?=
 =?us-ascii?Q?S24OfYPLmu/NuFVPHYy709m3iwXfVaTd4ALBXCrVtuQiL1CuU7jEVqXh4Rr2?=
 =?us-ascii?Q?v7Hg2sxwYy/SZ+FE0x1vSHR03Q1C7R9gtiiaMTDlPDrBe506gjZAp2Y1Kf68?=
 =?us-ascii?Q?iduOtuzd2C+uT47UY32OF6sS+x6gwzIyjYKUrZM/tDA3TbnvrQHNOqzcDJyi?=
 =?us-ascii?Q?tNQO+M23E7KCqYcBN5i+y5wBXRwF9Jm+gOQ3BCv1T9+5l3xSGG81y4KWtlv6?=
 =?us-ascii?Q?mMmoPIrEjHvt367JvV30+P19K9VGO1KxsI9dsqpDHMAxlf10BZkavWM9KldC?=
 =?us-ascii?Q?6XGEqU3o//vNRztYG717xnAfv+diPAYoXX/o+AqEUdl0L5bQkySfxHauycoC?=
 =?us-ascii?Q?/WZp1s976VPCUtmuyQfz0vJJtBAi8Dutiyfgk/DBSkBjOyEExz/R9+IrpUbt?=
 =?us-ascii?Q?dGJkdcGl/3EDb06uZa8Uz7d0y+dRzXwNQMlt4xGX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1461effe-3259-4ca5-c091-08ddfaa8d37a
X-MS-Exchange-CrossTenant-AuthSource: SE1PPF1EB5504E5.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:16.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnWluxr9vFIjKd80Af03vys707HNh2uXzsGJXeeUBoJfzLPJPbthfTyAyq3CKqJAtJ0wOzgXyh8HhbATWgwFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5786
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
v2: remove debugging variable tmp_cn and fix compliling errors when
    CONFIG_EROFS_FS_ZIP is disabled.
v1: https://lore.kernel.org/linux-erofs/20250922124304.489419-1-guochunhai@vivo.com/T/#u
---
 fs/erofs/data.c     |  22 ++-
 fs/erofs/fileio.c   |   2 +-
 fs/erofs/inode.c    |   4 +
 fs/erofs/internal.h |  15 +-
 fs/erofs/zdata.c    | 330 +++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 323 insertions(+), 50 deletions(-)

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
index 9a2f59721522..1fbfc7fd2456 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -214,7 +214,11 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
+#ifdef CONFIG_EROFS_FS_ZIP
+			inode->i_fop = &z_erofs_file_fops;
+#else
 			inode->i_fop = &generic_ro_fops;
+#endif
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
index 625b8ae8f67f..ed8c232563d3 100644
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
@@ -1930,4 +2051,147 @@ static void z_erofs_readahead(struct readahead_control *rac)
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


