Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE438655F81
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Dec 2022 04:33:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NgNfP5f98z3bZJ
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Dec 2022 14:33:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QiTenzMr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=40.92.99.21; helo=jpn01-tyc-obe.outbound.protection.outlook.com; envelope-from=mpiglet@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QiTenzMr;
	dkim-atps=neutral
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2021.outbound.protection.outlook.com [40.92.99.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NgNfG3QRtz2x9C
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Dec 2022 14:33:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq3pqGIE7a1jFQCNMhg47pHtdwwZoikzidfMjOiydnLUIG4zmy/cMOMOk8ZNrbfxfz2MBh+1Px+yalrxvmsChzKEbiNokNk3RrqE0Xy4rHPYTXa5uCCBDkJHENXzniaf1It0ivywkiEtlnUB9xucL6VWkrpnIBf93RSxvDTWMON44xLQ4kJtrB71vO403KFE9b5rdvHSuK77mFOkjalxZmWbKIEG0dHZ/qm2Z0QoVtJdFnI6WfSw72Z4iYXG5m02FF/DyQvgxG2es4MpV+hIXO6nl1YQE40dyRJntGVEDpzpsC36+ATQQKjyS6ZiTZqwjJibWVCIIL3ZzuagD/jN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWLK0C09HeJtnG8ixsbINf68wvfMaPgmM4PfmnNvYIE=;
 b=L3vd8dWFIPoBxSDd+m3dP9TbyMQtGFyXQeLnarHS2yKHqkZjXZoBrzkoGOnkKPOqys/BGCvDPzizl+fBrGUA8PObdGlbJQq99XdVU6RbvRCQ+2hM++FCvRX9mVptKZi7hDl3pud8bO3l2+PyBbE8t2uT68iYyBefP7hrIuPVOGMLUYHY8alRhoqqLmuW+ucQ39PmmRe7G4zb1MCGHGGzI4Tjz8Cobjel1ePZ4F/cv+1rsNF8zbJ/ev7Gyge6GsD3n3+SH5v1wbn7LzEe+mh2FmEIWpT8RLQSd9ibv7AI9ideJ1XYxCZTp5V7PdUVfw5HqMPocucVkgCu6uo1SQua3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWLK0C09HeJtnG8ixsbINf68wvfMaPgmM4PfmnNvYIE=;
 b=QiTenzMrI3CKq9xbriFsVTyH9ACu5VgVg9kuJ9pSfEc17GfZierHTF3dhhAC0O6OHONUgkISv8g7ELEYbN0inrznnN0rj8TJc9vMYbhbvwMw07sIKT6BxWZKRBvllNcT+igqnxXHjxkkCJMzwkqPiAII0+bWUcMkbti5Jh6aLkUl0zbhO+1ruULVB8qyUDPTeSV2h25jm65UzEsh+ZQ6esupgHWcYqTvTtDKNw+tUIxSxGVb36jvJSq23nBTm2Id/YebK4cMaXK3jGAM3IMHj0J9lYuAj2fH/PjPyIH5tVBn5nj1dnuIub1EirjWntZ6vLxbvdQOZ3t9IqcpUyMdVg==
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:f7::12)
 by TYVP286MB3119.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 03:32:48 +0000
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:b1b6:c553:fba5]) by OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:b1b6:c553:fba5%8]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 03:32:48 +0000
From: Qi Wang <mpiglet@outlook.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: add --ext # option to show top# file extensions
Date: Mon, 26 Dec 2022 11:32:38 +0800
Message-ID:  <OSZP286MB07099CC46D1B3F8EFA7EBAC6B2EC9@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xrVNlX2wd02QEJMR8iGeAWqQp7DaaNCkkZmoixIAGfE=]
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:f7::12)
X-Microsoft-Original-Message-ID: <20221226033238.4603-1-mpiglet@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB0709:EE_|TYVP286MB3119:EE_
X-MS-Office365-Filtering-Correlation-Id: 929bffd9-86de-47c1-a52b-08dae6f1dc40
X-MS-Exchange-SLBlob-MailProps: 	LVbdfIC7uFC3xBVfm8FjKvPFuLP32SqvwBdM1+u0lW48DF4ckCsD6vdQmAfKCOBDoXo5N298sfUInYLekDMutw4EOJkfFgsII1pQIQMOid2kb59ac61kZNWpjgahM3sHSfjDEOcZvpwHClwdNtV89EVHmMtcBZqDyzTsj+2qL57f91WTRw9MNM6IQ/dVVDUJRMWV6cnlNwr/GjSBGdWr+glqn77e9DVG5Bh9W30iJilC2hb2MdxysMHFc8tA9RpC+y8sU3uoIuyvUaCx5+uV9DoC6qKueCzYmydLNevCrb2u7fzAy2PSXcvI4QxY7gSb4SnXC2qUHu8RSJAZN0QR1BKFxuZJavy9M9O6Ay764lUfkaGHGke89/rFB9wlkUqHPXs7iGEL7oxghgwm7XEMeQdGgebEslxcGr/RM2itSqBt/oi+Do1igGrHT64sJHblGOByrM4ts0ng5wDUSKus2wDUZSQutwzBEEFOraOjgEvVd5nsD0bnPvX7RzLTSJ39x8kujt4FohSmMwA2pmx0a81yjxMA9Eg36blCF9ZywO+fGWfjdT+csEOQHuKW+H/d6QHRRCK9N30qRztox+zB0wY5BOVLenWdpaLwngiEYITjxZV+P6KMueVpBWGko3NE8XISemltQuvwP36EVYUFv2OwkSbdOyHIuK3Hz7QmkfpLItSDyxSZsn3moYPSG8DxrbbKzMP5wwyQ/AvhXLvovWEARmdpa7igXD8C459ueRCCpjpW3pGBqg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	uIGYW26iYSjfFiinCm8M2xDAuNw6avX5e+qc6N4ms3AoLRnPV2oDt5mNIFAcV/zy8qRu+Cv9Pq8c0kzBdV+G5wtFW50iYK1EI1i7juxzxZY1Cu+4le67VTYiOBmcsAQYqiIe2fP5UKA+q5RSe3yy2Y2LLSovAmpyeGnHiOamN8Hr896++F+oEw6WagFB2Q19xHHPP54Jtv0YyPPLwlkjsi2si0c2bQu6jyPkbnYixQHCfo6Y30G0exccnBIawhnBQ0LWCp/BBbNsXo1DwP2RtOFsAngmFp3gChKcZENjAYrD7BkxA39LptkXNCxKr1wqXGxwKCTTtnm1061vwYMJbabnDT+O2pyQMHpETJreX5+3sv6xbZBjVt9ysrTk/8CfycPgOq1wwe5s3cA6xsCaJGKqYuPINZsmAA6O0dV5ONHrppZZ3hLK4pgZ0E5LmavIcjnNr2hPPvpInD9ROBNrSGUZkfbDAFSCPqzbzirpNWsjpe2yAGMKKuwd646xOrSuHf2Qj+SrEPgRqh9V1Z61ywZMV7Ben9dtMAIvy+fvkGpbd4tSK9a2KkqiGbvCIIaIndj49pYFX9rFy7GdZ8s0ks3UxqZzXjXDlgGLThFhITnMBbwG6Wi7DRT3NP5/tEPWd4gbFQLr6f9/qGR/P1DzAQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?AiB9amG8ZUKfwhuRq5tJ+e2T8GWydnob2eN7YnQMBy73YHj26+hazF5IksdN?=
 =?us-ascii?Q?mUlmiuWYVhI0UaJK23zf64pcNdZYGIVAp/Fzon6Dai4gAUd2C7nruXTlbxkz?=
 =?us-ascii?Q?s6dvL2xKB5sLCc8ht412VghIO4TZr1gTKv23vdyiBJZX5tykuOUse74lkbAs?=
 =?us-ascii?Q?fayTCmtBy3iWylsT8KnJMV008QHpJeogaOgI3G/eVKg4EGYqRrmGozZ7O1uB?=
 =?us-ascii?Q?wbR+rbu+8X5viYllOIGvEMFILOnGLmEohrjigUknkCa4fae29Rkb4zdmGQJ9?=
 =?us-ascii?Q?RIuxSebLQgDVswbDbgbC5xvQexpKvo5YkHrumkqigKtsbRc/3nsoxNSTKiD5?=
 =?us-ascii?Q?k4w90IM3sgAF6X33aLrEkpLpXx2GBOM92fRDv+qkKd8dWmypPg1lLcgQiJxw?=
 =?us-ascii?Q?3P+rpBLH5afq9KCZ7e6xUnoHqyLFEsha5z9Qo3tfC+aqUIST89COHfaUZ+PE?=
 =?us-ascii?Q?t0zReaLGSHCal/dTLw5rNkUP0VgXKJsRA4CM6tMWuqQYr3ZV0mfn3yzjxhBw?=
 =?us-ascii?Q?OgyFHxwQNJ4lSXJnd5T6j+mc/fMRdjifB1ZAG6RQDgUh0khI5V3sAoMny0m2?=
 =?us-ascii?Q?1eyQiyWm1bKq4HfyiJLVtATcVwdWI6KiVdmWdKfGnU0y/4jghSvWRWaDfn8H?=
 =?us-ascii?Q?7kuFrR1sMMxtIOsNBN9F2/Z/2cqwcUWkBUEt9MPS/n/BpsL3LQV8YtVyNSbB?=
 =?us-ascii?Q?E9A560I2cbaAVom5Z6qywHAh5czyaMLY69rNXac3YdSYuadvXI78zG7/VYig?=
 =?us-ascii?Q?Si3aft5xSbLG/I10YR6n2fF2YCDfv+Fn3grKUt6cgA+Z3HUeHPN42SiRvSkk?=
 =?us-ascii?Q?1VsDWQGauHyuh1wm40rqOqmQpEyfs+8toVWARkyLYav8UPuQSxBs9/P4o66y?=
 =?us-ascii?Q?AICOCNJtaUhRBSAko3HjlLKcNTKOjNRRhkxaf2xVwFonXJ64V0iMBnw1gpMl?=
 =?us-ascii?Q?JMW82Bdjy/HaPYHIQHb5x/e3MxPmMVEPGYOiLlqF7XUo4mP3uL33g427pZoH?=
 =?us-ascii?Q?EzQ6XmNNwXjGYsz1m6IXiUl8+pqY10I1e8r1fDYy/wENIJLoMpn5P+QQNZbG?=
 =?us-ascii?Q?bRdJwBgik4kxN2zoZqkIJMdYSn4QHHDj2hIiSK08BC1+ZR9ItcTknqa5rY+V?=
 =?us-ascii?Q?HBkleYw9tWrMoQgQUGMuaD1EXI5J6FNPIOaTRz6H65MdxoGLCgRJ1Q/u7Kcd?=
 =?us-ascii?Q?yF4Twm5mQEc/FMQC1M5rm/3uDMtWXZxPe1DJVxm+AI8UPKsuT1spMiUXv4Vx?=
 =?us-ascii?Q?eQIJqgmSR/55Ww+HpZymZ9+XHyjOtmyq2hCVV50W5Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929bffd9-86de-47c1-a52b-08dae6f1dc40
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 03:32:48.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3119
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
Cc: hsiangkao@linux.alibaba.com, Qi Wang <mpiglet@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The --ext # option is used to let the user specify top# file extensions
with higher occurrence, instead of hardcode some file extensions ahead.

Signed-off-by: Qi Wang <mpiglet@outlook.com>
---
 dump/main.c | 131 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 101 insertions(+), 30 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 49ff2b7..188ab34 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -6,6 +6,7 @@
  *            Guo Xuenan <guoxuenan@huawei.com>
  */
 #define _GNU_SOURCE
+#include <string.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
@@ -15,6 +16,7 @@
 #include "erofs/io.h"
 #include "erofs/dir.h"
 #include "../lib/liberofs_private.h"
+#include "erofs/hashmap.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -29,17 +31,34 @@ struct erofsdump_cfg {
 	bool show_subdirectories;
 	erofs_nid_t nid;
 	const char *inode_path;
+	unsigned int show_ext_count;
 };
 static struct erofsdump_cfg dumpcfg;
 
 static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
 static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
-static char *file_types[] = {
-	".txt", ".so", ".xml", ".apk",
-	".odex", ".vdex", ".oat", ".rc",
-	".otf", ".txt", "others",
+
+struct postfix_statistics {
+	struct hashmap_entry ent;
+	char postfix[16];
+	unsigned int count;
+	unsigned long occupied_size;
+	unsigned long original_size;
 };
-#define OTHERFILETYPE	ARRAY_SIZE(file_types)
+
+static int erofs_postfix_hashmap_cmp(const void *a, const void *b,
+				  const void *key)
+{
+	const struct postfix_statistics *ps1 =
+			container_of((struct hashmap_entry *)a,
+				     struct postfix_statistics, ent);
+	const struct postfix_statistics *ps2 =
+			container_of((struct hashmap_entry *)b,
+				     struct postfix_statistics, ent);
+
+	return strncmp(ps1->postfix, key ? key : ps2->postfix, sizeof(ps1->postfix));
+}
+
 /* (1 << FILE_MAX_SIZE_BITS)KB */
 #define	FILE_MAX_SIZE_BITS	16
 
@@ -65,7 +84,7 @@ struct erofs_statistics {
 	/* [statistics] # of files based on inode_info->flags */
 	unsigned long file_category_stat[EROFS_FT_MAX];
 	/* [statistics] # of files based on file name extensions */
-	unsigned int file_type_stat[OTHERFILETYPE];
+	struct hashmap postfix_hashmap;
 	/* [statistics] # of files based on the original size of files */
 	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
 	/* [statistics] # of files based on the compressed size of files */
@@ -79,6 +98,7 @@ static struct option long_options[] = {
 	{"device", required_argument, NULL, 3},
 	{"path", required_argument, NULL, 4},
 	{"ls", no_argument, NULL, 5},
+	{"ext", required_argument, NULL, 6},
 	{0, 0, 0, 0},
 };
 
@@ -111,6 +131,7 @@ static void usage(void)
 	      " --ls            show directory contents (INODE required)\n"
 	      " --nid=#         show the target inode info of nid #\n"
 	      " --path=X        show the target inode info of path X\n"
+	      " --ext=#         show the top # extension file info\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
 }
@@ -164,6 +185,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 5:
 			dumpcfg.show_subdirectories = true;
 			break;
+		case 6:
+			dumpcfg.show_ext_count = atoi(optarg);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -208,20 +232,41 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 	return 0;
 }
 
-static void inc_file_extension_count(const char *dname, unsigned int len)
+static void inc_file_extension_count(const char *dname, unsigned int len,
+		unsigned long occupied_size, unsigned long original_size)
 {
 	char *postfix = memrchr(dname, '.', len);
-	int type;
+	unsigned int hash, plen;
+	struct postfix_statistics *ps;
+	char pf[sizeof(ps->postfix)] = {0};
+
+	plen = len - (postfix - dname);
+	if (plen > sizeof(ps->postfix))
+		plen = sizeof(ps->postfix);
+	if (postfix) {
+		memcpy(pf, postfix, plen);
+		hash = strhash(pf);
+		ps = hashmap_get_from_hash(&stats.postfix_hashmap, hash, pf);
+		if (ps) {
+			ps->count++;
+			ps->occupied_size += occupied_size;
+			ps->original_size += original_size;
+			return;
+		}
+		ps = malloc(sizeof(struct postfix_statistics));
+		if (!ps) {
+			erofs_err("memory allocation failed!");
+			return;
+		}
 
-	if (!postfix) {
-		type = OTHERFILETYPE - 1;
-	} else {
-		for (type = 0; type < OTHERFILETYPE - 1; ++type)
-			if (!strncmp(postfix, file_types[type],
-				     len - (postfix - dname)))
-				break;
+		ps->count = 1;
+		ps->occupied_size = occupied_size;
+		ps->original_size = original_size;
+		memset(ps->postfix, 0, sizeof(ps->postfix));
+		strncpy(ps->postfix, pf, plen);
+		hashmap_entry_init(&ps->ent, hash);
+		hashmap_add(&stats.postfix_hashmap, ps);
 	}
-	++stats.file_type_stat[type];
 }
 
 static void update_file_size_statatics(erofs_off_t occupied_size,
@@ -298,7 +343,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 
 	if (S_ISREG(vi.i_mode)) {
 		stats.files_total_origin_size += vi.i_size;
-		inc_file_extension_count(ctx->dname, ctx->de_namelen);
+		inc_file_extension_count(ctx->dname, ctx->de_namelen, occupied_size, vi.i_size);
 		stats.files_total_size += occupied_size;
 		update_file_size_statatics(occupied_size, vi.i_size);
 	}
@@ -481,27 +526,50 @@ static void erofsdump_filesize_distribution(const char *title,
 	}
 }
 
-static void erofsdump_filetype_distribution(char **file_types, unsigned int len)
+static int comp_postfix_statistics(const void *a, const void *b)
+{
+	const struct postfix_statistics *psa, *psb;
+
+	psa = a;
+	psb = b;
+	return psa->count < psb->count ? 1 :
+		(psa->count > psb->count) ? -1 : 0;
+}
+
+static void erofsdump_filetype_distribution(int topk)
 {
 	char col1[30];
-	unsigned int col2, i;
-	double col3;
+	unsigned int col2, i, pos;
+	double col3, compression_rate;
 	char col4[401];
-
+	struct postfix_statistics *ps_array;
+	struct postfix_statistics *ps;
+	struct hashmap_iter iter;
+
+	pos = 0;
+	ps_array = malloc(sizeof(struct postfix_statistics) * stats.postfix_hashmap.size);
+	hashmap_iter_init(&stats.postfix_hashmap, &iter);
+	while ((ps = hashmap_iter_next(&iter)))
+		ps_array[pos++] = *ps;
+
+	DBG_BUGON(pos != stats.postfix_hashmap.size);
+	qsort(ps_array, pos, sizeof(struct postfix_statistics),
+			comp_postfix_statistics);
 	fprintf(stdout, "\nFile type distribution:\n");
 	fprintf(stdout, header_format, "type", "count", "ratio",
-			"distribution");
-	for (i = 0; i < len; i++) {
+			"compression rate");
+	for (i = 0; i < topk && i < pos; i++) {
 		memset(col1, 0, sizeof(col1));
-		memset(col4, 0, sizeof(col4));
-		sprintf(col1, "%-17s", file_types[i]);
-		col2 = stats.file_type_stat[i];
+		sprintf(col1, "%-17s", ps_array[i].postfix);
+		col2 = ps_array[i].count;
 		if (stats.file_category_stat[EROFS_FT_REG_FILE])
 			col3 = (double)(100 * col2) /
 				stats.file_category_stat[EROFS_FT_REG_FILE];
 		else
 			col3 = 0.0;
-		memset(col4, '#', col3 / 2);
+		compression_rate = 100.0 * (double)ps_array[i].occupied_size /
+				(double)ps_array[i].original_size;
+		sprintf(col4, "%.2f%%", compression_rate);
 		fprintf(stdout, chart_format, col1, col2, col3, col4);
 	}
 }
@@ -543,6 +611,7 @@ static void erofsdump_print_statistic(void)
 		.de_namelen = 0,
 	};
 
+	hashmap_init(&stats.postfix_hashmap, erofs_postfix_hashmap_cmp, 0);
 	err = erofsdump_readdir(&ctx);
 	if (err) {
 		erofs_err("read dir failed");
@@ -555,7 +624,7 @@ static void erofsdump_print_statistic(void)
 	erofsdump_filesize_distribution("On-disk",
 			stats.file_comp_size,
 			ARRAY_SIZE(stats.file_comp_size));
-	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
+	erofsdump_filetype_distribution(dumpcfg.show_ext_count);
 }
 
 static void erofsdump_show_superblock(void)
@@ -624,9 +693,11 @@ int main(int argc, char **argv)
 	if (dumpcfg.show_superblock)
 		erofsdump_show_superblock();
 
-	if (dumpcfg.show_statistics)
+	if (dumpcfg.show_statistics) {
+		if (dumpcfg.show_ext_count == 0)
+			dumpcfg.show_ext_count = 10;
 		erofsdump_print_statistic();
-
+	}
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
 		goto exit_dev_close;
-- 
2.30.2

