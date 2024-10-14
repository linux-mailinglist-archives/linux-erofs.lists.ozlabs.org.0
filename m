Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CD99D079
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2024 17:04:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XS0r65Qc8z3c2V
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 02:04:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728918261;
	cv=none; b=MGuil2TAXcO83S+dl2bzQdLhRMjQn20GsH+3g374mXpgtrnSFf9X6b7eBdjOWE4VD+l5XZGBcwFd9/m25Gj7Pk1eDJRyogKKjkMJ8MA9GsK13Um8QAUv8gbQRRHBFMlGAJOdN+4v85AD8AIRlWI9rKaqjgGTJcGCnp0LS+gKUgMPQHIRWxOtxyjfZgxWD4iilv55GJ1m7mhJG8UfA5cu+tiFHoVbymP74LiYUb5bHWtB4QKX1abhvC9c0o4SsqP8QWLsoVY8T4UhqBxLasbh8UBjlh6IwGAatiBjSaqmERQ3zabV6vYLtgr9+LYb0CFB74SA5PwZokarlPVg/8idgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728918261; c=relaxed/relaxed;
	bh=f3vlUIcFK2AOdRKdV6A8m43KT7kiKOBOhbpDp5seMp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNH/gQqFI4OqhdZU0SdSsjV+vtRR3G7oxvFa6DlDvfiTnv12No8SDcWac+WQhbGj/waM7UmSJfLiLNWyFgcIrldQ7Dwb/wK9+g8Ch9xZx1MOqATfPveomBQHwwsVj4zYHknzHwoZ61xth2PqXK+fzZoZxLa8dSPe9IlzveK3Jrv+nFJSMmfTy1bxU8SKj6Qf/YWNbm4zm5sqLJyMDvLLqGFKhju02N5hxeLggbW/AGFGcGxwBHhXlArb2o93FcTaXipcfTWGyyB8ISrj5ULkt7xMtp0dprT8DRVNaZFOC+gXXNVeiQIxo4bQ+QUDtrMiHbJ7r1ujvt0HDmifrKHKcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DO+YF+xJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DO+YF+xJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XS0qv6ZDjz2x9W
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 02:04:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728918243; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f3vlUIcFK2AOdRKdV6A8m43KT7kiKOBOhbpDp5seMp8=;
	b=DO+YF+xJlRivTzSwo+/LA+sZFtxk+Kd6SBgd6k9v0AC+9t+biQg/r9gehQT9qPF+r51caW4cRXWGEFuijo1v7aIuVLe6sIUz8NFcgp9H+4CegVjBODhi3HJo7vB9CFGGw/1Xvs1nCd/5jkoumX8ebERk8UtTwW7IBCL5WmPJINY=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WH9vE2x_1728918241 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 23:04:02 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add test for file-backed mount
Date: Mon, 14 Oct 2024 23:03:59 +0800
Message-ID: <20241014150359.2185347-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Test for the file-backed mount feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 tests/Makefile.am   |  3 +++
 tests/erofs/026     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/026.out |  2 ++
 3 files changed, 59 insertions(+)
 create mode 100755 tests/erofs/026
 create mode 100644 tests/erofs/026.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 93016e5..70044a3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -110,6 +110,9 @@ TESTS += erofs/024
 # 025 - regression test for corrupted directories with hardlinks
 TESTS += erofs/025
 
+# 026 - test for file-backed mount
+TESTS += erofs/026
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/026 b/tests/erofs/026
new file mode 100755
index 0000000..2228f4b
--- /dev/null
+++ b/tests/erofs/026
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Test for file-backed moount
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
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
+_require_root
+_require_erofs
+_require_fssum
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+input_dir="../lib/"
+FSSUM_OPTS="-MAC"
+sum_std=`$FSSUM_PROG $FSSUM_OPTS "$input_dir"`
+
+# test uncompressed files
+_scratch_mkfs "$input_dir" >> $seqres.full 2>&1 || _fail "failed to mkfs (uncompressed)"
+_do_mount "-t $FSTYP $SCRATCH_DEV $SCRATCH_MNT" 2>>$seqres.full
+sum_uncompressed=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
+[ "x$sum_std" = "x$sum_uncompressed" ] || _fail "-->test uncompressed files FAILED"
+_scratch_unmount
+
+_require_erofs_compression "-zdeflate,9"
+MKFS_OPTIONS=" -zdeflate,9"
+_scratch_mkfs "$input_dir" >> $seqres.full 2>&1 || _fail "failed to mkfs (compressed)"
+_do_mount "-t $FSTYP $SCRATCH_DEV $SCRATCH_MNT" 2>>$seqres.full
+sum_compressed=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
+[ "x$sum_std" = "x$sum_compressed" ] || _fail "-->test compressed files FAILED"
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/026.out b/tests/erofs/026.out
new file mode 100644
index 0000000..e45c6a3
--- /dev/null
+++ b/tests/erofs/026.out
@@ -0,0 +1,2 @@
+QA output created by 026
+Silence is golden
-- 
2.43.5

