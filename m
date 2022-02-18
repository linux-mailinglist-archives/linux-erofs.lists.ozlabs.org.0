Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A08754BB005
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 04:12:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K0Gvx0Vnwz3cDC
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 14:12:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645153949;
	bh=PItZjAsFGXbWKZ8Z+m54DhWINUtRsVL05qInHDgL3K0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=aySFf9mjWVP2bLzvEmXskolA4ygyJeT2LsbDBVt16bp9Y+X66ElyMAwRHrHFaEo5P
	 JtcHr5rW7DNc5lMqkPAXhG4aOtlNoDHwoGAT4EBs3FhhOI359fxSEi3X7wCGMB+EDB
	 LADCxhA6+WoEHIQrFwJn1ni5iHb2ngoFYMbiOKMdHNPfSDvMq0FRu/e7Nf2CrmBylb
	 wpT98suBb8VG5pmJKnBE9EqHyUoy+z/hTqCzj8aNzLxv6Xwt8J5wKvCvg1zVDseY8g
	 huRAfF2BQ6FDZ8cVQqCwZ3zFaICsGo1L53pu7YDd+syRTkv5LaoGU/g/CVHF76SMsx
	 DOmY9RMMXeclA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feae::623;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=EbpIIX1+; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K0Gvj5Kq0z3bWj
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Feb 2022 14:12:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TInmbndlTqxMLerDA3SJcfqNnIlxethuZn08lUFGtkHZiXDgnsS3DbCdl6cJb1UPL4vduGtKdELYl2SZYJtAn6x1smOJyhmCBs6P5o0/QfRRXIMUhKwcshCvK/PtU2MKWYdfXM9/q02hWwc65qHU18Rzok8mutWhImpu85pLEyUZgC9Wf7ys1JKgbteqbqhlRrkFV11Z7w0feBs9shxvbQSbO6EW9koNtfZbHtW0zieF/9MOt0EDkac3AOqqgh0tHeWWAsMKdoymCClu+ca57NQbSFKjlw4uC5G5KqGQmJAGyoz49F7ioLQp/TXZpD9svoZRfLF8raOT8DHXejwbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PItZjAsFGXbWKZ8Z+m54DhWINUtRsVL05qInHDgL3K0=;
 b=AfjltcDSfVeHCx2Xo7/qT1vPidD3R56oCUFcBw6ZKrCrl6XBnr/mD72ky74WAb7YMQtRUbcUONmG3km+Yoq0f3hAJaohr5cYtTSzUsmd4rGFosFNSgI/r3BjOKkRA4lXbZl7pfHxHV44uL019/u/6FbdZplGeZrgA2ZpbVIbygUF+1Sie5lfIU+BDwiA+PzN0whwfc3MBVd+sA+N5ZglMooqMQlD9xnDwgSmCmQjMaPzPwRqPwp0Soyzs+VY/gro3l2DSvoGGv/CBWr59VEowCL0BK8IIuBuobd0wpUzmOp4IcRGyDmzkjXwWdaBlCq2YJrGpECEbAnNkfj3w6T0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 PSAPR02MB4870.apcprd02.prod.outlook.com (2603:1096:301:90::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.18; Fri, 18 Feb 2022 03:11:50 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0%4]) with mapi id 15.20.4995.018; Fri, 18 Feb 2022
 03:11:50 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: check the return value of ftell
Date: Fri, 18 Feb 2022 11:11:35 +0800
Message-Id: <20220218031137.18716-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48d9b22-420f-4e53-60fa-08d9f28c6826
X-MS-TrafficTypeDiagnostic: PSAPR02MB4870:EE_
X-Microsoft-Antispam-PRVS: <PSAPR02MB48703E060721125D64362925C3379@PSAPR02MB4870.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrWXqICpkeLqlcI5MrW1fkG8MNptHsJncynazbjIgQVWK+BEa+Ro07FFfVNWEkzEbzUqdRw/JlnmWG4QSgJ9ZUgg7Wn/yyGGG5JgXfHnkpa2rZzyoVE0zUQ/J7vKLPwEZ7kqThuRl08094Ma6uas6DV0UYowY2BjugLadKx+/E/tDvNwdW9gQL4z1u01/bO9PY1AX87z+WX2WZ5x5tEocU9uVtpxZjm3wdxdLv2t8pb479Oh4kvNOMDYfmFUpyMSIJ5p2GnrzOu3khdJ/54uKWxOK8eJYllZSidI8IjsXD2D6BJI0fscKVIqVHXWOn+PnawgWW9d6s1OaKB5R9pdmulf9a/1a1+elNUI1mTDrCLe2X+pikpKKy042dTHSG/l5LTjXtaJLaikNgT64BVDIo1qXZLgT+Ira74mfULOmKzBTdx4VupNty1BgCz0WV3+n0qmKpfQqOOahX9Im/oOyYf0fRrnQtKlMumhX12ZzXYxub8pbNOeMHXrKJxp/E8CYBc5xGNlHwFzjmXjLJgib2dvCzp7QQr7023VvydUFXio1fczJw7Dv7mDSEDYV524wzpmaZmHIICX8ShVXkYUrIcEWUGkEhLBbi3piM4Bm0WNDUyRdok2vAffm72DDX4abWnkbTclToqA4tBy+hRJmYGtRs+Safv4tKm+X1OATcNuO/QxqxntRN0NWCQ5jsJpLHnnNUFkbNyBg25dBbNtiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66476007)(4744005)(52116002)(6506007)(6512007)(6916009)(6666004)(508600001)(6486002)(4326008)(8676002)(2616005)(66946007)(107886003)(26005)(186003)(316002)(1076003)(66556008)(86362001)(36756003)(2906002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmTg85Ub4m1keKPannGzxuLtC5utVdC6Hmj20i5NZ+HuSXA1beTG+H70PfQr?=
 =?us-ascii?Q?w9R2Bg+RXck3DWbQQsKl1ORMvIuSVM6o2vuY97pPnFcAvjR+C3gMD147nJBT?=
 =?us-ascii?Q?DrF0q2pr1Qyt/VdGvEnP2QRsBCcZAkEB/WbfPw7GfXLhcT0X10ZGQOihntmK?=
 =?us-ascii?Q?0aEeXfzJta7n8lMMZkB4DBW9cMwAwGMwF7t6dT5Wtc2ilt64Wkj9FG8HRWfh?=
 =?us-ascii?Q?YzMAjZVaTJgAmzn+7Dx2Jyp16+Ki8DRTP2w6t5HiyhfURik17rAXeBq3C0Rx?=
 =?us-ascii?Q?Z0a5T+iWwad1T3Byk9JnH2x/0h70dquZps4nAMVUmTqmai9g5SlF9l9ZTNI/?=
 =?us-ascii?Q?+dOyR66w/GLYFfFF83KKmB9YezTq9kJFQT008n2wlw1ktYJIrWiUGCesmJU8?=
 =?us-ascii?Q?xqOr7mCcurwzgvX90ujgIyeXMJlP+sxyk7yno8y+q9hYOavI5ey+/xJvHECZ?=
 =?us-ascii?Q?LpTZMf0/UozT1oKDKaHevRMM3b9bGHrSNXxMcBq2AqdlYylecNgs8bdG4x0z?=
 =?us-ascii?Q?EqiYvIHDtyh30DCOiWbn1TUDXs2TNq/BpBfVO73Iy4LegiHj1Kw8SLneI7pi?=
 =?us-ascii?Q?UR4EvVfajwmV8+cI2PxCTFPoxlP5Ay6sFs9/PRRQBgLm/fpAjBVsL+vheFI+?=
 =?us-ascii?Q?k4ol5Wy6xQwNhL+UmBq0vIn700k+vHXzvV2zXU8Tj+bOluBOBbMPJloNjzN1?=
 =?us-ascii?Q?MeaCxKuDKEPa2AUT50d1SizWCAXpDZDLwN9EQ1lzWt11yA8fBLXvU+u0f+Zf?=
 =?us-ascii?Q?1nCfS7wgjAUtCkeF3HQ0TRbW7LNb1G+qv/M86RgUNgpLkkITqWaaS+WJ/B3h?=
 =?us-ascii?Q?sd/rRCUXd1hdO56ceUgBaSYXVKcVv97kZ38D16dtNGQLcKqpJvO/r7l7ZrdC?=
 =?us-ascii?Q?DBeKqAo7VMVnUhGeICgeDAA/6T7rsvp51U4WHdmW+G8WWWb62ASlTfv28NAh?=
 =?us-ascii?Q?ywwIiwBXvt/Qdf2UHsMH+idCZEqqd0r09detHyMYIKcDNHUUraPtuUcb1GJU?=
 =?us-ascii?Q?UvJyhC588rrcDSnBItkHh3ljuHqPko3QEvXdh7ambEAMQOKjPBMZa46a5XMh?=
 =?us-ascii?Q?TAuGAkmRSYqvQesA/jNj0zF/Ly3LNfIajE/DPsUCEG+lLeT+VF4/g6CpbGJ/?=
 =?us-ascii?Q?WasOLDCW0MMbh/fHNYnfrZeQc1aKQ3lVvrg1Uz5RC0rO9FuyKg+EDr2sXhm1?=
 =?us-ascii?Q?GhoL7MAc7o2Laryr1wxYmV1vIH8GZwT7PUaptY3s5X4Kn1NBmdxU3Olra9Rq?=
 =?us-ascii?Q?AS3BupnwRoEBCriQWviQbO5Jc458ODOLnoml0dQ13ECtngXor9/lRXm08N71?=
 =?us-ascii?Q?k7kUDULOpu859wWT/ckcDOO1ZVttDRWn/XpEiej9x51z2+Pvyh3ZI+NNuKR4?=
 =?us-ascii?Q?4yvUJClXIe1F1N8Q/Q7/6yMSufdUP3tLKR+8OUg4vUTpWqFcnzFsb1VL1/1y?=
 =?us-ascii?Q?zJJ/WLzi96osUmKBc0ZN5vWEqG+Sx9WbzRpgSxecZedQqVZHTZnrvwZCH+oq?=
 =?us-ascii?Q?6RH6sm6Vrt6wwOQnGDOyHqfmYNfSDJNkLtlcF+DfJFY3KstpvGIQNnAwKGCm?=
 =?us-ascii?Q?oPUXRSnV5i4Cbc8j4rhyIXWOmfeQUYysOXUSWRFsWQP4Nw+cYmbdAiGMhQzz?=
 =?us-ascii?Q?/3tITNcieca6kvDGOCN/0V4=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48d9b22-420f-4e53-60fa-08d9f28c6826
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 03:11:50.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/zsfN9iJLPfPEIetidABNEBETWGsyZ29JT/7iZApthxiyU4bQ9J18NW9Zy3ixqCuSwmA+Z7SgMFAYKOnF5SPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4870
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

Need to check if we got a normal length.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/blobchunk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 4a440d6..483362b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -221,6 +221,8 @@ int erofs_blob_remap(void)
 
 	fflush(blobfile);
 	length = ftell(blobfile);
+	if (length < 0)
+		return -errno;
 	if (multidev) {
 		struct erofs_deviceslot dis = {
 			.blocks = erofs_blknr(length),
-- 
2.25.1

