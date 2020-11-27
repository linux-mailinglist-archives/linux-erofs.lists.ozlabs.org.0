Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABE2C62E0
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 11:16:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cj9XM0D5vzDrdN
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 21:16:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.71;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=INypMGYU; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320071.outbound.protection.outlook.com [40.107.132.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cj9XG2CgnzDrcH
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 21:16:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bh/B6ZxoNpN+vKNac18ubyBjSz9hF2zxDDFzSwViThqi69AfMJLFI5iYwbTsJXaWZ/mojkpERpF2WywM+HcRedA2L8Q7n0M5nQ4v18GixLVkAcKshDV4RfBnCaoNzO0RlU1J+TWZf3cr6P7/mzGGt/IkTHk1/E2oNdUqax5Gpm/XL2lLrhs4AxDNU73aUHYMQEYjW2KC9HEHHSe03YjHOy82AwtfKL6uebjqjW3rU72i9btjdYY79MpygyJhYq5gyspHtyFE5HvgTjbQZY3y7flBYGvqbeiWQwiCzzLzowS8u0DUHAUU3HWR2Mq7B5rf6r/tfhgu8P4i4JDUDDp1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZYqsOgkvmFIIbA4LVPpbWw5dVgpyywepD9M8ugnYv8=;
 b=EZq1qHD9lFVojWQq8HkF7GPG5+vnl0NEWgawv/jnXVtH+7oodhFhlTtt5yN4rXE6434yIveFym19ZMKFWSRDie7+DdVFXpiY5EPEt6v0ZSxllkyV933IrrVtCnJRpw3QF/OPHGXG5HJepZYFHV20dQZGpXirlotFTzApzHL/m1US9uuYL+ULJzI8MqDVs8We5r7wWVsO66CwoikwMeT5TV5aygYgxASlcLD3b0x2+8oVw8FXpQ82UHU3/tLv08AOO2ZotbPg3KJ5mPeqezAaZZ0mN3MmlNm0rLpIOcbuNYdf2WLz167mmxq8B9zSNcPYmdNtSzduqK3Fo0rNWC0fiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZYqsOgkvmFIIbA4LVPpbWw5dVgpyywepD9M8ugnYv8=;
 b=INypMGYUJ8hx8HF1Iqc45bn70er1Yd7m1p9AZkYrcZ94FKVUkEQezXgK/L0TnUA7Fn9/Tng03fbjVoqH1NPswdF1SE4Y4OvFPVzBJZl3b2qLI/GbGJfRrBPFKJyyXmxlImXI3IU7qX7CrxAJwrGB2amfR9CtPp0yyqaUfHI0bYc=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3369.apcprd02.prod.outlook.com (2603:1096:4:43::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Fri, 27 Nov 2020 10:16:33 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 10:16:33 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use hash_for_each_safe in erofs_cleanxattrs
Date: Fri, 27 Nov 2020 18:16:13 +0800
Message-Id: <20201127101613.33435-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.0 via Frontend Transport; Fri, 27 Nov 2020 10:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 996bc9d6-9fa4-4c1f-3314-08d892bd8381
X-MS-TrafficTypeDiagnostic: SG2PR02MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB33699F6FEEAD54A7ED09F2E8C3F80@SG2PR02MB3369.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZhFdB6cJOSPxpIsj7IsrGxRySWKPgqbFaN2spoulA2AXIglOxd3mNS8HBy4eu6qAuMa3hD1jYCxzzzmc3BO15TRDw+B9HgwKtFXDzf9a8Cb0hP2RfFiyOtOrxQa2HlHYM1KTS582t8XS+2rxBpCNTBnMAMCppzhU4pkeOFCjMOyQcSYqo4r7Duz7AmPq6U2kGrq8SywM0a9gbJ3JrFGis0E9rH6IajdwfeWFCfwad9rHDtLrcWBDtiK5OkZgE1UUVqoxTS+1F03Uwjd5X7zzhc2pG4OGAq33l7HaxRTi3BWjMwjXHGmN0lg6zznwre+j6U2lTQ5BHb8HKLDLxkL+nBiFGpvZtCm4XRO6/BEH99JSk37VUAqvVKPmkeLtGFx38tPpQjufP/ngpw+aI3Hag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(6666004)(52116002)(107886003)(2906002)(26005)(16526019)(86362001)(36756003)(6486002)(4744005)(66946007)(6916009)(5660300002)(186003)(316002)(478600001)(8676002)(69590400008)(66476007)(66556008)(6512007)(83380400001)(4326008)(1076003)(6506007)(8936002)(2616005)(956004)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oSZdW5ixMz/20kQ+lZeCyrxUL7DVz2mS70owkeCX2RsCkiMhtiYuS2N2/NNo?=
 =?us-ascii?Q?j54oj9tuBeynyfMY0Z+9quGRJdblVFB4RvrfELdeqn4WEPVqLOacKNfohLER?=
 =?us-ascii?Q?Tb+qbkoFAzQtvhPbMTeANiUEuXC/83Brb9uqoWBRpw6Pz1QDr6nLYB8uISwk?=
 =?us-ascii?Q?GMPz+rc0CNBleKunSrrlzEufrz61VMc/1awu0r2dZZICSCcPZWHxtjY2gc38?=
 =?us-ascii?Q?78gV3L6hgTT1DZyn1nYDfASKjUE4engMCz0GH/Y2otv3bg5jjO5sYr/ngh43?=
 =?us-ascii?Q?Ga0BAi1qW+YgepV05J4J1EePBkWyHVKVlkQZWulXdS/1U6EwJD0DDZZF/GK/?=
 =?us-ascii?Q?8iq1tRnFTrt6UoJIOsDCFOk9tPQRdwAnyDRe7jckSPqTmZ6BtIICx/WXSQRB?=
 =?us-ascii?Q?riipQRsEx6naBIl4s7kXM1rUi1JQrttmAJ5xqmCUuTe2hgKYeUyIC5c5qDoS?=
 =?us-ascii?Q?ky1pPQJqtPxXNGQMviAjqt7lCXzuJVP26Lnvr1LZm2zEDvOkeQdA55RzdoBa?=
 =?us-ascii?Q?YyH6E5nuCE86qNFiqZcF9ntW20gtK7pML6boq5oK6Ke17ukWdF3jXHuiMhCf?=
 =?us-ascii?Q?Zsl5UL0U0LBku+JNNkxJjyStZD55LIPdmUsobP1lwDU5ENqwwLI/f+Sj8VAH?=
 =?us-ascii?Q?w7F0dnwVP3VQ3Aka9sAXWmQspG9cEJuKd67HeixhUDkYG9dqXhJBXcX9CGRq?=
 =?us-ascii?Q?L4qKLNiHORT64TyecFurhc0DR/zEnGCYY7IaYH7Y+0SBOL6Ww+FD/FfGqNis?=
 =?us-ascii?Q?fL4RdvfF4u2mVSjZppiJADxZjlS5Z6ouPNYI3k/PeP9qUzDBbP5mrUa4+JVU?=
 =?us-ascii?Q?8coYbEdZHvt699GZT7n550l4nPzjHJbZjKAzdOKREKaTKuwxaGgmTB8VeqLK?=
 =?us-ascii?Q?rlL6zsUSCzzDv+w+LfcwHK4e9CEy98DBaiadE5iMwDv+ALbMdb3bLLlkD2X3?=
 =?us-ascii?Q?1EaWF26Sf3dIp1Y9Y6ae+V06PjLgsJFq8CNRAsOOqesl7IhEjvuVpCBJs1yj?=
 =?us-ascii?Q?IkAa?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996bc9d6-9fa4-4c1f-3314-08d892bd8381
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 10:16:33.0039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXptuuQz0/PpGiYR8zTiQPJtlZO9W45/w1ft0WXbZj5IUyPG8NE/IKm5WLH6E4ZvnDFtZVmpP1Hk0PFO94p+4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3369
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

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 lib/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index f9ec78c..2596601 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -506,8 +506,9 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 {
 	unsigned int i;
 	struct xattr_item *item;
+	struct hlist_node *tmp;
 
-	hash_for_each(ea_hashtable, i, item, node) {
+	hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
 		if (sharedxattrs && item->shared_xattr_id >= 0)
 			continue;
 
-- 
2.25.1

