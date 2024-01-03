Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5FB822C92
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 13:02:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704283318;
	bh=NKPlHKXGPmSZ30oCEk45jCXzVBPhul+V6c5IbL1VpJE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=PAEFVvFE/VO/yZP4ThZBIZj0O1QWrqpf+SjLg2d7Fl7MniXz6Ss/xiFmW7WkLg783
	 YfieEkrW1CEfI08kG+bAQVfJsy46lwLR02jcOce4wxEblillC5ALL02p2/S3KF04hx
	 XTAX5ub6PdjQxFh5bh0Z/bZTqN6D3o6mu9N3+FquWaGi2VrXVbXB0e91lW4+DhdJpx
	 J7F3CXtfr6qyLYWODm30VfMmAuWNAoOF234+WzqdVuocnEoelzwIAJd2KioamLFNLh
	 P7QoKbhl9flUFU3R6Vu94UAiW1muQNcslguZqUhmDcrTtxgAiX0YaLhqzrl+Eej8QS
	 mE0YmTR+qybbA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4pHB4GlQz3cYp
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 23:01:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=CY0cYd42;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::700; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4pH31nFNz30gJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 23:01:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBXbt7oOeNoPl9waj4DjcbN/lSopSPtiDK70eWXnjVXwgy4LvXYXEWY5wwBXPDIrsDB6aIR1eXqAEwpzij6RU6Cc063yNQ3b8n++M9TQDOki1OnHMJhGnkerXjufAkAhSWQydDncyvPUxXDfcYKPEfw+ikYNNg86a+OBcSMPpM1ivDv0X83QfhYFFOO4IDHz0mkjkXvHr0Es9eqn0UemquzndbsqsL2tJeLvJoNFPt63I2L36Jd+8jAqHH9vXHQ9ecnT0nmw+xslauGGXYpB7BeymhMrVNiTQN+5ySio0TFuzUN9jzXni/NCHpFbaByjbzZGnpHj7WzR5YH93rp3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKPlHKXGPmSZ30oCEk45jCXzVBPhul+V6c5IbL1VpJE=;
 b=FwHIqhrPtzaFIMz8px9DTQua0UgEDmm42yPsi/99so+gLZWOH3D55QWuB39PdqHPN9J4phc+TUKgNtFRjnkDhe+eJ0fIpqKkXyvEx8ogPwg2xqN82GA+RzQIY3y3sFvJIO91aKDDJQMOQQMWwAm0XLBqRQNYJx5do0fAHIbX3faI/dztkhDVkmLhPLbLjrDREDp3u2oFnTj5yM/+L2iIPCLFZ5sUvz8CeaTZrtentA7DJJXiLZyNPIhfTdupwxifafPtlUHpbo2XoK3P6+fdbFwJbdK646Ustx02Ax1be3z3AKIvAbxjRq9lmeYyNmRrjTyNPKQ9QSwG0q7yjrCjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB7171.apcprd06.prod.outlook.com (2603:1096:405:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:01:29 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 12:01:29 +0000
To: xiang@kernel.org
Subject: [PATCH v3] erofs: make erofs_err() and erofs_info() support NULL sb parameter
Date: Wed,  3 Jan 2024 05:11:40 -0700
Message-Id: <20240103121140.3049732-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 025711b8-34ea-4d1f-e07b-08dc0c53b7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/dM/fDkgR8u5iGm1+lOTYjODc0jZHA1XYtWLkndW19/Ihnuvu0Nlnbivr4CymFzsHBcRHCSHjUztn+vhdXD7Bp//UWhsnkkyIqynunDqyRjazpkmRW83TfEVBQaTfPb3P0uiLcyRasY3+xcZ4hY+WGkfKhyTq4YHqjyqOqC13S+V9bIbXwlW6s1Y8pYGE0z1zOJSiufyObJQAPuXTRx80B9O38tmg4/NPMbyY3FapqzziORRNWNyx4Pf8WqqMUbfzjOQ5Us3pirxNbuDBLhKjDE6LJ4PAY899XcBAyEBFMnWNCI5nWHl4b036GWS+UBk0ESJxjgX+nvpyUXe9/9YkU6OKBsS2ROh9wstDtgA5osWmYGsBUYpeIuHj4LKuxD7IvTy1tUlWMzMcrpoj9PYXORUt3cMhnkeJUJRJndihpLUCFsgi+ulakv6OWYHTFos/2v33tIoR83SHQzl4OouMMztKw6gAjNiGU9YYKZOJh6VtZmU0uoe1nXGGMa6x7bcTaPZmIWXorAsrcRlvZ5Wv4r+Jhnk2oQcB45U74iSFdATNr8sWDXmtSZ574l6D/vLpWMzZcOpCOJBogHozGvWKZrEONdiFa0n5ijarN3qwIqsJj1SGfPH340rXpl6bHPa
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(107886003)(41300700001)(1076003)(26005)(2616005)(38100700002)(83380400001)(8676002)(6666004)(5660300002)(8936002)(316002)(4326008)(2906002)(478600001)(6916009)(52116002)(66556008)(6486002)(6506007)(66476007)(6512007)(66946007)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?QohN/LKjLtcqCQM1mjAfghBExfx0hBEFy9G1MC/I14b83/6xYbloRec1vdjA?=
 =?us-ascii?Q?7fwevSiWHXKZ+dnRLKSUROc/cEUUPH1+ciqGA3edio2Btqp+/xCkITLwZeRQ?=
 =?us-ascii?Q?IsEnO9GBK1tXEaJp7ZP8b0y0uiOOF0zG/I+MWDbfrAz0xAsGw6JGHOD7smYJ?=
 =?us-ascii?Q?tL4TzvNHyM63sdXGUOeawoqnBuooxitNe0D5zQzOzVVKtEx3Ni+UvhxW4BEt?=
 =?us-ascii?Q?1F+9j6IAw2kXB314ZmcbDSfesn2dcRgH3BGHBrU811x7VtFd4uL8DmlsI//G?=
 =?us-ascii?Q?1TIBx94XzBfJb75wqn250xbrzlxnSB9xOGTgjXJT6YTszFgglL8IvGcb3mob?=
 =?us-ascii?Q?e4b/XvfAudOT4vm5zGAIqk+Lzpusgaauml4p0dnpz2mNx4MAiIeGz8ucS2Ie?=
 =?us-ascii?Q?e8MRiY5r//R52R9ZYrBAZ+mfLEGPIJVop9LsnvB2pGGNAjmjzjLe9SOQvpTT?=
 =?us-ascii?Q?67mzMaFV1a49yEuaAjXdnR0Y9+ps/NgJtb1kxmALv0is1z4eXLeJ7xItqilv?=
 =?us-ascii?Q?zVfzzF2CPcApNrmj03SPisKMAvbv0o0b8sUjDo2miZNV4aT2lENcasCiFcci?=
 =?us-ascii?Q?LnRd2foSatB0M8d5GmYh/msGJRTbmcgYgpuxVioy6hN4Ys4e2rZU36+5w6Bm?=
 =?us-ascii?Q?ySr3GfW2ACPewuvANPCd7ztd2Ao/aS8geHa+uuhTsU91rAJwJhsWeVeeM3y0?=
 =?us-ascii?Q?715Xn4JZUNUm5QJEMRBQsb2vzVQkD1YiANcqBUB8vtUw98nL6Z15mRGhCZoJ?=
 =?us-ascii?Q?PG20S7BhftgGSj797JzZR5737IxRkQpqxnaV9LQfw5YugwFpqKYi6ozYOsRR?=
 =?us-ascii?Q?64WrQDnNVpgPcLu86ptNLryjuahQ3CX3mVqV7O0h5QeeMyeWfwJrJWnqQ1HD?=
 =?us-ascii?Q?yMCudvIeeKWIpxb7ySu1vlKQwi0gj/fFRSmgRIfOPuUHAC/NjOqMEXKoYL+W?=
 =?us-ascii?Q?mCkRMNSyG38bejMAuOMMgFGt4kEoI/EePJn5Y+9394iHl6NVwhpz6X60M5YV?=
 =?us-ascii?Q?KRYQL0cnkN3ObSFtoUlma2Ce9y+fTI9MnHbACz5wjyjJZNmf/N+SWcVcGOtC?=
 =?us-ascii?Q?Qext4YebdQ5OaC1I0Q+Jfu5uK1VVXT3XsQu2FMHlM3MMTe65RyqJygwk8xFY?=
 =?us-ascii?Q?hCgWG0sSo3tO5wY3X+LGvCRZwkk7dFztoIxUP+o0UZtLgbdLLc+xRVQnTqqm?=
 =?us-ascii?Q?pvJTcpcSyT+hjkBayr/6Nbdl6o+5AntvuALWvLNqKIZE6vrsTs+K7Xg3efHo?=
 =?us-ascii?Q?/7qwOHdxjpaUQJNdtlEYskfXdrn9vnI0CTrdThSOTHOoR0Cpzkb0noqQ+sUy?=
 =?us-ascii?Q?A8zmh3S1IjGMy5f4uqqLytSOUlCUKgW1Vvhzabp/U44lxeMxm3xvLNF09v5P?=
 =?us-ascii?Q?27WGTzSd2qoE1+MqDzWjfoM660HN3xgk4kmbcCPKvGFDwYl/aAplBq00w4hC?=
 =?us-ascii?Q?Zxxur/u2o60FmyDiMh/+VkeLUtkaP/ebDkFqnCSWr56sth5GDy4WHFi5y+rV?=
 =?us-ascii?Q?DjS/HM5IWszGayWTHVM+DidVwf24+Yb8k63n/PvrSlSNQqWVTDJx88DR9ND/?=
 =?us-ascii?Q?RqwXeGQe5Eo8K6hSur+Leh+gDWhb/q7oODl677ee?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025711b8-34ea-4d1f-e07b-08dc0c53b7d7
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:01:29.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oniv787IqHFIXCMpPmKIPRQgQb2f1AAmkNHWqgtEJFgNpjtLeStnK0SIzp5PWBFL20GtqL4ATs0+1RfRTuD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7171
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make erofs_err() and erofs_info() support NULL sb parameter for more
general usage.

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
V2 -> V3: convert pr_err() to erofs_err() in erofs codebase
V1 -> V2: add erofs_info()
---
 fs/erofs/decompressor_deflate.c |  2 +-
 fs/erofs/super.c                | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index daf3c1bdeab8..ad3d69eb6fc2 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -70,7 +70,7 @@ int __init z_erofs_deflate_init(void)
 	return 0;
 
 out_failed:
-	pr_err("failed to allocate zlib workspace\n");
+	erofs_err(NULL, "failed to allocate zlib workspace\n");
 	z_erofs_deflate_exit();
 	return -ENOMEM;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..5f60f163bd56 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -27,7 +27,10 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	if (sb)
+		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
 	va_end(args);
 }
 
@@ -41,7 +44,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_info("(device %s): %pV", sb->s_id, &vaf);
+	if (sb)
+		pr_info("(device %s): %pV", sb->s_id, &vaf);
+	else
+		pr_info("%pV", &vaf);
 	va_end(args);
 }
 
-- 
2.25.1

