Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E31974836
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 04:27:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3PcX4Ns8z2yhg
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 12:27:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726021672;
	cv=none; b=aJvvSvnvbGBzxS16ngGaUgdBx+ZjOA04vl2m0JomW1h7jjIUpsORZOvZSFa1uJ54OuCZuBkbiO+2JoerA5G5/B1py5gYoD2g/GEoDxc7EpsFinu5XJewd8+WM0H5kDZ9fxmTaM1EYcYIid3x+1dSSsihqiJIWz4EzNNv3jAlTh7J7KnLKddAYjL6wjr/W6JFDTNTKTGK4zJN1/JPYvIapgnW8s9qFhYtfUlxoPYeJh1rUpQKppqGfqF/W9zK6iDNkVKqZwtWmYKrBmpN5I0QDXe6zgAsOfjPNzAcqTZ4pdnf3xe2OATkYpp7yYZ0yqPm8yanl2ERyZ1lKwZyn0vyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726021672; c=relaxed/relaxed;
	bh=UWMjma3Rts0LkXJu8WbmRMT3XVCO6b3DjN7/mIcP4eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjxd8zqEe94otFoQ36pofVE/X2CbYNNrCV+DbbL5Sy1lyXB5GG6CSD74RilfW5qiGbIQB6GkB0MKXkxOg3JprdFdmwDaX3BKOqL/W8IbIspI2LbfyCNQUIAfSFgfEt/Duyda0RIF59qQfxH8/qJp2cmyKWccNQJTEhUlrPLjey0KhQCkVMO1kmkt06hQfTupFOziSzOVdKIpZHb7/iQS17AQan4neX2XVgdim7n9s+KUiixe0i8gcViKwdePRDSc+8qvKjaUcPKegHk8flOE9RKdHzIZwdQ7rF8KRw9g70hvh6Gj/OkYgPPWLZ/iX1ZT2bCzJ+hSx57dT7uG27lhOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f9u9/hv+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f9u9/hv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3PcR6PXWz2y8n
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 12:27:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726021663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UWMjma3Rts0LkXJu8WbmRMT3XVCO6b3DjN7/mIcP4eo=;
	b=f9u9/hv+G7a0U+t5ckFvuwqaUl+YyIkCp7LJYZ+wSL1bHCMaL1kbv2gGO1ISU7KmqrD9NBhz/4zCqReMdI3qqYsbIf3d90/1syKKcCw5ePjbe+bk+RYZHIg9SGGPAVxM9AJDoHuaLYfPvQFaRHf8lwqBzF/BlObVnJNWV8nWqbI=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEm00X8_1726021661)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 10:27:42 +0800
Message-ID: <0e3b056a-a5f8-4203-8524-16b5fecb2ca1@linux.alibaba.com>
Date: Wed, 11 Sep 2024 10:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
 <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
 <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
 <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/11 04:51, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 10:18 PM, Gao Xiang wrote:
> 
>> I know you ask for an explicit check on symlink i_size, but
>> I've explained the current kernel behavior:
>>     - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
>>       it behaves normally for EROFS Linux implementation;
>>
>>     - For symlink i_size >= PAGE_SIZE, EROFS Linux
>>       implementation will mark '\0' at PAGE_SIZE - 1 in
>>       page_get_link() -> nd_terminate_link() so the behavior is also
>>       deterministic and not harmful to the system stability and security;
> 
> Got it, OK.
> 
>> In other words, currently i_size >= PAGE_SIZE is an undefined behavior
>> but Linux just truncates the link path.
> 
> I think where we had a miscommunication is that when I see "undefined behavior" I thought you were using the formal term: https://en.wikipedia.org/wiki/Undefined_behavior
> 
> The term for what you're talking about in my experience is usually "unspecified behavior" or "implementation defined behavior" which (assuming a reasonable implementor) would include silent truncation or an explicit error, but *not* walking off the end of a buffer and writing to arbitrary other kernel memory etc.

Yeah, agreed. "implementation defined behavior" sounds a better term.

Sorry about my limited English corpus, because the environment I'm
living mostly is used to professional terms translated in Chinese..

> 
> (Hmm really given the widespread use of nd_terminate_link I guess this is kind of more of a "Linux convention" than just an EROFS one, with XFS as a notable exception?)

I'm not sure if other kernel fses have their own internal issues
(so they need to check i_size > PAGE_SIZE to cover up their own
format design in advance), but I think (and tested with crafted
images) EROFS with pure only Linux VFS nd_terminate_link()
implementation (since 2.6.x era)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd09abbd9699f328165aee50a070403fbf55a37

is already safe on i_size > PAGE_SIZE since EROFS symlink on-disk
format is just like its regular inode format.

As for XFS, I think it's a history on-disk behavior (1024-byte
hard limitation) so they have to follow until now, see the related
commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6eb0b8df9f74f33d1a69100117630a7a87a9cc96

> 
>> For this case, to be clear I'm totally fine with the limitation,
>> but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
>> as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
>> `link[4095] == '\0'`.
> 
> Mmmm...I think PATH_MAX is conventionally taken to include the NUL; yeah see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=b40c8e7a033ff2cafd33adbe50e2a516f88fa223#n123

Agreed, but honestly I have some concern if some OS or tar format
or other popular archive formats support large symlinks but EROFS
have no way to keep them due to on-disk limitation.

If you don't have some strong opinion on this, I do hope let's
hold off our decision about this to ensure compatibility.

Thanks,
Gao Xiang
