Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CB660D14
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Jan 2023 09:50:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Npv7F3RqTz3c6C
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Jan 2023 19:50:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HD4Nqdyt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=40.92.98.40; helo=jpn01-os0-obe.outbound.protection.outlook.com; envelope-from=mpiglet@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HD4Nqdyt;
	dkim-atps=neutral
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2040.outbound.protection.outlook.com [40.92.98.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Npv742fnfz2xVn
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Jan 2023 19:50:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYePbr927BDsBWYrItMkDzFASlHIIvdOCzGQ6eQ1ev777bMLhEpoQvCuk6F8V4ifl3O2Y568dvLUMnxppunjt3GrRntH4NvzM7nx1ymzVWRMJt+Bz5wmpXyx0IjK2zHDI9LtKpwZFEQeZND8HBNkt6q+gju2ZFwmfRHQgvhOxTCcq9TeFhWSSREDzJBM//Tkp5SBwSs+yvT1hgn+ulVavENVcQxZMhLhiFsIgG4lpZtKzNYRZH4grJQUbIMLvpBmiDI0cQTx2pbJdlc/sXkgRtZOsakmCzXFenRB/Hm6ZdmQTYGb7rAfrTdYjyASHyg+WsT8NBeG2Q/SdDAOf0J2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DjaPOVRZHjofg690CeN2EB65SHSFnpva3SpvB3TvNM=;
 b=cO4Qqoa/8jJgSgT59F+pWc0zSq4nFdy2eHObASyTfd8bX8IARczNO4n30yPSvYytyr8PeUmUaGNLWSMxErzwiZbUxxE3boVC2a1N7t9Od22yZXWEDBF3azQm3MtZPcX3Ez+nJCcyvLmxevapIPw2lTHMM4LX5L0OotwASpZQ8NPyF55XbRh+m51cUoqO82xXxAc1+NnLVYuSQqYymqhbJWMWjcuOoriVcHcnqciF6ezfF2131irk9F8LDi4L5KIbpeE5Irxet0YfXGMxL4NgGQBce/jhCZWN/FmEKf+rtvA5fNVfkoyB/aqV7BH7z4N/flObnTWiB7ViH3NWFiD2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DjaPOVRZHjofg690CeN2EB65SHSFnpva3SpvB3TvNM=;
 b=HD4NqdytgMV2oJrkW3ie0HzdaFLtnqqlkaMwGek4q36dJtk2UkjtlYKFZapx/9/Ea73h+YtAz++TySFoggCNk+2XpZUrzIRjZP5sPmpU5kS8QYSHiTnGDVvHtKeWk0zNjI/iF6VjrJXm0CSGkb8wQO0bcu0NMUjpLFz46bRArhPkvMocE1uxFTYSut6R5Erjf0VJRVtt8HS4mM6NKdaEiNpHrwn2ZrkqQJuSkUQdBPnKC/8k31bt7Bkf5C5vGpvt4gJds+AMXtk5jC/1B9btlGy/1RdKzyfPkMNkNQKiyxUNODjjFycQNNPKhx/wPsC8KPYw+ge6x51YlHcXupOMYA==
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:f7::12)
 by TYWP286MB2236.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 08:50:18 +0000
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:b1b6:c553:fba5]) by OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:b1b6:c553:fba5%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 08:50:18 +0000
From: Qi Wang <mpiglet@outlook.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: dump: add --ext # option to show file statistics for the top # extensions
Date: Sat,  7 Jan 2023 16:50:05 +0800
Message-ID:  <OSZP286MB070953535AAC82C0F7CAE682B2F89@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Iv6cVyEFpS3awoKqujr5+PJus5bQXyzv]
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:f7::12)
X-Microsoft-Original-Message-ID: <20230107085005.9719-1-mpiglet@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB0709:EE_|TYWP286MB2236:EE_
X-MS-Office365-Filtering-Correlation-Id: 457cc3a0-ab47-4b57-e5d0-08daf08c337d
X-MS-Exchange-SLBlob-MailProps: 	dx7TrgQSB6eNbinRl2/po8ze3WjJq2tpV4aYXDmfn3X73igM3RTJUx43E6YyaMhbZZxp2I5AFODaXPa/hgfe11EpwnL2fiGYbaddpGWG9kyu4AjEKG/5v5TRUxg9wjj/erpI6UvBeZY9475vc8eDy5nPMXP2C08ay77SSeOudjxAyN+si5XZg/eiOWIs4oxmGo6ajeEXvJ2JazIM5Ypo6YCw0ldpSpoG0aX036NI+XC+aoHKKh5+FQLOAzMSoKv0t0AVXNizb5GiPB/MBDEfMXWgZmZJm6GNBsoy+Z2SFryozk8EFxbAyu5Y5rdWWTo1+cJ/G0Gdsu7zaUyMR3dJhKjX59Q85p/8Ojywwsx6K93+lha6UxTHSZ0VmIfu3G+9yWpTdsltPq0ydA8HxMWAqvNCXlRdUAJReyczlAuLMMbYSvRTF18idbn98BS9mMVmMRUe0femI3aGTXI/m7THjYNZ1at9tan6BfSgfg3m5AL+ooNAGWiBUVn1gQ3uQdCaYZM8T/b//VvjzydJHlICAZm/QQ1miNBmfHwB7KMf9UKVF/ujIRQMOBjctgE88O24NrZNDp3iBS5zF+fcPyyetffAzbNH5N6jUc6F6anwjiUY5MUltBctejWRDBYyLf49o0Y4bsNwR3wrksAI62g01k/4hBIUMxYx5l4Gl/UlpjMwK8okAJDGBO0c3HELK70FQcmD3athidfdke3zbSx3asprNPB2gGJYsC0VBRDsM4YAd6zi7DfGp3/7wlF4/QZfE6MQX7hVpA8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	QHAczQY2jWCKryfbRknbahdUCRHZU8rWWjFLw6jlDwLLoUS1qly8WvrW8h6u3sXQVTOW8V1fO5V0I+yfdE4yR31BCrhRj9El2DNJRYZd0TauaBqxn4p3eYeIpGOrc6sArkBQz+0I7kuoJ/psE4W+PCnw7qQAICLYF9utTU3kUG4fKI6i8L+tpdhJ1hpzT4Uiaycj+XMSljiK0Cc4hGbAzMtDViS/Xk48l4x3rcZv2PNQUPJxZfVib/QMLqMElUV0eSyx/ea1MK0qJQi0fm+dULkPfzzAbFuZrLC9pMn8MHZj0x0F3ZoNJR0pu3rTNv7Ed9t4k0PmiZBZz8vSZy2jmIsPbxtu23ok20kzl8sLlEv3viax8q+GgO94TDaGMEBlALESpJFAFCpJSnIOJBLRcB72TvRVumQdoGZYqj1LMuPOZJUC49AYPxKEmO6ORLZK2uOsRRJFON2jl6ukuSBWdLoklUJx+9IukWLf/GLmKzdqeb38CHFjOaeUBqsBY3UijFFlh4k92hzrWXeT0iT7o3Zv1HB/UWihZ6mFkQYojpMWnlPne4HTexeyvuRf1Kv5aUt/sazKrfDBSaTB7r3kfanRIkQ7Z4i8QFRjunr/aZzOeNK/LHbeIFg5KvHHf9FIO2YJ6IbiPL4aNexs3RqcVA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?hrTmYL2ViqSC2IZTdcDzktvsj2dJtD6GOLlYw0w/lsiHjP467GfgpEjS/ymm?=
 =?us-ascii?Q?orkhGi7JQKHy+0ukGe+7a12xPfWlgIrezaB2+1v+GHftg0YRyjv+TdJfvI99?=
 =?us-ascii?Q?M2cSZZPU4oxjoJH4YG+k6K3o7S8ztAMRq3sncY9kQt953DzZSTDd+43pb48D?=
 =?us-ascii?Q?05tyv8TX45t3b0ZtEjAqhytKDHJYqeFoQcseehGRjjwcqIXtodwNQ3MyU4q2?=
 =?us-ascii?Q?5jbuk5Lcww0ZJUM/De/4bMUndcfWqM6yqCTyTLuv1iCef9KUeE8a63kBFPGy?=
 =?us-ascii?Q?bUW27or+1EkcUyezAeKMDUA8czrLsKK70grAb/MNh2qhR4CKb5uhfMJuZl0D?=
 =?us-ascii?Q?Oq88TbkbwXrHpm7BbB47qwsZJp8dz4VEgERKS6wzwACQ+lxM67ragB85kpSP?=
 =?us-ascii?Q?7W0/3fO4IW1+yPF9L36EufOnDig7xpUz/wgp8A+kRmGt9/APJOWoX1HW0R1g?=
 =?us-ascii?Q?TuxpSIgZ5+qwQoxZLK0tOGC/ZEWgYiABaF3Z7Kycr6qn/829R7ckmmmgk+kr?=
 =?us-ascii?Q?yd4k89gLnecFaOO90ImZmYCQrFtzII1147HPhebVMcF1GRSJkEi7b7lnAdMe?=
 =?us-ascii?Q?Tl/G4DCMWYPhtugSJaFHUBAW7jQSfMbt1YylHpWK1hMSqA6br71Wg57R0OkI?=
 =?us-ascii?Q?HjPwKCA0yf/ZqDx3re9NVnjGe5G6FFM9xRvYlxfbIIa/aiPayQrchhbY9msa?=
 =?us-ascii?Q?ldFZinL+uDdLM47ZrhAdQJcWOANe2nfoMh8telRO4XQHJAmXWlnU+LC8UZIR?=
 =?us-ascii?Q?hafbsWk6EThrJVIBe3FVkguX7bkqv4/sCpZGtbu2/63shPLk+5hTiRR5zbuu?=
 =?us-ascii?Q?xGnHJhn3bQW2Gqzi+abRykiwa2D9oxX0izOr6CAyCKun0hy+7BR68GOyYBhX?=
 =?us-ascii?Q?bQj7HvDv+qQ6Vrj9DtZVOlFYZ1i2ozysQnh8A7OWq4pgnsJHDloLMdxfkVU+?=
 =?us-ascii?Q?bzV5pXDpKg+T6UWORS8ulCCO2PvAvKob/lyOrZEHaZdXrwY1otusryTy7PQc?=
 =?us-ascii?Q?ALE4g6HecLSAcKCbmKfv/WvMCagV+qKHD1NrIRSbqJGqEqU7o+Eg7ga1RPDB?=
 =?us-ascii?Q?xMXWHEZXO5EGfaeEOm3sPEkt9lcl9KrZ6cLAYJIFY9sFkKS3NTu0nUd+++Re?=
 =?us-ascii?Q?kQVesboCf/WufljGZUK/efkIMDR6op65xqaHmBULQFgfiK8DPP/+NaIkKfC9?=
 =?us-ascii?Q?+XDmLqBfuG5dR0gOrc6Fq9aEb0tmfK3E6SUiJr86fF8cnGuuufmPqin33TuW?=
 =?us-ascii?Q?/M4FC5uENvjDCoCSPgqiYsSDQDwemt3w3J52GXvi5A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457cc3a0-ab47-4b57-e5d0-08daf08c337d
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 08:50:18.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2236
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
Cc: huyue2@coolpad.com, mpiglet@outlook.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The --ext # option is used to let the user specify top # file extensions
with higher occurrence to show their corresponding statistic info,
instead of hardcode some file extensions ahead.

Signed-off-by: Qi Wang <mpiglet@outlook.com>
---
 dump/main.c | 144 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 33 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 49ff2b7..24674d6 100644
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
@@ -14,6 +15,7 @@
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/dir.h"
+#include "erofs/hashmap.h"
 #include "../lib/liberofs_private.h"
 
 #ifdef HAVE_LIBUUID
@@ -29,17 +31,35 @@ struct erofsdump_cfg {
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
+static const char no_ext[] = "no extensions";
+struct erofsdump_extension_statistics {
+	struct hashmap_entry ent;
+	char suffix[16];
+	unsigned int count;
+	unsigned long occupied_size;
+	unsigned long original_size;
 };
-#define OTHERFILETYPE	ARRAY_SIZE(file_types)
+
+static int erofs_suffix_hashmap_cmp(const void *a, const void *b,
+				  const void *key)
+{
+	const struct erofsdump_extension_statistics *es1 =
+			container_of((struct hashmap_entry *)a,
+				     struct erofsdump_extension_statistics, ent);
+	const struct erofsdump_extension_statistics *es2 =
+			container_of((struct hashmap_entry *)b,
+				     struct erofsdump_extension_statistics, ent);
+
+	return strncmp(es1->suffix, key ? key : es2->suffix, sizeof(es1->suffix));
+}
+
 /* (1 << FILE_MAX_SIZE_BITS)KB */
 #define	FILE_MAX_SIZE_BITS	16
 
@@ -65,7 +85,7 @@ struct erofs_statistics {
 	/* [statistics] # of files based on inode_info->flags */
 	unsigned long file_category_stat[EROFS_FT_MAX];
 	/* [statistics] # of files based on file name extensions */
-	unsigned int file_type_stat[OTHERFILETYPE];
+	struct hashmap suffix_hashmap;
 	/* [statistics] # of files based on the original size of files */
 	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
 	/* [statistics] # of files based on the compressed size of files */
@@ -79,6 +99,7 @@ static struct option long_options[] = {
 	{"device", required_argument, NULL, 3},
 	{"path", required_argument, NULL, 4},
 	{"ls", no_argument, NULL, 5},
+	{"extentions", required_argument, NULL, 6},
 	{0, 0, 0, 0},
 };
 
@@ -111,6 +132,7 @@ static void usage(void)
 	      " --ls            show directory contents (INODE required)\n"
 	      " --nid=#         show the target inode info of nid #\n"
 	      " --path=X        show the target inode info of path X\n"
+	      " --ext=#         show the file statistics for the top # extensions\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
 }
@@ -164,6 +186,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 5:
 			dumpcfg.show_subdirectories = true;
 			break;
+		case 6:
+			dumpcfg.show_ext_count = atoi(optarg);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -208,20 +233,45 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 	return 0;
 }
 
-static void inc_file_extension_count(const char *dname, unsigned int len)
+static void inc_file_extension_count(const char *dname, unsigned int len,
+		unsigned long occupied_size, unsigned long original_size)
 {
-	char *postfix = memrchr(dname, '.', len);
-	int type;
-
-	if (!postfix) {
-		type = OTHERFILETYPE - 1;
+	unsigned int hash, sf_len;
+	struct erofsdump_extension_statistics *es;
+	char sf[sizeof(es->suffix)] = {0};
+	const char *suffix = memrchr(dname, '.', len);
+
+	if (suffix) {
+		sf_len = len - (suffix - dname);
+		if (sf_len > sizeof(es->suffix))
+			sf_len = sizeof(es->suffix);
 	} else {
-		for (type = 0; type < OTHERFILETYPE - 1; ++type)
-			if (!strncmp(postfix, file_types[type],
-				     len - (postfix - dname)))
-				break;
+		suffix = no_ext;
+		sf_len = strlen(no_ext);
 	}
-	++stats.file_type_stat[type];
+
+	memcpy(sf, suffix, sf_len);
+	hash = strhash(sf);
+	es = hashmap_get_from_hash(&stats.suffix_hashmap, hash, sf);
+	if (es) {
+		es->count++;
+		es->occupied_size += occupied_size;
+		es->original_size += original_size;
+		return;
+	}
+	es = malloc(sizeof(struct erofsdump_extension_statistics));
+	if (!es) {
+		erofs_err("memory allocation failed!");
+		return;
+	}
+
+	es->count = 1;
+	es->occupied_size = occupied_size;
+	es->original_size = original_size;
+	memset(es->suffix, 0, sizeof(es->suffix));
+	strncpy(es->suffix, sf, sf_len);
+	hashmap_entry_init(&es->ent, hash);
+	hashmap_add(&stats.suffix_hashmap, es);
 }
 
 static void update_file_size_statatics(erofs_off_t occupied_size,
@@ -298,12 +348,12 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 
 	if (S_ISREG(vi.i_mode)) {
 		stats.files_total_origin_size += vi.i_size;
-		inc_file_extension_count(ctx->dname, ctx->de_namelen);
+		inc_file_extension_count(ctx->dname, ctx->de_namelen, occupied_size, vi.i_size);
 		stats.files_total_size += occupied_size;
 		update_file_size_statatics(occupied_size, vi.i_size);
 	}
 
-	/* XXXX: the dir depth should be restricted in order to avoid loops */
+	/* XXXX: the dir depth should be restricted in order to avoid looes */
 	if (S_ISDIR(vi.i_mode)) {
 		struct erofs_dir_context nctx = {
 			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
@@ -481,27 +531,50 @@ static void erofsdump_filesize_distribution(const char *title,
 	}
 }
 
-static void erofsdump_filetype_distribution(char **file_types, unsigned int len)
+static int comp_erofsdump_extension_statistics(const void *a, const void *b)
+{
+	const struct erofsdump_extension_statistics *esa, *esb;
+
+	esa = a;
+	esb = b;
+	return esa->count < esb->count ? 1 :
+		(esa->count > esb->count) ? -1 : 0;
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
+	struct erofsdump_extension_statistics *es_arr;
+	struct erofsdump_extension_statistics *es;
+	struct hashmap_iter iter;
+
+	pos = 0;
+	es_arr = malloc(sizeof(struct erofsdump_extension_statistics) * stats.suffix_hashmap.size);
+	hashmap_iter_init(&stats.suffix_hashmap, &iter);
+	while ((es = hashmap_iter_next(&iter)))
+		es_arr[pos++] = *es;
+
+	DBG_BUGON(pos != stats.suffix_hashmap.size);
+	qsort(es_arr, pos, sizeof(struct erofsdump_extension_statistics),
+			comp_erofsdump_extension_statistics);
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
+		sprintf(col1, "%-17s", es_arr[i].suffix);
+		col2 = es_arr[i].count;
 		if (stats.file_category_stat[EROFS_FT_REG_FILE])
 			col3 = (double)(100 * col2) /
 				stats.file_category_stat[EROFS_FT_REG_FILE];
 		else
 			col3 = 0.0;
-		memset(col4, '#', col3 / 2);
+		compression_rate = 100.0 * (double)es_arr[i].occupied_size /
+				(double)es_arr[i].original_size;
+		sprintf(col4, "%.2f%%", compression_rate);
 		fprintf(stdout, chart_format, col1, col2, col3, col4);
 	}
 }
@@ -543,10 +616,11 @@ static void erofsdump_print_statistic(void)
 		.de_namelen = 0,
 	};
 
+	hashmap_init(&stats.suffix_hashmap, erofs_suffix_hashmap_cmp, 0);
 	err = erofsdump_readdir(&ctx);
 	if (err) {
 		erofs_err("read dir failed");
-		return;
+		goto exit;
 	}
 	erofsdump_file_statistic();
 	erofsdump_filesize_distribution("Original",
@@ -555,7 +629,9 @@ static void erofsdump_print_statistic(void)
 	erofsdump_filesize_distribution("On-disk",
 			stats.file_comp_size,
 			ARRAY_SIZE(stats.file_comp_size));
-	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
+	erofsdump_filetype_distribution(dumpcfg.show_ext_count);
+exit:
+	hashmap_free(&stats.suffix_hashmap, 1);
 }
 
 static void erofsdump_show_superblock(void)
@@ -624,9 +700,11 @@ int main(int argc, char **argv)
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

