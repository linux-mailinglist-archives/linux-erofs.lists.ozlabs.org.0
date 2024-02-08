Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C657084E2BB
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Feb 2024 15:00:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RSMqu/kx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TVzCN6nzsz3cBN
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Feb 2024 01:00:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RSMqu/kx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:2818::801; helo=aus01-me3-obe.outbound.protection.outlook.com; envelope-from=i.pear@outlook.com; receiver=lists.ozlabs.org)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn20801.outbound.protection.outlook.com [IPv6:2a01:111:f403:2818::801])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TVzCD62GRz309c
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Feb 2024 01:00:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqvKUWQCao14CE5QpcBKsL4fsuJlO6D4qeNucfHvC4Ve48DgEloOtdizjr/dzndcOh9wFdRGc1xwJ79pOEkGftaaQdo9VCstHgFpsk90zfBWnROFBPBrQehyio/K3aUWFAcQhhXxEdj85HRBJykmFX9JZMI1Xfq5iU37i7eqrETqviyv/N9Tz/u2dqhKDkWtVjom9gG80joZtF/iLxNrGdZL8pQdfFNVLzPSQKr2YZnowbDZslXCP7ADIehc0A3MdZA2PffhCjUQKc6YCk9moyLhXwBUcQAnUYWvjmWIXHxLpCZmiba+wqSv77sCZz+azwFs+ZTXLlMTyoWGI4jwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN2xKk5dSQooZ/40KhEfRlYQ3219SUck8lU24gVxNpU=;
 b=Q7yAezCIMdXg1xcfjWxw5PMQVP5mz00kon4eQyTJnf6KHx7hFRQF+OXetrKxBQAUvJkDBPYPBniFm3iM5xpjziDaJdRJvfeRKDmZW6AlBY8xFc+zxYpueEH3lqtoJ+ZC56bPAw6qQXpHI0pIr98f7MQ72HtqCr1doNt9Xewh6qeR8x2LbEwrDeUIRf2Q9cT59TfT5WbHaTnuYrpLJFePCgyeo2YWV6FWPEJN5+DLjHoLX9O+kkZFAgyOi1zCNtAopTxDyK8Bzeo2J7auWckd2LkL8Nx1YjT1o+kplSykyPL8ZWWE70aG2zz0fRivU2m3yXxi+GVmWXWFUXCnuMzInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN2xKk5dSQooZ/40KhEfRlYQ3219SUck8lU24gVxNpU=;
 b=RSMqu/kx6JSrTOYpVSmYwqysMmljYGkpoxViLu+ZLgaS+Az5L/lGw1Qj+6F5PK069DXj46Geq45Ho4QyRTWYByIaVOQRlkiQIdYrl1QLnG6cYFb5MMuh1c2c1iuWrp9HxFp1exwn1xXrGdk9w/RuqR6dpqYGMGbOw3XKXngQ0utf4SsB1l1IIjz0uMQKmRvhg7STpXGFV/A42mPqUrO4ilcRH34bf+VA69kmrXm4xPqaHvz/7Y5i48EFE4kQNl4YcPXISb02PXzda1dMBi0Sy1T/E00CQiEzN2BaM4vZbJU8mzOCzkJYkxJlUQRTEn+0sqajuPAXu7K4OaM2AN/W4A==
Received: from SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:164::22)
 by SY4P282MB3874.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 14:00:00 +0000
Received: from SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM
 ([fe80::812d:e51d:5eaf:594a]) by SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM
 ([fe80::812d:e51d:5eaf:594a%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 14:00:00 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix incorrect usages of `erofs_strerror`
Date: Thu,  8 Feb 2024 21:59:09 +0800
Message-ID:  <SY6P282MB3193657433D35C3A7799CA5F9D442@SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IyOStKgAVhETbn3m16b2ycsv4QppN1ibUllSaAjCwzfoljQRDIy43A==]
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:164::22)
X-Microsoft-Original-Message-ID: <20240208135909.15167-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY6P282MB3193:EE_|SY4P282MB3874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b27d860-0b9f-4ac9-a125-08dc28ae3dc9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Mnq1JdKNzBs5MFrKTUQqk4PMTfWgB/f5kjVasKcy6i3tE0CqvvLva2DhtskqPfeQ5FzzwOu6HUodR6N9tzqrOVb+JL+Fd1QNU3MLWLWlccdcjLDZ78l75PdwUtQaVD7yvG2Xq9T2QseZBx1yDRiety5AqnSWWbizpnvytIu+qFDgv81qmaf4zdxTQ5Bc3EhAX+1WLPtnOxhtOg6B3RLTt8sVLsqWKqWNVrHlf8dm08XnUfXqdjegtRjXZMtE9z2QsRLgtU64iUu+Ns94z/B48ut7dzOhxgZMwNaZZXyQfQyYBeFGMJ4biPR5+Sp8aikY9DsEHxeCsW+VVrSl7DS6Ux8G+VnGwNJW70NCWCYAoPZ3g6rYwuw8D0FW0UlXCrjsADSLUnN7E9Py1+RQBoTG4pT3n3fypF90nfkcCsHSv8YAJE3nwyaOrTxKiP1/WG5jXd8qVZZpk1BvFq8iQknai3m6I5qzDMvKhN0x5485C4QsIai18Ep/H8LyuSl7iFarH4SIFKxLe85cuX1y/ao58DZsSe6vw8sps99jn5/HaJN/YoT7bXs4bolp8xM3aCQkuVgN2Q+Ivjj7ydfHtYcHoiLdjAzmTuh4JgETQQdPSPGL4KQej9Sdrc03rAKxXutZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?oLfV4DrlIDP5wvdHxvn6TUIgmYsOVtMsm+OZvDxD/EgGi6lqiIL5c4wv1WQl?=
 =?us-ascii?Q?ilc6DQrOHJiXLEJDzu+fRM4ebE5kKohPo5apLPK+HpOpx9C/ulayxMygRn9Y?=
 =?us-ascii?Q?b0c1jrpOdVwtlxGK0tTi/RDsv6/HYvfg0Kv19Xjy88HJbU4oRO0ji9tqM3+c?=
 =?us-ascii?Q?K7kQL5So32KlnzZs9H70Rpdh+pcTEXvNi6vv/AQreNMAFpGeG4z94gGAYP5e?=
 =?us-ascii?Q?ZhCnO29m6clAB7aRm4QIMBthjH1CNpPqeIpEtg/QvEph22ko+sf4r4tA7pjZ?=
 =?us-ascii?Q?8fYl1xt8sg5CiQPPOoQLWFKdqdJqSxdNneZgKt26Yqk2nkLDlo6ImYGOz4aU?=
 =?us-ascii?Q?NFlHikPSrrrFz4li/W/WfVsPt/6Q1xCC/GS5fG7ToxrUpYnFQRFzrIeqYgZ2?=
 =?us-ascii?Q?MXRDA5ICBYjFXAvUg1oB9o71IHLDJ0r2GtNqaUfHuTJjPHg2RjjUE4xwdIrM?=
 =?us-ascii?Q?hgBsvTWvQtFFwA8RHXIeF6YOFvdju+FbVuJRNgatSNlzac564IPX35OY9VrH?=
 =?us-ascii?Q?qBtUxallhg0XTtB6L9OVfAOtsJBg5T+jY3YlQCh2fBFxnnctM/aSbG98kNqm?=
 =?us-ascii?Q?sjNUeT48N40VjB6/ojVf+Tx2/boUnpJJUnAV7jA5eVJmP03m96ZH8yev/61W?=
 =?us-ascii?Q?rF0tFUFjAddoOhkCyYsxIbaJ+2IuejijIu2RhgxOvGuZgzqNsB2+lJ1+paNd?=
 =?us-ascii?Q?fCOFe7UShtJZ/UTKOAngUMU/ZXty8b9EXgmB1Fk5V4hamGR9hKTynhVIaIge?=
 =?us-ascii?Q?wuc6ojf2GXd72AisU6U6KFyhdVKtVwkw/Ro7fSmXB4NCe/zmVStn2fjI26Ee?=
 =?us-ascii?Q?jN2Y3EArHMlVu4eWGPx2ydTUr2IlXov4P2vQ+D2vzeLhtfkYretYDb26ug/t?=
 =?us-ascii?Q?3ncpiiQMIxsjbAtjb7ORJGdXM7BloH0scMa2lm80Qj/Yq6Pl0oD5KakJDSkt?=
 =?us-ascii?Q?MpoI/nHtk+bA3uHLKZKA57c/tqp7wI0z07u4RHIDHxuj0vbgJMDnjaQWMNJF?=
 =?us-ascii?Q?iZwZOTn4IO2fVceDY3ok6fT1maYNVv6f74bNIoOvGxvS6BCsKnUgGdwja24B?=
 =?us-ascii?Q?utfqYteVoJ0tiEi1+KCgHBFOL8j6OLvWuTYC94lwUPfEdupfDKul4V5hXJC7?=
 =?us-ascii?Q?GUDr0c+gFHswiA+8IPYK701ZXxGLh6dU7pgHReLJpTAAP7ey5J7Tce8foLOs?=
 =?us-ascii?Q?QRQ9pZPBO8HADheOkRJTVEYMUW0TcT13LwpeLEQVolYa4JEIth0JJSZD+xlG?=
 =?us-ascii?Q?+DrAurG0vi5jNxLIj2lq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b27d860-0b9f-4ac9-a125-08dc28ae3dc9
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 14:00:00.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3874
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
Cc: Tianyi Liu <i.pear@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

`erofs_strerror` accepts a negative argument,
so `errno` should be negatived before passing to it.

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 lib/inode.c | 2 +-
 lib/tar.c   | 2 +-
 lib/xattr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index c6424c0..2a9b18c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1146,7 +1146,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
 		erofs_err("failed to opendir at %s: %s",
-			  dir->i_srcpath, erofs_strerror(errno));
+			  dir->i_srcpath, erofs_strerror(-errno));
 		return -errno;
 	}
 
diff --git a/lib/tar.c b/lib/tar.c
index 8204939..ead74ba 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -106,7 +106,7 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 #ifdef HAVE_POSIX_FADVISE
 			if (posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL))
 				erofs_warn("failed to fadvise: %s, ignored.",
-					   erofs_strerror(errno));
+					   erofs_strerror(-errno));
 #endif
 		}
 		ios->bufsize = 16384;
diff --git a/lib/xattr.c b/lib/xattr.c
index 77c8c3a..427933f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -698,7 +698,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 	_dir = opendir(path);
 	if (!_dir) {
 		erofs_err("failed to opendir at %s: %s",
-			  path, erofs_strerror(errno));
+			  path, erofs_strerror(-errno));
 		return -errno;
 	}
 
-- 
2.43.0

