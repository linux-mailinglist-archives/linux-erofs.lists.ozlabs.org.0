Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA159F9E70
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Dec 2024 06:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1734758145;
	bh=do2i6AFCwMKlo5qBewvhm0xBYVvlDal45T7eDtE7twg=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UZSMbvLFYh5SyxTclkQ1aEE7kQRDBlywNX2JvYDQ7yNUzpInyTrYj1BPzvWdcdWb5
	 aCb205pjgBm1DlhdJQka+VVHl4+Rx3Eu1c0DLNKbRrMvq5mez2WTnMJvXHsd1bix9N
	 ry1dXvftbgIi77p4nMq/rfkP4ANFm1SZukNiHOo9QA7Uxryms7PWZ01qXa2J2fqsVw
	 qEtNeW9jU13EcZ49AahNcUM5V6vfLjbVmoFG8cNBKw0WmjfsgcPNc6EILSWl1b/1lz
	 A+/ncv/Ak+imSzp4GhISGEK0iy1XjpDHMKXuYuTtn/jpuTLz540HfsS3o6Qy+7Lai+
	 qhfFOry0qwwuA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YFXYY4R5qz30gL
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Dec 2024 16:15:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734758143;
	cv=none; b=TNAmm+MfEkIno26JsA0o9ASjtgmW9jexcXyodScb4FZLO4dBfqamRZ5sQPFf1gjjaxT1bJuNwdXhCZi1u+Sgh7a8Kjl8kN4iKtHnhdSOXAh3L3LMWhcBHWFv3tydCjBaOb2NDJ71PjKKNrSU2vzD77ZTao5B/Fju+wryS13ThT87VG1w+oZNOA4SevZ/dBsuzCPVqLzL0RZwvRRG33sMq6uUK+z6kYJLyHpsq0/zld8chvQnxUMd2tvI/X/OdpZrN8kJNkGMLsdbh2Len8navegTOytbsRetyycGDdqpPZdLp0GPkSs0ZlgIcDeDO7t2GRxK6POi0/8yrv5cDlNVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734758143; c=relaxed/relaxed;
	bh=do2i6AFCwMKlo5qBewvhm0xBYVvlDal45T7eDtE7twg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfVYMxK3jdHAb4Ngq5lrRkYcWjhM7ztC33XGK05cMtyGA4q0Re7TFC326eiaDsyKB8GgNFkgzZYwcRkEIgp+h5N9Y/QBnxgamYqqX4cogRXJPymzpXdXk4EL3G9spps1Xsyjl5SDbQpm1iW+0b3qaMY0o4nKQw9b8B+vTotDnJDpMHFU5jQLw6mOpzDCk/MgSSNbMhSlgyYoltRDLS3+c6hhdQTQIQhjQP+iRvaWCVNJyjfNnOQn44jvRVz2coNIo7nX5GLFL8ymhz7ISz2YqA4tKKkA7w4vhpKE3A5vxjJzw4HL7rcyspehMfaG0KzcmPiPObTGw3Lgu3CkHHAesw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBXpg8Ka; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=masahiroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBXpg8Ka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=masahiroy@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YFXYV5PTkz2xmk
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 16:15:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 415E35C2937
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 05:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85312C4CECE
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 05:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734758138;
	bh=6D22z4Q6qM5owg8DKTRELAvvJsU6v0seLUtNWMGH3rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBXpg8KaWOmk5BPV9JRlUwyRpdhTsLRyF3o8nRURr2/sbFbiwU2VhLnOWtq7YJJec
	 Ot/mrxQD51xumkqWjcecDxrOC+vTCvlpENvgKus+wds6XuYQMZ4OjFmYVLVzNmKCQx
	 8Yd4aIB+ofU4wRNrNx2mJNZo6Y8Ig66H3F2PCCchNTw5ieI+yPfxIk0SIIw6/HdH41
	 HX+8wPXoowb5iLRcX7svVCHB1ds6rNhJGAqS3gQxaOmqT1MnGb2nQvhuhzrDVJM+Yw
	 huvvldEYppAd0O00Hj7vzofTkZWWE0+YpLYoWM8cW36gTa9GhYsreT3EctWsy/x6p3
	 x8mJPCbZig5Og==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53f22fd6887so2347809e87.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Dec 2024 21:15:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnjky+GTbVdajJI0ThECH0UZU2ojgeMAfzWQ+FF+A+OO7dXk2fjv701H3jpq9n8SvTz+UAe+Dl73MwAA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoaiH2cXsNyg1kzlHfkGGUDNqw9gssCgNmcfe6HjKiOk9oKcuv
	eaEIwWuQLRj9PgXhVlnbMeqbsA/1OByA5eZSJdiJAXvSBa4YUKkZL6H8awLxHbdI38neasNHjyG
	V09dqtMduEJbCSn38GNe5Qbg5JJ0=
X-Google-Smtp-Source: AGHT+IFLGvnYDVZLLa6gb/IFLNG+NtJdTz+H8BQtiW/Pv7A9hdRHwl2vjaIxr7x6UhU9lyjaVH3MCdnPjifz3TMcGbU=
X-Received: by 2002:ac2:5682:0:b0:542:2f5a:5f52 with SMTP id
 2adb3069b0e04-5422f5a5f9dmr180818e87.13.1734758137206; Fri, 20 Dec 2024
 21:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20241213135013.2964079-1-dhowells@redhat.com> <20241213135013.2964079-2-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-2-dhowells@redhat.com>
Date: Sat, 21 Dec 2024 14:15:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQndCMudAtVRAbfSfnV+XhSMDcnP-s1_GAQh8UiEdLBSg@mail.gmail.com>
Message-ID: <CAK7LNAQndCMudAtVRAbfSfnV+XhSMDcnP-s1_GAQh8UiEdLBSg@mail.gmail.com>
Subject: Re: [PATCH 01/10] kheaders: Ignore silly-rename files
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Masahiro Yamada via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 13, 2024 at 10:50=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Tell tar to ignore silly-rename files (".__afs*" and ".nfs*") when buildi=
ng
> the header archive.  These occur when a file that is open is unlinked
> locally, but hasn't yet been closed.  Such files are visible to the user
> via the getdents() syscall and so programs may want to do things with the=
m.
>
> During the kernel build, such files may be made during the processing of
> header files and the cleanup may get deferred by fput() which may result =
in
> tar seeing these files when it reads the directory, but they may have
> disappeared by the time it tries to open them, causing tar to fail with a=
n
> error.  Further, we don't want to include them in the tarball if they sti=
ll
> exist.
>
> With CONFIG_HEADERS_INSTALL=3Dy, something like the following may be seen=
:

I am confused.

kernel/gen_kheaders.sh is executed when CONFIG_IKHEADERS is enabled.

How is CONFIG_HEADERS_INSTALL related?



>    find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': N=
o such file or directory
>    tar: ./include/linux/greybus/.__afs3C95: File removed before we read i=
t
>
> The find warning doesn't seem to cause a problem.

I picked the following commit.

https://lore.kernel.org/all/20241218202021.17276-1-elsk@google.com/

This shoots the root cause of the 'find' errors.
Does it fix your problems too?


Your patch does not address the 'find' errors.






>
> Fix this by telling tar when called from in gen_kheaders.sh to exclude su=
ch
> files.  This only affects afs and nfs; cifs uses the Windows Hidden
> attribute to prevent the file from being seen.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Masahiro Yamada <masahiroy@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> ---
>  kernel/gen_kheaders.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 383fd43ac612..7e1340da5aca 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -89,6 +89,7 @@ find $cpio_dir -type f -print0 |
>
>  # Create archive and try to normalize metadata for reproducibility.
>  tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> +    --exclude=3D".__afs*" --exclude=3D".nfs*" \
>      --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner --mode=3Du=3Dr=
w,go=3Dr,a+X \
>      -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
>
>


--=20
Best Regards
Masahiro Yamada
