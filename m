Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AA4358C0
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 04:59:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZXJP72Tgz2yg4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 13:59:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1634785173;
	bh=ZTJ1UfhR6iHh7LRmX/vz3ZxoiOdO8bJsZyUG1/+Qzb4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ylo69W01QfCDYGaBVvAxRzal0mteqUck2Fj+6Q+9aiEMP8iNEa1f9uGoKjsgzKeb+
	 D1gpYik6mGxv593VgcfdMH48uDX8nQYqD7mXAq+RxgRbu3LKZwWXlmnCLvqcyukM+Q
	 YZedvwnbLFtvrUwtlJlUBSotijsr32ySKYdYM8sU3g6QQBnfAD2xdava/fqYTNaABP
	 /s/Cygvkdw3epm4USItPEs8Yvq7imQXpGCGjV38+3chq8olANwf6aprGjasSeHbzFV
	 +SQf1795H+mFXvadyZ4UAMFkqW1IZyz6SwX0eARa0QqbmwXIF4eVzLxTLDDGeTD2XK
	 /nhh8WI2R8qDQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febd::602;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=kYE0KDqx; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febd::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZXJJ0fGvz2xth
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 13:59:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5Mr2pfZ7ucJZcadH7tvQ0bVPb/nqUBVCeCnJYMCEQ9U2pBe3p190sA5M26NUqoYuLu6c9UJAXrFAYQ9QuFvGqRG5rLSUIwyQV1ta2PNs7+n/mnDrafOD1lLv6MTljLby027keTOz5BYkhYIiMuGKd/IhutE3yIgGrp2RmvSz2lv2L3YWE3hxQGSJa8KdW3g3coDjReqsSE1dtUZRwC2kpS4cJva/CWnPihfqpSIq/5KWwWnspAw1XKLqE13rUw7Wix3rH1kpNy0ld5cr/T92vzB94zpLtMrKecHI0nreBzDptbrYpq2L5g7dj9EWBjP0FGZ5NVd/g3Wn7x7Az2F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTJ1UfhR6iHh7LRmX/vz3ZxoiOdO8bJsZyUG1/+Qzb4=;
 b=WoVJLAS1gS+HOGaSAi7QofisuC9v3QdJNPT88vOgscZZU9LpLz7BavVA+44MtZuAWmp7EFw6Evy/DVJyN5stnBXs4NgT98ONWGIzyqRAVv/FFoi9NEvi9fSW2dKfDNEQE0lS7Cs9qoLR74t0XiKDtedFPfQOSAaIiOSh0PZFrDdQFrJRw9MnZcOOQ7dm0Js6snuEjC+xAdlAZ44YeWkhe7vp7Z/8kPvnHqoqCQVYrwQXa0u+TqQIfpsIlhnx5unI+pnl02PhAS++CPsBbOzu9h4IIl+QVWGd2R0bNthPGlUGH4kH/qLaokx5O4AELGGYrdXDR3BS2POeeZBNrMEMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4203.apcprd02.prod.outlook.com (2603:1096:4:9d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 02:58:59 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6%6]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 02:58:59 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: sort shared xattr
Date: Thu, 21 Oct 2021 10:58:47 +0800
Message-Id: <20211021025847.1136-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021025847.1136-1-huangjianan@oppo.com>
References: <20211021025847.1136-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.255.79.105) by
 HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.9 via Frontend Transport; Thu, 21 Oct 2021 02:58:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00397abb-f174-45f8-89fb-08d9943eba96
X-MS-TrafficTypeDiagnostic: SG2PR02MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4203280C9D5001741B08D1E7C3BF9@SG2PR02MB4203.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayAp9QO5Td1On5AnH8z04QOvfpJyVto96b/xPkeDpGZS9pCE0pp4gpothQ1kLmaqyuT6kJBPs19m6BO/dXbkw+a06Eoc4se99mCR9RKJ363uZj9SEhqduPj2tLgpoB53/f1IL8ycD4hh1aeVMhmHl3od0cIialHzo5C1ViypmPjSWzFq2X+4xy7l6ofQgckW0nH9Rlw4CBIBUSUcxMYywFowF4y9kQsjauYsEKuZv9cxKeasd29H9QReZuF2dzWSFyFdvWP+7oZ5HO/NCku8nB+W3qHvT90+oGKe/Ghlxv2GOzieFvvZIXGao8qxcNxCw2ZpG7KjeDC3+XGI4Potc2e40I/Cnj1eLJnd+ugEcq1M2YBiwyqHFXgKZ7l6/IyfL/A5jN32MArMtqfE57gwYL3/dZSn865HkcUASnzCewSFu5ipm9O8Zyy8A4DSUCzb17E7hK8Oaqb79Gg/ecfAYSa4hcrQ7kDyoD5PEvA5z4aGcj9RDLnc1RKzyrhuti3A3vmTkRRB5ZJBLcuLrTy4+02dOODEQiSGox46dsqAIhKi/Wrlq7pO0H+1KLi/AVNdDQJ6c1eZw1HtOgElJeDvRbUQcc3V7qSHwfQi2iDg+zWyzjv8FlZsm23x6rrVY6VSm7wt3Q48JCBEV9w3yDm122Xxvf8zqumjQOq1DWRkcrC0R3fo6hPhAxmcoyV1Oo7Twmk4MFvZ+m+IDZHDPxcwHqJECKu0li1ngnf3SMge8F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(26005)(66946007)(38100700002)(6486002)(6916009)(8936002)(52116002)(316002)(36756003)(107886003)(6666004)(956004)(86362001)(83380400001)(4326008)(186003)(2906002)(5660300002)(6506007)(2616005)(1076003)(8676002)(38350700002)(508600001)(6512007)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaoWy5aCzuqRMp3exlf9RSphCZOYvhIELww3NHVkJMsUGTYQiBVqZMEhMGvI?=
 =?us-ascii?Q?En1X5DEaDYyoF/a0hipNHn+DGODJT/fdY4THNBLWBcpg2ZMpEicUXAhE7OnG?=
 =?us-ascii?Q?NMV2Ci47YzvR/6nQvN2GL1x+PBAcrDmB/bDSrVTHBvWfUoTs5WueM/7ob6pL?=
 =?us-ascii?Q?LIhNNPyyl2aVA0Eyyq0ixSo8sDSV4EOBH5cnnzB8KFzJjkcVSqHf0+tY/CsZ?=
 =?us-ascii?Q?7mex27jo8php6DPCeJKy6nkLMJsv9+nganNbUY4NfrUIggK+HfZBLBDsmlWv?=
 =?us-ascii?Q?vE+y4d4kxko2VvmhpM5ZLH17wAEIHpNISr9eXnn+vgCjCiZjVysh/Zr2Jmsw?=
 =?us-ascii?Q?mLC6qkkWhZhuoy6T/Jfux6XOptU1oXYLWs1tu5XHVB8lSijiBHpgSAWEtpZ6?=
 =?us-ascii?Q?qIra1aIsXeyumHDiFWR/1X9P1eepEjDkzmyyS0s2wix+3gAM/g/VwkpiwY48?=
 =?us-ascii?Q?pN8wDumpzSVKZLuRmqsdevn7sRZfI8cW9gVPtt1uIZqM9DsaM4P2yN72sMSf?=
 =?us-ascii?Q?TObDqHn2sHzxW0Rr2F25MuYq5IwxOn9ezyheUlboCwA/yMCgsSs3BLzf0fwM?=
 =?us-ascii?Q?2RLImoFS0suNPsSxzTA7k/WtTVsFTviJr84R0Nl7OKOq4rPqjly38cXSAmVJ?=
 =?us-ascii?Q?7aahJ+yisLq1iVrEYo0SkKHXgB98c8eOPMKrC5fhfurbJnLC0hGOE0VjZ/ST?=
 =?us-ascii?Q?sA9gQktEF2FmjkWJXFjOwuDl/lsyZIm7nLG/qdC7fPg4FcdS8E1/38pILHRG?=
 =?us-ascii?Q?EpdUbKGO+E6G2l15vFElrnHnqUDCrdpcILyT1Se2wAn3I0jpwwOKsd3//AuU?=
 =?us-ascii?Q?MBxk9JHGPnUoM0oJ7DqHWiQ1hiio497vFYWMLEPRTsv9zdTCId9eKzsFtulJ?=
 =?us-ascii?Q?VlQKj79oGXobvsRcHF1HMgujKA5X0F56+U2QRF/IBLL28rKaEEtrGLojxMpJ?=
 =?us-ascii?Q?HgjpCCQq8x+KRgvjm6+VmzLYuYC3Vh/ZwTzlgUlLz9DKZP18i+lfbctYc7rD?=
 =?us-ascii?Q?RjVEUH9nlmVViHXAlSc+qOW/f24P0g993IheOLVN78cyWYU7a/rAWdqrTEye?=
 =?us-ascii?Q?WHga+x9trq/fYgofmBfO+8B//5nmGsFig8GgMlJEb+DFFgX++Ju1ZF5a3TiT?=
 =?us-ascii?Q?ZKA4xPSxX0tQAyGDn5lmnO1u8RoeJfy8uFRWHkZx+mx2xFZd7a8mnwpZceRu?=
 =?us-ascii?Q?BWRXPDLoulNFwEhH6AvKRujbsand2WI/9iOYaVyiFydX1Z2tpwpKCa4behRa?=
 =?us-ascii?Q?+KEiAdbAJ9cNS8vleiyLJqRv3ksVSM1fWYKaeKQFfB8pJYpLsyA+ahw0/9Ef?=
 =?us-ascii?Q?8MLIBbTh+3ecAfKRImHsaR64?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00397abb-f174-45f8-89fb-08d9943eba96
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 02:58:59.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1clm2UbHLHoB+YwVdTkwGq1vKmiKslAZhxMGpA+d/LXmhKIpQh6Ek6tag/LbzKQQSRodW//NTIXl5mlWABqGQ==
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

Sort shared xattr before writing to disk to ensure the consistency
of reproducible builds.
---
 lib/xattr.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a..f17e57e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -171,7 +171,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	/* allocate key-value buffer */
 	len[0] = keylen - prefixlen;
 
-	kvbuf = malloc(len[0] + len[1]);
+	kvbuf = malloc(len[0] + len[1] + 1);
 	if (!kvbuf)
 		return ERR_PTR(-ENOMEM);
 	memcpy(kvbuf, key + prefixlen, len[0]);
@@ -196,6 +196,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 			len[1] = ret;
 		}
 	}
+	kvbuf[len[0] + len[1]] = '\0';
 	return get_xattritem(prefix, kvbuf, len);
 }
 
@@ -398,7 +399,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	len[0] = sizeof("capability") - 1;
 	len[1] = sizeof(caps);
 
-	kvbuf = malloc(len[0] + len[1]);
+	kvbuf = malloc(len[0] + len[1] + 1);
 	if (!kvbuf)
 		return -ENOMEM;
 
@@ -409,6 +410,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	caps.data[1].permitted = (u32) (capabilities >> 32);
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + len[0], &caps, len[1]);
+	kvbuf[len[0] + len[1]] = '\0';
 
 	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
 	if (IS_ERR(item))
@@ -562,13 +564,23 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
 	.flush = erofs_bh_flush_write_shared_xattrs,
 };
 
+static int comp_xattr_item(const void *a, const void *b)
+{
+	const struct xattr_item *ia, *ib;
+
+	ia = (*((const struct inode_xattr_node **)a))->item;
+	ib = (*((const struct inode_xattr_node **)b))->item;
+
+	return strcmp(ia->kvbuf, ib->kvbuf);
+}
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
-	struct inode_xattr_node *node, *n;
+	struct inode_xattr_node *node, *n, **sorted_n;
 	char *buf;
-	unsigned int p;
+	unsigned int p, i;
 	erofs_off_t off;
 
 	/* check if xattr or shared xattr is disabled */
@@ -606,6 +618,20 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	off %= EROFS_BLKSIZ;
 	p = 0;
 
+	sorted_n = malloc(shared_xattrs_count * sizeof(n));
+	if (!sorted_n)
+		return -ENOMEM;
+	i = 0;
+	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
+		list_del(&node->list);
+		sorted_n[i++] = node;
+	}
+	DBG_BUGON(i != shared_xattrs_count);
+	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
+	for (i = 0; i < shared_xattrs_count; i++)
+		list_add_tail(&sorted_n[i]->list, &shared_xattrs_list);
+	free(sorted_n);
+
 	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
 		struct xattr_item *const item = node->item;
 		const struct erofs_xattr_entry entry = {
-- 
2.25.1

