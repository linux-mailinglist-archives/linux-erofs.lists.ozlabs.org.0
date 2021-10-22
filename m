Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D74375A6
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 12:46:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbLcZ6VHkz3c9w
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 21:46:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=H1uDU2dU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=212.227.17.20; helo=mout.gmx.net;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=H1uDU2dU; 
 dkim-atps=neutral
X-Greylist: delayed 328 seconds by postgrey-1.36 at boromir;
 Fri, 22 Oct 2021 21:46:15 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbLcR5sZZz3brX
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 21:46:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1634899568;
 bh=P3pL0z5U1lr82ILvj/7RspKnruMijC05DS94G9TQaDc=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=H1uDU2dU/kIzKcIjjz0LTnc1TYBt7y26RfDuTF7ERc1CJS7vFcCOuyS9snadU0qZN
 Jcal7kaoXvLgB2UUrAsDMjCqhPMCQrT4BOM1KaKDKpbDkSujxSAtI5M8tNwuy1MPqm
 r2o7c+3QlJMGhd+9tUN2sIWg05yyB1aDHkmm+JaU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1mTiZK0V7H-00HMcZ; Fri, 22
 Oct 2021 12:40:09 +0200
Message-ID: <93e4eccb-d839-0e8e-4b87-1964232a0458@gmx.com>
Date: Fri, 22 Oct 2021 18:40:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
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
 <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
 <YXKG0V99Ph9KhDyg@B-P7TQMD6M-0146.local>
 <YXKKOx6OX1LzLShe@B-P7TQMD6M-0146.local>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Readahead for compressed data
In-Reply-To: <YXKKOx6OX1LzLShe@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XaNW1n6QiLwbDcJuGYG2KuaxcGS/lNhVqz994mJdjFhdak8XHNx
 P3uHq1BxPePF5ZPfY0V9Oold01NUP2jZWnLdXeW+LI1ea267R3os6v1Z4HwnrzGq5dFbDoG
 4FlctrJUAemI8gI2DiXrq9CWZ5Zf9Fg2IZv2SetOd+Ra+P7ecZN4tfG2+gsQlvsbZVIzoA4
 bBghD2DLCCzez9t2IiRgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MGULd1DtJsE=:HGBi0FhRkP3Itb7+G4KIGx
 S+fOW+nEm2SCQPQJ+67XCPY+ksYkR3KjYC0B+U221s6OCBpAGssb7Ze923WbhJz8WkgRYy3CB
 8trZyTol387fUD4ZAgCze0qs1uitTstsSowU+rJ2FzBBD+gLgnG85zs03Ur9tME+ooH7SyXgs
 7lL6RE3/smPWTWFByxw+oWwKTvT/xoBd4vgdEmLL2ci+1eE/3PJ4CfAatLAsO35Uq5t18SiYO
 LYX4ktheiUjupjTkM9AmnP0g0olrJkCO/Zl6+6Xk+Eol+tGvjFpUuI5zZxWFGfqMwS7e7zYOC
 UN5p4whR8z5A3EX64YqM5U1pNu9vXi9/3n4MRbVxqHB0JZf4wK/iuTtXXkLSClSb3GjoIOeec
 jNIh0EQHATNkzZ73sh73Y3uuJ7//3sQAfZJMM7OBcvDXoQhYpF23/HE89WVXY2ydMLpNpfxjs
 ScNSM1npyudiQgSeB10bt77ZYtJDP9nlCW0c34WNH8UhNh8Ix91RviE+VfSoG+XBvOq4+Fy+v
 M1p684fwTbI0sQXX2pjTip9JnzyFKnGjXKHAKHWLhlT4ffhtR3BV380At/GCugA0e8svMR16D
 tm9dJOj9osefud2CHDIULt92+zKNG6+avlwZXxADWUKhUidfw/Lsx5YByPpPaPaIjQpw2hFIQ
 WVXyecveNE/bwivGupkj0SXB//OI9NDk5xa0rvrsyfCxnvC4C3xX/ozDyDSVtUVUQN0qwg8Gm
 XCVqDDzlDAeg/P4ma1mIDyDJved0K6zpKQvd+w+01o3eISU4nPVehXKTQFbO4CC8QS3NH1NOW
 /fSir+YZHcxY8KxBMsWAAaJuBcDS/Dt/VGly8gZbk8zEETbDaJqcSHAts4VoN9RpNVq6vrAzc
 gmsdWe4qOqZSu/NhVoRMUHvDKMzy3AsMDyLZXj/1dOfZpKsXDZ9x6rQPf4FO//XWMjNN8GDrH
 swiT6FdV3rulwQrTe7eOEM5r3TsEsUD0G87BtRmHUGA4uV9aM19XrNCVFWgiw4ganG3vvI3yj
 UPuHnnTkXp3dM6U+LHl3qIHhNd7mXqm2KweN7Ghmm7Z7WSsiveKJo9yARKOiaMn+vWnlRW0J4
 fS+tIK1r4heq8k=
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



On 2021/10/22 17:54, Gao Xiang wrote:
> On Fri, Oct 22, 2021 at 05:39:29PM +0800, Gao Xiang wrote:
>> Hi Qu,
>>
>> On Fri, Oct 22, 2021 at 05:22:28PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/10/22 17:11, Gao Xiang wrote:
>>>> On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
>>>>> On Thu 21-10-21 21:04:45, Phillip Susi wrote:
>>>>>>
>>>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>>>
>>>>>>> As far as I can tell, the following filesystems support compressed=
 data:
>>>>>>>
>>>>>>> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>>>>>>>
>>>>>>> I'd like to make it easier and more efficient for filesystems to
>>>>>>> implement compressed data.  There are a lot of approaches in use t=
oday,
>>>>>>> but none of them seem quite right to me.  I'm going to lay out a f=
ew
>>>>>>> design considerations next and then propose a solution.  Feel free=
 to
>>>>>>> tell me I've got the constraints wrong, or suggest alternative sol=
utions.
>>>>>>>
>>>>>>> When we call ->readahead from the VFS, the VFS has decided which p=
ages
>>>>>>> are going to be the most useful to bring in, but it doesn't know h=
ow
>>>>>>> pages are bundled together into blocks.  As I've learned from talk=
ing to
>>>>>>> Gao Xiang, sometimes the filesystem doesn't know either, so this i=
sn't
>>>>>>> something we can teach the VFS.
>>>>>>>
>>>>>>> We (David) added readahead_expand() recently to let the filesystem
>>>>>>> opportunistically add pages to the page cache "around" the area re=
quested
>>>>>>> by the VFS.  That reduces the number of times the filesystem has t=
o
>>>>>>> decompress the same block.  But it can fail (due to memory allocat=
ion
>>>>>>> failures or pages already being present in the cache).  So filesys=
tems
>>>>>>> still have to implement some kind of fallback.
>>>>>>
>>>>>> Wouldn't it be better to keep the *compressed* data in the cache an=
d
>>>>>> decompress it multiple times if needed rather than decompress it on=
ce
>>>>>> and cache the decompressed data?  You would use more CPU time
>>>>>> decompressing multiple times, but be able to cache more data and av=
oid
>>>>>> more disk IO, which is generally far slower than the CPU can decomp=
ress
>>>>>> the data.
>>>>>
>>>>> Well, one of the problems with keeping compressed data is that for m=
map(2)
>>>>> you have to have pages decompressed so that CPU can access them. So =
keeping
>>>>> compressed data in the page cache would add a bunch of complexity. T=
hat
>>>>> being said keeping compressed data cached somewhere else than in the=
 page
>>>>> cache may certainly me worth it and then just filling page cache on =
demand
>>>>> from this data...
>>>>
>>>> It can be cached with a special internal inode, so no need to take
>>>> care of the memory reclaim or migration by yourself.
>>>
>>> There is another problem for btrfs (and maybe other fses).
>>>
>>> Btrfs can refer to part of the uncompressed data extent.
>>>
>>> Thus we could have the following cases:
>>>
>>> 	0	4K	8K	12K
>>> 	|	|	|	|
>>> 		    |	    \- 4K of an 128K compressed extent,
>>> 		    |		compressed size is 16K
>>> 		    \- 4K of an 64K compressed extent,
>>> 			compressed size is 8K
>>
>> Thanks for this, but the diagram is broken on my side.
>> Could you help fix this?
>
> Ok, I understand it. I think here is really a strategy problem
> out of CoW, since only 2*4K is needed, you could
>   1) cache the whole compressed extent and hope they can be accessed
>      later, so no I/O later at all;
>   2) don't cache such incomplete compressed extents;
>   3) add some trace record and do some finer strategy.

Yeah, this should be determined by each fs, like whether they want to
cache compressed extent at all, and at which condition to cache
compressed extent.

(e.g. for btrfs, if we find the range we want is even smaller than the
compressed size, we can skip such cache)

Thus I don't think there would be a silver bullet for such case.

>
>>
>>>
>>> In above case, we really only need 8K for page cache, but if we're
>>> caching the compressed extent, it will take extra 24K.
>>
>> Apart from that, with my wild guess, could we cache whatever the
>> real I/O is rather than the whole compressed extent unconditionally?
>> If the whole compressed extent is needed then, we could check if
>> it's all available in cache, or read the rest instead?
>>
>> Also, I think no need to cache uncompressed COW data...

Yeah, that's definitely the case, as page cache is already doing the
work for us.

Thanks,
Qu

>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> It's definitely not really worthy for this particular corner case.
>>>
>>> But it would be pretty common for btrfs, as CoW on compressed data can
>>> easily lead to above cases.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Otherwise, these all need to be take care of. For fixed-sized input
>>>> compression, since they are reclaimed in page unit, so it won't be
>>>> quite friendly since such data is all coupling. But for fixed-sized
>>>> output compression, it's quite natural.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> 								Honza
>>>>> --
>>>>> Jan Kara <jack@suse.com>
>>>>> SUSE Labs, CR
