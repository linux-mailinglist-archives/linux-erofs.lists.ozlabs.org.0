Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5209588E98
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 16:23:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyYxh6vZ7z305v
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 00:23:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1659536617;
	bh=zBZC4gFzzMSw1vYPwVU4ulPnywQBod2Wr4ryQYe8OE4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DUXRqnwwVEZJpF2zdjiRJhSmKr5jQuBScQUxbO8aoRTg7MPFR+i5cy8S3JbJU+fRI
	 OfCcN7pH4DJlGFUF7+0HH0mpwSqeFYzVbmkt40/qySZnwNyNV+CM062qQXLyaufdNf
	 vhoopyvLl1YsnafHrNHLbzVbKifCpcUbwC+RnoBUIpJ41+74D/GEGya6tNOEaGyAMr
	 iQRh5gceMzQOrBc59M8/0cP4HEVsAQUg4vPQRoJpKQGboDSF1t6Q8nJzeiSxJEZu05
	 UgyQyASt9MRtOyjsw98pjhz2f2uYqGsMW19EJ8BWxZHKislW6rhBBffvgMhVbxxfWn
	 KbOo6gvYSJoNg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=apc01-sg2-obe.outbound.protection.outlook.com (client-ip=40.107.215.64; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=kipGTo9O;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyYxZ1h8Vz2yp5
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 00:23:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSyljLGQl2QwlA5qdr+rXnU+7UzdLBCV1NKNsqfS+fV9Deo5GPJc0xaEFK80ORExUwnn42R7b6Y7d1kSG9Vd1lgDN22fMO6rBuRrpDWZWvnJ24W4Enb2Dyoe4B+0DTBI26LdfsGNRpeq3O4L3zghiR9S7K2beLYEgvFrgLj8JFaASuRSNrEiKOtBYeGkHINv481RpImja/RzmcABCFHkEz0RuXos0fjAX3OMoDAqkJgLaco0i+uLu84D3j/dR3QBFB+bD/+ziZtrqw/WvGprimz1gKm/iHnN2abJpQfh1dc8A7TKjMcJ/S2oySIi+uhM3lcTnzFvT6AoxmI+JWnQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBZC4gFzzMSw1vYPwVU4ulPnywQBod2Wr4ryQYe8OE4=;
 b=ZcuLGIglDI5jQ+jTiEfRlkmAYRb9SGufsqBZmb4DPaeWbEUbylZR97voMBz5atR5TEEO1iEgt6fMUrYb3i5CcSPrKcKdzzS2TxpGpNPwTyTcGjyKcmtlqBrd3tJ2PflNxG+h/7/UoQD9gJw/o0debpHutz99VJ3ayRjcdIes99v8lKHuBc2/6YT3+v4CsV21NpABqnt+PC5PEoXLVGIRvy+3LFPAO1BnJ9SwWxXx5UjiW1g/9A7LxolxmWPSBOPD9CEaAATyvhzuZ7BfR+gLkqOksIR+T99IfxDY4evQuDhPwEwyqBcofqCeHSBOjNJCBfHwk0JoF358FclhXGcR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 TY2PR02MB4493.apcprd02.prod.outlook.com (2603:1096:404:800d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 14:23:09 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 14:23:09 +0000
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	linux-erofs@lists.ozlabs.org,
	chao@kernel.org
Subject: [RFC PATCH 1/3] erofs-utils: fuse: set d_type for readdir
Date: Wed,  3 Aug 2022 22:22:21 +0800
Message-Id: <20220803142223.3962974-2-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803142223.3962974-1-shengyong@oppo.com>
References: <20220803142223.3962974-1-shengyong@oppo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94866a5a-2525-4377-7889-08da755bb099
X-MS-TrafficTypeDiagnostic: TY2PR02MB4493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	IDdB0AZf8nT/Ta+9FEq9Vsy2h0bvR2Vh85etHpVL8KgcWXmCK3tfxhkYR9ynIkwzq0pg/IaroAxrpPx+Qq03pMjsRGabRlqGvE5rS9oYdfY/pBD/iUpUrh66Z/FAOfQRs3KzLV04owfa9faK3j1qlmijWg8GJkZ65mRlVxtmsuE9yii0HMJfLZsNgfOBU/ZOL+OHvOH3jx67BzeRtRqFE0lv0vDK4omRR2izxikmdwz7JxI2ezocvucY1M49xsfIjowyUU1+o03Jgb79nMAmrxtKRrgLcNgR9PmRbYJckWZvSjzT2EQHrnMArUNLFyUoYaJvIJdVTk1fqoGnEiAjqdD1oIf26iSNahR22j1dt3jXmdTMKXRVnrsiWnAqw5PzZNroPocpr/uMgJmsu1rkFNAFfBmvCOPKqv6cNhHGnfdoLR8AgztwEYZ7xdc0QHYX7Bv0oMmNlpliJgJEk49P14T3hW9hNYscYQqOalkm9Ganizbh5Oxkf5xul9sgXthuvxbNI21up93cZ0eGb4y1USSASAwQhgn16iD09esGn3lEttl5mNEdTazROzUYsxvA/Kcxl4sErouZ+11j/eLKG1X9+WIQ2bEXV2heeqHFZikDp7ocai5Ou4PF2aJtZfgUoHvceSovJwvvzQ7YJKkq5Ab7bU7oGT/ov+nGuR51MyPPairpVGZsPFcwHcy0n2YhFn7fGPap4lbKUwuAue3DwEdPK+Rpx3eJqtM9A551HF20bF7/QvajJv+b5ItPENrE/IFphyX/jJWvilV2q6PuDzmtMJ3/ffdWtr6B0UBTT7M=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(8676002)(186003)(66946007)(4326008)(66556008)(6512007)(1076003)(2616005)(86362001)(107886003)(6666004)(66476007)(316002)(41300700001)(6506007)(26005)(6486002)(52116002)(478600001)(36756003)(2906002)(38350700002)(83380400001)(5660300002)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?WCXjdJodovq/CGn1ZYZCGi9Uq90MV1r1LIuZmCtW++9e4Iv/0cufZ6+w9QGF?=
 =?us-ascii?Q?Ay1rRwdZcpjI6tdHTBvuWp9fP/+RXMINqMxd2c+0xrIlRFx7mIvIkY8lRnt9?=
 =?us-ascii?Q?9JrlbHZuaS/1EVplz85nSFRTvmIJ/wzT4ET1kOoZW6Eb8GQptAPg6rYG4oJL?=
 =?us-ascii?Q?NCvjQok0qkboSMO7FGoHo/anaAM+UiP3flFpKdRFXTHWEajC6gGO7LgrERnT?=
 =?us-ascii?Q?z8XO9L24c31gnhteWOfOIP3ZLv8sopOTZQ/2GmNUGHzNjHBWSQrFvaZJHI9+?=
 =?us-ascii?Q?XMP7AOa9U1U/oiz/VOldXHFoqs4z2aSN695GWJ1UJ5CmaYtj8BPtSpJEHovi?=
 =?us-ascii?Q?7AJHK5Z4enof8IWDSR6rICIoYUT9z3XyzQpvd+8xnSwq6OHRehyxaDQnxtdf?=
 =?us-ascii?Q?R0n22Pyxbk8aURB6qpN17MoPITlpGU1Clg/GRWKFLmwNXSr1BCaV845agmn8?=
 =?us-ascii?Q?2JduVCiX6vDk3e7mfF+C78Dmtc5UXyxBhmjAJcz10cz9ZiULi3AYquUET/hs?=
 =?us-ascii?Q?kIW/kbJKWvIyRFKjL6y0kelFdEZMd1afs7Ke3BiIQuuVNxNNZxBFvL3m2zSF?=
 =?us-ascii?Q?/SQHhkJ7r9rfLpA56PeHlpgFPBeMkdFBpAxMW1DwzZnvWeXS/RCJdNdRhErn?=
 =?us-ascii?Q?PwXidsmCQpYxOJ6BUuTn1qDtrp2OCMsOFvlBlgs1yGLGf9fWh9uwvii9QmdH?=
 =?us-ascii?Q?v313CwSo3s3B1X55oJVJgozCMTjvz6cFsOpQCdeKK2/gCei9OGMJLvPzsXoy?=
 =?us-ascii?Q?6DKlURENVuj6mR4q0usRkBQNV4Lf3Z9g5P9W7nEbIS4tbnbNc1iwFLWsfb5C?=
 =?us-ascii?Q?sdeCJFRovdCF1sQM4ma26uqw3BkucClqSmVTKp0hKiBFZZow6LHCpHeKmCfo?=
 =?us-ascii?Q?X2THtc4pnxET4qQy+oVbBfR8PMte3uAl6umZIFDxzuokXcu9Z24DseGdpU3a?=
 =?us-ascii?Q?clrozaa7KNoB9PHoe0qD5ws9ux/B675AbwRxZPtGH7d5OMJjzCliOnQsJ7WN?=
 =?us-ascii?Q?/LLKhSj4c4x88eeBbmelGNlZ7eErv/uOpIH4hW+vM7RNPwwEDkE571lepQyh?=
 =?us-ascii?Q?g9pCkVRO5J03LDcTFjuxTSnWK03uOQGyOYN/IMoCBOEsVh8Yfpo3vQ8LBp60?=
 =?us-ascii?Q?rPcffys4Kk9VHN89xbbh5K0AkqR1cn0REoImoioe8f0XmSN6mGHNHBwfSSow?=
 =?us-ascii?Q?EcfglHcM++RlWEceKMJJ0CYv+iQgLxsCJcLoOkBec6pDcdf9ALDRQs+XecYK?=
 =?us-ascii?Q?zF2BS0bbSbLtAVBlcA58H68VjOccjBRlU9jstDNO7B9yhkn8Wy58CTtoqagO?=
 =?us-ascii?Q?iHD6GYmR4SKVg+GdBD6DyAJssbHA9n8WkVrdXf2xqoKcqylS94f/51SqNYjq?=
 =?us-ascii?Q?Dp8FjVxOiCGUfeMR57MLo4MHwBTWmpHCDJLts0R4gTf6LtTwByhgCjyQaVJ8?=
 =?us-ascii?Q?yXP79/OZMPU+xMyfhm7O+eYUE1hXS6SO03c03sik4DToc4iVEP+YX8kATAv4?=
 =?us-ascii?Q?KS4ktRvVXMGrQyPh5pC8zmS8K/WY7czK4qwU4RrE7kYqBoCoUdZSUd4X0DS/?=
 =?us-ascii?Q?MJNBYHwz3/Y01yCKWSke0M8vI3Uhqjakpn6JaMS7?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94866a5a-2525-4377-7889-08da755bb099
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 14:23:09.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o17ringZeHH37CIN7RHhYLb4KalVg4xHLBRjDcilk0xxYqBWeRaR04llhey70vIHwEHTGIZROnZdA8Z4TCPq7w==
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

Set inode mode for libfuse readdir filler so that readdir count get
correct d_type.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fuse/main.c           |  5 ++++-
 include/erofs/inode.h |  1 +
 lib/inode.c           | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fuse/main.c b/fuse/main.c
index 95f939e..345bcb5 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -13,6 +13,7 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/dir.h"
+#include "erofs/inode.h"

 struct erofsfuse_dir_context {
        struct erofs_dir_context ctx;
@@ -24,11 +25,13 @@ struct erofsfuse_dir_context {
 static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
 {
        struct erofsfuse_dir_context *fusectx =3D (void *)ctx;
+       struct stat st =3D {0};
        char dname[EROFS_NAME_LEN + 1];

        strncpy(dname, ctx->dname, ctx->de_namelen);
        dname[ctx->de_namelen] =3D '\0';
-       fusectx->filler(fusectx->buf, dname, NULL, 0);
+       st.st_mode =3D erofs_ftype_to_dtype(ctx->de_ftype) << 12;
+       fusectx->filler(fusectx->buf, dname, &st, 0);
        return 0;
 }

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 79b39b0..79b8d89 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -16,6 +16,7 @@ extern "C"
 #include "erofs/internal.h"

 unsigned char erofs_mode_to_ftype(umode_t mode);
+unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
diff --git a/lib/inode.c b/lib/inode.c
index f192510..ce75014 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -43,6 +43,25 @@ unsigned char erofs_mode_to_ftype(umode_t mode)
        return erofs_ftype_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }

+static const unsigned char erofs_dtype_by_ftype[EROFS_FT_MAX] =3D {
+       [EROFS_FT_UNKNOWN]      =3D DT_UNKNOWN,
+       [EROFS_FT_REG_FILE]     =3D DT_REG,
+       [EROFS_FT_DIR]          =3D DT_DIR,
+       [EROFS_FT_CHRDEV]       =3D DT_CHR,
+       [EROFS_FT_BLKDEV]       =3D DT_BLK,
+       [EROFS_FT_FIFO]         =3D DT_FIFO,
+       [EROFS_FT_SOCK]         =3D DT_SOCK,
+       [EROFS_FT_SYMLINK]      =3D DT_LNK
+};
+
+unsigned char erofs_ftype_to_dtype(unsigned int filetype)
+{
+       if (filetype >=3D EROFS_FT_MAX)
+               return DT_UNKNOWN;
+
+       return erofs_dtype_by_ftype[filetype];
+}
+
 #define NR_INODE_HASHTABLE     16384

 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
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
