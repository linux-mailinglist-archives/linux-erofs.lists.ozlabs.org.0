Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B42127C41F
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 15:55:58 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zFLz3QxjzDqR3
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 23:55:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zD8x5xC4zDqVR
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2019 23:02:05 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B0D6EAEF3;
 Wed, 31 Jul 2019 13:02:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 2E7961E434C; Wed, 31 Jul 2019 15:01:48 +0200 (CEST)
Date: Wed, 31 Jul 2019 15:01:48 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v5 12/24] erofs: introduce tagged pointer
Message-ID: <20190731130148.GE15806@quack2.suse.cz>
References: <20190730071413.11871-1-gaoxiang25@huawei.com>
 <20190730071413.11871-13-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730071413.11871-13-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue 30-07-19 15:14:01, Gao Xiang wrote:
> Currently kernel has scattered tagged pointer usages
> hacked by hand in plain code, without a unique and
> portable functionset to highlight the tagged pointer
> itself and wrap these hacked code in order to clean up
> all over meaningless magic masks.
> 
> This patch introduces simple generic methods to fold
> tags into a pointer integer. Currently it supports
> the last n bits of the pointer for tags, which can be
> selected by users.
> 
> In addition, it will also be used for the upcoming EROFS
> filesystem, which heavily uses tagged pointer pproach
>  to reduce extra memory allocation.
> 
> Link: https://en.wikipedia.org/wiki/Tagged_pointer
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

I'm not sure the generic approach you take is really needed here... You can
rely on getting at most two unused bits in the pointer anyway (and on mk68
architecture I've heard even that is not true but I guess you don't care).
So why not just define a single pointer type representing pointer with as
many tags as you can get? Also what I find bad about your tagptr approach
is that the way you've implemented it you loose the information about the
original pointer type. So overall I'm not sure the benefits outweight the
downsides but I guess that's a matter of taste and ultimately your call as
a maintainer of this code.

								Honza

> ---
>  fs/erofs/tagptr.h | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 fs/erofs/tagptr.h
> 
> diff --git a/fs/erofs/tagptr.h b/fs/erofs/tagptr.h
> new file mode 100644
> index 000000000000..a72897c86744
> --- /dev/null
> +++ b/fs/erofs/tagptr.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * A tagged pointer implementation
> + *
> + * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
> + */
> +#ifndef __EROFS_FS_TAGPTR_H
> +#define __EROFS_FS_TAGPTR_H
> +
> +#include <linux/types.h>
> +#include <linux/build_bug.h>
> +
> +/*
> + * the name of tagged pointer types are tagptr{1, 2, 3...}_t
> + * avoid directly using the internal structs __tagptr{1, 2, 3...}
> + */
> +#define __MAKE_TAGPTR(n) \
> +typedef struct __tagptr##n {	\
> +	uintptr_t v;	\
> +} tagptr##n##_t;
> +
> +__MAKE_TAGPTR(1)
> +__MAKE_TAGPTR(2)
> +__MAKE_TAGPTR(3)
> +__MAKE_TAGPTR(4)
> +
> +#undef __MAKE_TAGPTR
> +
> +extern void __compiletime_error("bad tagptr tags")
> +	__bad_tagptr_tags(void);
> +
> +extern void __compiletime_error("bad tagptr type")
> +	__bad_tagptr_type(void);
> +
> +/* fix the broken usage of "#define tagptr2_t tagptr3_t" by users */
> +#define __tagptr_mask_1(ptr, n)	\
> +	__builtin_types_compatible_p(typeof(ptr), struct __tagptr##n) ? \
> +		(1UL << (n)) - 1 :
> +
> +#define __tagptr_mask(ptr)	(\
> +	__tagptr_mask_1(ptr, 1) ( \
> +	__tagptr_mask_1(ptr, 2) ( \
> +	__tagptr_mask_1(ptr, 3) ( \
> +	__tagptr_mask_1(ptr, 4) ( \
> +	__bad_tagptr_type(), 0)))))
> +
> +/* generate a tagged pointer from a raw value */
> +#define tagptr_init(type, val) \
> +	((typeof(type)){ .v = (uintptr_t)(val) })
> +
> +/*
> + * directly cast a tagged pointer to the native pointer type, which
> + * could be used for backward compatibility of existing code.
> + */
> +#define tagptr_cast_ptr(tptr) ((void *)(tptr).v)
> +
> +/* encode tagged pointers */
> +#define tagptr_fold(type, ptr, _tags) ({ \
> +	const typeof(_tags) tags = (_tags); \
> +	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
> +		__bad_tagptr_tags(); \
> +tagptr_init(type, (uintptr_t)(ptr) | tags); })
> +
> +/* decode tagged pointers */
> +#define tagptr_unfold_ptr(tptr) \
> +	((void *)((tptr).v & ~__tagptr_mask(tptr)))
> +
> +#define tagptr_unfold_tags(tptr) \
> +	((tptr).v & __tagptr_mask(tptr))
> +
> +/* operations for the tagger pointer */
> +#define tagptr_eq(_tptr1, _tptr2) ({ \
> +	typeof(_tptr1) tptr1 = (_tptr1); \
> +	typeof(_tptr2) tptr2 = (_tptr2); \
> +	(void)(&tptr1 == &tptr2); \
> +(tptr1).v == (tptr2).v; })
> +
> +/* lock-free CAS operation */
> +#define tagptr_cmpxchg(_ptptr, _o, _n) ({ \
> +	typeof(_ptptr) ptptr = (_ptptr); \
> +	typeof(_o) o = (_o); \
> +	typeof(_n) n = (_n); \
> +	(void)(&o == &n); \
> +	(void)(&o == ptptr); \
> +tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
> +
> +/* wrap WRITE_ONCE if atomic update is needed */
> +#define tagptr_replace_tags(_ptptr, tags) ({ \
> +	typeof(_ptptr) ptptr = (_ptptr); \
> +	*ptptr = tagptr_fold(*ptptr, tagptr_unfold_ptr(*ptptr), tags); \
> +*ptptr; })
> +
> +#define tagptr_set_tags(_ptptr, _tags) ({ \
> +	typeof(_ptptr) ptptr = (_ptptr); \
> +	const typeof(_tags) tags = (_tags); \
> +	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
> +		__bad_tagptr_tags(); \
> +	ptptr->v |= tags; \
> +*ptptr; })
> +
> +#define tagptr_clear_tags(_ptptr, _tags) ({ \
> +	typeof(_ptptr) ptptr = (_ptptr); \
> +	const typeof(_tags) tags = (_tags); \
> +	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
> +		__bad_tagptr_tags(); \
> +	ptptr->v &= ~tags; \
> +*ptptr; })
> +
> +#endif	/* __EROFS_FS_TAGPTR_H */
> +
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
