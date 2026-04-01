Return-Path: <linux-erofs+bounces-3154-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBcCAGnPzGlFWwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3154-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 09:55:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3937659A
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 09:55:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fly2X4B0Vz2ySY;
	Wed, 01 Apr 2026 18:55:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775030116;
	cv=none; b=oT5at8Wxu2ZZLfswNTp9sB7+h8Fuo4ADKNdnWfP8+Dkg9sNq4EXz8SQVIM5mGDMwC5fHYcq8srDUWU4r2iJMPaeCspRQ5KFC3xjxs5H0GWwJIPHjT6Ie6kb7BKwwu3DdEKVWt0MhNXLL3AGM4+FNBq6vmeWGx94jcUL2+l653xD0IW4/wgJlEi41vT7h3vkDYtZJyCN7JSBGPqZfcmIRGMhTRhKgjQWywO/W+5Haus1WNI4rFT600k6A8wtgKDbyk+FcXb68aw0YK82P0t6LSVhRyx0q4KEAwIEKSiWer3AbH0KPyWjGhunHiifWL0ueQuhKyV+5ND61MXtkUSrYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775030116; c=relaxed/relaxed;
	bh=rZ1+ns/EQ3R9uNipu51aX2c9DRWUfzVguW+BVoEquwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFCk5JQQNQKj1dnV1FiB9ML+Lr1B3poyb0bq5Q2sYTBG6pBKWy+qOudyAZKo2AYwEPhhMPzmL9KXccsnuSHleg4wCcWJXxA5W6Ir0Kaypvmti3w+2M7a3dkZC6qnpERFA9s9oPtoRB3p4X5REUOQNKekJMnyy9BnWAF3wd99O7cPVkb5TIXSJlxhJLwBKmEmUy3l044anp52qzzQ11ttRXkOmv6GP55S2Wj+XOjaUAK/VLu/YfndxO+Oc+1RjBKad1QmCkC1M5IwvWeKmKBbitOm25B2aTQNxF514o3uyCdG9goBHK0PAUX2q5mOwx7Vd90ml05qBly+J9I3Y+P0Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UQk/9m0M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UQk/9m0M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fly2W1r9jz2xpk
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 18:55:14 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b2503753efso25832515ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775030111; x=1775634911; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ1+ns/EQ3R9uNipu51aX2c9DRWUfzVguW+BVoEquwU=;
        b=UQk/9m0MbGI8cew1peXE/jwU8uQ8DbFjqpxG8Kd8swagqUZv0nC48V/arEAOdfH2u3
         MEQujv5kHqRRazFdQ228uv2KV2qu6bXHVG48f9XtsFDdQf5jUIUIWt7s9dYXmopZxBN4
         wkDmrb2R64YuU0gWorIFPZweUHcPNdWnHTImMiuYsriGvKXH4fIVJkdjK1rUQdfgigKH
         j2drFIK7tUqsHDYxzijf69V2nDMKd9aulC1rtnzqflO4kpN8HnBYrobQcE/KzxeZKt0q
         LsvrDFSs4WoBFjTjM4itrqm6bg3uVIlK6dFpMvkQcTGmP0hExIhUZYtfrBGiB3W6a8oL
         CS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775030111; x=1775634911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZ1+ns/EQ3R9uNipu51aX2c9DRWUfzVguW+BVoEquwU=;
        b=Eg4wNemkFaGOAjSr/VZzTlJcVK5aGDU6B6fns+9loVqZGb+QYmm8rv1xX0FLQFhedX
         lQyxenhd6/DW4SpJZajUcftQVoe3l8Zc+IPm8MW498TdlFvFMoFBFF1ykJiCPYzyItr3
         2R9g5XyNKRXuo6BlPZC6fJYWD8zCwXxKrxqpIr33DExAosxeW2HRbRork5UorMOCky7V
         LvhrOuQkN7I91DhFetK5gbrmG0W+/eRFlS4NcgUv72OpFMkTb2PXcAJAJXi4DawnxuPe
         PTgHc+imLUwmj0viZcWHbw6B7xiKAIMMv3BnXQ1EEuVevwdIyBTnW4sOAqoJSyW6TWc/
         6b+A==
X-Forwarded-Encrypted: i=1; AJvYcCWelTxi6fY9mLmbSg37WBhIdwi/ByJI7HI5H2sMZ6oqs3FEP2M5DiGOAm74we+m63EUQmoBXSewgX/Bpw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnpfA2T1A1w0nN/fDrsoY1tNpMCV31qdVUxwBGoGC5DMyMHKbH
	nkZ/PERm1WbFHunhGcH5jhK4/GIqOz8KcYJF+/8bRWVUvVJiY5f4egUL
X-Gm-Gg: ATEYQzzOEG6BYCNa2jop28nZvj5f99AAsIBd55jCIVtj3IHcsEcRb44WLDsh5ZOAe5R
	s4/Kgyg9Ipn/ttH5dYtEqcDS/UsXETIgFtLKdduanxCYzBIu7xSI0n+hT8ZyrosChWBApIqt7ka
	EmDafEu1d4OFZ8sm5QHiWu4GePYaXRB+NQpKu1mp8ox0KgcK3wP/xPTw7ULCv7eMLnI+Uy3TzN2
	GM+rhHZeN8Oo3z2CY9nLGEt6wjNIJPzBuprxfkIiizpDCXpczKg/Aw07M8ldU0A+auJES0l7IJa
	WOHVcsArtLA0C68ulx/FYcIY5SOjvwSKx90yJC8tUBdQ4sBcCGRyiTODkf0L6e1yvzClDta+/5/
	ScOg+zRCrJgdRIo6tlFYxx8qcT3XTTuX3xFdpn3qRg7oF5QQ48cW2C7n3kPpiRF2RVTD3IabZnB
	+xZziSepfRZuUN8PGMPAHYyD4Mh7A/CE+q1LtfuK9HBbzivJAZKm4w/86o
X-Received: by 2002:a17:902:f54f:b0:2b2:5091:1c0a with SMTP id d9443c01a7336-2b269d1044emr24206375ad.41.1775030111541;
        Wed, 01 Apr 2026 00:55:11 -0700 (PDT)
Received: from localhost.localdomain ([45.114.150.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm176839855ad.48.2026.04.01.00.55.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 00:55:11 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	newajay.11r@gmail.com,
	xiang@kernel.org
Subject: [PATCH v4 experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Wed,  1 Apr 2026 13:25:04 +0530
Message-ID: <20260401075504.88389-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401071018.86191-1-nithurshen.dev@gmail.com>
References: <20260401071018.86191-1-nithurshen.dev@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3154-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6BA3937659A
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
Changes in v4:
- Corrected the commit message and notes to accurately match the
  code submitted (v3 accidentally included a draft message that
  did not match the diff).

Changes in v3:
- Disabled superblock checksums using `-Enosbcrc` in _scratch_mkfs.
- Used `_scratch_unmount` instead of standard `umount`.

Note regarding the corruption method:
My apologies for the confusion in v3. The email described
using `dump.erofs` and `0xFF`, but the patch contained my code
using the hardcoded offset 1152 and `/dev/urandom`. I am resending
the patch as v4 so the commit message accurately reflects the code.

I originally kept the hardcoded root offset (1152) because targeting
`/testfile` dynamically with `/dev/urandom` was slightly flaky. If
the random bytes happened to form a valid-looking layout, the bug
was bypassed. Wiping 1024 bytes at offset 1152 reliably destroys the
root metadata and guarantees the bug triggers 100% of the time.

Is this hardcoded offset approach acceptable for this specific test?
If you strictly prefer the `dump.erofs` approach (using 0xFF instead
of urandom to guarantee the error), please let me know and I will
gladly send those updates in a v5 patch.
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
index 0000000..0189813
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
+_scratch_mkfs -Enosbcrc $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
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
+	_scratch_unmount >> $seqres.full 2>&1
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


