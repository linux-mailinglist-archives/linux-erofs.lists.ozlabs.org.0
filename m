Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500140C457
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 13:22:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8d9N6Lbhz2yL7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 21:22:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1631704952;
	bh=t46cJfGedR1qwuO/TiMd1TrwLxWVnbDtU6EGE1XHN9s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DLwxMogsoiyde6nvoCUq52xBLr2tYA7RJmEdzk8uP13xbqUnI5ygvoVxj+DfZj5Oe
	 s2+VBITpZyWn5nfC8H7FQ2FKK44ZTClm2J9EpSqgyzgB6LYfAlELYVj4ZBfJLFHCym
	 BJH1sXG9NwBNREIruP6DC9jeaev5pL5ILTNu2XrWM2nbKF2ooNfTYSKneTTv/lUpVQ
	 YPwto7b2tT4/w0JbtsdJyM+HpousCfHWlj4PxU5fI8yIGcId17g4M9BPDU/cJdsOJT
	 mc1pgT7XR6ZonO9eCX4F7zNHPjWCOPrv42hmNm1/E3v0/NL4MLENwx8Q8DTWZwKLHp
	 GDasg972+MDPg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.71;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=OoDcsyOV; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300071.outbound.protection.outlook.com [40.107.130.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8d9F5ZP3z2xvV
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Sep 2021 21:22:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt/XYF7psrfhmYOSoveqk2TbQ27IPwfb/zUyOgDqOCPlt6TbtkqiJdKwFBoEmeXyZTeGeURYXPIaeSMwpjyK8B7OchLaLXtENZsgRzFsbytt/wYSj7h6hRPY8AQNVRJNmYlvkadhnm4aGzLGnTILqY506EIkPwljQkiYuKsbpweNJV5mvsdhLjOtgI4qXxtvV9SflnZRvLv2RdyrfWWFJwy/vPq5LzH9SMTQkdOoRY4/kYWylllwdiWSj6kzFSdpWhSu0E2DUq0KKsE500iSpg6Aab6cR3M7ptG4QLLoRSyHPFAH4LUJD9oRn5gm8RR6gpRB/v+K3Qqz9fH92v8TSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=t46cJfGedR1qwuO/TiMd1TrwLxWVnbDtU6EGE1XHN9s=;
 b=jndK8wgqjZX5+e1/GNxrzuwPwyfkn4iKK5NjlWOcBnMM64O/J4Kqt1YfyK4WZbm4jVymGPjG6iQPgWnMneau16FwMUqbQzgONkqeZ8OfggpBefX1aN0Vvcg4BzzxC4suaYYcbNJ7g8PBgI8B0V34erZmF6O9JEHH7HM1wXxbWR6d26rhmG8aCfsQP+Q6Mc1Jcxt4SEiDvDvRqNf7V5w0pUD6DLVBd+6/DYa3Kd/VuPTBpp3OB52DtxGjKtR2wNLjKFuz09i/7vfXCToGdRf2xH6USg/p3XXgN8UG0z9U9vCkEEcWQAoiToVY3rfzhGRv4D40e4sg64fB6/1e7zWhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2859.apcprd02.prod.outlook.com (2603:1096:4:56::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Wed, 15 Sep 2021 11:21:56 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 11:21:56 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: check the compress-hints functionality
Date: Wed, 15 Sep 2021 19:21:49 +0800
Message-Id: <20210915112149.25073-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907001250.GD23541@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210907001250.GD23541@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 11:21:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08bfa92b-a520-44a7-c159-08d9783b066e
X-MS-TrafficTypeDiagnostic: SG2PR02MB2859:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2859CDB96E231C18194720FFC3DB9@SG2PR02MB2859.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOoOn6Pko0W88g6HSjLB2m5uwMO3jGqX66wjBZ9/gOzWsIZ8yOUs6r7lOhn8h4SXhDQQetdSZsrb04lzVhOtVowekjXszgTJrdHvdK556NYrwcR04csDvhWhQJGWEstYZ/WUinGBlW/nBCRKfvruwfKldBKDJZ4E2hmmMQix4aj9ndpRXUhANDlsfH86bRQ2IXjFzZfL42vPijQB440CSHowtwqMcs87Go9Rx3cCIkO7Wz1Y9U8BKRBcsY/rH0OYIkcAHVDcz/gDPjT0P6IiOcrAI4+331e57J+Aob8B3rNPBJOnXvzUqeTmgFGtnDkbolud6LzDXKgtKmzt5JER2DPdQ7lNnqyFWijaFxwVyNT5x8gti//cu57qJcbeifHGfiSl11Q9FUWp0ROhsEJcIu8kf0Yv+xsG6/U3rHFWqUG27gEp7mw2vjfy4mVVTPM4JMvdTzEAj3VOFDriJQN0EeaSXTMSnhSHPy4weptCrvgDAmBXXGbYIqUz182nf9WxhjmwZ4MttUCW9NtMJt7sT/+Nj1urJfSDIbj7Jr4QOsu6Ueu9UGxImT4hjEYysav6hr6l/e5lgNngKtr291Ae2Oda4Tu+Qu7yDbywMDqSUynskYolchTpyD5x+G7PTYPDHKRs6lULVFhGIGM+Oru7yc3nwvlNTLJvgFJEzrV1gV9YRdq1x6c2Sswkxg2OQp1Dz+ga53BvJymz6bHQcqzo9aljZ3piPdTJdsZ2SI96KWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(316002)(4326008)(2616005)(107886003)(1076003)(83380400001)(86362001)(956004)(478600001)(6506007)(186003)(6512007)(26005)(6916009)(2906002)(66556008)(6486002)(66476007)(66946007)(6666004)(8936002)(36756003)(8676002)(38350700002)(38100700002)(52116002)(5660300002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmWrJei++Ol3wEsadYfg8dRsoQUPe86rN4hJ8SGjd/4hs2qUhc7Hu7yvn26e?=
 =?us-ascii?Q?D8yJDobkntOYl08YxfQ7WaRD2WLWNkH3QPOfYTjOl6nO0IZ88e5FQBWl/AVX?=
 =?us-ascii?Q?jasO0yRNiFWRC0EsW7s6m49D9W4Ejr2chLvoD/SNlpk++NIBjuDqXXPNjPZL?=
 =?us-ascii?Q?O7lmfDcEzxnCq1+i39XbPjmkbnCtT6sXjJ/KUtnWpOjBdVZF2mTNH0yPgqjp?=
 =?us-ascii?Q?q8NjYe6uOujsqXYZDV6P74OyFnNWCRPbyjw9W6KClVQqawzQjpTCWb9xOe1a?=
 =?us-ascii?Q?tHculDdhxhH9WLXT2c7qTO7ZtCOoqlrLN4aadyOTNLNnYqWfcKOKFNapAt0n?=
 =?us-ascii?Q?YrHcrMTQPcJxJClPTxZA3Gjjuu5hxXsQy34YOkFLCC4ndJDdHKfGcsav+XG4?=
 =?us-ascii?Q?x/1FrLSuWO+un8zEzKaSrCoNiekkGtvY/rwEWzUfn6mJc63YT0veIVlBE13A?=
 =?us-ascii?Q?mEwuOF5UObQM5aZDEg6wpOl6RoN4uOhSwnV4aNKoyxeEOIUwB4RXUzoZ7Jn9?=
 =?us-ascii?Q?LEsksQBb86gJeO/I86AwLl0q52Uyz2YUnneqg72Jy0kdd8+dP2wCwwZftVvB?=
 =?us-ascii?Q?V/AuNMjXJfLZ55UPYtNS27TPGg+uGoizuMJukMvYpoan/fcA+Ha7OxsrpK9/?=
 =?us-ascii?Q?Ers6Lzx8ppclGtmXq+yWgLegTxgYqnqyR6dAxF7g0Ikw2H0ybvrMxG3lBQ2q?=
 =?us-ascii?Q?mDVOllh/PBz0emlY9OkFe1BbqJAlom3jkfarbimVrd158WYYYoHXpd3YshJB?=
 =?us-ascii?Q?lDwD65mh4H3jeeOuGz+UEv1pNRmPGyqkgM4DQyfv8Z9TzAPGKoWhDTI7tueE?=
 =?us-ascii?Q?kE/mWV4rY1/OuEmQRWwwxTiK3O2AaGhDAUWLSBeBokev2f5kt/GI5h3tFo2T?=
 =?us-ascii?Q?6OnZvHxdQhiiEu+ic/27c6i2vUXQnWGcKh1/FzUGAX7LnCXnm1tB7/zR9CMD?=
 =?us-ascii?Q?vL5t2Ein8GSR0DcwgIgcY/NS4mCaLqaAslnvO2oFLu5+CzIZkh7J9Kk/618k?=
 =?us-ascii?Q?hiftnJ4QYgqnPIW3B98RunBeiOqUFgpjvra/2WGgfCwafDiyaSxR3fXDtWoV?=
 =?us-ascii?Q?Jw0voz4ssJv+LDgVCIcKs1NcPn1JKjGfRXNfXi5+cQJ8QR3FL1PBzTCzpcxI?=
 =?us-ascii?Q?tKLqiITIiYjjGsBjO8ySUDlDlkYdL7g221sfq2rJXhqXTizWzJ3k7qyyRpFV?=
 =?us-ascii?Q?Vo3crkvI8/sr8jnGJ07KuaPTzaapPPoqdm5UWJEXiqryCvHenZMcp98VJdv3?=
 =?us-ascii?Q?RT1sN4WYVPr1JrEDKbr88KvqzQGsZUhoXBsc7Zip5K3fUICfUr87XEiXiCa5?=
 =?us-ascii?Q?vtbY2nzBfvKQM0LacL9JIE8P?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bfa92b-a520-44a7-c159-08d9783b066e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 11:21:55.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phgNQjvfLJ5e/7Hi4YTZqldd0Hh1ujzzb7oJiZg09HE+B/oR0TNhbGSvU3xL5kmIfrmrr1UHWJJt4gMxjKjktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2859
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

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 tests/Makefile.am   |  5 ++-
 tests/common/rc     |  2 +-
 tests/erofs/017     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/017.out |  2 ++
 4 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100755 tests/erofs/017
 create mode 100644 tests/erofs/017.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 1d73a1b..632dcf5 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -70,9 +70,12 @@ TESTS += erofs/014
 # 015 - regression test for battach on full buffer block
 TESTS += erofs/015
 
-# 006 - verify the uncompressed image with 2-level random files
+# 016 - verify the uncompressed image with 2-level random files
 TESTS += erofs/016
 
+# 017 - check the compress-hints functionality
+TESTS += erofs/017
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/common/rc b/tests/common/rc
index a6b6014..abd88d1 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -185,7 +185,7 @@ _scratch_cycle_mount()
 
 _get_filesize()
 {
-    stat -c %s "$1"
+	stat -c %s "$1"
 }
 
 _require_fssum()
diff --git a/tests/erofs/017 b/tests/erofs/017
new file mode 100755
index 0000000..a12d1ad
--- /dev/null
+++ b/tests/erofs/017
@@ -0,0 +1,78 @@
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
+[ -z "$lz4hc_on" ] && \
+	_notrun "lz4hc compression is disabled, skipped."
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
+# collect files pending for verification
+dirs=`find ../ -maxdepth 1 -type d -printf '%p:'`
+IFS=':'
+for d in $dirs; do
+	[ $d = '../' ] && continue
+	[ -z "${d##\.\./tests*}" ] && continue
+	[ -z "${d##\.\./\.*}" ] && continue
+	cp -nR $d $localdir
+done
+unset IFS
+
+# init compress_hints
+compress_hints="$tmp/compress_hints"
+rm -rf $compress_hints
+# ignore warning
+MKFS_OPTIONS="${MKFS_OPTIONS} -d1 -zlz4hc --compress-hints=$compress_hints"
+
+echo "0" > $compress_hints
+_scratch_mkfs $localdir && \
+	_fail "successfully mkfs with invalid compress_hints"
+
+echo "0        \.c$"  >  $compress_hints
+echo "1048577  \.am$" >> $compress_hints
+echo "8192     \.h$"  >> $compress_hints
+_scratch_mkfs $localdir || _fail "failed to mkfs"
+
+# verify lz4hc compressed image
+_require_erofs
+_require_fssum
+
+_scratch_mount 2>>$seqres.full
+
+FSSUM_OPTS="-MAC"
+[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+
+sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
+echo "$localdir checksum is $sum1" >>$seqres.full
+sum2=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
+echo "$SCRATCH_MNT checksum is $sum2" >>$seqres.full
+
+[ "x$sum1" = "x$sum2" ] || _fail "-->checkMD5 FAILED"
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/017.out b/tests/erofs/017.out
new file mode 100644
index 0000000..8222844
--- /dev/null
+++ b/tests/erofs/017.out
@@ -0,0 +1,2 @@
+QA output created by 017
+Silence is golden
-- 
2.25.1

