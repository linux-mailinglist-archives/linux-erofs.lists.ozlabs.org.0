Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C0738278
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 13:57:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SxApC0LT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPkQEtg6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmMSQ3Mb3z3bVS
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 21:57:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SxApC0LT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPkQEtg6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 314 seconds by postgrey-1.37 at boromir; Wed, 21 Jun 2023 21:57:21 AEST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmMSK4Lz2z30hG
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 21:57:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687348637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZCxbwN/fBZM1/IqvleFuFO1GiX4lYJkVAnMsqMaFMw=;
	b=SxApC0LTQO4PbgLJneA/WI/9qi6+f9C75JrICIIRdwgFHz1qoPSRn+FOhgjAP6lhd47BTO
	TSzDNOjou3c3iTP6j9Ki2zI9SdRqtVQT4AJZPkvrzkwq/gVDfm3Gm8+3UeG3gC0RFToGo0
	GKHovUYC7dwX04QhXsZYuxcSIe/h7cU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687348638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZCxbwN/fBZM1/IqvleFuFO1GiX4lYJkVAnMsqMaFMw=;
	b=QPkQEtg6QSfYb20O8AQanoKAcN8s0RpBe7Lxr7o6E8dZS80nD6fczxl4a7kORX0Fdq1dcb
	mhbiODJYWUiB7Jd/O6j+k8lFOq+VtjZVbiCF32Yuj73eNB9CekKHBNCyI9U6UJCVgHVy+R
	E8bdELgCEQS7kEtLxB/mj8sqr3YnVpU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-49KkPcj_NoSJyH54y8eeJA-1; Wed, 21 Jun 2023 07:50:55 -0400
X-MC-Unique: 49KkPcj_NoSJyH54y8eeJA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-340b21b5927so43976455ab.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348255; x=1689940255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZCxbwN/fBZM1/IqvleFuFO1GiX4lYJkVAnMsqMaFMw=;
        b=CwyJTRogciij8aF3TWmhFkWDxxD+59qdnQgweqkaOv56glFLN+FfXVUGiEhyciW81u
         waWVTzXMxUNIIP6GzsY2rjakCLgx63cXJQ1HyMit8eezM0H1Q37FSwWNrDU5n1WCT3Vr
         EXeS3REaYpdTyg4qqtERJTkIjusxIysmZ8jkctXVF+yINnaTTUtO/TrKFne3szGk7b49
         DT5TwKFFGnhmA+TGgw8q6pzOTnN4Qc7jPeyEKAO9E7yhR0gEoTf1bsfXvf3NbIPCKZoG
         NEp1GF6gnsJ/squc8nQHHx3MwtFayd1WU8r61ZApUZVMUaMzwQR58xxt/3x/kGzw1qOI
         zmtA==
X-Gm-Message-State: AC+VfDwZAIFZcsbPET7vm6bPqoQ5KA6Kt+xBodR4JZFRD7bEArIJo+p5
	TFij80pH0Fu2Igcx00eKAl08SDZoYeR8lBVqJ5eGF+CzoTJRjkXi3CkiFvLyh9ItmO6a1pCKqkH
	CRC6yGcYEGospXKJAVf04n3OeegqqpuFh/rwxlice
X-Received: by 2002:a92:d9cb:0:b0:340:9f52:a981 with SMTP id n11-20020a92d9cb000000b003409f52a981mr10565090ilq.2.1687348254888;
        Wed, 21 Jun 2023 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76KxJo9Yk/hYbLA5LofTwK7sebnG7qzFyA6+bsQ06fuBfM3XCfpffFr4o0yohCtXfXEwtar35+6FVQNAHy/fc=
X-Received: by 2002:a92:d9cb:0:b0:340:9f52:a981 with SMTP id
 n11-20020a92d9cb000000b003409f52a981mr10565079ilq.2.1687348254601; Wed, 21
 Jun 2023 04:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
From: Alexander Larsson <alexl@redhat.com>
Date: Wed, 21 Jun 2023 11:50:43 +0000
Message-ID: <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To: Jingbo Xu <jefflexu@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 21, 2023 at 10:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Filesystems with ACL enabled generally need to read
> "system.posix_acl_access"/"system.posix_acl_default" xattr to get the
> access and default ACL.  When filesystem is mounted with ACL enabled
> while files in the system have not set access/default ACL, the getattr()
> will run in vain while the round trip can decrease the performance in
> workload like "ls -lR".
>
> For example, there's a 12% performance boost if erofs is mounted with
> "noacl" when running "ls -lR" workload on dataset [1] (given in [2]).
>
> We'd better offer a fastpath to boost the above workload, as well as
> other negative xattr lookup.
>
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
> Introduce a per-inode bloom filter for xattrs to boost the negative
> xattr queries.
>
> As following shows, a 32-bit bloom filter is introduced for each inode,
> describing if a xattr with specific name exists on this inode.
>
> ```
>  struct erofs_xattr_ibody_header {
> -       __le32 h_reserved;
> +       __le32 h_map; /* bloom filter */
>         ...
> }
> ```
>
> Following are some implementation details for bloom filter.
>
> 1. Reverse bit value
> --------------------
> The bloom filter structure describes if a given data is inside the set.
> It will map the given data into several bits of the bloom filter map.
> The data must not exist inside the set if any mapped bit is 0, while the
> data may be not inside the set even if all mapped bits is 1.
>
> While in our use case, as erofs_xattr_ibody_header.h_map is previously a
> (all zero) reserved field, the bit value for the bloom filter has a
> reverse semantics in consideration for compatibility.  That is, for a
> given data, the mapped bits will be cleared to 0.  Thus for a previously
> built image without support for bloom filter, the bloom filter is all
> zero and when it's mounted by the new kernel with support for bloom
> filter, it can not determine if the queried xattr exists on the inode and
> thus will fallback to the original routine of iterating all on-disk
> xattrs to determine if the queried xattr exists.
>
>
> 2. The number of hash functions
> -------------------------------
> The optimal value for the number of the hash functions (k) is (ln2 *
> m/n), where m stands the number of bits of the bloom filter map, while n
> stands the number of all candidates may be inside the set.
>
> In our use case, the number of common used xattr (n) is approximately 8,
> including system.[posix_acl_access|posix_acl_default],
> security.[capability|selinux] and
> security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].
>
> Given the number of bits of the bloom filter (m) is 32, the optimal value
> for the number of the hash functions (k) is 2 (ln2 * m/n =3D 2.7).

This is indeed the optimal value in a traditional use of bloom
filters. However, I think it is based on a much larger set of values.
For this usecase it may be better to choose a different value.

I did some research a while ago on this, and I thought about the
counts too. Having more than one hash function is useful because it
allows you to avoid problems if two values happen to hash to the same
bucket, but this happens at the cost of there being less "unique
buckets".  I spent some time looking for common xattr values
(including some from userspace) and ended up with a list of about 30.
If we can choose a single hash function that maps all (or most) of
these to a unique bucket (mod 32), then it seems to me that having
just that single hash function is better, as it is faster to compute,
and is good enough to uniquely identify each of these commonly used
xattrs.

