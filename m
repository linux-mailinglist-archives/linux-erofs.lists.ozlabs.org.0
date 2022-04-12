Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B952B4FCCEE
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Apr 2022 05:17:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KcrW63zjLz2ync
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Apr 2022 13:17:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KcrW170rgz2xB1
 for <linux-erofs@lists.ozlabs.org>; Tue, 12 Apr 2022 13:17:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V9saviW_1649733421; 
Received: from 30.225.24.141(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9saviW_1649733421) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 12 Apr 2022 11:17:03 +0800
Message-ID: <65116657-bf3f-94ae-9565-fa15b4ebcd83@linux.alibaba.com>
Date: Tue, 12 Apr 2022 11:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 07/20] cachefiles: document on-demand read mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220406075612.60298-8-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1094292.1649684331@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1094292.1649684331@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-erofs@lists.ozlabs.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi, thanks for such thorough and detailed reviewing and all these
corrections. I will fix them in the next version.


On 4/11/22 9:38 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> + (*) On-demand Read.
>> +
> 
> Unnecessary extra blank line.
> 
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
> What's the scope of the uniqueness of "id"?  Is it just unique to a particular
> cachefiles cache?

Yes. Currently each cache, I mean, each "struct cachefiles_cache",
maintains an xarray. The id is unique in the scope of the cache.


> 
>> +
>> +	struct cachefiles_close {
>> +		__u32 fd;
>> +	};
>> +
> 
> "where:"
> 
>> +	* ``fd`` identifies the anon_fd to be closed, which is exactly the same
> 
> "... which should be the same as that provided to the OPEN request".
> 
> Is it possible for userspace to move the fd around with dup() or whatever?

Currently No. The anon_fd is stored in

```
struct cachefiles_object {
	int fd;
	...
}
```

When sending READ/CLOSE request, the associated anon_fd is all fetched
from @fd field of struct cachefiles_object. dup() won't update @fd field
of struct cachefiles_object.

Thus when dup() is done, let's say there are fd A (original) and fd B
(duplicated from fd A) associated to the cachefiles_object. Then the @fd
field of following READ/CLOSE requests is always fd A, since @fd field
of struct cachefiles_object is not updated. However the CREAD (reply to
READ request) ioctl indeed can be done on either fd A or fd B.

Then when fd A is closed while fd B is still alive, @fd field of
following READ/CLOSE requests is still fd A, which is indeed buggy since
fd A can be reused then.

To fix this, I plan to replace @fd field of READ/CLOSE requests with
@object_id field.

```
struct cachefiles_close {
        __u32 object_id;
};


struct cachefiles_read {
        __u32 object_id;
        __u64 off;
        __u64 len;
};
```

Then each cachefiles_object has a unique object_id (in the scope of
cachefiles_cache). Each object_id can be mapped to multiple fds (1:N
mapping), while kernel only send an initial fd of this object_id through
OPEN request.

```
struct cachefiles_open {
	__u32 object_id;
        __u32 fd;
        __u32 volume_key_size;
        __u32 cookie_key_size;
        __u32 flags;
        __u8  data[];
};
```

The user daemon can modify the mapping through dup(), but it's
responsible for maintaining and updating this mapping. That is, the
mapping between object_id and all its associated fds should be
maintained in the user space.


>> +
>> +	struct cachefiles_read {
>> +		__u64 off;
>> +		__u64 len;
>> +		__u32 fd;
>> +	};
>> +
>> +	* ``off`` identifies the starting offset of the requested file range.
> 
> identifies -> indicates
> 
>> +
>> +	* ``len`` identifies the length of the requested file range.
>> +
> 
> identifies -> indicates (you could alternatively say "specified")
> 
>> +	* ``fd`` identifies the anonymous fd of the requested cache file. It is
>> +	  guaranteed that it shall be the same with
> 
> "same with" -> "same as"
> 
> Since the kernel cannot make such a guarantee, I think you may need to restate
> this as something like "Userspace must present the same fd as was given in the
> previous OPEN request".

Yes, whether the @fd field of READ request is same as that of OPEN
request or not, is actually implementation dependent. However as
described above, I'm going to change @fd field into @object_id field.
After that refactoring, the @object_id field of READ/CLOSE request
should be the same as the @object_id filed of CLOSE request.



>> +CACHEFILES_IOC_CREAD ioctl on the corresponding anon_fd::
>> +
>> +	ioctl(fd, CACHEFILES_IOC_CREAD, id);
>> +
>> +	* ``fd`` is exactly the fd field of the previous READ request.
> 
> Does that have to be true?  What if userspace moves it somewhere else?
> 

As described above, I'm going to change @fd field into @object_id field.
Then there is an @object_id filed in READ request. When replying the
READ request, the user daemon itself needs to get the corresponding
anon_fd of the given @object_id through the self-maintained mapping.


-- 
Thanks,
Jeffle
