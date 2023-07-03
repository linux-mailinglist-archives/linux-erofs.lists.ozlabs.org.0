Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD0A7455F8
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 09:25:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BJ2aJlam;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dvl/LLnU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvcsT5hhQz30hQ
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 17:25:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BJ2aJlam;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dvl/LLnU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvcsL2ZLTz2ydP
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Jul 2023 17:25:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688369134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8K7BQdTCFcPMOKT0p8Mp9q5MKPmEZzCzLNkquYu4m0=;
	b=BJ2aJlamNwqURqHQoP6hmrtSiGxk/zRaSXV+b0Tj79l4evhN028EEcFqJgweTeuyGPpHId
	003fghRxeoffa3ehxVHs9nT0udAGlTovU61h4VmzkJNtmcAtn4IxKSZ6X7cjBDAmbYVjvd
	9RUe9jMOtgkuglafdewEyH2sGF7O7y0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688369135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8K7BQdTCFcPMOKT0p8Mp9q5MKPmEZzCzLNkquYu4m0=;
	b=dvl/LLnUt0QsTZEDfxNyFxhz7DQj3RKPxHa7o0hcxcS7MmmTW4IjPdH46oXiv1ww6Vcv45
	HaRFGrZm4X4Nf+4olCVhWj1BL9r1bkUZwTLJat6xvNigB2OJc9funhvkq8Eu/AKdf/Yo8W
	AniIT9r7kXaRgTS4B8OMxf57W7UpUCY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-HKRzB5pfM1enBtQuUay4_w-1; Mon, 03 Jul 2023 03:25:33 -0400
X-MC-Unique: HKRzB5pfM1enBtQuUay4_w-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77e41268d40so181487039f.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Jul 2023 00:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369132; x=1690961132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8K7BQdTCFcPMOKT0p8Mp9q5MKPmEZzCzLNkquYu4m0=;
        b=lDCz2UlpqrbAVQIDcbdThJQvQRYB48+CMpHv8Ix6P5xMEfWI8s5XZ3vuaXeIDb5ZU+
         zWfG7deRzoizIwEnGXB4D/lRAV5iLYTP3ZFkdjCvI53FJHV/rDl790Fg5Wwxv287W5SE
         UTkBLuvzzsa5g1PqrxbIXGXqOiwEM+bCvjVDkervCK4yXwfEZbdcf43KHm8NU5yfFt59
         0Iqm3kwhSLqI5QVodXCBodqlozWEFYsakzJmAuKciibZmEK/iec7k449hr5XVKpkeE3k
         W/ObAb5SxjUfLKVayI29w9NvRs8uUpdhHtJtwmH5FobTT8cW1pwslSwViicAcjnXb/eG
         AvQQ==
X-Gm-Message-State: ABy/qLYFxHbXkA9sMKGpE6egqDa5e5wjTRuB+0XCDXJwF1hq3moVEv/T
	xxkPS7KUENJmqV6IFMOnqq/WsXW9Z3lM1O76kk+EcyXDm9JQSmZy1lQ6Tt7tbDBoPqNytySRvGd
	X7WPT3eGD4UPufwZP4ZxFigFS2ecSWQlVlGnTO8UZ
X-Received: by 2002:a92:7304:0:b0:345:d277:18eb with SMTP id o4-20020a927304000000b00345d27718ebmr7747436ilc.30.1688369132635;
        Mon, 03 Jul 2023 00:25:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxAGjG5dGftIWqldWWYnIv5mQYfMJ0B2jptkgu7YvlMJjeSzqyGrFcUlTo77pTsoU5o6WVwk2Lg7iaLQnlteQ=
X-Received: by 2002:a92:7304:0:b0:345:d277:18eb with SMTP id
 o4-20020a927304000000b00345d27718ebmr7747429ilc.30.1688369132335; Mon, 03 Jul
 2023 00:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com> <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
In-Reply-To: <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
From: Alexander Larsson <alexl@redhat.com>
Date: Mon, 3 Jul 2023 09:25:21 +0200
Message-ID: <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 5:38=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi all,
>
> Sorry for the late reply as I was on vacation these days.
>
> I test the hash bit for all xattrs given by Alex[1], to see if each
> xattr could be mapped into one unique bit in the 32-bit bloom filter.
>
> [1]
> https://lore.kernel.org/all/CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU=
_LArUw@mail.gmail.com/
>
>
> On 6/21/23 4:32 PM, Jingbo Xu wrote:
> >
> > 3.2. input of hash function
> > -------------------------
> > As previously described, each hash function will map the given data int=
o
> > one bit of the bloom filter map.  In our use case, xattr name serves as
> > the key of hash function.
> >
> > When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
> > and the remaining name apart from the prefix are handy.  To avoid
> > constructing the full xattr name, the above index and name are fed into
> > the hash function directly in the following way:
> >
> > ```
> > bit =3D xxh32(name, strlen(name), index + i);
> > ```
> >
> > where index serves as part of seed, so that it gets involved in the
> > calculation for the hash.
>
>
> All xattrs are hashed with one single hash function.
>
> I first tested with the following hash function:
>
> ```
> xxh32(name, strlen(name), index)
> ```
>
> where `index` represents the index of corresponding predefined name
> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
> after stripping the above predefined name prefix (e.g.
> "overlay.metacopy" for "user.overlay.metacopy")
>
>
> The mapping results are:
>
> bit  0: security.SMACK64EXEC
> bit  1:
> bit  2: user.overlay.protattr
> bit  3: trusted.overlay.impure, user.overlay.opaque, user.mime_type
> bit  4:
> bit  5: user.overlay.origin
> bit  6: user.overlay.metacopy, security.evm
> bit  8: trusted.overlay.opaque
> bit  9: trusted.overlay.origin
> bit 10: trusted.overlay.upper, trusted.overlay.protattr
> bit 11: security.apparmor, security.capability
> bit 12: security.SMACK64
> bit 13: user.overlay.redirect, security.ima
> bit 14: user.overlay.upper
> bit 15: trusted.overlay.redirect
> bit 16: security.SMACK64IPOUT
> bit 17:
> bit 18: system.posix_acl_access
> bit 19: security.selinux
> bit 20:
> bit 21:
> bit 22: system.posix_acl_default
> bit 23: security.SMACK64MMAP
> bit 24: user.overlay.impure, user.overlay.nlink, security.SMACK64TRANSMUT=
E
> bit 25: trusted.overlay.metacopy
> bit 26:
> bit 27: security.SMACK64IPIN
> bit 28:
> bit 29:
> bit 30: trusted.overlay.nlink
> bit 31:
>
> Here 30 xattrs are mapped into 22 bits.  There are two potential
> conflicts, i.e. bit 10 (trusted.overlay.upper, trusted.overlay.protattr)
> and bit 24 (user.overlay.impure, user.overlay.nlink).

Bit 11 (apparmor and capabilities) seems like the most likely thing to
run into. I.e. on an apparmor-using system, many files would have
apparmor xattr set, so looking up security.capabilities on it would
cause a false negative and we'd unnecessarily read the xattrs.

> > An alternative way is to calculate the hash from the full xattr name by
> > feeding the prefix string and the remaining name string separately in
> > the following way:
> >
> > ```
> > xxh32_reset()
> > xxh32_update(prefix string, ...)
> > xxh32_update(remaining name, ...)
> > xxh32_digest()
> > ```
> >
> > But I doubt if it really deserves to call multiple APIs instead of one
> > single xxh32().
>
>
> I also tested with the following hash function, where the full name of
> the xattr, e.g. "user.overlay.metacopy", is fed into the hash function.
>
> ```
> xxh32(name, strlen(name), 0)
> ```
>
>
> Following are the mapping results:
>
> bit  0: trusted.overlay.impure, user.overlay.protattr
> bit  1: security.SMACK64IPOUT
> bit  2:
> bit  3: security.capability
> bit  4: security.selinux
> bit  5: security.ima
> bit  6: user.overlay.metacopy
> bit  8:
> bit  9: trusted.overlay.redirect, security.SMACK64EXEC
> bit 10: system.posix_acl_access
> bit 11: trusted.overlay.nlink
> bit 12: trusted.overlay.opaque
> bit 13:
> bit 14:
> bit 15:
> bit 16:
> bit 17: user.overlay.impure
> bit 18: security.apparmor
> bit 19:
> bit 20: user.overlay.origin, user.overlay.nlink, security.SMACK64TRANSMUT=
E
> bit 21:
> bit 22: trusted.overlay.metacopy, trusted.overlay.protattr
> bit 23: user.overlay.upper, security.evm
> bit 24: user.overlay.redirect, security.SMACK64IPIN,
> system.posix_acl_default
> bit 25: security.SMACK64
> bit 26:
> bit 27: trusted.overlay.upper, security.SMACK64MMAP
> bit 28: trusted.overlay.origin, user.mime_type
> bit 29:
> bit 30:
> bit 31: user.overlay.opaque
>
> 30 xattrs are mapped into 20 bits.  Similarly there are two potential
> conflicts, i.e. bit 20 (user.overlay.origin, user.overlay.nlink) and bit
> 22 (trusted.overlay.metacopy, trusted.overlay.protattr).
>
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
>
> Personally I would prefer the former, as it maps xattrs into the bloom
> filter more evenly (22 bits vs 20 bits) and can better cooperate with
> the kernel routine (index and the remaining name string, rather than the
> full name string, are handy).

I agree that we want the approach with better cooperation with the
kernel function. However, I would much prefer if all the xattrs that
are commonly set on many files are unconflicted. This would be at
least: selinux, ima, evm, apparmor.

Can't you just add a magic constant to the seed? Then we can come up
with one that gives a good spread and hardcode that.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

