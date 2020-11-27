Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B82C60E1
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 09:34:50 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cj7Gb0JPMzDrfy
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 19:34:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.51;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=cZCltPWC; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300051.outbound.protection.outlook.com [40.107.130.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cj7GR5S50zDrfP
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 19:34:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KslzVMtD0SNhPPcM5NrhWKUUPXGG2AtoCRpeHOH0c6Azs5DvV5AuagDXoYwNhaSdkk0WAP6HYcc/IifZnGDIfITMa8zTg9ZYzBAs3G2NNA/ZooRqZlamr4/FvKEum83fcH5QaMBM6ocKFQHq9JBSYK1fYX9YjDg90F4EVP9qLmqto0+hXU+M9GcYoeFG+Zo1wOY2JYQY2xmmsIBRpqNBzDjt5sru5S/EZEyEDVaPP1JyrYkCTK2m/N5niIyvtvVz9lmSpFJOkpfuAEcdfYUQKbr7Fi9NFkxFGFhEEpAC1HyZ+lr8cK01Ji8BtzhMOAJgPc4wzMsasQ40VbVwNGIjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2K0OvdLuMJCbZLOwg+QE1CsFEknh+hOyAElb9iHeDA=;
 b=QSSwm9mF8wj9HCFvKAbKaj57Zx2qJFaPh4C7W1QwAN+p8Pdcn/HLRyhbP8XyuhdAfTlDb846miNMtQe/e+YY8+F2s5wQJjjzFK/rp9f5bHY+yj9yq7mJZV8Y2gqBj9mcA5V2cwWEfNATQMYTZ5kXP9cKQ9+my+O4JAeLhDnsdbzgjavHRScECKBVWYbVJcufWqN2Vuj9+h1XUcgwLiRXtS6ZDzC+pg0ayDYXF+8nujf+tkbihL7XYEO2YtV25xvoGLYO+/9/+vtxJX+fSkNdleVHTK8dAOsbZesiYS9ishvw0Gfuj5H7mHvs/6QiaxggpXDkwOAZYFRJ0dyhfBcZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2K0OvdLuMJCbZLOwg+QE1CsFEknh+hOyAElb9iHeDA=;
 b=cZCltPWCBTfMXJOUau7A5xXuJwu4vsh5QBYTH2xbSZABi+uwu5I5hrxXGXfw3QUNccVv0W1J7ta/GEZmHPe8xPTbT3mHa7t8yE0i8S/NcUb+s9E8912qB9CaFuB/gcsr/oqT1zy2Pih0bShOmpE7RYt7PtxaiDwAgLfSMvccnnc=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2384.apcprd02.prod.outlook.com (2603:1096:3:1f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Fri, 27 Nov 2020 08:34:25 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 08:34:23 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix random data in shared xattrs
Date: Fri, 27 Nov 2020 16:33:34 +0800
Message-Id: <20201127083334.32738-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR03CA0101.apcprd03.prod.outlook.com (2603:1096:203:b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 08:34:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ead41e-2dfd-4e35-b706-08d892af3d94
X-MS-TrafficTypeDiagnostic: SG2PR02MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2384FF944C6CCCEEFB2E0BFBC3F80@SG2PR02MB2384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji4UomJfg7vrkryUlz1oYcS0qsq4YfCvkPHvqPKTDCHEJRkewrxOKPfo9RiajlMcmEYreT+wyr6xz5h0cb00pHbNycbbl4OfSZ03vtxpV+odvvkGCfrt8oY1xxg+ucLtom1dlQuB6JDdlOvskgzx3X2N1lt1YELhf2+xYFYOvca6qer0Jk2dC1A2ViuTGCpQXaL8N37s74UxFQLT5cRFek6DcDjJRRMRmanoVSd83xJiYREPxaMrx0nbtwrTcXtOCW2h9pHA46xNUe77ffY2rHV5PsrlLfhjXez99q9QUiW+d+F2BJbtZf+edvVDjBrTo7BRCZVDaDMJhuom1ho3rOhiCMScgIeRs0Eyn9bNCrTvF86bVSUoPbe5r3SbOWDX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(8676002)(8936002)(107886003)(66476007)(66946007)(5660300002)(2906002)(36756003)(66556008)(86362001)(1076003)(83380400001)(16526019)(6666004)(6916009)(186003)(6512007)(6486002)(26005)(6506007)(4326008)(52116002)(316002)(478600001)(956004)(2616005)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ElK6/mNFRSRsj22ChU8fNnNKWEyh1kr9xEcE8OI1bVL9PvPnfk4ctpJGLcZ6?=
 =?us-ascii?Q?vUav/5H8DwMObDbjEXsoTay5mEsFUqatS+w9VUPcgaqEWSlH+u2gM1JiWP5l?=
 =?us-ascii?Q?v8K+/Dzlyeu4BZJiZDUbwsAHMhRu/itTaqR//zEK/8JF7JRBpvMSt1045zH0?=
 =?us-ascii?Q?vmD1cryaHjuW4nwJVXwkvnkF2ffE6pVODEyJaKvUlBsT2pXQAs4kDxk65wW2?=
 =?us-ascii?Q?98EL5HFJdoW5QblKnYReNvExExJzavYcnSiTFWOAsPRPbket86tkV51v2n76?=
 =?us-ascii?Q?YANyOxWpWupH8hxp9t/tsPh/5mRxCzdZXYkIQdhhxPvNGbmGX0wyvICs76p8?=
 =?us-ascii?Q?uOqwMbT/VWel+mMR32a7n5DE6F/qOQz3//uNZOpfatFEiLy0uidqc//UcmRl?=
 =?us-ascii?Q?6OLaRJUu4d5AWM6WCsvJn9BvtLsrfh/Jv9iE7728HrVdXjEwp4fLijYJrrWi?=
 =?us-ascii?Q?A5vw1zb9l0cAe0z9QednmJ48qVXmxTOINTF2cU0GZKtNp02xF49kpn/fyYrt?=
 =?us-ascii?Q?gLMRBSlah2MjhKkKdG7pMxvX+wTUE9+psnMm+1HTSPGPGxY+KpI6G7gD7oza?=
 =?us-ascii?Q?YuCJQJZpVIygQ+cLo3HCl2BbRIDgSGjZiZMRvNGD0kdVxSSH4jD48KQldB7A?=
 =?us-ascii?Q?o2qXzd8QJMRdALom3vhPlSfHLcI37dOaIw/E55u6LC9CZo7I38dxfe+AnkvR?=
 =?us-ascii?Q?TxdBRWW1ZsvbdYJn80+T7m93ftzkHZMTXnA5NbrRssO5rWOYvsR/avMstpMq?=
 =?us-ascii?Q?d5Yqh1GooKZuqcrXqNiqceaSsqWWnjm3NzjdwQ9re9/g9NiN7G1OaIs0GUcW?=
 =?us-ascii?Q?eSYTiEU0FDha29VQYbcicfgSNwbO1jknApRYd5HY/YPPuo5d/rZMUmP/XBYU?=
 =?us-ascii?Q?Z8GdVUUoWe5W68BA6JD0vYmK/Q1s3zR8GlfnqwIggx/xyVBu4Qqpt+BmFRP4?=
 =?us-ascii?Q?4yqpp5WvrVHasmiUB5EbomFn4gfg+WdSjqQaEGWgnG0=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ead41e-2dfd-4e35-b706-08d892af3d94
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 08:34:23.1818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUOTfTpv8C6kkP5s+Dy3ICOr6WkalQsRjX0NeUScftbSphs/VxE6m6QhsDzdME0uDBW/g/u91AhuDhUDHp3SBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2384
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There will be holes between xattr entry after EROFS_XATTR_ALIGN, so
we should clear shared xattrs buff to avoid random data.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 1ce3fb3..f9ec78c 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -547,7 +547,7 @@ int erofs_build_shared_xattrs_from_path(const char *pat=
h)
        if (!shared_xattrs_size)
                goto out;

-       buf =3D malloc(shared_xattrs_size);
+       buf =3D calloc(1, shared_xattrs_size);
        if (!buf)
                return -ENOMEM;

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
