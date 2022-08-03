Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E8588E9C
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 16:23:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyYxw0fXpz30JK
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 00:23:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1659536628;
	bh=6l/906D/TZot7ybMEVntJJ5hBO+iZIa4jyByO4ZN5Ro=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jiyQiw0bCSOLOlIFHam7+67UQTV0u4YvMxARBMM4dogtto3TaKFn9MuMUgcMeD+WS
	 uQRJJKbn+oRh2q20e8OiwSLjfp1qG4r1YDDTtSvbWMCHPYmmflbbMqZFy11MzPEYlq
	 VaZZ+pltyxCkeknHezRhv1kCSCUGTOYW/4QT3Gc4hogd1Taw6boqMwFb8+wljWaMnt
	 InvJpH9QalMY+R/D5TFdJ9/Bx4XxuYjmL0WTMUn3rn/dj3N2VyLXKBSoqxW8Yimpnt
	 Le4b+8YfiMcpvtUNqlb/ipYjvOL/tKnmKYlp3PPtjbe7w3U0VylzPy+elIf8peFHU+
	 z5iIhpfe1NYBQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=apc01-sg2-obe.outbound.protection.outlook.com (client-ip=40.107.215.64; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=C7YbwtXo;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyYxc2GYWz2yMk
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 00:23:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKVa3jz0pH+uHJ9Wy6juOVMdcNKuJOWTn4Wr2k6/4Ksnx9CP83W+EIP/MIo2MdpBnppz/Ir6JBEpo1S9/NVr6XS8vX7am6rqfapZwStqFvfRLQ2rr5BLYcqHB7X8H5yjCB94YDQCU4A2Y7711avq2HZ0oc2QJOxbuyQGOeVmx6GwW2blxY/iyM6z+hInoVPL0lIA4RDM9icp86+ZfgXVjJD4vQBPYvPhX0MELogh2QV4OJZcBfVVsEdwsF25lWvaqMbGF6Z+RQP/lPd1RW7Kqaph4sRJRpzoOCKqGABBrly+EUfEKp2NNJi85vwQza32xmppXST+1mIcgo53OM1KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l/906D/TZot7ybMEVntJJ5hBO+iZIa4jyByO4ZN5Ro=;
 b=WuXWxkbnJyvv37K7qSa6o8lcKW/SwF8jSQM5nMQ2YPVnGctY1PCm205aSTSTp7Szuq6Ui/VXgcp5Hx3nm9VgjyMSqA+EDpbz/CGR/uYxHiX9+bwuByhTEFWt6qN29azzdf2X+W8a16eroS4wO8M90xx1y5MhYwKRzOJS3QmEpFt5RejidcMyPBsmIHSc+0JbfWMKZePA5NHxviiGS2kEb5kd9sHqFfgRzI8zPV6Oz5e+iJeyCUJACd9VxdEzOCnIpUhLv8kcji4Jea9uM6Og69UlDYFc7iDEqverwLG2gDhfh0A3UXtGXt4SxS34fvQh/dTUZHXJNKVHfnfDfuXL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 TY2PR02MB4493.apcprd02.prod.outlook.com (2603:1096:404:800d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 14:23:11 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 14:23:11 +0000
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	linux-erofs@lists.ozlabs.org,
	chao@kernel.org
Subject: [RFC PATCH 3/3] erofs-utils: fuse: support get/list xattr
Date: Wed,  3 Aug 2022 22:22:23 +0800
Message-Id: <20220803142223.3962974-4-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803142223.3962974-1-shengyong@oppo.com>
References: <20220803142223.3962974-1-shengyong@oppo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedc3ecf-6dc0-4903-c8f6-08da755bb1b7
X-MS-TrafficTypeDiagnostic: TY2PR02MB4493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	SSPOb26RIs6QQx7zwL8FsR5F6eiN+KVIv4u3USfcx6vWMnDQtgkWqL9lnCPe6PnIH5Vjh8Jp9qXle69NVvM+FYVd3CLmratWUeV/Tm6PXRI3eOXRgKM0hdyipAIFCLyYDO3ooA1D4poIj48+dg7fFNxDrX/EyFhsdDGcc6Ey7D/MriCxTvl5yROmZbc5P9b0nJsaA3Hm+tDyQSEuqYMuqu8REQ8KMUy3X0xlWD2frNh/dq090WZPfINYczeEuI02f1QtCw18ZQUik5z1GXB6FRmbdkf2s5kUK4zaQHIaGlk5v3i63r/VlGiB5xqcZ0ESn3iiS0i8KM3X6BSkdkMTsMbXRRjcaaWxjSju/t7fw0W+rcnNiyys222aohqCcdIon92NRQdBzEFlyGbpMEHLIrsx9p1YwU3Zv/x0tNNB9L738437x9cUuUzA1a2y3FjbtxRePxDggXy+nnFcfLwTNoVaydZB+kH/hOIeYtwFVZmgncIOpzpbJvw+czA91ZvLDuVM/9by0zVKxfS5ZswfMW4BUGSql3BiYlgQ5VY1ya3g9m55RI+V2hUwC3o9uH5njaLQROF6PRTOSbDw7D3/sgzvR4sq5L+EZlrVViwQrG61v5d18eB+CSrO4e1ZrkPBDyDVbClc5WYSv7g+Odce+LmRVivwwrANw6weHKKsZDbzkQFOgXuyLzzpm7lEnI2Ya/o5qDJCgIvE7HBoP5A4GtNw25Lt98Dv8Hz1YDAvE8gaSB8HU+xyn69pCtv70Dad0zu85gVDJ9ojZQmRa/9UcrDvFk2Ojpg0l1z5/bZqtNQ=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(8676002)(186003)(66946007)(4326008)(66556008)(6512007)(1076003)(2616005)(86362001)(107886003)(6666004)(66476007)(316002)(41300700001)(6506007)(26005)(6486002)(52116002)(478600001)(36756003)(2906002)(38350700002)(83380400001)(5660300002)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?3Nn0LIQGrAbUPdqeJKuibwJgB6EguXBij+UDaVOULlEsSiOUE/wxUDkQAycB?=
 =?us-ascii?Q?UC1xDMCCMpJSHOjAfu1b2z7hHDRy9FrZ2ZfHbaODsNo8vAz+OHnkUJUv2pJQ?=
 =?us-ascii?Q?AmBJBdnWf5LXpJPVp7/TgK6Bt6Texpib4Sm3yMW3CPKMdFvTH37+xh7AE++7?=
 =?us-ascii?Q?nC1LhnE+RGIFhGLi6cHFDXvYNgB37d73rbre3/AhaD3GMflGKUlZgntHC2Fb?=
 =?us-ascii?Q?afTqzj5/KHSG14dztFg57uPel5CkVq55m8jd+9QFxKyt/GKiBXdBqJwfpaaH?=
 =?us-ascii?Q?MMzPib62tsQzXhBbLOvneHYaSl8KILM7gi6mckklGB+IxplyUBb3fxjfd9Lt?=
 =?us-ascii?Q?zx58vq9kWPqyuE4h8hu1wTI9qTEBl1KNmP0TB3qGNYlsOjv1PYgLwDfZtU2s?=
 =?us-ascii?Q?KswQc8WLoIRyvPIDbFInpqw0AdfpPA9vS1/MP87P1kLRSjCS/wKvvPNn+cuU?=
 =?us-ascii?Q?LHlgFzFkdM5pjrgeQb4uqxKHwDdDN+eZeir7hdG04Aet32qebQ4P0YxwvSAe?=
 =?us-ascii?Q?xZ/JgQZkedO0od0iDiBfUKSWfg3PsZ2UyE6y8PlEOZGeV7ZBNw/nqcuPNXzj?=
 =?us-ascii?Q?gJ+fijQaT7zAKY8tm6S5Ys16IWBsLP9oWzGjjeVCbBnfJlHLwMMnOlneFcsK?=
 =?us-ascii?Q?AgAuHFfMWczJK93KZwRpmnLUWXZPYBCy5zKVu+7OcndbJPxvkFaIumKXWSMr?=
 =?us-ascii?Q?BVOKdKx/4JNSljqETfFJHhPTVkAGtR1R9FrklPFfM+omvi+qrfk9S+hdQNVu?=
 =?us-ascii?Q?G6eeBnIuRbXLExpTlMiI8F4m/5K6QMvcd+IC1o+M+Klr3t6VMsJIe+AsQ2CP?=
 =?us-ascii?Q?1BgwgZkx1Tt5Cc6roumZ4WFW5HVauWfOod1AUUEkVngrH1e9uRcXnRGB0zqX?=
 =?us-ascii?Q?nuzsZs0kot+WWPkhXg2BpawWkaVd/am9CPJTAXCVOQr8SOrlM1BzmYlWGJO4?=
 =?us-ascii?Q?bMfK/RIr6V7lLopMJr28GJ4W+6VZkJXe8hNzxZQmmkB7vC93lJDkKEUNXWqr?=
 =?us-ascii?Q?zQuKRPw8HPqzTSTh7/SKi1MXuJ0vnQSJWJVqW/p19ODWTYTsgvdtHOnflwB6?=
 =?us-ascii?Q?U9hCB6/pn2/87IUqnKa1WuPhLpDmc3zbWG+f8cGb+MX983hPJUOCRpVkP/re?=
 =?us-ascii?Q?O/G2lZOzTebnzEc8MeJgyF3q7zl4L0rrN9GTGl6oqW+iitnUf9nm4gLFaup1?=
 =?us-ascii?Q?2OVnkeL4se5+nvmAPr7stg0dmZ31egW/9gDZJoIVtMZkVCZulNZnfLrcHedY?=
 =?us-ascii?Q?CeQ9PXWwus6bBjyetP7Paw6XkCoyjUMb4eYonifdz0knKLGEj3i3jBj0/8bf?=
 =?us-ascii?Q?HO5gt1vwfVXevqwuX8Jnq0znOqXXeTIE9znW9+0PzwMu/L6dSb+L9/+m3XVE?=
 =?us-ascii?Q?OMe9dAnXcsKT8Rp9aIX2U1D2S7e22h9JKlB8oYpIcxH9k8jJ7dtXsL2ATY8h?=
 =?us-ascii?Q?42Baj3luF1RQkTkTagd/hOr9opFzCh+b8DmwhEKmhrgRevengSbtvXXwIMVi?=
 =?us-ascii?Q?MDIUGNxUYemnqTjA2kZHIJGaGGhwt6gg6uiV+Cso/uaIPHsZTzVdj+Ko0KXP?=
 =?us-ascii?Q?nOiL023hfyzviRCRIKQoBMHWiPnq1AWYsBZrmHv1?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc3ecf-6dc0-4903-c8f6-08da755bb1b7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 14:23:11.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZCRuq8vlEjivTn48zPub6M2ssXji5fPVBwF6KMRYz7kxx/iSaRVsSm/BUSFpCccxFX6tEZlfV9D+70WFMgAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4493
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
Cc: shengyong@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add new options get and list to xattr iteration operations to
support getxattr and listxattr.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fsck/main.c           |   2 +
 fuse/main.c           | 135 ++++++++++++++++++++++++++++++++++++++++++
 include/erofs/xattr.h |   8 +++
 lib/xattr.c           |  26 ++++++--
 4 files changed, 167 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 237ccc1..ceaab3d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -291,6 +291,8 @@ static int erofs_verify_xattr_entry(const struct erofs_=
xattr_entry *entry)

 struct xattr_iter_ops erofs_verify_xattr_ops =3D {
        .verify =3D erofs_verify_xattr_entry,
+       .list =3D NULL,
+       .get =3D NULL,
 };

 static int erofs_verify_xattr(struct erofs_inode *inode)
diff --git a/fuse/main.c b/fuse/main.c
index 345bcb5..7997234 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -14,6 +14,7 @@
 #include "erofs/io.h"
 #include "erofs/dir.h"
 #include "erofs/inode.h"
+#include "erofs/xattr.h"

 struct erofsfuse_dir_context {
        struct erofs_dir_context ctx;
@@ -142,6 +143,138 @@ static int erofsfuse_readlink(const char *path, char =
*buffer, size_t size)
        return 0;
 }

+struct listxattr_iter {
+       char *buffer;
+       size_t size;
+       unsigned int ofs;
+};
+
+static int list_one_xattr(const struct erofs_xattr_entry *entry, void *dat=
a)
+{
+       struct listxattr_iter *it =3D (struct listxattr_iter *)data;
+       const char *prefix =3D xattr_types[entry->e_name_index].prefix;
+       unsigned int prefix_len =3D xattr_types[entry->e_name_index].prefix=
_len;
+       int i;
+
+       /* if size is 0, return the total size without copying data */
+       if (it->size =3D=3D 0) {
+               it->ofs +=3D prefix_len + entry->e_name_len + 1;
+               return it->ofs;
+       }
+
+       if (it->ofs + prefix_len + entry->e_name_len + 1 > it->size)
+               return -ERANGE;
+
+       switch (entry->e_name_index) {
+       case EROFS_XATTR_INDEX_USER:
+       case EROFS_XATTR_INDEX_TRUSTED:
+       case EROFS_XATTR_INDEX_SECURITY:
+               memcpy(it->buffer + it->ofs, prefix, prefix_len);
+               it->ofs +=3D prefix_len;
+               for (i =3D 0; i < entry->e_name_len; i++, it->ofs++)
+                       it->buffer[it->ofs] =3D entry->e_name[i];
+               it->buffer[it->ofs++] =3D '\0';
+               break;
+       case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
+       case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
+               memcpy(it->buffer + it->ofs, prefix, prefix_len);
+               it->ofs +=3D prefix_len;
+               it->buffer[it->ofs++] =3D '\0';
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       return it->ofs;
+}
+
+struct xattr_iter_ops erofs_listxattr_ops =3D {
+       .verify =3D NULL,
+       .list =3D list_one_xattr,
+       .get =3D NULL,
+};
+
+static int erofsfuse_listxattr(const char *path, char *list, size_t size)
+{
+       struct erofs_inode vi =3D {};
+       struct listxattr_iter it =3D {
+               .buffer =3D list,
+               .size =3D size,
+               .ofs =3D 0,
+       };
+
+       erofs_dbg("listxattr(%s) size %zu", path, size);
+       if (erofs_ilookup(path, &vi))
+               return -ENOENT;
+
+       return erofs_xattr_foreach(&vi, &erofs_listxattr_ops, &it);
+}
+
+struct getxattr_iter {
+       const char *name;
+       char *buffer;
+       size_t size;
+};
+
+static int get_one_xattr(const struct erofs_xattr_entry *entry, void *data=
)
+{
+       struct getxattr_iter *it =3D (struct getxattr_iter *)data;
+       const char *prefix =3D xattr_types[entry->e_name_index].prefix;
+       int prefix_len =3D xattr_types[entry->e_name_index].prefix_len;
+       int name_len, val_len;
+
+       name_len =3D entry->e_name_len;
+       if (strlen(it->name) !=3D prefix_len + name_len  ||
+           strncmp(it->name, prefix, prefix_len) ||
+           strncmp(it->name + prefix_len, entry->e_name, name_len))
+               /* not match */
+               return -ENODATA;
+
+       val_len =3D le16_to_cpu(entry->e_value_size);
+       if (it->size =3D=3D 0)
+               return val_len;
+       if (val_len > it->size)
+               return -ERANGE;
+
+       switch (entry->e_name_index) {
+       case EROFS_XATTR_INDEX_USER:
+       case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
+       case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
+       case EROFS_XATTR_INDEX_TRUSTED:
+       case EROFS_XATTR_INDEX_SECURITY:
+               memcpy(it->buffer, entry->e_name + name_len, val_len);
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       /* found */
+       return val_len;
+}
+
+struct xattr_iter_ops erofs_getxattr_ops =3D {
+       .verify =3D NULL,
+       .list =3D NULL,
+       .get =3D get_one_xattr,
+};
+
+static int erofsfuse_getxattr(const char *path, const char *name,
+                             char *value, size_t size)
+{
+       struct erofs_inode vi =3D {};
+       struct getxattr_iter it =3D {
+               .name =3D name,
+               .buffer =3D value,
+               .size =3D size,
+       };
+
+       erofs_dbg("getxattr(%s) name %s size %zu", path, name, size);
+       if (erofs_ilookup(path, &vi))
+               return -ENOENT;
+
+       return erofs_xattr_foreach(&vi, &erofs_getxattr_ops, &it);
+}
+
 static struct fuse_operations erofs_ops =3D {
        .readlink =3D erofsfuse_readlink,
        .getattr =3D erofsfuse_getattr,
@@ -149,6 +282,8 @@ static struct fuse_operations erofs_ops =3D {
        .open =3D erofsfuse_open,
        .read =3D erofsfuse_read,
        .init =3D erofsfuse_init,
+       .listxattr =3D erofsfuse_listxattr,
+       .getxattr =3D erofsfuse_getxattr,
 };

 static struct options {
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index c592d47..eea3a2a 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -45,8 +45,16 @@ extern "C"
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif

+struct xattr_prefix {
+       const char *prefix;
+       u16 prefix_len;
+};
+extern struct xattr_prefix xattr_types[];
+
 struct xattr_iter_ops {
        int (*verify)(const struct erofs_xattr_entry *entry);
+       int (*list)(const struct erofs_xattr_entry *entry, void *data);
+       int (*get)(const struct erofs_xattr_entry *entry, void *data);
 };

 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
diff --git a/lib/xattr.c b/lib/xattr.c
index 92c155d..eed3c71 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -39,10 +39,7 @@ static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS=
);
 static LIST_HEAD(shared_xattrs_list);
 static unsigned int shared_xattrs_count, shared_xattrs_size;

-static struct xattr_prefix {
-       const char *prefix;
-       u16 prefix_len;
-} xattr_types[] =3D {
+struct xattr_prefix xattr_types[] =3D {
        [EROFS_XATTR_INDEX_USER] =3D {
                XATTR_USER_PREFIX,
                XATTR_USER_PREFIX_LEN
@@ -811,6 +808,17 @@ int erofs_xattr_foreach(struct erofs_inode *vi, struct=
 xattr_iter_ops *ops,
                        if (ret < 0)
                                return ret;
                }
+               if (ops->list) {
+                       ret =3D ops->list(entry, data);
+                       if (ret < 0)
+                               return ret;
+               }
+               if (ops->get) {
+                       ret =3D ops->get(entry, data);
+                       if ((ret < 0 && ret !=3D -ENODATA) || ret >=3D 0)
+                               /* error or found */
+                               return ret;
+               }

                ofs +=3D xattr_entry_size;
                addr +=3D xattr_entry_size;
@@ -830,6 +838,16 @@ int erofs_xattr_foreach(struct erofs_inode *vi, struct=
 xattr_iter_ops *ops,
                        if (ret < 0)
                                return ret;
                }
+               if (ops->list) {
+                       ret =3D ops->list(entry, data);
+                       if (ret < 0)
+                               return ret;
+               }
+               if (ops->get) {
+                       ret =3D ops->get(entry, data);
+                       if ((ret < 0 && ret !=3D -ENODATA) || ret >=3D 0)
+                               return ret;
+               }
                addr +=3D entry_sz;
                remaining -=3D entry_sz;
        }
--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
