Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E74358C1
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 04:59:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZXJS2K4pz2ynD
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 13:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1634785176;
	bh=Xre25pChu8Onpt/t/pO3tBUlebhyOb9rQIOf4iLgQB8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=n2atcRIwi3tB8h7A8smuZjP036mORbOOEr6s0i2uZCxaqL9uk9KtVSIBi4kRQ/Fm+
	 YIlm2rfB18h8J96YTIZ80hIZiDdSFXOUcZ92YanNFKyvYIujN2ZMkGKwqo8yV6gf5w
	 76zggJeQezMVVyk4eZet6QUfuXLxOjdljLjy3Gza0k+i7YwF3OagU9+Nj3AMiEuLHW
	 YgxNIPPvZRdzvSjy9f/NVb1bnEcGY+Avfhc6WE/WZOntlrHtLWOLNHG+xdtKvDnmYd
	 gqKHREPxEH/P45pheUuISord94/HDriLjd1poXigmcbHjyn8y3Zeti4TsREb0LUKvy
	 pzkoaRP45Hk7w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febd::602;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=QK2tn4YB; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febd::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZXJK2l7pz2xth
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 13:59:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhLJkYakYGiBlPSjQgg1oP742yz/AGbYHSdRhYgbV8ajp9QRRdEmDBKcsLttd8R9yXqsFUOX+sbRU8WMOtU6WLO/7C5sZrTGf4yEUFoXhlh80nI+ukNYjjRcW/ZqIHsSD4bNC+RJKeRcg2LnpyA+JxHS/eK5csaEgvuESMXiHiYdnthiRboOqDlAPmWHgwMMz9FApLeV72BEtuT9LPSWh/vfa7fV6DVdo9xFlmROFJZw5yw/SuiZ8CZ6r2WTQZ/DaNg4FUyfNi23jvaB90qDTHVB3HVhaOglXw4pe7KaQ/EybXsq7Rk+0A0xFv9M7kebKKfFvGOjNx671+59zZqimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xre25pChu8Onpt/t/pO3tBUlebhyOb9rQIOf4iLgQB8=;
 b=kXHK5OAQOc0rAW4qgdU3hSNt/AGgdeN/oMLYrsASrNmwEkKRaPEly0s5PMxKCGqx+ghxsd3yeHWJ9Klrbtuiz0drHRGT2q2tr6mPiZLjTl2ODlUVfXao+DeIs0ZFJFhdnbasKYCxhqzU245PIgu+rW1Unf/A5Qe5A0p67MnzM1x1n/UeOIo28CECh/5/W/N8xImOBZwkRKWMmYO5u5SqtwaIumIsrso9h7LDridCIaSDaPd2QGyJ+8jo0bNOo0XQtaYgzqr+PvkJlEdX+N5V2FhVmSWbsrxS7mgUZ8+WMQFQRNdyABDNARo4eWPonYQ0wXA0Pl1fIw7tgOC8QaEs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4203.apcprd02.prod.outlook.com (2603:1096:4:9d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 02:58:58 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6%6]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 02:58:58 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add dump.erofs to .gitignore
Date: Thu, 21 Oct 2021 10:58:46 +0800
Message-Id: <20211021025847.1136-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.255.79.105) by
 HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.9 via Frontend Transport; Thu, 21 Oct 2021 02:58:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e1d376-5d69-4ad3-cd20-08d9943eb984
X-MS-TrafficTypeDiagnostic: SG2PR02MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB42030F7DC8D038101C322554C3BF9@SG2PR02MB4203.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8B98OtSLXLb11Q7UoDsnZ90kijKUX7J4bEZ//8jadqJNw+jGudfN0hV0198WMPcBd1dBvOah8dUxYObPC9rUPmvroCNLpnvUXIcPWFAMIHsX9pbD3UxSjGWx6MMSeK/nIMFADMPJGwmvuU4/OESmBQcrL6CYNdCBUa4d1U18cE3HIc+Ag9mATgPvHcN4fAsmwTrGCByh69jpLnGud4PQUQGPGOs9V124uJGg7TpaU4QyUCDtIOiezM9lKDO8HbHogIw4HeCk7gfMSdZ2+Pb7VlcNIsy80gXj9csoi7QnqYbr9MWR/7zqqDB99r+SWlMSg4ij/uGuq2XDS2UPNiDMaAbVXfg9uEC57GtzlXImnke4eNsMo2PndK20yv2oE0XEaIWuz6RqtTVhqe8aWElM9x4BxlbYbinppZjt5HjGKDdMRb0ZHTW5SCuUP0DQat4ofKg+QFzkGb18YneqL55DqXNXSNAZEu9aoE/NOd1gj24IbVVldgXR31qmhg6EDPaZYmnCnv/THacFY24fPPEPz5VvmVh3IiVtxcMZwNmIDK6xDEtAP2QRuitjQE0LEwA0g6VDZpzV4c0xhbWStPHMLUCdpRGdPfUAwAsSDbReeT4UL3uHlOvwn2SFSH1gKyrZ4FVwVzlzBpa9QCXtkhcOniu3gELQFB0LjIcVajpkgxm18D3ER7ve+BnQIDb0CWynfXhLG34S3DIWfIDSwsEoXApQQLuhmAI/X/zy6Pa2Nca/4qd28fAcsfsy98G02l8r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(26005)(66946007)(38100700002)(6486002)(6916009)(8936002)(52116002)(316002)(36756003)(107886003)(6666004)(956004)(86362001)(558084003)(4326008)(186003)(2906002)(5660300002)(6506007)(2616005)(1076003)(8676002)(38350700002)(508600001)(6512007)(11606007)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T40PNTieYIDJPMrktQ6RlDymk9GBxAwWuM4wijdVcr9xduPcw/FWqkgJr4hk?=
 =?us-ascii?Q?OFdk7PTb4tib0EQcUExRLhT4TwEY0O9gfjerAFoxuAO+txaZilN2QJooVsv2?=
 =?us-ascii?Q?03kGVhDgGuJfd56kdb/UHQeX0oyhFxwnPYkC8lgy4SpYdUD+PdLcQ/KrjtIP?=
 =?us-ascii?Q?tt6NfH0Kxz/dzsOA+Qlo1NAEUnH5jnk/asyNjX+l+aKZBNGqp5n/oW8Kv4Wn?=
 =?us-ascii?Q?jiQVfw797f/5Q56MtEkQBztE7pX/c6aqjmqy7imnIE8G6tqxK9C2uWbdDBId?=
 =?us-ascii?Q?YE0sE8ZnSdz5rPbxRmMh1LgBrTutEcgxjLuwFKrJmDsmsnTLwvOKkvKzle4A?=
 =?us-ascii?Q?4gv7RGvwntsORwlg8QpzEewXDqgc8FSDi8G848w2gCTQa1qt8WX6/B/qGlu0?=
 =?us-ascii?Q?pIT8PJZE2mM9mXYKKioyEyiffblhzhRxi1L8hPGIfkw+rPcZiW1K5+MdETS5?=
 =?us-ascii?Q?w6WUO5ypS87g6J47jqo/YBl4dBi8Jvin1GGWdhXkiEhYjF7KsS6SEulB+fGa?=
 =?us-ascii?Q?kyBAlcI7xHl6bk6rozDgaLiRm9dKOy2wKjPSgFoucxWg002+ksJIUv5Bfomn?=
 =?us-ascii?Q?gH8zy4S11cdthxsa3dBH4Y6grha4Fg2VN3mYCcLOd30KK7JTPnf51mtc7jWO?=
 =?us-ascii?Q?benHcRa3W+Ge6TBVRBqLcs2o7EIN5jNSz84prc8wfSBf6tBlZ8cTm03Pm1wG?=
 =?us-ascii?Q?btOPECnGz1WZpXCr2BLqtKF5bOr5zmjHmc0pdZwFI60QrneZtRVq0kIod+SR?=
 =?us-ascii?Q?sslqxBUdNg32rB2wfibs8Qw2VOKrfeE9KmD72N/aUCbvgb5T4Rx+wswCBKHX?=
 =?us-ascii?Q?43yiMCL3C54ep3mh+Azkt114Hsxk7uk4MJVoZiu2HgDS5Jayzi4ZzDe9l7sj?=
 =?us-ascii?Q?0NT4cap60kG9GUzY2tHALwi3FMXO2TwRx2FpCg2UiEsQuczUFWPaw116Oj1T?=
 =?us-ascii?Q?OqbgwFwkPsV6glgjCATwv6m/N+xskWiDu47CVfy5l8pTp6BO1IXbCX6XrZ4K?=
 =?us-ascii?Q?qth9QyYM7P3dcgyDrgj7IdM5SfFBjFoxeXRtVjD8wq+HCTlyEY57BPJDW+hz?=
 =?us-ascii?Q?/attT5j3GBb+muOR/Qg9UZZ+vDYyLw4A9LQmU30tCCEExmjHZqrEn0be6e4E?=
 =?us-ascii?Q?2olQGHSqjjRsrHbSST2/YlwU4rCo+kQa94B/FBO8l8QATjR0esN+ga2CaF8l?=
 =?us-ascii?Q?mb84WzD3Cj3+O3LrPHBZTbD8XOC8uw8Qv/+ifL39IcI2qFP1YN5A04bUUMPN?=
 =?us-ascii?Q?GNVq2M3zeQ4VHxGfWy7cL4JcjC+qDQB9WPZQHNgyL9ihbwymO03c9a4nAAAc?=
 =?us-ascii?Q?xcbZqKqhhJOI6cr8a8rmvYC1?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e1d376-5d69-4ad3-cd20-08d9943eb984
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 02:58:58.0072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05IzxJWmLyRsXmcGEApKFvwl6KdoptBBUEIxHHrMrApgdgiZlowdZMBf5MiQOrqWZ/oab8yBF77sw597MUfaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4203
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 7bc3f58..27403d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,3 +29,4 @@ stamp-h
 stamp-h1
 /mkfs/mkfs.erofs
 /fuse/erofsfuse
+/dump/dump.erofs
-- 
2.25.1

