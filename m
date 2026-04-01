Return-Path: <linux-erofs+bounces-3155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KBsIPXRzGlFWwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 10:06:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C3376792
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 10:06:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flyH46KBKz2ySY;
	Wed, 01 Apr 2026 19:06:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775030768;
	cv=none; b=PZSIyiQA73cIdXi3EgNJXSaaHtALpKyppdozQxAsGVIVkolJ44bmvFEOeedxxk6PXf3L7SP21FLHmDR1y5W1izKyq1YF7QfM+WLwXqvSj2aGHrkhTNqWNp0sq1DUtrf3IYF5ve8q1AZHBu1wneIFy7Vm8V7WJ+36pI0Tdp1da+ijA7QCWyIzZMqJL2cOCtC/aPIxYDyzx11bzvrEaZibCq6kkauN4mwQjq091A7dHPjJeF8pYYvWjvHsFQkfxoTmh2Hpw0vnEq9SZFRHvWrxsmIO3dlXFWOyOi+F6V6oencjxl58FFZarQEn/1Y8OO4+njJ/EPkuPksriSkx8NEi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775030768; c=relaxed/relaxed;
	bh=jf3OZbamsNsJPXVOncA7a1jMXpULi79gpLAvkZhh9Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwGoQ3XUhOCXEj/77sLJHhJlxsBVEe+wRYPlgJl6JK7tZO5dKPQgzkEm+GwXupmoaz9blFIzthVukzm0BpQ1g+wjiRpdRLqfQvrtucOF2zp6KCjUqKkjNP94BrQoezdxIN80pE5qcd8hIGej1Er6ZoQZtOJ8WqhMvQwjVJhmC0xkMC8Pb40aTBDf4CjIwlQ/AIwbHJDM0gjpR2nOkFmPxJtuH02431HgvvpoCOUtSiqNlVcM+zKXz2VahAxAVVJiy5blrU27WputsW76U+VQ534p5/mi/15lfroA5tLlm1sHBQmaQa7gGmypgZCNXgym40/hh4TDDxPtGaue2xi3CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cyx4bDTK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cyx4bDTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flyH23N6Lz2xpk
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 19:06:04 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775030760; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jf3OZbamsNsJPXVOncA7a1jMXpULi79gpLAvkZhh9Dk=;
	b=cyx4bDTKc59SIePyDHx+6CCLxvLbrkWfnj5bggr9ZRRpvbKQk/vk3A25iWS548cYNTkS7yFaiCRru2+uItczwYVHjFzwIe5163Ux/+rU6SQ6xGMN5UneSwjZMeQaZLAk0hpNncTD+VQpXzoP7UzXummYSbGsqpuhirs0Dt4Xu+U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X09T4Vm_1775030759;
Received: from 30.221.131.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X09T4Vm_1775030759 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Apr 2026 16:05:59 +0800
Message-ID: <eedeb2dd-4ee0-4ef9-a672-e0f8758faa2c@linux.alibaba.com>
Date: Wed, 1 Apr 2026 16:05:58 +0800
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
Subject: Re: [PATCH v4 experimental-tests] erofs-utils: tests: test FUSE error
 handling on corrupted inodes
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, newajay.11r@gmail.com, xiang@kernel.org
References: <20260401071018.86191-1-nithurshen.dev@gmail.com>
 <20260401075504.88389-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260401075504.88389-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3155-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 986C3376792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/1 15:55, Nithurshen wrote:
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
> Changes in v4:
> - Corrected the commit message and notes to accurately match the
>    code submitted (v3 accidentally included a draft message that
>    did not match the diff).
> 
> Changes in v3:
> - Disabled superblock checksums using `-Enosbcrc` in _scratch_mkfs.
> - Used `_scratch_unmount` instead of standard `umount`.
> 
> Note regarding the corruption method:
> My apologies for the confusion in v3. The email described
> using `dump.erofs` and `0xFF`, but the patch contained my code
> using the hardcoded offset 1152 and `/dev/urandom`. I am resending
> the patch as v4 so the commit message accurately reflects the code.
> 
> I originally kept the hardcoded root offset (1152) because targeting
> `/testfile` dynamically with `/dev/urandom` was slightly flaky. If
> the random bytes happened to form a valid-looking layout, the bug
> was bypassed. Wiping 1024 bytes at offset 1152 reliably destroys the
> root metadata and guarantees the bug triggers 100% of the time.
> 
> Is this hardcoded offset approach acceptable for this specific test?
> If you strictly prefer the `dump.erofs` approach (using 0xFF instead
> of urandom to guarantee the error), please let me know and I will
> gladly send those updates in a v5 patch.

Are we still miscommunicating? I asked using `dump.erofs` for many
many times but you still send those useless patches?

Is it hard to understand? No hardcode offset please.

Thanks,
Gao Xiang

