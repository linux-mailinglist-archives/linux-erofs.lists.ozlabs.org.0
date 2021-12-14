Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF9473FED
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 10:53:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCtwd6dm4z3000
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 20:53:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639475585;
	bh=KhSnUgUkrXjk0WCdu1A7Oy2o7l7bMIbugYgHTD1ekYU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MHq80R0tXpDahIWPulL4z/jUgRyi+Lvvtyu5N9hk3497kph2d74oj2hnTwPzqwhic
	 cm1hNN6vaB2gI7JKottsocnOqqC1WM9H00+S+FVc//NIclp2o8Sw+Zp4AK4MUXf3R/
	 8vCdNhTZjUD87AY60LFY6jRHGq+a1Z+ENZ02jO1WGR7J50X6f6YuppFFwuVmG6cL6Q
	 3iF8yfO4CvdMmAXGG13udoIj3A1AJ+5zs2qTycOI5+jUXwkPgGctsTBd8OJwzRyuyD
	 y1/riPZm4UbhwCJqOLpflQP3ua+0VgTB1y6MqnudhODuIJKkeYbNFEuhj93d+VkyyT
	 HtzOYajuMxKdg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.55;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=HmfvCEaP; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCtwS1lYnz2yY0
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 20:52:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr6WgtPEdcuHu9CL41YSkF1SNPk+OPe7EeIE4/lG2ExzoDB1V5wBsyHv7x111rae181Jrd8B0KMAPh/HCCo1fjimnj0IIBF3TCZIFy/oHL9jsFpXxA83/3Auh1E6e0HdQ/4pzdGy0W8mlmAlmeUFcCjTZV+8w9bt1fdYy9UICEBpHoYp4PkITmSjFsdRrmK12D7AVY3QG9AMYly4bWMqxa8LbE5OxSoR4pRstCOwdlbc/+419DFm6iqyGyzDBstyWgfojegMUEgcFxJlnfw9ZAH3wv1dnbqbF1a/Cz34t3v+ZhmDd/uBSnMlERqoSS7ot8w2/JFljHEr6CPXsTglBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhSnUgUkrXjk0WCdu1A7Oy2o7l7bMIbugYgHTD1ekYU=;
 b=QWbxRYrLMth24oE7iRo3SUkfjxQNsXsgpMSvfW53BqSre4wzffrL+jPjYdmt/lRk/EUF8Xeks8lJDbg8auWDyiADJJ1aTUlHFbyeaCFubpvM+N97heWrqiEuhC9Jp0dBcjv0Xt7iAey6sVRyvdd4JYbxQw4IWhZey0iQYETmpnsOYX8q11xWCYIzCuvqZhBoAz/2P/NN98bgdi+nqEJ3ppmAhHtqTPa0cpN32SXUHDBCcYtegHX3GkZxPPWi0pkMLIDiOy++WCfAK10mmKNbovX62t28mSWjeWQRYkjI99dFyLvG3vhAko+5pHh5NdVW4aMjKuEG9Y60XdrVus5zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3371.apcprd02.prod.outlook.com (2603:1096:4:47::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 14 Dec 2021 09:52:31 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 09:52:31 +0000
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 2/2] erofs-utils: tests: add test for xattr
Date: Tue, 14 Dec 2021 17:52:02 +0800
Message-Id: <20211214095202.11717-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214095202.11717-1-huangjianan@oppo.com>
References: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
 <20211214095202.11717-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6243d24-e52e-48c7-0b5b-08d9bee77210
X-MS-TrafficTypeDiagnostic: SG2PR02MB3371:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB337119ED9005774FE8C36DAAC3759@SG2PR02MB3371.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIl4lDGwwtBMUHFwCuM41N5OoQgfYuKTGrqY1J+kxNdF2JuqoiTYGsZ9BebzY7kUnpcjf+NFjSG0pD8N1dyi7q00dTpKN7UiwqlGhm8r+wYyVlnuIGMi4wJQd9II8K29b6z90rWwe66kg4tVgSKAqbLmH7lw2oxmPzI1xkXHVhMsB79xMg0jjuhGB7JbPJbu4xvr63NVajzC6gcqj6cd8ebD9fglR+yztlBaQPigcAT+c11SAM/AJfAVR1yXK6LLnAV+kWCr7cVfsLUWkv7xmi2ItOUPyUQIurTkJJ2FdssTn1MQyoX1QubFoOYZhjQtvuTXq7rORtXVaDq1b4gqoevsuyWOJRzxgUdwxpweb5BSci9uf3MmFv8NsGM67rtLh1Kg7EX7jf4mY7HVjrkLQnxTqIFuWOP7DVgD7oRqXpBrKBHHskv6173yQDUVl37FUCjv7yCjSLZdkInZ44d5sGRfDMmRnGZdVmWvM3cgpL3VnGFi8waBvvzdxijjonJPxtN3sRIFea9KtRxGkHRaOAE0Etaj+mTD1eQmW2Uk/m+KhjkeavuAW5baNwzd5K/uIG1szmVQM+7+OS+nDO+IMHS2f2arV3d3LWGhevvUZV+SzkdEaoikHKdGgDeev58S5Kj+TD2zn+zaLc6h5ScV0EiyidRepoNnpAJmMTO7DKN8luN2aDKuSfIDT9dQYBKIEemr7dCD9l6VC74EsA0nMwDI22LynqHWDILC+cmRq78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(186003)(2906002)(4326008)(316002)(6506007)(38350700002)(8936002)(83380400001)(38100700002)(66946007)(1076003)(52116002)(66476007)(36756003)(86362001)(2616005)(6666004)(5660300002)(6512007)(8676002)(107886003)(66556008)(508600001)(6486002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0uGw9pnorLpyX64HVBOs5tOoHmkEyBp/GyJPf5bct8pJ+KZG28xbyA2K88K?=
 =?us-ascii?Q?DaPNM2K/DpBu0B+eg8xFrIc6TUGzKUsx8XmVHhGAE9jZgEbZ+vfUARNkdH6u?=
 =?us-ascii?Q?Ngeri1cQMzTJ7Ey60NcfezcDm3GnYq4EZocws0jJEIx/FrFK8cAWlx1eaO9r?=
 =?us-ascii?Q?lreqB3quC2alS0bJUri/Xs/KDahUK7Hlay4fn1DOHGTSe2Zx8J6JAxY+YUZS?=
 =?us-ascii?Q?sHeTZjT5XL9Hy2Lnn9asp4ghA3Ar8gqHryIGbgU3C6mLkxj0JtBPPKHnmbdv?=
 =?us-ascii?Q?h0b5yx9CS4u6hfhajwv+IdtN0ImY+qmpoi9nJiN0n0Oxd75c7XtPGHQ4HUVb?=
 =?us-ascii?Q?oaFNBoFmJuGKIaTRaeqBbQynyq7IHApLKi8kTDU9bmK2/ZvDruVYSE31IYRK?=
 =?us-ascii?Q?MlL3kY1q0Hayd2SrQciIZveMwHDn2yaeSde7xRTjMEOos9HxWNc5vqwJPMvq?=
 =?us-ascii?Q?UJhC3T2AHHKY+m41wq+gfhS2Q2YmY3tPf+BqP6+o5sP3wtnL7HoWnLo4e/iQ?=
 =?us-ascii?Q?yYLUW0rs00ejqrb8G3lVx2mKlDSLB+oxkj7/4PiggoTQSZQMwfT/zRTUtFCY?=
 =?us-ascii?Q?k5J6yRUKibF7Q1WN+nBS3dR7PNnFfRshl0WtrakyltYfqPs6n/wTjaw6l6tc?=
 =?us-ascii?Q?ea0sMs9Sjll7m9b6HrfN/3gep80JUf9j3DX6ZVr83gbbtv4qi5qLzPHtxDc3?=
 =?us-ascii?Q?shcf68zWC29lIZGeMcLz1A7v03IKqS6hVgUX764UBAe/JvhB5/+6ok7vhD/t?=
 =?us-ascii?Q?bOnUlnsxaJqx1VMRf1HuNREsC68hFkjDI6J+hWIsaEe1jIQOCInKUTOzyyHL?=
 =?us-ascii?Q?+oYDgzSVAB8JT0QS873liTgapuNMF7MdUuwxOXK9rS8ay+jEvWffTJFmjtys?=
 =?us-ascii?Q?rPRxKp3HKMvHEUEF0swYKOqnlrra3ON5Llw3czhVIerRvRgwX5RW9kCb7EIa?=
 =?us-ascii?Q?z0+rPyN4Gs9rieburhTeA3a4U9fkAZlbg/ruo21o9BL0W6UZwtH8yrOTO71L?=
 =?us-ascii?Q?2I+sFwvI2+uwfiimKwEkzMojmQTwGEEczjZ6L5BE750THa0JNheKZAfak+ct?=
 =?us-ascii?Q?+taGgSz4bCzFdLInZU6bCdELcGIwC6P/n4LXk7ZAbR9pzjeZ5hw77B/bayXG?=
 =?us-ascii?Q?iRPwYR36A8ez0uUc1WPtB47Oh3eAVHh/3tEF3LzsWSK5OZ+DW0SL/smSNYlC?=
 =?us-ascii?Q?eJZwPw8RHlSE0HYe1yrRvjtusdkjQKaVREpo5TeHR5KBaAwY80P7Ro7Z3x71?=
 =?us-ascii?Q?UkDQTgBJmY7ZeuqxmuW8472pT+EXRMpoEWbAlnW/dW7Ep05xZtsIiFwocu4b?=
 =?us-ascii?Q?/dmpl4LXI5/u1tmkbL+FIlDPnZmenZWhgCqiu129lVLflXH3uuVu0vWuQ345?=
 =?us-ascii?Q?1GGluuvWvYQJYeaduDkem6b7VREdRalBC2KtgGLMxzdDwjLBXybfHroNLvvk?=
 =?us-ascii?Q?GUmgGXCzmHa2TOR1hI0GaaMgof7C6/yTfoi9WpuYaPdOR2qX97IsOK8bdDre?=
 =?us-ascii?Q?1RtGWTTBoKd3cKJx/DgLBmcWHww7DtMFBs6F0/liXup2502F/xdPnhsOEpca?=
 =?us-ascii?Q?K6rLKLmQ+g9kQoten1CncYwIsX0fJy5HWS5YEaUhyot0sQEwPdVKehqx6bt5?=
 =?us-ascii?Q?zUbegIsGfkidSwXGrPOYSZE=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6243d24-e52e-48c7-0b5b-08d9bee77210
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 09:52:31.2043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eep1AX7i0Z38kaa1Jmn45xf9ypsU+rKuzLngitR4+J5g6ciQV2CJdiL13IB823j26DQBmygB30P7cMQGWyKnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3371
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

Add basic function check for xattr.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 tests/Makefile.am   |  3 +++
 tests/erofs/019     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/019.out |  2 ++
 3 files changed, 68 insertions(+)
 create mode 100755 tests/erofs/019
 create mode 100644 tests/erofs/019.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6eeaece..da3e888 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -82,6 +82,9 @@ TESTS += erofs/017
 # 018 - verify lzma compressed image
 TESTS += erofs/018
 
+# 019 - check the xattr functionality
+TESTS += erofs/019
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/019 b/tests/erofs/019
new file mode 100755
index 0000000..5e182a0
--- /dev/null
+++ b/tests/erofs/019
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+_require_erofs
+
+[ -z "$lz4_on" ] && \
+	_notrun "lz4 compression is disabled, skipped."
+
+have_xattr=`which xattr`
+[ -z "$have_xattr" ] && \
+	_notrun "xattr isn't installed, skipped."
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+# set random xattr
+cp -nR ../ $localdir
+dirs=`ls $localdir`
+for d in $dirs; do
+	key=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
+	val=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
+	xattr -w user.$key $val $localdir/$d
+done
+
+_scratch_mkfs $localdir || _fail "failed to mkfs"
+
+# check xattr
+_scratch_mount 2>>$seqres.full
+
+for d in $dirs; do
+	xattr1=`xattr -l $localdir/$d`
+	xattr2=`xattr -l $SCRATCH_MNT/$d`
+	[ "$xattr1" = "$xattr2" ] || _fail "-->check xattr FAILED"
+done
+
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/019.out b/tests/erofs/019.out
new file mode 100644
index 0000000..163484b
--- /dev/null
+++ b/tests/erofs/019.out
@@ -0,0 +1,2 @@
+QA output created by 019
+Silence is golden
-- 
2.25.1

