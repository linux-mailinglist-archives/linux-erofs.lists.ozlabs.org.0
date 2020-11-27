Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71B2C638D
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:04:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjBbM5BkFzDrfH
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:04:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.80;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=Dw4pD+sw; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310080.outbound.protection.outlook.com [40.107.131.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjBb32VHQzDrdJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:04:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WghTC120l1wJ8Tbjtt2VEIkroB5aqzQpMRwdGqz3qYwlNJKh9IbQ8P6RQoKqxjuRblOcvpmPoZL8HXvvoUIVflGVuBpTyrv9N2rnvN/bNScvym5D63PGDbyRGor6eFgevOWZt6Tb//aOJsm0nUpHEDkcWi5I4l7tm/3gR4WlbD1JtoDdi02LDbsadWho3E+8vj1dATW4TO8GJJVqf8+I3ATCND7wy7fhOX2pPAOTTKbJsmDeVf6Hj54uwTrcH01h0F1adbzXu7pYu6QxnuF2ZnrYzgFpSvCPzql20z2FkYDo+bWRhdbgvYmg8HTDCHQUr2/GD4i7t0TECYqgC5XoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9dN+l8JCQjK6Y8lDH9yuyJwL2meceJln3HlASXHdKI=;
 b=M8b70DPtSHyRXIc29ipe22lTixh2Au7CQ5GU0Eb0imD2o73KnEMSm7NtZk0Q6x2nAkuqD1GKStmS7GkOkkkVIkeWaepzGvIAzIjtWJ4F8vyBtpHFeCdSccJmePon+ffm2vsGG6ojgXxBVETp4RgE56G7qmnavew0msPBZupGP0ilTP4ciJDUwn9hOgfMPOHKR5tT796qGeLnrSSzdrmcWhBuN21ZjZrYCzyMw9cZdmWsQMwKuJAOxhTfKPPIg8n4aNJpy1b6iDBlGnlIQYQY/yijAsP8Oh3Cu7gYR7/BpS23SlCfCrXe2YaA3CXEdRjOfgGSCV1klw73vu8XGbTwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9dN+l8JCQjK6Y8lDH9yuyJwL2meceJln3HlASXHdKI=;
 b=Dw4pD+swXp4oyAJc4Y6BNVz5gHtZB1zqNzkv6/tuq1y3RylLo18ihor3AHMuNoGC86bqihkwDwcpPFtR4F1coOfI4s/mQ1IV6X8kPL2VZudLzNRCDDF/CgXOFAA4U1Uzjdk3yc13Hmilt4OI/T6t2T8s5ledMlWEdMLiHnhh6NE=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2093.apcprd02.prod.outlook.com (2603:1096:3:b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.21; Fri, 27 Nov 2020 11:04:06 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 11:04:06 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/1] erofs-utils: fix use after free in closedir
Date: Fri, 27 Nov 2020 19:03:17 +0800
Message-Id: <20201127110317.34030-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HKAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:203:c8::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HKAPR03CA0018.apcprd03.prod.outlook.com (2603:1096:203:c8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.8 via Frontend Transport; Fri, 27 Nov 2020 11:04:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f732535c-4cc5-4732-5aca-08d892c427ee
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB2093CAC0FF2838AB316EC45BC3F80@SG2PR0201MB2093.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdkigU7IGVrG3Bh+Rd/fDjIjIvaqzToRdf/TBQLZTduxMqi0nWK56nwx0fc45BXhxJbAljkKNBv6kdMys1C/4jcg5HvvqlH4M90KCIoIbF3i3Y77OVEe2B850J+GzYtB9R9YtT4Ip5ngPsBSuNFCR2H809YnBPimyVB84IhzwEvzPxElcDGQ1JY//sS5jgCTI2OJV20Pl2T3HuS0Ul2Y7tCIHztOrARpMPzUPxGQ/bILgFcD1leZgy49Rmy7DDuhOhxS4VLoQJ2gmhjWANA+9xiHvrA33lp9ipgqpBly0jY++ueH/uNoxLGyQakxPweQ9nEb78LSRq1lLUPbqPd211eFyXRa/NdgpJ+7+Msilm2BGETuqU2wijVdDja4+jfEkRu88MHCiTV3Hok2siueR8sQEVSr94D+Ih9il6AvI+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(86362001)(52116002)(2616005)(6512007)(478600001)(8676002)(4326008)(6506007)(5660300002)(83380400001)(2906002)(956004)(1076003)(4744005)(8936002)(107886003)(6916009)(16526019)(6666004)(66946007)(316002)(6486002)(186003)(66556008)(66476007)(26005)(69590400008)(36756003)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h5tYzz+Bqk5rz9V8N9fl+d8nWvGibhpMjkoME3gOjbxKPk8WsEnPoMeCrxZR?=
 =?us-ascii?Q?FXACM6zO+SIkJEQJHbSyNWesasnPX2hIC5Xp4tNzsaX25cF/2T7xLn8ZB9SO?=
 =?us-ascii?Q?LJyXqSrnO9dDZiaGXyU7SJv3UpjScoEk54WlBcgb1cRXFRmnLdf3ukIgmQVA?=
 =?us-ascii?Q?crxn0lZvkhCjzklh9zPuhYvFiOSeBuToCMtFVz6UlbZ0hl+WtHiYUmIwNZyW?=
 =?us-ascii?Q?YwLX76LjsrnOWzLyGTNsrDu9khrHHxmV2t1ZMWFbTVN3RiHhwR0Vu9zgF5BF?=
 =?us-ascii?Q?g5m15uoozrpFSkBEslyWsuSR9O6aoFsN6warCNlNTNBRGfk8TugLYgy7hSvL?=
 =?us-ascii?Q?lBRGEvqPO4P7INWD+WoX1j4Eltwx35JYco63nhbokiVEgazDHUH0q2gBZkXZ?=
 =?us-ascii?Q?t2PBjH4TpoO/25xT0ePOsPQVGtOxxqbMWYd8SHnbvl6+VDAV9+mT+WRDKXNG?=
 =?us-ascii?Q?R8zvyKuSaQw5ceHCKdkAj4GnIPGNb4eMkiFxdQbD7pbMPru8jWdHI9yU4k8u?=
 =?us-ascii?Q?SJRPOIeT/ptgHUIEEz/k4+zx1mdWAwmGTMtuGXTKcdOq3cjrKWXBpCc4N2Tw?=
 =?us-ascii?Q?O1fZEB6q/VzsOXXhnuT7Eq6MfGuO8y3DLDtfXysp0Fol0rIXgpeiW4JYHabb?=
 =?us-ascii?Q?pOZJpElUVXuS2oNmbEjaa1SHlwCPDJe+xtpjjKkwUlOuZ13542IX2i2LnTnx?=
 =?us-ascii?Q?W41+bCHBtxwfYuY6Vo+BQF0iB9+mlRrFm5/lJFkYfdnHyk8pg7M7bFhkW7X6?=
 =?us-ascii?Q?QxG/mGatzZ8moPSONQ4UsSAPu9iOBzHfS7EwIxYusXtmBdw4ZHEzSpm/Ew/Z?=
 =?us-ascii?Q?+rbnEHJvQAR1fQCfSn/6SkjLwoct15zdJelfL74y0/WLFahzMfuK9AKhUbOb?=
 =?us-ascii?Q?U+uEluefxRbr+B5LRH5G6jx1m//EYbEYKr3k77ojpMXr294+81uRwg8SDsPx?=
 =?us-ascii?Q?rriGVazuI0F2OMNuN7WVU5wX/K4bZSBSQM9ENyDWJjgvV4v615GEQDQjuwza?=
 =?us-ascii?Q?0ZAk?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f732535c-4cc5-4732-5aca-08d892c427ee
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 11:04:05.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY8Bs6eaSh4GwOPDIVpOgVosU9sD4xKzr26n5SGxVVUhgZsSTIMDOgK8umaUkkRmREb972lDXBHMcvB1FG2FFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2093
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
Cc: liufeibao@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

No need to closedir _dir again since it has been released.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 lib/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index eb2e0f2..2397bc7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -958,11 +958,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	ret = erofs_prepare_dir_file(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	ret = erofs_prepare_inode_buffer(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
@@ -1003,6 +1003,7 @@ fail:
 
 err_closedir:
 	closedir(_dir);
+err:
 	return ERR_PTR(ret);
 }
 
-- 
2.25.1

