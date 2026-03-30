Return-Path: <linux-erofs+bounces-3100-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAmdMH4NymmL4gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3100-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:43:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04744355A9A
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:43:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkgCG1GGkz2xpt;
	Mon, 30 Mar 2026 16:43:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774849402;
	cv=none; b=cFqpBODaWbppfnfUxUWQvN614gw9sTYFmhoSxc93kVg2lLCA6JetdE7Tl3IfxW+ETczImMq9x68eSKBF+dR0gYF0pwj5A9NCpyIlf5KqsIEn1Hb18z1ByWHmantJ1Bm05nv57CoKi+/IU4m3UN5MHWYoGM9TMyukti+22R14HsdQQ4etA9ezEtfQa3Av/KCpWdpIC1mzZz7UThk4H7VNKQaxzyJ5LoP/IlZt1LIrITwJXnFVJhX60AwpeEr5My7BFsM++7X8L14EmUkUegp/oKLzXJ5GlMksXzSg5MwiS6W6wxZY9de8gWjxeML/a7W78dUD5Dwk1IWo70g7Lj/+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774849402; c=relaxed/relaxed;
	bh=BxMQKC6zaLOpwahiWD7u3XDlf8WTDewmUscIa5Hro6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw1wVdgHHkUKBABUsSp2kZlTdFxpAR9YoD3D+Q0P2vyuVSohDUqDGEHZbaScmV5ldGProbi7IXjMx2IelxX5CI/0MqunbXm0WBy0Xiuz4E6S2fGKrCTjbX7VnC/ec3/0mCFk0JkVbVerjeFoWzbt2XWa3kmdY2WL4o+oh5J4HIC/z+C7rHIxYunXCO282YECivohoGk7ZnnUPkY7D/fs0Rrmm/GVsrbz8y3JYcf4COOeko9yZ7V1pAK92mlar/m+0MOJIkYNmGrq1eJbhm+EB+eYf88JJ7jpMxZCmX4NjZt/GZtWliEa1KrrKINDqrHNwMxpGs63Zwu2ki+wrVe4Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiGzBV3E; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiGzBV3E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkgCC53V9z2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:43:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774849393; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BxMQKC6zaLOpwahiWD7u3XDlf8WTDewmUscIa5Hro6Y=;
	b=qiGzBV3E4+C235iXEkxoVx5gk4v/Lme/JCidQrI84WaXwXaAek6sS+iORBKj63BOJBaaQSLlsBbJnosfSLyVih553mFWNH9jlSLLk3Hwu/G8aaPgtd/LAW6+uE1ZvPjZGTAzhvYEMqMtXcd7rClse+Nd0pOhO4rynDn0M+DMS30=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.uNxsG_1774849391;
Received: from 30.221.131.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.uNxsG_1774849391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 13:43:13 +0800
Message-ID: <0e7b2ad8-91a6-420f-8da6-cbd95b186abd@linux.alibaba.com>
Date: Mon, 30 Mar 2026 13:43:12 +0800
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
Subject: Re: [PATCH experimental-tests] erofs-utils: tests: test FUSE error
 handling on corrupted inodes
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, newajay.11r@gmail.com
References: <20260330042801.78385-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260330042801.78385-1-nithurshen.dev@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3100-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay.11r@gmail.com,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 04744355A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/30 12:28, Nithurshen wrote:
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
>   tests/Makefile.am   |  3 ++
>   tests/erofs/099     | 76 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/erofs/099.out |  2 ++
>   3 files changed, 81 insertions(+)
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
> index 0000000..952bdbd
> --- /dev/null
> +++ b/tests/erofs/099
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Test FUSE daemon error handling on corrupted inodes (missing return fix)
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
> +
> +# get standard environment, filters and checks
> +. "${srcdir}/common/rc"
> +
> +cleanup()
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
> +[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
> +
> +if [ -z $SCRATCH_DEV ]; then
> +	SCRATCH_DEV=$tmp/erofs_$seq.img
> +	rm -f SCRATCH_DEV
> +fi
> +
> +localdir="$tmp/$seq"
> +rm -rf $localdir
> +mkdir -p $localdir
> +
> +echo "test data" > $localdir/testfile
> +
> +_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
> +
> +# Corrupt the root inode to force erofs_read_inode_from_disk to fail.
> +dd if=/dev/urandom of=$SCRATCH_DEV bs=1 seek=1152 count=1024 conv=notrunc >> $seqres.full 2>&1
> +
> +# Bypass _scratch_mount to run erofsfuse in the foreground (-f)
> +# This lets us capture libfuse's internal stderr warnings.
> +$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/fuse_err.log 2>&1 &

If this testcase is erofsfuse-specific, we should
check FSTYP="erofsfuse" instead, otherwise this
case should be skiped.

Otherwise if this test case can test the kernel
as well, we should make the kernel tested too.

Thanks,
Gao Xiang

