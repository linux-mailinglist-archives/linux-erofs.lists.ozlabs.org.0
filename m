Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7907408FB
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 05:38:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrS3M1fJ1z307y
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 13:38:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrS3H4xNTz2y1Y
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 13:38:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vm85EE4_1687923491;
Received: from 30.221.149.82(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vm85EE4_1687923491)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 11:38:12 +0800
Message-ID: <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
Date: Wed, 28 Jun 2023 11:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
 linux-erofs@lists.ozlabs.org
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

Sorry for the late reply as I was on vacation these days.

I test the hash bit for all xattrs given by Alex[1], to see if each
xattr could be mapped into one unique bit in the 32-bit bloom filter.

[1]
https://lore.kernel.org/all/CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU_LArUw@mail.gmail.com/


On 6/21/23 4:32 PM, Jingbo Xu wrote:
> 
> 3.2. input of hash function
> -------------------------
> As previously described, each hash function will map the given data into
> one bit of the bloom filter map.  In our use case, xattr name serves as
> the key of hash function.
> 
> When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
> and the remaining name apart from the prefix are handy.  To avoid
> constructing the full xattr name, the above index and name are fed into
> the hash function directly in the following way:
> 
> ```
> bit = xxh32(name, strlen(name), index + i);
> ```
> 
> where index serves as part of seed, so that it gets involved in the
> calculation for the hash.


All xattrs are hashed with one single hash function.

I first tested with the following hash function:

```
xxh32(name, strlen(name), index)
```

where `index` represents the index of corresponding predefined name
prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
after stripping the above predefined name prefix (e.g.
"overlay.metacopy" for "user.overlay.metacopy")


The mapping results are:

bit  0: security.SMACK64EXEC
bit  1:
bit  2: user.overlay.protattr
bit  3: trusted.overlay.impure, user.overlay.opaque, user.mime_type
bit  4:
bit  5: user.overlay.origin
bit  6: user.overlay.metacopy, security.evm
bit  8: trusted.overlay.opaque
bit  9: trusted.overlay.origin
bit 10: trusted.overlay.upper, trusted.overlay.protattr
bit 11: security.apparmor, security.capability
bit 12: security.SMACK64
bit 13: user.overlay.redirect, security.ima
bit 14: user.overlay.upper
bit 15: trusted.overlay.redirect
bit 16: security.SMACK64IPOUT
bit 17:
bit 18: system.posix_acl_access
bit 19: security.selinux
bit 20:
bit 21:
bit 22: system.posix_acl_default
bit 23: security.SMACK64MMAP
bit 24: user.overlay.impure, user.overlay.nlink, security.SMACK64TRANSMUTE
bit 25: trusted.overlay.metacopy
bit 26:
bit 27: security.SMACK64IPIN
bit 28:
bit 29:
bit 30: trusted.overlay.nlink
bit 31:

Here 30 xattrs are mapped into 22 bits.  There are two potential
conflicts, i.e. bit 10 (trusted.overlay.upper, trusted.overlay.protattr)
and bit 24 (user.overlay.impure, user.overlay.nlink).


> 
> An alternative way is to calculate the hash from the full xattr name by
> feeding the prefix string and the remaining name string separately in
> the following way:
> 
> ```
> xxh32_reset()
> xxh32_update(prefix string, ...)
> xxh32_update(remaining name, ...)
> xxh32_digest()
> ```
> 
> But I doubt if it really deserves to call multiple APIs instead of one
> single xxh32().


I also tested with the following hash function, where the full name of
the xattr, e.g. "user.overlay.metacopy", is fed into the hash function.

```
xxh32(name, strlen(name), 0)
```


Following are the mapping results:

bit  0: trusted.overlay.impure, user.overlay.protattr
bit  1: security.SMACK64IPOUT
bit  2:
bit  3: security.capability
bit  4: security.selinux
bit  5: security.ima
bit  6: user.overlay.metacopy
bit  8:
bit  9: trusted.overlay.redirect, security.SMACK64EXEC
bit 10: system.posix_acl_access
bit 11: trusted.overlay.nlink
bit 12: trusted.overlay.opaque
bit 13:
bit 14:
bit 15:
bit 16:
bit 17: user.overlay.impure
bit 18: security.apparmor
bit 19:
bit 20: user.overlay.origin, user.overlay.nlink, security.SMACK64TRANSMUTE
bit 21:
bit 22: trusted.overlay.metacopy, trusted.overlay.protattr
bit 23: user.overlay.upper, security.evm
bit 24: user.overlay.redirect, security.SMACK64IPIN,
system.posix_acl_default
bit 25: security.SMACK64
bit 26:
bit 27: trusted.overlay.upper, security.SMACK64MMAP
bit 28: trusted.overlay.origin, user.mime_type
bit 29:
bit 30:
bit 31: user.overlay.opaque

30 xattrs are mapped into 20 bits.  Similarly there are two potential
conflicts, i.e. bit 20 (user.overlay.origin, user.overlay.nlink) and bit
22 (trusted.overlay.metacopy, trusted.overlay.protattr).


Summary
=======

Personally I would prefer the former, as it maps xattrs into the bloom
filter more evenly (22 bits vs 20 bits) and can better cooperate with
the kernel routine (index and the remaining name string, rather than the
full name string, are handy).

-- 
Thanks,
Jingbo
