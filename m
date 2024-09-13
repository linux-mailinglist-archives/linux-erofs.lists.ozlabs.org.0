Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3479782A2
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 16:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726238184;
	bh=zbtEd1y16O7jNaVaBss0NumhnBGbIRNrjnVQm1eWxpY=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=FrqiiT94eJyxjiLUrgXGtoGeihpTkAoanCg22lmfplietzGVgLoPco5x2+0nExhgX
	 2xv0vWT+flQMnquyglnpRXEdiPhGkkYRUEFh3NpTXspz50fdBDU0EcG6WxhdzTPsvM
	 nxzOzI/JCXidtueYLD0InD8rQVW57mLB9RdGxs4E+TnJKFokuPa2/t2kz9HoO7x4lH
	 yTNl216NbucEgZmWwY0H0g/lFqyUV8AIzaGIvQaXIX2cuXB/7pBfazoFQnfMu2faSX
	 pqJQvm+viiOwN7jYWVRSFoJ7H4LDLnt76fvtSrZBxA+T4yM42/+0Jowr/mQKvq++qk
	 JuX0Eqsxz0CaQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4xh82yM7z2yp9
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 00:36:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::620" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726238180;
	cv=pass; b=a9hIOz0cB9UJiyX1okkZ5Xcm559h1Jte4bdP/bgBBnKOGBSMDrjS4pKL7cmZ7zO9K186Bb7z1XeUM+E/L8KEdK2SVvQUZxpmNxkMH+24YT3May5ILiEEMgWRykXwHJwNpiv+RPN8e9fcpmJc0NtQI9gmxnyTd1katTzNCSX2DRSXYPVa0Z+YocWjCJ1hPBketervXIm1NplIz7uBR8jE6TM0UTnqKP63mlbQ3msQWG9FFeVX1F5JUH1GAGAnnJmF2P7KvwB+E+g52ZiFgdXqpaDifUx6vgKTV/KPpJZNge+RgY7wxuBrRNlN43wut+S4GIRkFYebFp056i6x3Ww/ow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726238180; c=relaxed/relaxed;
	bh=zbtEd1y16O7jNaVaBss0NumhnBGbIRNrjnVQm1eWxpY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gff4UHNCsLZwjZR8koQBJ/H88QW6QqAN26/OIwtkLi0gc193gkUru6kXjgPhyJtxKbsywDSbyHSA7unP838iKGAvuCAzLJRwe2mwpjDshG2DAKcPDcZzPu8zSFgnrcR6gK1ppi2uUCve5qnX/n9/c1kvaSGnTdWSZgVGkh/MIPRHTmtJSNpCZdVoZ5K7iNmgHKxlKjD5bZgOqZ5ct0tqi3F1XYD9F3q2bdQmmhIUjewf2yaENZzi6vjuV3HVvAiM9nzC70DuY2PsKbcCjgaj4ODX11SD+yRrllfl3GJBMbZ/S8BWrx75hi360SgXwqRMxBzfVed4dQuFIkd/q7TxQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=iS98TwNR; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::620; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=lists.ozlabs.org) smtp.mailfrom=oppo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=iS98TwNR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oppo.com (client-ip=2a01:111:f403:2011::620; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20620.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::620])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4xh34n9wz2yK9
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Sep 2024 00:36:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3Y/9gnkiV2ZMRA7OlF8vF5oVhcusbJWKNygKk6BtcdNQQuk1OV00HUxb41Wha9ka6ttCCwZyVumEXXiAGvLndMyJFlYJaaXIVfsRs/qxjENUMP82ExNQVRrQBkIweRC5MM0927ooSuzxNNWWLNpnSW0R7nU/09pKrl8S0Y35yn1TyocrduJAfGxzt7QTLGBoxG3UyoEYW5/nfrlgRZkIgFfJozYBheFNDmOjPXd58wLHF6SeLc1QmSAynXJbdhO7DUAyXMdifnk9klF6Zfxiunaco61sHieFTJfzOtYYeEHzzsttuBOkHSlsgm5YkhgL0dxi+uFLDWyHRb7TY6Khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbtEd1y16O7jNaVaBss0NumhnBGbIRNrjnVQm1eWxpY=;
 b=mmvRLHUdKnASWKXiJcIOIUzDg8Om5orIapwWdA8fjSYwK7lJP+HzbLjm1ntGJsEz2/mZUecoOswtRU9FEts2+7I71ruzf++SFS6Mj6q1w8btkkqgRVdlScM+deIMqahrFISgzOAs8qkYx2rcAm+a1RcuL2S+LkQ/kI4XG2oCRkdfB0ATfDlcgZCOJ5YpZS4twPqchWvAe4rZwaPk10b/HOw5XXyI5fueYM4Qe+NN+PDg2ocvyvazVlxslzAxJs15Fffs0jx9fb1ZZoNmBQEXNR/BSO8labSogdA9efP53NJexbzwgU9enJdqR0ysq+ONXW7TGIG+n3wiFyzq4vv9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbtEd1y16O7jNaVaBss0NumhnBGbIRNrjnVQm1eWxpY=;
 b=iS98TwNR+rQomcHLElN6dXF+UG+JhTg+KCcwfbOAOSrNdgUxNSpT/slWIiVxP9+b+TsBy8aFr7Q/Z4DF8JplWrto8uCJG5PRxlFg+RAaptRZfRlHdha9ShUFlMK+b9eXT9Q3+fKqDUdUC7R7VudINVgRnGiaZniNmHy1zNtjQoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by SEYPR02MB7300.apcprd02.prod.outlook.com (2603:1096:101:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 14:35:55 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%6]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 14:35:54 +0000
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org
Subject: [PATCH] erofs-utils: lib: fix sorting shared xattrs
Date: Fri, 13 Sep 2024 22:35:42 +0800
Message-Id: <20240913143542.3265071-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0198.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::13) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|SEYPR02MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: d3339237-9af4-48c5-3965-08dcd4015f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?YcFuQUYQTl930DN9qQmn3y8laY+UvyvvPdsb9LfEd+o7S0uhqMWNzZajCDy2?=
 =?us-ascii?Q?pi4WJiVu5PDNrFfzwxnj2j3pffxbYEl5n9EqVtloQwTUHQPPmBb7pPUpp5pH?=
 =?us-ascii?Q?K93XX81jYu6L7vvhmqF1p0Tle44pWvrgAlO7WXbmJmmF94kQWBMs1FyTUWtf?=
 =?us-ascii?Q?4PQnNZsUOpwO6Eb4SSQijg+WrA6HRJ2JvIbR/mKI9XqRPQEmVKvimxFRXpL5?=
 =?us-ascii?Q?JVuoNJzaAZDgNH7GR3YSPBLGIMdYkXaadWarkPw/I983i+YC61GEOwV6xAS3?=
 =?us-ascii?Q?LNx8Y9VVZtjU200155I5rm1Ws0N+1Gwey1GQl7Y9RvuKu0kKQ0+sz4ZoS3MX?=
 =?us-ascii?Q?ZwR5yqrmKXQdWZzMOepKirbMzgtv5AEvkNGkUDPyBMFSMxv7sZLB/AWW8Tcr?=
 =?us-ascii?Q?r1zTpl2CqWa9enwFTCkeZIv77eT+odrBWFUsmX2wb0HabJ0LDOnjfuIe2PRe?=
 =?us-ascii?Q?n6GpM7fqg5JI9vMcpBBbmjL/HVpJC9eUyHXGIR4rkhx62uzHDAGTYkgAK98N?=
 =?us-ascii?Q?wY/7val1y9wVQq3sNjopU1YCcQLOtqVk7+8KN4mm4JaOnsgjtQmXPAQa8SQt?=
 =?us-ascii?Q?EyMbG3zzAWiqY5Gn1blgfC2q0yQfF32HOuBpcWJAg9CdB7ob1u72XJS5xq62?=
 =?us-ascii?Q?8ZINmWy9Nz7nKIA7iN2n12kKq0rpdqS9wQIdokd+/ieKRqrATuAjqhxyEvHK?=
 =?us-ascii?Q?xRuFsETAv811QITjnWyxKoUeQNwdOZTZhF5P0bu5XlsOz1dI6gRBifEdvolT?=
 =?us-ascii?Q?LhuaF7yPKeErPEj6VNq28dPbTYg9CzzdHCNI0J5YkLnZGmP5a2040AjWUjzD?=
 =?us-ascii?Q?DPhxs50N9+SroB1nGnWn17BkFS6srOTmzJskveooFcvoIXFTL6qQuGqbYUGX?=
 =?us-ascii?Q?PjMZwgUQeFMKGtTP98Ibu3wDxYd8Cli8r9JrVi7q0R1h1Tdf8OtDt55Rgur8?=
 =?us-ascii?Q?jEXbL2TsAFZxdElI0yp0IthDxkbQ8zuE4Og4/AKs6/zVhe2vT/5BzV2Ej+Mb?=
 =?us-ascii?Q?7BKQ0YnwumIkTdm7I1+Qz44S8DVG0UVYsfcTASzaqj4l9TyRN0YNdjmBiBKm?=
 =?us-ascii?Q?uki8cc2RT54sNVG8Ja+RZ5DJeMLhfGDw+HhyKvap1OP8pt92CmB3+6UWv+x8?=
 =?us-ascii?Q?UjSBgPzQfi0SZCzv3IW+3YbH5WiES8eWdwFFN3oJtmb8PeOURzcRo45JIjxA?=
 =?us-ascii?Q?ROn/63TvOVoOJxDVLvEsZ9nCnjxYC9d3hJE/LyyV/Pe8zEKkHi9u+2j+/l1x?=
 =?us-ascii?Q?wDTVpM193DH9Dg+rS4LSK8mqwlj4M7r3u6dR3OQJSpjeOS1fMChjygrqbZAA?=
 =?us-ascii?Q?ey7nUcT8BwwYlBq+o7WvUqF3c/wN108H6yX4Nad55HPXQSe6v4xgllZdQ5tT?=
 =?us-ascii?Q?OrzCpBeoSRp1/u31YUmGUvVOURed/jikyi4gUNq7VKkCVtcE/g=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?dvGwoZpnnBgE0lGR6o7Tp1QNMgERLUmbpE2ELoNzEYYvF2+XwCyYLKgTMSxQ?=
 =?us-ascii?Q?TcCKOTrxFYY99y0sL8K392U3RPNWcD6PKNk3p94QJ2msu41QvxOsH9hVe/yq?=
 =?us-ascii?Q?/xi1KIRCX4ZiMXU1By0BRprvy4FXgWTFF/rqwFc5Uk7jT2qAJNgNuY0s7CKD?=
 =?us-ascii?Q?9Hfom5CpQA+/Kop3eqlC7RqKYZLlZITXYga1a+xPDQuxBZOGs9YA5Si+WISu?=
 =?us-ascii?Q?tdppVpLmS8nG2W1YAUwQVGaeikYX874XxJkC8g5gIWnFrsnTSXt1EWv8Yxl+?=
 =?us-ascii?Q?Td4CRXQ9brlsZqZ6audaCjPUULweWvlXlBb1dFhGlou7XAb7mx5p3/Rz6kbs?=
 =?us-ascii?Q?sSPw3s0beGKU7xBOC4LL3BKWzYpXiJvHUtS9zxpDAGWMwyGdMdAARkl0OHWD?=
 =?us-ascii?Q?81Bvq7GU172NILQjN0Phc+az/5+yft7iP5Z0ywceqZQgRIMzq/uIYTf+D497?=
 =?us-ascii?Q?G1p2sjz63yRej+o0VjCipokp+kFVNcCquKbYgH3b0g4eCzEQUnT2dGKxD5OE?=
 =?us-ascii?Q?PZxr/OoWAwCCrr7g1/FmBxZIS6kLVvDIL7OMaxs9UX/rombjjKnPjDEhgxT0?=
 =?us-ascii?Q?Fe0R75CpBbQABSsjl6lU7lEabjTSMB/+zkSBYDoizQrU/oQTmJ843hKwx+jY?=
 =?us-ascii?Q?LKxzPF828GhKe2dLpxdf0rDZ6SqINA5C6d7GRxQ9yx/UuqdjY049PKbZXKCC?=
 =?us-ascii?Q?9QwXDAwfN+0/tGzr4fM6NLcZWvXAlmnmjuBqgXhWyZIchy7NtzXQKAtDcCer?=
 =?us-ascii?Q?IWYZC9k5HT79U0S+KExa2Z8nTUCOptZ6R5kby7MkWuGkMQescZuFyDe3M6lC?=
 =?us-ascii?Q?7GI/WNi34wE31BLYTIrJEcL//8Ui/Cm2SjpLXirnnkyaKYG+Q90ZZHD4DADk?=
 =?us-ascii?Q?Ip8/rYH0/2K6vi8osVZZ0Q4iH9vREVllulIo3nRl8/QVArS8R97GQMAF/QEY?=
 =?us-ascii?Q?QsBuiidZyzv/vDqOdQVhwZ8KHiJH0b7820TYmWPNEqmAWWESOIuyFc61IGrt?=
 =?us-ascii?Q?SeuT917+1bjkNGoB93OcmVymYOqYIvT1sYAjhtRzfFBWtShvUJHEKPxGgDAb?=
 =?us-ascii?Q?KLVO4Nxu12rLMVBCGTHfEop/+vCsWLxR0CAOXf+//ZSXoVe3oQEVvQHUciYl?=
 =?us-ascii?Q?oUuMZ3CuzOVCufAW2Px8WoNptIYaBRt2Iei6g2HaQ8nCEWprGVmgSy4uZT8v?=
 =?us-ascii?Q?rvsZsMOo8f+aHfSmWJzbOWzsvPSn9Dki0ckNereV/Z6fI4d9xoIKTuo92s2W?=
 =?us-ascii?Q?M8B78sWZNI128SJZ9SLOZHGGtwdaNYw2VnCIm/K78hNq0yr3n4NGvIG/GkB2?=
 =?us-ascii?Q?TJKglDtNW3VO2RCNFCjMAina/X3mfMvcJYFTHnLkh3T65hBOvG1/6tUl59Ak?=
 =?us-ascii?Q?3B3J6JFTRIfssRNHxbM+qhF4HF23FzvckjoyshRWy60YnhBZ5PAfFdtGaLBN?=
 =?us-ascii?Q?YBtadm7QzXLkVth0LI8vt8VOtMWpkYXb6+dP9J2uD+QJm9Exllikkk2zXvKm?=
 =?us-ascii?Q?pC7IZBQLuzYTNKiS4hIHCPNQiVZ4pvhYFB+ga+bHJb8KJPT8IW3jjrm4BEEb?=
 =?us-ascii?Q?g77YpFi5dWyU28n0UWERXL48IunIHTRYAifbLwy8?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3339237-9af4-48c5-3965-08dcd4015f6d
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:35:54.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybTDzJf4pzRYWpjpCmLii73SLlIF/KKKkOheEmtREj65FdPVBHAQZQbz/SgRDDwKsBrdQBpe8RZvXmX+VBx3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7300
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
From: Sheng Yong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sheng Yong <shengyong@oppo.com>
Cc: linux-erofs@lists.ozlabs.org, Sheng Yong <shengyong@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The length of xattr_item->kvbuf is calculated by EROFS_XATTR_KVSIZE,
and the key part has a trailing '\0' before the value part. When qsort
compares two xattr_items, the key-value length should be calculated by
EROFS_XATTR_KVSIZE, and use memcmp instead of strncmp to avoid key-value
string being cut by '\0'.

Fixes: 5df285cf405d ("erofs-utils: lib: refactor extended attribute name prefixes")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 lib/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 651657f979cc..1dbb6e7bde49 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -794,10 +794,10 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 
 	ia = *((const struct xattr_item **)a);
 	ib = *((const struct xattr_item **)b);
-	la = ia->len[0] + ia->len[1];
-	lb = ib->len[0] + ib->len[1];
+	la = EROFS_XATTR_KVSIZE(ia->len);
+	lb = EROFS_XATTR_KVSIZE(ib->len);
 
-	ret = strncmp(ia->kvbuf, ib->kvbuf, min(la, lb));
+	ret = memcmp(ia->kvbuf, ib->kvbuf, min(la, lb));
 	if (ret != 0)
 		return ret;
 
-- 
2.40.1

