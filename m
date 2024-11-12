Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0249C4CEE
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 03:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731380359;
	bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jLavNVdoFBGN01O1JPQDgxXBkxR4hugAs1kQ51HaO2FqDWLRtUpIT3b0e7vvfhCUk
	 KiYlNiHzl2ce9J598hcDpc4YlhhoHqwZnTEAbzLuaTWa8DB1oTnxxpeDu/KccwMAww
	 49l+A7usSHOQj5osohKKGny4wmQp5ifeQ1lhfO93+gUzgNQC2bRccEhVKoyuVhP+CP
	 4Hb+cLwzlbxOT9F8Fx4yC4jiNt4+KoRRkM4BNZ56YKg1D84NvzKQnGK9ealsY6igUk
	 fYcfoxLJogPNRWkrUNQTDD2Tii2JDfXiFuzvKOaVUh5AKbLEOtjyDxEM1g49SIWVtL
	 CF41YR8yC+OPg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnWN72qmgz2yWr
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 13:59:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200e::62b" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731380357;
	cv=pass; b=V38fLA1QTZNdi27eRw8nIIVWaUmUAxDatFtwv5DmT3NK/Ag+gsxiDqzQIikoESnFNEZl/McMeMCr043shRrACXfIRJNGgWC8oEWKAnyfKpO4L1vrf6RAfBUw394ljDLRKZ2DF2amHN7w8ADzHVHKZDz1Qsc7Baf1VAIfPQdxrfW920cUsk9sswqbUiWuBT6PoILos9gXpQyFhGRrGxScQtbsBFMYFhlmc9i53apemH8OYioQ3K2NaBwMgOQ68/zZTSWMaSg8rScIDi07h/vvMyOFF1M4v7ZT6Uy7GuFxvVgOWA3eR9V12DoK5cFLqZmV66DaIYJ+9ZdpU2B7NZ47Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731380357; c=relaxed/relaxed;
	bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=izrcsK5XKkYnt0bsQ6yjEHi0Z7BlNg6x8reO8up0Y9CrLwmXVqPeK8Oh59xAapi63rWo/n06Q1iXiZ8sshN7EFCyHuSN91CA+eu7aw/OqrSMomdGMfRuPyPznyfWi5pUoUxh813IRIF4KpJDNxuWEkCWJtSo9YtXW5vOUExS6R4jYY+Kcntzfk/OiPfgGyTS78dG8ht/VnRabIePk20iRYb2cU4r62A8WGWB+uirFqK7vtvRDkQolk2UdzeKEe9Ax+0FBvcc1kzon3tFaKXmviTl1DEfOQn+KD4eNYN2ftuL5fra8Pb7f3oYYmT4IMJM9GIQU4VzqshFn+MSPyNNIw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ONBBZQGZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200e::62b; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ONBBZQGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:200e::62b; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f403:200e::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnWN34Q48z2xk7
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 13:59:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/HQoL69loJ6tzv4WyS+pac86RB+x2VSHp12VXrdrifYHBahZpnC2Y66Ouh5NNdILzPIvI1mUoaY7F+aBYE4bJUMqFllnnx7/Sv0ov9jfo9d8fpbKdTRCqGWmp3T2VivXe9t/f9Tlk4GcDHqUKZUgEl5gF9A72jtFQXdthuEk++uHTb1v0fjgmlzS3O9spwAzdDAZ5//V9qdOOG5YiD1HDmoGT12horPyyQg9IyRF/2YXW153M1fXWNvowmF/2OylYwxaIVGk8pccriW8wre88sWUz/xhLF1LXCiGS7FmSCjrAl9A5EtadNz7blozYTYk2CiYnmpdELOVIKAmGBZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
 b=c3ZvXuDXwXFcNb6VrsKCNhHH6E+ZVShe5rIT5O1kQpRt7p7TPh8M5t40YG00ydzBPd1tpgLVcmjMXV5cC8ok4rrMGILGsxGbadwqbabTXQYOZi0uWggMK0Y9BuJJInXU1UygR9pni0dJJogPzaBWd4Dng2LR7kqQVcDAfzUC9noINTociuyHR6Us/Kqsp4jvXrnUu56ii3ohuyOtAlKKf4itODk1aJ8UyltJV59XaGwFtL9g3UxA8qmVHOmKqQdCJh588lY8BMyzveKdBNCsF9J6dkFPZaYxu2EMi9jjW9XJGkJQ9hKVVsVymIRP6qZYzF4vOmy6l2DBrntYTCz0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
 b=ONBBZQGZqSO7Vs6hupQLxlYZppSJ1vq1LqL+4IOe/hcMtrJOzqWLn2NVIbL4hi0I6JaDCNryqIRwWG58N8sopOWmslNsSGpXs6/8594zAWK3KvXcK1ZkMAqQGchWjS4zwgzV8lrMUIpeejL0OU59TBKfBuGld9oX44CboU4KWzMwro5/T2yZehxD0c61G5rcfTZqJgmoVkwkLc3uQdjOY0iOIYoKcXFNvxFAjtdmz8i8CVwsovcBz//nNHEo8vT1lXCd/6yQM/pHK1/pc5305ueOnLiL/MLBZiHvVV02WkwHCWYVomGk1BYTJudRtNHoXNVTcXGovXDp4AgTe5Tr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYSPR06MB6695.apcprd06.prod.outlook.com (2603:1096:400:470::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Tue, 12 Nov
 2024 02:58:51 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 02:58:50 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: clean up the cache if cached decompression is disabled
Date: Mon, 11 Nov 2024 20:15:13 -0700
Message-Id: <20241112031513.528474-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYSPR06MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cf2e75-9d68-4a68-6e75-08dd02c5ef47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?QZT+0owaTK7D9kJMukaYR+pu4wBdDKnbdOQQbInOCA4IsnlPVQ/Gyj+WZ0b9?=
 =?us-ascii?Q?ad2870Rs583SLAeeVvvfuLoUKwJYoTVvyS03zwGyKZy4yKBuUzUajdTRQb7z?=
 =?us-ascii?Q?Wh2vCeChk2dgdEpmOsnrInksu+3nlxRWrsIoW49FoGQqCRlV1BJpTFlMsCdq?=
 =?us-ascii?Q?IYtecJjnSASk1t2NSYNuP81ANFbPhND6ms53nQRzXGT2t7i2MxnaiwpOAkCL?=
 =?us-ascii?Q?FZ6P7USCvUmbhkQhU2XzPRIDDq9w4Gz1+SLGyo3zggb4uLQk0IsskeWlbMN2?=
 =?us-ascii?Q?Bdm+HMZZ5W6OBfKgZs20wb5vACU0ZL6oZRiMukyOQJlgm+KFWNjFlmX3IHLh?=
 =?us-ascii?Q?j5bYddQvbiW2Wi7Wn/vh1uJBw8o9JjWD6/QwlEfP4IvcSAKmHkRabiuk1lo6?=
 =?us-ascii?Q?oTNiURjEh3r+cuS8yiAe91EqqFGBXXo/kzwCVDKgtd0tQ0FbUIOHyx3KPv6G?=
 =?us-ascii?Q?Dm11uGftUUJUg0EtrEO6R/KghR87BlPdfY8+QMws+uT26bMJAZRZimpIm3eE?=
 =?us-ascii?Q?fmK5ipWI9SYPM4smnBFtP+jejGjmmQ9GKiBsRig8XXxa1MDuAeSdM4J3+1IM?=
 =?us-ascii?Q?fnyMRFNBhHsFychgAt0vQxxls9V7kyCoFvFwRhv7FA2z21LEC44u6NpMd9TC?=
 =?us-ascii?Q?6dsRCXXu8tzpqBglzD+xTyqpce70kv4coqDWZZlXQG7sfks1YTxjj0CcxOFP?=
 =?us-ascii?Q?4yGW/pSUeIHFkaX9BE5DWZ0+8dwalrX3aNyHgWPqNaYhCpep+LDrZbpsb6kZ?=
 =?us-ascii?Q?UNH0MvGIvFH6Q7QIDcDQnZ5DVjDa8IhT1GIMvBgXLOphpNkHqAICKscV3Sq9?=
 =?us-ascii?Q?8Zjc87OkS3LfPe0ro8jXQr6TDPr7ZfzghjWSZFF2a8Ixqfb2cV2ohbvfi0HQ?=
 =?us-ascii?Q?PBAk7I2msRq1c7fP87IWHGdEiD1O9Ddra1Ml16tPhyydVepwkqmV5pmV33mJ?=
 =?us-ascii?Q?ejL5IZl+mqAF+ZfnSmHj8iq14tBpigRUeVoh2SO+Kxt4mDAQeJYtX9HU6n0Z?=
 =?us-ascii?Q?JdQYH2BEDQbgAWI+jScCeIovcdCTGbDmq/Neeru/DeZgU5vlnvmrtt3Xhfpf?=
 =?us-ascii?Q?t+OQhoeGM8X7zpw1tBuaya88K7rl/cBz2wqLs+ZZyj/Z4N2D+S8A0Kr446ST?=
 =?us-ascii?Q?0LghNENsmKyGYmdDx0LKXPGsqOrqWBKqSobFz4k2bFsNPyqeMlaIpVUhslAL?=
 =?us-ascii?Q?Pn5+DMq4pcZ0EK8zbiXQDRfwODDaYb5cphLCUOYKqWGBsIPEyl0SWBx+1Lrc?=
 =?us-ascii?Q?AajqknD+5/IZ6Is4YYxl1lGczzfnPHoXvF0zwPny1F+a+hNwsBNMQTPMzHxm?=
 =?us-ascii?Q?wLhEbmRndld/Ahh33hNzc7jEf1rFm/senD1Jg7smkQkQdRQa13BMu50iWLbc?=
 =?us-ascii?Q?OxYSv3Y=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?gTkGHZsRFV+oqqRMxBsjUk2Mp08BkptwYFwlfXJSBlVtGz9jIFqAIRdyc5zl?=
 =?us-ascii?Q?DhiP/FKJ2kbbDr/ZJqXW67n1AslY5T2eqitz9RIEnjFp9Ud1MvzwECSpta7l?=
 =?us-ascii?Q?tQJGPxC3a4fAzgx68VBQL/c417igBvH3zp8ohNj6A0ldSPu5qpLls8VU8KjR?=
 =?us-ascii?Q?+zOB/DcyhVqkfb6Kc292BLfs0tadBxnmcE79oxNtgsE0GeXP364l/PEaAHQR?=
 =?us-ascii?Q?xNbTgI06lu7FgYwzTzHfaDN7gyHZPFSjUpbezKcguNhilmYBSmHsYurOelpt?=
 =?us-ascii?Q?veWMmifCk8FUbmcA7By1ZJTy/2j+u2w+mdxsk9Bf7+5nt7yxEtO31O3j4lf4?=
 =?us-ascii?Q?mO/+gX1VkAtHhTOKE56I26h0YYK1cf5xC3BQ101Bon2h9YGpY0zb+vHqNhtG?=
 =?us-ascii?Q?KQdZwz8nLFfp4a2ezjmiHpkaXKHtCJPhRxHSPTb2k5Fc89oGAtxAsrwJj0f5?=
 =?us-ascii?Q?qd/J1pYzx1WAZD5hm9S7rKdAPzLfHU8iGA5QTFYsRxcxH4Dp9bRN966CjT4a?=
 =?us-ascii?Q?bw3HWy3l074FJXBplWHpP1zP+WShPbnjjmPNA8r1Mj/ySo1xCVFwAJ2JhIKa?=
 =?us-ascii?Q?JaeASTSEzfpX0iO9fZbKyEdIx7wh2jzFU6VTb8WuGKxiVwgv2FdWDvRuo57i?=
 =?us-ascii?Q?Ua8jcCVMwRzE+p6FHr+v4FNJMaiphGyQd287e+TAFjflJ60HFmzpKvGvaEj/?=
 =?us-ascii?Q?jJTc7UQ9faKX3ajMqiC5ktGgHVtVTlp6C8addz0qy4vGzgJW7MJ8KaLSQkkY?=
 =?us-ascii?Q?PEnKLslOq8QwgaSdWKFp1tD8WEScSaI6eeujqC59UcQu37lFnN8zxw/EMRcT?=
 =?us-ascii?Q?4kkpxHs7NE0PSAv+Ye/3Fxygu5dJ84XIool3e1u5ZByc0GrKZmgxpWm7kY5a?=
 =?us-ascii?Q?j7AbvsIYMwKV9M1aWzn/2zVifMSxfAOQcAELUONZzrdxDwnlHBP6VTQZ3h4c?=
 =?us-ascii?Q?HkxJvZqrU2DpiE1pHwvTQ1XEUKp9aKZEMHlbfDvI1ljSCy3mSfP9+EkfoO7S?=
 =?us-ascii?Q?l9Eb/WQ5vxsGHNqHiE2PE73989rsSTE0+o5c+JkO1wmGFhV5xMnzrlT1eU4U?=
 =?us-ascii?Q?elEm7lRRtG/YX7nsWvOB/st30+r+vwTLY+1bOwICdsLpZWezxbYVGJHIVZgO?=
 =?us-ascii?Q?vJzzZ8l4c4RBp4imoF4n9vkt+fjGyXyxWOdLBe35Vw4gqjDUyCmVwOlyxM4B?=
 =?us-ascii?Q?YbxCAeFPeaJVpMQ1XCjgL9kd/3rXxPX8WrYOqgxXl6r7sNuuEtZyBKnRgG1J?=
 =?us-ascii?Q?XSTdDv4TP2sy9lm7cV376OhXQNCAa49RlfNkqW27KPdCj8UbMSWP4VCdueXu?=
 =?us-ascii?Q?Ugwmp+x4NYVk6dt0MK4fpSlQdeMg4Sd6nsSP+6AWuzymvxAS3+YOt07A/Ags?=
 =?us-ascii?Q?Uq6wKtV51Iubc4BDSMlu8vGVRLUTeEddJCDNfzw5Ev9XyWQWhmzv3vY+ZWyH?=
 =?us-ascii?Q?KeKfNd6/9qRBrtPBbYRAitIT68uEiJmNArKnGhYnHhNnEoIMuhrli6Nmq2/l?=
 =?us-ascii?Q?8X/LusfcWVHPFYxY/MJgTeQfD2CZ0iLt1vdt1w8R/nVFG9boBZqzAKFE2Ln5?=
 =?us-ascii?Q?ODwIpKR7pMz8vImm6sqGtvt7sFC1lzWBe1w1Vrpa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cf2e75-9d68-4a68-6e75-08dd02c5ef47
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:58:50.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK4O6r5vXQSTtmqCH0mRY34ZvC7Z+udNX+jKoQySoO/oflI9RXNhb1usHnCI6WcQR90kWYnujQh9pP8zngCYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6695
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Clean up the cache when cached decompression strategy is changed to
EROFS_ZIP_CACHE_DISABLED by remount.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..de2af862e65b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -743,6 +743,11 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
+	if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
+		mutex_lock(&sbi->umount_mutex);
+		z_erofs_shrink_scan(sbi, ~0UL);
+		mutex_unlock(&sbi->umount_mutex);
+	}
 	sbi->opt = new_sbi->opt;
 
 	fc->sb_flags |= SB_RDONLY;
-- 
2.34.1

