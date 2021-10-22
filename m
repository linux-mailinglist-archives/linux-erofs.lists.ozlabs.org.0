Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8944374B7
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 11:29:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbJvM5xfsz3c9C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 20:29:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=YagujkB3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=212.227.15.18; helo=mout.gmx.net;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=YagujkB3; 
 dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at boromir;
 Fri, 22 Oct 2021 20:28:58 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbJvG2cYMz2ymc
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 20:28:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1634894931;
 bh=wYE5icMGjlbxqUC5vNAl8WPiRJIK0GBgDoDvJbZLhoM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=YagujkB3FDWzAPRZpt1QHj+qDt2rPY2sv2GWRYE0Bg/3JFXS//871RFb5sgElbnIZ
 WIN4ysvevf/vh4vrsbRtMc0mGRhyc+AagRmBV4taMFcgZUbpsfU+jUhqw1gda+DqZY
 +JkIzDpIPEOFkM/QXZ9N/LXDRd2j1P62yRO/9hlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1mE6g70IXW-00S3VI; Fri, 22
 Oct 2021 11:22:37 +0200
Message-ID: <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
Date: Fri, 22 Oct 2021 17:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Readahead for compressed data
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Phillip Susi <phill@thesusis.net>,
 linux-ntfs-dev@lists.sourceforge.net, Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net> <20211022084127.GA1026@quack2.suse.cz>
 <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dm44L66HxZZOvJluzMF4iV9LIJ3EEb9YYGAOwv/YTcc29C93Oa8
 7KnlE2MPl5pfyoJD36N8kmOjeqjj/MpmWbl2IXs3ugp+GogwlG7LLWpfllDVb2bJzUgSjGJ
 U7EozDK5tBZnCu2+1dfjirOPJkP+aIl9u9A0d9s9C1WxWZMltcnqp9oBdgTsGS5P3cDjHNH
 bbmR1YSQ/OF2k5E2mR6oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cURxHrmA3ew=:3RETLVo4L07xhRx70HIViv
 tUPqjims+o6Oj1n+kcIqjln0cVlfpoNy/koBUVrA53rQun5vQWPeX1W9krzwCP3EGH5btKfRT
 EvPnp5FpD5XhF12iD5LHQttgiI+j4E2gGHautoEqN5oVRPlLLZTHQQgWnAfmTaLM0P1A4L6q6
 CTKBr10uPfzp4meXJhSwBZRcN1sWXT49N++G+paq2kkFA4Gtgu1RB8dudVkr6LB+4jsq6NQqt
 +EaxNvFZMhFyOAMRRh6LZcPdCANpw66Hpq2QJq2YPj6RtHd9NcLk5CkFXFtkSLk7VlTnC5ZCg
 TnSsPh/+qQaMsyh2XUs2oGCUU3eQzb3LOIJiHczHg0Xr3qgc4+vgURRZkkU1u6OP2lE2i96fp
 WDicPF4bwka28KABFhUxvjFaHUF1miIfLGJEWKd/HaQUfmGPD8L6Q+cLFI4SIekB6qWT7kw0d
 Di2nVFfpqGlpOHS458QS3buFbUHBMlaIUdUVVRsDCpNlugp+P9Cd9SNhcnNBaOeF/cm5G2NnR
 1yq17v3dbh/xYGceKJZsHqsNpTkafQfm/eG5QfrQsgzdO6qHTNjLnY69UABkLyV9/rPGQNDi8
 MDVE6+05Xa1TWFyIao6uD0wFNgglhN6I9MRJvry9SR1RmrK6hu89xwf2pAP0cZ6nE8jr8D1Bl
 noWcz/FZY87MduRZJKQdF9KSWJqtIMLEgVkP0/jKtkdSFKCWQ3EsxVehpjAWs7jlyPls0F2d/
 hlXobWCumZ0Zmug4lELUpuE+TyNkyqP+b58OOgzBoWcg51TwXnJQ/aQY4suJl5ZL/bRbYwj7n
 Y6Jo0yXZ4FQm6dABA/QwL6StzOJSx4DoBjXuC808Sz0jB+Fw+BmFE5QFyO7jbGZ2Ga4mLjSRK
 YIsR3XHUWZW65FPNs1sV/hSXCSJqaM0yWP4vvTYnqSb5eXjfxmQIDmo4KdvkQ9jybKOzb+LVT
 bUaXUVA19BWPITumZjCAbvr7v6Aqxgha6A/hE6qlh3cgp0On0EeHHQOQ+vp+xTBKLOPcibngF
 Uz6iGZOzJIHbxeqP5Hv1hhzdTDr8/UAWSdJDeG+QoJ/w29MP8w+pyrYZum39N9vc90Wz3Z3P5
 jDvojPV7oPTjrc=
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/10/22 17:11, Gao Xiang wrote:
> On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
>> On Thu 21-10-21 21:04:45, Phillip Susi wrote:
>>>
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>
>>>> As far as I can tell, the following filesystems support compressed da=
ta:
>>>>
>>>> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>>>>
>>>> I'd like to make it easier and more efficient for filesystems to
>>>> implement compressed data.  There are a lot of approaches in use toda=
y,
>>>> but none of them seem quite right to me.  I'm going to lay out a few
>>>> design considerations next and then propose a solution.  Feel free to
>>>> tell me I've got the constraints wrong, or suggest alternative soluti=
ons.
>>>>
>>>> When we call ->readahead from the VFS, the VFS has decided which page=
s
>>>> are going to be the most useful to bring in, but it doesn't know how
>>>> pages are bundled together into blocks.  As I've learned from talking=
 to
>>>> Gao Xiang, sometimes the filesystem doesn't know either, so this isn'=
t
>>>> something we can teach the VFS.
>>>>
>>>> We (David) added readahead_expand() recently to let the filesystem
>>>> opportunistically add pages to the page cache "around" the area reque=
sted
>>>> by the VFS.  That reduces the number of times the filesystem has to
>>>> decompress the same block.  But it can fail (due to memory allocation
>>>> failures or pages already being present in the cache).  So filesystem=
s
>>>> still have to implement some kind of fallback.
>>>
>>> Wouldn't it be better to keep the *compressed* data in the cache and
>>> decompress it multiple times if needed rather than decompress it once
>>> and cache the decompressed data?  You would use more CPU time
>>> decompressing multiple times, but be able to cache more data and avoid
>>> more disk IO, which is generally far slower than the CPU can decompres=
s
>>> the data.
>>
>> Well, one of the problems with keeping compressed data is that for mmap=
(2)
>> you have to have pages decompressed so that CPU can access them. So kee=
ping
>> compressed data in the page cache would add a bunch of complexity. That
>> being said keeping compressed data cached somewhere else than in the pa=
ge
>> cache may certainly me worth it and then just filling page cache on dem=
and
>> from this data...
>
> It can be cached with a special internal inode, so no need to take
> care of the memory reclaim or migration by yourself.

There is another problem for btrfs (and maybe other fses).

Btrfs can refer to part of the uncompressed data extent.

Thus we could have the following cases:

	0	4K	8K	12K
	|	|	|	|
		    |	    \- 4K of an 128K compressed extent,
		    |		compressed size is 16K
		    \- 4K of an 64K compressed extent,
			compressed size is 8K

In above case, we really only need 8K for page cache, but if we're
caching the compressed extent, it will take extra 24K.

It's definitely not really worthy for this particular corner case.

But it would be pretty common for btrfs, as CoW on compressed data can
easily lead to above cases.

Thanks,
Qu

>
> Otherwise, these all need to be take care of. For fixed-sized input
> compression, since they are reclaimed in page unit, so it won't be
> quite friendly since such data is all coupling. But for fixed-sized
> output compression, it's quite natural.
>
> Thanks,
> Gao Xiang
>
>>
>> 								Honza
>> --
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
