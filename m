Return-Path: <linux-erofs+bounces-3218-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNyrBEtJ1Wk44AcAu9opvQ
	(envelope-from <linux-erofs+bounces-3218-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 20:13:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BF3B2D3A
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 20:13:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqvT26tjQz2ydq;
	Wed, 08 Apr 2026 04:13:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775585606;
	cv=pass; b=FFmhHVuNF9EzVUYuEsPVDcIW9TLLDkUa5JSJPfvDrQYSm2Jfr/HQy31aSTXSIgEcovRamF2nV8EHPNUbqEzX9JtXSbCJ+RMs6jSbk7JdTbla0yUMmgP5QU1H6pR+YQsrF8DvpnrKF0EmDJYwcDyGPwbr/xRrW45wFKfjtb5GBnrgBSud+swkZUv0Aqll08RmDYKzZ8pW7z8WKplMmy6CMzWbmTZjwFkbuTOEYGH0NV+3B3gGqvGIXTkv2dbi+sLfRL6Dt+vgOJXRCL61e9cnNWVwKVsONeKI8eNge03KPkWkW59TsArH2EtphF6zyIlRlfTEUeKGa5CHALsHIXa/Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775585606; c=relaxed/relaxed;
	bh=49KfjRicTxyrJwny51JdKZt25vcPW9zPIvx5KVf7Bd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jmt1cjsUfqw0JwE7OZy63/jlH/hCbeee+A79+Knj0NEnorM3Jqn5ATZuCYf5fGCFfRP3xfaF9QgmaMSMoK56d88ql8dXeNnxGSlcoELj/00CgnoSZ5m1xDcyU91C0u8Evo5vfupuanGYTrdqVxYKv/lEUQj66t6XSXNwrDi2yQa1ZaDr5kESYbdclQ+UhX47Ze8lEr2E0cMBQnFPPQJBZKtI1nE6+AFrGb5GFcL0AnJ+ILtBTpFhXOh4ipo/7BfFu0BNHuGVbmH8aCPcyNUI2lo4Sl5mEldJeOgJr1sutWeGXkta31fD7xtHQ0qMnwS29xl4/T3t4LoyW85mJ2AFXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=X5qMKLqn; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=X5qMKLqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqvT060Ylz2ySC
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 04:13:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1775585597; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=e9n+iH/7M6Cj+ikm9E1cNctSTI0Ku/CDnhOpUgLWGmZvWv36TuKgj6Ocs5K2I/VdLmp2QvpKb/5rJuhbn/QHER2s5fuekD4g/5qz0Vj/TlC8llF7DShXRMFYZ6LcreDyRDhF2gcH9DnJeDvWCN69moeMCF1k7bYa0YkYD+j18Lc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1775585597; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=49KfjRicTxyrJwny51JdKZt25vcPW9zPIvx5KVf7Bd4=; 
	b=MjC+fTJJyX0ugVdfJXPywz9J8z9Ft9W4vJOA2JizUvKIuTB5iK1wUhseSvjUX5rmTA+6YEfKnyO5kcZpis1mD/XkB4rZQcPmEOc3a+zQcpFtd+rwlljau4yw4XHT70sZtg3xi2kYkmIfFbNDRHvqV7DsTs1ZTCIpKZQS8/RPMKA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775585597;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=49KfjRicTxyrJwny51JdKZt25vcPW9zPIvx5KVf7Bd4=;
	b=X5qMKLqn+rmcbYXMR9xNP9MTLzjf61grV1GvWyghSd0NqxWEiDpiYYnSdqhIRNCj
	ohNZs9oxRfTXgCEW/cd5IXp5t7ZgRn7wZnJQlv1DwitBwSbjMMA9Lqr/sCV9/4/GXV3
	lXSmrrMu20oEJWaTX55AxAkWaJgMR11BvOhZoiaM=
Received: by mx.zoho.in with SMTPS id 1775585594266396.45242353386254;
	Tue, 7 Apr 2026 23:43:14 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tests: add test for negative GNU tar mtimes
Date: Tue,  7 Apr 2026 18:13:13 +0000
Message-ID: <20260407181313.89203-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7228eca8-8688-438e-a3c1-95b322d5940e@linux.alibaba.com>
References: <7228eca8-8688-438e-a3c1-95b322d5940e@linux.alibaba.com>
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
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3218-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: B16BF3B2D3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for negative GNU tar mtimes.

It creates a tarball with a file whose mtime is -1, checks that the
mtime field is encoded in GNU base-256 format, and verifies that the
timestamp is preserved after building and extracting the image.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 tests/Makefile.am   |  3 +++
 tests/erofs/030     | 57 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/030.out |  2 ++
 3 files changed, 62 insertions(+)
 create mode 100755 tests/erofs/030
 create mode 100644 tests/erofs/030.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index d8ac067..28edc0d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -126,6 +126,9 @@ TESTS += erofs/028
 # 029 - test FUSE daemon and kernel error handling on corrupted inodes
 TESTS += erofs/029
 
+# 030 - regression test for negative GNU tar mtimes
+TESTS += erofs/030
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/030 b/tests/erofs/030
new file mode 100755
index 0000000..6d57225
--- /dev/null
+++ b/tests/erofs/030
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 030 - regression test for negative GNU tar mtimes
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir/src
+
+: > $localdir/src/foo
+touch -d @-1 $localdir/src/foo >> $seqres.full 2>&1 || \
+	_notrun "touch -d @-1 is not supported"
+tar --format=gnu -C $localdir/src -cf $localdir/foo.tar foo >> $seqres.full 2>&1 || \
+	_fail "failed to create tarball"
+
+mtime=$(od -An -t x1 -j 136 -N 12 $localdir/foo.tar | tr -d '[:space:]')
+[ "$mtime" = "ffffffffffffffffffffffff" ] || \
+	_notrun "tar did not encode a negative GNU mtime"
+
+rm -f $SCRATCH_DEV
+$MKFS_EROFS_PROG --tar=f $SCRATCH_DEV $localdir/foo.tar \
+	>> $seqres.full 2>&1 || _fail "failed to mkfs tarball"
+
+rm -rf $localdir/out
+mkdir -p $localdir/out
+$FSCK_EROFS_PROG --extract=$localdir/out $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	_fail "failed to extract image"
+
+mtime=$(stat -c '%Y' $localdir/out/foo)
+[ "$mtime" = "-1" ] || _fail "negative GNU mtime was not preserved"
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/030.out b/tests/erofs/030.out
new file mode 100644
index 0000000..06a1c8f
--- /dev/null
+++ b/tests/erofs/030.out
@@ -0,0 +1,2 @@
+QA output created by 030
+Silence is golden
-- 
2.43.0


