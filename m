Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9FC54457D
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 10:16:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJcPH02Tsz3bm5
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 18:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKWVK5To;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKWVK5To;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKWVK5To;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKWVK5To;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJcPB3dPNz2x9T
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jun 2022 18:16:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654762571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8SVe5aiMwQ66aCyV8FH9qy1UnNuhdudkR6VUPMWV6A=;
	b=WKWVK5ToLKixvOeIRMD56UHFxoNU9HmTpy2V614LAqAX/99zNYDAQlKla3QrRLPJrMV3U0
	tJNZhJ6Vvlku44sqtZi7wgUx09rzPlvdXXm/Mc2r6hto/OB7TV0QFf9TkSnUfVUiXfJRAA
	WwHj6SFgo2e349bEtU8eAD0M+YzroXo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654762571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8SVe5aiMwQ66aCyV8FH9qy1UnNuhdudkR6VUPMWV6A=;
	b=WKWVK5ToLKixvOeIRMD56UHFxoNU9HmTpy2V614LAqAX/99zNYDAQlKla3QrRLPJrMV3U0
	tJNZhJ6Vvlku44sqtZi7wgUx09rzPlvdXXm/Mc2r6hto/OB7TV0QFf9TkSnUfVUiXfJRAA
	WwHj6SFgo2e349bEtU8eAD0M+YzroXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-swCr3ZqTNYevSKMJZgmZVA-1; Thu, 09 Jun 2022 04:16:07 -0400
X-MC-Unique: swCr3ZqTNYevSKMJZgmZVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89641833967;
	Thu,  9 Jun 2022 08:16:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95887492C3B;
	Thu,  9 Jun 2022 08:16:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
References: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
To: jlayton@kernel.org
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4000416.1654762563.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jun 2022 09:16:03 +0100
Message-ID: <4000417.1654762563@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Here's a program that can be used to exercise the iter_xarray_get_pages()
function in userspace.  In the main() function, there are various paramete=
rs
that can be adjusted, such as the starting offset (iter.xarray_start), the
size of the content (iter.count), the maximum number of pages to be extrac=
ted
(maxpages) and the maximum size to be extracted (maxsize).

David
---
/* SPDX-License-Identifier: GPL-2.0 */
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef unsigned long pgoff_t;
#define PAGE_SHIFT 12
#define PAGE_SIZE ((unsigned long)1 << PAGE_SHIFT)
#define PAGE_MASK (~(PAGE_SIZE - 1))

struct page;
struct xarray;

struct iov_iter {
	size_t iov_offset;
	size_t count;
	loff_t xarray_start;
};
#define __is_constexpr(x) \
	(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
#define __typecheck(x, y) \
	(!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))

#define __no_side_effects(x, y) \
		(__is_constexpr(x) && __is_constexpr(y))

#define __safe_cmp(x, y) \
		(__typecheck(x, y) && __no_side_effects(x, y))

#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))

#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
		typeof(x) unique_x =3D (x);		\
		typeof(y) unique_y =3D (y);		\
		__cmp(unique_x, unique_y, op); })

#define __careful_cmp(x, y, op) \
	__builtin_choose_expr(__safe_cmp(x, y), \
		__cmp(x, y, op), \
		__cmp_once(x, y, __x, __y, op))
#define min(x, y)	__careful_cmp(x, y, <)
#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)

static int apply_fix;

static ssize_t iter_xarray_populate_pages(pgoff_t index, unsigned int nr_p=
ages)
{
	return nr_pages;
}

static ssize_t iter_xarray_get_pages(struct iov_iter *i, size_t maxsize,
				     unsigned maxpages, size_t *_start_offset)
{
	unsigned nr, offset;
	pgoff_t index, count;
	size_t size =3D maxsize, head_size, tail_size;
	loff_t pos;

	if (!size || !maxpages)
		return 0;

	pos =3D i->xarray_start + i->iov_offset;
	index =3D pos >> PAGE_SHIFT;
	offset =3D pos & ~PAGE_MASK;
	*_start_offset =3D offset;

	count =3D 1;
	tail_size =3D head_size =3D PAGE_SIZE - offset;
	if (maxsize > head_size) {
		size -=3D head_size;
		count +=3D size >> PAGE_SHIFT;
		tail_size =3D size & ~PAGE_MASK;
		if (tail_size)
			count++;
	}

	if (count > maxpages)
		count =3D maxpages;

	printf(" %6lx %6lu %6zx |", index, count, tail_size);

	nr =3D iter_xarray_populate_pages(index, count);
	if (nr =3D=3D 0)
		return 0;

	if (!apply_fix) {
		size_t actual =3D PAGE_SIZE * nr;
		actual -=3D offset;
		if (nr =3D=3D count && size > 0) {
			unsigned last_offset =3D (nr > 1) ? 0 : offset;
			actual -=3D PAGE_SIZE - (last_offset + size);
		}
		return actual;
	} else {
		return min(nr * PAGE_SIZE - offset, maxsize);
	}
}

ssize_t iov_iter_get_pages(struct iov_iter *i,
			   size_t maxsize, unsigned maxpages, size_t *start)
{
	if (maxsize > i->count)
		maxsize =3D i->count;
	if (!maxsize)
		return 0;
	return iter_xarray_get_pages(i, maxsize, maxpages, start);
}

int main()
{
	struct iov_iter iter;
	ssize_t size;
	size_t i, maxpages, maxsize, offset;

	memset(&iter, 0, sizeof(iter));

	/* Adjustable parameters */
	iter.xarray_start	=3D 0x11000;
	iter.count		=3D PAGE_SIZE * 16;
	maxpages		=3D 15;
	maxsize			=3D maxpages * PAGE_SIZE;

	printf("X-STRT X-OFFS X-CNT  | INDEX  COUNT  T-SIZE | OFFSET SIZE\n");
	printf("=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D | =3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D | =3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D\n");

	for (apply_fix =3D 0; apply_fix < 2; apply_fix++) {
		i =3D 0;
		for (;;) {
			iter.iov_offset =3D i;
			printf("%6lx %6zx %6zx |",
			       iter.xarray_start, iter.iov_offset, iter.count);
			size =3D iov_iter_get_pages(&iter, maxsize, maxpages,
						  &offset);

			printf(" %6zx %6zx", offset, size);
			if (offset + size > maxsize)
				printf(" ** BIG");
			if (offset + size > iter.iov_offset + iter.count)
				printf(" ** OVER");
			printf("\n");
			if (i > PAGE_SIZE)
				break;
			i +=3D 0x111;
		}

	}
	return 0;
}

