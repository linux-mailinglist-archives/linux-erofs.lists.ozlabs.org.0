Return-Path: <linux-erofs+bounces-3088-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M4YL+D7yWmd3wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3088-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 06:28:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE104355479
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 06:28:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkdXY1DsGz2xly;
	Mon, 30 Mar 2026 15:28:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774844893;
	cv=none; b=flw+1htud5PTKrGlZbXquDuiWIavjZbK1qHE9QshLvfiyVt2daEpQ8pGWIbTm5avWvjK/2J0mjt+jPEhqqXCd0OP1WyFLjmoPsBmrnDEAzPdM6mVr19Wd0e073wIuofbKvrgUoLe2F5Q9Iz6EbnJxkCMH+KTbqEOM+cgO/1yg8HZvdZ45qYiV/6nCP2IRfGMx4QnHhpgvvSta8wtibzZFsXdKagjtACvgPU/l1x7gkvFuTEbAItAqvf7C5H1jcFZ2ikN7LyU0r8TLZXujNw9qcciWZb5XKZ9icE68FSdyu4VyM0+UXHP5c6nLR7OlFDTbtjJ5pc3PVgh3GVPxEL6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774844893; c=relaxed/relaxed;
	bh=xu4KbjgHsjho+uYUMtDaFb9gJ+DUg4RKN+RdE8AliAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vu2qQY3MMzJ9nhvtEp67p2aZJ0F5A5xGKB/8dG5agrioEPE+BPinP2L79GmUqPRkk2Z9+t7qpcfHNHxzy1SLpmYuwa8Fn++8K/i2nss8063+Ie3LnPVSgi2O/LDOlzsBnJyvtglWXNsMxbkb4qbQxZIKuxM9Ta9pWz5PR0aHatxvxlwmF6PCLNzbYCOEPzVH1zQHdNdv+DLYOWWZVhn/XOrVqA4tVqJby9rCz8/XP4zRvfH7o3rEI3Wup6hkxlCzCtjaDBUN4lTXvGsHJRSdAgC/vVuob8oFwApjCa8MbKd1v99/UUVkNp46a1mKHPmNosd84Nk7GRynS2q4A+JQ0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYnET0/t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYnET0/t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkdXW3Gmqz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 15:28:11 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82418b0178cso1902458b3a.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 21:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844889; x=1775449689; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xu4KbjgHsjho+uYUMtDaFb9gJ+DUg4RKN+RdE8AliAU=;
        b=DYnET0/tqXBmXf62LkhHGJPDsHVkB2qwFoVGEQGeX5Ucr+FlG4dl9y+0j9vQwCWyoy
         yYKxurq6dxXWfc+K4Ewc8kBJ8Yyf6gyfH2sVZXzq03w00e4ev2l/N1OT5s75L2xvOjwz
         Q9BqH89TaJF7foWlPyNXyRmit8ElyNmK4Xo2QAwmE3fvE5ysEkwEv+En97qHEPh73ltM
         88CmxetMgpUWwtRz6DQMdGxv4l8d6rX+tX3BpG9f7pgeKHwm+i/mJG381iVYFiTcPkP9
         rv3d0iQp/cM4FN81bebzmq68L4KnKluVKJjAPX/DtVjoCSxTL0AJWNQETQDoi+X71l/h
         pOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844889; x=1775449689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu4KbjgHsjho+uYUMtDaFb9gJ+DUg4RKN+RdE8AliAU=;
        b=GkHMfH2EWTduDC1UvnjKZ8QMFDUB9QdmdlaZVD0PhQJCyuN59CsmHQifPDGn9jRkwF
         i0a/EvDgZHmrW+Czgw62bP1EEqGEbHLSUOz9gFDh0eZSs2B7kMXuTXtkvPhfQB/hftXy
         9CXrieQsrFiE+47FMjkGTXCH1eZoNmLFiEzI3oPF6VpkLo63BfjV/hNocpdHJt8n/hFJ
         D9PBT+Xca9wA/12BIeeKtnUCe5PUrI3u9FqwvgIo3Sfghi/uER3dUQp6rfIoriD1lix4
         5CDPFJ0HCeCo/hkpHhgSkuIzTVEiFGBE3dLWvQ9ACtMO4mBN/qYAucSWnL+qIe/x2X+1
         QFrw==
X-Gm-Message-State: AOJu0YzGvalf+nKe7fiU+5i5f2UFZy9oTSXTG3gvjuDqW6PX65/C24TS
	bZhNKZlRf7+WZxOv0gqGq2YvgC9lP48E0aHihiKBFO2OffD7HBkc5TBrlomm7OfL
X-Gm-Gg: ATEYQzyy6SzP/cxEY1t7DRGANXl9JXauE2uak+XVqYoS3lPJwGUf3zEuKAnBco4UfbA
	Puw5H7WJ2CvNXTaroW7H0YsVYSK4w2Bfd3tT40arLfVd/dnbkIMehXJkYobXN3+Zy6iS7vM4Yox
	P2CdGmOWd0OBqf42HjFs86hZU7uvNBwDwAF3UQ3vtCvwEB5LX+vbC5CjFa0jJf6AosEU0kXHc47
	m2+yYLeyM1qSwHxuvdkq9EjXRR5I+E7KuPfGZ7S9pQSkftk0EFQsaPWzJwfasvnibluzTM2FynX
	ayt9GZZ3AWSyDl7ZMAUMQwgZyuUEgszg22z3rtACpsCjGWDbZ9qxtf/sVjgfUBwBACBs/rZFd+C
	GZ71kEs5gblB3/5ywi+IRjGtWTHHOH0ZaF0H4ADoos1SrmfmLbBVpXDBeFMuIW9+ZJ0mQGs+MF3
	dm7L0p31CfFvIW0UUTdOShw/nf3gGizUK0BTuRk4MeaY+SiNyIBmXElAG6
X-Received: by 2002:a05:6a00:3388:b0:82a:e3de:27c2 with SMTP id d2e1a72fcca58-82c95ff78dfmr9659124b3a.41.1774844888901;
        Sun, 29 Mar 2026 21:28:08 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm5750530b3a.50.2026.03.29.21.28.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 21:28:08 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	newajay.11r@gmail.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Mon, 30 Mar 2026 09:58:01 +0530
Message-ID: <20260330042801.78385-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-3088-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CE104355479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces a regression test (erofs/099) to verify that
the FUSE daemon gracefully handles corrupted inodes without crashing
or violating the FUSE protocol.

Recently, a bug was identified where erofs_read_inode_from_disk()
would fail, but erofsfuse_getattr() lacked a return statement
after sending an error reply. This caused a fall-through, sending
a second reply via fuse_reply_attr() and triggering a libfuse
segmentation fault.

To prevent future regressions, this test:
1. Creates a valid EROFS image.
2. Surgically corrupts the root inode (injecting random data at
   offset 1152) while leaving the superblock intact so it mounts.
3. Mounts the image in the foreground to capture daemon stderr.
4. Runs 'stat' to trigger the inode read failure.
5. Evaluates the stderr log to ensure no segfaults, aborts, or
   "multiple replies" warnings are emitted by libfuse.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 tests/Makefile.am   |  3 ++
 tests/erofs/099     | 76 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/099.out |  2 ++
 3 files changed, 81 insertions(+)
 create mode 100755 tests/erofs/099
 create mode 100644 tests/erofs/099.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index e376d6a..c0f117c 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -122,6 +122,9 @@ TESTS += erofs/027
 # 028 - test inode page cache sharing functionality
 TESTS += erofs/028
 
+# 099 - test fuse error handling on truncated images
+TESTS += erofs/099
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/099 b/tests/erofs/099
new file mode 100755
index 0000000..952bdbd
--- /dev/null
+++ b/tests/erofs/099
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Test FUSE daemon error handling on corrupted inodes (missing return fix)
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
+	# Ensure we kill our background daemon if it's still alive
+	[ -n "$fuse_pid" ] && kill -9 $fuse_pid 2>/dev/null
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
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
+echo "test data" > $localdir/testfile
+
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+
+# Corrupt the root inode to force erofs_read_inode_from_disk to fail.
+dd if=/dev/urandom of=$SCRATCH_DEV bs=1 seek=1152 count=1024 conv=notrunc >> $seqres.full 2>&1
+
+# Bypass _scratch_mount to run erofsfuse in the foreground (-f) 
+# This lets us capture libfuse's internal stderr warnings.
+$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/fuse_err.log 2>&1 &
+fuse_pid=$!
+
+# Wait for the mount to establish
+sleep 1
+
+# Attempt to stat the root directory.
+timeout 5 stat $SCRATCH_MNT >> $seqres.full 2>&1
+res=$?
+
+# Clean up the mount
+umount $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Wait for the daemon to cleanly exit, or kill it if stuck
+kill $fuse_pid 2>/dev/null
+wait $fuse_pid 2>/dev/null
+
+cat $tmp/fuse_err.log >> $seqres.full
+
+# Evaluate the results based on the captured stderr and timeout
+if [ $res -eq 124 ]; then
+	_fail "stat command timed out (macFUSE daemon hung due to double reply)"
+elif grep -q -i "multiple replies" $tmp/fuse_err.log; then
+	_fail "Bug detected: libfuse reported multiple replies to request"
+elif grep -q -i "segmentation fault\|aborted" $tmp/fuse_err.log; then
+	_fail "Bug detected: FUSE daemon crashed"
+fi
+
+echo Silence is golden
+status=0
+exit 0
\ No newline at end of file
diff --git a/tests/erofs/099.out b/tests/erofs/099.out
new file mode 100644
index 0000000..4f36820
--- /dev/null
+++ b/tests/erofs/099.out
@@ -0,0 +1,2 @@
+QA output created by 099
+Silence is golden
-- 
2.52.0


