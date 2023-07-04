Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48F746B76
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 10:06:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOZlBm5n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOZlBm5n;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwFjj6B8lz3bNm
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 18:06:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOZlBm5n;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOZlBm5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwFjd5d0jz309V
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jul 2023 18:06:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688457967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HLEhyMz8craTsn3to7RUK9ThuIC3AHRSWlUj4z7344=;
	b=QOZlBm5nQ1ELENzzj98yrI9WeTUu4blKV9qYDEt+6ItWYW8V3zz2Mg9XuieFrjl6WPXxS6
	LGEKUNZgwChvougSux4cHS6IVxZxjiN/waEcnFL3FWXDH/Y1u/QkGjax6eul6Wf0pXR36+
	CuZHLv6dkJuILn8JpzSoCnMFOt85tXE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688457967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HLEhyMz8craTsn3to7RUK9ThuIC3AHRSWlUj4z7344=;
	b=QOZlBm5nQ1ELENzzj98yrI9WeTUu4blKV9qYDEt+6ItWYW8V3zz2Mg9XuieFrjl6WPXxS6
	LGEKUNZgwChvougSux4cHS6IVxZxjiN/waEcnFL3FWXDH/Y1u/QkGjax6eul6Wf0pXR36+
	CuZHLv6dkJuILn8JpzSoCnMFOt85tXE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-qTpJHPj7PraSUWs3TaXWYQ-1; Tue, 04 Jul 2023 04:06:05 -0400
X-MC-Unique: qTpJHPj7PraSUWs3TaXWYQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-345e8b04c78so25447875ab.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Jul 2023 01:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457965; x=1691049965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HLEhyMz8craTsn3to7RUK9ThuIC3AHRSWlUj4z7344=;
        b=WTimZsf8/zAweYqdF4cxdPVCYsmo3vHno6eQnZJiYnoLZ52JDJOCvUs4MTIxgVCMuD
         Gvna2lHI4JxZRVd6AytfAWX3p5x6TIiwLFcPuLE1gbBFOKPGE6p4J0YK3vwt03uyb4zI
         SjN9KZO3SEJjLUSjx0oT5wlEQRGcFYp6FPRsNlql+ywGVxcKi73dxs+HwTBmyvr4fnd4
         HpI4oXVLN9vq6e+OPLRyUKWzncpBgvLgt3rrDYJTvQJZnsBMI42H2fSVtRt5/d7vgYIu
         1NhJEPmExaH2mcbt76ntLONt+ngFWXqQUUN0eoYe92V4fkCLWlowBzJ7RqS8w5w0tGGy
         pp/Q==
X-Gm-Message-State: ABy/qLYtVy8HXGFplxGBb0E6atUvt7qVLvMoT5tm0SdJ9RNFFJnqAhQ1
	CAjlHn0E9iFMP7VvG8FrNTmODGHfIAitHRlmr6AqNZz7A4AWSP5V6DiIaOrwWhkU+3rRrOmRpCY
	yYxicqs8TeO7v3c+LlEV8vfCbudDZrLQk+i8BCk61
X-Received: by 2002:a92:ce84:0:b0:345:83d6:6020 with SMTP id r4-20020a92ce84000000b0034583d66020mr12999349ilo.21.1688457965098;
        Tue, 04 Jul 2023 01:06:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLDeGDk/zYVzoKn96RZTkAhnesrVyPUXni/0BVg+Vo4e1ny43N+7wGy6hBmGg+VFFp4ff/SHA9Unfdzfbe/I0=
X-Received: by 2002:a92:ce84:0:b0:345:83d6:6020 with SMTP id
 r4-20020a92ce84000000b0034583d66020mr12999343ilo.21.1688457964852; Tue, 04
 Jul 2023 01:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com> <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
 <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
In-Reply-To: <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
From: Alexander Larsson <alexl@redhat.com>
Date: Tue, 4 Jul 2023 10:05:53 +0200
Message-ID: <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 7:56=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 7/3/23 3:25 PM, Alexander Larsson wrote:
>
> >
> > Can't you just add a magic constant to the seed? Then we can come up
> > with one that gives a good spread and hardcode that.
> >
>
> I tried Alex's proposal of making a constant magic as part of the seed li=
ke:
>
> ```
> xxh32(name, strlen(name), SEED_MAGIC + index)
> ```
>
> >> where `index` represents the index of corresponding predefined name
> >> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
> >> after stripping the above predefined name prefix (e.g.
> >> "overlay.metacopy" for "user.overlay.metacopy")
>
>
> I tried SEED_MAGIC in range [0, UINT32_MAX], trying to find a constant
> magic giving a best spread.
>
> There are totally 30 commonly used xattrs and 32 bits could be mapped
> into.  I failed to find the most perfect constant magic which maps these
> 30 xattrs to exactly 30 bits with no conflict.
>
> Later I can only select a magic from those that 1) maps 30 xattrs into
> 29 bits (with one conflict) and 2) at least xattrs like selinux, ima,
> evm, apparmor are unconflicted to each other.  Following are all
> candidates and the conflicted xattrs:
>
> ```
> seed: 745a51e
> bit 29: user.overlay.opaque, security.selinux,
>
> seed: fb08ad9
> bit 10: user.overlay.impure, system.posix_acl_access,
>
> seed: 11aa6c32
> bit 19: user.overlay.redirect, security.SMACK64MMAP,
>
> seed: 1438d503
> bit 10: trusted.overlay.protattr, security.ima,
>
> seed: 14ccea75
> bit 30: user.overlay.upper, security.ima,
>
> seed: 1d6a0d15
> bit 31: trusted.overlay.upper, user.overlay.metacopy,
>
> seed: 25bbe08f
> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: 2649da2a
> bit  6: user.overlay.nlink, security.SMACK64TRANSMUTE,
>
> seed: 2b9180b2
> bit 29: user.overlay.impure, security.evm,
>
> seed: 2c5d7862
> bit 16: user.overlay.upper, system.posix_acl_default,
>
> seed: 322040a6
> bit 17: trusted.overlay.impure, user.overlay.metacopy,
>
> seed: 328bcb8c
> bit 30: user.overlay.opaque, security.evm,
>
> seed: 35afc469
> bit  3: trusted.overlay.opaque, user.overlay.origin,
>
> seed: 435bed25
> bit  4: trusted.overlay.upper, security.SMACK64MMAP,
>
> seed: 43a853af
> bit  3: trusted.overlay.protattr, security.selinux,
>
> seed: 4930f511
> bit 22: trusted.overlay.origin, security.SMACK64,
>
> seed: 4acdce1d
> bit 21: user.overlay.opaque, security.selinux,
>
> seed: 4fc5f2b0
> bit 24: user.overlay.redirect, system.posix_acl_default,
>
> seed: 50632396
> bit  6: security.SMACK64, system.posix_acl_access,
>
> seed: 535f6351
> bit  3: system.posix_acl_access, user.mime_type,
>
> seed: 56f4306e
> bit  9: user.overlay.redirect, security.SMACK64MMAP,
>
> seed: 637e2bd9
> bit 22: trusted.overlay.upper, security.evm,
>
> seed: 6ab57b38
> bit  9: trusted.overlay.upper, user.overlay.metacopy,
>
> seed: 7113bd57
> bit 19: trusted.overlay.redirect, security.SMACK64,
>
> seed: 753e3f24
> bit  6: user.overlay.redirect, security.SMACK64EXEC,
>
> seed: 81883030
> bit  0: trusted.overlay.upper, security.SMACK64IPOUT,
>
> seed: 835f9f14
> bit 27: security.SMACK64EXEC, system.posix_acl_access,
>
> seed: 938fbb78
> bit 28: user.overlay.upper, security.apparmor,
>
> seed: 953bb3e9
> bit 30: user.overlay.protattr, system.posix_acl_access,
>
> seed: 962ccd7f
> bit 29: trusted.overlay.nlink, security.SMACK64IPOUT,
>
> seed: 9fff798e
> bit  3: user.overlay.nlink, user.mime_type,
>
> seed: a2e324eb
> bit 28: trusted.overlay.nlink, user.overlay.impure,
>
> seed: a6e00cef
> bit 26: user.overlay.opaque, security.SMACK64TRANSMUTE,
>
> seed: ae26aaa9
> bit  0: trusted.overlay.metacopy, user.overlay.impure,
>
> seed: b2172573
> bit 14: trusted.overlay.upper, security.ima,
>
> seed: b5917739
> bit  8: trusted.overlay.protattr, user.overlay.impure,
>
> seed: c01a4919
> bit 22: trusted.overlay.nlink, user.overlay.upper,
>
> seed: c1fa0c0a
> bit 19: security.SMACK64TRANSMUTE, user.mime_type,
>
> seed: cbd314d7
> bit  6: trusted.overlay.upper, security.SMACK64IPOUT,
>
> seed: cc6dd8ee
> bit  2: trusted.overlay.nlink, user.overlay.upper,
>
> seed: cc922efd
> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>
> seed: cd478c17
> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: d35be1c8
> bit  9: trusted.overlay.protattr, security.SMACK64MMAP,
>
> seed: d3914458
> bit  1: trusted.overlay.redirect, security.SMACK64IPIN,
>
> seed: f3251337
> bit  7: user.overlay.opaque, security.SMACK64IPOUT,
>
> seed: f37d8900
> bit  9: trusted.overlay.impure, user.overlay.protattr,
>
> seed: fafd6c93
> bit  0: security.SMACK64, user.mime_type,
>
> seed: fcd35cbb
> bit  3: trusted.overlay.upper, user.overlay.redirect,
>
> seed: fe2e058a
> bit 14: user.overlay.impure, user.mime_type,
> ```
>
>
> Among all these candidates, I would prefer the following three
> candidates as for each inode the same xattr of overlayfs family xattrs,
> e.g. "overlay.metacopy", can not be prefixed with "trusted." and "user."
> at the same time.

Well, they *can* be the same at the same time, it just doesn't make
much sense, so it seems very unlikely. I agree that these make sense,
if the kernel is looking for user.overlay.metacopy, it would be in an
userxattr mounted overlayfs layer, and it would be very unlikely that
it had a trusted metacopy xattr, so there won't be any false negatives
causing us to do a full look up.

> ```
> seed: 25bbe08f
> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: cc922efd
> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>
> seed: cd478c17
> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
> ```
>
>
> Any other idea?

Any of these three is good to me. I don't have any ideas directly
related to this. However,  semi-related, it would be really cool if
fuse supported the same approach for xattr lookup. I.e. if lookup
could add a bloom filter value as part of the inode data, then we
could avoid a kernel<->fusefs-d transition for negative xattrs
lookups.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

