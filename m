Return-Path: <linux-erofs+bounces-3114-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCdxGfFQymmb7QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3114-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 12:31:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4C359529
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 12:31:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fknbK5g8Wz2xpt;
	Mon, 30 Mar 2026 21:31:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774866669;
	cv=none; b=dvO2oQVpgL4Kiqg8H2sgP58HJokri9oga3XmxqwDcgGLlsY5QoEovG88oyYR/clakdGPan22cq8n3B7FZ/5iwsUuGNERRjJSh7g7ihbYtPt9PlXwk46XAVY0WBQh8lShNTBcUz9gDdKH1Y1R+neh4mEK+fTXzy9J02Rjtc2ugRdNf1sLrsOdf7JBE4iyI2HVGvp3rtuX7xRl7GW9+M1UBo0ndJKSlJazvVRLEJkWnm8WwEbAOii2vslsJxhMPVNZ92Z2DMVP0zS+Hvly67gHK4z9GWbmkiSu8LZUxiXg1fBNy5YU/0XgCVQwgYppLi4Cg0B3Kz7VEAbIXBu1DNU+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774866669; c=relaxed/relaxed;
	bh=uz6fS8lRETbz2t3+whf8Amn55CL6gutKQNQEg4Bd0dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgWSGDKijIdTl4iHebbMrz8M3DCStJlol7Km8wIwLNtv5IK2PduoH2H7VjBCbDjZRZREU6pAJm4o6Eeykb35gxi1BFKJKQN78RkYpD1S0wOJ6LdMBjkKZZWayNpFuku50n74dB1nliocUblQ7A21s8vNu3eLMKilIrLTUogrFWhAgRslVA4xd8J58AT35TyLKwn7eo8PBaODQHbqB7X8dufW7BPxB7QdfBcLbfreHrSDWaot2uofcWAFZY/DHJXN+glmt7S/n0C2e5yJwa7pZ32dBGaQBwtm4PA6AyBh7Nivy7mVx5DRBO+MqD8Vc76yzwcAVDQvr2s9Y3DfFcW/+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6V9rlof; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6V9rlof;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fknbC735Pz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 21:31:02 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2816571a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774866659; x=1775471459; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz6fS8lRETbz2t3+whf8Amn55CL6gutKQNQEg4Bd0dA=;
        b=r6V9rlof+WWJ5nshEAvWp32C811eHveutMdY2ly7++HpyIrxA/gncaeqmV1hTNYZ+O
         oGO8ujWbp39TKxRtsIEzKXpqfEppvqGjVvhN8A53jsoqvS2grqfeuwM0Spv93wGtvMAx
         fC28RzLTfJqgS4tgw6CVGj27DwbEZ8gn8xXI8rw40w/VxEvcRC4LJWrSNUvDpMBjukxO
         MkCRbmZbXsS2whoQgVf53z1t3B4a/g1Q7NFM/TB6/gtmgJdLSdAqQxHXMUuHgWFaoxsN
         5UxlkUZq3hh2qiyCwCvoAcAQadx4gt+oI0e5EFxzV+jabGVbvf6IDe8EJZG0N2NSTjtX
         zcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774866659; x=1775471459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uz6fS8lRETbz2t3+whf8Amn55CL6gutKQNQEg4Bd0dA=;
        b=dXlZCudmp68pOB+rnmSRD40ZBGCeOlxHiOS4lqNkF176DtDrbsrthkiFixo8zwWxuv
         MJTIYbfU8fp0a3A2wAc1kgTUdOeDxp9HY4oO/2uNXdUwThgiLrCXTu94OmyXwVHa/9oW
         ReficYTFb93UqpqUP8rcaCWLiga2Kl9eAaoIv3oRukchlJR7iCSBU4g8iVxXS0mbZXiw
         WlkI/w2iJu+BeL6UEY059UE9h6tVzSByzufLSyYU3/iJhgywr7yTChVzpoG5JoboPYio
         d0iNLqk3t1YkfNKP8rzELsVRgLvCRiJmctCIrmbjiuB6fVRcBsqTV71YcteRzo+E2ToR
         2qtA==
X-Forwarded-Encrypted: i=1; AJvYcCVXnX4SB8s5cAKlCbE03k/2HyQpUdWxhuaL9wOYPNzTZes6iQjEzZgvtaWhKGUdhNbJLX3+x6/srojFNQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYVMUUPwg5+DYq8MJFD3aHEoy6JxI/MgNwHEHaII+SCPQWZwmd
	vrqynWg/R4rypC7vJUiLAqKXoNlAFWCJWXqqmwvXapOqlMjXliBb3cyS
X-Gm-Gg: ATEYQzyzN6w+2XwZ/wFtnjB7HQ7FNeBG27gXA2+eF/wfC89IXYzSI/FKJJPkUsIETEK
	Hitm8kFdluq38CBKUZznMEBV3jdTpEeDXAMbHywo80NI1+HbZPQachWgPCr5P+wOjvWd9iLuMsx
	TxoL8gQfbfUkGACPjEcZuJ9XvUNo5n80db+KJkdXQA02hMtFm0di29mmgyy1pvLRg3NRuOdQ4or
	jenxWQ9IP2l9pWNOpRbmQBLyfFhmwxVCwU/aFVfFQBw9MFfUMZpVYz1te5O7T5zjYZoofC0XUam
	/iKl9Y0tOiwwg71z8F9kqDCpDj4N6GTn6dvGGibFxd+OW0UQeXC1fp42pBoN9xpdlP0dnZutcDn
	cOZVFNB7tey8WWkXHEiZwP3CSTlE7CjX2pe6S2xRYX9FFiQ+Ea3xmcRoLaulf1gKBfPUe+WDMVE
	ny3a3mzVy1yedVomI5PuPBpZPk+3YQYuzFyzrpw2zfiexh+RlGWbnDDaKk
X-Received: by 2002:a17:903:32d2:b0:2b2:4862:78e9 with SMTP id d9443c01a7336-2b24862803bmr74847845ad.15.1774866659334;
        Mon, 30 Mar 2026 03:30:59 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afa57sm94298765ad.71.2026.03.30.03.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 Mar 2026 03:30:58 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	newajay.11r@gmail.com,
	xiang@kernel.org
Subject: [PATCH v2 experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Mon, 30 Mar 2026 16:00:51 +0530
Message-ID: <20260330103051.26877-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330042801.78385-1-nithurshen.dev@gmail.com>
References: <20260330042801.78385-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3114-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,gmail.com,kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6ED4C359529
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
Changes in v2:
- Added $FSTYP check to ensure the test is skipped when testing the
  kernel driver (Gao Xiang).
- Renamed cleanup() to _cleanup() to align with standard rc teardown.
---
 tests/Makefile.am   |  3 ++
 tests/erofs/099     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/099.out |  2 +
 3 files changed, 95 insertions(+)
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
index 0000000..11dab4d
--- /dev/null
+++ b/tests/erofs/099
@@ -0,0 +1,90 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Test FUSE daemon and kernel error handling on corrupted inodes
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+_cleanup()
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
+# Default to erofs (kernel) if FSTYP is not set
+[ -z "$FSTYP" ] && FSTYP="erofs"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
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
+# The EROFS superblock is at offset 1024 and is 128 bytes long.
+# The metadata (including the root inode) starts immediately after (offset 1152).
+# We inject 1024 bytes of random garbage starting at offset 1152. This leaves 
+# the SB intact so the mount succeeds, but guarantees the inode read will fail.
+dd if=/dev/urandom of=$SCRATCH_DEV bs=1 seek=1152 count=1024 conv=notrunc >> $seqres.full 2>&1
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
+	# Run erofsfuse in the foreground to capture libfuse's internal stderr
+	$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/fuse_err.log 2>&1 &
+	fuse_pid=$!
+	# Wait for the mount to establish
+	sleep 1
+else
+	_require_erofs
+	_scratch_mount >> $seqres.full 2>&1
+fi
+
+# Attempt to stat the root directory. We expect this to fail with an error.
+timeout 5 stat $SCRATCH_MNT >> $seqres.full 2>&1
+res=$?
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	# Clean up the mount
+	umount $SCRATCH_MNT >> $seqres.full 2>&1
+	# Wait for the daemon to cleanly exit, or kill it if stuck
+	kill $fuse_pid 2>/dev/null
+	wait $fuse_pid 2>/dev/null
+	cat $tmp/fuse_err.log >> $seqres.full
+
+	# Evaluate results based on captured stderr and timeout
+	if [ $res -eq 124 ]; then
+		_fail "stat command timed out (FUSE daemon likely hung due to double reply)"
+	elif grep -q -i "multiple replies" $tmp/fuse_err.log; then
+		_fail "Bug detected: libfuse reported multiple replies to request"
+	elif grep -q -i "segmentation fault\|aborted" $tmp/fuse_err.log; then
+		_fail "Bug detected: FUSE daemon crashed"
+	fi
+else
+	# Kernel check: ensure no hang and error is returned
+	[ $res -eq 124 ] && _fail "stat command timed out (kernel hung?)"
+	[ $res -eq 0 ] && _fail "stat unexpectedly succeeded on a corrupted image"
+	_scratch_unmount >> $seqres.full 2>&1
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


