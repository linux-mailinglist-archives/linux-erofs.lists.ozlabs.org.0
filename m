Return-Path: <linux-erofs+bounces-3156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J6nMtLSzGlFWwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 10:09:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90D376822
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 10:09:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flyMM2cptz2ySY;
	Wed, 01 Apr 2026 19:09:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775030991;
	cv=none; b=iYLg9Ps9QW1iGBX+6utRo2yCnHgSsJ4cbBmigTvSmYfKioHS5Cp5z7EZ/OZHcntEvJpYMlIElUBjP6GkANlV9UNL+uiSFK9MQ0dlI8QOCfsUNY30sFG7Xb5q/thGQMo2NlEoREHn52C/A1Wj39zVwWOr43ruimu9V+2hwCmtn0R+1174pw+VL6H4oqXNWrmSgNzc93kjuEBeGkijK+DzJwnS4gU/XFLiiFJJ2KLVHVllDp6TYMqEFehkJh6DEuSfL9gVxREq2IIC4sI8PeWjeYcVtA/IfyC1eToFDN2gctnplWJpIp0+qypEa3aWCayy0tRZyid3XA1XenLqonBwag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775030991; c=relaxed/relaxed;
	bh=hL2T7GwSns6xmC7Qk64UwqGlsiD/T//93EJ66XppcfQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gZmKPRqkOQHfGozey3/jp912JW6C/uGa86Kovj3k1iK4uDxmqc5uNhjYoTMx2ihwfPf9PCXShJEQz+eWqzeO19bYwYjESnWjplBWbRvOxJbR0EtjfB5sHXyVrlc97KlJaRYuwFqvId1MAOtdV2ureDA2JZhNOTVnrMHh/wcvcC3jolCFnhi4mMlKKN3Y0DR6g9Hb7A3W0FGg5vD9grUduGJ3Sp4ufnuTk6Mc94ti5EIDb/RfvFjVa6unH0WkMoCoaKFVxxAmsABHmBEkN0RRFj8XybFD/iYXBvC/pG8qN0c5qeU01i/9MQEEhxmrroUysaHBXLvIDNF/sXFno3zW2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ch9ToP3P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ch9ToP3P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flyML3Ftpz2xpk
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 19:09:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775030986; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=hL2T7GwSns6xmC7Qk64UwqGlsiD/T//93EJ66XppcfQ=;
	b=ch9ToP3PJkLZd3kqf8N0njQxxmviN+7SUVsS9IAutwVNs8kQa/wqifnh+XtQ7Xwnu8SKVgh4zs+QEVpxOYShRKgo14j+DJ7AiVsRdC7Opeo4I+H6taIp30IW+Bwc86+68MBOYxBJnXQFUjtLwI4RARFsfWEL1e/h9fz8kbP0JJQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X09LXRR_1775030984;
Received: from 30.221.131.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X09LXRR_1775030984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Apr 2026 16:09:45 +0800
Message-ID: <ed42337d-a623-457c-b08f-e60886170b7e@linux.alibaba.com>
Date: Wed, 1 Apr 2026 16:09:44 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, newajay.11r@gmail.com, xiang@kernel.org
References: <20260401071018.86191-1-nithurshen.dev@gmail.com>
 <20260401075504.88389-1-nithurshen.dev@gmail.com>
 <eedeb2dd-4ee0-4ef9-a672-e0f8758faa2c@linux.alibaba.com>
In-Reply-To: <eedeb2dd-4ee0-4ef9-a672-e0f8758faa2c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-3156-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: EA90D376822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/1 16:05, Gao Xiang wrote:
> 
> 
> On 2026/4/1 15:55, Nithurshen wrote:
>> This patch introduces a regression test (erofs/099) to verify that
>> the FUSE daemon gracefully handles corrupted inodes without crashing
>> or violating the FUSE protocol.
>>
>> Recently, a bug was identified where erofs_read_inode_from_disk()
>> would fail, but erofsfuse_getattr() lacked a return statement
>> after sending an error reply. This caused a fall-through, sending
>> a second reply via fuse_reply_attr() and triggering a libfuse
>> segmentation fault.
>>
>> To prevent future regressions, this test:
>> 1. Creates a valid EROFS image.
>> 2. Surgically corrupts the root inode (injecting random data at
>>     offset 1152) while leaving the superblock intact so it mounts.
>> 3. Mounts the image in the foreground to capture daemon stderr.
>> 4. Runs 'stat' to trigger the inode read failure.
>> 5. Evaluates the stderr log to ensure no segfaults, aborts, or
>>     "multiple replies" warnings are emitted by libfuse.
>>
>> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
>> ---
>> Changes in v4:
>> - Corrected the commit message and notes to accurately match the
>>    code submitted (v3 accidentally included a draft message that
>>    did not match the diff).
>>
>> Changes in v3:
>> - Disabled superblock checksums using `-Enosbcrc` in _scratch_mkfs.
>> - Used `_scratch_unmount` instead of standard `umount`.
>>
>> Note regarding the corruption method:
>> My apologies for the confusion in v3. The email described
>> using `dump.erofs` and `0xFF`, but the patch contained my code
>> using the hardcoded offset 1152 and `/dev/urandom`. I am resending
>> the patch as v4 so the commit message accurately reflects the code.
>>
>> I originally kept the hardcoded root offset (1152) because targeting
>> `/testfile` dynamically with `/dev/urandom` was slightly flaky. If
>> the random bytes happened to form a valid-looking layout, the bug
>> was bypassed. Wiping 1024 bytes at offset 1152 reliably destroys the
>> root metadata and guarantees the bug triggers 100% of the time.
>>
>> Is this hardcoded offset approach acceptable for this specific test?
>> If you strictly prefer the `dump.erofs` approach (using 0xFF instead
>> of urandom to guarantee the error), please let me know and I will
>> gladly send those updates in a v5 patch.
> 
> Are we still miscommunicating? I asked using `dump.erofs` for many
> many times but you still send those useless patches?
> 
> Is it hard to understand? No hardcode offset please.

And why do you think /dev/urandom is a good idea? A regression test
is needed, determination is needed, why bother with /dev/urandom?

> 
> Thanks,
> Gao Xiang


