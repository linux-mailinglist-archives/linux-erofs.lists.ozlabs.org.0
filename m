Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F3365821
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Apr 2021 13:53:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPhsh2bMqz2yjK
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Apr 2021 21:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1618919624;
	bh=s4+8oi0ALeqKSALeFHERwIpciYRNByYFnwguJN1Gm70=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=bMeZzzb/IJHot2oLsR4zZRTB0Z1rZvUT0dqdIhzYUglZ5CJf28qNdVvvh+dsaazMx
	 FDo1rTzLpVK+BWZ1gGtwt+8zQ1UxubRP6RQWrxgxoIi0fYu3l2hDvuNrBdfTQ5Yw8Y
	 PI8wFV1UEpAZywFApjV0hLeiTwcTo4TPQsYYrwu90PAxtSGRaxq7PGl0zbfdfhevpL
	 qUx5LlzwieXtrCBKgZpEkQL8Sk69CyPH6nLm1XUiZdeWWRZDSMT277OHAQKVn05izq
	 ZVzuLv3TxAd89suWm//LVobepyQ0ExEXM0RR/rhJMGhtmvzaK3/ZG/bHjA7hV/ryNp
	 v7+TGCofOi7MA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.51;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=bXI5KMK/; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320051.outbound.protection.outlook.com [40.107.132.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FPhsZ6XM4z2xfk
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Apr 2021 21:53:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkQT0LMkAD1ldfjJlkiJwixX1kxQLtZ1cGqSdyMyeaJDv+lFFMRlCd4WsUweOANrhV2B+1PtsG6MMhbqQyJp2+wfgNNcJqoH3GQIUMZhkLvXWORXOemsLcnFCEG+U2xXW06IVwo6zADSVFMTrltYYZS5tuSg+mM/V/X68HgBcMnJd+qe4RTY+phJUppf5Ia+2rDEZF9C/z10Xz1gPi4cm3sKNHVXnwlBM4uRvedZAYMqs0x4J1eYFFOoW5sMKf3u0ZYuxMXZ1Z4zGDRqCdY8aoMSKsWYMnL9gBXiCMvAJBNfLbQaZkLK49OFWP6KOkRlSGCaCaILvys1laR6PgksEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4+8oi0ALeqKSALeFHERwIpciYRNByYFnwguJN1Gm70=;
 b=W7fDpPUywbH7ns3HBQ125TbRPmO1Z95RaBpRJje00uAHymkvjq2aALhasHuS1TtehYT0FWBInHBI6psNdFPqtA/6Ag+vbVyCgiE4sJjFHtV7B2/aHxnrRyeqNztljsQmR4LT2c8fiWEV2Xf6bdh5qmfvFmpCW3TmBsffNgDF1HvnfWV9pssmvjO9UCx/JedvYdZrke30g79GIWVasXRdR1f4TVgmgRQ6SJ+1w5ViavCiqZKGMO0eooY31Jw4FZ0YzDOfrkVgQ9goEoHD1vyYaIJNbuMa7x+FeqKjg9GkzOtHh3qsJQk1IponymVwtS20YGi8QwYFK3jREJQippEoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4458.apcprd02.prod.outlook.com (2603:1096:0:d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 11:53:07 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5894:37b3:a7c5:18b4]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5894:37b3:a7c5:18b4%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 11:53:07 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: remove duplicate __func__ print
Date: Tue, 20 Apr 2021 19:52:37 +0800
Message-Id: <20210420115237.52938-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 11:53:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5db839-24cf-4548-4d68-08d903f2dcb2
X-MS-TrafficTypeDiagnostic: SG2PR02MB4458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB44581C7C9EFABC555C957F2DC3489@SG2PR02MB4458.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsMIGEdBNbgZm4GAZ8b2iI2ju+Wf/FLHEfBt/SWkkpWwJUZnQYQz/AKQDNByDZdpi/6wHG2EPiXj73n0shM2beDpkdMRkdfAzn8/a/o29iCEvqbL1FNvo7LEbGmM0XsM9HWPAAvUfaHJo9OqmVz5bhQ0lFV2PrzpL1oh+PDxdcogSDqcEDCLcb39FN8CLQdJ51arvlmJCp/21Odu1U6RufN1J+ghhbawHplh1JjDlg5zIhlAgdE5et9cKwdXaPVZR2Tmw6CPnuluytrllgcfGAHLKOPadhlx2+BGselaTbjYSVm1bLc298a9a9lR/Wd5tt5RoDVR0/K682bKFvDWiOfPmLtuRgxye2Z18KzjzyWBOft9Q0rw9yzjsny77uWmFbvuEKAwC5qkkZqM1GovVKAekmox1N7ytAMJpp5pI1k/tMgJsIfCNo/6s5AvGbHwoyOnuq5rzlB9hDBhkBf9OSWhdTV52W23+Nfs5W0HWNWhNDpnOa4trM0FwLVxRPm8BjcD5OdfD0Ltwuz00TvlqFU2EPsmkR3ZAdz34js1fCoQ1hY15TZMlGpJVtPeLXEKxbrIjHzzxxTiWsvbIcX7QOCeE6nhZMjCg0x02pVedzvEt99n1Lu7KFJYz8HkG/dQCv/MCRSNjYPFGAOBm5SbcUTAtJ/h+a/qV7opSGtO2pYZRDduedpm6U/3PUHq44s5XJ4G1q0P0+Ajy2XEmyYSwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(346002)(396003)(136003)(376002)(478600001)(6486002)(86362001)(316002)(6512007)(26005)(36756003)(6506007)(6666004)(16526019)(5660300002)(6916009)(956004)(38100700002)(2616005)(38350700002)(66556008)(1076003)(52116002)(4326008)(66476007)(8676002)(2906002)(83380400001)(186003)(8936002)(66946007)(107886003)(69590400013)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w17SR9dvRZJFW7jsARKHBX5pXfvEJWCTDSDE3xUQFBfmARS+BcsMjxJd0KPs?=
 =?us-ascii?Q?h83+yZd+YIydAb6h5cKB4McyDzE6LQtCKZkbMKkj4Jq+H6JjtU021LYOoriY?=
 =?us-ascii?Q?AhYcunMUA4S8Hwreg+MyP1TPRbXjRQdMOUX+0MIAa2q80bYQzFxMGNMNUoKh?=
 =?us-ascii?Q?BhceDkrWNWMx18iRhZThEUgwxfDZEUooLSqlgV1EqvPY83+qhxH6PYYgKW/P?=
 =?us-ascii?Q?XI9RV+zo/p3mZCXPiwiwmpBYeFZ47I5yBVNj0ai6KVsyqsio1M/zk+6r4riu?=
 =?us-ascii?Q?JOWlE3v/HMe0qaZWKS6OKPP+bK4CnaQaqic2Fz9SIhCL+BMbSdWmn2cb+Oy3?=
 =?us-ascii?Q?lWWrGN67DFeNsY/qNsgGthLhfg4b1O/+JCPsF1Eve52ckipYCAMNOWy14NSk?=
 =?us-ascii?Q?9PStKAIn1OrI/p/17TPW0vZW55UxuLgqh+CfxYsAMH35LKEBUi5IQdE4le4R?=
 =?us-ascii?Q?WMXi4TBuy66K/8s7OWKx/ZAb1XeQ1w3TJnX6bRWxGz6bBltK4CSPYt31rDBn?=
 =?us-ascii?Q?Ntoc5MxSxgf1tOY5QO40lzotScm8JvFY2hCEiuuXnYefCvwAwnN6CF7tPCAn?=
 =?us-ascii?Q?pQhQNtJaNBYQuxYLQM1ogZUW+aG1eHJesapEbfDQsqgRAhU9HM4I+x9/Lho5?=
 =?us-ascii?Q?F7eEfc0FqIEJuf5a3+MW2XNTwH3gJQjIom3eus1+sNljZtBqPM5MTrL94DcG?=
 =?us-ascii?Q?2ip8mQhmZYhWTB2HeN72vRcsb0lk3t6Q8vxt5Hd50XZAqjGBbvk4uKvpl6Vu?=
 =?us-ascii?Q?KkHIzGywj1lXEv6GedY19kI58Tm3PJYwnPEBbQ6nELpWFzZT7Icy/7tJnXOI?=
 =?us-ascii?Q?9rvZX+7YRyowo6FclV2Ba0QDiJd3sINKhJtHwwRrGjxl8GxNLGospLdANC+M?=
 =?us-ascii?Q?tdYbq9xd2oU14Y/taNLe5AzL8SSW6isGB7/RwN8UKsWwTMGDpnPc8qmL+GT2?=
 =?us-ascii?Q?hvfKJ0n74lmbL0AN3tRNP5fy1ustMXas9Dcpu010duVJip47ypbOU6N1Vra7?=
 =?us-ascii?Q?P9zWiKSayXYmG90Vl9ie7DFxb0lWwWla9VpJoNDGSnG5hTUOOUNltBcuqHX2?=
 =?us-ascii?Q?HWXrYMG39mROfxkANzG+K/pCrRNHuPcSBIVM16NLULxrJ5YidX+TisOT6/YV?=
 =?us-ascii?Q?0anFIp8c+AJ4n2esKFk+bEfgkfmIhMRShq6SmiDvbSxmVq5O3ZbjXpQz7mAx?=
 =?us-ascii?Q?ZVx77+aQrQThO8eQE5IfXKPgddcUdK1ByGhKmWeBS9XXVMppfnqpwbjGRPhf?=
 =?us-ascii?Q?6kGkUcFk+xVJHkpedFHDsc3HIQPo72f5cpdzqrNnuvXQUkW2QmyVSTAA7his?=
 =?us-ascii?Q?SK+Aqn1yup3T+T2neAKrl4ch?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5db839-24cf-4548-4d68-08d903f2dcb2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 11:53:07.2515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZGyxJPq1RxH6UJ/m/CT0+OmY9XjASJSdVEbbnQA8w2+xx0/iRm724T+EyG0BuVT5rn/mFd5utUlAs6DnIDISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4458
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
Cc: zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

__func__ has been printed in the macro definition of erofs_err.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 4 ++--
 lib/xattr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 40189fe..b964b98 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -956,8 +956,8 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
-		erofs_err("%s, failed to opendir at %s: %s",
-			  __func__, dir->i_srcpath, erofs_strerror(errno));
+		erofs_err("failed to opendir at %s: %s",
+			  dir->i_srcpath, erofs_strerror(errno));
 		return ERR_PTR(-errno);
 	}
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 8b7bcb1..a7677b9 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -446,8 +446,8 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 
 	_dir = opendir(path);
 	if (!_dir) {
-		erofs_err("%s, failed to opendir at %s: %s",
-			  __func__, path, erofs_strerror(errno));
+		erofs_err("failed to opendir at %s: %s",
+			  path, erofs_strerror(errno));
 		return -errno;
 	}
 
-- 
2.25.1

