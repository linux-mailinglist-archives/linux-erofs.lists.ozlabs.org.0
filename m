Return-Path: <linux-erofs+bounces-3130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNlDMH0yy2kbEwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:33:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC13637B9
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:33:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flBxk2QZYz2ybR;
	Tue, 31 Mar 2026 13:33:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774924410;
	cv=none; b=ftqMt3NufJ3rqxBKmMqqFwTriUbRgcI16xpggNeZp37HWRds7BnblQyRHgMCgh3r8JNQfxh7g0NOo67iSVPMStTy1g7dxxG25+fHkllbo1GPZvsB7puSgZO8UGuKejelUC/n51ZTHXCoT2k+m9rCJBiizpD8MHPA1Orh572D24ZCMB0nfbQcfTvPf6qavAdwLvTi77pNRJIT/r/0GJY+ebVYUIT/aO0QAUgRJfFvVSFQ83qK2UIsV6mWkg/1nNlNG+1AV7zrj2nELCMWnThFPJ8Uz9/OxGTKMGw77IwZbbxbCIj3/07wIIqdYcajgdUWXQhRg3fMa7IDGufl+npvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774924410; c=relaxed/relaxed;
	bh=tXnoXdsCfrRJIV0wYOapfhkujkbGnGY6+9PWosfQ1rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFWTL84oCpXfqaezs0q1Mr6P5myDnnAA0X/g1esaAaduW/0mQo7W2teJDWxpRBdOcpzGXyTgZBWCIzkmSYDIBHCbug0Oe2oZjcmdT3dr0DSHp/vDvmuTX/C7lKpvgjL/ZetArPOsjXS7CKUpPhsEEPAsRGGZlgFmpR9g806aK0DcAhNPGHLexj2x+I4v7EpjDBaeIIEOFTMkHOwuXGg/NRgg3WogdrzFigOPjjdzfRYfN01Ep1AHy7a517N/lJ3LXg5qCuln743XRHazx95CH2dyRxkLazZyEcSJE5z7xUPnDV7NOZvFlidm4pDzI06vrObP/Dip7WtmjcNeH5+D2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fuvelrGQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fuvelrGQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flBxg5l4zz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 13:33:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774924403; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tXnoXdsCfrRJIV0wYOapfhkujkbGnGY6+9PWosfQ1rs=;
	b=fuvelrGQLuVloaXLGg5qCUpSKvPadl9ILsLdz61x2ledPeP6tekMEfddP4d0Zk2Q+PhQ2MSSTgjnrKTaVs6pDgEkvCP9A7rlx8fyiyRmLGh/i8z/KQytbavGhL0YQFJQ/GMFGzq277LZ8zVaj6ppfiXHTvCkO5o0mK3pBlLKlQM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X02iV9x_1774924401;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X02iV9x_1774924401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 10:33:22 +0800
Message-ID: <794b4d71-6bba-4bbd-8720-a98a82f7ddc5@linux.alibaba.com>
Date: Tue, 31 Mar 2026 10:33:21 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 experimental-tests] erofs-utils: tests: test FUSE error
 handling on corrupted inodes
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, newajay.11r@gmail.com, xiang@kernel.org
References: <20260330042801.78385-1-nithurshen.dev@gmail.com>
 <20260330103051.26877-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260330103051.26877-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3130-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D9AC13637B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/30 18:30, Nithurshen wrote:
> This patch introduces a regression test (erofs/099) to verify that
> the FUSE daemon gracefully handles corrupted inodes without crashing
> or violating the FUSE protocol.
> 
> Recently, a bug was identified where erofs_read_inode_from_disk()
> would fail, but erofsfuse_getattr() lacked a return statement
> after sending an error reply. This caused a fall-through, sending
> a second reply via fuse_reply_attr() and triggering a libfuse
> segmentation fault.
> 
> To prevent future regressions, this test:
> 1. Creates a valid EROFS image.
> 2. Surgically corrupts the root inode (injecting random data at
>     offset 1152) while leaving the superblock intact so it mounts.
> 3. Mounts the image in the foreground to capture daemon stderr.
> 4. Runs 'stat' to trigger the inode read failure.
> 5. Evaluates the stderr log to ensure no segfaults, aborts, or
>     "multiple replies" warnings are emitted by libfuse.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
> Changes in v2:
> - Added $FSTYP check to ensure the test is skipped when testing the
>    kernel driver (Gao Xiang).
> - Renamed cleanup() to _cleanup() to align with standard rc teardown.
> ---
>   tests/Makefile.am   |  3 ++
>   tests/erofs/099     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/erofs/099.out |  2 +
>   3 files changed, 95 insertions(+)
>   create mode 100755 tests/erofs/099
>   create mode 100644 tests/erofs/099.out
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index e376d6a..c0f117c 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -122,6 +122,9 @@ TESTS += erofs/027
>   # 028 - test inode page cache sharing functionality
>   TESTS += erofs/028
>   
> +# 099 - test fuse error handling on truncated images
> +TESTS += erofs/099
> +
>   EXTRA_DIST = common/rc erofs
>   
>   clean-local: clean-local-check
> diff --git a/tests/erofs/099 b/tests/erofs/099
> new file mode 100755
> index 0000000..11dab4d
> --- /dev/null
> +++ b/tests/erofs/099
> @@ -0,0 +1,90 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Test FUSE daemon and kernel error handling on corrupted inodes
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
> +
> +# get standard environment, filters and checks
> +. "${srcdir}/common/rc"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	# Ensure we kill our background daemon if it's still alive
> +	[ -n "$fuse_pid" ] && kill -9 $fuse_pid 2>/dev/null
> +}
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +echo "QA output created by $seq"
> +
> +# Default to erofs (kernel) if FSTYP is not set
> +[ -z "$FSTYP" ] && FSTYP="erofs"
> +
> +if [ -z "$SCRATCH_DEV" ]; then
> +	SCRATCH_DEV=$tmp/erofs_$seq.img
> +	rm -f $SCRATCH_DEV
> +fi
> +
> +localdir="$tmp/$seq"
> +rm -rf $localdir
> +mkdir -p $localdir
> +
> +echo "test data" > $localdir/testfile
> +
> +_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"

You need to disable superblock checksum using:

_scratch_mkfs -Enosbcrc $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"


> +
> +# Corrupt the root inode to force erofs_read_inode_from_disk to fail.
> +# The EROFS superblock is at offset 1024 and is 128 bytes long.
> +# The metadata (including the root inode) starts immediately after (offset 1152).

I think a better way is to use `dump.erofs` to get the NID, and use
meta_blkaddr * block_size + NID * 32 to calculate the inode offset:
for example:

$EROFSDUMP_PROG --path=/testfile $SCRATCH_DEV
...

> +# We inject 1024 bytes of random garbage starting at offset 1152. This leaves
> +# the SB intact so the mount succeeds, but guarantees the inode read will fail.
> +dd if=/dev/urandom of=$SCRATCH_DEV bs=1 seek=1152 count=1024 conv=notrunc >> $seqres.full 2>&1
> +
> +if [ "$FSTYP" = "erofsfuse" ]; then
> +	[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
> +	# Run erofsfuse in the foreground to capture libfuse's internal stderr
> +	$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/fuse_err.log 2>&1 &
> +	fuse_pid=$!
> +	# Wait for the mount to establish
> +	sleep 1
> +else
> +	_require_erofs
> +	_scratch_mount >> $seqres.full 2>&1
> +fi
> +
> +# Attempt to stat the root directory. We expect this to fail with an error.
> +timeout 5 stat $SCRATCH_MNT >> $seqres.full 2>&1
> +res=$?
> +
> +if [ "$FSTYP" = "erofsfuse" ]; then
> +	# Clean up the mount
> +	umount $SCRATCH_MNT >> $seqres.full 2>&1

Can you use `_scratch_unmount`? Does that work?

> +	# Wait for the daemon to cleanly exit, or kill it if stuck
> +	kill $fuse_pid 2>/dev/null
> +	wait $fuse_pid 2>/dev/null
> +	cat $tmp/fuse_err.log >> $seqres.full
> +
> +	# Evaluate results based on captured stderr and timeout
> +	if [ $res -eq 124 ]; then
> +		_fail "stat command timed out (FUSE daemon likely hung due to double reply)"
> +	elif grep -q -i "multiple replies" $tmp/fuse_err.log; then
> +		_fail "Bug detected: libfuse reported multiple replies to request"
> +	elif grep -q -i "segmentation fault\|aborted" $tmp/fuse_err.log; then
> +		_fail "Bug detected: FUSE daemon crashed"
> +	fi
> +else
> +	# Kernel check: ensure no hang and error is returned
> +	[ $res -eq 124 ] && _fail "stat command timed out (kernel hung?)"
> +	[ $res -eq 0 ] && _fail "stat unexpectedly succeeded on a corrupted image"
> +	_scratch_unmount >> $seqres.full 2>&1
> +fi
> +
> +echo Silence is golden
> +status=0
> +exit 0
> \ No newline at end of file

Need a new line here.

Thanks,
Gao Xiang

