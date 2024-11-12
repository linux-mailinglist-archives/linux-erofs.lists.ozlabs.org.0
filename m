Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C0E9C4D84
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 04:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731383769;
	bh=y1M/OCwQAeUX+jUbldWwj02ROa80FCV+buPJlQNsJy8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=JVe8R+1oymHFY2nHDRkXb6VYrz8KcrCaHRJ2yapiX3iErAGi6cVt5j8tC7rNGQ2Oz
	 JzioMbJ/jR7ScN0gSzu3sF1yBUKhPsKE2R6gCOAyFqO0pisGve8KesgThutLgLeF8K
	 DnVSCgefn0t5jRbg/6mb0OolZIdLbBxTgkIJo4ojpoo/iuEWk+7An9UBJNCmW5vmxq
	 L25VFXKNDH4+ws+TLSEO2d7fvg4OAPoY80bH3P1cK0oTB01TF7S+ZqstYKu8SK/GsN
	 tUAnoZ2jJpv8URdfwKlXNNgx7w/ykaRpVcUbMtEz/fjrOMolKfaD/N2Oi2QrA+8j8K
	 SmG0YeYeJ2zKQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnXdj4lH7z2yWr
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 14:56:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::608" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731383766;
	cv=pass; b=GpUwa8OU0U5LaCYkZEJM4jt9IKZ49kOaJN+hPUIKQezH47fTC70brWdVL+R1sHDy83b6gNtNFByr2rT+uQN1EJnU8eJ+AR7Hw28G/Kog55hmfoqS0F5D8azT6Ccd3p6cb/gTrdd3EnohpETS+1djk8gYtm06IGktk0IsGlEcI6LnMCvGsxLtSZJwEKGUc4fB/yG5CqlJyPPrOpJ54VlWnlt8231ZuVa+Zlm+Ly18BOg3maDH/bEuyz0i8ZtVvZj+0t1jPtuSkJvqTtCwRVQftadZK6lH12L5uK7l2/EzdaBpzswVdYhdc4bUETIpkh3iPGVMn7/hVmjVpJq6OoSeKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731383766; c=relaxed/relaxed;
	bh=y1M/OCwQAeUX+jUbldWwj02ROa80FCV+buPJlQNsJy8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K2piVdjf8wCTzM/MLGfOse8ti3CIZALyniuWxyJn0H1cV+66ro/FevAfM2OLYdVFyw/JiU2Evo4fGQjzncEfwrcfG8YizLRCPeWTnP0lqXv+MBpD0+gxJ+9eXqhj3zE6ZNtISEEx/smHURDq8DjMZMrjKOPC6M6YNniMpDBrgk5bkVOZ/866WYUQhmZL2dGI5aE4oRFSsG6T4h0D4aTcFM1TpMJu8V00PtC6WuHAaLEpx1fD7dKJ4ddIGwvuFTZnnToT33FtaMivXnQQTffUvGHmgM8gSI3LNernDanR13Iqx+zKh3fVElGQdUTz5fQ4yY9n8p1yKENy0A+2DWvrxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=P1vRMgmQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::608; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=P1vRMgmQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:200f::608; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20608.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::608])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnXdZ10T3z2xYg
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 14:56:01 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdkStCAiUg+gxp2VEjFrU8WDK9jD3NGWqhXgwoHBCP3TdQnEilGy0GqcFb5FrG2BrSyrfXUBiFJtGjOgp4+V65lhVbExl6QdP/+7StStpDujr+e7+jqUnBE47WdRQ91aXMHjylAtgGephw1XAFvUOCbyMXCgX9hdWDe5dCjuTz7jgsMifb7jszHna9r1ICpz1StHtV83RLVxrboArSxVVral6h+EMYZSkK9LJEvJ0mogaULeH/aIqv5EYVyezEj/5KV2g29UnV39IHbVfXrhit4eFAiQn4bY6+VX+M/0DCvKjkkY+tos2WRV+cLVbONjC9QXmjx7Zofw68onSFRzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1M/OCwQAeUX+jUbldWwj02ROa80FCV+buPJlQNsJy8=;
 b=TgywW7n48bWqUxszG97/Qb3NbZh/FKxNildhwndUuHh7Cf/5RY7aWdnPUUNJ3k4ud8YA551kIFgOn9K6gbeqM027wVUJnjjJD9Ql8dsvZ8ofT8LmJB5SiYwoprB8vbA3o5c1iFWY7pGbEcEVYJRIxCwDdLZHoi02KsBswDe8XI4OeOqSIjRRcEyeotASJQiwvEw9O7wmM7NX7B8LGKd2HrEOu/g/SygZRScxPaiV7SrQp+x3mgBMAOh5rITwIwjuoleErqlGaiUu7CNRJKF0ClZNsCwel0t2XL0LiJxNuindMm85wQq76Lh0pohcmBQuBv6n2794y/WQ7+yEiibMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1M/OCwQAeUX+jUbldWwj02ROa80FCV+buPJlQNsJy8=;
 b=P1vRMgmQYHVcYNz+l2Cv8lZtKS1qHQLozzSAK+30rUE2j4clULKSaO9n0zKqBIwFNBjyUoKT/axw+tv6XNFsbCTCVogfjnXIqo4tFCevHhi4vcvNeYY433a3OwMJozSlOd+lCeCr0UrI9+29rlzIqvNS22cSil424P6JlZqPqYxxsXp54BtVcbMOvq5ViINOJNkyRfcY81G0OcyzUjm2fqS6DUh2BDOBioCw7gH9CnMneREwBSr1MMLm4fppARNyWeDIVJxhyHbe16J+xLAzI2Nblg3KqmzUBGPaBKRXL4GGquqUp2vaw0c6T0iWMk1+ZVzJITqnolMBhZ/KyE1blw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB5642.apcprd06.prod.outlook.com (2603:1096:101:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 12 Nov
 2024 03:55:37 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 03:55:37 +0000
To: xiang@kernel.org
Subject: [PATCH v5] erofs: free pclusters if no cached folio is attached
Date: Mon, 11 Nov 2024 21:11:29 -0700
Message-Id: <20241112041129.541307-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: af78af09-c73d-4d1b-84db-08dd02cdde0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?/uy0zocF415qfajAo0KEu3+ergkZaTLt9ddd1MvSQaCLEjAhN00gqqKTP2dX?=
 =?us-ascii?Q?swKbhayclPfinOEIfQKTA6pIm5bapVf2mQkCrKmFDc0jWU/REafrWKre1kzG?=
 =?us-ascii?Q?M/tDQuN1JQPGKMrM624JekU1tca5csltfufV6jtkl2DXVsBRVSdNoMCS/Yon?=
 =?us-ascii?Q?bjfrweosEq9nIUv2a/MKOOz9E9kyAVSkq6S7qMQXSCHgiZsRYeUBqUasHKgi?=
 =?us-ascii?Q?aKx0JURiVsDIPax09v6av9/3Uw48BiFFj5M6mn4Sx0fN6U1/tDhZgcWGOelh?=
 =?us-ascii?Q?aNio+2+DIojUh1/0D6iYXZk9sPmMKmqrj7tbsOk31gD4fR8ku1COTAdgWahS?=
 =?us-ascii?Q?sBV5JZgRtIBk6MYrnVYoGDDKIZokc1QzpHh6zWeMbYVgrjXBGizkFbpleh05?=
 =?us-ascii?Q?3Vg61BbFJwewS8onjDfzEtFRngjNhUK1DrQ7i8naPKAoKLeEoSJy0AIMikiY?=
 =?us-ascii?Q?Auj7aWUD7hc18IFFdCFzhECQn/oPfT0pZziw3K89OWGqZ7vaEeJ1OBBxEVoe?=
 =?us-ascii?Q?VMN2L7w6M5i7EjDuBPUkCLuG5nkS5ru1R5LFyn9A910At6MdTtRoDGtDllRP?=
 =?us-ascii?Q?TllfpqBPVxHKBwI3+4DH0schwc6iLhEiEiOsKvWBrkT6+j4Bzr8OISlorefs?=
 =?us-ascii?Q?+OpNfbySffAixn7U2ocpCLkEGbP6EVj16jSbp8O/7M7dsh7JbonSQDMPlzPL?=
 =?us-ascii?Q?8Z/byZkEo13EARatYkW/yGyVi//UTbQspTxgcXqWkOs/0tR1I1QdI07gyC4j?=
 =?us-ascii?Q?3LhmEE5RI5e3Fn/4b2fAdDYchC4T4XX4qu4EKwZOUoYcWwNokg9E9tcHxASy?=
 =?us-ascii?Q?PPaYuA6D/Y7q1QNyvuGTtRQytRSu8ovGs3OaK1+yEh0tiPGEV4Hg+9uoZIac?=
 =?us-ascii?Q?pV8Gmww0UyNXLvtVrig0hUtBBK5bF71s+ipouqc5LHS2itONSAnWFiAIXCqi?=
 =?us-ascii?Q?i7eDnPxdx8t+kyvuxJHRbcCEDM7mAfEBZcPkChT+B2cguxnk+LSwWAPfeHFa?=
 =?us-ascii?Q?OGqOv0+X6rdtDTCdi8CttmLDGxs7UMdnycumNRY8N5J/yIZl9r+Ch8ngtqOf?=
 =?us-ascii?Q?DnIG7ZldlHQP2uFiE9buGg+lLZR67+SBumIlW9cDngUxuY114E+ocpwVGTgC?=
 =?us-ascii?Q?5s/ikzPmDdA3me/L++pXvwDeOPvMuR7Xakd04dwcAvhL93a3Qdh9qfqGGrUz?=
 =?us-ascii?Q?JU/xcVbdj6ZmvQHrMlEVRs32qIrNRTande5GvaSsDuAQKfUBUoNrBQP6b5Us?=
 =?us-ascii?Q?qWyE1wXfBU3hbmJrtMz1svlHR2C7m1gaawOt6ASU33T7ozJ3CkbbJmibRjmC?=
 =?us-ascii?Q?dekmIAcfNFjz5kW2/NbjjplabEjiWaSsnxXdcG38w+XGjPclQ54Ooc6oKGom?=
 =?us-ascii?Q?JRCjGJwfwqldPdctiqH9Vdk0bj+d?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?zp3+iVFolLorQW87v9N6yRSB/cso6jbQmyDFrHd/BVL7cYoz5qhQfAnvQq8W?=
 =?us-ascii?Q?dCOtLgUJMXh0ewI5yR8b8MbrEN90bC7ipLTSBLW7z5xiz5t03d20izIFRR37?=
 =?us-ascii?Q?QPWdX09yjUei1hy2gtRhYVLK95OZJCDahUi6UMfBN2+OE8E3QHTsGMOhqmvQ?=
 =?us-ascii?Q?mJCvW0T36BZfEPZ6ESqImNbpBEMU4n9AcI1FAMhWdpxwrMZUqPI3eYMkaNsb?=
 =?us-ascii?Q?975rDFNR7NHjo9yoDgCprvy9oGVbMbVdB2yiubULbtzznA+hGC/sJKnNiCuz?=
 =?us-ascii?Q?5aDYZXlpdqGYEyogMpnxkbE2rcOMRTn72HKbUyZJcUOWl3kkhTh2eAJDx+0J?=
 =?us-ascii?Q?WFfrstSS0O2Mue+Qdfe23aYWGsT7xOhaMwCC7ph31tJAuKPM4LOpRiV0HSSq?=
 =?us-ascii?Q?D/Tm5zJ9X9vNkuc80QQJ4Flrkabq57uAuA2/ZEuxYEzrdnyLC19TWIZ+RXg+?=
 =?us-ascii?Q?D6J1xoZ2PcMzHOISuzfvusr/ttmZ4czaR80UIT8jigxQQAgboazPNQhnvGAZ?=
 =?us-ascii?Q?YNswO2h5mN0TQus9OfdZzLzBnjRdffQlAsnEfPx0eabE3rs+83q+hmbZZJze?=
 =?us-ascii?Q?Glxkk+9rXv1sSNzrZjOJHyKz/JQJez8maaCM221nVX++rEZuBDNRvxM7kC/9?=
 =?us-ascii?Q?mQWLYp55ah3Uf/c68ofT1HJAfCIfAHhz9L8Zx9dUlSNDUJZlOUpH5JQTAufY?=
 =?us-ascii?Q?d931jZSWoJwkbM4eAwTaTj1d20ftFyN+XqKtKxjgQtP54cKzRLkfBFhT3jGJ?=
 =?us-ascii?Q?u/Mp/uScLjQeBcw5prDP9nrBa5FNo9YMAPqMm4KJ8v5eYTe25gS0Qs5SAtyu?=
 =?us-ascii?Q?bbBgFclmCkmXl3Zg1DsFx0rfs4MYcmOuh5Hfk684UiWWeAphW7E4bJfiAFup?=
 =?us-ascii?Q?5uu2r33zsDkRD+ARTapxbemCbjNKhtgai81hx6Tz/HiPU6OCVXbDUMcdh6Uw?=
 =?us-ascii?Q?LboIvXOjawf1OyNBfLm7R1RYQ93JZE9k6roe54XtlsTgijQoRnfVyyffDy8a?=
 =?us-ascii?Q?aSf90PYs3hGnC5I8ivrabqgyN9W/GVFj/GlWzRo378x8L43TefIVLOeIZTWO?=
 =?us-ascii?Q?nSQB1cpoJPQg10R2Ge44Q4EpHTJ8fXeuH9Z4oVTopWOsC0QyEokU12l9D9UP?=
 =?us-ascii?Q?InjWd6+llr55IbSNVWyoP1VFzEG8HKft0HY0xpJ8gKUp5DA98XMRStnYwCOk?=
 =?us-ascii?Q?KKKZGQr48w8MGsYDBihDSV71nI8DVyZ89N7Zw4UT2xO0MRoJ7SQBFnBZkATX?=
 =?us-ascii?Q?YGBCw7n4k3xMTaQzrJaJrVmGLtVCGQSAaEfYBOZxdGeCA68rY4vyMZ3xhoKV?=
 =?us-ascii?Q?bL87DyOC8YDb6qqn1KIBJnobD8EIMLuowChv7DJn7wSQQEP6uHq5l72UA9cm?=
 =?us-ascii?Q?ED3vUcYZw/XD4/rYrux0r8rkGdtLqwV+67a+3FzBqZZjaaPMLVWo+nfBHri+?=
 =?us-ascii?Q?Gsq2D3AsebkZAk5sVZzTtvACD98kJHk9mBspfLV1XXuq40MhyQEHn2IjUUfx?=
 =?us-ascii?Q?EUVoCTfh7NErhb6w9Q3xMl43LBFGeBCFlmhelhP4qcFWotlUsxAHbvQWda58?=
 =?us-ascii?Q?Bs3G+QBRwYcoiD/4r65llvvu7HFvkoptPFPGmv37?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af78af09-c73d-4d1b-84db-08dd02cdde0e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:55:37.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws5UrytqLYBslVYwdS7nA4k1s6DCyFYA4stEnCQRj/Mff2rdDRWMyD3Oso4uoRi3k+9UfwJlXGfLjbIE3IPQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5642
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

Once a pcluster is fully decompressed and there are no attached cached
folios, its corresponding `struct z_erofs_pcluster` will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for `struct z_erofs_pcluster`.

The tables below show approximately a 96% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for `struct
z_erofs_pcluster` after applying this patch. The results were obtained
by performing a test to copy a 4.1GB partition on ARM64 Android devices
running the 6.6 kernel with an 8-core CPU and 12GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   11390   |   390    | -96.57% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 133612656 | 4434552  | -96.68% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v4 -> v5:
 - modify subject to be more formal
 - `--pcl->lockref.count == 0` --> `!--pcl->lockref.count`

v3 -> v4:
 - modify the patch as Gao Xiang suggested in v3.

v2 -> v3:
 - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
 - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()

v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6b73a2307460..737f33d28c40 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -942,16 +947,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (!--pcl->lockref.count) {
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		atomic_long_add(!free, &erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -972,7 +986,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1274,6 +1288,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1332,8 +1347,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
 			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			    erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
 				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1379,6 +1396,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
 	return err;
 }
 
@@ -1401,10 +1423,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
-- 
2.34.1

