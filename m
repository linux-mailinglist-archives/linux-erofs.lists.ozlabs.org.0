Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B701E98421A
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 11:29:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCZLx4FWnz2yjN
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 19:29:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727170166;
	cv=none; b=ghvZxRdgQ5JKawEuncFk7WoY4FxvZxQ69dryUR3LY/rr0sLwDZkYCjOG1qqtoD6ZftmjhwF2BfrGtTmx6BzAolDLxbN1h7ufGro8lUXebChM/JF9/q20UQ+Xez0733i456dLmqYqdFmxyEY3pBAt7K30HURaoI6ee4pJZGx4iG+IMhrFIvNF/mQgzaAkvp2+q4t3n6FPoOekxnyeC26AtLmffyWbpd2zZU/2WdTvjZCiRkQcIhSKlw5l7pvDLBna6qRnyAGHg7C289KU/8nRJrODtIwq23XyIR7/FCz7iJXM120wtUd9sOy8AhdrR9WhAjae8zfsexWse4Czn+7ZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727170166; c=relaxed/relaxed;
	bh=TYPCTrP9ZTx3OP31Ms8q/MZw7Vr2s+RTwZ353YzEMbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGO/z9cKgFMEmqmYtokRh/tRZ42Lwtd9nxn40SC1/lmj+g+gQ2nHcLiJKOIQ0WwX/Hn/4VDALKd55mKiMFpyuGBtba7NkYMUPBeP/oim+BxBpV0aLpXiSHqkSpleTSTE0NaS06KsTtcPoj73LibH1a5h4Tsieg1nNrV1crRP2sl7fmCXkc2houpK50Sd1yV5/D1XCcb0+jUtYwqfo5a4I1IdbtjkZGm/bG/gH4goaJqP5qD8P3OzrThHQQZewGYprkwz5L020J/GDK6BE1Z2fC/JhhTpXhUpvaekpwgnhHoPJOV2By2aEY+ufkkobXiTX0n7OBlYOqTCfzlIw/WKng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Egbbrsy9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Egbbrsy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCZLr3Fthz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 19:29:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727170156; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TYPCTrP9ZTx3OP31Ms8q/MZw7Vr2s+RTwZ353YzEMbk=;
	b=Egbbrsy9HTAnhkUwsgsUwzHQv2jECw7QAo2pu7z8OBFxhXoVmkVZlehjkVgDuZKPgBtcQXL0uGsUy7sRcmRvkDDG/qxlTvrAQLMXSxOfT0QtChKkckwry58Q/K954Z8ybUKArAOWn+uVe6pIu4x4oy+V6Bf4lc6WojsM58f05bI=
Received: from 30.221.130.48(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFfii39_1727170154)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 17:29:15 +0800
Message-ID: <34e86448-65fa-447d-b5d9-1897b2a53ff6@linux.alibaba.com>
Date: Tue, 24 Sep 2024 17:29:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Geert,

On 2024/9/24 17:21, Geert Uytterhoeven wrote:
> Hi Gao,
> 
> CC vfs
> 
> On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> It actually has been around for years: For containers and other sandbox
>> use cases, there will be thousands (and even more) of authenticated
>> (sub)images running on the same host, unlike OS images.
>>
>> Of course, all scenarios can use the same EROFS on-disk format, but
>> bdev-backed mounts just work well for OS images since golden data is
>> dumped into real block devices.  However, it's somewhat hard for
>> container runtimes to manage and isolate so many unnecessary virtual
>> block devices safely and efficiently [1]: they just look like a burden
>> to orchestrators and file-backed mounts are preferred indeed.  There
>> were already enough attempts such as Incremental FS, the original
>> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
>> for current EROFS users, ComposeFS, containerd and Android APEXs will
>> be directly benefited from it.
>>
>> On the other hand, previous experimental feature "erofs over fscache"
>> was once also intended to provide a similar solution (inspired by
>> Incremental FS discussion [2]), but the following facts show file-backed
>> mounts will be a better approach:
>>   - Fscache infrastructure has recently been moved into new Netfslib
>>     which is an unexpected dependency to EROFS really, although it
>>     originally claims "it could be used for caching other things such as
>>     ISO9660 filesystems too." [3]
>>
>>   - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>>     enhancements.  For example, the failover feature took more than
>>     one year, and the deamonless feature is still far behind now;
>>
>>   - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>>     perfectly supersede "erofs over fscache" in a simpler way since
>>     developers (mainly containerd folks) could leverage their existing
>>     caching mechanism entirely in userspace instead of strictly following
>>     the predefined in-kernel caching tree hierarchy.
>>
>> After "fanotify pre-content hooks" lands upstream to provide the same
>> functionality, "erofs over fscache" will be removed then (as an EROFS
>> internal improvement and EROFS will not have to bother with on-demand
>> fetching and/or caching improvements anymore.)
>>
>> [1] https://github.com/containers/storage/pull/2039
>> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
>> [3] https://docs.kernel.org/filesystems/caching/fscache.html
>> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>>
>> Closes: https://github.com/containers/composefs/issues/144
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks for your patch, which is now commit fb176750266a3d7f
> ("erofs: add file-backed mount support").
> 
>> ---
>> v2:
>>   - should use kill_anon_super();
>>   - add O_LARGEFILE to support large files.
>>
>>   fs/erofs/Kconfig    | 17 ++++++++++
>>   fs/erofs/data.c     | 35 ++++++++++++---------
>>   fs/erofs/inode.c    |  5 ++-
>>   fs/erofs/internal.h | 11 +++++--
>>   fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>>   5 files changed, 100 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 7dcdce660cac..1428d0530e1c 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>>
>>            If you are not using a security module, say N.
>>
>> +config EROFS_FS_BACKED_BY_FILE
>> +       bool "File-backed EROFS filesystem support"
>> +       depends on EROFS_FS
>> +       default y
> 
> I am a bit reluctant to have this default to y, without an ack from
> the VFS maintainers.

It don't touch any VFS stuffs so I didn't cc -fsdevel.

Okay, if VFS maintainers have any objection of this, I could turn
it into "default n", if not, I tend to leave it as "y" since I
believe it shouldn't be any risk of this feature (since EROFS is
only an immutable filesystem and I don't think out a context which
could be risky) with clear use cases and I've clearly documented
and showed in the commit message and upstream pull request.

Thanks,
Gao Xiang
