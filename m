Return-Path: <linux-erofs+bounces-680-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69BB0B99F
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 02:44:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blhVL0PM5z30WT;
	Mon, 21 Jul 2025 10:44:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::936"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753058649;
	cv=none; b=GVGX8wXURMNTvXOXXgQJd+pjguVQnnT4axyxp9HZWY3FN2W3ZysAm6BwVj8p7dJnCopzRFd7lOuUS4sHpw4Hfs41zaY+KPN9UJyvNI/aEHDZ5sKaVKS0jtXw/uhxebp413nbfN6Y5UiIbprUdvfcpGAeUyi3Z8leaRq8dR6tTftEJKzfK2L7wOqgq1zlXkYm40Qpuk7wuOcKzxMQbddIS+s2dF7T7WOs7qZi2f5YP8KJLQRLFForFJ/mrRsds6v8ahq59TpytrdRdd9Q2lCuAvZq2SYl2lzMOxyyXq0nn+jvGyHb8KP02D2Q96ESZybb+WTW6SGo9usK7xoqilVytg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753058649; c=relaxed/relaxed;
	bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLtrJV7aeKLoEKW8aJ6zoUV1gfrMl7oHiaah6O99YS4bo1KdicGxAt0L/2lRmgcUsvvbN59TDmqpWBDy+3qJa6faW6HWdoGXLWaVhRv4KkXjH2h+1eXW2QG1xawAc6R5SdSHANtVw5A9II+EtNxpoEbOSgI0VFzskquiCfKOvohCtDJIZyKShQzxo3s/r7RZgUVIAcyfwyFBvoKMAWSaY0CVdh4BlUyza2k0d18MiReHryWxBThMWPBHcBIE3e2iTedhkjfERsbGgO5UaOEiq+azkqwqWRZWir0nMEMfiubZujWQdX4fMIY//5QEQu10cUYqf4Y3+1inIXm+I4jl3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gr1RJb5A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gr1RJb5A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blhVH5Jh7z2yfx
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 10:44:06 +1000 (AEST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-880f92a63c7so1884851241.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 20 Jul 2025 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753058643; x=1753663443; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=Gr1RJb5Aa0rEAtnZrpcEahWcv1YRWZSkQ2+gkO5OPMK8T8NUbBUpMNpLt2kS4o7imN
         aB44jRO8LWBfdF+WabQt1aYgz+4xNyDaDBrx5cpfSAm0+NKPOB5oG2dt++HxLeECw534
         h4kicV/7UJ2d4a5NbrJpVEaQ4bHFRrxj1q8kTIPioqQtoyNEQnllzvfy3r0e8wAWLFTE
         bk3xu4dBMwzZpK6HYFf0Y/S7S1q+wNSwJl2ZAKYUHZHj1lYG6IVxvf68nHvvR+1E9zfr
         97JfvI9i3cZvIiURTU34DmG8vDmsFNw6vMNQdJKuhYy92v03QI0SKCedlRJH9rcGPoFX
         UGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753058643; x=1753663443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=LK4XE/7rA0oYtjLn+mUepcAD1Ptr2cffGSstVGHhjTqT0t2irf0TKpb9u7RGcKPIhW
         2qtY2fwBpwUIWaDIfVNfZUBaGzFhVZHNmtmOYmKra+/+e5AzP2Y3p9pCpiHzW5Bbi56M
         XeODjNvSsnwXtGpOOGCBI7GLFb5Dw2e8OmUltfRo+Yg+pEELvYRZy9R7MZC1zWwD2lTz
         LiEGUgDf5Z0kQLeyZR4+XjcAR/qE2u6wD8/3pjf+CGlPCnpZleGc5zPbmolF9Y6Gbibj
         KBq0SGlZK/UKbffj1vAulkktlN1RXU4NBhtU3/OBIULP3VL79soiCitiQvymu4SewtFn
         tArA==
X-Forwarded-Encrypted: i=1; AJvYcCXYtIamkTRoXpfdEQJx1//Bl8+T81WmaS6n1CnT/1jkmuJOy7BITlfJkMp1Dv1wIPX99MhH8Y9Xq52jgw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz5zJTHLZRZxu7nZMgz4kz6R62vZdwdt841Izy2dem4aGKSwuWs
	Ht8xUMR/z/UOlA5jNH+75WZdz5mE7O02QJJYEcgSX/nl99e+V6MMBRk25i5/m2dfFeqy/VtjVYc
	LbWTcvVYyfN+JXeD8jCDyjXtMOOV4MN0=
X-Gm-Gg: ASbGnct9vSahcnbVugf/R+kUGb1avKkeaKTTnm6Xu/HMZ49xU9AXeJc30MfkqjCPCpc
	9V7WQ+xpYkBaWuHKD1xtB5dnfkNVRdYnh73oK/qrqav89PTYLz+jDyTUw1D847bktzWBeicbdhN
	rqdxCkcMIUFzgHab6Dy11Qey6+uGP2tPeDxD8hhoLTRfqQYrkkCijvyp5YiStMk16X7y5Byn3cD
	/cUGMY=
X-Google-Smtp-Source: AGHT+IGFRYyrS35WTP3i9Qe8TXmZslY6x6nCRq1gIJA/O9dosgodOs3uPYD7WXYU49lcEb5mCGS05wblqRqGVV/3QiI=
X-Received: by 2002:a05:6102:6316:10b0:4f9:6a91:cc95 with SMTP id
 ada2fe7eead31-4f96a91cec6mr5610145137.27.1753058643165; Sun, 20 Jul 2025
 17:44:03 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
In-Reply-To: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 08:43:51 +0800
X-Gm-Features: Ac12FXzyFbI4GjwypQZFYPLAZaBnNxcXr0fPPaJY0y3WB9_zSNUgD719YOscIeg
Message-ID: <CAGsJ_4wOeBwm2=1CbtZk+gHXe0wVyAYZuV-RZcV-wXe4Rj+h7g@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jul 16, 2025 at 7:32=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
[...]
>
> I don't see this will work for EROFS because EROFS always supports
> variable uncompressed extent lengths and that will break typical
> EROFS use cases and on-disk formats.
>
> Other thing is that large order folios (physical consecutive) will
> caused "increase the latency on UX task with filemap_fault()"
> because of high-order direct reclaims, see:
> https://android-review.googlesource.com/c/kernel/common/+/3692333
> so EROFS will not set min-order and always support order-0 folios.

Regarding Hailong's Android hook, it's essentially a complaint about
the GFP mask used to allocate large folios for files. I'm wondering
why the page cache hasn't adopted the same approach that's used for
anon large folios:

    gfp =3D vma_thp_gfp_mask(vma);

Another concern might be that the allocation order is too large,
which could lead to memory fragmentation and waste. Ideally, we'd
have "small" large folios=E2=80=94say, with order <=3D 4=E2=80=94to strike =
a better
balance.

>
> I think EROFS will not use this new approach, vmap() interface is
> always the case for us.
>
> Thanks,
> Gao Xiang
>
> >
>

Thanks
Barry

