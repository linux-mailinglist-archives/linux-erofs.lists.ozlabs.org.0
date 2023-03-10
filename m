Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3D6B3637
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 06:49:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXw9f2WT6z3cgp
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 16:49:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DhrtnIpE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:704b::731; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DhrtnIpE;
	dkim-atps=neutral
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::731])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXw9R6p7rz3bjk
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 16:49:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZBQI09aBrcFQwbdE1dSoCPoz9mf7sDp1znqN6bjvF4gIOUEkK1hP0rr8sZuVx0MGghZiOSDRMF8mnjlpXj/DyAqn8tZX6UbKIgMRznOD13r5NzOCF5usARHWIfsmMnbjQpXQWmCKjKM+G+NOtpNW0pAOLN6/040s4aJ/CDyidUm5m5NM74ghvqp4asPRoEoo1osoeGfPcaE2+XHw1wtDcPQ+lo3qMClFp728wJDwmFbVIv9onOeXZVe7FiAgQ0jlei0Qu074CGcVvdK5dX1ZcCndjWj93aNregJjEo8xJGc938AZA0SSGqkcemgQsRE0aaM1yVe+PQ0oAoT0bkaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc8PCYn/F+bBJwiE/Ok+CXT7KaO9/KsZNoz5vBuhjVo=;
 b=Sr1KduMnkzv3qTpFNVxEV4A7gYVokFxEFGme1LWwz0IxPqaDNMszYrmI3uyW6l4bYri//ZF8cfJaq65Sg/UONAmrxB1956pWUN1B0mx+DUhExDSVwqa52gfPK9eSyPS8B/LcJ2QaVJ+r8u7n8MOiV2367Kn8FwUiF3K4RlhFjhrPNnLNDwEcNs0zL81zS+y07VqLE7/Yo6IjivR9Y6TMt+d1M9mWd2+9DxjivIobTyVsO9vEeHIgv+SCaXPK5f354XZ2KLFnr+LXHDNO1WiZ0mg2wjcIsheFKkuvYVV6kbDrBwu1xG1xDJ8Z93etpCqBaBRWcp4wrnBf6lQjg5ypBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc8PCYn/F+bBJwiE/Ok+CXT7KaO9/KsZNoz5vBuhjVo=;
 b=DhrtnIpEiA6bd5jbrLeAW7wLptcnM90lamm/lfkmQlL5gmtKmHyzzlPprgbOJAZlfC8jONDztrACNjyHM+SN25JDzQcTHEvkB9s9myCU67QlLDukXzL2yHYTpHQRKAkQmrGZZmSIkKreW/Z8q3Kr11uix1lE3a/oXYIf2xv2my49NbOGTW/UKhC43WHW4NBeKSirBsioRSVBq13+AF7qtN35ibKM3G1Nf88ECAfyrGKQz3aCwdiKtwgpDS0KTpNcLHyWodnb9HjrgbbvxP05G40cywOqQQ7Vtcsnx25kiXNRGYYOWMYU0XutBRUOVjYo75bIfGodpcTOCLgVltiC1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6023.apcprd06.prod.outlook.com (2603:1096:400:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 05:49:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 05:49:10 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	rpeterso@redhat.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v4 2/5] erofs: convert to use i_blockmask()
Date: Fri, 10 Mar 2023 13:48:26 +0800
Message-Id: <20230310054829.4241-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310054829.4241-1-frank.li@vivo.com>
References: <20230310054829.4241-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: bcffa574-3eae-42e4-c992-08db212b2b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	F09TohasIhTyNhQn1Q15MARbJIWHM7mi6dgLhf9/hSMOnolpvihaJxOWdp3xoMg1USFa+Ekf5868XXq2Cme489uZw0gqais4IgETkt2naElfGnKzMZzuDH/590c+oYQMBVfNkSX3r2aYX7p2p7iBEP4zJypqhMR/KpQwKD7yaIZ1XJVcUCLeTqZVCSr1+ItA7P1zD2iJGsh1INiyKWBqReeBoRX1yUUpST5LxqXgDhSUFLb+4d3K7IEkOy1X8v97NYtSf1iypG2DKeHx8+lr76x7xQr8qyVWl/fm6GwzLCSWR8wWHPSjQmZd1MMdOhbFOufxCxwhbLUWxSPhJzQk8Im1nM8cciSF7ap10AxlSlwguNKHHWaBNq2vhchbCkXIBHlXioDOeLLDK33B89Gq24Iwj/lKo8cqClk6ULcN30+Q3q9ifGQjruNPNQ4S/y30jzUFMAfM2J9KCrxalgsc4d7c98qU9JId7+70InSMScDlI/1h4nqQSsCYCLPIAQS7Eyt2atI0B++TaQwAjPIo/fBFMiUzWt9tSTlzgSfwlITtDasTnBqMZv4pJtGJaAWfLpOMqFQgPb3uyxC2zScz35H9++gW8Sqs4Lgy33zG5QELdxxw/77ImjOGEN5Zgf7buk0J/Fr5Fdga2ZDRa8f1wMMN6hfK5nt9Nbjk8pi9dY47kFLjQLE+E6ySwKjp3OiZZnoO9j7RcL6fii/AhdsaCCpk9ZiuxjbgWDcl55J3TpA=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(451199018)(52116002)(6486002)(1076003)(26005)(6506007)(6666004)(6512007)(107886003)(186003)(4744005)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(7416002)(8936002)(5660300002)(86362001)(2906002)(36756003)(316002)(478600001)(921005)(83380400001)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?yWt6yC7hZnI+11hk3GMmC8uqlDpn5nk71f5MkLq9/9imI/I2aCaOjrgHQ3Gh?=
 =?us-ascii?Q?wTZpi1Sw/Z3ZVb9umR0DSVZKqz/b2J4PcnL3h5kMfw4bvBdvW39d4prvYWT6?=
 =?us-ascii?Q?OHihxeRUgxdGORDP+9BYGeJhmEFrEkJDT9vf78k4wLOZahpwG7Z2Rm/EPWTn?=
 =?us-ascii?Q?OZsBRLT6nOvkxyHk8rxZ6j5FHykyeoimJ7iPtoqs9OiFqo8uprbjxPJA1Z//?=
 =?us-ascii?Q?iH4NqxN2ScUC9F00uvT21pC+UxzYPfkOZC4UGBePll4UmWqgdVOOK7TKcwj0?=
 =?us-ascii?Q?CQry+6eBRZEWq6yqRTRJmDh0idS6SpO7Ul+uhQcLKL266cOPCFKdNF0Ci/jS?=
 =?us-ascii?Q?3/GTXHjjfY3K/mX5r2H5X1HTpO84rtsNi+yGqUsiJ0OxoUFe6jzB0oGZvWYy?=
 =?us-ascii?Q?zTY2y16xzKvCEZLy1OEnKDEtc6jBFRV7TuHixnY6EA8XC8vvd3D+RUjeDWJs?=
 =?us-ascii?Q?s6eHip0VmrFSPDWWD2l3jf42yMwN4KlGohfZ90NEpbGDb9NN12z9uV8PQqvp?=
 =?us-ascii?Q?O2bPYkvZ7VTytz6IR+CVfAiVA7/I1P5sMb11vrjPiPAt51KwRz03oOQsc2ot?=
 =?us-ascii?Q?wtKLO0H03On7G0HGMWkEY4ZDHpXZ23ppXu62VFS8KQM++5YwQ++Rz6JHwkWo?=
 =?us-ascii?Q?rD7Ka/PuRh98G4X5L7IRZ6kp7a3JeSWGMS/31X0t6PlX6eEJPFoY+VzYOuEt?=
 =?us-ascii?Q?BhxikuskwKrAYBXzkyagQMnRCKXc523jdi0I79f2Q+AdNPCFiwjPvHGvW5IF?=
 =?us-ascii?Q?ir3XwTD1rhbTWNPtlJdctaqGMnMK7gMYtv46FX5ubBfErdRdCXpPOrOSyVnA?=
 =?us-ascii?Q?kq+Si3yCl72/VczEdpnNf4LAHQBoycpFE5P739REe6g16cIVf0g4oHWwJIFL?=
 =?us-ascii?Q?xg91tyDUtoVXdvIBPULYfzCywQ+op1jd6onHzH+4udXKaoUG5tLihJCuOUe6?=
 =?us-ascii?Q?wM3XUkBNuuZhde6Wgr/unyaz3RWge/isXAeQ5dB2C0GTMK0RbZ6PgEN1X3dV?=
 =?us-ascii?Q?3RT/jlhGqTGPRvtvYNVQESuIR1uis4I95fJ8YiRDd7YZF9X2hpsQooQbT8Jl?=
 =?us-ascii?Q?njVP2mrIDGomuLS0lcvjd1IKx7IUGG+ARShd/qIG0TjwClN5Z+Y/Wx1s4wRF?=
 =?us-ascii?Q?UkgIcAEn/2D0gF/+fJimffq1rfGgJRTH5AuDP9YaRQ3cpBYU7SoEsLFATBzT?=
 =?us-ascii?Q?uvyCdWWw20pLUwgyP8TbxXUGqzPiVYj+SU6O3JdGNifVtovKVWvBTvClhPQ4?=
 =?us-ascii?Q?jjAUEj3YGZvjjSFf79lcjG4WW33GOXBriBCUO4+dIL63u2qG3+bXsvewZH2k?=
 =?us-ascii?Q?6eulck6G3w4/9XoVtZRHlUnmz7f+YBHSq8M2BuJQEUOuzu4UC23xTaERcA4j?=
 =?us-ascii?Q?PPjWDb5DR2AvsO518GvmpBzg+nxd6TGZ6kEGrUsA1PWvQ3RMq0g4tQAmEDJh?=
 =?us-ascii?Q?XYyinpzz8pbdlkXRDc5y3MpImr3kr53Q8UzN1lbec3pwLzfofz6SvqTQvB8a?=
 =?us-ascii?Q?BTniycCkipR88m5Wl6ibkSnEcjsFvf/GXlsLfH3///T0GevMkkLyoVwwCdzN?=
 =?us-ascii?Q?kTlidXUjPLrL+udnTbHOVTiAQEKiifqBKCN/rDOE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcffa574-3eae-42e4-c992-08db212b2b59
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:49:10.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMtR/Nv+Q3wGPOGsV84uFg0xXL7DCwcUMQwQtzGtUnB2SDvburE9KXj7IS/Yf/16VeWDex7mrHo+JAyGMNTiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6023
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..d394102ef9de 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -376,7 +376,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = (1 << inode->i_blkbits) - 1;
+			blksize_mask = i_blockmask(inode);
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.25.1

