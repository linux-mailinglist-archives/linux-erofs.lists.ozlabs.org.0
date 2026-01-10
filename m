Return-Path: <linux-erofs+bounces-1809-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BCD0D4C6
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 11:30:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpFJl5n0Zz2y8c;
	Sat, 10 Jan 2026 21:30:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768041015;
	cv=none; b=hM61oeG4HFAtjx7KEHhQLvxn0pkgejWa9h9T5jQHkdibOJsBC+htB5P/cqRn2WxM3rrYmkqWat18Pq5r/IJh3LF9rjig7L0QF7EFb8dbvP+Z6U5zACjkusziUeeujeKmJpEInX/+SB2GBJUvGvk6Jtmnq/rLgiNEriWjxQAfRHnuhYQVkPKuIew8DqTSiRcvuAxm3x6aKpxu6zXoyWioAsX1MZIGKGdwKJAfZ4FFRF+FfMl1CsD+CDlqlRvD7ag/8xIuZch7MwFumJnJK2jPm6dhDWqmycUBkDmm7M29U9RR/pPEdC+hPm/yCNbEhoDJKBK0m0EHOK8WHEHNQiwHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768041015; c=relaxed/relaxed;
	bh=Aq+A9PyioO73SBRkgOtyvMmH4oU0csKSwRhh/v2cmJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gABTkNrnBHxj6xCQXbMd/E1DgmEW6dBQriRXpc8SCbdXlQjLeA0Px30AXFq7VqDGzhO7+i9Yf347v9dGWTWVHw1Rid7fqgzi1f3irb6JJw2N8k24Jq8EzKVXwsV75Kzdht+YRnPbLsRj1Sz4m19hrVSIHZqmJS4O6/kHFmlwEjc3pMKaH7xDW6w6A/wSpoVlr6IbxIKlcI8I/KMzoVRxvimyV6XGc5SJ3qeXvP0MO1YEo2rjJxMokHs9y/shoa6nRUBw5Ki6rVPRp/zfkRryxy0gaXqqxB61wI+vICJiHWPkOSOoLPOxblR9IPaY+k2z1sAKBz0UPb5FL55vhc4T/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZLh7Ooez; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZLh7Ooez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpFJh0rnrz2xRv
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 21:30:09 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768041004; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Aq+A9PyioO73SBRkgOtyvMmH4oU0csKSwRhh/v2cmJs=;
	b=ZLh7OoezUGhuLAP4BJKP++GFLDalBP4bccq2Gisb/u+/TBGiXzeNnYW6kOvHt1bbPnS0O45xv4tCenVNgV0MOosnV1oT/KoIndywzLqLN9ZYeWk5n/SUUSFBKjN9yLX6BMsjKRUfQhNAhAcOl/erOqzgAid3/UvGx/ktBktgzUA=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwjdzhG_1768041001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 18:30:02 +0800
Message-ID: <9303721e-5b67-4c66-8369-61c5125b1fb1@linux.alibaba.com>
Date: Sat, 10 Jan 2026 18:30:01 +0800
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
Subject: Re: [GIT PULL] erofs fix for 6.19-rc5 (fix the stupid mistake)
To: Amir Goldstein <amir73il@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Larsson <alexl@redhat.com>, Dusty Mabe <dusty@dustymabe.com>,
 Chao Yu <chao@kernel.org>, Sheng Yong <shengyong1@xiaomi.com>,
 Zhiguo Niu <zhiguo.niu@unisoc.com>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Gao Xiang <xiang@kernel.org>
References: <aWHibOkAT18Hc/G5@debian> <aWH/dP4xD51Rqwa+@debian>
 <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Amir,

On 2026/1/10 17:50, Amir Goldstein wrote:
> On Sat, Jan 10, 2026 at 8:27 AM Gao Xiang <xiang@kernel.org> wrote:
>>
>> Hi Linus,
>>
>> Very sorry I sent an incorrect pull request which used an
>> outdated PATCH version (I just manually applied tags on the
>> incorrect version, but I didn't realize), I shouldn't make
>> the stupid mistake in the beginning.
>>
>> Someone reminded me the mistake just now.
>>
>> Could you please apply this pull request, I promise that I
>> won't make the similar fault again and I should be blamed.
>>
>> Thanks,
>> Gao Xiang
>>
>> The following changes since commit 072a7c7cdbea4f91df854ee2bb216256cd619f2a:
>>
>>    erofs: don't bother with s_stack_depth increasing for now (2026-01-10 13:01:15 +0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc5-fixes-2
>>
>> for you to fetch changes up to 0a7468a8de7a2721cc0cce30836726f2a3ac2120:
>>
>>    erofs: don't bother with s_stack_depth increasing for now [real fix] (2026-01-10 15:13:12 +0800)
>>
>> ----------------------------------------------------------------
>> Changes since last update:
>>
>>   - Revert the incorrect outdated PATCH version
>>
>>   - Apply the correct fix of
>>     "erofs: don't bother with s_stack_depth increasing for now"
>>
>> ----------------------------------------------------------------
>> Gao Xiang (2):
>>        Revert "erofs: don't bother with s_stack_depth increasing for now"
>>        erofs: don't bother with s_stack_depth increasing for now [real fix]
>>
> 
> Gao,
> 
> You merged the wrong patch version by mistake - no real harm done.

Sadly, the merged one doesn't work for Android APEX (Sheng actually
claimed that PATCH v3 RESEND works instead of PATCH v3 [I'm very sorry
for v3 RESEND mark again here] and it was him found that the merged
pull request used wrong version and he gave me a private text hours
ago), see my explanation below.

> 
> But now that it was merged, for the sake of git history, I think it would
> be better to merge a fix patch rather than revert + patch with same title.

My concern would be that people could merge incomplete patch chain,
but I'm fine to send a fix for the fix, I will do.

> 
> If you merge a fix patch you could properly attribute Report/Review/Tested-by
> to Sheng Yong [1].
> 
> It's true that the merged patch already claims to work for Android APEX,
> but it had a braino bug and this is what fix patches are for.

Sigh, the merged patch (PATCH v3) actually _breaks_ APEX (it's just
like PATCH v1/v2), because:
  		if (erofs_is_fileio_mode(sbi)) {
-			sb->s_stack_depth =
-				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
-			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-				erofs_err(sb, "maximum fs stacking depth exceeded");
+			inode = file_inode(sbi->dif0.file);
+			if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||

Here `!sb->s_bdev` is true for all file-backed mounts all the time,
so `!sb->s_bdev` equals to a no-op.

+			    inode->i_sb->s_stack_depth) {

I will make a delta patch candidate with his "Reported-by:" and
"Tested-by:", I will try to send now.

It seems I need to sleep later because my brain is exhaused,
and always screwed things up, very very sorry about that.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com/


